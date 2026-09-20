import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab/kebab_single_page.dart';
import 'package:kebabbo_flutter/pages/reviews/write_review_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

enum MapStyleType {
  googleRoadmap,
  googleSatellite,
  openStreetMap,
}

class MapPage extends StatefulWidget {
  final Position? initialPosition;

  const MapPage({super.key, required this.initialPosition});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> with TickerProviderStateMixin {
  // Centro predefinito di Bologna
  static const LatLng _bolognaCenter = LatLng(44.4949, 11.3426);

  List<Map<String, dynamic>> dashList = [];
  final MapController _mapController = MapController();
  String? errorMessage;

  Position? _currentPosition;
  bool _requestingPermission = false;

  Map<String, dynamic>? _selectedKebab;
  MapStyleType _currentMapStyle = MapStyleType.googleRoadmap;

  // Filtri mappa multi-selezione (selezionati entrambi di default)
  bool _showStaff = true;
  bool _showCommunity = true;

  // Tab di visualizzazione recensione nella scheda locale ('staff' oppure 'community')
  String _cardReviewTab = 'staff';
  bool _isLoadingCommunityReview = false;
  final Map<dynamic, Map<String, dynamic>> _communityStatsCache = {};

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialPosition;
    fetchKebab();
    if (_currentPosition == null) {
      _requestLocationPermission();
    }
  }

  // Permette a main.dart di aggiornare la posizione dell'utente
  void updatePosition(Position newPosition) {
    if (mounted) {
      setState(() {
        _currentPosition = newPosition;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    if (_requestingPermission) return;
    setState(() {
      _requestingPermission = true;
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

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() => _currentPosition = position);
        _animatedMapMove(LatLng(position.latitude, position.longitude), 15.0);
      }
    } catch (_) {
      // Posizione non disponibile, la mappa resta centrata su Bologna
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

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = _mapController.camera;
    final latTween = Tween<double>(
      begin: camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: camera.zoom,
      end: destZoom,
    );

    final controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);

    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void _centerOnUser() {
    if (_currentPosition != null) {
      _animatedMapMove(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        15.5,
      );
    } else {
      _requestLocationPermission();
    }
  }

  void _zoomIn() {
    final currentZoom = _mapController.camera.zoom;
    _animatedMapMove(
      _mapController.camera.center,
      (currentZoom + 1).clamp(3.0, 19.5),
    );
  }

  void _zoomOut() {
    final currentZoom = _mapController.camera.zoom;
    _animatedMapMove(
      _mapController.camera.center,
      (currentZoom - 1).clamp(3.0, 19.5),
    );
  }

  void _toggleMapStyle() {
    setState(() {
      switch (_currentMapStyle) {
        case MapStyleType.googleRoadmap:
          _currentMapStyle = MapStyleType.googleSatellite;
          break;
        case MapStyleType.googleSatellite:
          _currentMapStyle = MapStyleType.openStreetMap;
          break;
        case MapStyleType.openStreetMap:
          _currentMapStyle = MapStyleType.googleRoadmap;
          break;
      }
    });
  }

  String _getMapStyleName() {
    switch (_currentMapStyle) {
      case MapStyleType.googleRoadmap:
        return "Google Stradale";
      case MapStyleType.googleSatellite:
        return "Google Satellite";
      case MapStyleType.openStreetMap:
        return "OpenStreetMap";
    }
  }

  TileLayer _buildTileLayer() {
    switch (_currentMapStyle) {
      case MapStyleType.googleRoadmap:
        return TileLayer(
          urlTemplate: 'https://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
          subdomains: const ['0', '1', '2', '3'],
          userAgentPackageName: 'com.canny.kebabbologna',
          tileProvider: CancellableNetworkTileProvider(),
          maxZoom: 20,
        );
      case MapStyleType.googleSatellite:
        return TileLayer(
          urlTemplate: 'https://mt{s}.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
          subdomains: const ['0', '1', '2', '3'],
          userAgentPackageName: 'com.canny.kebabbologna',
          tileProvider: CancellableNetworkTileProvider(),
          maxZoom: 20,
        );
      case MapStyleType.openStreetMap:
        return TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.canny.kebabbologna',
          tileProvider: CancellableNetworkTileProvider(),
          maxZoom: 19,
        );
    }
  }

  String _calculateDistance(double targetLat, double targetLng) {
    if (_currentPosition == null) return '';
    final distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      targetLat,
      targetLng,
    );
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
    }
  }

