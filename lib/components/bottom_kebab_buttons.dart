import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomButtonItem extends StatelessWidget {
  final String linkMaps;
  final String text;
  final IconData icon;

  const BottomButtonItem({required this.linkMaps, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _launchMaps,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }

  void _launchMaps() async {
    final Uri url = Uri.parse(linkMaps);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
