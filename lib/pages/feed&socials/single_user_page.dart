import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/list_items/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/feed&socials/followers_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/seguiti_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/user_posts_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

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
  List<dynamic> _followed = [];
  List<dynamic> _userPosts = [];
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
    _loadUserPosts(); // Passa l'ID utente anche qui
  }

Future<void> _loadUserPosts() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = widget.userId; // Usando userId passato al widget

      // Recupera i post dell'utente specificato
      final postsResponse = await supabase
          .from('posts')
          .select('*')
          .eq('user_id', userId.toString())
          .filter('comment', 'is', null)
          .order('created_at', ascending: false);

      _userPosts = List<Map<String, dynamic>>.from(postsResponse);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).failed_to_load_posts)),
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
          SnackBar(content: Text(S.of(context).failed_to_load_follower_count)),
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
          SnackBar(content: Text(S.of(context).failed_to_load_profile)),
        );
      }
    }
  }

  Future<void> _toggleFollow() async {
    final currentUserId = supabase.auth.currentSession!.user.id;
    final userIdToFollow = widget.userId;

    // Verifica se l'utente è già seguito
    if (_isFollowing) {
      // Se già seguito, rimuovi l'ID dell'utente dalla lista dei seguiti
      _followed.remove(userIdToFollow);
    } else {
      // Aggiungi l'ID dell'utente alla lista dei seguiti solo se non è già presente
      if (!_followed.contains(userIdToFollow)) {
        _followed.add(userIdToFollow);
      }
    }

    try {
      // Aggiorna il campo "followed_users" nel profilo dell'utente loggato
      await supabase.from('profiles').update({
        'followed_users': _followed,
      }).eq('id', currentUserId);

      setState(() {
        _isFollowing = !_isFollowing; // Cambia lo stato
        _seguitiCount = _followed.length; // Aggiorna il numero di seguiti
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).failed_to_update_follow_status)),
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
          SnackBar(content: Text(S.of(context).failed_to_load_post_count)),
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
    body: _loading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: red, width: 3),
              ),
              child: CircleAvatar(
                radius: 47,
                backgroundImage: (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                    ? NetworkImage(_avatarUrl!)
                    : const AssetImage('assets/logos/small_logo.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _toggleFollow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFollowing ? Colors.black12 : red,
                  ),
                  child: Text(_isFollowing ? S.of(context).segui_gia : S.of(context).segui),
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
                          builder: (context) =>
                              UserPostsPage(userId: widget.userId)));
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
                          builder: (context) => FollowersPage(
                                userId: widget.userId,
                              )));
                    },
                    child: Column(
                      children: [
                        Text(
                          '$_followerCount',
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
                          builder: (context) =>
                              SeguitiPage(userId: widget.userId)));
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
                        Text(
                          S.of(context).seguiti,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_favoriteKebab.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.star, color: yellow, size: 24),
                    Row(
                      children: [
                        Image.asset(
                          _favoriteKebab["tag"] == "kebab"
                              ? "assets/images/kebabcolored.png"
                              : "assets/images/sandwitch.png",
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${_favoriteKebab["name"] ?? S.of(context).nome_non_disponibile}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.star, color: yellow, size: 24),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            
            // User's Posts Section
            Text(
              S.of(context).i_tuoi_post,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // List of user posts
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, // Let ListView take up only the necessary space
              itemCount: _userPosts.length,
              itemBuilder: (context, index) {
                final post = _userPosts[index];
                return FeedListItem(
                  text: post['text'] ?? S.of(context).testo_non_disponibile,
                  createdAt: post['created_at'] ?? '',
                  userId: post['user_id'],
                  imageUrl: post['image_url'] ?? '',
                  postId: post['id'],
                  likeList: post['like'] ?? [],
                  commentNumber: post['comments_number'] ?? 0,
                  kebabTagId: post['kebab_tag_id'] ?? 0,
                  kebabName: post['kebab_tag_name'] ?? '',
                  canBeEliminated: widget.userId == supabase.auth.currentUser!.id,
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}