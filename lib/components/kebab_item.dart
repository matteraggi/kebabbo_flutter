import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/bottom_kebab_buttons.dart';
import 'package:kebabbo_flutter/components/single_chart.dart';
import 'package:kebabbo_flutter/components/single_stat.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:flip_card/flip_card.dart';

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
  final double? distance;
  final double vegetables;
  final double yogurt;
  final double spicy;
  final double onion;
  final String tag;
  final bool isOpen;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final bool special;
  final bool initiallyExpanded;
  final bool glutenFree;

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
    this.distance,
    required this.vegetables,
    required this.yogurt,
    required this.spicy,
    required this.onion,
    required this.tag,
    required this.isOpen,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.special,
    this.initiallyExpanded = false,
    required this.glutenFree,
  });

  @override
  KebabListItemState createState() => KebabListItemState(); // Corrected line
}

class KebabListItemState extends State<KebabListItem> {
  bool isExpanded = false;
  late FlipCardController _controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
    _controller = FlipCardController();
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

  List<Widget> _buildUserRatingStars() {
    List<Widget> stars = [];

    for (int i = 0; i < 4; i++) {
      stars.add(const Icon(Icons.star, color: yellow, size: 40));
    }
    return stars;
  }

  Widget _buildFront() {
    return Container(
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
            SingleStat(
              label: "Qualità",
              number: widget.quality,
              isFront: true,
            ),
            const SizedBox(height: 8),
            SingleStat(label: "Prezzo", number: widget.price, isFront: true),
            const SizedBox(height: 8),
            SingleStat(
                label: "Dimensione", number: widget.dimension, isFront: true),
            const SizedBox(height: 8),
            SingleStat(label: "Menu", number: widget.menu, isFront: true),
            const SizedBox(height: 16),
            SingleChart(
              vegetables: widget.vegetables,
              yogurt: widget.yogurt,
              spicy: widget.spicy,
              onion: widget.onion,
              isFront: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomButtonItem(
                    linkMaps: widget.map,
                    text: "Apri in Maps",
                    icon: Icons.map),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.toggleCard();
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text("Review"),
                    ],
                  ),
                ),
                if (widget.glutenFree)
                  Image.asset(
                    "assets/images/gluten_free.png",
                    height: 40,
                    width: 40,
                  ),
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
    );
  }

  Widget _buildBack() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
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
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SingleStat(
                label: "Qualità", number: widget.quality, isFront: false),
            const SizedBox(height: 8),
            SingleStat(label: "Prezzo", number: widget.price, isFront: false),
            const SizedBox(height: 8),
            SingleStat(
                label: "Dimensione", number: widget.dimension, isFront: false),
            const SizedBox(height: 8),
            SingleStat(label: "Menu", number: widget.menu, isFront: false),
            const SizedBox(height: 16),
            SingleChart(
              vegetables: widget.vegetables,
              yogurt: widget.yogurt,
              spicy: widget.spicy,
              onion: widget.onion,
              isFront: false,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomButtonItem(
                    linkMaps: widget.map,
                    text: "Apri in Maps",
                    icon: Icons.map),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.toggleCard();
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.kebab_dining_outlined),
                      SizedBox(width: 8),
                      Text("Review"),
                    ],
                  ),
                ),
                if (widget.glutenFree)
                  Image.asset(
                    "assets/images/gluten_free.png",
                    height: 40,
                    width: 40,
                  ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: isFront ? Colors.white : Colors.grey[800],
      shadowColor: Colors.grey,
      child: Stack(
        children: [
          if (widget.glutenFree)
            Positioned(
              bottom: 16,
              right: 16,
              child: Image.asset(
                "assets/images/gluten_free.png",
                height: 40,
                width: 40,
              ),
            ),
          ExpansionTile(
            initiallyExpanded: isExpanded,
            leading: const SizedBox(width: 10),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: isFront ? Colors.black : Colors.white,
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
                    "Aperto",
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
                  children: isFront
                      ? _buildRatingStars(widget.rating)
                      : _buildUserRatingStars(),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.distance != null
                      ? "${widget.distance!.toStringAsFixed(2)} km distante da te"
                      : "Distanza non disponibile",
                  style: TextStyle(
                    color: widget.distance != null
                        ? Colors.grey
                        : Colors.transparent,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            trailing: const SizedBox(width: 10),
            children: [
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final rotate =
                        Tween(begin: 1.0, end: 0.0).animate(animation);
                    return RotationTransition(turns: rotate, child: child);
                  },
                  child: FlipCard(
                      fill: Fill.fillBack,
                      side: CardSide.FRONT,
                      controller: _controller,
                      flipOnTouch: false,
                      onFlipDone: (status) {
                        setState(() {
                          isFront = !isFront;
                        });
                      },
                      front: _buildFront(),
                      back: _buildBack())),
            ],
            onExpansionChanged: (bool expanding) {
              setState(() {
                isExpanded = expanding;
                if (!expanding) {
                  isFront = true;
                }
              });
            },
          ),
          if (!widget.special)
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
          Positioned(
            top: 16,
            left: 16,
            child: Image.asset(
              widget.tag == "kebab"
                  ? "assets/images/kebabcolored.png"
                  : "assets/images/sandwitch.png",
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
