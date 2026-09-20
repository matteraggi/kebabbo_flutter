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
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';
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
  DateTime? _lastPack;
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
        final rawLastPack = profileData['last_pack'];
        DateTime? parsedLastPack;
        if (rawLastPack != null && rawLastPack.toString().trim().isNotEmpty) {
          try {
            parsedLastPack = DateTime.parse(rawLastPack.toString()).toUtc();
          } catch (_) {}
        }

        setState(() {
          _lastPack = parsedLastPack;
          _ingredients =
              List<int>.from(profileData['ingredients'] ?? [5, 5, 5, 5, 5]);
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
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildSmallButtonPack()),
                const SizedBox(width: 16),
                Expanded(child: _buildSmallButtonCollection()),
              ],
            ),
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
        final stamina = PackStamina.calculate(_lastPack);
        final int availablePacks = stamina.availablePacks;
        final Duration timeToNext = stamina.timeToNextPack;
        final String timerText = PackStamina.formatDuration(timeToNext);

        final bool hasPacks = availablePacks > 0;
        final bool isMax = availablePacks >= PackStamina.maxPacks;

        return Pressable(
          onTap: hasPacks
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PackPage()),
                  ).then((_) => _loadPageData());
                }
              : () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Nessun pacchetto pronto. Il prossimo sarà disponibile tra $timerText.",
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
          onLongPress: () async {
            final userId = supabase.auth.currentUser?.id;
            if (userId == null) return;
            final fullStaminaTime =
                DateTime.now().toUtc().subtract(const Duration(hours: 24));
            await supabase.from('profiles').update({
              'last_pack': fullStaminaTime.toIso8601String(),
            }).eq('id', userId);
            await _loadPageData();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pacchetti ricaricati al massimo: 2 / 2 pronti! 📦✨"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            decoration: BoxDecoration(
              color: hasPacks ? main.red : const Color(0xFF2E1212),
              borderRadius: BorderRadius.circular(20),
              border: !hasPacks
                  ? Border.all(color: Colors.white24, width: 1.0)
                  : (isMax
                      ? Border.all(color: const Color(0xFFFFD700), width: 1.5)
                      : null),
              boxShadow: [
                BoxShadow(
                  color: hasPacks
                      ? main.red.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      hasPacks ? Icons.card_giftcard : Icons.hourglass_top,
                      size: 28,
                      color: hasPacks ? Colors.white : Colors.white70,
                    ),
                    if (hasPacks)
                      Positioned(
                        right: -10,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFBA1C),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Text(
                            "$availablePacks",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  hasPacks
                      ? (availablePacks == 1 ? "1 Pacchetto" : "2 Pacchetti")
                      : timerText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: hasPacks
                        ? Colors.black.withValues(alpha: 0.25)
                        : Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    hasPacks
                        ? (isMax ? "MAX (2/2)" : "+1 in $timerText")
                        : "In Ricarica (0/2)",
                    style: TextStyle(
                      color: hasPacks ? const Color(0xFFFFD700) : Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: main.red,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: main.red.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.collections_bookmark, size: 28, color: Colors.white),
            SizedBox(height: 6),
            Text(
              "Collezione",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
