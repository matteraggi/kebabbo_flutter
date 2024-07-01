import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/pages/about_page.dart';
import 'package:kebabbo_flutter/pages/account_page.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:kebabbo_flutter/pages/map_page.dart';
import 'package:kebabbo_flutter/pages/special_page.dart';
import 'package:kebabbo_flutter/pages/top_kebab_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

Color red = Color.fromRGBO(187, 0, 0, 1.0);
Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

Future<void> main() async {
  /*
  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception("Supabase URL and Anon Key must be set in .env file");
  }
  */

  await Supabase.initialize(
      url: "https://ntrxsuhmslsvlflwbizb.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50cnhzdWhtc2xzdmxmbHdiaXpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg3OTAwNzYsImV4cCI6MjAzNDM2NjA3Nn0.lJ9AUgZteiVE7DVTLBCf7mUs5HhUK9EpefB9hIHeEFI");
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kebabbo',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: yellow,
        primaryColor: red,
        appBarTheme: AppBarTheme(
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
      home: MyHomePage(),
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
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 2;
  Position? _currentPosition;
  late Stream<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    _positionStream.listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
      // Se la pagina corrente è la mappa, aggiorna la posizione
      if (selectedIndex == 2) {
        (context
            .findAncestorWidgetOfExactType<MapPage>()
            ?.updatePosition(position));
      }
    });
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      if (selectedIndex == 2) {
        (context
            .findAncestorWidgetOfExactType<MapPage>()
            ?.updatePosition(position));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page =
            supabase.auth.currentSession == null ? LoginPage() : AccountPage();
      case 1:
        page = AboutPage();
      case 2:
        page = MapPage(
          currentPosition: _currentPosition,
        );
      case 3:
        page = TopKebabPage(currentPosition: _currentPosition!);
      case 4:
        page = SpecialPage(currentPosition: _currentPosition);
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kebab_dining),
            label: 'Top Kebab',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_play_rounded),
            label: 'Special',
          ),
        ],
        backgroundColor: red, // Colore di sfondo della navbar
        selectedItemColor: yellow,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
