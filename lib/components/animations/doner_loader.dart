import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/utils/app_theme.dart';

/// Spiedo di kebab che gira, con un coltello che lo affetta e le fette che cadono.
class DonerSpitLoader extends StatefulWidget {
  final double height;

  /// Testo letto dagli screen reader (default: "Caricamento").
  final String? semanticLabel;

  const DonerSpitLoader({super.key, this.height = 200, this.semanticLabel});

  @override
  State<DonerSpitLoader> createState() => _DonerSpitLoaderState();
}

class _DonerSpitLoaderState extends State<DonerSpitLoader>
    with SingleTickerProviderStateMixin {
  // Un ciclo = una passata del coltello dall'alto in basso.
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _controller.value = 0.4;
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.height;
    return Semantics(
      label: widget.semanticLabel ?? S.of(context).loading,
      child: SizedBox(
        width: h * 0.95,
        height: h,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => CustomPaint(
            painter: _DonerPainter(_controller.value),
          ),
        ),
      ),
    );
  }
}

/// Il caricamento di Kebabbo, uguale ovunque (app e sito): spiedo, titolo
/// rosso, sottotitolo e, se serve, qualcosa sotto (es. i passi dell'accesso).
class KebabLoadingView extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? footer;
  final double spitHeight;

  const KebabLoadingView({
    super.key,
    required this.title,
    required this.subtitle,
    this.footer,
    this.spitHeight = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DonerSpitLoader(height: spitHeight, semanticLabel: title),
            const SizedBox(height: 22),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: headingStyle(size: 22, color: AppColors.red),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.4,
                      color: AppColors.char.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
            ),
            if (footer != null) ...[
              const SizedBox(height: 22),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Caricamento a pagina intera dell'app, con lo stesso testo del sito.
class KebabLoader extends StatelessWidget {
  const KebabLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return KebabLoadingView(title: s.loader_title, subtitle: s.loader_subtitle);
  }
}

class _DonerPainter extends CustomPainter {
  final double t; // 0..1

  _DonerPainter(this.t);

  static const _meat = [
    Color(0xFFB95E24),
    Color(0xFFA2481A),
    Color(0xFFCF7A36),
    Color(0xFF6E2A0C),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.33; // lo spiedo è a sinistra, il coltello a destra
    final coneTop = h * 0.08;
    final coneBottom = h * 0.83;
    final topHalf = w * 0.27;
    final bottomHalf = w * 0.15;

    // Posizione verticale del coltello in funzione del tempo (0..1):
    // scende lentamente lungo il cono e risale veloce.
    double knifeY(double time) {
      final tt = time % 1;
      final down = tt < 0.78
          ? Curves.easeInOut.transform(tt / 0.78)
          : 1 - Curves.easeIn.transform((tt - 0.78) / 0.22);
      return coneTop + 18 + down * (coneBottom - coneTop - 36);
    }

    double edgeAt(double y) =>
        cx +
        topHalf +
        (bottomHalf - topHalf) * ((y - coneTop) / (coneBottom - coneTop));

    // --- asta e base ---
    final rodPaint = Paint()
      ..shader = LinearGradient(
        colors: const [Color(0xFF8F8F8F), Color(0xFFE7E7E7), Color(0xFF8F8F8F)],
      ).createShader(Rect.fromLTWH(cx - 3, 0, 6, h));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(cx - 3, 0, 6, h * 0.97), const Radius.circular(3)),
        rodPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(cx, h * 0.02), width: 20, height: 9),
            const Radius.circular(4)),
        Paint()..color = const Color(0xFF9A9A9A));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, h * 0.97), width: w * 0.5, height: 8),
            const Radius.circular(4)),
        Paint()..color = const Color(0xFF7D7D7D));

    // --- sciabola: inclinata verso l'alto, la lama passa DIETRO la carne.
    // Si vedono l'elsa a destra e la punta che spunta a sinistra; scende lungo
    // il cono e risale veloce, come chi affetta il kebab.
    final ky = knifeY(t);
    final edgeX = edgeAt(ky); // bordo del cono all'altezza della lama
    final saw =
        math.sin(t * math.pi * 2 * 6) * 2; // piccolo movimento di taglio
    final bladeLen = w * 0.66;

    canvas.save();
    canvas.translate(edgeX + 12 + saw, ky);
    canvas.rotate(0.38); // punta verso l'alto a sinistra
    final blade = Path()
      ..moveTo(0, -3.5)
      ..quadraticBezierTo(-bladeLen * 0.55, -5, -bladeLen, -15) // dorso
      ..quadraticBezierTo(-bladeLen * 0.55, 4, 0, 4.5) // filo
      ..close();
    canvas.drawPath(
      blade,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF7F7F7), Color(0xFFC3C8CE), Color(0xFF8D949B)],
        ).createShader(Rect.fromLTWH(-bladeLen, -15, bladeLen, 20)),
    );
    // guardia dorata
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, -8, 4.5, 16), const Radius.circular(2)),
      Paint()..color = const Color(0xFFD4A017),
    );
    // impugnatura e pomolo
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(4.5, -4.5, w * 0.16, 9), const Radius.circular(4)),
      Paint()..color = const Color(0xFF3A2416),
    );
    canvas.drawCircle(Offset(4.5 + w * 0.16 + 2, 0), 4,
        Paint()..color = const Color(0xFFD4A017));
    canvas.restore();

    // --- cono di carne ---
    final cone = Path()
      ..moveTo(cx - topHalf + 4, coneTop)
      ..quadraticBezierTo(cx, coneTop - 8, cx + topHalf - 4, coneTop)
      ..lineTo(cx + topHalf, coneTop + 10)
      ..lineTo(cx + bottomHalf, coneBottom)
      ..quadraticBezierTo(cx, coneBottom + 6, cx - bottomHalf, coneBottom)
      ..lineTo(cx - topHalf, coneTop + 10)
      ..close();

    canvas.save();
    canvas.clipPath(cone);
    // Strisce verticali che scorrono: danno l'idea della rotazione.
    const period = 52.0;
    final shift = (t * 2 % 1) * period; // due giri per passata del coltello
    final stripeWidths = [11.0, 7.0, 5.0, 3.0];
    double x = cx - topHalf - period + shift;
    while (x < cx + topHalf) {
      for (var i = 0; i < 4; i++) {
        final sw = stripeWidths[i] * (period / 26);
        canvas.drawRect(Rect.fromLTWH(x, coneTop - 10, sw + 0.5, h),
            Paint()..color = _meat[i]);
        x += sw;
      }
    }
    // Strati orizzontali della carne impilata.
    final layer = Paint()
      ..color = const Color(0xFF3C0F00).withValues(alpha: 0.30)
      ..strokeWidth = 2;
    for (double y = coneTop + 9; y < coneBottom; y += 12) {
      canvas.drawLine(
          Offset(cx - topHalf, y), Offset(cx + topHalf, y + 1.5), layer);
    }
    // Ombra ai lati e riflesso al centro: volume cilindrico.
    canvas.drawRect(
      Rect.fromLTRB(cx - topHalf, coneTop - 10, cx + topHalf, coneBottom + 10),
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.5),
            Colors.transparent,
            const Color(0xFFFFD696).withValues(alpha: 0.22),
            Colors.transparent,
            Colors.black.withValues(alpha: 0.55),
          ],
          stops: const [0, 0.28, 0.48, 0.7, 1],
        ).createShader(Rect.fromLTRB(cx - topHalf, 0, cx + topHalf, h)),
    );
    canvas.restore();

    // --- fette che cadono dal punto di taglio ---
    // Ogni fetta nasce dove si trovava il coltello e cade verso il basso.
    const lifetime = 0.42; // frazione del ciclo
    const slices = 9;
    for (var i = 0; i < slices; i++) {
      final age = ((t + i / slices) % 1) * lifetime * slices / 4 % lifetime;
      final sizeFactor =
          0.65 + (i * 37 % 10) / 20; // 0.65..1.1, varia per fetta
      final p = age / lifetime; // 0..1
      final birth = t - age;
      final startY = knifeY(birth < 0 ? birth + 1 : birth);
      final sx = edgeAt(startY) + 2 + p * (10 + (i % 3) * 6);
      final sy = startY + p * p * (h * 0.95 - startY);
      final opacity = (p < 0.1 ? p / 0.1 : 1 - (p - 0.1) / 0.9).clamp(0.0, 1.0);
      canvas.save();
      canvas.translate(sx, sy);
      canvas.rotate(p * 4 + i);
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset.zero,
            width: 14 * sizeFactor,
            height: 6 * sizeFactor),
        Paint()..color = _meat[i % 3].withValues(alpha: opacity),
      );
      canvas.drawOval(
        Rect.fromCenter(
            center: const Offset(-1, -1),
            width: 8 * sizeFactor,
            height: 2.5 * sizeFactor),
        Paint()
          ..color = const Color(0xFF6E2A0C).withValues(alpha: opacity * 0.6),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_DonerPainter old) => old.t != t;
}

