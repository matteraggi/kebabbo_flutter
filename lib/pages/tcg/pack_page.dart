import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PackPage extends StatefulWidget {
  const PackPage({super.key});

  @override
  PackPageState createState() => PackPageState();
}

class PackPageState extends State<PackPage> with TickerProviderStateMixin {
  final SupabaseClient supabase = Supabase.instance.client;

  String? _kebabName;
  String? _kebabDisplayName;
  bool _isOpeningLogicRunning = false;
  bool _isTorn = false;
  bool _isRevealed = false;
  bool _isDuplicate = false;
  DateTime? _lastPack;
  int _availablePacks = 0;

  // Controllers
  late AnimationController _idleController;
  late AnimationController _tearController;
  late AnimationController _revealController;
  late AnimationController _sunburstController;
  late AnimationController _springController;

  // 3D Tilt interactive state
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  double _tiltStartX = 0.0;
  double _tiltStartY = 0.0;

  // Pre-calculated particle seed for burst
  final List<_Particle> _particles = _generateParticles(36);

  @override
  void initState() {
    super.initState();
    _loadStamina();

    // 1. Idle breathing/floating animation
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // 2. Tear & burst animation
    _tearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    // 3. Card reveal animation
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // 4. Continuous sunburst rotation once revealed
    _sunburstController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    );

    // 5. Spring back controller for 3D card tilt
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _tearController.addListener(() {
      // Trigger card reveal around 30% into the tear animation
      if (_tearController.value >= 0.30 && !_isRevealed) {
        _isRevealed = true;
        _revealController.forward(from: 0.0);
        _sunburstController.repeat();
      }
    });

