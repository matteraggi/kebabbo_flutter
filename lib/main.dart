import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/misc/medal_popup.dart';
import 'package:kebabbo_flutter/pages/account/account_page.dart';
import 'package:kebabbo_flutter/pages/feed&socials/feed_page.dart';
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
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('it', ''), // Italian
        const Locale('es', ''), // Spanish
        const Locale('fr', ''), // French
        const Locale('de', ''), // German
        const Locale('pt', ''), // Portuguese
      ],
      // Locale resolution for user-preferred language
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
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
  var selectedIndex = 2;
  final ValueNotifier<Position?> _currentPositionNotifier =
      ValueNotifier<Position?>(null);
  late Stream<Position> _positionStream;

  final GlobalKey<MapPageState> _mapPageKey = GlobalKey<MapPageState>();

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpen(); 
    _getLocation();
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
      // Show the dialog if it's the first time
      showFirstTimeDialog(context);
      // Set isFirstTime to false so the dialog won't show again
      prefs.setBool('isFirstTime', false);
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _currentPositionNotifier.value = null;
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _currentPositionNotifier.value = null;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _currentPositionNotifier.value = null;
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _currentPositionNotifier.value = position;
    if (selectedIndex == 3 && _mapPageKey.currentState != null) {
      _mapPageKey.currentState!.updatePosition(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    // Show ReviewPage if there's a reviewHash, otherwise use selectedIndex
    if (widget.reviewHash != null) {
      page = ReviewPage(
        hash: widget.reviewHash!,
      );
    } else {
      // Use selectedIndex to set the page based on the current tab
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
          page = supabase.auth.currentSession == null
              ? const LoginPage()
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
