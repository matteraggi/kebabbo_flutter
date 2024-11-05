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
    // Ensure the widget is mounted before proceeding
    if (!mounted) return;
    _usernameController.text= _username;
    // Show the dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Username'),
          content: TextField(
            controller: _usernameController,
            maxLength: 12, // Limit to 12 characters
            decoration: const InputDecoration(
              hintText: 'Enter new username',
              counterText: '', // Remove the counter text
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (mounted) {
                  Navigator.of(context).pop(); // Close the dialog immediately
                }
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Immediately dismiss the dialog to avoid async gap issues
                if (mounted) {
                  Navigator.of(context).pop();
                }

                // Wait for the async update to complete
                setState(() {
                  _username = _usernameController.text.trim();
                });

                // Perform the update operation
                await _updateProfile();

                // After async operation, ensure widget is still mounted
                if (mounted) {
                  setState(() {}); // Trigger a UI update if necessary
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeAvatar() async {
    // Usa FilePicker per selezionare un’immagine
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      final Uint8List? bytes = result.files.single.bytes;
      final userId = supabase.auth.currentSession!.user.id;
      final filePath = '$userId.png';

      try {
        print("got here");
        // Carica l'immagine nel bucket
        await supabase.storage.from('avatars').uploadBinary(filePath, bytes!,
            fileOptions: const FileOptions(upsert: true));
        print("not here ");
        // Ottieni l'URL pubblico dell'immagine e aggiorna il profilo
        final imageUrlResponse = supabase.storage.from('avatars').getPublicUrl(
            filePath,
            transform: const TransformOptions(
                height: 200,
                width: 200,
                resize: ResizeMode.contain,
                quality: 60));
        final imageUrl = imageUrlResponse;
        setState(() {
          _avatarUrl = imageUrl;
        });

        await _updateProfile(); // Aggiorna il profilo con il nuovo avatar URL
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                              ? NetworkImage(_avatarUrl!)
                              : const AssetImage('assets/images/kebab.png')
                                  as ImageProvider,
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      color: red,
                      onPressed: _changeAvatar,
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
