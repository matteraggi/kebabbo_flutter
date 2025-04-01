import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/medal_popup.dart';
import 'package:kebabbo_flutter/pages/account/account_page.dart';
import 'package:kebabbo_flutter/pages/account/reset_password.dart';
import 'package:kebabbo_flutter/pages/feed&socials/feet_page.dart';
import 'package:kebabbo_flutter/pages/account/login_page.dart';
import 'package:kebabbo_flutter/pages/misc/map_page.dart';
import 'package:kebabbo_flutter/pages/misc/privacy_policy.dart';
import 'package:kebabbo_flutter/pages/reviews/review_page.dart'; // Import ReviewPage
import 'package:kebabbo_flutter/pages/feed&socials/search_page.dart';
import 'package:kebabbo_flutter/pages/kebab/top_kebab_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kebabbo_flutter/utils/notifications.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:url_launcher/url_launcher.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);
const Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

Future<void> main() async {
  await Supabase.initialize(
      url: "https://ntrxsuhmslsvlflwbizb.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50cnhzdWhtc2xzdmxmbHdiaXpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg3OTAwNzYsImV4cCI6MjAzNDM2NjA3Nn0.lJ9AUgZteiVE7DVTLBCf7mUs5HhUK9EpefB9hIHeEFI");

  String? reviewHash;
  String? otherPaths;

  // Handle deep links based on URL path
  if (Uri.base.pathSegments.isNotEmpty) {
    if (Uri.base.pathSegments[0] == 'reviews') {
      reviewHash = Uri.base.pathSegments[1];
    } else if (Uri.base.pathSegments[0] == 'privacy-policy') {
      otherPaths = "privacy-policy";
    } else if (Uri.base.pathSegments[0] == 'reset-password') {
      otherPaths = "reset-password";
    }
  }

  WidgetsFlutterBinding.ensureInitialized();

  // Web-specific initialization using FirebaseOptions
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDs2C7PvgXSUgCGoy7OcAGm55hlpbGtFVI",
          authDomain: "kebabbo-669ea.firebaseapp.com",
          projectId: "kebabbo-669ea",
          storageBucket: "kebabbo-669ea.firebasestorage.app",
          messagingSenderId: "12309724529",
          appId: "1:12309724529:web:c84bf69f2af9846fee4ad0",
          measurementId: "G-Z2YEVGGKTF"),
    );
  } else {
    // Mobile initialization (Android/iOS)
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(MyApp(reviewHash: reviewHash, otherPaths: otherPaths));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  final String? reviewHash;
  final String? otherPaths;

  const MyApp({super.key, this.reviewHash, this.otherPaths});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kebabbo',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: yellow,
        primaryColor: red,
        appBarTheme: const AppBarTheme(
          backgroundColor: yellow,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: red,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: red,
          ),
        ),
      ),
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it', ''), // Italian
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
        Locale('fr', ''), // French
        Locale('de', ''), // German
        Locale('pt', ''), // Portuguese
      ],
      // Locale resolution to prefer system language
      localeResolutionCallback: (locale, supportedLocales) {
        return supportedLocales.firstWhere(
          (supportedLocale) =>
              supportedLocale.languageCode == locale?.languageCode,
          orElse: () => supportedLocales.first,
        );
      },
      home: MyHomePage(
          reviewHash: reviewHash,
          otherPaths: otherPaths), // Set MyHomePage as the home
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? reviewHash;
  final String? otherPaths;

  const MyHomePage({super.key, this.reviewHash, this.otherPaths});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? reviewHash; // Now a mutable state variable
  String? otherPaths; // Now a mutable state variable

  var selectedIndex = 2; // Home page by default
  final ValueNotifier<Position?> _currentPositionNotifier =
      ValueNotifier<Position?>(null);
  late Stream<Position> _positionStream;

  final GlobalKey<MapPageState> _mapPageKey = GlobalKey<MapPageState>();
  final GlobalKey<ReviewPageState> _reviewsPageKey =
      GlobalKey<ReviewPageState>();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    reviewHash = widget.reviewHash;
    otherPaths = widget.otherPaths;
    _checkFirstTimeOpen();
    _checkIfAppInstalled();
    _getLocation();
    if (!kIsWeb) {
      requestNotificationPermissions(
          _messaging); // Request notification permissions
      registerNotificationListeners(context);
    } // Register notification listeners

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    _positionStream.listen((Position position) {
      _currentPositionNotifier.value = position;
      if (selectedIndex == 3 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
      }
    });
  }

  Future<void> _checkFirstTimeOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime && mounted) {
      // Show first-time dialog
      showFirstTimeDialog(context);
      prefs.setBool('isFirstTime', false);
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled || permission == LocationPermission.deniedForever) {
      _currentPositionNotifier.value = null;
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Location services are disabled.')));
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.denied) {
      print('Getting current location...');
      Position position = await Geolocator.getCurrentPosition();
      _currentPositionNotifier.value = position;
      if (selectedIndex == 3 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
      }
      if (_reviewsPageKey.currentState != null) {
        _reviewsPageKey.currentState!.updatePosition(position);
      }
    }
  }

  Future<void> _checkIfAppInstalled() async {
    String appUrl =
        'intent://kebabbologna/path#Intent;scheme=https;package=com.canny.kebabbologna;end';

    if (!kIsWeb && Platform.isAndroid) {
      // Check for Android *and* not web
      if (await canLaunchUrl(Uri.parse(appUrl))) {
        // App is likely installed, but let's try to launch it just in case:
        await launchUrl(Uri.parse(appUrl));
      } else {
        //App is not installed
        showAppInstallDialog(context);
      }
    }
  }

