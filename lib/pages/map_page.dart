import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
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
  final MapController _mapController = MapController();
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _centerMap() {
    if (widget.currentPosition != null && _isMapInitialized) {
      _mapController.move(
        LatLng(widget.currentPosition!.latitude,
            widget.currentPosition!.longitude),
        15,
      );
    }
  }

  @override
  void didUpdateWidget(MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPosition != null &&
        oldWidget.currentPosition != widget.currentPosition) {
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

    LatLng _center = LatLng(
        widget.currentPosition!.latitude, widget.currentPosition!.longitude);

    return Center(
      child: FlutterMap(
        options: MapOptions(
          initialCenter: _center,
          initialZoom: 10.2,
          onMapReady: () {
            setState(() {
              _isMapInitialized = true;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
          MarkerLayer(
            markers: [
              if (widget.currentPosition != null)
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(widget.currentPosition!.latitude,
                      widget.currentPosition!.longitude),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 40.0,
                  ),
                ),
            ],
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
