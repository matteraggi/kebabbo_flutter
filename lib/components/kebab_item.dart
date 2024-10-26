import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/bottom_kebab_buttons.dart';
import 'package:kebabbo_flutter/components/single_chart.dart';
import 'package:kebabbo_flutter/components/single_stat.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);

class KebabListItem extends StatefulWidget {
  final String id;
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
  final double vegetables;
  final double yogurt;
  final double spicy;
  final double onion;
  final String tag;
  final bool isOpen;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const KebabListItem({
    super.key,
    required this.id,
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
    required this.vegetables,
    required this.yogurt,
    required this.spicy,
    required this.onion,
    required this.tag,
    required this.isOpen,
    required this.isFavorite,
    required this.onFavoriteToggle,
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
      child: Stack(
        children: [
          ExpansionTile(
            leading: const SizedBox(width: 10),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.tag == "kebab"
                          ? "assets/images/kebabcolored.png"
                          : "assets/images/sandwitch.png",
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                if (widget.isOpen)
                  const Text(
                    "aperto",
                    style: TextStyle(
                        color: Color.fromARGB(255, 37, 154, 41),
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  )
                else
                  const Text(
                    "Chiuso",
                    style: TextStyle(
                        color: red, fontSize: 12, fontStyle: FontStyle.italic),
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
                ),
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
                child: Padding(
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
                      SingleStat(label: "Qualità", number: widget.quality),
                      const SizedBox(height: 8),
                      SingleStat(label: "Prezzo", number: widget.price),
                      const SizedBox(height: 8),
                      SingleStat(label: "Dimensione", number: widget.dimension),
                      const SizedBox(height: 8),
                      SingleStat(label: "Menu", number: widget.menu),
                      const SizedBox(height: 16),
                      SingleChart(
                        vegetables: widget.vegetables,
                        yogurt: widget.yogurt,
                        spicy: widget.spicy,
                        onion: widget.onion,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BottomButtonItem(
                              linkMaps: widget.map,
                              text: "Apri in Maps",
                              icon: Icons.map),
                          if (widget.fun >= 4)
                            Transform.rotate(
                              angle: -0.2,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanding) =>
                setState(() => isExpanded = expanding),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                widget.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: widget.isFavorite ? red : Colors.grey,
              ),
              onPressed: widget.onFavoriteToggle,
            ),
          ),
        ],
      ),
    );
  }
}
