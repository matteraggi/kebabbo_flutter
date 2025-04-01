import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/kebab_item_favorite.dart';
import 'package:kebabbo_flutter/components/misc/info_dialog.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/reviews/review_page.dart';
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
    // Recupera tutti i profili che hanno l'userId nel campo 'followed_users'
    final response =
        await supabase.from('reviews').select('*').eq('user_id', userId);
    for (var review in response) {
      final kebabberId = review['kebabber_id'].toString();
      final kebabberResponse = await supabase
          .from('kebab')
          .select('*')
          .eq('id', kebabberId)
          .single();
      review['name'] = kebabberResponse['name'];
      review['map'] = kebabberResponse['map'];
      review['lat'] = kebabberResponse['lat'];
      review['lng'] = kebabberResponse['lng'];
      review['gluten_free'] = kebabberResponse['gluten_free'];
      review['is_open'] = isKebabOpen(
        kebabberResponse['orari_apertura'],
      );
      review['tag'] = kebabberResponse['tag'];
      review['vegetables'] = kebabberResponse['vegetables'];
      review['yogurt'] = kebabberResponse['yogurt'];
      review['spicy'] = kebabberResponse['spicy'];
      review['onion'] = kebabberResponse['onion'];

      review['rating'] = (review['quality'] +
              review['price'] +
              review['quantity'] +
              review['menu']) /
          4;
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
          // Pill-shaped button at the top
          Padding(
            padding: const EdgeInsets.all(
                10.0), // Add some padding for better spacing
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
                      builder: (context) => ReviewPage(
                        hash: "nearme",
                        initialPosition: widget.initialPosition,
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
