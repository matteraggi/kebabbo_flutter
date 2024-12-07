import 'package:flutter_map/flutter_map.dart';

class KebabMarker extends Marker {
  final String name;
  final String description;
  final double rating;
  final double quality;
  final double price;
  final double dimension;
  final double menu;

  const KebabMarker({
    required super.point,
    required super.child,
    required this.name,
    required this.description,
    required this.rating,
    required this.quality,
    required this.price,
    required this.dimension,
    required this.menu,
  });
}
