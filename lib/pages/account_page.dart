import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/favorites_page.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:kebabbo_flutter/pages/tools_page.dart';
import 'package:kebabbo_flutter/pages/user_posts_page.dart';
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
  String? _avatarUrl;
  int _postCount = 0;
  bool _loading = true;
  int _favoritesCount = 0;
  List<int> _ingredients = [5, 5, 5, 5, 5];
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _getPostCount();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
    });

    final profileData = await getProfile(context); // Call the utility function
    if (profileData != null) {
      setState(() {
        _username = profileData['username'];
        _avatarUrl = profileData['avatarUrl'];
        _favoritesCount = profileData['favoritesCount'];
        _ingredients = List<int>.from(profileData['ingredients']);
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
                        border: Border.all(color: red, width: 3), // Red border
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
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 25, // Smaller icon size
                          color: red, // Red icon color
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
                      // Azione per la sezione dei post
                      // Ad esempio, naviga alla pagina dei post dell'utente
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserPostsPage()));
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
                          'Post',
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
                      // Azione per la sezione dei preferiti
                      // Ad esempio, naviga alla pagina dei preferiti dell'utente
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const FavoritesPage()));
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
                          'Preferiti',
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
