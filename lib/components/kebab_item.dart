import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rating: ${widget.rating}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
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
    );
  }
}
