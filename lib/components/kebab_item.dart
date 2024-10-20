import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/bottom_kebab_buttons.dart';
import 'package:kebabbo_flutter/components/single_chart.dart';
import 'package:kebabbo_flutter/components/single_stat.dart';
import 'package:kebabbo_flutter/main.dart';

class KebabListItem extends StatefulWidget {
  final String name;
  final String description;
  final double rating;
  final double quality;
  final double price;
  final double dimension;
  final double menu;
  final double fun;
  final String map;
  final double lat;
  final double lng;
  final double distance;
  final double meat;
  final double yogurt;
  final double spicy;
  final double onion;

  const KebabListItem({super.key, 
    required this.name,
    required this.description,
    required this.rating,
    required this.quality,
    required this.price,
    required this.dimension,
    required this.menu,
    required this.fun,
    required this.map,
    required this.lat,
    required this.lng,
    required this.distance,
    required this.meat,
    required this.yogurt,
    required this.spicy,
    required this.onion,
  });

  @override
  KebabListItemState createState() => KebabListItemState(); // Corrected line
}

class KebabListItemState extends State<KebabListItem> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];

    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars.toDouble() >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: yellow, size: 40));
    }

    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: yellow, size: 40));
    }

    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: yellow, size: 40));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey,
      child: Center(
        child: ExpansionTile(
          leading: const SizedBox(width: 10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Numero massimo di righe
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildRatingStars(widget.rating),
              ),
              const SizedBox(height: 8),
              Text(
                "${widget.distance.toStringAsFixed(2)} km distante da te",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
          trailing: const SizedBox(width: 10),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.description,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        //SingleStat(label: "Qualità", number: widget.quality),
                        const SizedBox(height: 8),
                        //SingleStat(label: "Prezzo", number: widget.price),
                        const SizedBox(height: 8),
                        //SingleStat(label: "Dimensione", number: widget.dimension),
                        const SizedBox(height: 8),
                        //SingleStat(label: "Menu", number: widget.menu),
                        const SizedBox(height: 16),
                        /*
                        SingleChart(
                          meat: widget.meat,
                          yogurt: widget.yogurt,
                          spicy: widget.spicy,
                          onion: widget.onion,
                        ),
                        */
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BottomButtonItem(
                                linkMaps: widget.map,
                                text: "Apri in Maps",
                                icon: Icons.map),
                            if (widget.fun >= 3.5)
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Transform.rotate(
                                  angle: -0.2, // Ruota il badge verso sinistra
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: yellow,
                                        size: 30,
                                      ),
                                      Text(
                                        'fun!',
                                        style: TextStyle(
                                          color: yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
          onExpansionChanged: (bool expanding) =>
              setState(() => isExpanded = expanding),
        ),
      ),
    );
  }
}
