// lib/components/misc/app_launcher_mobile.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openApp() async {
  final uri = Uri.parse(
      'intent://kebabbo.top/path#Intent;scheme=https;package=com.canny.kebabbologna;end');

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch app intent.');
    // You could add a fallback here to open your website
    // await launchUrl(Uri.parse('https://kebabbologna.com/'));
  }
}
