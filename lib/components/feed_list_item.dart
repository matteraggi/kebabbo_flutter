import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_it;

class FeedListItem extends StatefulWidget {
  final String text;
  final String createdAt;
  final String userId;
  final String imageUrl;
  final String postId;
  final List<dynamic> likeList;

  const FeedListItem({
    super.key,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.imageUrl,
    required this.postId,
    required this.likeList,
  });

  @override
  _FeedListItemState createState() => _FeedListItemState();
}

class _FeedListItemState extends State<FeedListItem> {
  String? userName;
  String? avatarUrl;
  bool isLoading = true;
  bool hasLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(widget.userId);
    _checkIfLiked();
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
      // Ottieni l'ID dell'utente attualmente autenticato
      final userId = supabase.auth.currentSession!.user.id;

      // Controlla se l'ID utente è presente nella lista dei like
      bool userLiked = widget.likeList.contains(userId);

      // Aggiorna lo stato
      if (mounted) {
        setState(() {
          hasLiked = userLiked;
          likeCount = widget.likeList
              .length; // Il conteggio dei like è semplicemente la lunghezza della lista
        });
      }
    } catch (error) {
      print('Errore nel controllo dei like: $error');
    }
  }

  Future<void> _toggleLike(String postId) async {
    // Ottieni l'ID dell'utente attualmente autenticato
    final userId = supabase.auth.currentSession!.user.id;

    // Crea una copia della lista dei like attuale
    final updatedLikes = List<String>.from(widget.likeList);

    // Verifica se l'utente ha già messo "mi piace" al post
    if (hasLiked) {
      updatedLikes.remove(userId);
      // Riduci il conteggio dei like di 1
      likeCount--;
    } else {
      updatedLikes.add(userId);
      // Aumenta il conteggio dei like di 1
      likeCount++;
    }

    try {
      // Aggiorna il database con la nuova lista di like
      print("Aggiornamento dei like per $postId: $updatedLikes");
      await supabase
          .from('posts')
          .update({'like': updatedLikes}).eq('id', postId);

      // Aggiorna lo stato locale
      setState(() {
        hasLiked = !hasLiked; // Inverti lo stato di hasLiked
        // Non è più necessario aggiornare la lista manualmente, perché stiamo usando updatedLikes
      });

      // Log del nuovo stato
      print("Nuovo stato like per $postId: ${!hasLiked}");
    } catch (error) {
      print('Errore durante l\'aggiornamento dei like: $error');
    }
  }

  String _formatTimestamp(String createdAt) {
    final DateTime postDate = DateTime.parse(createdAt);
    return timeago.format(postDate, locale: 'it');
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
                : Row(
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
            const SizedBox(height: 8),
            Text(widget.text),
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
                Text("0"), // Numero dei commenti (sostituibile con variabile)
                IconButton(
                  icon: const Icon(Icons.comment_outlined, color: Colors.black),
                  onPressed: () {
                    // Logica per aprire i commenti
                  },
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
