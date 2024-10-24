import 'package:flutter/material.dart';

class FeedListItem extends StatelessWidget {
  final String text;
  final String createdAt;

  const FeedListItem({
    Key? key,
    required this.text,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text(text),
        trailing: Text(createdAt),
      ),
    );
  }
}
