import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:kebabbo_flutter/components/kebab_item_clickable.dart';
import 'package:kebabbo_flutter/components/kebab_item_favorite.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/favorites_page.dart';
import 'package:kebabbo_flutter/pages/followers_page.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:kebabbo_flutter/pages/seguiti_page.dart';
import 'package:kebabbo_flutter/pages/tools_page.dart';
import 'package:kebabbo_flutter/pages/user_posts_page.dart';
import 'package:kebabbo_flutter/pages/user_reviews_page.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, Position? currentPosition});

  get currentPosition => null;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _username = "";
  final String _id = Supabase.instance.client.auth.currentSession!.user.id;
  String? _avatarUrl;
  int _postCount = 0;
  bool _loading = true;
  int _favoritesCount = 0;
  List<int> _ingredients = [5, 5, 5, 5, 5];
  final TextEditingController _usernameController = TextEditingController();
  int _followersCount = 0;
  int _seguitiCount = 0;
  int _reviewsCount = 0;
  String? _favoriteKebabId;
  Map<String, dynamic>? _favoriteKebab;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _getPostCount();
    _getFollowerCount();
    _getReviewsCount();
  }

  Future<void> _getFollowerCount() async {
    try {
      final response = await supabase
          .from('profiles')
          .select('id')
          .contains('followed_users', [supabase.auth.currentUser!.id]);
      setState(() {
        _followersCount = response.length;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load follower count')),
        );
      }
    }
  }
  
  Future<void> _getReviewsCount() async {
    try {
      final response = await supabase
          .from('reviews')
          .select('id')
          .eq('user_id', supabase.auth.currentUser!.id);
      setState(() {
        _reviewsCount = response.length;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load reviews count')),
        );
      }
    }
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
    });

    final profileData = await getProfile(context);
    fetchSelectedKebab(profileData!['favoriteKebab'].toString());
    if (profileData != null) {
      setState(() {
        _username = profileData['username'];
        _avatarUrl = profileData['avatarUrl'];
        _favoritesCount = profileData['favoritesCount'];
        _ingredients = List<int>.from(profileData['ingredients']);
        _seguitiCount = (profileData['seguitiCount'] != null)
            ? profileData['seguitiCount'].length
            : 0;
        _loading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    await updateProfile(
        context, _username, _avatarUrl, null); // Call the utility function

    setState(() {
      _loading = false;
    });
  }

  Future<void> _changeUsername() async {
    if (!mounted) return;

    _usernameController.text = _username;

    String? errorMessage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Username'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _usernameController,
                    maxLength: 12,
                    decoration: const InputDecoration(
                      hintText: 'Enter new username',
                      counterText: '',
                    ),
                    onChanged: (value) {
                      setState(() {
                        errorMessage =
                            validateUsername(value); // Use the utility function
                      });
                    },
                  ),
                  SizedBox(height: 4),
                  Text(
                    errorMessage ?? ' \n ',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: errorMessage != null
                      ? null
                      : () async {
                          if (mounted) {
                            Navigator.of(context).pop();
                          }

                          setState(() {
                            _username = _usernameController.text.trim();
                          });

                          await _updateProfile();

                          if (mounted) {
                            setState(() {});
                          }
                        },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _changeAvatar() async {
    // Usa FilePicker per selezionare un’immagine
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      allowMultiple: false,
    );

    if (result != null) {
      final Uint8List bytes = result.files.single.bytes!;
      Uint8List? compressedImage = await compressImage(bytes);
      final userId = supabase.auth.currentSession!.user.id;
      final filePath = '$userId.png';

      print("Uploading image to $filePath");

      try {
        await supabase.storage.from('avatars').uploadBinary(
            filePath, compressedImage!,
            fileOptions: const FileOptions(upsert: true));
        // Ottieni l'URL pubblico dell'immagine e aggiorna il profilo
        final imageUrlResponse =
            supabase.storage.from('avatars').getPublicUrl(filePath);
        setState(() {
          _avatarUrl = imageUrlResponse;
        });

        await _updateProfile();
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload avatar')),
          );
        }
      }
    }
  }

  Future<void> _getPostCount() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      final postCount = await supabase
          .from('posts')
          .select('*')
          .eq('user_id', userId)
          .filter('comment', 'is', null)
          .count(CountOption.exact);

      setState(() {
        _postCount = postCount.count;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load post count')),
        );
      }
    }
  }

