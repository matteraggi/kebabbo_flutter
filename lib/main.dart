import 'dart:async';
// <── Aggiunto
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/medal_popup.dart';
import 'package:kebabbo_flutter/pages/account/account_page.dart';
import 'package:kebabbo_flutter/pages/account/reset_password.dart';
import 'package:kebabbo_flutter/pages/feed&socials/feet_page.dart';
import 'package:kebabbo_flutter/pages/account/login_page.dart';
import 'package:kebabbo_flutter/pages/misc/map_page.dart';
import 'package:kebabbo_flutter/pages/misc/privacy_policy.dart';
import 'package:kebabbo_flutter/pages/feed&socials/games_page.dart';
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
import 'firebase_options.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);
const Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
const firebaseKey = String.fromEnvironment('FIREBASE_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    debugPrint('⚠️ ATTENZIONE: variabili SUPABASE mancanti nel file .env');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  String? otherPaths;

  // Handle deep links based on URL path
  if (kIsWeb) {
    try {
      if (Uri.base.pathSegments.isNotEmpty) {
        if (Uri.base.pathSegments[0] == 'privacy-policy') {
          otherPaths = "privacy-policy";
        } else if (Uri.base.pathSegments[0] == 'reset-password') {
          otherPaths = "reset-password";
        }
      }
    } catch (e) {
      debugPrint("Error reading Uri.base: $e");
    }
  }



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  runApp(MyApp(otherPaths: otherPaths));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  final String? otherPaths;

  const MyApp({super.key, this.otherPaths});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kebabbo',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: yellow,
        primaryColor: red,
        appBarTheme: const AppBarTheme(backgroundColor: yellow),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: red),
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
        otherPaths: otherPaths,
      ), // Set MyHomePage as the home
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
  final String? otherPaths;

  const MyHomePage({super.key, this.otherPaths});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? otherPaths; // Now a mutable state variable

  var selectedIndex = 2; // Home page by default
  final ValueNotifier<Position?> _currentPositionNotifier =
      ValueNotifier<Position?>(null);
  late Stream<Position> _positionStream;

  final GlobalKey<MapPageState> _mapPageKey = GlobalKey<MapPageState>();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    otherPaths = widget.otherPaths;
    _checkFirstTimeOpen();
    _checkIfAppInstalled();
    _getLocation();
    if (!kIsWeb) {
      requestNotificationPermissions(
        _messaging,
      ); // Request notification permissions
      registerNotificationListeners(context);
    } // Register notification listeners

    // Listener globale per intercettare errori di refresh del token e forzare il signOut
    _authSubscription = supabase.auth.onAuthStateChange.listen(
      (data) {},
      onError: (error) async {
        debugPrint('Auth stream error intercepted: $error');
        // Valvola di sicurezza: se il refresh fallisce, facciamo un signOut pulito
        await supabase.auth.signOut();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sessione scaduta. Effettua nuovamente il login.'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );

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
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // If service is disabled, set position to null and show a message.
        _currentPositionNotifier.value = null;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location services are disabled.')),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        // If permission is still denied after asking, we will throw an error
        // that our catch block will handle.
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // If we have permission, get the location
      Position position = await Geolocator.getCurrentPosition();
      _currentPositionNotifier.value = position;

      // This part remains the same, to update pages that are already built
      if (selectedIndex == 3 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
      }
    } catch (e) {
      // If any error occurs (denied permission, etc.), set position to null
      // and show the error message.
      _currentPositionNotifier.value = null;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
      debugPrint("Error getting location: $e");
    }
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  Future<void> _checkIfAppInstalled() async {
    if (!kIsWeb) return; // Only check on web!

    String appUrl =
        'intent://kebabbo.top/path#Intent;scheme=https;package=com.canny.kebabbologna;end';

    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        if (await canLaunchUrl(Uri.parse(appUrl))) {
          await launchUrl(Uri.parse(appUrl));
        } else {
          if (!mounted) return;
          showAppInstallDialog(context);
        }
      } catch (e) {
        if (!mounted) return;
        showAppInstallDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    if (otherPaths != null) {
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
      body: mounted ? page : Container(), // Wraps the page,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            otherPaths = null; // Reset policy
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: S.of(context).seguiti,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kebab_dining),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: S.of(context).mappa,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
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
        return GamesPage(currentPosition: _currentPositionNotifier.value);
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
              return LoginPage(
                authCallback: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            } else {
              return AccountPage(
                currentPosition: _currentPositionNotifier.value,
              );
            }
          },
        );

      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }
  }

  Widget _buildDefaultPage() {
    // Return a default widget for when otherPaths is not null but doesn't match known paths
    return const Center(
      child: Text("Page Not Found"),
    ); // Or any other appropriate default
  }
}
