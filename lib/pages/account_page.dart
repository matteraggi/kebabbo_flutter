import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _usernameController = TextEditingController();
  String? _avatarUrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _usernameController.text = (data['username'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    final userName = _usernameController.text.trim();
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'avatar_url': _avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully updated profile!')),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
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
        // Carica l'immagine nel bucket
        await supabase.storage.from('avatars').uploadBinary(filePath, bytes!,
            fileOptions: const FileOptions(upsert: true));

        // Ottieni l'URL pubblico dell'immagine e aggiorna il profilo
        final imageUrlResponse =
            supabase.storage.from('avatars').getPublicUrl(filePath);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: (_avatarUrl != null &&
                          _avatarUrl!.isNotEmpty)
                      ? NetworkImage(_avatarUrl!)
                      : const AssetImage('images/kebab.png') as ImageProvider,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  color: red,
                  onPressed: _changeAvatar,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _loading ? null : _updateProfile,
            child: Text(_loading ? 'Saving...' : 'Update'),
          ),
          const SizedBox(height: 18),
          TextButton(onPressed: _signOut, child: const Text('Sign Out')),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error occurred')),
        );
      }
    }
  }
}
