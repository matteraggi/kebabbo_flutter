// lib/components/misc/app_launcher_web.dart
import 'dart:html' as html;

void openApp() {
  // This is your original code
  html.window.location.href = 'intent://kebabbologna.com/path#Intent;scheme=https;package=com.canny.kebabbologna;end';
}