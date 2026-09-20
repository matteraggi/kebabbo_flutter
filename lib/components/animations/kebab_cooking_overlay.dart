import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

/// Modern, highly polished animated overlay shown while cooking/building a kebab
/// or rerolling a recommendation. Replaces the legacy sliding cloud PNG.
class KebabCookingOverlay extends StatefulWidget {
  final bool isVisible;
  final bool isReroll;
  final Map<String, int>? ingredients;

  const KebabCookingOverlay({
    super.key,
    required this.isVisible,
    this.isReroll = false,
    this.ingredients,
  });

  @override
  State<KebabCookingOverlay> createState() => _KebabCookingOverlayState();
}

class _KebabCookingOverlayState extends State<KebabCookingOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _sizzleController;
  late AnimationController _particlesController;
  late AnimationController _ingredientsController;

  Timer? _stepTimer;
  int _stepIndex = 0;

  final List<String> _buildSteps = [
    "🔥 Scaldo la piadina...",
    "🥩 Taglio la carne allo spiedo...",
    "🥗 Aggiungo verdure fresche e salse...",
    "🌯 Arrotolo a regola d'arte...",
    "🔍 Cerco il miglior kebab per te...",
  ];

  final List<String> _rerollSteps = [
    "👨‍🍳 Nuova combinazione in arrivo...",
    "🔥 Bilancio spezie e cottura...",
    "✨ Cerco un'altra eccellente proposta...",
  ];

  static const List<Map<String, dynamic>> _ingredientMeta = [
    {
      'key': 'meat',
      'label': 'Carne',
      'asset': 'assets/images/meat_medium.png',
      'angle': -math.pi / 2, // Top
    },
    {
      'key': 'onion',
      'label': 'Cipolla',
      'asset': 'assets/images/onion_medium.png',
      'angle': -math.pi / 6, // Top-right
    },
    {
      'key': 'spicy',
      'label': 'Piccante',
      'asset': 'assets/images/spicy_medium.png',
      'angle': math.pi / 4, // Bottom-right
    },
    {
      'key': 'yogurt',
      'label': 'Yogurt',
      'asset': 'assets/images/yogurt_medium.png',
      'angle': 3 * math.pi / 4, // Bottom-left
    },
    {
      'key': 'vegetables',
      'label': 'Verdure',
      'asset': 'assets/images/vegetables_medium.png',
      'angle': -5 * math.pi / 6, // Top-left
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _sizzleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _particlesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _ingredientsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    if (widget.isVisible) {
      _startSequence();
    }
  }

  void _startSequence() {
    _stepIndex = 0;
    _fadeController.forward();
    _ingredientsController.forward(from: 0.0);
    _stepTimer?.cancel();

    final steps = widget.isReroll ? _rerollSteps : _buildSteps;
    _stepTimer = Timer.periodic(const Duration(milliseconds: 450), (timer) {
      if (!mounted || !widget.isVisible) {
        timer.cancel();
        return;
      }
      if (_stepIndex < steps.length - 1) {
        setState(() => _stepIndex++);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void didUpdateWidget(covariant KebabCookingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _startSequence();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _stepTimer?.cancel();
      _fadeController.reverse();
    }
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _fadeController.dispose();
    _sizzleController.dispose();
    _particlesController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible && _fadeController.isDismissed) {
      return const SizedBox.shrink();
    }

    final steps = widget.isReroll ? _rerollSteps : _buildSteps;
    final currentStep = steps[_stepIndex.clamp(0, steps.length - 1)];

    return AnimatedBuilder(
      animation: Listenable.merge([
        _fadeController,
        _sizzleController,
        _particlesController,
        _ingredientsController,
      ]),
      builder: (context, child) {
        final opacity = _fadeController.value;
        if (opacity == 0) return const SizedBox.shrink();

        final pulse = _sizzleController.value;
        final sizzleScale = 1.0 + (pulse * 0.05);

        return Opacity(
          opacity: opacity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Frosted glass blur backdrop
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.1,
                      colors: [
                        const Color(0xFF2C1406).withValues(alpha: 0.88),
                        const Color(0xFF0F0804).withValues(alpha: 0.95),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. Rising steam & ember particles
              CustomPaint(
                painter: _CookingParticlesPainter(
                  progress: _particlesController.value,
                ),
              ),

              // 3. Central Cooking Arena
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Top header badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFFFBA1C)
                                    .withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.restaurant,
                                  color: Color(0xFFFFBA1C),
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.isReroll
                                      ? "Ricerca Alternativa"
                                      : "Preparazione Kebab",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 36),

                          // Sizzling Kebab & Converging Ingredients Stage
                          SizedBox(
                            width: 280,
                            height: 280,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Warm golden glowing aura
                                Container(
                                  width: 220 + (pulse * 20),
                                  height: 220 + (pulse * 20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        const Color(0xFFFF6D00)
                                            .withValues(alpha: 0.35 + pulse * 0.15),
                                        const Color(0xFFFFBA1C)
                                            .withValues(alpha: 0.15),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),

                                // Spinning subtle accent ring
                                Transform.rotate(
                                  angle: _particlesController.value * 2 * math.pi,
                                  child: Container(
                                    width: 190,
                                    height: 190,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFFFFBA1C)
                                            .withValues(alpha: 0.25),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                // Central Kebab illustration with sizzle pulse
                                Transform.scale(
                                  scale: sizzleScale,
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF1E100A),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFFF6D00)
                                              .withValues(alpha: 0.4),
                                          blurRadius: 24,
                                          spreadRadius: 4,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Image.asset(
                                      "assets/images/kebabcolored.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                // Converging ingredients flying inward
                                ..._buildConvergingIngredients(),
                              ],
                            ),
                          ),

                          const SizedBox(height: 36),

                          // Dynamic Step Status Box
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.25),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Container(
                              key: ValueKey<String>(currentStep),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.45),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                              child: Text(
                                currentStep,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Glowing minimal progress dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(steps.length, (index) {
                              final isActive = index <= _stepIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: isActive ? 20 : 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFFFFBA1C)
                                      : Colors.white24,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildConvergingIngredients() {
    final widgets = <Widget>[];
    final progress = _ingredientsController.value;

    for (int i = 0; i < _ingredientMeta.length; i++) {
      final meta = _ingredientMeta[i];
      final key = meta['key'] as String;
      final asset = meta['asset'] as String;
      final angle = meta['angle'] as double;

      // Check amount from widget.ingredients if provided
      final amount = widget.ingredients?[key] ?? 5;
      if (amount <= 0 && widget.ingredients != null) {
        continue; // Skip ingredients with 0 amount
      }

      // Stagger start for each ingredient
      final staggerStart = (i * 0.12).clamp(0.0, 0.7);
      final staggerEnd = (staggerStart + 0.45).clamp(0.0, 1.0);

      final ingredientProgress = ((progress - staggerStart) / (staggerEnd - staggerStart))
          .clamp(0.0, 1.0);

      // Curve: starts outside, accelerates inward into the center kebab
      final curved = Curves.easeInOutCubic.transform(ingredientProgress);

      const startRadius = 115.0;
      const endRadius = 15.0;
      final radius = Tween<double>(begin: startRadius, end: endRadius).transform(curved);

      final dx = radius * math.cos(angle);
      final dy = radius * math.sin(angle);

      // Ingredient scale and opacity: fades/shrinks as it enters the kebab
      final itemScale = ingredientProgress < 0.8
          ? (0.6 + (0.4 * (1.0 - (ingredientProgress - 0.5).abs() * 2))).clamp(0.4, 1.1)
          : (1.0 - (ingredientProgress - 0.8) / 0.2).clamp(0.0, 1.0);

      final itemOpacity = ingredientProgress > 0.85
          ? (1.0 - (ingredientProgress - 0.85) / 0.15).clamp(0.0, 1.0)
          : (ingredientProgress * 3.0).clamp(0.0, 1.0);

      if (itemOpacity <= 0.01) continue;

      widgets.add(
        Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.scale(
            scale: itemScale,
            child: Opacity(
              opacity: itemOpacity,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFFBA1C).withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFBA1C).withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(5),
                child: Image.asset(asset, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}

/// Custom painter that draws delicate rising steam wisps and golden sizzle embers
class _CookingParticlesPainter extends CustomPainter {
  final double progress;

  _CookingParticlesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final steamPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final emberPaint = Paint()..style = PaintingStyle.fill;

    // 1. Rising Steam Wisps
    const int steamWisps = 5;
    for (int i = 0; i < steamWisps; i++) {
      final offsetPhase = (progress + (i / steamWisps)) % 1.0;
      final startY = centerY + 30 - (offsetPhase * 160);
      final alpha = math.sin(offsetPhase * math.pi) * 0.35;

      steamPaint.color = Colors.white.withValues(alpha: alpha);
      steamPaint.strokeWidth = 2.5 + (i % 2) * 1.5;

      final path = Path();
      final sway = math.sin((offsetPhase * 4 * math.pi) + i) * 16;
      final wispX = centerX + ((i - 2) * 28) + sway;

      path.moveTo(wispX, startY);
      path.quadraticBezierTo(
        wispX + sway * 1.2,
        startY - 35,
        wispX,
        startY - 70,
      );

      canvas.drawPath(path, steamPaint);
    }

    // 2. Rising Sizzle Embers
    const int emberCount = 12;
    for (int i = 0; i < emberCount; i++) {
      final emberPhase = (progress + (i * 0.083)) % 1.0;
      final emberY = centerY + 40 - (emberPhase * 180);
      final spreadX = math.sin(i * 1.7) * (30 + emberPhase * 40);
      final alpha = math.sin(emberPhase * math.pi) * 0.75;

      emberPaint.color = const Color(0xFFFF9E1B).withValues(alpha: alpha);
      final radius = (1.5 + (i % 3) * 0.8) * (1.0 - emberPhase * 0.3);

      canvas.drawCircle(Offset(centerX + spreadX, emberY), radius, emberPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CookingParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
