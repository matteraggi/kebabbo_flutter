import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/list_items/feed_list_item.dart';
import 'package:kebabbo_flutter/components/misc/medal_popup.dart';
import 'package:kebabbo_flutter/components/misc/user_item.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/image_compressor.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  
  List<Map<String, dynamic>> userList = [];
  final TextEditingController searchController = TextEditingController();

  final TextEditingController postController = TextEditingController();
  Uint8List? imageBytes;
  String? imagePath = "";
  bool _isImageLoading = false; 
  List<String> userSuggestion = [];
  OverlayEntry? suggestionOverlay;
  String? selectedKebabId;
  String? selectedKebabName;
  List<Map<String, dynamic>> kebabbariList = [];

  bool _showFriendsOnly = false; 

  @override
  void initState() {
    super.initState();
    _fetchFeed();
    fetchUserNames();
    searchController.addListener(_onSearchTextChanged);
    postController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchTextChanged);
    searchController.dispose();
    postController.removeListener(_onTextChanged);
    postController.dispose();
    suggestionOverlay?.remove();
    super.dispose();
  }

  void _onSearchTextChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        searchResultList = feedList;
      } else {
        searchResultList = fuzzySearchAndSort(
          userList,
          query,
          'username',
          false,
          false,
        );
      }
    });
  }

  Future<void> fetchUserNames() async {
    try {
      final PostgrestList response =
          await supabase.from('profiles').select('id, username, avatar_url');
      if (mounted) {
        setState(() {
          userList = List<Map<String, dynamic>>.from(response as List);
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

  Future<void> _fetchFeed() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final PostgrestList response;

      if (userId == null) {
        setState(() => _showFriendsOnly = false); 
        response = await supabase.rpc('get_recent_posts');
      } else {
        if (_showFriendsOnly) {
          final profileResponse = await supabase
              .from('profiles')
              .select('followed_users')
              .eq('id', userId)
              .single();

          final followedUsers = List<String>.from(profileResponse['followed_users'] ?? []);
          followedUsers.add(userId);

          if (followedUsers.isEmpty) {
            response = [];
          } else {
            final String orCondition = followedUsers.map((id) => 'user_id.eq.$id').join(',');
            response = await supabase
                .from('posts')
                .select('*')
                .or(orCondition)
                .filter('comment', 'is', null)
                .order('created_at', ascending: false);
          }
        } else {
          response = await supabase
              .from('posts')
              .select('*')
              .filter('comment', 'is', null)
              .neq('user_id', userId)
              .order('created_at', ascending: false);
        }
      }

      if (mounted) {
        List<Map<String, dynamic>> posts =
            List<Map<String, dynamic>>.from(response as List);
        setState(() {
          feedList = posts;
          _onSearchTextChanged(); 
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  
  List<String> getTopUserSuggestions(String query, List<Map<String, dynamic>> userListMap) {
    final userListNames = userListMap
        .map((user) => user['username'])
        .where((username) => username != null)
        .map((username) => username.toString())
        .toList();

    if (query.isEmpty) {
      userListNames.shuffle();
      return userListNames.take(3).toList();
    } else {
      List<Map<String, dynamic>> fuzzyResults = fuzzySearchAndSort(
        userListMap,
        query,
        'username',
        false, 
        false,
      );
      return fuzzyResults
          .map((result) => result['username'].toString())
          .take(3)
          .toList();
    }
  }

  void _showSuggestionOverlay(BuildContext context) {
    if (suggestionOverlay != null) {
      _removeSuggestionOverlay();
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context);
    final textFieldSize = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    suggestionOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + 70,
        width: textFieldSize.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: min(180, 200),
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

  void _onTextChanged() {
    final text = postController.text;
    if (text.contains('@')) {
      final match =
          RegExp(r'@(\S*)').firstMatch(text.substring(text.lastIndexOf('@')));
      final query = match?.group(1) ?? '';
      setState(() {
        userSuggestion = getTopUserSuggestions(query, userList);
        if (userSuggestion.isNotEmpty) {
          _showSuggestionOverlay(context);
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
      final filePath = '${user.id}-${DateTime.now().millisecondsSinceEpoch}.png';
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
      // --- FIX 2: Initialize stats for local display ---
      'like': [], 
      'comments_number': 0,
    };

    if (imageUrl != null) {
      postData['image_url'] = imageUrl;
    }
    
    if (selectedKebabId != null) {
      postData['kebab_tag_id'] = int.tryParse(selectedKebabId!) ?? 0;
      postData['kebab_tag_name'] = selectedKebabName;
    }

    try {
      final response = await supabase
          .from('posts')
          .insert(postData)
          .select()
          .single();

      postController.clear();
      setState(() {
        imageBytes = null;
        imagePath = null;
        selectedKebabId = null;
        selectedKebabName = null;
      });

      final int newPostId = response['id'];
      
      feedList.insert(0, {...postData, 'id': newPostId});
      _onSearchTextChanged(); 

      final postCountResponse = await supabase
          .from('posts')
          .select('id')
          .eq('user_id', user.id)
          .filter('comment', 'is', null)
          .count(CountOption.exact);

      final postCount = postCountResponse.count;

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

        await supabase.from('profiles').update({'medals': medals}).eq('id', user.id);

        if (newMedal && mounted){
          showMedalDialog(context);
        }
      }
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
      // 1. Start Loading
      setState(() {
        _isImageLoading = true;
      });

      // 2. FORCE UI REFRESH: This pause allows the loader to appear before the freeze starts
      await Future.delayed(const Duration(milliseconds: 100));

      try {
        Uint8List imageData = result.files.single.bytes!;
        
        // This is the line blocking your browser
        Uint8List? compressedImage = await ImageUtils.compressImage(
            imageData, 400 * 1024, 1200, 1200);

        // 3. Update State on Success
        if (mounted) {
          setState(() {
            imageBytes = compressedImage;
            imagePath = result.files.single.name;
            _isImageLoading = false; // Stop loading
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            errorMessage = "Error processing image: $e";
            _isImageLoading = false; // Stop loading on error
          });
        }
      }
    }
  }

  Future<void> _tagKebab() async {
    await fetchKebabNames();

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
                Navigator.pop(context);
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
        setState(() {
          errorMessage = error.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = supabase.auth.currentUser != null;

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
                              enabled: isLoggedIn,
                              decoration: InputDecoration(
                                hintText: isLoggedIn
                                    ? S.of(context).cerca_utenti
                                    : S.of(context).accedi_per_cercare,
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            )),
                            
                            if (isLoggedIn)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: _showFriendsOnly ? red : Colors.grey[300],
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    searchController.clear(); 
                                    setState(() {
                                      _showFriendsOnly = !_showFriendsOnly;
                                    });
                                    _fetchFeed();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _showFriendsOnly ? "Followed" : "All",
                                        style: TextStyle(
                                          color: _showFriendsOnly ? Colors.white : Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(
                                        _showFriendsOnly ? Icons.people : Icons.public,
                                        color: _showFriendsOnly ? Colors.white : Colors.black87,
                                        size: 20,
                                      ),
                                    ],
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
                            final item = searchResultList[index];

                            if (searchController.text.isEmpty) {
                              return FeedListItem(
                                // --- FIX 1: ADD KEY ---
                                key: ValueKey(item['id']), 
                                // ----------------------
                                text: item['text'] ??
                                    S.of(context).testo_non_disponibile,
                                createdAt: item['created_at'] ?? '',
                                userId: item['user_id'].toString(),
                                imageUrl: item['image_url'] ?? '',
                                postId: item['id'] ?? '',
                                likeList: item['like'] ?? [],
                                commentNumber: item['comments_number'] ?? 0,
                                kebabTagId: item['kebab_tag_id'] ?? 0,
                                kebabName: item['kebab_tag_name'] ?? '',
                              );
                            } else {
                              return UserItem(
                                  userId: item['id'] ?? "",
                                  username:
                                      item["username"] ?? S.of(context).anonimo,
                                  avatarUrl: item["avatar_url"] ?? "");
                            }
                          },
                        ),
                      ),

                      if (isLoggedIn)
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
                                            icon: Icon(
                                              Icons.place_rounded,
                                              // Assuming 'red' is your defined constant color
                                              color: (selectedKebabId != null) ? red : Colors.grey, 
                                            ),
                                          ),
                                        if (_isImageLoading)
                                          const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                color: red, 
                                              ),
                                            ),
                                          )
                                        else
                                          IconButton(
                                            onPressed: _pickImage,
                                            icon: Icon(
                                              Icons.photo,
                                              // Check imageBytes (data) instead of just the path string
                                              color: (imageBytes != null) ? red : Colors.grey,
                                            ),
                                          ),
                                    ],
                                  ),
                                )
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
                    ],
                  ),
                ),
    );
  }
}