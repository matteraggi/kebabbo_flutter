import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> feedList = [];
  List<Map<String, dynamic>> searchResultList = [];
  bool isLoading = true;
  String? errorMessage;
  Uint8List? imageBytes;
  String? imagePath = "";
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

// Function to fetch top 3 fuzzy matches or random users
List<String> getTopUserSuggestions(String query, List<String> userList) {
  if (query.isEmpty) {
    // If no query, return 3 random users
    userList.shuffle();
    return userList.take(3).toList();
  } else {
    // Perform fuzzy search for top 3 matches
    List<Map<String, dynamic>> fuzzyResults = fuzzySearchAndSort(
      userList.map((user) => {'username': user}).toList(),
      query,
      'username',
      false, // showOnlyOpen
      false, // showOnlyKebab
    );
    return fuzzyResults
        .map((result) => result['username'].toString())
        .take(3)
        .toList(); // Take top 3 matches sorted by closest score
  }
}

// Show overlay with suggestions below the text field
void _showSuggestionOverlay(BuildContext context) {
  if (suggestionOverlay != null) _removeSuggestionOverlay(); // Remove existing overlay before showing a new one

  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final overlay = Overlay.of(context);
  final textFieldSize = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);

  suggestionOverlay = OverlayEntry(
    builder: (context) => Positioned(
      left: offset.dx,
      top: offset.dy + 70, // Adjust position below the text field
      width: textFieldSize.width,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: min(180, 200), // Height to fit up to 4 items, with each ListTile about 48px in height
          child: userSuggestion.isEmpty
              ? const Center(
                  child: Text("No suggestions available",
                      style: TextStyle(color: Colors.grey)),
                )
              : ListView.separated(
                  itemCount: userSuggestion.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
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
                          postController.selection = TextSelection.fromPosition(
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

// Update suggestions when text changes
void _onTextChanged() {
  final text = postController.text;
  if (text.contains('@')) {
    final match = RegExp(r'@(\S*)').firstMatch(text.substring(text.lastIndexOf('@')));
    final query = match?.group(1) ?? '';     setState(() {
      userSuggestion = getTopUserSuggestions(query, userList);
      if (userSuggestion.isNotEmpty) {
        _showSuggestionOverlay(context); // Pass context
      } else {
        _removeSuggestionOverlay();
      }
    });
  } else {
    _removeSuggestionOverlay();
  }
}

// Remove overlay
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
      // Recupera la lista degli utenti seguiti
      final profileResponse = await supabase
          .from('profiles')
          .select('followed_users')
          .eq('id', supabase.auth.currentSession!.user.id)
          .single();

      final followedUsers =
          List<String>.from(profileResponse['followed_users'] ?? []);

      followedUsers.add(supabase.auth.currentSession!.user.id);

      if (followedUsers.isNotEmpty) {
        final String orCondition =
            followedUsers.map((userId) => 'user_id.eq.$userId').join(',');

        // Recupera i post solo dagli utenti seguiti usando la condizione 'or'
        final PostgrestList response = await supabase
            .from('posts')
            .select('*')
            .or(orCondition)
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
      } else {
        setState(() {
          feedList = [];
          searchResultList = [];
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
      allowCompression: true,
      allowMultiple: false,
    );

    if (result != null) {
      // Ottiene i bytes dell'immagine e la comprime
      Uint8List imageData = result.files.single.bytes!;
      Uint8List? compressedImage = await compressImage(imageData);

      setState(() {
        imageBytes = compressedImage;
        imagePath = result.files.single.name;
      });
    }
  }

  Future<void> _tagKebab() async {
    await fetchKebabNames(); // Popola la lista dei kebabbari

    if (!mounted) return;

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
