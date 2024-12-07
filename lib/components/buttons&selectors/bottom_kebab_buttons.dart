import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomButtonItem extends StatelessWidget {
  final String linkMaps;
  final IconData icon;
  bool isFront;

  BottomButtonItem(
      {super.key,
      required this.linkMaps,
      required this.icon,
      required this.isFront});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _launchMaps,
      icon: Icon(
        icon,
        color: isFront ? Colors.black : Colors.white,
        size: 30,
      ), // Icona con colore a tua scelta
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
