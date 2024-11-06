import 'package:flutter/material.dart';

class FollowersPage extends StatelessWidget {
  final String userId;

  const FollowersPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguiti'),
      ),
      body: Center(
        child: Text(
          'ID utente: $userId',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
