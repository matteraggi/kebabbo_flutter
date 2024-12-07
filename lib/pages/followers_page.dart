import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/user_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class FollowersPage extends StatefulWidget {
  final String userId;

  const FollowersPage({super.key, required this.userId});

  @override
  FollowersPageState createState() => FollowersPageState();
}

class FollowersPageState extends State<FollowersPage> {
  List<Map<String, dynamic>> followers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFollowers(widget.userId);
  }

  Future<void> _fetchFollowers(String userId) async {
    try {
      // Recupera tutti i profili che hanno l'userId nel campo 'followed_users'
      final response = await supabase
          .from('profiles')
          .select('id, username, avatar_url')
          .contains('followed_users', [userId]);

      setState(() {
        followers = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(S.of(context).errore_nel_caricamento_dei_follower)),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : followers.isEmpty
              ? Center(child: Text(S.of(context).nessun_utente_ti_segue))
              : ListView.builder(
                  itemCount: followers.length,
                  itemBuilder: (context, index) {
                    final follower = followers[index];
                    return UserItem(
                        userId: follower["id"].toString(),
                        username: follower["username"].toString(),
                        avatarUrl: follower["avatar_url"].toString());
                  },
                ),
    );
  }
}
