import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/popup_kebab.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/about_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapPage extends StatefulWidget {
  final Position?
      initialPosition; // Make it final since the initial position is passed during creation

  const MapPage({super.key, required this.initialPosition});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> dashList = [];
  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();
  bool _isMapInitialized = false;
  String? errorMessage;

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition =
        widget.initialPosition; // Initialize position from widget
    fetchKebab();
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

  // Function to update position
  void updatePosition(Position newPosition) {
    setState(() {
      _currentPosition = newPosition;
    });
  }

  void _centerMap() {
    print('Centering map to: $_currentPosition');
    if (_currentPosition != null && _isMapInitialized) {
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        14,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    LatLng center =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    List<Marker> markers = [
      if (_currentPosition != null)
        Marker(
          width: 50.0,
          height: 50.0,
          point:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          child: Image.asset("assets/images/user.png"),
          key: const ValueKey('user_marker'), // Key to identify the user marker
        ),
      ...dashList.map((item) {
        return Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(item['lat'], item['lng']),
          child: Image.asset(item['tag'] == 'kebab'
              ? "assets/images/kebab.png"
              : "assets/images/sandwitch.png"),
          key: ValueKey('kebab_marker_${item['id']}'),
        );
      })
    ];

    return Center(
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: center,
              initialZoom: 14,
              onMapReady: () {
                setState(() {
                  _isMapInitialized = true;
                });
              },
              onTap: (_, __) {
                _popupController.hideAllPopups();
              },
              /*
              provare questo per rotazione ma meno sensibile e non mentre zoommi

              interactionOptions: const InteractionOptions(
                enableMultiFingerGestureRace: true,
                flags: InteractiveFlag.doubleTapDragZoom |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.scrollWheelZoom,
              ),
              */
              interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                tileProvider: CancellableNetworkTileProvider(), // Add this line
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
              MarkerLayer(markers: markers),
              PopupMarkerLayer(
                options: PopupMarkerLayerOptions(
                  markerCenterAnimation: const MarkerCenterAnimation(
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 500)),
                  markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
                  popupController: _popupController,
                  markers: markers,
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                      // Open popup only if it's not the user marker
                      if (marker.key == const ValueKey('user_marker')) {
                        return const SizedBox.shrink();
                      }
                      final item = dashList.firstWhere((element) =>
                          marker.point.latitude == element['lat'] &&
                          marker.point.longitude == element['lng']);
                      return PopupKebabItem(
                        name: item['name'],
                        description: item['description'],
                        rating: item['rating'].toDouble(),
                        quality: item['quality'].toDouble(),
                        price: item['price'].toDouble(),
                        dimension: item['dimension'].toDouble(),
                        menu: item['menu'].toDouble(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Pulsante info in alto a sinistra
          Positioned(
            top: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
              child: const Icon(Icons.info, color: Colors.black),
            ),
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
      ),
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
