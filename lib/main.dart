import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/medal_popup.dart';
import 'package:kebabbo_flutter/pages/account/account_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/feet_page.dart';
import 'package:kebabbo_flutter/pages/account/login_page.dart';
import 'package:kebabbo_flutter/pages/misc/map_page.dart';
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

const Color red = Color.fromRGBO(187, 0, 0, 1.0);
const Color yellow = Color.fromRGBO(255, 186, 28, 1.0);
 
Future<void> main() async {
  await Supabase.initialize(
      url: "https://ntrxsuhmslsvlflwbizb.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50cnhzdWhtc2xzdmxmbHdiaXpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg3OTAwNzYsImV4cCI6MjAzNDM2NjA3Nn0.lJ9AUgZteiVE7DVTLBCf7mUs5HhUK9EpefB9hIHeEFI");

  String? reviewHash;
  if (Uri.base.pathSegments.isNotEmpty &&
      Uri.base.pathSegments[0] == 'reviews') {
    reviewHash = Uri.base.pathSegments[1];
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

  runApp(MyApp(reviewHash: reviewHash));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  final String? reviewHash;

  const MyApp({super.key, this.reviewHash});

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
      home: MyHomePage(reviewHash: reviewHash), // Set MyHomePage as the home
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
  String? reviewHash;

  MyHomePage({super.key, this.reviewHash});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 2; // Home page by default
  final ValueNotifier<Position?> _currentPositionNotifier =
      ValueNotifier<Position?>(null);
  late Stream<Position> _positionStream;

  final GlobalKey<MapPageState> _mapPageKey = GlobalKey<MapPageState>();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpen();
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

    if (isFirstTime) {
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
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition();
      _currentPositionNotifier.value = position;
      if (selectedIndex == 3 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    if (widget.reviewHash != null) {
      // Handle Review Page
      page = ReviewPage(
        hash: widget.reviewHash!,
      );
    } else {
      // Standard navigation based on selectedIndex
      switch (selectedIndex) {
        case 0:
          page = const FeedPage();
          break;
        case 1:
          page = SearchPage();
          break;
        case 2:
          page = ValueListenableBuilder<Position?>(
            valueListenable: _currentPositionNotifier,
            builder: (context, currentPosition, child) {
              return TopKebabPage(currentPosition: currentPosition);
            },
          );
          break;
        case 3:
          page = MapPage(
            initialPosition: _currentPositionNotifier.value,
            key: _mapPageKey,
          );
          break;
        case 4:
          page = supabase.auth.currentSession ==
                  null // add function to update selected index
              ? LoginPage(authCallback: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                })
              : AccountPage(currentPosition: _currentPositionNotifier.value);
          break;
        default:
          throw UnimplementedError('No widget for $selectedIndex');
      }
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            widget.reviewHash =
                null; // Reset reviewHash so the nav bar takes control
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
}
