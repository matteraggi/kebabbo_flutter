import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/bottom_kebab_buttons.dart';
// import 'package:kebabbo_flutter/components/misc/info_dialog.dart'; // Rimosso
import 'package:kebabbo_flutter/components/misc/single_chart.dart';
import 'package:kebabbo_flutter/components/list_items/single_stat.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:flip_card/flip_card.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/pages/reviews/add_kebab.dart'; // <-- 1. Import Aggiunto

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
  final bool hasUserReview;
  final bool flipped;
  final bool? approved;

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
    required this.hasUserReview,
    this.flipped = false,
    this.approved,
  });

  @override
  KebabListItemState createState() => KebabListItemState();
}

class KebabListItemState extends State<KebabListItem> {
  bool isExpanded = false;
  late FlipCardController _controller;
  bool isFront = true;
  double avgQuality = 0.0;
  double avgQuantity = 0.0;
  double avgMenu = 0.0;
  double avgPrice = 0.0;
  double avgFun = 0.0;
  double overallAvgRating = 0.0;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
    _controller = FlipCardController();
    if (widget.flipped) {
      isFront = false;
      getUsersReviews();
    } else {
      isFront = true;
    }
  }

  Future<void> getUsersReviews() async {
    // ... (nessuna modifica qui)
    try {
      final response = await supabase
          .from('reviews')
          .select('quality, quantity, menu, price, fun')
          .eq('kebabber_id', widget.id);

      List<dynamic> reviews = response;
      if (reviews.isEmpty) return;

      double totalQuality = 0;
      double totalQuantity = 0;
      double totalMenu = 0;
      double totalPrice = 0;
      double totalFun = 0;

      for (var review in reviews) {
        totalQuality += review['quality'] ?? 0;
        totalQuantity += review['quantity'] ?? 0;
        totalMenu += review['menu'] ?? 0;
        totalPrice += review['price'] ?? 0;
        totalFun += review['fun'] ?? 0;
      }

      avgQuality = totalQuality / reviews.length;
      avgQuantity = totalQuantity / reviews.length;
      avgMenu = totalMenu / reviews.length;
      avgPrice = totalPrice / reviews.length;
      avgFun = totalFun / reviews.length;
      overallAvgRating =
          (avgQuality + avgQuantity + avgMenu + avgPrice + avgFun) / 5;

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Errore durante il recupero delle recensioni: $e");
    }
  }

  List<Widget> _buildRatingStars(double rating) {
    // ... (nessuna modifica qui)
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
    // ... (nessuna modifica qui)
    List<Widget> stars = [];

    double rating = overallAvgRating;

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

  Widget _buildFront() {
    // La "faccia" della recensione Staff
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
              label: S.of(context).quality,
              number: widget.quality,
              isFront: true,
            ),
            const SizedBox(height: 8),
            SingleStat(
                label: S.of(context).price,
                number: widget.price,
                isFront: true),
            const SizedBox(height: 8),
            SingleStat(
                label: S.of(context).quantity,
                number: widget.dimension,
                isFront: true),
            const SizedBox(height: 8),
            SingleStat(
                label: S.of(context).menu, number: widget.menu, isFront: true),
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
                Row(
                  children: [
                    if (widget.map.isNotEmpty) ...[
                      BottomButtonItem(
                        linkMaps: widget.map,
                        icon: Icons.map,
                        isFront: true,
                      ),
                      const SizedBox(width: 16),
                    ],

                    // Mostra il pulsante flip solo se ci sono recensioni UTENTE E il kebab è approvato
                    if (widget.approved != false)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            getUsersReviews();
                            _controller.toggleCard();
                          });
                        },
                        icon: Icon(
                          Icons.cached,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (widget.glutenFree)
                      Image.asset(
                        "assets/images/gluten_free.png",
                        height: 40,
                        width: 40,
                      ),
                    const SizedBox(width: 16),
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
                )
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Center(
                child: Text("Kebabbo Review",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 12))),
          ],
        ),
      ),
    );
  }

Widget _buildBack() {
    // La "faccia" della recensione Utenti
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (avgMenu == 0 &&
                      avgPrice == 0 &&
                      avgQuality == 0 &&
                      avgQuantity == 0)
                    // Avvolgi il contenuto in un Center
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
                        crossAxisAlignment: CrossAxisAlignment.center, // Centra orizzontalmente
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            S.of(context).nessuna_recensione_disponibile,
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          // Bottone "Recensisci"
                          ElevatedButton.icon(
                            icon: Icon(Icons.add_comment_rounded, size: 16),
                            label: Text("Recensisci questo Kebab"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddKebab(
                                    kebabId: widget.id,
                                    kebabName: widget.name,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  else
                    // Altrimenti, mostra le statistiche
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add_comment_rounded, size: 16),
                            label: Text("Recensisci questo Kebab"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddKebab(
                                    kebabId: widget.id,
                                    kebabName: widget.name,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        SingleStat(
                            label: S.of(context).quality,
                            number: avgQuality,
                            isFront: false),
                        const SizedBox(height: 8),
                        SingleStat(
                            label: S.of(context).price,
                            number: avgPrice,
                            isFront: false),
                        const SizedBox(height: 8),
                        SingleStat(
                            label: S.of(context).quantity,
                            number: avgQuantity,
                            isFront: false),
                        const SizedBox(height: 8),
                        SingleStat(
                            label: S.of(context).menu,
                            number: avgMenu,
                            isFront: false),
                        const SizedBox(height: 16),
                        SingleChart(
                          vegetables: widget.vegetables,
                          yogurt: widget.yogurt,
                          spicy: widget.spicy,
                          onion: widget.onion,
                          isFront: false,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.map.isNotEmpty) ...[
                      BottomButtonItem(
                        linkMaps: widget.map,
                        icon: Icons.map,
                        isFront: false,
                      ),
                      SizedBox(width: 16),
                    ],
                    if (widget.approved ?? false)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.toggleCard();
                          });
                        },
                        icon: Icon(
                          Icons.cached,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (widget.glutenFree)
                      Image.asset(
                        "assets/images/gluten_free.png",
                        height: 40,
                        width: 40,
                      ),
                    const SizedBox(width: 16),
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
                )
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Center(
                child: Text(S.of(context).users_review,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.white))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ... (nessuna modifica qui)
    return Card(
      elevation: 4,
      color: isFront ? Colors.white : Colors.grey[700],
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
                  Text(
                    S.of(context).aperto,
                    style: TextStyle(
                        color: Color.fromARGB(255, 37, 154, 41),
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
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
                      ? widget.distance!.toStringAsFixed(2) +
                          S.of(context).km_distante_da_te
                      : S.of(context).distanza_non_disponibile,
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
                    front: widget.flipped ? _buildBack() : _buildFront(),
                    back: widget.flipped ? _buildFront() : _buildBack(),
                  ))
            ],
            onExpansionChanged: (bool expanding) {
              setState(() {
                isExpanded = expanding;
                if (!expanding) {
                  isFront = !widget.flipped;
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