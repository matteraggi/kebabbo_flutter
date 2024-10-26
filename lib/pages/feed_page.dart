import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
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
  Uint8List? imageBytes; // Variabile per memorizzare l'immagine
  String? imagePath; // Variabile per il percorso dell'immagine
  final TextEditingController postController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetchFeed();
  }

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

  Future<void> _fetchFeed() async {
    try {
      final PostgrestList response = await supabase
          .from('posts')
          .select('*')
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

    String? imageUrl;

    if (imageBytes != null) {
      final filePath =
          '${user.id}-${DateTime.now().millisecondsSinceEpoch}.png';
      try {
        await supabase.storage.from('posts').uploadBinary(
              filePath,
              imageBytes!,
              fileOptions: const FileOptions(upsert: true),
            );
        imageUrl = supabase.storage.from('posts').getPublicUrl(filePath);
      } catch (error) {
        setState(() {
          errorMessage = "Errore nel caricamento dell'immagine: $error";
        });
        return;
      }
    }

    // Inserisci il post, includendo `imageUrl` solo se è presente
    final Map<String, dynamic> postData = {
      'text': text,
      'user_id': user.id,
      'created_at': DateTime.now().toIso8601String(),
    };
 
    if (imageUrl != null) {
      postData['image_url'] = imageUrl;
    }

    try {
      await supabase.from('posts').insert(postData);
      postController.clear();
      setState(() {
        imageBytes = null; // Rimuovi l’immagine dopo il post
        imagePath = null;
      });
      await _fetchFeed(); // Refresh del feed dopo il post
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        imageBytes = result.files.single.bytes;
        imagePath = result.files.single.name;
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
              minimum: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            // Row containing the TextField and Icons
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: postController,
                                    maxLines: null,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      hintText: "Scrivi un post...",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      // Trailing icons: Gallery and Camera inside the TextField
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: _pickImage,
                                            icon: const Icon(Icons.photo),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Send IconButton wrapped in a red container
                                Container(
                                  decoration: BoxDecoration(
                                    color: red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    onPressed: _postFeed,
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white, // White icon inside red container
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Posts list display
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchResultList.length,
                          itemBuilder: (context, index) {
                            final post = searchResultList[index];
                            return FeedListItem(
                              text: post['text'] ?? 'Testo non disponibile',
                              createdAt: post['created_at'] ?? '',
                              userId: post['user_id'],
                              imageUrl: post['image_url'] ?? '',
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
