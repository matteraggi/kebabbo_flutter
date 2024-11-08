import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:kebabbo_flutter/components/kebab_item_clickable.dart';
import 'package:kebabbo_flutter/components/kebab_item_favorite.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/favorites_page.dart';
import 'package:kebabbo_flutter/pages/followers_page.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:kebabbo_flutter/pages/medal_page.dart';
import 'package:kebabbo_flutter/pages/review_page.dart';
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
              title: const Text('Cambia Username'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _usernameController,
                    maxLength: 12,
                    decoration: const InputDecoration(
                      hintText: 'Nuovo username...',
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
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Posiziona il menu un po' più in basso rispetto all'icona
                    final RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    final position = renderBox.localToGlobal(Offset.zero);

                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        position.dx + 10, // posiziona orizzontalmente all'icona
                        position.dy +
                            60, // posiziona verticalmente 50px sotto l'icona
                        position.dx + renderBox.size.width,
                        position.dy + 60, // aggiungi offset anche qui
                      ),
                      items: [
                        PopupMenuItem<int>(
                          value: 1,
                          height:
                              40, // Altezza del menu per dare un po' più di spazio
                          child: Row(
                            children: [
                              Icon(Icons.settings, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Edit profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          height: 40,
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Menu arrotondato
                      ),
                      elevation: 5, // Ombra per far sembrare il menu "sospeso"
                      color: Colors.white, // Colore di sfondo del menu
                    ).then((value) {
                      if (value != null) {
                        // Gestisci la selezione del menu
                        if (value == 1) {
                          // Usa Future.delayed per ritardare l'apertura della finestra di dialogo
                          Future.delayed(Duration(milliseconds: 100), () {
                            _changeUsername(); // Apri il modulo di cambio username
                          });
                        } else if (value == 2) {
                          _signOut(); // Esegui il logout
                        }
                      }
                    });
                  },
                  child: Icon(Icons.menu, color: Colors.black, size: 24),
                ),
                Text(
                  _username,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
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
                  child: Icon(Icons.build, color: Colors.black, size: 22),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: main.red, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 47,
                    backgroundImage:
                        (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                            ? NetworkImage(_avatarUrl!)
                            : const AssetImage('assets/images/kebab.png')
                                as ImageProvider,
                  ),
                ),
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
                    padding:
                        EdgeInsets.zero, // Remove extra padding around the icon
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
            const SizedBox(height: 20),
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
                          "$_postCount",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Posts',
                          style: TextStyle(fontSize: 14),
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
                          '$_followersCount',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Followers',
                          style: TextStyle(fontSize: 14),
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
                          '$_seguitiCount',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Seguiti',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_favoriteKebab == null || _favoriteKebab!.isEmpty)
                    Text("Seleziona il tuo kebab preferito")
                  else
                    Row(
                      children: [
                        Image.asset(
                          _favoriteKebab?["tag"] == "kebab"
                              ? "assets/images/kebabcolored.png"
                              : "assets/images/sandwitch.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${_favoriteKebab?["name"] ?? 'Nome non disponibile'}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  InkWell(
                    onTap: () {
                      _openFavoriteKebabSelection();
                    },
                    child:
                        Icon(Icons.border_color, color: Colors.black, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    physics: const BouncingScrollPhysics(),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.emoji_events)),
                      Tab(icon: Icon(Icons.star)),
                      Tab(icon: Icon(Icons.bookmark)),
                    ],
                  ),
                  SizedBox(
                    height: 370, // Or any other height that suits your content
                    child: TabBarView(
                      children: [
                        MedalPage(userId: _id),
                        UserReviewsPage(userId: _id),
                        FavoritesPage(userId: _id),
                      ],
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
