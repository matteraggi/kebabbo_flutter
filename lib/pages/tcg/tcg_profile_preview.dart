import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/pressable.dart';
import 'package:kebabbo_flutter/main.dart' as main;
import 'package:kebabbo_flutter/pages/tcg/tcg_hub_page.dart';
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TcgProfilePreview extends StatefulWidget {
  final String userId;
  const TcgProfilePreview({super.key, required this.userId});

  @override
  State<TcgProfilePreview> createState() => _TcgProfilePreviewState();
}

class _TcgProfilePreviewState extends State<TcgProfilePreview> {
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
    try {
      final profile = await supabase
          .from('profiles')
          .select('last_pack, tcg')
          .eq('id', widget.userId)
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
      debugPrint("Error loading TCG profile preview: $e");
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final double progress = _totalCardsCount > 0
        ? (_collectedCardsCount / _totalCardsCount).clamp(0.0, 1.0)
        : 0.0;
    final int percentage = (progress * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                      // 1. INTESTAZIONE ALBUM + PERCENTUALE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFBA1C)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.style,
                                  color: Color(0xFFB37400),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Album Carte TCG",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFBA1C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$percentage%",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // 2. CONTEGGIO CARTE + BARRA PROGRESSO
                      Row(
                        children: [
                          Text(
                            "$_collectedCardsCount",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            " / $_totalCardsCount",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "carte sbloccate",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${_totalCardsCount - _collectedCardsCount} mancanti",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFFBA1C)),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 3. SEZIONE PACCHETTI (PURAMENTE INFORMATIVA, NO BOTTONE)
                      StreamBuilder<DateTime>(
                        stream: Stream.periodic(
                            const Duration(seconds: 1), (_) => DateTime.now()),
                        builder: (context, snapshot) {
                          final stamina = PackStamina.calculate(_lastPack);
                          final int availablePacks = stamina.availablePacks;
                          final Duration timeToNext = stamina.timeToNextPack;
                          final String timerText =
                              PackStamina.formatDuration(timeToNext);
                          final bool hasPacks = availablePacks > 0;
                          final bool isMax =
                              availablePacks >= PackStamina.maxPacks;

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: hasPacks
                                  ? const Color(0xFFFFF9E6)
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: hasPacks
                                    ? const Color(0xFFFFBA1C)
                                        .withValues(alpha: 0.6)
                                    : Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  hasPacks
                                      ? Icons.card_giftcard
                                      : Icons.hourglass_top,
                                  size: 24,
                                  color: hasPacks
                                      ? const Color(0xFFB37400)
                                      : Colors.grey[600],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hasPacks
                                            ? (isMax
                                                ? "2 / 2 Pacchetti pronti da aprire"
                                                : "1 / 2 Pacchetto pronto da aprire")
                                            : "0 / 2 Pacchetti disponibili",
                                        style: TextStyle(
                                          color: hasPacks
                                              ? const Color(0xFF855A00)
                                              : Colors.black87,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        hasPacks
                                            ? (isMax
                                                ? "Carica massima raggiunta (1 ogni 12h)"
                                                : "Prossima ricarica tra $timerText")
                                            : "Ricarica in corso: prossimo tra $timerText",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // 4. IMMAGINE PACCHETTI RESPONSIVE CHE OCCUPA LO SPAZIO
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Image.asset(
                              "assets/images/kebabbo_packs_row.png",
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // 5. UNICO PULSANTE PRINCIPALE PER ANDARE ALLA PAGINA DELLE CARTE
                      Pressable(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TcgHubPage()),
                          ).then((_) => _loadData());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: main.red,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: main.red.withValues(alpha: 0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.auto_awesome,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text(
                                "Spacchetta & Guarda Collezione",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.white70, size: 13),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
