import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/single_stat.dart';
import 'package:kebabbo_flutter/main.dart';

class PopupKebabItem extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final double quality;
  final double price;
  final double dimension;
  final double menu;

  const PopupKebabItem({
    required this.name,
    required this.description,
    required this.rating,
    required this.quality,
    required this.price,
    required this.dimension,
    required this.menu,
  });

  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];

    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: yellow, size: 25));
    }

    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: yellow, size: 25));
    }

    while (stars.length < 5) {
      stars.add(Icon(Icons.star_border, color: yellow, size: 25));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 325, // Limita la larghezza del popup
          ),
          child: SingleChildScrollView(
            // Aggiunge uno scroll in caso di contenuto eccessivo
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Row(
                      children: _buildRatingStars(rating),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(description, style: TextStyle(fontSize: 14)),
                Divider(), // Linea divisoria
                SingleStat(label: "Qualità", number: quality),
                SizedBox(height: 8),
                SingleStat(label: "Prezzo", number: price),
                SizedBox(height: 8),
                SingleStat(label: "Dimensione", number: dimension),
                SizedBox(height: 8),
                SingleStat(label: "Menu", number: menu),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