@override
Widget build(BuildContext context) {
  Widget page;

  if (reviewHash != null) {
    // Handle Review Page
    page = ReviewPage(
      hash: reviewHash!,
      initialPosition: _currentPositionNotifier.value,
      key: _reviewsPageKey,
    );
  } else if (otherPaths != null) {
    // Check if otherPaths is NOT null BEFORE comparing it
    if (otherPaths == "privacy-policy") {
      // Handle Privacy Policy Page
      page = PrivacyPolicyPage();
    } else if (otherPaths == "reset-password") {
      // Handle Reset Password Page
      page = ResetPasswordForm();
    } else {
      // Handle other possible paths or show a default page
      page = _buildDefaultPage(); // Or another appropriate default
    }
  } else {
    // Standard navigation based on selectedIndex
    page = _buildStandardNavigationPage();
  }


    return Scaffold(
      body: mounted ? page : Container(), // Wrap the page,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            reviewHash = null; // Reset reviewHash so the nav bar takes control
            otherPaths = null; // Reset policy
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: S.of(context).seguiti,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: S.of(context).esplora,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kebab_dining),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: S.of(context).mappa,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        backgroundColor: red,
        selectedItemColor: yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }


Widget _buildStandardNavigationPage() {
  switch (selectedIndex) {
    case 0:
      return const FeedPage();
    case 1:
      return SearchPage();
    case 2:
      return ValueListenableBuilder<Position?>(
        valueListenable: _currentPositionNotifier,
        builder: (context, currentPosition, child) {
          return TopKebabPage(currentPosition: currentPosition);
        },
      );
    case 3:
      return MapPage(
        initialPosition: _currentPositionNotifier.value,
        key: _mapPageKey,
      );
    case 4:
      return StreamBuilder<AuthState>(
  stream: supabase.auth.onAuthStateChange,
  builder: (context, snapshot) {
    final session = supabase.auth.currentSession;

    if (session == null) {
      return LoginPage(authCallback: (int index) {
        setState(() {
          selectedIndex = index;
        });
      });
    } else {
      return AccountPage(currentPosition: _currentPositionNotifier.value);
    }
  },
);

    default:
      throw UnimplementedError('No widget for $selectedIndex');
  }
}

Widget _buildDefaultPage() {
  // Return a default widget for when otherPaths is not null but doesn't match known paths
  return const Center(child: Text("Page Not Found")); // Or any other appropriate default
}

}