  Future<void> _openDirections(double lat, double lng) async {
    final uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: yellow, size: 18));
    }
    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: yellow, size: 18));
    }
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: yellow, size: 18));
    }
    return stars;
  }

  Widget _buildUserMarker() {
    return Image.asset(
      "assets/images/user.png",
      width: 50.0,
      height: 50.0,
      fit: BoxFit.contain,
    );
  }

  Widget _buildKebabMarkerWidget(Map<String, dynamic> item, bool isSelected) {
    final isKebab = item['tag'] == 'kebab';
    final isStaff = item['is_staff'] == true;
    final Color ringColor = isSelected
        ? red
        : (isStaff ? const Color(0xFFFFB300) : const Color(0xFF1E88E5));

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _selectKebab(item);
      },
      child: AnimatedScale(
        scale: isSelected ? 1.25 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isSelected ? yellow : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ringColor,
                    width: isSelected ? 2.8 : 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: isSelected ? 8 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  isKebab
                      ? "assets/images/kebab.png"
                      : "assets/images/sandwitch.png",
                  width: 24,
                  height: 24,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: isStaff
                        ? const Color(0xFFFF8F00)
                        : const Color(0xFF1976D2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(
                    isStaff ? Icons.workspace_premium : Icons.people_alt,
                    size: 9,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectKebab(Map<String, dynamic> item) {
    setState(() {
      _selectedKebab = item;
      _cardReviewTab = (item['is_staff'] == true) ? 'staff' : 'community';
    });
    _animatedMapMove(
      LatLng(item['lat'], item['lng']),
      15.5,
    );
    _fetchCommunityStats(item['id']);
  }

  Future<void> _fetchCommunityStats(dynamic kebabId) async {
    if (kebabId == null) return;
    if (_communityStatsCache.containsKey(kebabId)) return;

    setState(() => _isLoadingCommunityReview = true);
    try {
      final response = await supabase
          .from('reviews')
          .select('quality, quantity, price, menu, fun')
          .eq('kebabber_id', kebabId.toString());

      final List<dynamic> reviews = response as List<dynamic>;
      if (reviews.isNotEmpty) {
        double totalQuality = 0;
        double totalQuantity = 0;
        double totalPrice = 0;
        double totalMenu = 0;
        double totalFun = 0;

        for (var r in reviews) {
          totalQuality += (r['quality'] ?? 0.0).toDouble();
          totalQuantity += (r['quantity'] ?? 0.0).toDouble();
          totalPrice += (r['price'] ?? 0.0).toDouble();
          totalMenu += (r['menu'] ?? 0.0).toDouble();
          totalFun += (r['fun'] ?? 0.0).toDouble();
        }

        final int count = reviews.length;
        final double avgQ = totalQuality / count;
        final double avgDim = totalQuantity / count;
        final double avgP = totalPrice / count;
        final double avgM = totalMenu / count;
        final double avgF = totalFun / count;
        final double avgRating =
            (avgQ + avgDim + avgP + avgM + avgF) / 5.0;

        _communityStatsCache[kebabId] = {
          'count': count,
          'rating': avgRating,
          'quality': avgQ,
          'dimension': avgDim,
          'price': avgP,
          'menu': avgM,
          'fun': avgF,
        };
      } else {
        _communityStatsCache[kebabId] = {
          'count': 0,
        };
      }
    } catch (e) {
      debugPrint("Errore durante il recupero recensioni community: $e");
      _communityStatsCache[kebabId] = {'count': 0};
    } finally {
      if (mounted) {
        setState(() => _isLoadingCommunityReview = false);
      }
    }
  }

  void _toggleStaff() {
    setState(() {
      if (_showStaff && !_showCommunity) {
        // Se è l'unico attivo, spegnerlo accende la community
        _showStaff = false;
        _showCommunity = true;
      } else {
        _showStaff = !_showStaff;
      }
      _checkSelectedKebabVisible();
    });
  }

  void _toggleCommunity() {
    setState(() {
      if (_showCommunity && !_showStaff) {
        // Se è l'unico attivo, spegnerlo accende lo staff
        _showCommunity = false;
        _showStaff = true;
      } else {
        _showCommunity = !_showCommunity;
      }
      _checkSelectedKebabVisible();
    });
  }

  void _checkSelectedKebabVisible() {
    if (_selectedKebab != null) {
      final isStaff = _selectedKebab!['is_staff'] == true;
      if ((isStaff && !_showStaff) || (!isStaff && !_showCommunity)) {
        _selectedKebab = null;
      }
    }
  }

  Widget _buildFilterToggle({
    required IconData icon,
    required String label,
    required int count,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? activeColor : Colors.white,
      elevation: isSelected ? 4 : 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapStyleButton() {
    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Tooltip(
        message: "Cambia mappa: ${_getMapStyleName()}",
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _toggleMapStyle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _currentMapStyle == MapStyleType.googleSatellite
                      ? Icons.satellite_alt
                      : Icons.layers,
                  size: 18,
                  color: const Color(0xFF1A73E8),
                ),
                const SizedBox(width: 4),
                Text(
                  _currentMapStyle == MapStyleType.googleSatellite
                      ? "Satellite"
                      : _currentMapStyle == MapStyleType.openStreetMap
                          ? "OSM"
                          : "Stradale",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedKebabCard() {
    if (_selectedKebab == null) return const SizedBox.shrink();

    final item = _selectedKebab!;
    final name = item['name'] ?? 'Nome non disponibile';
    final isKebab = item['tag'] == 'kebab';
    final bool isStaff = item['is_staff'] == true;
    final distanceStr = _calculateDistance(item['lat'], item['lng']);

    final commStats = _communityStatsCache[item['id']];
    final int commCount = commStats?['count'] ?? 0;
    final bool showingStaff = isStaff && (_cardReviewTab == 'staff');

    // Valutazioni da mostrare in base alla tab attiva nella card
    final double displayRating = showingStaff
        ? (item['rating'] ?? 0.0).toDouble()
        : (commStats?['rating'] ?? (item['rating'] ?? 0.0)).toDouble();

    final double displayQuality = showingStaff
        ? (item['quality'] ?? 0.0).toDouble()
        : (commStats?['quality'] ?? (item['quality'] ?? 0.0)).toDouble();

    final double displayPrice = showingStaff
        ? (item['price'] ?? 0.0).toDouble()
        : (commStats?['price'] ?? (item['price'] ?? 0.0)).toDouble();

    final double displayDimension = showingStaff
        ? (item['dimension'] ?? 0.0).toDouble()
        : (commStats?['dimension'] ?? (item['dimension'] ?? 0.0)).toDouble();

    final bool hasNoCommunityReviews =
        !showingStaff && isStaff && commCount == 0 && !_isLoadingCommunityReview;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520),
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intestazione con badge tipo e pulsante chiudi
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: isKebab
                          ? red.withValues(alpha: 0.12)
                          : Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      isKebab ? "KEBAB" : "PANINO",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isKebab ? red : Colors.deepOrange,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                    onPressed: () {
                      setState(() => _selectedKebab = null);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 18,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Switch Recensione Staff vs Utenti (o badge Community) + Distanza
              Row(
                children: [
                  if (isStaff) ...[
                    Container(
                      height: 32,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () =>
                                setState(() => _cardReviewTab = 'staff'),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: showingStaff
                                    ? const Color(0xFFE65100)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.workspace_premium,
                                    size: 13,
                                    color: showingStaff
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Staff",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: showingStaff
                                        ? Colors.white
                                        : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () =>
                                setState(() => _cardReviewTab = 'community'),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: !showingStaff
                                    ? const Color(0xFF1565C0)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.people_alt,
                                    size: 13,
                                    color: !showingStaff
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    commCount > 0
                                        ? "Utenti ($commCount)"
                                        : "Utenti",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: !showingStaff
                                        ? Colors.white
                                        : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: const Color(0xFF64B5F6)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.people_alt_rounded,
                              size: 13, color: Color(0xFF1565C0)),
                          SizedBox(width: 4),
                          Text(
                            "Recensione Community",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (distanceStr.isNotEmpty) ...[
                    const Spacer(),
                    Icon(Icons.directions_walk,
                        size: 15, color: Colors.grey[600]),
                    const SizedBox(width: 3),
                    Text(
                      distanceStr,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),

              // Contenuto Recensione (Stelle + Voto + Statistiche OPPURE Banner "Sii il primo")
              if (hasNoCommunityReviews) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.rate_review_outlined,
                          color: Color(0xFF1565C0), size: 18),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          "Nessun utente ha ancora recensito questo locale!",
                          style:
                              TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 6),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 5),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WriteReviewPage(
                                preselectedKebabId: (item['id'] is int)
                                    ? item['id'] as int
                                    : int.tryParse(item['id'].toString()),
                                preselectedKebabName: item['name'],
                              ),
                            ),
                          ).then((_) {
                            _communityStatsCache.remove(item['id']);
                            _fetchCommunityStats(item['id']);
                          });
                        },
                        child: const Text('Recensisci',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    ..._buildRatingStars(displayRating),
                    const SizedBox(width: 6),
                    Text(
                      displayRating > 0
                          ? displayRating.toStringAsFixed(1)
                          : "-",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Mini statistiche
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatPill(S.of(context).quality, displayQuality),
                    _buildStatPill(S.of(context).price, displayPrice),
                    _buildStatPill(S.of(context).quantity, displayDimension),
                  ],
                ),
              ],
              const SizedBox(height: 12),

              // Pulsanti azione: Indicazioni e Dettagli & Recensioni
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.directions, size: 18),
                      label: const Text(
                        "Indicazioni",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () => _openDirections(
                        item['lat'],
                        item['lng'],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.reviews_outlined, size: 18),
                      label: const Text(
                        "Dettagli & Recensioni",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: red,
                        side: const BorderSide(color: red, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KebabSinglePage(
                              kebabId: item['id'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatPill(String label, double score) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          Text(
            score > 0 ? score.toStringAsFixed(1) : "-",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = _currentPosition != null
        ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
        : _bolognaCenter;

    // Lista dei marker
    List<Marker> markers = [];

    // Posizione utente (se disponibile)
    if (_currentPosition != null) {
      markers.add(
        Marker(
          width: 50.0,
          height: 50.0,
          point:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          child: _buildUserMarker(),
          key: const ValueKey('user_marker'),
        ),
      );
    }

    final int staffCount = dashList
        .where((k) =>
            k['is_staff'] == true && k['lat'] != null && k['lng'] != null)
        .length;
    final int communityCount = dashList
        .where((k) =>
            k['is_staff'] != true && k['lat'] != null && k['lng'] != null)
        .length;
    // Filtra kebab in base alla multi-selezione Staff / Community (entrambi attivi di default)
    final List<Map<String, dynamic>> visibleKebabs = dashList.where((item) {
      if (item['lat'] == null || item['lng'] == null) return false;
      final bool isStaff = item['is_staff'] == true;
      if (isStaff && !_showStaff) return false;
      if (!isStaff && !_showCommunity) return false;
      return true;
    }).toList();

    // Marker dei locali kebab
    for (final item in visibleKebabs) {
      final isSelected =
          _selectedKebab != null && _selectedKebab!['id'] == item['id'];
      markers.add(
        Marker(
          width: 48.0,
          height: 48.0,
          point: LatLng(item['lat'], item['lng']),
          child: _buildKebabMarkerWidget(item, isSelected),
          key: ValueKey('kebab_marker_${item['id']}'),
        ),
      );
    }

    final bool isCardOpen = _selectedKebab != null;

    return Stack(
      children: [
        // Mappa principale FlutterMap
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: 14.0,
            minZoom: 3.0,
            maxZoom: 19.5,
            onTap: (_, __) {
              if (_selectedKebab != null) {
                setState(() => _selectedKebab = null);
              }
            },
            // Risoluzione de-zoom touch su mobile:
            // Abilita pinchZoom + pinchMove + drag + fling + doubleTap
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              enableMultiFingerGestureRace: true,
              pinchZoomThreshold: 0.5,
              pinchMoveThreshold: 40.0,
            ),
          ),
          children: [
            _buildTileLayer(),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  _currentMapStyle == MapStyleType.openStreetMap
                      ? 'OpenStreetMap contributors'
                      : 'Google Maps',
                  onTap: () {
                    final url = _currentMapStyle == MapStyleType.openStreetMap
                        ? 'https://openstreetmap.org/copyright'
                        : 'https://www.google.com/maps';
                    launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),
            MarkerLayer(
              markers: markers,
            ),
          ],
        ),

        // Barra Superiore: Filtri Multipli Staff / Community & Selettore Stile Mappa
        Positioned(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            children: [
              _buildFilterToggle(
                icon: Icons.workspace_premium,
                label: 'Staff',
                count: staffCount,
                isSelected: _showStaff,
                activeColor: const Color(0xFFE65100),
                onTap: _toggleStaff,
              ),
              const SizedBox(width: 8),
              _buildFilterToggle(
                icon: Icons.people_alt,
                label: 'Community',
                count: communityCount,
                isSelected: _showCommunity,
                activeColor: const Color(0xFF1565C0),
                onTap: _toggleCommunity,
              ),
              const Spacer(),
              _buildMapStyleButton(),
            ],
          ),
        ),

        // Controlli Zoom & Centra Posizione (stile Google Maps a destra)
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          right: 16.0,
          bottom: isCardOpen ? 250.0 : 20.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pulsante "Centra su di me"
              Material(
                color: Colors.white,
                elevation: 4,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _centerOnUser,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _requestingPermission
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          )
                        : Icon(
                            _currentPosition != null
                                ? Icons.my_location
                                : Icons.location_searching,
                            color: _currentPosition != null
                                ? const Color(0xFF1A73E8)
                                : Colors.grey[700],
                            size: 22,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Pillola Zoom (+ / -)
              Material(
                color: Colors.white,
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10)),
                      onTap: _zoomIn,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.add, size: 22, color: Colors.black87),
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    InkWell(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10)),
                      onTap: _zoomOut,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child:
                            Icon(Icons.remove, size: 22, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Bottom Card per il locale selezionato (stile Google Maps)
        _buildSelectedKebabCard(),
      ],
    );
  }
}