    _springController.addListener(() {
      final t = Curves.easeOutBack.transform(_springController.value);
      setState(() {
        _tiltX = _tiltStartX * (1.0 - t);
        _tiltY = _tiltStartY * (1.0 - t);
      });
    });
  }

  @override
  void dispose() {
    _idleController.dispose();
    _tearController.dispose();
    _revealController.dispose();
    _sunburstController.dispose();
    _springController.dispose();
    super.dispose();
  }

  Future<void> _loadStamina() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    try {
      final res = await supabase
          .from('profiles')
          .select('last_pack')
          .eq('id', userId)
          .single();
      final raw = res['last_pack'];
      DateTime? parsed;
      if (raw != null && raw.toString().trim().isNotEmpty) {
        parsed = DateTime.parse(raw.toString()).toUtc();
      }
      _lastPack = parsed;
      final stamina = PackStamina.calculate(_lastPack);
      if (mounted) {
        setState(() {
          _availablePacks = stamina.availablePacks;
        });
      }
    } catch (e) {
      debugPrint("Error loading stamina in PackPage: $e");
    }
  }

  void _resetForNextPack() {
    setState(() {
      _isTorn = false;
      _isRevealed = false;
      _isDuplicate = false;
      _kebabName = null;
      _kebabDisplayName = null;
      _tiltX = 0.0;
      _tiltY = 0.0;
      _tiltStartX = 0.0;
      _tiltStartY = 0.0;
    });
    _tearController.reset();
    _revealController.reset();
    _sunburstController.stop();
    _idleController.repeat(reverse: true);
    _loadStamina();
  }

  static List<_Particle> _generateParticles(int count) {
    final rand = math.Random(42);
    final colors = [
      const Color(0xFFFFD700), // Gold
      const Color(0xFFFFBA1C), // Kebabbo Yellow
      const Color(0xFFFF5252), // Bright Red
      const Color(0xFFFFFFFF), // White flash
      const Color(0xFFFF9100), // Amber
    ];
    return List.generate(count, (index) {
      final angle = (index / count) * 2 * math.pi + (rand.nextDouble() - 0.5) * 0.4;
      final speed = 120.0 + rand.nextDouble() * 220.0;
      final size = 4.0 + rand.nextDouble() * 6.0;
      final color = colors[rand.nextInt(colors.length)];
      return _Particle(angle: angle, speed: speed, size: size, color: color);
    });
  }

  Future<void> _initiatePackOpening() async {
    if (_isOpeningLogicRunning || _isTorn) {
      return;
    }

    setState(() {
      _isOpeningLogicRunning = true;
    });

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found. Please log in again.")),
        );
        Navigator.pop(context);
      }
      _isOpeningLogicRunning = false;
      return;
    }

    try {
      final profileResponse = await supabase
          .from('profiles')
          .select('tcg, last_pack')
          .eq('id', userId)
          .single();

      final lastPackTimestamp = profileResponse['last_pack'] as String?;
      final List<dynamic> tcgArray =
          List<dynamic>.from(profileResponse['tcg'] ?? []);

      DateTime? lastPackTime;
      if (lastPackTimestamp != null && lastPackTimestamp.trim().isNotEmpty) {
        try {
          lastPackTime = DateTime.parse(lastPackTimestamp).toUtc();
        } catch (_) {}
      }

      final stamina = PackStamina.calculate(lastPackTime);
      final int availablePacks = stamina.availablePacks;

      // Check if user has at least 1 pack ready
      if (availablePacks == 0) {
        final remainingHours = stamina.timeToNextPack.inHours;
        final remainingMinutes = stamina.timeToNextPack.inMinutes.remainder(60);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Nessun pacchetto pronto al momento (0/2). Il prossimo pacchetto sarà pronto tra ${remainingHours}h e ${remainingMinutes}m.",
              ),
              duration: const Duration(seconds: 3),
            ),
          );
          setState(() => _isOpeningLogicRunning = false);
        }
        return;
      }

      // Fetch all available cards matching valid card IDs
      final allCardsResponse = await supabase
          .from('kebab')
          .select('id, name')
          .inFilter('id', TcgCardsHelper.validCardIds.toList());
      final availableKebabs =
          List<dynamic>.from(allCardsResponse as List<dynamic>);

      if (availableKebabs.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nessuna carta disponibile nel database.")),
          );
          Navigator.pop(context);
        }
        if (mounted) {
          setState(() => _isOpeningLogicRunning = false);
        }
        return;
      }

      // Pick randomly from all cards (allows duplicates)
      final randomKebab =
          (availableKebabs..shuffle()).first as Map<String, dynamic>;
      final String kebabDisplayName = randomKebab['name'];
      final foundKebabId = randomKebab['id'];
      final bool isDuplicate = tcgArray.contains(foundKebabId);
      final updatedTcgArray = isDuplicate
          ? tcgArray
          : [...tcgArray, foundKebabId];

      final newLastPack = PackStamina.consumePack(lastPackTime);
      await supabase.from('profiles').update({
        'tcg': updatedTcgArray,
        'last_pack': newLastPack.toIso8601String(),
      }).eq('id', userId);
      _lastPack = newLastPack;
      _availablePacks = PackStamina.calculate(newLastPack).availablePacks;
      _isDuplicate = isDuplicate;

      final String imageName =
          kebabDisplayName.toLowerCase().replaceAll(' ', '-');

      // Precache the image before starting animation
      if (mounted) {
        await precacheImage(
            AssetImage('assets/kebab-card/$imageName.png'), context);
      }

      if (!mounted) return;

      // Haptic feedback on mobile
      HapticFeedback.heavyImpact();

      setState(() {
        _kebabName = imageName;
        _kebabDisplayName = kebabDisplayName;
        _isOpeningLogicRunning = false;
        _isTorn = true;
      });

      // Stop idle and start tear animation
      _idleController.stop();
      _tearController.forward(from: 0.0);
    } catch (e, stacktrace) {
      debugPrint('Error opening pack: $e\n$stacktrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')),
        );
        Navigator.pop(context);
      }
      if (mounted) {
        setState(() => _isOpeningLogicRunning = false);
      }
    }
  }

  void _handleTap() {
    if (!_isTorn) {
      if (!_isOpeningLogicRunning) {
        _initiatePackOpening();
      }
    } else {
      if (_revealController.isCompleted) {
        Navigator.pop(context);
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_revealController.isCompleted) return;
    _springController.stop();
    setState(() {
      _tiltX += details.delta.dx * 0.008;
      _tiltY -= details.delta.dy * 0.008;
      _tiltX = _tiltX.clamp(-0.25, 0.25);
      _tiltY = _tiltY.clamp(-0.25, 0.25);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_revealController.isCompleted) return;
    _tiltStartX = _tiltX;
    _tiltStartY = _tiltY;
    _springController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // Proportional dimensions
    const double cardWidth = 281.25;
    const double cardHeight = 500.0;
    const double packWidth = 280.0;
    const double packTopHeight = 280.0 * (312.0 / 1080.0); // ~80.9
    const double packBottomHeight = 280.0 * (1608.0 / 1080.0); // ~416.9

    return Scaffold(
      backgroundColor: const Color(0xFF140707),
      appBar: AppBar(
        title: Text(
          S.of(context).my_cards,
        ),
        backgroundColor: red,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _availablePacks > 0
                    ? const Color(0xFFFFBA1C)
                    : Colors.white24,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.card_giftcard,
                  size: 16,
                  color: _availablePacks > 0
                      ? const Color(0xFFFFBA1C)
                      : Colors.white60,
                ),
                const SizedBox(width: 6),
                Text(
                  "$_availablePacks / ${PackStamina.maxPacks}",
                  style: TextStyle(
                    color: _availablePacks > 0 ? Colors.white : Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.2,
            colors: [
              Color(0xFF381010),
              Color(0xFF1A0606),
              Color(0xFF0D0202),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Interactive stage for Pack and Card
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _handleTap,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: SizedBox.expand(
                  child: Center(
                    child: SizedBox(
                      width: 340,
                      height: 560,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // A. PACK SHADOW (Floats and scales with idle)
                          if (!_isTorn)
                            AnimatedBuilder(
                              animation: _idleController,
                              builder: (context, child) {
                                final floatFactor =
                                    math.sin(_idleController.value * math.pi);
                                final shadowScale = 0.85 + floatFactor * 0.15;
                                final shadowOpacity = 0.35 + floatFactor * 0.15;
                                return Positioned(
                                  bottom: 12,
                                  child: Container(
                                    width: packWidth * shadowScale,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(packWidth),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: shadowOpacity),
                                          blurRadius: 18,
                                          spreadRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                          // B. SUNBURST RAYS (Behind Card when revealed)
                          if (_isRevealed)
                            AnimatedBuilder(
                              animation: Listenable.merge(
                                  [_revealController, _sunburstController]),
                              builder: (context, child) {
                                final revealProgress = Curves.easeOut.transform(
                                  (_revealController.value / 0.7).clamp(0.0, 1.0),
                                );
                                if (revealProgress <= 0.01) {
                                  return const SizedBox.shrink();
                                }
                                return Opacity(
                                  opacity: revealProgress * 0.85,
                                  child: Transform.rotate(
                                    angle: _sunburstController.value * 2 * math.pi,
                                    child: CustomPaint(
                                      size: const Size(600, 600),
                                      painter: _SunburstPainter(),
                                    ),
                                  ),
                                );
                              },
                            ),

                          // C. REVEALED CARD WITH 3D TILT & GLOW
                          if (_kebabName != null)
                            AnimatedBuilder(
                              animation: _revealController,
                              builder: (context, child) {
                                final popT = Curves.easeOutBack.transform(
                                  (_revealController.value / 0.65)
                                      .clamp(0.0, 1.0),
                                );
                                final scale = 0.5 + popT * 0.5;
                                final opacity =
                                    (_revealController.value * 2.5).clamp(0.0, 1.0);

                                return Opacity(
                                  opacity: opacity,
                                  child: Transform(
                                    alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateX(_tiltY)
                                        ..rotateY(_tiltX)
                                        ..scaleByDouble(scale, scale, 1.0, 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFFBA1C)
                                                .withValues(alpha: 0.35 * popT),
                                            blurRadius: 28,
                                            spreadRadius: 4,
                                          ),
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.4),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          // Clean, uncropped 9:16 card
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: Image.asset(
                                              'assets/kebab-card/$_kebabName.png',
                                              width: cardWidth,
                                              height: cardHeight,
                                              fit: BoxFit.contain,
                                            ),
                                          ),

                                          // Diagonal Holo Foil Shimmer Sweep
                                          Positioned.fill(
                                            child: _HoloFoilSweep(
                                              progress: _revealController.value,
                                              tiltX: _tiltX,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                          // D. BOTTOM HALF OF PACK (Separates and falls down on tear)
                          AnimatedBuilder(
                            animation: Listenable.merge(
                                [_idleController, _tearController]),
                            builder: (context, child) {
                              if (_tearController.value >= 0.95) {
                                return const SizedBox.shrink();
                              }

                              double translateY = 0.0;
                              double translateX = 0.0;
                              double rotation = 0.0;
                              double opacity = 1.0;

                              if (!_isTorn) {
                                // Idle breathing
                                translateY =
                                    math.sin(_idleController.value * math.pi) *
                                        -8.0;
                              } else {
                                final t = _tearController.value;
                                // Shake phase (0.0 to 0.12)
                                if (t < 0.12) {
                                  final shakeT = t / 0.12;
                                  translateX =
                                      math.sin(shakeT * math.pi * 6) * 6.0;
                                } else {
                                  // Fall phase (0.12 to 1.0)
                                  final fallT = Curves.easeInQuad
                                      .transform((t - 0.12) / 0.88);
                                  translateY = fallT * 380.0;
                                  translateX = -fallT * 25.0;
                                  rotation = -fallT * 0.12;
                                  if (fallT > 0.4) {
                                    opacity =
                                        (1.0 - (fallT - 0.4) / 0.6).clamp(0.0, 1.0);
                                  }
                                }
                              }

                              return Positioned(
                                top: 10 + packTopHeight + translateY,
                                child: Transform.translate(
                                  offset: Offset(translateX, 0),
                                  child: Transform.rotate(
                                    angle: rotation,
                                    alignment: Alignment.topRight,
                                    child: Opacity(
                                      opacity: opacity,
                                      child: Image.asset(
                                        'assets/images/pack_bottom.png',
                                        width: packWidth,
                                        height: packBottomHeight,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // E. TOP HALF OF PACK (Rips, arches up & fades on tear)
                          AnimatedBuilder(
                            animation: Listenable.merge(
                                [_idleController, _tearController]),
                            builder: (context, child) {
                              if (_tearController.value >= 0.90) {
                                return const SizedBox.shrink();
                              }

                              double translateY = 0.0;
                              double translateX = 0.0;
                              double rotation = 0.0;
                              double opacity = 1.0;

                              if (!_isTorn) {
                                // Idle breathing
                                translateY =
                                    math.sin(_idleController.value * math.pi) *
                                        -8.0;
                              } else {
                                final t = _tearController.value;
                                // Shake phase (0.0 to 0.12)
                                if (t < 0.12) {
                                  final shakeT = t / 0.12;
                                  translateX =
                                      -math.sin(shakeT * math.pi * 6) * 6.0;
                                } else {
                                  // Rip and fly phase (0.12 to 1.0)
                                  final ripT = Curves.easeOutCubic
                                      .transform((t - 0.12) / 0.88);
                                  translateY = -ripT * 260.0;
                                  translateX = ripT * 55.0;
                                  rotation = ripT * 0.35; // ~20 deg tilt
                                  if (ripT > 0.3) {
                                    opacity =
                                        (1.0 - (ripT - 0.3) / 0.7).clamp(0.0, 1.0);
                                  }
                                }
                              }

                              return Positioned(
                                top: 10 + translateY,
                                child: Transform.translate(
                                  offset: Offset(translateX, 0),
                                  child: Transform.rotate(
                                    angle: rotation,
                                    alignment: Alignment.bottomLeft,
                                    child: Opacity(
                                      opacity: opacity,
                                      child: Image.asset(
                                        'assets/images/pack_top.png',
                                        width: packWidth,
                                        height: packTopHeight,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // F. TEAR FLASH & PARTICLE BURST (At the moment of ripping)
                          if (_isTorn)
                            AnimatedBuilder(
                              animation: _tearController,
                              builder: (context, child) {
                                final t = _tearController.value;
                                if (t < 0.08 || t > 0.85) {
                                  return const SizedBox.shrink();
                                }
                                final burstT = (t - 0.08) / 0.77;

                                return Positioned(
                                  top: 10 + packTopHeight,
                                  child: CustomPaint(
                                    size: const Size(0, 0),
                                    painter: _ParticleBurstPainter(
                                      particles: _particles,
                                      progress: burstT,
                                    ),
                                  ),
                                );
                              },
                            ),

                          // G. TEAR LIGHT FLASH (Glow on the cut seam)
                          if (_isTorn)
                            AnimatedBuilder(
                              animation: _tearController,
                              builder: (context, child) {
                                final t = _tearController.value;
                                if (t < 0.10 || t > 0.50) {
                                  return const SizedBox.shrink();
                                }
                                final flashT = (t - 0.10) / 0.40;
                                final flashOpacity = math.sin(flashT * math.pi);

                                return Positioned(
                                  top: 10 + packTopHeight - 30,
                                  child: Opacity(
                                    opacity: flashOpacity,
                                    child: Container(
                                      width: packWidth + 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(30),
                                        gradient: const RadialGradient(
                                          colors: [
                                            Colors.white,
                                            Color(0xFFFFD700),
                                            Colors.transparent,
                                          ],
                                          stops: [0.0, 0.4, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // 2. IDLE CALL-TO-ACTION (Before tear)
              if (!_isTorn)
                Positioned(
                  bottom: 30,
                  child: AnimatedBuilder(
                    animation: _idleController,
                    builder: (context, child) {
                      final pulse = 0.85 +
                          0.15 * math.sin(_idleController.value * math.pi);
                      return Opacity(
                        opacity: pulse,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFFFBA1C).withValues(alpha: 0.6),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFBA1C).withValues(alpha: 0.2),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_isOpeningLogicRunning)
                                const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFFBA1C),
                                    strokeWidth: 2,
                                  ),
                                )
                              else
                                const Icon(
                                  Icons.touch_app,
                                  color: Color(0xFFFFBA1C),
                                  size: 20,
                                ),
                              const SizedBox(width: 10),
                              Text(
                                _isOpeningLogicRunning
                                    ? "Apertura in corso..."
                                    : "Tocca per aprire il pacchetto!",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // 3. REVEALED FOOTER (Card title & Add to Collection button)
              if (_isRevealed)
                AnimatedBuilder(
                  animation: _revealController,
                  builder: (context, child) {
                    final footerT = Curves.easeOutCubic.transform(
                      ((_revealController.value - 0.65) / 0.35).clamp(0.0, 1.0),
                    );
                    if (footerT <= 0.01) return const SizedBox.shrink();

                    return Positioned(
                      bottom: 24,
                      child: Opacity(
                        opacity: footerT,
                        child: Transform.translate(
                          offset: Offset(0, (1.0 - footerT) * 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Status badge (DOPPIONE vs NUOVA CARTA)
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 5),
                                decoration: BoxDecoration(
                                  color: _isDuplicate
                                      ? const Color(0xFF232326)
                                      : const Color(0xFF1B5E20),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: _isDuplicate
                                        ? const Color(0xFFFFB300)
                                        : const Color(0xFF81C784),
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (_isDuplicate
                                              ? const Color(0xFFFFB300)
                                              : const Color(0xFF81C784))
                                          .withValues(alpha: 0.35),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isDuplicate
                                          ? Icons.repeat_rounded
                                          : Icons.auto_awesome,
                                      color: _isDuplicate
                                          ? const Color(0xFFFFB300)
                                          : Colors.white,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _isDuplicate
                                          ? "CARTA DOPPIONE"
                                          : "NUOVA CARTA SBLOCCATA!",
                                      style: TextStyle(
                                        color: _isDuplicate
                                            ? const Color(0xFFFFB300)
                                            : Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Name Tag
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: _isDuplicate
                                        ? const [
                                            Color(0xFFE0E0E0),
                                            Color(0xFFBDBDBD),
                                          ]
                                        : const [
                                            Color(0xFFFFBA1C),
                                            Color(0xFFFF8C00),
                                          ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (_isDuplicate
                                              ? Colors.white24
                                              : const Color(0xFFFFBA1C))
                                          .withValues(alpha: 0.4),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _isDuplicate
                                      ? "${_kebabDisplayName ?? 'KEBABBO CARD'} (Già in Collezione)"
                                      : "✨ ${_kebabDisplayName ?? 'KEBABBO CARD'} ✨",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Interactive hint
                              Text(
                                "Trascina con il dito per inclinare in 3D",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.65),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Action Buttons: Open next pack or add to collection
                              if (_availablePacks > 0)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.white38),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 13),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "Collezione",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: red,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 13),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          side: const BorderSide(
                                            color: Color(0xFFFFBA1C),
                                            width: 1.5,
                                          ),
                                        ),
                                        elevation: 6,
                                        shadowColor: red.withValues(alpha: 0.5),
                                      ),
                                      onPressed: _resetForNextPack,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.replay,
                                              size: 18,
                                              color: Color(0xFFFFBA1C)),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Apri 2° Pacchetto ($_availablePacks)",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              else
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: red,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 36, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: const BorderSide(
                                        color: Color(0xFFFFBA1C),
                                        width: 1.5,
                                      ),
                                    ),
                                    elevation: 6,
                                    shadowColor: red.withValues(alpha: 0.5),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "Aggiungi alla Collezione",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER MODELS & CUSTOM PAINTERS
// -----------------------------------------------------------------------------

class _Particle {
  final double angle;
  final double speed;
  final double size;
  final Color color;

  const _Particle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.color,
  });
}

class _ParticleBurstPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticleBurstPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final distance = p.speed * progress;
      final x = math.cos(p.angle) * distance;
      // Slight gravity pull down
      final y = math.sin(p.angle) * distance + (progress * progress * 70.0);
      final alpha = (1.0 - progress).clamp(0.0, 1.0);
      final radius = p.size * (1.0 - progress * 0.5);

      final paint = Paint()
        ..color = p.color.withValues(alpha: alpha)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticleBurstPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _SunburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    const rayCount = 18;
    const rayAngle = (2 * math.pi) / rayCount;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD700).withValues(alpha: 0.40),
          const Color(0xFFFF8C00).withValues(alpha: 0.18),
          Colors.transparent,
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));

    for (int i = 0; i < rayCount; i += 2) {
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: maxRadius),
          i * rayAngle,
          rayAngle,
          false,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HoloFoilSweep extends StatelessWidget {
  final double progress;
  final double tiltX;

  const _HoloFoilSweep({
    required this.progress,
    required this.tiltX,
  });

  @override
  Widget build(BuildContext context) {
    // Holographic sheen sweeps across during reveal (between 0.45 and 0.85)
    // and shifts slightly with 3D tilt
    double sweepPos = -1.2;
    double opacity = 0.0;

    if (progress >= 0.45 && progress <= 0.85) {
      final t = (progress - 0.45) / 0.40;
      sweepPos = -1.2 + t * 2.4;
      opacity = math.sin(t * math.pi) * 0.45;
    } else if (progress > 0.85) {
      // Interactive sheen driven by tilt
      sweepPos = tiltX * 3.0;
      opacity = (tiltX.abs() * 1.5).clamp(0.0, 0.35);
    }

    if (opacity <= 0.01) return const SizedBox.shrink();

    return IgnorePointer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Opacity(
          opacity: opacity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(sweepPos - 0.4, -1.0),
                end: Alignment(sweepPos + 0.4, 1.0),
                colors: const [
                  Colors.transparent,
                  Color(0x80FFFFFF),
                  Color(0x90FFD700),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.45, 0.55, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
