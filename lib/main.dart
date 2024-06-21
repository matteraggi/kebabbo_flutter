import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kebabbo_flutter/pages/about_page.dart';
import 'package:kebabbo_flutter/pages/account_page.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:kebabbo_flutter/pages/map_page.dart';
import 'package:kebabbo_flutter/pages/special_page.dart';
import 'package:kebabbo_flutter/pages/top_kebab_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Color red = Color.fromRGBO(187, 0, 0, 1.0);
Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

Future<void> main() async {
  await dotenv.load(fileName: "process.env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception("Supabase URL and Anon Key must be set in .env file");
  }

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
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
        page = MapPage();
      case 3:
        page = TopKebabPage();
      case 4:
        page = SpecialPage();
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
            icon: Icon(Icons.zoom_out_map),
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
