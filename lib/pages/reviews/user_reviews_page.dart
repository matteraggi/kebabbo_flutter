import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/kebab_item_favorite.dart';
import 'package:kebabbo_flutter/components/misc/info_dialog.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/reviews/add_kebab.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class UserReviewsPage extends StatefulWidget {
  final String userId;
  final Position? initialPosition;

  const UserReviewsPage(
      {super.key, required this.userId, required this.initialPosition});

  @override
  UserReviewsState createState() => UserReviewsState();
}

class UserReviewsState extends State<UserReviewsPage> {
  List<Map<String, dynamic>> reviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReviews(widget.userId);
  }
Future<void> _fetchReviews(String userId) async {
    final response =
        await supabase.from('reviews').select('*').eq('user_id', userId);
    
    // Lista temporanea per i kebab da fetchare
    final kebabIds = response.map((review) => review['kebabber_id'].toString()).toSet().toList();

    // Se non ci sono recensioni, esci
    if (kebabIds.isEmpty) {
      setState(() {
        reviews = [];
        isLoading = false;
      });
      return;
    }

    // --- OTTIMIZZAZIONE: Fetcha tutti i kebab in UNA SOLA chiamata ---
    final kebabResponse = await supabase
        .from('kebab')
        .select('*')
        .inFilter('id', kebabIds); // .in_() per fetchare tutti gli ID

    // Mappa i kebab per ID per un accesso rapido
    final kebabMap = {
      for (var kebab in kebabResponse) kebab['id'].toString(): kebab
    };
    // -------------------------------------------------------------

    for (var review in response) {
      final kebabberId = review['kebabber_id'].toString();
      final kebabberData = kebabMap[kebabberId]; // Prendi i dati dalla mappa

      if (kebabberData != null) {
        review['name'] = kebabberData['name'] ?? 'Nome non disponibile';
        review['map'] = kebabberData['map'] ?? '';
        review['lat'] = kebabberData['lat'] ?? 0.0;
        review['lng'] = kebabberData['lng'] ?? 0.0;
        review['gluten_free'] = kebabberData['gluten_free'] ?? false;
        review['is_open'] = isKebabOpen(
          kebabberData['orari_apertura'],
        );
        review['tag'] = kebabberData['tag'] ?? 'kebab';
        review['vegetables'] = kebabberData['vegetables'] ?? 0.0;
        review['yogurt'] = kebabberData['yogurt'] ?? 0.0;
        review['spicy'] = kebabberData['spicy'] ?? 0.0;
        review['onion'] = kebabberData['onion'] ?? 0.0;

        review['rating'] = (review['quality'] +
                review['price'] +
                review['quantity'] +
                review['menu']) /
            4;
      } else {
        // Gestisci il caso in cui il kebab è stato cancellato
        review['name'] = 'Kebab non più disponibile';
      }
    }
    setState(() {
      reviews = List<Map<String, dynamic>>.from(response);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25),
          // Pill-shaped button at the top
          Padding(
            padding: const EdgeInsets.all(
                12.0), // Add some padding for better spacing
            child: SizedBox(
              width: double.infinity, // Full width button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15), // Button height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Pill shape
                  ),
                  backgroundColor: red, // Customize color if needed
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddKebab(
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center, // Center everything
                  children: [
                    Text(
                      S.of(context).write_a_review_for_a_kebab_near_you,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16), // Prevents overlap
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // The rest of the content
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : reviews.isEmpty
                  ? textExplanation(
                      context, S.of(context).nessuna_recensione_ancora)
                  : Expanded(
                      // Wrap ListView.builder in Expanded to fit it in the column
                      child: ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final review = reviews[index];
                          return KebabListItemFavorite(
                            id: review['kebabber_id'].toString(),
                            name: review['name'],
                            description: review['description'],
                            rating: review['rating'],
                            quality: review['quality'],
                            price: review['price'],
                            dimension: review['quantity'],
                            menu: review['menu'],
                            fun: review['fun'],
                            map: review['map'],
                            lat: review['lat'],
                            lng: review['lng'],
                            vegetables: review['vegetables'],
                            yogurt: review['yogurt'],
                            spicy: review['spicy'],
                            onion: review['onion'],
                            tag: review['tag'],
                            isOpen: review['is_open'],
                            glutenFree: review['gluten_free'],
                            expanded: false,
                            
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
