import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);

class KebabListItemClickable extends StatefulWidget {
  final String id;
  final String name;
  final double rating;
  final String tag;
  final bool isOpen;
  final bool glutenFree;
  final Function(String)
      onKebabSelected; // Callback per passare il valore cliccato

  const KebabListItemClickable({
    super.key,
    required this.id,
    required this.name,
    required this.rating,
    required this.tag,
    required this.isOpen,
    required this.glutenFree,
    required this.onKebabSelected, // Aggiungi il callback
  });

  @override
  KebabListItemClickableState createState() => KebabListItemClickableState();
}

class KebabListItemClickableState extends State<KebabListItemClickable> {
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

  Future<void> saveFavoriteKebab(String favoriteKebabId) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      print('Utente non autenticato');
      return;
    }

    final userId = user.id; // Prendi l'ID dell'utente loggato

    final response = await Supabase.instance.client
        .from('profiles')
        .upsert({
          'id': userId, // ID dell'utente per trovare la riga corretta
          'favorite_kebab': favoriteKebabId, // Il kebab preferito
        })
        .eq('id',
            userId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        saveFavoriteKebab(widget.id);
        widget.onKebabSelected(widget.id);
        Navigator.pop(context);
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              ],
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
          ],
        ),
      ),
    );
  }
}
