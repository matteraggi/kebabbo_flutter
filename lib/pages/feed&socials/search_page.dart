import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/list_items/feed_list_item.dart';
import 'package:kebabbo_flutter/components/misc/user_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> feedList = [];
  List<Map<String, dynamic>> searchResultList = [];
  bool isLoading = true;
  String? errorMessage;
  Uint8List? imageBytes;
  String? imagePath = "";
  List<Map<String, dynamic>> userList = [];
  List<String> userSuggestion = [];
  bool showSuggestions = false;
  OverlayEntry? suggestionOverlay;
  String? selectedKebabId;
  String? selectedKebabName;
  List<Map<String, dynamic>> kebabbariList = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetchFeed();
    fetchUserNames();
    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchTextChanged);
    searchController.dispose();
    suggestionOverlay?.remove();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        // Se non c'è testo nella barra di ricerca, mostra i post
        searchResultList = feedList;
      } else {
        searchResultList = fuzzySearchAndSort(
          userList,
          query,
          'username', // Search key for usernames
          false, // Set `showOnlyOpen` to false if not relevant
          false, // Set `showOnlyKebab` to false if not relevant
        );
      }
    });
  }

  Future<void> fetchUserNames() async {
    try {
      final PostgrestList response =
          await supabase.from('profiles').select('id, username, avatar_url');
      if (mounted) {
        List<Map<String, dynamic>> users =
            List<Map<String, dynamic>>.from(response as List);

        setState(() {
          userList = users;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
  }

  Future<void> _checkAuthAndFetchFeed() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      await _fetchFeed();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = S.of(context).registrati_per_poter_visualizzare_il_feed;
      });
    }
  }

  Future<void> _fetchFeed() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        setState(() {
          isLoading = false;
        });
        return; // No user is logged in, exit early
      }

      final PostgrestList response = await supabase
          .from('posts')
          .select('*')
          .filter('comment', 'is', null)
          .neq('user_id', userId) // Escludi i post con il tuo user_id
          .order('created_at',
              ascending: false); // Ordina per timestamp in ordine decrescente

      if (mounted) {
        List<Map<String, dynamic>> posts =
            List<Map<String, dynamic>>.from(response as List);
        setState(() {
          feedList = posts;
          searchResultList = posts;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
          isLoading = false;
        });
      }
    }
  }

  Future<void> fetchKebabNames() async {
    try {
      final PostgrestList response =
          await supabase.from('kebab').select('id, name');

      if (mounted) {
        List<Map<String, dynamic>> kebabs =
            List<Map<String, dynamic>>.from(response as List);

        setState(() {
          kebabbariList = kebabs
              .map((kebab) =>
                  {'id': kebab['id'], 'name': kebab['name'].toString()})
              .toList();
        });
      }
    } catch (error) {
      if (mounted) {
        // gestione errori
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SafeArea(
                  minimum:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: S.of(context).cerca_utenti,
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchResultList.length,
                          itemBuilder: (context, index) {
                            // Gestisci i dati in base al tipo di risultato
                            final item = searchController.text.isEmpty
                                ? searchResultList[index] // Post
                                : searchResultList[index]; // Utente

                            if (searchController.text.isEmpty) {
                              // Se non c'è testo, visualizza i post
                              return FeedListItem(
                                text: item['text'] ??
                                    S.of(context).testo_non_disponibile,
                                createdAt: item['created_at'] ?? '',
                                userId: item['user_id'].toString(),
                                imageUrl: item['image_url'] ?? '',
                                postId: item['id'] ?? '',
                                likeList: item['like'] ?? [],
                                commentNumber: item['comments_number'] ?? 0,
                                kebabTagId:
                                    item['kebab_tag_id'] ?? 0,
                                kebabName: item['kebab_tag_name'] ?? '',
                              );
                            } else {
                              // Se c'è testo, visualizza gli utenti
                              return UserItem(
                                  userId: item['id'] ?? "",
                                  username:
                                      item["username"] ?? S.of(context).anonimo,
                                  avatarUrl: item["avatar_url"] ?? "");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
