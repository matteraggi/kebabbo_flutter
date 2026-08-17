// lib/components/misc/app_launcher_web.dart
// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;

void openApp() {
  // This is your original code
  html.window.location.href =
      'intent://kebabbo.top/path#Intent;scheme=https;package=com.canny.kebabbologna;end';
}
