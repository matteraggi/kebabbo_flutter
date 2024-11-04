import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);

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
  String? imagePath = ""; // Variabile per il percorso dell'immagine
  final TextEditingController postController = TextEditingController();
  List<String> userList = [];
  List<String> userSuggestion = [];
  bool showSuggestions = false;
  OverlayEntry? suggestionOverlay;
  String? selectedKebabId;
  String? selectedKebabName;
  List<Map<String, dynamic>> kebabbariList = [];

  @override
  void initState() {
    super.initState();
    _checkAuthAndFetchFeed();
    fetchUserNames();
    postController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    postController.removeListener(_onTextChanged);
    postController.dispose();
    suggestionOverlay?.remove();
    super.dispose();
  }

  Future<void> fetchUserNames() async {
    try {
      final PostgrestList response =
          await supabase.from('profiles').select('username');

      if (mounted) {
        List<Map<String, dynamic>> users =
            List<Map<String, dynamic>>.from(response as List);

        setState(() {
          userList = users
              .map((user) => user['username'])
              .where((username) => username != null) // Filtra i valori null
              .map((username) => username.toString()) // Converte a stringa
              .toList();
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

  void _showSuggestionOverlay(BuildContext context) {
    if (suggestionOverlay != null) return; // Non mostrare più volte l'overlay

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context);
    final textFieldSize = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    suggestionOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: 70, // Puoi regolare questa posizione come necessario
        width: textFieldSize.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 200,
            child: userSuggestion.isEmpty
                ? const Center(
                    child: Text("Nessun suggerimento",
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: userSuggestion.length,
                    itemBuilder: (context, index) {
                      final suggestion = userSuggestion[index];
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () {
                          setState(() {
                            final text = postController.text;
                            final newText = text.replaceRange(
                              text.lastIndexOf('@'),
                              text.length,
                              '@$suggestion ',
                            );
                            postController.text = newText;
                            postController.selection =
                                TextSelection.fromPosition(
                              TextPosition(offset: newText.length),
                            );
                            _removeSuggestionOverlay();
                          });
                        },
                      );
                    },
                  ),
          ),
        ),
      ),
    );
    overlay.insert(suggestionOverlay!);
  }

  void _onTextChanged() {
    final text = postController.text;
    if (text.contains('@')) {
      final query = text.split('@').last;
      setState(() {
        userSuggestion = userList
            .where((kebab) => kebab.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (userSuggestion.isNotEmpty) {
          _showSuggestionOverlay(context); // Passa il contesto qui
        } else {
          _removeSuggestionOverlay();
        }
      });
    } else {
      _removeSuggestionOverlay();
    }
  }

  void _removeSuggestionOverlay() {
    if (suggestionOverlay != null) {
      suggestionOverlay!.remove();
      suggestionOverlay = null;
    }
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
          .filter('comment', 'is', null)
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
        imageUrl = supabase.storage.from('posts').getPublicUrl(filePath,
            transform: const TransformOptions(
                height: 200,
                width: 200,
                resize: ResizeMode.contain,
                quality: 60));
      } catch (error) {
        setState(() {
          errorMessage = "Errore nel caricamento dell'immagine: $error";
        });
        return;
      }
    }

    // Inserisci il post, includendo `imageUrl` e `kebab_tag_id` solo se presenti
    final Map<String, dynamic> postData = {
      'text': text,
      'user_id': user.id,
      'created_at': DateTime.now().toIso8601String(),
    };

    if (imageUrl != null) {
      postData['image_url'] = imageUrl;
    }
    if (selectedKebabId != null) {
      postData['kebab_tag_id'] = selectedKebabId;
      postData['kebab_tag_name'] = selectedKebabName;
    }

    try {
      await supabase.from('posts').insert(postData);
      postController.clear();
      setState(() {
        imageBytes = null; // Rimuovi l’immagine dopo il post
        imagePath = null;
        selectedKebabId = null; // Resetta il tag selezionato
        selectedKebabName = null;
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

  Future<void> _tagKebab() async {
    await fetchKebabNames(); // Popola la lista dei kebabbari
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: kebabbariList.length,
          itemBuilder: (context, index) {
            final kebabName = kebabbariList[index]['name'];
            final kebabId = kebabbariList[index]['id'];
            return ListTile(
              title: Text(kebabName),
              onTap: () {
                setState(() {
                  selectedKebabId = kebabId;
                  selectedKebabName = kebabName;
                });
                Navigator.pop(context); // Chiude il modulo
              },
            );
          },
        );
      },
    );
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
              .map((kebab) => {
                    'id': kebab['id'].toString(),
                    'name': kebab['name'].toString()
                  })
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
                                controller: postController,
                                maxLines: 1,
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
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: _tagKebab,
                                        icon: (selectedKebabId != null)
                                            ? const Icon(
                                                Icons.place_rounded,
                                                color: red,
                                              )
                                            : const Icon(Icons.place_rounded),
                                      ),
                                      IconButton(
                                        onPressed: _pickImage,
                                        icon: (imagePath != null &&
                                                imagePath!.isNotEmpty)
                                            ? const Icon(Icons.photo,
                                                color: red)
                                            : const Icon(Icons.photo),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: _postFeed,
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
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
                            final post = searchResultList[index];
                            return FeedListItem(
                              text: post['text'] ?? 'Testo non disponibile',
                              createdAt: post['created_at'] ?? '',
                              userId: post['user_id'],
                              imageUrl: post['image_url'] ?? '',
                              postId: post['id'].toString(),
                              likeList: post['like'] ?? [],
                              commentNumber: post['comments_number'] ?? 0,
                              kebabTagId: post['kebab_tag_id'] ?? '',
                              kebabName: post['kebab_tag_name'] ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