/*
  Future<Map<String, dynamic>>? _fetchFavoriteKebab() async {
    if (_favoriteKebab == null || _favoriteKebab!.isEmpty) return {};

    final response = await supabase
        .from('kebab')
        .select('name')
        .eq('id', _favoriteKebab!)
        .single();

    return response;
  }
*/
  Future<void> _openFavoriteKebabSelection() async {
    List<Map<String, dynamic>> kebabItems = await fetchKebab();

    showModalBottomSheet(
      backgroundColor: yellow,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: ListView.builder(
            itemCount: kebabItems.length,
            itemBuilder: (context, index) {
              final kebab = kebabItems[index];
              return Column(children: [
                KebabListItemClickable(
                  id: kebab['id'].toString(),
                  name: kebab['name'] ?? '',
                  rating: (kebab['rating'] ?? 0.0).toDouble(),
                  tag: (kebab['tag'] ?? ''),
                  isOpen: kebab['isOpen'] ?? false,
                  glutenFree: kebab['gluten_free'] ?? false,
                  onKebabSelected: (selectedKebabId) {
                    fetchSelectedKebab(selectedKebabId);
                  },
                ),
                SizedBox(height: 8),
              ]);
            },
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchKebab() async {
    final response = await supabase.from('kebab').select();

    if (response != null) {
      return List<Map<String, dynamic>>.from(response as List);
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchSelectedKebab(String id) async {
    final response =
        await supabase.from('kebab').select().eq('id', id).single();

    if (response != null && response['name'] != null) {
      print("Selected kebab: ${response['name']}");
      setState(() {
        _favoriteKebab = response;
      });
    } else {
      print("Error: No valid response or name found.");
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // Red border around CircleAvatar
                    Container(
                      width: 100, // Diameter of the circle
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: main.red, width: 3), // Red border
                      ),
                      child: CircleAvatar(
                        radius:
                            47, // Adjust radius to fit within the red border
                        backgroundImage:
                            (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                                ? NetworkImage(_avatarUrl!)
                                : const AssetImage('assets/images/kebab.png')
                                    as ImageProvider,
                      ),
                    ),
                    // White pill-shaped background for the camera icon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        shape: BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.circular(15), // Pill-shaped corners
                      ),
                      padding: const EdgeInsets.all(
                          2), // Adjust padding for smaller pill
                      child: IconButton(
                        padding: EdgeInsets
                            .zero, // Remove extra padding around the icon
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.camera_alt,
                          size: 25, // Smaller icon size
                          color: main.red, // Red icon color
                        ),
                        onPressed: _changeAvatar, // Added the onPressed action
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/kebabcolored.png",
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _username,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: _changeUsername,
                          child: const Text('edit'),
                        ),
                        const SizedBox(width: 3),
                        const Text(' | '),
                        const SizedBox(width: 3),
                        TextButton(
                          onPressed: _signOut,
                          child: const Text('sign out'),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserPostsPage(userId: _id)));
                    },
                    child: Column(
                      children: [
                        Text(
                          "$_postCount", // Numero di post
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'post',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FavoritesPage(userId: _id)));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_favoritesCount', // Numero di preferiti
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'preferiti',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SeguitiPage(userId: _id)));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_seguitiCount', // Numero di preferiti
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'seguiti',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FollowersPage(userId: _id)));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_followersCount', // Numero di preferiti
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'followers',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                        
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserReviewsPage(userId: _id)));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_reviewsCount', // Numero di preferiti
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ToolsPage(
                            currentPosition: widget.currentPosition,
                            ingredients: _ingredients,
                            onIngredientsUpdated: (updatedIngredients) {
                              setState(() {
                                _ingredients =
                                    updatedIngredients; // Update ingredients locally in AccountPage
                              });
                            },
                          )));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  child:
                      Text('Build your Kebab!', style: TextStyle(fontSize: 20)),
                )),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_favoriteKebab == null || _favoriteKebab!.isEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _openFavoriteKebabSelection();
                    },
                    child: const Text("Scegli il tuo kebab preferito"),
                  )
                else
                  Column(
                    children: [
                      Text(
                          "${_favoriteKebab?["name"] ?? 'Nome non disponibile'}"),
                      ElevatedButton(
                        onPressed: () {
                          _openFavoriteKebabSelection();
                        },
                        child: const Text("Cambia kebabbaro preferito"),
                      ),
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();

      // Navigate immediately after sign out
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred')),
        );
      }
    }
  }
}
