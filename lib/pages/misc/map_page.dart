import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/misc/popup_kebab.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapPage extends StatefulWidget {
  final Position? initialPosition;

  const MapPage({super.key, required this.initialPosition});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> dashList = [];
  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();
  String? errorMessage;

  Position? _currentPosition;
  bool _requestingPermission = false;
  bool _permissionPermanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition;
    fetchKebab();
    if (_currentPosition == null) {
      _requestLocationPermission();
    }
  }

  // RESTORED: This method allows main.dart to update the map's position
  void updatePosition(Position newPosition) {
    if (mounted) {
      setState(() {
        _currentPosition = newPosition;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    setState(() {
      _requestingPermission = true;
      _permissionPermanentlyDenied = false;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() => _permissionPermanentlyDenied = true);
        }
        return;
      }

      if (permission == LocationPermission.denied) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() => _currentPosition = position);
      }
    } catch (_) {
      // Leave _currentPosition null; the empty state offers a retry.
    } finally {
      if (mounted) {
        setState(() => _requestingPermission = false);
      }
    }
  }

  Future<void> fetchKebab() async {
    try {
      final response = await supabase.from('kebab').select('*');

      if (mounted) {
        setState(() {
          dashList = List<Map<String, dynamic>>.from(response as List);
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
  }

  void _centerMap() {
    if (_currentPosition != null) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        14,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // If the position is null (e.g., permission was denied), show a
    // helpful message with a way to (re)try instead of a dead end.
    if (_currentPosition == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _permissionPermanentlyDenied
                    ? 'Location access is disabled for Kebabbo. Enable it from app settings to see the map.'
                    : 'Location not available. Please enable location permissions for Kebabbo.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (_requestingPermission)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _permissionPermanentlyDenied
                      ? Geolocator.openAppSettings
                      : _requestLocationPermission,
                  child: Text(_permissionPermanentlyDenied
                      ? 'Open settings'
                      : 'Enable location'),
                ),
            ],
          ),
        ),
      );
    }

    // If we have a position, build the map.
    LatLng center =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    List<Marker> markers = [
      // User's location marker
      Marker(
        width: 50.0,
        height: 50.0,
        point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        child: Image.asset("assets/images/user.png"),
        key: const ValueKey('user_marker'),
      ),

      // Filter dashList to only include items with valid lat/lng
      ...dashList
          .where((item) => item['lat'] != null && item['lng'] != null)
          .map((item) {
        return Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(item['lat'], item['lng']), // This is now safe
          child: Image.asset(item['tag'] == 'kebab'
              ? "assets/images/kebab.png"
              : "assets/images/sandwitch.png"),
          key: ValueKey('kebab_marker_${item['id']}'),
        );
      })
    ];

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: 14,
            onTap: (_, __) {
              _popupController.hideAllPopups();
            },
            interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.scrollWheelZoom),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.canny.kebabbologna',
              tileProvider: CancellableNetworkTileProvider(),
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => _launchURL(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markerCenterAnimation: const MarkerCenterAnimation(),
                markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
                popupController: _popupController,
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    if (marker.key == const ValueKey('user_marker')) {
                      return const SizedBox.shrink();
                    }
                    // Find the item
                    final item = dashList.firstWhere((element) =>
                        marker.point.latitude == element['lat'] &&
                        marker.point.longitude == element['lng']);

                    // Use default values (??) to prevent crashes if data is null
                    return PopupKebabItem(
                      name: item['name'] ?? 'Nome non disponibile',
                      description: item['description'] ?? '',
                      rating: (item['rating'] ?? 0.0).toDouble(),
                      quality: (item['quality'] ?? 0.0).toDouble(),
                      price: (item['price'] ?? 0.0).toDouble(),
                      dimension: (item['dimension'] ?? 0.0).toDouble(),
                      menu: (item['menu'] ?? 0.0).toDouble(),
                    );
                  },
                ),
                markers: markers, // This uses the filtered list of markers
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: _centerMap,
            child: const Icon(Icons.my_location, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

void _launchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
