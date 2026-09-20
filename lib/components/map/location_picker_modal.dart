import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/maps_resolver.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerModal extends StatefulWidget {
  final LatLng? initialPosition;
  final TileProvider? tileProvider;
  final bool autoLocate;

  const LocationPickerModal({
    super.key,
    this.initialPosition,
    this.tileProvider,
    this.autoLocate = true,
  });

  @override
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal> {
  static const LatLng _defaultBologna = LatLng(44.4949, 11.3426);

  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  late LatLng _selectedPosition;
  String _addressText = 'Tocca la mappa per selezionare il punto esatto';
  String? _placeName;
  String? _cityName;
  bool _isLoadingAddress = false;
  bool _isLocatingUser = false;

  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition ?? _defaultBologna;
    if (widget.autoLocate) {
      if (widget.initialPosition != null) {
        _loadAddressForPosition(_selectedPosition);
      } else {
        _locateUser(initial: true);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _locateUser({bool initial = false}) async {
    setState(() => _isLocatingUser = true);
    try {
      final hasPermission = await _checkLocationPermission();
      if (hasPermission) {
        final pos = await Geolocator.getCurrentPosition();
        final userLatLng = LatLng(pos.latitude, pos.longitude);
        if (mounted) {
          setState(() {
            _selectedPosition = userLatLng;
          });
          _mapController.move(userLatLng, 16.5);
          _loadAddressForPosition(userLatLng);
        }
      } else if (initial) {
        _loadAddressForPosition(_selectedPosition);
      }
    } catch (e) {
      debugPrint('Errore geolocalizzazione: $e');
      if (initial) {
        _loadAddressForPosition(_selectedPosition);
      }
    } finally {
      if (mounted) {
        setState(() => _isLocatingUser = false);
      }
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;
    return true;
  }

  Future<void> _loadAddressForPosition(LatLng position) async {
    setState(() => _isLoadingAddress = true);
    final details =
        await MapsResolver.reverseGeocode(position.latitude, position.longitude);
    if (mounted) {
      setState(() {
        _addressText = details?['address'] ??
            'Lat: ${position.latitude.toStringAsFixed(5)}, Lng: ${position.longitude.toStringAsFixed(5)}';
        if (details?['name'] != null && details!['name']!.isNotEmpty) {
          _placeName = details['name'];
        }
        _cityName = details?['city'];
        _isLoadingAddress = false;
      });
    }
  }

  void _onMapTapped(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selectedPosition = point;
      _searchResults = [];
    });
    FocusScope.of(context).unfocus();
    _loadAddressForPosition(point);
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    if (query.trim().length < 3) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 400), () async {
      setState(() => _isSearching = true);
      final results = await MapsResolver.searchPlaces(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    });
  }

  void _selectSearchResult(Map<String, dynamic> result) {
    final lat = result['lat'] as double;
    final lng = result['lng'] as double;
    final latLng = LatLng(lat, lng);

    setState(() {
      _selectedPosition = latLng;
      _addressText = result['displayName'] ?? '';
      _placeName = result['name'] ?? '';
      _cityName = result['city'];
      _searchResults = [];
    });

    _searchController.text = result['displayName'] ?? '';
    FocusScope.of(context).unfocus();
    _mapController.move(latLng, 16.5);
  }

  void _confirmLocation() {
    final result = LocationDetails(
      lat: _selectedPosition.latitude,
      lng: _selectedPosition.longitude,
      address: _addressText,
      placeName: _placeName,
      city: _cityName,
      googleMapsUrl: MapsResolver.buildGoogleMapsUrl(
        _selectedPosition.latitude,
        _selectedPosition.longitude,
      ),
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: const Text(
          'Seleziona sulla Mappa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: _isLocatingUser
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.my_location),
            tooltip: 'Centra sulla mia posizione',
            onPressed: _locateUser,
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Mappa Interattiva
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPosition,
              initialZoom: 15.0,
              minZoom: 4.0,
              maxZoom: 18.5,
              onTap: _onMapTapped,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                tileProvider:
                    widget.tileProvider ?? CancellableNetworkTileProvider(),
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPosition,
                    width: 60,
                    height: 60,
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.restaurant_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Container(
                          width: 4,
                          height: 10,
                          decoration: BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 2. Barra di Ricerca Indirizzo in Cima
          Positioned(
            top: 12,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Cerca indirizzo o locale...',
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: red),
                      suffixIcon: _isSearching
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: red,
                                ),
                              ),
                            )
                          : _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchResults = []);
                                  },
                                )
                              : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                // Lista Suggerimenti di Ricerca
                if (_searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = _searchResults[index];
                        final name = item['name'] as String?;
                        final displayName = item['displayName'] as String? ?? '';
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.location_on, color: red, size: 20),
                          title: Text(
                            name != null && name.isNotEmpty ? name : displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          subtitle: (name != null && name.isNotEmpty && name != displayName)
                              ? Text(
                                  displayName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                )
                              : null,
                          onTap: () => _selectSearchResult(item),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          // 3. Card Inferiore con Info e Bottone Conferma
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.place, color: red, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (_placeName != null && _placeName!.isNotEmpty)
                                  ? _placeName!
                                  : 'Punto selezionato',
                              style: TextStyle(
                                fontSize: (_placeName != null && _placeName!.isNotEmpty) ? 14 : 11,
                                fontWeight: FontWeight.bold,
                                color: (_placeName != null && _placeName!.isNotEmpty) ? Colors.black87 : Colors.grey,
                                letterSpacing: (_placeName != null && _placeName!.isNotEmpty) ? 0 : 0.5,
                              ),
                            ),
                            const SizedBox(height: 3),
                            _isLoadingAddress
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: red,
                                    ),
                                  )
                                : Text(
                                    _addressText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: (_placeName != null && _placeName!.isNotEmpty) ? 12 : 14,
                                      fontWeight: (_placeName != null && _placeName!.isNotEmpty) ? FontWeight.normal : FontWeight.bold,
                                      color: (_placeName != null && _placeName!.isNotEmpty) ? Colors.black54 : Colors.black87,
                                    ),
                                  ),
                            const SizedBox(height: 3),
                            Text(
                              'Lat: ${_selectedPosition.latitude.toStringAsFixed(5)}, Lng: ${_selectedPosition.longitude.toStringAsFixed(5)}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.check_circle_outline, size: 20),
                      label: const Text(
                        'Conferma Questa Posizione',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _confirmLocation,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
