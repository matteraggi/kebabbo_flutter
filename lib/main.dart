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
import 'package:kebabbo_flutter/pages/kebab/add_new_kebab_page.dart';
import 'package:kebabbo_flutter/pages/reviews/write_review_page.dart';
import 'package:kebabbo_flutter/pages/kebab/top_kebab_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kebabbo_flutter/utils/notifications.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);
const Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
const firebaseKey = String.fromEnvironment('FIREBASE_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerTimeagoLocales();

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
      // Scorre tutte le lingue preferite del dispositivo (non solo la prima):
      // es. [el, it] -> italiano. Se nessuna è supportata, inglese.
      localeListResolutionCallback: (locales, supportedLocales) {
        for (final locale in locales ?? const <Locale>[]) {
          for (final supported in supportedLocales) {
            if (supported.languageCode == locale.languageCode) {
              return supported;
            }
          }
        }
        return const Locale('en', '');
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

  var selectedIndex = 0; // Home page by default
  final ValueNotifier<Position?> _currentPositionNotifier =
      ValueNotifier<Position?>(null);
  StreamSubscription<Position>? _positionSubscription;

  final GlobalKey<MapPageState> _mapPageKey = GlobalKey<MapPageState>();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    otherPaths = widget.otherPaths;
    _showStartupDialogs();
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
              content: Text(S.of(context).session_expired),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );

  }

  // Avviato solo dopo aver ottenuto il permesso: altrimenti lo stream emette
  // un errore non gestito (PermissionDeniedException).
  void _startPositionStream() {
    _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen(
      (Position position) {
        _currentPositionNotifier.value = position;
        if (selectedIndex == 1 && _mapPageKey.currentState != null) {
          _mapPageKey.currentState!.updatePosition(position);
        }
      },
      onError: (e) => debugPrint('Position stream error: $e'),
    );
  }

  // Al massimo un dialog per visita: benvenuto alla prima apertura,
  // altrimenti (solo web su Android) l'invito ad aprire l'app.
  Future<void> _showStartupDialogs() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Salvato prima di mostrare il dialog, così non riappare se l'app
      // viene chiusa con il dialog aperto.
      await prefs.setBool('isFirstTime', false);
      if (!mounted) return;
      showFirstTimeDialog(context);
      return;
    }

    await _maybeShowOpenInAppPrompt(prefs);
  }

  static const _openInAppPromptKey = 'openInAppPromptShownAt';

  Future<void> _maybeShowOpenInAppPrompt(SharedPreferences prefs) async {
    // Un sito web non può sapere se l'app è installata: proponiamo di aprirla
    // (con fallback al Play Store) al massimo una volta ogni 14 giorni.
    if (!kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    if (otherPaths != null) return; // es. reset password / privacy policy

    final now = DateTime.now().millisecondsSinceEpoch;
    final lastShown = prefs.getInt(_openInAppPromptKey);
    if (lastShown != null &&
        now - lastShown < const Duration(days: 14).inMilliseconds) {
      return;
    }
    await prefs.setInt(_openInAppPromptKey, now);
    if (!mounted) return;
    showAppInstallDialog(context);
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // If service is disabled, set position to null and show a message.
        _currentPositionNotifier.value = null;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).location_services_disabled)),
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
          if (!mounted) return;
          _showLocationError(S.of(context).location_permission_denied);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        _showLocationError(S.of(context).location_permission_denied_forever);
        return;
      }

      // If we have permission, get the location
      _startPositionStream();
      Position position = await Geolocator.getCurrentPosition();
      _currentPositionNotifier.value = position;

      // This part remains the same, to update pages that are already built
      if (selectedIndex == 1 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
      }
    } catch (e) {
      // If any error occurs, set position to null.
      _currentPositionNotifier.value = null;
      debugPrint("Error getting location: $e");
    }
  }

  void _showLocationError(String message) {
    _currentPositionNotifier.value = null;
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    _positionSubscription?.cancel();
    _currentPositionNotifier.dispose();
    super.dispose();
  }

  void _showContributeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                S.of(context).contribute_title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                S.of(context).contribute_subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              // Bottone 1: Aggiungi Nuovo Kebabbaro
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddNewKebabPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: red.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.add_location_alt_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).add_kebab_place,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              S.of(context).add_kebab_place_subtitle,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.white70, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Bottone 2: Scrivi una Recensione
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WriteReviewPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF232526),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.rate_review_outlined,
                          color: Color(0xFFFFBA1C),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).write_review_title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              S.of(context).write_review_subtitle,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.white70, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        );
      },
    );
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
          if (index == 2) {
            _showContributeSheet(context);
            return;
          }
          setState(() {
            selectedIndex = index;
            otherPaths = null; // Reset policy
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.kebab_dining),
            label: S.of(context).nav_home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: S.of(context).mappa,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: yellow,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: red, size: 22),
            ),
            label: S.of(context).nav_add,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.comment),
            label: S.of(context).nav_feed,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: S.of(context).nav_account,
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
        return ValueListenableBuilder<Position?>(
          valueListenable: _currentPositionNotifier,
          builder: (context, currentPosition, child) {
            return TopKebabPage(currentPosition: currentPosition);
          },
        );
      case 1:
        return MapPage(
          initialPosition: _currentPositionNotifier.value,
          key: _mapPageKey,
        );
      case 2:
        return ValueListenableBuilder<Position?>(
          valueListenable: _currentPositionNotifier,
          builder: (context, currentPosition, child) {
            return TopKebabPage(currentPosition: currentPosition);
          },
        );
      case 3:
        return const FeedPage();
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
    return Center(
      child: Text(S.of(context).page_not_found),
    ); // Or any other appropriate default
  }
}
