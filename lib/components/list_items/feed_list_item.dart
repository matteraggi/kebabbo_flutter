import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/kebab/kebab_single_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/single_user_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_it;
import 'package:kebabbo_flutter/generated/l10n.dart';

class FeedListItem extends StatefulWidget {
  final String text;
  final String createdAt;
  final String userId;
  final String imageUrl;
  final int postId;
  final List<dynamic> likeList;
  final int commentNumber;
  final int kebabTagId;
  final String kebabName;
  final bool canBeEliminated;
  

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
    this.canBeEliminated = false,
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
  String anonymous ="Anonimo";
  bool deleted = false;
  

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(widget.userId);
    _checkIfLiked();
    fetchUserNames();
    _currentCommentNumber = widget.commentNumber;
    timeago_it.setLocaleMessages('it', timeago_it.ItMessages());
  }
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Use S.of(context) safely here
    if (Supabase.instance.client.auth.currentSession == null) {
      setState(() {
        anonymous = S.of(context).anonimo;
      });
    }
  }

Future<void> _fetchUserProfile(String userId) async {
  try {
    // If userId is null or empty, set default values
    if (supabase.auth.currentUser == null) {
      if (mounted) {
        setState(() {
          userName = anonymous;
          avatarUrl = null;
          isLoading = false;
        });
      }
      return; // Exit early since no user ID is provided
    }

    final response =
        await supabase.from('profiles').select('*').eq('id', userId).single();

    if (mounted) {
      setState(() {
        userName = response['username'] ?? anonymous;
        avatarUrl = response['avatar_url'] as String?;
        isLoading = false;
      });
    }
  } catch (error) {
    if (mounted) {
      setState(() {
        userName = anonymous;
        avatarUrl = null; // No avatar if there's an error
        isLoading = false;
      });
    }
    print('Errore nel recupero del profilo: $error');
  }
}

  Future<void> _checkIfLiked() async {
    try {
      final userId = supabase.auth.currentSession?.user.id;
      bool userLiked = userId != null ? widget.likeList.contains(userId) : false;

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

  Future<void> _toggleLike(int postId) async {
    final userId = supabase.auth.currentSession?.user.id;
    final updatedLikes = List<String>.from(widget.likeList);

    if (hasLiked) {
      updatedLikes.remove(userId);
      likeCount--;
    } else {
      if (userId == null) {
        //show a toast
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).devi_essere_autenticato_per_mettere_mi_piace)),
        );
        return;
      }
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
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).autenticazione_necessaria)));
      return;
    }

    final String commentText = commentController.text.trim();
    if (commentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).commento_vuoto))); 
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
                      return Center(
                          child: Text(S.of(context).errore +
                              snapshot.error.toString()));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child:
                              Text(S.of(context).nessun_commento_disponibile));
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
                            title: Text(comment['text'] ??
                                S.of(context).commento_non_disponibile),
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
                        enabled: supabase.auth.currentUser !=
                            null, // Abilita solo se l'utente è loggato
                        decoration: InputDecoration(
                          hintText: supabase.auth.currentUser != null
                              ? S.of(context).scrivi_un_commento
                              : S.of(context).devi_essere_autenticato_per_commentare,
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
                            SnackBar(
                                content: Text(S
                                    .of(context)
                                    .il_commento_e_stato_aggiunto_con_successo)),
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

  Future<List<Map<String, dynamic>>> _fetchComments(int postId) async {
    try {
      //use edge function get_comments_for_post
      final comments = await supabase.rpc('get_comments_for_post',params:  {'post_id': postId});
      userProfiles = [];
      
      if (supabase.auth.currentUser == null) {
        for (var comment in comments) {
          comment['user_profile'] = {'username': 'Anonimo', 'avatar_url': null};
        }
        return List<Map<String, dynamic>>.from(comments);
      }
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
      print('Errore nel recupero dei commenti: $error');
      return []; // Restituisci una lista vuota in caso di errore
    }
  }

  Future<void> fetchUserNames() async {
    if (supabase.auth.currentUser == null) {
      return;
    }
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

      bool isUsername = userList.contains(tagText);

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
              if(supabase.auth.currentUser == null) {
                //show toast
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).devi_essere_autenticato_per_visualizzare_il_profilo)),
                );
                return;
              }
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
                  SnackBar(content: Text(S.of(context).user_not_found)),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).an_error_occurred)),
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
    // Get the current user's ID (Supabase auth example)
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;

    return deleted ? Container() : Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          if(supabase.auth.currentUser == null){
                            //show toast
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(S.of(context).devi_essere_autenticato_per_visualizzare_il_profilo)),
                            );
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleUserPage(
                                userId: widget.userId,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: avatarUrl != null &&
                                      avatarUrl!.isNotEmpty
                                  ? NetworkImage(avatarUrl!)
                                  : const AssetImage('assets/logos/small_logo.png')
                                      as ImageProvider,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              userName ?? S.of(context).anonimo,
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
                        color: hasLiked ? Colors.red : Colors.black,
                      ),
                      onPressed: () => _toggleLike(widget.postId),
                    ),
                    const SizedBox(width: 16),
                    Text('$_currentCommentNumber'),
                    IconButton(
                      icon: const Icon(Icons.comment_outlined,
                          color: Colors.black),
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
            // Add the trash icon if the post belongs to the current user
            if (widget.canBeEliminated &&
                currentUserId != null &&
                currentUserId == widget.userId)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    _showDeleteConfirmationDialog();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to show a confirmation dialog before deleting
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).conferma_eliminazione),
          content: Text(S.of(context).vuoi_veramente_eliminare_il_post),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close dialog
              },
              child: Text(S.of(context).annulla),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();  // Close dialog
                await _deletePost(widget.postId);  // Call the delete function
              },
              child: Text(S.of(context).elimina),
            ),
          ],
        );
      },
    );
  }

  // Function to delete the post
  Future<void> _deletePost(int postId) async {
    // Example delete operation, update this with your actual delete logic
    await Supabase.instance.client
        .from('posts')
        .delete()
        .eq('id', postId);


    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).post_eliminato)),
    );
    setState(() {
      // Hide the post from the UI
      deleted = true;
    });
  }

}

Future<String?> _fetchUserIdByUsername(String username) async {
  if(supabase.auth.currentUser == null) {
    return null;
  }
  final response = await supabase
      .from('profiles') // Replace with your actual users table
      .select('id')
      .eq('username', username)
      .single();

  return response['id'].toString();
}
