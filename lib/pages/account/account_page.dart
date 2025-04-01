import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item_clickable.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab/favorites_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/followers_page.dart';
import 'package:kebabbo_flutter/pages/misc/about_page.dart';
import 'package:kebabbo_flutter/pages/misc/medal_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/seguiti_page.dart';
import 'package:kebabbo_flutter/pages/account/tools_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/user_posts_page.dart';
import 'package:kebabbo_flutter/pages/reviews/user_reviews_page.dart';
import 'package:kebabbo_flutter/pages/tcg/carousel.dart';
import 'package:kebabbo_flutter/pages/tcg/pack_page.dart';
import 'package:kebabbo_flutter/utils/image_compressor.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';



class AccountPage extends StatefulWidget {
  final Position? currentPosition;
  const AccountPage({super.key, required this.currentPosition});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _username = "";
  final String _id = Supabase.instance.client.auth.currentSession!.user.id;
  String? _avatarUrl;
  int _postCount = 0;
  bool _loading = true;
  List<int> _ingredients = [5, 5, 5, 5, 5];
  final TextEditingController _usernameController = TextEditingController();
  int _followersCount = 0;
  int _seguitiCount = 0;
  Map<String, dynamic>? _favoriteKebab;
  final String privacyPolicyUrl = "https://kebabbo.top/privacy-policy";
  bool _isAvatarLoading = false;
  DateTime _lastPack = DateTime.now().toUtc();
  bool _isTimerActive = false;
  @override
  void initState() {
    super.initState();
    _loadProfile();
    _getPostCount();
    _getFollowerCount();
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
          SnackBar(content: Text(S.of(context).failed_to_load_follower_count)),
        );
      }
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.remainder(12).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
    });

    final profileData = await getProfile(context);
    fetchSelectedKebab(profileData!['favoriteKebab'].toString());
    setState(() {
      _username = profileData['username'];
      _avatarUrl = profileData['avatarUrl'];
      _lastPack = DateTime.parse(profileData['last_pack']).toUtc();
      _isTimerActive = _calculateIsTimerActive(_lastPack);
      _ingredients = List<int>.from(profileData['ingredients']);
      _seguitiCount = (profileData['seguitiCount'] != null)
          ? profileData['seguitiCount'].length
          : 0;
      _loading = false;
    });
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
            return _isAvatarLoading
                ? const Center(child: CircularProgressIndicator())
                : AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: main.red, // Sfondo rosso
                            borderRadius:
                                BorderRadius.circular(15), // Angoli arrotondati
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8), // Padding interno
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                                12), // Effetto di tocco arrotondato
                            onTap: () async {
                              _changeAvatar(); // Cambia avatar
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    S.of(context).cambia_profilepic,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .white, // Testo bianco per contrasto
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.camera_alt,
                                  size: 25, // Dimensione dell'icona
                                  color: Colors.white, // Icona bianca
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(S.of(context).cambia_username,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        TextField(
                          controller: _usernameController,
                          maxLength: 12,
                          decoration: InputDecoration(
                            hintText: S.of(context).nuovo_username,
                            counterText: '',
                          ),
                          onChanged: (value) {
                            setState(() {
                              errorMessage = validateUsername(
                                  value, context); // Use the utility function
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
                        child: Text(S.of(context).cancel),
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
                        child: Text(S.of(context).update),
                      ),
                    ],
                  );
          },
        );
      },
    );
  }

  Future<void> _changeAvatar() async {
    setState(() {
      _isAvatarLoading = true;
    });

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      allowMultiple: false,
    );

    if (result != null) {
      final Uint8List bytes = result.files.single.bytes!;
      Uint8List? processedImage =
          await ImageUtils.compressImage(bytes, 100 * 1024, 800, 800);

      final userId = supabase.auth.currentSession!.user.id;

      try {
        await supabase.storage.from('avatars').uploadBinary(
              '$userId.png',
              processedImage!,
              fileOptions: const FileOptions(upsert: true),
            );

        final imageUrlResponse =
            supabase.storage.from('avatars').getPublicUrl('$userId.png');

        final cacheBustedUrl =
            '$imageUrlResponse?v=${DateTime.now().millisecondsSinceEpoch}';

        setState(() {
          _avatarUrl = cacheBustedUrl;
        });

        await _updateProfile();

        Navigator.of(context).pop(); // Chiudi il dialog
      } catch (error) {
        if (mounted) {
          print( "Error uploading avatar: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).failed_to_upload_avatar)),
          );
        }
      }
    }

    setState(() {
      _isAvatarLoading = false; // Nascondi il loader
    });
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
          SnackBar(content: Text(S.of(context).failed_to_load_post_count)),
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
                  shouldSaveFavorite: true,
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

    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<Map<String, dynamic>> fetchSelectedKebab(String id) async {
    if (id.isEmpty || id == "0") {
      print("Error: No valid kebab id found.");
      return {};
    }
    final response =
        await supabase.from('kebab').select().eq('id', id).single();

    if (response['name'] != null) {
      setState(() {
        _favoriteKebab = response;
      });
    } else {
      print("Error: No valid response or name found.");
    }

    return response;
  }

  bool _calculateIsTimerActive(DateTime lastPackTime) {
    return false;
    final now = DateTime.now().toUtc();
    final difference = now.difference(lastPackTime);
    return difference.inSeconds < 12 * 60 * 60;
  }

  @override
  Widget build(BuildContext context) {
    // Ottieni l'altezza dello schermo
    final screenHeight = MediaQuery.of(context).size.height;

    // Calcola l'altezza dinamica per la TabBarView
    final tabBarViewHeight = screenHeight - 410;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          // Posiziona il menu un po' più in basso rispetto all'icona
                          final RenderBox renderBox =
                              context.findRenderObject() as RenderBox;
                          final position = renderBox.localToGlobal(Offset.zero);

                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              position.dx + 10,
                              position.dy + 60,
                              position.dx + renderBox.size.width,
                              position.dy + 60,
                            ),
                            items: [
                              PopupMenuItem<int>(
                                value: 1,
                                height: 40,
                                child: Row(
                                  children: [
                                    Icon(Icons.settings, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      S.of(context).edit_profile,
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
                                    Icon(Icons.info_outline,
                                        color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      "About",
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
                                value: 3,
                                height: 40,
                                child: Row(
                                  children: [
                                    Icon(Icons.privacy_tip,
                                        color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'Privacy Policy',
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
                                value: 4,
                                height: 40,
                                child: Row(
                                  children: [
                                    Icon(Icons.collections_bookmark_sharp,
                                        color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'Cards',
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
                                value: 5,
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
                              // Add "Delete account" button in red
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            color: Colors.white,
                          ).then((value) {
                            if (value != null) {
                              if (value == 1) {
                                Future.delayed(Duration(milliseconds: 100), () {
                                  _changeUsername();
                                });
                              } else if (value == 2) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AboutPage()));
                              } else if (value == 3) {
                                print("Opening privacy policy");

                                () async {
                                  final url = Uri.parse(privacyPolicyUrl);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.inAppWebView,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Impossibile aprire il link.'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                }();
                              } else if (value == 4) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => KebabCarouselPage()));
                              } else if (value == 5) {
                                _signOut();
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
                      Row(
                        children: [
                          InkWell(
                            onTap: _isTimerActive
                                ? null // Disable if timer is active
                                : () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PackPage()),
                                    );
                                  },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.card_giftcard,
                                  color: _isTimerActive
                                      ? Colors.blueGrey
                                      : Colors.black, // Grey if disabled
                                  size: 22,
                                ),
                                StreamBuilder<DateTime>(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 1),
                                      (_) => DateTime.now().toUtc()),
                                  builder: (context, snapshot) {
                                    final now =
                                        snapshot.data ?? DateTime.now().toUtc();
                                    final difference =
                                        now.difference(_lastPack);
                                    final remainingTime =
                                        const Duration(hours: 12) - difference;
                                    if (difference.inSeconds < 12 * 60 * 60 &&
                                        !remainingTime.isNegative) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.white, // White background
                                          borderRadius: BorderRadius.circular(
                                              20), // Pill shape
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.2),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          _formatDuration(remainingTime),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                                FontWeight.bold, // Bold text
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox
                                          .shrink(); // Hide if timer is not needed
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ToolsPage(
                                        currentPosition: widget.currentPosition,
                                        ingredients: _ingredients,
                                        onIngredientsUpdated:
                                            (updatedIngredients) {
                                          setState(() {
                                            _ingredients =
                                                updatedIngredients; // Update ingredients locally in AccountPage
                                          });
                                        },
                                      )));
                            },
                            child: Icon(Icons.build,
                                color: Colors.black, size: 22),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog when tapped again
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.8, // Adjust size
                                    height: MediaQuery.of(context).size.height *
                                        0.5, // Adjust size
                                    child: Image(
                                      image: (_avatarUrl != null &&
                                              _avatarUrl!.isNotEmpty)
                                          ? NetworkImage(_avatarUrl!)
                                          : const AssetImage(
                                                  'assets/logos/small_logo.png')
                                              as ImageProvider,
                                      fit: BoxFit
                                          .cover, // Fit the image within the dialog
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10, // Adjust positioning as necessary
                                  right: 10, // Adjust positioning as necessary
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        4.0), // Add padding around the icon
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // White background color
                                      shape: BoxShape
                                          .circle, // Circular shape for the container
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets
                                          .zero, // Remove extra padding around the icon
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 25, // Smaller icon size
                                        color: main.red, // Red icon color
                                      ),
                                      onPressed:
                                          _changeAvatar, // Action to change the avatar
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Stack(
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
                                    : const AssetImage(
                                            'assets/logos/small_logo.png')
                                        as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    UserPostsPage(userId: _id)));
                          },
                          child: Column(
                            children: [
                              Text(
                                "$_postCount",
                                style: const TextStyle(
                                  fontSize: 25,
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
                                builder: (context) =>
                                    FollowersPage(userId: _id)));
                          },
                          child: Column(
                            children: [
                              Text(
                                '$_followersCount',
                                style: const TextStyle(
                                  fontSize: 25,
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
                                builder: (context) =>
                                    SeguitiPage(userId: _id)));
                          },
                          child: Column(
                            children: [
                              Text(
                                '$_seguitiCount',
                                style: const TextStyle(
                                  fontSize: 25,
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
                  const SizedBox(height: 15),
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
                    child: InkWell(
                      onTap: () {
                        _openFavoriteKebabSelection();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_favoriteKebab == null || _favoriteKebab!.isEmpty)
                            Text(S.of(context).seleziona_il_tuo_kebab_preferito)
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
                                  "${_favoriteKebab?["name"] ?? S.of(context).nome_non_disponibile}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          Icon(Icons.border_color,
                              color: Colors.black, size: 22),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                            Tab(icon: Icon(Icons.reviews)),
                            Tab(icon: Icon(Icons.bookmark)),
                          ],
                        ),
                        SizedBox(
                          height:
                              tabBarViewHeight, // Or any other height that suits your content
                          child: TabBarView(
                            children: [
                              MedalPage(userId: _id),
                              UserReviewsPage(userId: _id, initialPosition:  widget.currentPosition,),
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
      setState(() {});
      await supabase.auth.signOut();
      // Navigate immediately after sign out
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).unexpected_error_occurred)),
        );
      }
    }
  }

  /* Future<void> _deleteAccount(BuildContext context) async {
  final userId = supabase.auth.currentUser!.id;
  final allMyPosts = await supabase
      .from('posts')
      .select('image_url') // Select only the image_url
      .eq('user_id', userId);

    // Fetch all posts made by the current user
    final postFiles = await supabase.storage.from('posts').list();

  for (var post in allMyPosts) {
    final imageUrl = post['image_url'] as String?; // Get the image URL

    // Check if imageUrl is not null and not empty
    if (imageUrl != null && imageUrl.isNotEmpty) {
      final imageName = imageUrl.split('/').last; // Extract the image name

      for (var postFile in postFiles) {
        if (postFile.name == imageName) {
          await supabase.storage.from('posts').remove([postFile.name]);
          break; // Exit the inner loop after deleting the image
        }
      }
    }
  }


    // 2. Delete avatar from 'avatars' bucket (assuming one avatar per user)
    final avatarFiles = await supabase.storage.from('avatars').list();
    for (var file in avatarFiles) {
    }
  if (_avatarUrl != null && _avatarUrl!.isNotEmpty) {  
    final avatarName = _avatarUrl!.split('/').last;

    for (var file in avatarFiles) {
      if (file.name == avatarName) {
        print("Deleting avatar: $avatarName");
        final response = await supabase.storage.from('avatars').remove([file.name]);
        break; // Exit the loop after deleting the avatar
      }
    }
  }

    // Delete the user profile from the 'profiles' table
    await supabase
        .from('profiles')
        .delete()
        .eq('id', userId);
    print ("User profile deleted");

    // Sign out the user after deletion
    _signOut();
    print("User signed out");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );

}


  void _showDeleteAccountDialog(BuildContext context) {
    bool showConfirmButton = false; // Track state for the second button

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                "Delete Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Are you sure you want to delete your account? This action cannot be undone.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  // First Delete Account Button
                  if (!showConfirmButton)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showConfirmButton = true; // Show confirm button
                        });
                      },
                      child: Text(
                        "Delete Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  // Second Confirm Button
                  if (showConfirmButton)
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 14),
                            backgroundColor:
                                Colors.redAccent, // Different color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _deleteAccount(
                                context); // Call your delete function
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text(
                            "Confirm Delete",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                ],
              ),
              actionsAlignment:
                  MainAxisAlignment.center, // Center cancel button
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
  */
}

/*
GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(privacyPolicyUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Impossibile aprire il link.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
*/
