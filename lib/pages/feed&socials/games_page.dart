import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/pages/reviews/add_kebab.dart';
import 'package:kebabbo_flutter/pages/tcg/carousel.dart';
import 'package:kebabbo_flutter/pages/tcg/pack_page.dart';
import 'package:kebabbo_flutter/pages/account/tools_page.dart';
import 'package:kebabbo_flutter/pages/misc/medal_page.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GamesPage extends StatefulWidget {
  final Position? currentPosition;
  const GamesPage({super.key, required this.currentPosition});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  bool _loading = true;
  List<int> _ingredients = [5, 5, 5, 5, 5];
  DateTime _lastPack = DateTime.now().toUtc();
  final supabase = Supabase.instance.client;
  String? _id;

  @override
  void initState() {
    super.initState();
    _loadPageData();
  }

  Future<void> _loadPageData() async {
    if (supabase.auth.currentUser == null) {
      setState(() => _loading = false);
      return;
    }
    _id = supabase.auth.currentUser!.id;

    try {
      final profileData = await getProfile(context);
      if (profileData != null && mounted) {
        setState(() {
          _lastPack = DateTime.parse(profileData['last_pack']).toUtc();
          _ingredients = List<int>.from(profileData['ingredients']);
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        debugPrint("Error loading game data: $e");
      }
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.remainder(12).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Helper to build the navigation buttons
  Widget _buildGameButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // Se onTap è nullo, usa un colore grigio
          color: onTap != null ? color : Colors.grey[400],
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: onTap != null ? color.withValues(alpha: 0.3) : Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.white, size: 32),
                if (trailing != null) trailing,
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Special builder for the Pack Page button with timer
  Widget _buildPackButton() {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(
          const Duration(seconds: 1), (_) => DateTime.now().toUtc()),
      builder: (context, snapshot) {
        bool isTimerActive = false;
        String timerText = "";

        if (supabase.auth.currentUser != null) {
          final now = snapshot.data ?? DateTime.now().toUtc();
          final difference = now.difference(_lastPack);
          final remainingTime = const Duration(hours: 12) - difference;

          if (difference.inSeconds < 12 * 60 * 60 &&
              !remainingTime.isNegative) {
            isTimerActive = true;
            timerText = _formatDuration(remainingTime);
          }
        }
        
        final bool isButtonEnabled = !isTimerActive && supabase.auth.currentUser != null;
        final Color buttonColor = isTimerActive ? const Color.fromARGB(255, 127, 127, 127) : const Color.fromARGB(255, 44, 157, 237);

        return _buildGameButton(
          title: "Pacchetto",
          subtitle: "spacchetta il tuo kebab preferito",
          icon: Icons.card_giftcard,
          color: buttonColor, // Colore dinamico
          onTap: isButtonEnabled
              ? () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                            builder: (context) => const PackPage()),
                      )
                      .then((_) =>
                          _loadPageData());
                }
              : null, // Disabilitato
          trailing: isTimerActive
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    timerText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = supabase.auth.currentUser != null;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Games & Tools'),
          backgroundColor: main.red,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Devi effettuare l'accesso per usare questa sezione.",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Games & Tools'),
        backgroundColor: main.red,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildGameButton(
                          title: "Aggiungi Recensione",
                          subtitle: "Hai provato un nuovo kebab?",
                          icon: Icons.add_comment_rounded,
                          color: main.red,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const AddKebab()),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildPackButton(), // Bottone con timer
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildGameButton(
                                title: "Collezione",
                                subtitle: "controlla le tue kebabbo cards",
                                icon: Icons.collections_bookmark,
                                color: Colors.deepPurple,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          KebabCarouselPage()));
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildGameButton(
                          title: "Crea il Kebab",
                          subtitle: "crea il tuo kebab",
                          icon: Icons.build_rounded,
                          color: Colors.teal,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ToolsPage(
                                      currentPosition: widget.currentPosition,
                                      ingredients: _ingredients,
                                      onIngredientsUpdated:
                                          (updatedIngredients) {
                                        setState(() {
                                          _ingredients = updatedIngredients;
                                        });
                                      },
                                    )));
                          },
                        ),
                      ],
                    ),
                  ),

                  // --- Sezione Medaglie ---
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Text(
                      "Le tue Medaglie",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  SizedBox(
                    height: 250, // Altezza fissa per la griglia
                    child: MedalPage(userId: _id!),
                  ),
                ],
              ),
            ),
    );
  }
}