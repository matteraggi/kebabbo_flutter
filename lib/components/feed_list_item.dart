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
  String? avatarUrl;
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

      setState(() {
        userName = response['username'] ?? 'Anonimo';
        avatarUrl = response['avatar_url'] as String?;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        userName = 'Anonimo';
        isLoading = false;
      });
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
                        backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                            ? NetworkImage(avatarUrl!)
                            : const AssetImage('images/kebab.png') as ImageProvider,
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
