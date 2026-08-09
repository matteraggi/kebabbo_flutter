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
import 'package:kebabbo_flutter/pages/feed&socials/user_posts_page.dart';
import 'package:kebabbo_flutter/pages/reviews/user_reviews_page.dart';
import 'package:kebabbo_flutter/utils/image_compressor.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kebabbo_flutter/pages/reviews/add_kebab.dart';

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
  final TextEditingController _usernameController = TextEditingController();
  int _followersCount = 0;
  int _seguitiCount = 0;
  Map<String, dynamic>? _favoriteKebab;
  final String privacyPolicyUrl = "https://kebabbo.top/privacy-policy";
  bool _isAvatarLoading = false;

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

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
    });

    final profileData = await getProfile(context);
    fetchSelectedKebab(profileData!['favoriteKebab'].toString());
    setState(() {
      _username = profileData['username'];
      _avatarUrl = profileData['avatarUrl'];
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

    await updateProfile(context, _username, _avatarUrl, null);

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
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            color: main.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              _changeAvatar();
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
                                      color: Colors.white,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(S.of(context).cambia_username,
                            style: const TextStyle(
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
                              errorMessage = validateUsername(value, context);
                            });
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          errorMessage ?? ' \n ',
                          style: const TextStyle(color: red),
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
      withData: true,
    );

    if (result != null) {
      final Uint8List bytes = result.files.single.bytes!;
      Uint8List? processedImage =
          await ImageUtils.compressImage(bytes, 100 * 1024, 800, 800);

      final userId = supabase.auth.currentSession!.user.id;

      try {
        if (processedImage == null) {
          throw Exception("Image processing failed.");
        }

        await supabase.storage.from('avatars').uploadBinary(
              '$userId.png',
              processedImage,
              fileOptions: const FileOptions(upsert: true),
            );

        final imageUrlResponse =
            supabase.storage.from('avatars').getPublicUrl('$userId.png');

        final cacheBustedUrl =
            '${imageUrlResponse.trim()}?v=${DateTime.now().millisecondsSinceEpoch}';

        setState(() {
          _avatarUrl = cacheBustedUrl;
        });

        await _updateProfile();

        if (!mounted) return;
        Navigator.of(context).pop(); // Close dialog
      } catch (error) {
        if (mounted) {
          debugPrint("Error uploading avatar: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).failed_to_upload_avatar)),
          );
        }
      }
    }

    setState(() {
      _isAvatarLoading = false;
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

  Future<void> _openFavoriteKebabSelection() async {
    List<Map<String, dynamic>> kebabItems = await fetchKebab();

    if (!mounted) return;
    showModalBottomSheet(
      backgroundColor: yellow,
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
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
                    const SizedBox(height: 8),
                  ]);
                },
              ),
            ),
          ],
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
      debugPrint("Error: No valid kebab id found.");
      return {};
    }
    final response =
        await supabase.from('kebab').select().eq('id', id).single();

    if (response['name'] != null) {
      setState(() {
        _favoriteKebab = response;
      });
    } else {
      debugPrint("Error: No valid response or name found.");
    }

    return response;
  }

  Future<void> _signOut() async {
    try {
      setState(() {});
      await supabase.auth.signOut();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).unexpected_error_occurred)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                      SizedBox(
                        width: 48,
                        child: InkWell(
                          onTap: () async {
                            final RenderBox renderBox =
                                context.findRenderObject() as RenderBox;
                            final position =
                                renderBox.localToGlobal(Offset.zero);

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
                                      const Icon(Icons.settings,
                                          color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).edit_profile,
                                        style: const TextStyle(
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
                                      const Icon(Icons.info_outline,
                                          color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).about,
                                        style: const TextStyle(
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
                                      const Icon(Icons.privacy_tip,
                                          color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).privacy_policy,
                                        style: const TextStyle(
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
                                      const Icon(Icons.add_business,
                                          color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).add_kebab,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  value: 6,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.logout,
                                          color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).logout,
                                        style: const TextStyle(
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              color: Colors.white,
                            ).then((value) {
                              if (!context.mounted) return;
                              if (value != null) {
                                if (value == 1) {
                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    _changeUsername();
                                  });
                                } else if (value == 2) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const AboutPage()));
                                } else if (value == 3) {
                                  () async {
                                    final url = Uri.parse(privacyPolicyUrl);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode.inAppWebView,
                                      );
                                    } else {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .could_not_open_link),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  }();
                                } else if (value == 5) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const AddKebab()),
                                  );
                                } else if (value == 6) {
                                  _signOut();
                                }
                              }
                            });
                          },
                          child: const Icon(Icons.menu,
                              color: Colors.black, size: 24),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _username,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48), // Balancer
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Profile + Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Image(
                                            image: (_avatarUrl != null &&
                                                    _avatarUrl!.isNotEmpty)
                                                ? NetworkImage(_avatarUrl!)
                                                : const AssetImage(
                                                        'assets/logos/small_logo.png')
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: Icon(
                                              Icons.camera_alt,
                                              size: 25,
                                              color: main.red,
                                            ),
                                            onPressed: _changeAvatar,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
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
                        ),
                      ),

                      const SizedBox(width: 24),

                      // Stats
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // POSTS
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserPostsPage(userId: _id),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "$_postCount",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).posts,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),

                            // FOLLOWERS
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FollowersPage(userId: _id),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$_followersCount',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).followers,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),

                            // SEGUITI
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SeguitiPage(userId: _id),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$_seguitiCount',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).following,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
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
                                const SizedBox(width: 8),
                                Text(
                                  "${_favoriteKebab?["name"] ?? S.of(context).nome_non_disponibile}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          const Icon(Icons.border_color,
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
                        const TabBar(
                          physics: BouncingScrollPhysics(),
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
                          height: tabBarViewHeight,
                          child: TabBarView(
                            children: [
                              MedalPage(userId: _id),
                              UserReviewsPage(
                                userId: _id,
                                initialPosition: widget.currentPosition,
                              ),
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
}
