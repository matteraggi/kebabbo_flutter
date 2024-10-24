import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> feedList = [];
  List<Map<String, dynamic>> searchResultList = [];
  bool isLoading = true;
  String? errorMessage;

  // Aggiungi un TextEditingController per gestire l'input dell'utente
  final TextEditingController postController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetchFeed();
  }

  // Verifica se l'utente è autenticato e, se sì, fetch del feed
  Future<void> _checkAuthAndFetchFeed() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      await _fetchFeed();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Registrati per poter visualizzare il feed";
      });
    }
  }

  // Fetch dei post da Supabase
  Future<void> _fetchFeed() async {
    try {
      final PostgrestList response = await supabase.from('posts').select('*');

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

  // Funzione per postare il testo su Supabase
  Future<void> _postFeed() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() {
        errorMessage = "Devi essere autenticato per postare";
      });
      return;
    }

    final String text = postController.text.trim();
    if (text.isEmpty) {
      setState(() {
        errorMessage = "Il testo non può essere vuoto";
      });
      return;
    }

    try {
      await supabase.from('posts').insert({
        'text': text,
        'user_id': user.id, // Aggiungi l'ID dell'utente autenticato
        'created_at': DateTime.now().toIso8601String(), // Inserisci timestamp
      });

      postController.clear(); // Pulisci il campo di input dopo aver postato
      await _fetchFeed(); // Refresh del feed dopo il post
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
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
                  minimum: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 32,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: postController,
                                        maxLines:
                                            null, // Permette l'espansione multilinea
                                        minLines: 1, // Numero minimo di righe
                                        decoration: InputDecoration(
                                          hintText: "Inserisci un post...",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: _postFeed,
                                      child: const Text("Posta"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: searchResultList.length,
                              itemBuilder: (context, index) {
                                final post = searchResultList[index];
                                return FeedListItem(
                                  text: post['text'] ?? 'Testo non disponibile',
                                  createdAt: post['created_at'] ?? '',
                                  userId: post['user_id'],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
