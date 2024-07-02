import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/popup_kebab.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  Position? currentPosition;

  MapPage({required this.currentPosition});

  @override
  _MapPageState createState() => _MapPageState();

  void updatePosition(Position newPosition) {
    currentPosition = newPosition;
  }
}

class _MapPageState extends State<MapPage> {
  List<Map<String, dynamic>> dashList = [];
  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();
  bool _isMapInitialized = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
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

  void _centerMap() {
    if (widget.currentPosition != null && _isMapInitialized) {
      _mapController.move(
        LatLng(widget.currentPosition!.latitude,
            widget.currentPosition!.longitude),
        14,
      );
    }
  }

  @override
  void didUpdateWidget(MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPosition != null &&
        oldWidget.currentPosition != widget.currentPosition &&
        _isMapInitialized) {
      _centerMap();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentPosition == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    LatLng center = LatLng(
        widget.currentPosition!.latitude, widget.currentPosition!.longitude);

    List<Marker> markers = [
      if (widget.currentPosition != null)
        Marker(
          width: 50.0,
          height: 50.0,
          point: LatLng(widget.currentPosition!.latitude,
              widget.currentPosition!.longitude),
          child: Image.asset("assets/images/user.png"),
          key: const ValueKey('user_marker'), // Key to identify the user marker
        ),
      ...dashList.map((item) {
        return Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(item['lat'], item['lng']),
          child: Image.asset("assets/images/kebab.png"),
          key: ValueKey(
              'kebab_marker_${item['id']}'),
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
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
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
                  markerCenterAnimation: MarkerCenterAnimation(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500)),
                  markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
                  popupController: _popupController,
                  markers: markers,
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                      // Open popup only if it's not the user marker
                      if (marker.key == const ValueKey('user_marker')) {
                        return SizedBox.shrink();
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
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _centerMap,
              child: Icon(Icons.my_location, color: Colors.black),
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
