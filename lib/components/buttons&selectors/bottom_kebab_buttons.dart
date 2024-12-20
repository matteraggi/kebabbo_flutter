import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomButtonItem extends StatefulWidget {
  final String linkMaps;
  final IconData icon;
  final bool isFront;

  const BottomButtonItem({
    super.key,
    required this.linkMaps,
    required this.icon,
    required this.isFront,
  });

  @override
  State<BottomButtonItem> createState() => _BottomButtonItemState();
}

class _BottomButtonItemState extends State<BottomButtonItem> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _launchMaps,
      icon: Icon(
        widget.icon,
        color: widget.isFront ? Colors.black : Colors.white,
        size: 30,
      ),
    );
  }

  void _launchMaps() async {
    final Uri url = Uri.parse(widget.linkMaps);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}