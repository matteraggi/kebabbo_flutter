import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/favorites_page.dart';
import 'package:kebabbo_flutter/pages/followers_page.dart';
import 'package:kebabbo_flutter/pages/seguiti_page.dart';
import 'package:kebabbo_flutter/pages/user_posts_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingleUserPage extends StatefulWidget {
  final String userId; // Aggiungi il parametro per l'ID dell'utente

  const SingleUserPage({super.key, required this.userId});

  @override
  State<SingleUserPage> createState() => _SingleUserPageState();
}

class _SingleUserPageState extends State<SingleUserPage> {
  String _username = "";
  String? _avatarUrl;
  int _postCount = 0;
  bool _loading = true;
  int _favoritesCount = 0;
  List<dynamic> _followed = [];
  bool _isFollowing = false; // Variabile per controllare se l'utente è seguito
  int _seguitiCount = 0; // Variabile per il conteggio dei follower
  int _followerCount = 0;
  Map<String, dynamic> _favoriteKebab = {};

  @override
  void initState() {
    super.initState();
    _loadProfile(widget.userId); // Passa l'ID utente al metodo di caricamento
    _getPostCount(widget.userId); // Passa l'ID utente anche qui
    _getFollowerCount(widget.userId); // Passa l'ID utente anche qui
  }

  Future<void> _getFollowerCount(String userId) async {
    try {
      final response = await supabase
          .from('profiles')
          .select('id')
          .contains('followed_users', [userId]);
      setState(() {
        _followerCount = response.length;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load follower count')),
        );
      }
    }
  }

  Future<void> _loadProfile(String userId) async {
    setState(() {
      _loading = true;
    });

    try {
      // Usa l'ID dell'utente per recuperare i dati del profilo da Supabase
      final profileData =
          await supabase.from('profiles').select().eq('id', userId).single();

      // Recupera anche il profilo dell'utente loggato per controllare il follow
      final currentUserProfile = await supabase
          .from('profiles')
          .select('followed_users')
          .eq('id', supabase.auth.currentUser!.id)
          .single();

      // Verifica se l'utente ha un kebab preferito
      Map<String, dynamic>? favoriteKebab;
      if (profileData['favorite_kebab'] != null) {
        // Ottieni i dettagli del kebab preferito
        favoriteKebab = await supabase
            .from('kebab')
            .select('name, description')
            .eq('id', profileData['favorite_kebab'])
            .single();
      }

      setState(() {
        _username = profileData['username'];
        _avatarUrl = profileData['avatar_url'];
        _favoritesCount = (profileData['favorites'] is List)
            ? profileData['favorites'].length
            : 0;
        _followed = currentUserProfile['followed_users'] ?? [];
        _isFollowing = _followed.contains(userId);
        _seguitiCount = (profileData['followed_users'] != null)
            ? profileData['followed_users'].length
            : 0;
        _favoriteKebab = favoriteKebab ?? {};
        _loading = false;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load profile')),
        );
      }
    }
  }

  Future<void> _toggleFollow() async {
    final currentUserId = supabase.auth.currentSession!.user.id;
    if (_isFollowing) {
      // Se già seguito, rimuovi l'ID dell'utente dalla lista dei seguiti
      _followed.remove(widget.userId);
    } else {
      // Aggiungi l'ID dell'utente alla lista dei seguiti
      _followed.add(widget.userId);
    }

    try {
      // Aggiorna il campo "followed_users" nel profilo dell'utente loggato
      await supabase.from('profiles').update({
        'followed_users': _followed,
      }).eq('id', currentUserId);

      setState(() {
        _isFollowing = !_isFollowing; // Cambia lo stato
        _seguitiCount = _followed.length; // Aggiorna il numero di follower
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update follow status')),
      );
    }
  }

  Future<void> _getPostCount(String userId) async {
    try {
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
      appBar: AppBar(
        backgroundColor: yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _toggleFollow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFollowing ? Colors.black12 : red,
                      ),
                      child: Text(_isFollowing ? 'Segui già' : 'Segui'),
                    ),
                    const SizedBox(height: 16),
                    if (_favoriteKebab.isNotEmpty)
                      Text(
                        "Kebab preferito: ${_favoriteKebab['name']}",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
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
                          builder: (context) =>
                              UserPostsPage(userId: widget.userId)));
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
                          builder: (context) => FavoritesPage(
                                userId: widget.userId,
                              )));
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
                          builder: (context) =>
                              SeguitiPage(userId: widget.userId)));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_seguitiCount', // Numero di follower
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
                          builder: (context) =>
                              FollowersPage(userId: widget.userId)));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_followerCount', // Numero di follower
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