/// Schermata di caricamento a pieno schermo durante l'accesso.
class _SignInLoaderScreen extends StatelessWidget {
  final ValueNotifier<int> step; // 0 = accesso, 1 = profilo, 2 = finito

  const _SignInLoaderScreen({required this.step});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    Widget stepRow(String label, bool done, bool active) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? AppColors.red : Colors.transparent,
                border: Border.all(
                  color: done || active
                      ? AppColors.red
                      : AppColors.char.withValues(alpha: 0.35),
                  width: 2,
                ),
              ),
              child: done
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: done || active ? FontWeight.w600 : FontWeight.w400,
                color:
                    AppColors.char.withValues(alpha: done || active ? 1 : 0.6),
              ),
            ),
          ],
        );

    return Material(
      color: AppColors.saffron,
      child: SafeArea(
        child: KebabLoadingView(
          title: s.login_loader_title,
          subtitle: s.login_loader_subtitle,
          spitHeight: 170,
          footer: ValueListenableBuilder<int>(
            valueListenable: step,
            builder: (context, value, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                stepRow(s.login_step_auth, value > 0, value == 0),
                const SizedBox(height: 10),
                stepRow(s.login_step_profile, value > 1, value == 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Esegue [signIn] mostrando il caricamento a pieno schermo se dura più di
/// 400 ms; poi controlla che il profilo sia leggibile ([loadProfile]).
/// Gli errori vengono rilanciati, così la pagina di login li mostra come prima.
Future<void> runWithSignInLoader(
  BuildContext context, {
  required Future<void> Function() signIn,
  Future<void> Function()? loadProfile,
}) async {
  final overlay = Overlay.of(context, rootOverlay: true);
  final step = ValueNotifier<int>(0);
  OverlayEntry? entry;
  final timer = Timer(const Duration(milliseconds: 400), () {
    entry = OverlayEntry(builder: (_) => _SignInLoaderScreen(step: step));
    overlay.insert(entry!);
  });

  try {
    await signIn();
    step.value = 1;
    if (loadProfile != null) {
      try {
        await loadProfile();
      } catch (e) {
        // Il profilo verrà ricaricato dalla pagina account: non blocca l'accesso.
        debugPrint('Profilo non caricato durante il login: $e');
      }
    }
    step.value = 2;
    if (entry != null) {
      await Future.delayed(const Duration(milliseconds: 250));
    }
  } finally {
    timer.cancel();
    entry?.remove();
    step.dispose();
  }
}
