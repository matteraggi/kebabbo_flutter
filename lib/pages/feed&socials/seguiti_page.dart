import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/user_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class SeguitiPage extends StatefulWidget {
  final String userId;

  const SeguitiPage({super.key, required this.userId});

  @override
  SeguitiPageState createState() => SeguitiPageState();
}

class SeguitiPageState extends State<SeguitiPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> followedUsersProfiles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFollowedUsers();
  }

  Future<void> _fetchFollowedUsers() async {
    try {
      // Recupera gli ID degli utenti seguiti
      final profileResponse = await supabase
          .from('profiles')
          .select('followed_users')
          .eq('id', widget.userId)
          .single();

      List<String> followedUsers =
          List<String>.from(profileResponse['followed_users'] ?? []);

      if (followedUsers.isNotEmpty) {
        // Costruisce la condizione "or" per selezionare i profili degli utenti seguiti
        final String orCondition =
            followedUsers.map((userId) => 'id.eq.$userId').join(',');

        final profilesResponse = await supabase
            .from('profiles')
            .select('id, username, avatar_url')
            .or(orCondition);

        setState(() {
          followedUsersProfiles =
              List<Map<String, dynamic>>.from(profilesResponse as List);
          isLoading = false;
        });
      } else {
        setState(() {
          followedUsersProfiles = [];
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Errore nel recupero dei seguiti: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).seguiti),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : followedUsersProfiles.isEmpty
              ? Center(child: Text(S.of(context).nessun_utente_seguito))
              : ListView.builder(
                  itemCount: followedUsersProfiles.length,
                  itemBuilder: (context, index) {
                    final user = followedUsersProfiles[index];
                    return UserItem(
                      userId: user['id'].toString(),
                      username: user['username'].toString(),
                      avatarUrl: user['avatar_url'].toString(),
                    );
                  },
                ),
    );
  }
}
