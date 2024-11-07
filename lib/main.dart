import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/pages/account_page.dart';
import 'package:kebabbo_flutter/pages/feed_page.dart';
import 'package:kebabbo_flutter/pages/login_page.dart';
import 'package:kebabbo_flutter/pages/map_page.dart';
import 'package:kebabbo_flutter/pages/review_page.dart'; // Import ReviewPage
import 'package:kebabbo_flutter/pages/search_page.dart';
import 'package:kebabbo_flutter/pages/top_kebab_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);
const Color yellow = Color.fromRGBO(255, 186, 28, 1.0);

Future<void> main() async {
  await Supabase.initialize(
      url: "https://ntrxsuhmslsvlflwbizb.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50cnhzdWhtc2xzdmxmbHdiaXpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg3OTAwNzYsImV4cCI6MjAzNDM2NjA3Nn0.lJ9AUgZteiVE7DVTLBCf7mUs5HhUK9EpefB9hIHeEFI");
  
  String? reviewHash;
  if (Uri.base.pathSegments.isNotEmpty && Uri.base.pathSegments[0] == 'reviews') {
    reviewHash = Uri.base.pathSegments[1];
    print('reviewHash: $reviewHash');
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
  Position? _currentPosition;
  late Stream<Position> _positionStream;

  final GlobalKey<MapPageState> _mapPageKey = GlobalKey<MapPageState>();

  @override
  void initState() {
    super.initState();
    _getLocation();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    _positionStream.listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
      if (selectedIndex == 3 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
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
      if (selectedIndex == 3 && _mapPageKey.currentState != null) {
        _mapPageKey.currentState!.updatePosition(position);
      }
    });
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
        page = supabase.auth.currentSession == null
            ? const LoginPage()
            : AccountPage(currentPosition: _currentPosition);
        break;
      case 1:
        page = SearchPage();
        break;
      case 2:
        page = _currentPosition != null
            ? TopKebabPage(currentPosition: _currentPosition!)
            : const Center(child: CircularProgressIndicator());
        break;
      case 3:
        page = MapPage(
          initialPosition: _currentPosition,
          key: _mapPageKey,
        );
        break;
      case 4:
        page = const FeedPage();
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
          widget.reviewHash = null;  // Reset reviewHash so the nav bar takes control
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.kebab_dining),
          label: 'Top Kebab',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.comment),
          label: 'Followed',
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