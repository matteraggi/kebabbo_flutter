// lib/components/misc/app_launcher_web.dart
// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;

void openApp() {
  // This is your original code
  // Se l'app non è installata, Chrome apre il Play Store (browser_fallback_url).
  html.window.location.href =
      'intent://kebabbo.top/#Intent;scheme=https;package=com.canny.kebabbologna;'
      'S.browser_fallback_url=https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.canny.kebabbologna;end';
}
