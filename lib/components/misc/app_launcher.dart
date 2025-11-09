// lib/components/misc/app_launcher.dart

// This conditionally exports the correct implementation
export 'app_launcher_mobile.dart' // For Mobile (Android/iOS)
    if (dart.library.html) 'app_launcher_web.dart'; // For Web