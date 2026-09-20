import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/pressable.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/pages/tcg/carousel.dart';
import 'package:kebabbo_flutter/pages/tcg/pack_page.dart';
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TcgHubPage extends StatefulWidget {
  const TcgHubPage({super.key});

  @override
  State<TcgHubPage> createState() => _TcgHubPageState();
}

class _TcgHubPageState extends State<TcgHubPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool _loading = true;
  DateTime? _lastPack;
  int _collectedCardsCount = 0;
  int _totalCardsCount = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }

    try {
      // 1. Carica last_pack e tcg dal profilo
      final profile = await supabase
          .from('profiles')
          .select('last_pack, tcg')
          .eq('id', userId)
          .single();

      final rawLastPack = profile['last_pack'];
      DateTime? parsedLastPack;
      if (rawLastPack != null && rawLastPack.toString().trim().isNotEmpty) {
        try {
          parsedLastPack = DateTime.parse(rawLastPack.toString()).toUtc();
        } catch (_) {}
      }

      final List<dynamic> tcgArray = List<dynamic>.from(profile['tcg'] ?? []);
      final collectedCount = TcgCardsHelper.countCollected(tcgArray);
      final totalCount = TcgCardsHelper.totalCardsCount;

      if (mounted) {
        setState(() {
          _lastPack = parsedLastPack;
          _collectedCardsCount = collectedCount;
          _totalCardsCount = totalCount;
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading TCG Hub data: $e");
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: main.yellow,
      appBar: AppBar(
        backgroundColor: main.yellow,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Kebabbo TCG",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeroBanner(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _buildPackSection(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildHeroBanner() {
    final double percentage = _totalCardsCount > 0
        ? (_collectedCardsCount / _totalCardsCount).clamp(0.0, 1.0)
        : 0.0;

    return Pressable(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KebabCarouselPage()),
        ).then((_) => _loadData());
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF232526), Color(0xFF414345)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.style, color: Color(0xFFFFD700), size: 26),
                    SizedBox(width: 8),
                    Text(
                      "Collezione Carte",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${(percentage * 100).toInt()}%",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white70, size: 14),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  "$_collectedCardsCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  " / $_totalCardsCount",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  _collectedCardsCount == _totalCardsCount && _totalCardsCount > 0
                      ? "Tutte trovate! 🏆"
                      : "${_totalCardsCount - _collectedCardsCount} rimanenti",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percentage,
                minHeight: 8,
                backgroundColor: Colors.white12,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFFFFBA1C)),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.view_carousel,
                    size: 16,
                    color: const Color(0xFFFFD700).withValues(alpha: 0.9)),
                const SizedBox(width: 6),
                Text(
                  "Tocca per sfogliare l'album completo ›",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackSection() {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        final stamina = PackStamina.calculate(_lastPack);
        final int availablePacks = stamina.availablePacks;
        final Duration timeToNext = stamina.timeToNextPack;
        final String timerText = PackStamina.formatDuration(timeToNext);
        final bool hasPacks = availablePacks > 0;

        return Column(
          children: [
            const SizedBox(height: 6),
            const Text(
              "Spacchetta Nuove Carte",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Ricarica 1 pacchetto ogni 12h (max 2)",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Booster Pack Stage in the center (fills height naturally)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: hasPacks
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PackPage()),
                        ).then((_) => _loadData());
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
                child: _buildPackStage(hasPacks, availablePacks),
              ),
            ),

            // Stamina slots: non-redundant, showing exact status of both slots
            _buildStaminaSlots(availablePacks, timerText),

            const SizedBox(height: 16),

            // Big open pack button docked at bottom
            _buildOpenPackButton(hasPacks, availablePacks, timerText),

            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Widget _buildPackStage(bool hasPacks, int availablePacks) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxHeight =
            constraints.maxHeight.isFinite ? constraints.maxHeight : 260.0;
        final double maxWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 300.0;

        // Dynamically compute responsive pack height based on available vertical & horizontal space
        final double maxPackHeightByWidth = maxWidth * 1.35;
        final double targetHeight = (maxHeight * 0.78).clamp(170.0, 360.0);
        final double packHeight = targetHeight > maxPackHeightByWidth
            ? maxPackHeightByWidth
            : targetHeight;
        final double backPackHeight = packHeight * 0.94;
        final double haloSize = (packHeight * 1.08).clamp(180.0, 390.0);
        final double offsetX = (packHeight * 0.08).clamp(12.0, 26.0);
        final double offsetY = (packHeight * 0.045).clamp(6.0, 15.0);

        return Center(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Ambient warm halo
              Container(
                width: haloSize,
                height: haloSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (hasPacks ? const Color(0xFFFF9500) : Colors.white)
                          .withValues(alpha: 0.28),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Vertical Booster Pack artwork
              if (availablePacks >= 2) ...[
                // Back pack slightly tilted
                Transform.translate(
                  offset: Offset(-offsetX, -offsetY),
                  child: Transform.rotate(
                    angle: -0.08,
                    child: Image.asset(
                      "assets/images/kebabbo_pack.png",
                      height: backPackHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Front pack slightly tilted
                Transform.translate(
                  offset: Offset(offsetX * 0.7, offsetY * 0.7),
                  child: Transform.rotate(
                    angle: 0.05,
                    child: Image.asset(
                      "assets/images/kebabbo_pack.png",
                      height: packHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ] else ...[
                Opacity(
                  opacity: hasPacks ? 1.0 : 0.65,
                  child: Image.asset(
                    "assets/images/kebabbo_pack.png",
                    height: packHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildStaminaSlots(int availablePacks, String timerText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Slot 1
        _buildSlotItem(
          title: "1° Pacchetto",
          isReady: availablePacks >= 1,
          statusText: availablePacks >= 1 ? "Pronto!" : timerText,
          icon: availablePacks >= 1 ? Icons.check_circle : Icons.hourglass_top,
        ),
        const SizedBox(width: 12),
        // Slot 2
        _buildSlotItem(
          title: "2° Pacchetto",
          isReady: availablePacks >= 2,
          statusText: availablePacks >= 2
              ? "Pronto!"
              : (availablePacks == 1 ? timerText : "In coda"),
          icon: availablePacks >= 2
              ? Icons.check_circle
              : (availablePacks == 1 ? Icons.hourglass_top : Icons.lock_outline),
        ),
      ],
    );
  }

  Widget _buildSlotItem({
    required String title,
    required bool isReady,
    required String statusText,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isReady ? Colors.white : Colors.black.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isReady ? const Color(0xFFFFBA1C) : Colors.black12,
          width: 1.2,
        ),
        boxShadow: isReady
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isReady ? const Color(0xFF2E7D32) : Colors.black54,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: isReady ? Colors.black54 : Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 13,
                  color: isReady ? const Color(0xFF1B5E20) : Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpenPackButton(
      bool hasPacks, int availablePacks, String timerText) {
    return Pressable(
      onTap: hasPacks
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PackPage()),
              ).then((_) => _loadData());
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
        await _loadData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Pacchetti ricaricati al massimo: 2 / 2 pronti! 📦✨"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: hasPacks ? main.red : Colors.grey[400],
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: hasPacks
                  ? main.red.withValues(alpha: 0.35)
                  : Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasPacks ? Icons.flare : Icons.lock_outline,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 10),
            Text(
              hasPacks
                  ? (availablePacks > 1
                      ? "Apri Pacchetto (2 Pronti!)"
                      : "Apri Pacchetto")
                  : "Nessun pacchetto pronto",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
