import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/feed_list_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class UserPostsPage extends StatefulWidget {
  final String userId; // Aggiungiamo il parametro userId

  const UserPostsPage(
      {super.key, required this.userId}); // Modificato per accettare userId

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
      final userId = widget.userId; // Usando userId passato al widget

      // Recupera i post dell'utente specificato
      final postsResponse = await supabase
          .from('posts')
          .select('*')
          .eq('user_id', userId)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
        title: Text(S.of(context).i_tuoi_post),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _userPosts.isEmpty
                  ? Center(child: Text(S.of(context).nessun_post_trovato))
                  : ListView.builder(
                      itemCount: _userPosts.length,
                      itemBuilder: (context, index) {
                        final post = _userPosts[index];
                        return FeedListItem(
                          text: post['text'] ?? S.of(context).testo_non_disponibile,
                          createdAt: post['created_at'] ?? '',
                          userId: post['user_id'],
                          imageUrl: post['image_url'] ?? '',
                          postId: post['id'].toString(),
                          likeList: post['like'] ?? [],
                          commentNumber: post['comments_number'] ?? 0,
                          kebabTagId: post['kebab_tag_id'] ?? '',
                          kebabName: post['kebab_tag_name'] ?? '',
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
