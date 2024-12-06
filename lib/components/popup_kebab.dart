import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/single_stat.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class PopupKebabItem extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final double quality;
  final double price;
  final double dimension;
  final double menu;

  const PopupKebabItem({
    super.key,
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
      stars.add(const Icon(Icons.star, color: yellow, size: 25));
    }

    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: yellow, size: 25));
    }

    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: yellow, size: 25));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
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
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Row(
                      children: _buildRatingStars(rating),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 14)),
                const Divider(), // Linea divisoria
                SingleStat(label: S.of(context).quality, number: quality, isFront: true,),
                const SizedBox(height: 8),
                SingleStat(label: S.of(context).price, number: price, isFront: true,),
                const SizedBox(height: 8),
                SingleStat(label: S.of(context).quantity, number: dimension, isFront: true,),
                const SizedBox(height: 8),
                SingleStat(label: S.of(context).menu, number: menu, isFront: true,),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
