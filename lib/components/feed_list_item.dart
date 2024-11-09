import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab_single_page.dart';
import 'package:kebabbo_flutter/pages/single_user_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_it;

class FeedListItem extends StatefulWidget {
  final String text;
  final String createdAt;
  final String userId;
  final String imageUrl;
  final String postId;
  final List<dynamic> likeList;
  final int commentNumber;
  final String kebabTagId;
  final String kebabName;

  const FeedListItem({
    super.key,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.imageUrl,
    required this.postId,
    required this.likeList,
    required this.commentNumber,
    required this.kebabTagId,
    required this.kebabName,
  });

  @override
  FeedListItemState createState() => FeedListItemState();
}

class FeedListItemState extends State<FeedListItem> {
  String? userName;
  String? avatarUrl;
  bool isLoading = true;
  bool hasLiked = false;
  int likeCount = 0;
  final TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> commentsList = [];
  bool isLoadingComments = false;
  List<Map<String, dynamic>> userProfiles = [];
  late int _currentCommentNumber;
  List<String> userList = [];

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(widget.userId);
    _checkIfLiked();
    fetchUserNames();
    _currentCommentNumber = widget.commentNumber;
    timeago_it.setLocaleMessages('it', timeago_it.ItMessages());
  }

  Future<void> _fetchUserProfile(String userId) async {
    try {
      final response =
          await supabase.from('profiles').select('*').eq('id', userId).single();

      if (mounted) {
        setState(() {
          userName = response['username'] ?? 'Anonimo';
          avatarUrl = response['avatar_url'] as String?;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          userName = 'Anonimo';
          isLoading = false;
        });
      }
      print('Errore nel recupero del profilo: $error');
    }
  }

  Future<void> _checkIfLiked() async {
    try {
      final userId = supabase.auth.currentSession!.user.id;
      bool userLiked = widget.likeList.contains(userId);

      if (mounted) {
        setState(() {
          hasLiked = userLiked;
          likeCount = widget.likeList.length;
        });
      }
    } catch (error) {
      print('Errore nel controllo dei like: $error');
    }
  }

  Future<void> _toggleLike(String postId) async {
    final userId = supabase.auth.currentSession!.user.id;
    final updatedLikes = List<String>.from(widget.likeList);

    if (hasLiked) {
      updatedLikes.remove(userId);
      likeCount--;
    } else {
      updatedLikes.add(userId);
      likeCount++;
    }

    try {
      await supabase
          .from('posts')
          .update({'like': updatedLikes}).eq('id', postId);

      setState(() {
        hasLiked = !hasLiked;
      });
    } catch (error) {
      print('Errore durante l\'aggiornamento dei like: $error');
    }
  }

  String _formatTimestamp(String createdAt) {
    final DateTime postDate = DateTime.parse(createdAt);
    return timeago.format(postDate, locale: 'it');
  }

  Future<void> _postComment() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      print("Devi essere autenticato per commentare.");
      return;
    }

    final String commentText = commentController.text.trim();
    if (commentText.isEmpty) {
      print("Il testo del commento non può essere vuoto.");
      return;
    }

    final Map<String, dynamic> commentData = {
      'comment': widget.postId,
      'user_id': user.id,
      'text': commentText,
      'created_at': DateTime.now().toIso8601String(),
    };

    try {
      // Inserisce il nuovo commento
      await supabase.from('posts').insert(commentData);

      await supabase
          .from('posts')
          .update({'comments_number': widget.commentNumber + 1}).eq(
              'id', widget.postId);

      setState(() {
        _currentCommentNumber++;
      });

      // Resetta il controller del commento
      commentController.clear();
      print("Commento pubblicato con successo.");
    } catch (error) {
      print("Errore durante la pubblicazione del commento: $error");
    }
  }

  void _showCommentsDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _fetchComments(
                      widget.postId), // Ritorna il Future di commenti
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Errore: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('Nessun commento disponibile'));
                    } else {
                      final commentsList =
                          snapshot.data!; // Usa la lista di commenti qui
                      return ListView.builder(
                        itemCount: commentsList.length,
                        itemBuilder: (context, index) {
                          final comment = commentsList[index];
                          final userProfile = comment[
                              'user_profile']; // Ottieni il profilo dell'utente

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: userProfile['avatar_url'] != null
                                  ? NetworkImage(userProfile['avatar_url'])
                                  : null,
                              child: userProfile['avatar_url'] == null
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            title: Text(
                                comment['text'] ?? 'Commento non disponibile'),
                            subtitle: Text(
                              '${userProfile['username'] ?? 'Anonimo'} - ${_formatTimestamp(comment['created_at'])}',
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: "Scrivi un commento...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        await _postComment();
                        if (mounted) {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Il commento è stato aggiunto con successo!")),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchComments(String postId) async {
    try {
      final comments = await supabase
          .from('posts')
          .select('*')
          .filter('comment', 'eq', postId)
          .order('created_at', ascending: true);

      userProfiles = [];
      for (var comment in comments) {
        final userId = comment['user_id'];
        final response = await supabase
            .from('profiles')
            .select('*')
            .eq('id', userId)
            .single();
        userProfiles.add(response);
      }

      for (var comment in comments) {
        final userProfile = userProfiles.firstWhere(
            (profile) => profile['id'] == comment['user_id'],
            orElse: () => {'username': 'Anonimo', 'avatar_url': null});
        comment['user_profile'] = userProfile;
      }

      return List<Map<String, dynamic>>.from(comments);
    } catch (error) {
      return []; // Restituisci una lista vuota in caso di errore
    }
  }

  Future<void> fetchUserNames() async {
    final PostgrestList response =
        await supabase.from('profiles').select('username');

    if (mounted) {
      List<Map<String, dynamic>> users =
          List<Map<String, dynamic>>.from(response as List);

      setState(() {
        userList = users
            .map((user) => user['username'])
            .where((username) => username != null) // Filtra i valori null
            .map((username) => username.toString()) // Converte a stringa
            .toList();
      });
    }
  }

  List<TextSpan> _highlightUserTags(String text) {
    List<TextSpan> spans = [];
    int start = 0;

    RegExp exp = RegExp(r'@(\S+)');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    for (final match in matches) {
      String tagText = match.group(1)!;

      bool isUsername = userList?.contains(tagText) ?? false;

      spans.add(TextSpan(
        text: text.substring(start, match.start),
        style: const TextStyle(color: Colors.black),
      ));

      spans.add(TextSpan(
        text: '@$tagText',
        style: TextStyle(color: isUsername ? red : Colors.black),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            try {
              final userId = await _fetchUserIdByUsername(tagText);
              if (userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleUserPage(
                      userId: userId,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User not found")),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("An error occurred")),
              );
            }
          },
      ));

      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: const TextStyle(color: Colors.black),
      ));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? const CircularProgressIndicator()
                : InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleUserPage(
                            userId: widget
                                .userId, // Passa l'ID dell'utente alla SingleUserPage
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              avatarUrl != null && avatarUrl!.isNotEmpty
                                  ? NetworkImage(avatarUrl!)
                                  : const AssetImage('images/kebab.png')
                                      as ImageProvider,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          userName ?? 'Anonimo',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 8),
            if (widget.kebabName.isNotEmpty)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KebabSinglePage(
                        kebabId: widget.kebabTagId,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      widget.kebabName,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: _highlightUserTags(widget.text),
              ),
            ),
            const SizedBox(height: 8),
            widget.imageUrl.isNotEmpty
                ? Image.network(widget.imageUrl)
                : const SizedBox.shrink(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('$likeCount'),
                IconButton(
                  icon: Icon(
                    hasLiked ? Icons.favorite : Icons.favorite_border,
                    color: hasLiked ? red : Colors.black,
                  ),
                  onPressed: () => _toggleLike(widget.postId),
                ),
                const SizedBox(width: 16),
                Text('$_currentCommentNumber'),
                IconButton(
                  icon: const Icon(Icons.comment_outlined, color: Colors.black),
                  onPressed: _showCommentsDialog,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _formatTimestamp(widget.createdAt),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _fetchUserIdByUsername(String username) async {
  final response = await supabase
      .from('profiles') // Replace with your actual users table
      .select('id')
      .eq('username', username)
      .single();

  return response['id'].toString();
}
