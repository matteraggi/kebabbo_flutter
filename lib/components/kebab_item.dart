import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

class KebabListItem extends StatefulWidget {
  final String name;
  final String description;
  final double rating;
  final double quality;
  final double price;
  final double dimension;
  final double menu;

  KebabListItem({
    required this.name,
    required this.description,
    required this.rating,
    required this.quality,
    required this.price,
    required this.dimension,
    required this.menu,
  });

  @override
  _KebabListItemState createState() => _KebabListItemState();
}

class _KebabListItemState extends State<KebabListItem> {
  bool isExpanded = false;

  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];

    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: yellow, size: 40));
    }

    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: yellow, size: 40));
    }

    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: yellow, size: 40));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      child: Center(
        child: ExpansionTile(
          leading: SizedBox(width: 10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Numero massimo di righe
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildRatingStars(widget.rating),
              ),
              SizedBox(height: 8),
              Text(
                "tot km distante da te",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
          trailing: SizedBox(width: 10),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Qualità: ${widget.quality}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: ${widget.price}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dimensione: ${widget.dimension}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Menu: ${widget.menu}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onExpansionChanged: (bool expanding) =>
              setState(() => isExpanded = expanding),
        ),
      ),
    );
  }
}
