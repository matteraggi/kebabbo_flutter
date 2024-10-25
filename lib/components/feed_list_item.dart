import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart' as timeago_it;

class FeedListItem extends StatefulWidget {
  final String text;
  final String createdAt;
  final String userId;

  const FeedListItem({
    super.key,
    required this.text,
    required this.createdAt,
    required this.userId,
  });

  @override
  _FeedListItemState createState() => _FeedListItemState();
}

class _FeedListItemState extends State<FeedListItem> {
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(widget.userId);
    timeago_it.setLocaleMessages('it', timeago_it.ItMessages());
  }

  Future<void> _fetchUserProfile(String userId) async {
    try {
      final response = await supabase
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .single();

      print(response);
      
      setState(() {
        userName = response['username']; // Imposta il nome dell'utente
        isLoading = false; // Segnala che il caricamento è completato
      });
    } catch (error) {
      setState(() {
        userName = 'Anonimo'; // In caso di errore, mostra 'Anonimo'
        isLoading = false;
      });
    }
  }

    String _formatTimestamp(String createdAt) {
    // Converti la stringa in DateTime
    final DateTime postDate = DateTime.parse(createdAt);
    // Usa la libreria timeago con il locale italiano
    return timeago.format(postDate, locale: 'it'); // Locale italiano
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostra un indicatore di caricamento finché il nome non è disponibile
            isLoading
                ? const CircularProgressIndicator() 
                : Text(
                    userName ?? 'Anonimo',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 8),
            Text(widget.text),
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
