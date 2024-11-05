import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';


class UserPostsPage extends StatefulWidget {
  const UserPostsPage({super.key});

  @override
  State<UserPostsPage> createState() => _UserPostsPageState();
}

class _UserPostsPageState extends State<UserPostsPage> {
  List<Map<String, dynamic>> _userPosts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserPosts();
  }

  Future<void> _loadUserPosts() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;

      // Recupera i post dell'utente attuale
      final postsResponse = await supabase
          .from('posts')
          .select('*')
          .eq('user_id', userId)
          .filter('comment', 'is', null)
          .order('created_at', ascending: false);

      _userPosts = List<Map<String, dynamic>>.from(postsResponse);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load posts')),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
        title: const Text('I tuoi Post'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _userPosts.isEmpty
                  ? const Center(child: Text("Nessun post trovato"))
                  : ListView.builder(
                      itemCount: _userPosts.length,
                      itemBuilder: (context, index) {
                        final post = _userPosts[index];
                        return FeedListItem(
                          text: post['text'] ?? 'Testo non disponibile',
                          createdAt: post['created_at'] ?? '',
                          userId: post['user_id'],
                          imageUrl: post['image_url'] ?? '',
                          postId: post['id'].toString(),
                          likeList: post['like'] ?? [],
                          commentNumber: post['comments_number'] ?? 0,
                          kebabTagId: post['kebab_tag_id'] ?? '',
                          kebabName: post['kebab_name'] ?? '',
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
