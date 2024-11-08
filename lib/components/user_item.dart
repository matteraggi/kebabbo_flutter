import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/pages/single_user_page.dart';

class UserItem extends StatefulWidget {
  final String userId;
  final String username;
  final String avatarUrl;

  const UserItem(
      {super.key,
      required this.userId,
      required this.username,
      required this.avatarUrl});

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  void initState() {
    super.initState();
  }

  void _navigateToUserPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleUserPage(userId: widget.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: _navigateToUserPage,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: widget.avatarUrl.isNotEmpty
                ? NetworkImage(widget.avatarUrl)
                : const AssetImage('assets/default_avatar.png')
                    as ImageProvider,
          ),
          title: Text(widget.username),
        ),
      ),
    ));
  }
}
