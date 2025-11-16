import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/pages/reviews/add_kebab.dart';
import 'package:kebabbo_flutter/pages/tcg/carousel.dart';
import 'package:kebabbo_flutter/pages/tcg/pack_page.dart';
import 'package:kebabbo_flutter/pages/account/tools_page.dart';
import 'package:kebabbo_flutter/utils/user_logic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/pressable.dart';

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

  Widget _buildCreateKebabButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: onTap != null ? color : Colors.grey[400],
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color:
                  onTap != null ? color.withValues(alpha: 0.3) : Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ICONA CON SFONDO BIANCO OPACO (rettangolo arrotondato)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ),

            const SizedBox(width: 16),

            // TITOLO + SOTTOTITOLO A DESTRA DELL'ICONA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget buildReviewSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onAddReview,
    required VoidCallback onAddKebabbaro,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.9), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP ----------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icona grande a sinistra
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              const SizedBox(width: 16),

              // Titolo + sottotitolo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // BOTTOM BUTTONS -----------------------------------------
          Row(
            children: [
// ────────────────────────────────────────────────
// BOTTONE 1 – Aggiungi Recensione
// ────────────────────────────────────────────────
              Expanded(
                child: Pressable(
                  onTap: onAddReview,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withValues(alpha: 0.25),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.6,
                      ),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.star_border, color: Colors.white, size: 30),
                        SizedBox(height: 6),
                        Text(
                          "Aggiungi Recensione",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

// ────────────────────────────────────────────────
// BOTTONE 2 – Aggiungi Kebabbaro
// ────────────────────────────────────────────────
              Expanded(
                child: Pressable(
                  onTap: onAddKebabbaro,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withValues(alpha: 0.25),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.6,
                      ),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            color: Colors.white, size: 28),
                        SizedBox(height: 6),
                        Text(
                          "Aggiungi Kebabbaro",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCollectionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TITOLO
          const Text(
            "Colleziona le carte di Kebabbo!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          // SOTTOTITOLO
          const Text(
            "Trova tutte le carte dei tuoi kebabbari preferiti",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),

          // IMMAGINE DEI 4 PACCHETTI (immagine unica)
          Image.asset(
            "assets/images/kebabbo_packs_row.png",
            width: double.infinity,
            fit: BoxFit.contain,
          ),

          // DUE BOTTONI IN RIGA (PACK + COLLEZIONE)
          Row(
            children: [
              Expanded(child: _buildSmallButtonPack()),
              const SizedBox(width: 16),
              Expanded(child: _buildSmallButtonCollection()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButtonPack() {
    return StreamBuilder<DateTime>(
      stream:
          Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        bool isTimerActive = false;
        String timerText = "";

        if (supabase.auth.currentUser != null) {
          final now = snapshot.data ?? DateTime.now();
          final difference = now.difference(_lastPack);
          final remainingTime = const Duration(hours: 12) - difference;

          if (difference.inSeconds < 43200 && !remainingTime.isNegative) {
            isTimerActive = true;
            timerText = _formatDuration(remainingTime);
          }
        }

        final bool enabled =
            !isTimerActive && supabase.auth.currentUser != null;

        return Pressable(
          onTap: enabled
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PackPage()),
                  ).then((_) => _loadPageData());
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: enabled ? main.red : Colors.grey[400],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.card_giftcard,
                  size: 32,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  isTimerActive ? timerText : "Pacchetto",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmallButtonCollection() {
    return Pressable(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => KebabCarouselPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: main.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: const [
            Icon(Icons.collections_bookmark, size: 32, color: Colors.white),
            SizedBox(height: 8),
            Text(
              "Collezione",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = supabase.auth.currentUser != null;

    if (!isLoggedIn) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              S.of(context).login_required_section,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
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
                        buildReviewSection(
                          icon: Icons.add,
                          title: "Hai provato un nuovo kebab?",
                          subtitle: "Facci sapere cosa ne pensi!",
                          color: main.red,
                          onAddReview: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddKebab()),
                            );
                          },
                          onAddKebabbaro: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddKebab()),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        buildCollectionSection(),
                        const SizedBox(height: 16),
                        _buildCreateKebabButton(
                          title: "Costruisci il tuo Kebab",
                          subtitle: "E trova il kebabbaro perfetto per te!",
                          icon: Icons.build_rounded,
                          color: main.red,
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
                ],
              ),
            ),
    );
  }
}
