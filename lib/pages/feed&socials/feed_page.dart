import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/list_items/feed_list_item.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    if (suggestionOverlay != null) {
      _removeSuggestionOverlay(); // Remove existing overlay before showing a new one
    }

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
            height: min(180,
                200), // Height to fit up to 4 items, with each ListTile about 48px in height
            child: userSuggestion.isEmpty
                ? Center(
                    child: Text(S.of(context).no_suggestions_available,
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

// Update suggestions when text changes
  void _onTextChanged() {
    final text = postController.text;
    if (text.contains('@')) {
      final match =
          RegExp(r'@(\S*)').firstMatch(text.substring(text.lastIndexOf('@')));
      final query = match?.group(1) ?? '';
      setState(() {
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
        errorMessage = S.of(context).registrati_per_poter_visualizzare_il_feed;
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
        errorMessage = S.of(context).devi_essere_autenticato_per_postare;
      });
      return;
    }

    final String text = postController.text.trim();
    if (text.isEmpty) {
      setState(() {
        errorMessage = S.of(context).il_testo_non_puo_essere_vuoto;
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
          errorMessage =
              S.of(context).errore_nel_caricamento_dellimage + error.toString();
        });
        return;
      }
    }

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
        imageBytes = null;
        imagePath = null;
        selectedKebabId = null;
        selectedKebabName = null;
      });

      final response = await supabase
          .from('posts')
          .select('*')
          .eq('user_id', user.id)
          .filter('comment', 'is', null)
          .count(CountOption.exact);

      final postCount = response.count;

      if (postCount > 0) {
        final profileResponse = await supabase
            .from('profiles')
            .select('medals')
            .eq('id', user.id)
            .single();

        List<dynamic> medals = List.from(profileResponse['medals'] ?? []);
        bool newMedal = false;

        if (!medals.contains(5)) {
          medals.add(5);
          newMedal = true;
        }
        if (postCount > 4 && !medals.contains(6)) {
          medals.add(6);
          newMedal = true;
        }
        if (postCount > 9 && !medals.contains(7)) {
          medals.add(7);
          newMedal = true;
        }
        if (postCount > 49 && !medals.contains(8)) {
          medals.add(8);
          newMedal = true;
        }
        await supabase
            .from('profiles')
            .update({'medals': medals}).eq('id', user.id);

        if (newMedal) {
          _showMedalDialog();
        }
      }

      // Aggiungi il nuovo post alla lista dei post in memoria
      setState(() {
        feedList.insert(
            0, postData); // Aggiungi il nuovo post in cima alla lista
      });

      //await _fetchFeed();
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

// Funzione per mostrare la modale della medaglia
  void _showMedalDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: S.of(context).congratulazioni,
      desc: S
          .of(context)
          .hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia,
      btnOkOnPress: () {},
      customHeader: Icon(
        Icons.emoji_events,
        color: Colors.orange,
        size: 100,
      )
          .animate(
            onComplete: (controller) =>
                controller.repeat(), // Ripeti l'animazione
          )
          .scaleXY(
            begin: 0.5,
            end: 1.1,
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticInOut,
          )
          .fadeIn(duration: Duration(milliseconds: 300)),
    ).show();
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
            final kebab = kebabbariList[index];
            final kebabName = kebab['name'];
            return ListTile(
              title: Text(kebabName),
              onTap: () {
                setState(() {
                  selectedKebabId = kebab['id'];
                  selectedKebabName = kebabName;
                });
                Navigator.pop(context); // Chiude il modal dopo la selezione
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
                                  hintText: S.of(context).scrivi_un_post,
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
                        child: searchResultList.isNotEmpty
                            ? ListView.builder(
                                itemCount: searchResultList.length,
                                itemBuilder: (context, index) {
                                  final post = searchResultList[index];
                                  return FeedListItem(
                                    key: ValueKey(post['created_at']),
                                    text: post['text'] ??
                                        S.of(context).testo_non_disponibile,
                                    createdAt: post['created_at'] ?? '',
                                    userId: post['user_id'].toString(),
                                    imageUrl: post['image_url'] ?? '',
                                    postId: post['id'].toString(),
                                    likeList: post['like'] ?? [],
                                    commentNumber: post['comments_number'] ?? 0,
                                    kebabTagId: post['kebab_tag_id'].toString(),
                                    kebabName: post['kebab_tag_name'] ?? '',
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                    S.of(context).non_segui_ancora_nessuno),
                              ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
