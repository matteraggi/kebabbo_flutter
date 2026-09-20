import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/filter_search.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/pages/tcg/pack_page.dart';
import 'package:kebabbo_flutter/pages/tcg/rotation_scene_v1.dart';
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KebabCarouselPage extends StatefulWidget {
  const KebabCarouselPage({super.key});

  @override
  State<KebabCarouselPage> createState() => _KebabCarouselPageState();
}

class _KebabCarouselPageState extends State<KebabCarouselPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = true;
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      final response = await supabase.from('profiles').select('tcg').eq('id',
          supabase.auth.currentUser?.id ?? ""); // Fetch current user's tcg list

      if (response.isNotEmpty) {
        final List<int> tcgIds = List<int>.from(
            response[0]['tcg'] ?? []); // Get list of ids from "tcg" column
        if (tcgIds.isNotEmpty) {
          final List<int> validUserCardIds =
              tcgIds.where((id) => TcgCardsHelper.isValidCard(id)).toSet().toList();

          if (validUserCardIds.isNotEmpty) {
            final kebabResponse = await supabase
                .from('kebab')
                .select('id, name')
                .inFilter('id', validUserCardIds);

            List<String> kebabList = [];
            for (final kebab in kebabResponse) {
              final int id = kebab['id'] as int;
              if (TcgCardsHelper.isValidCard(id)) {
                final String kebabberId = kebab['name']
                    .toString()
                    .toLowerCase()
                    .replaceAll(' ', '-');
                kebabList.add('assets/kebab-card/$kebabberId.png');
              }
            }

            if (!mounted) return;
            for (var item in kebabList) {
              try {
                await precacheImage(AssetImage(item), context);
              } catch (e) {
                debugPrint('Failed to precache $item: $e');
              }
            }
            if (mounted) {
              setState(() {
                imagePaths = kebabList;
              });
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).my_cards,
        ),
        backgroundColor: red,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.card_giftcard, color: Colors.white),
            tooltip: "Apri Pacchetto",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PackPage()),
              ).then((_) => fetchReviews());
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : imagePaths.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(S.of(context).no_cards_yet),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PackPage()),
                          );
                        },
                        child: Text(S.of(context).go_back),
                      ),
                    ],
                  ),
                )
              : RotationSceneV1(imagePaths: imagePaths),
    );
  }
}
