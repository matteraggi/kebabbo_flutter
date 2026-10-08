import 'package:flutter/material.dart';

/// Colori dei blocchi segnaposto: dorati sullo sfondo giallo, grigio caldo
/// sulle schermate chiare, così il caricamento resta "Kebabbo".
class _Bone {
  static const Color gold = Color(0xFFF6E2B0);
  static const Color goldHi = Color(0xFFFFF0CC);
  static const Color warm = Color(0xFFEFE8E1);
  static const Color warmHi = Color(0xFFFAF6F2);
}

/// Fornisce ai blocchi [SkeletonBox] figli il colore e il riflesso animato.
class SkeletonShimmer extends StatefulWidget {
  final Widget child;
  final bool gold;

  const SkeletonShimmer({super.key, required this.child, this.gold = false});

  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Rispetta "riduci animazioni" del sistema.
    if (MediaQuery.of(context).disableAnimations) {
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
    return _SkeletonScope(
      base: widget.gold ? _Bone.gold : _Bone.warm,
      highlight: widget.gold ? _Bone.goldHi : _Bone.warmHi,
      animation: _controller,
      child: widget.child,
    );
  }
}

class _SkeletonScope extends InheritedWidget {
  final Color base;
  final Color highlight;
  final Animation<double> animation;

  const _SkeletonScope({
    required this.base,
    required this.highlight,
    required this.animation,
    required super.child,
  });

  static _SkeletonScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_SkeletonScope>();

  @override
  bool updateShouldNotify(_SkeletonScope old) =>
      old.base != base ||
      old.highlight != highlight ||
      old.animation != animation;
}

/// Un blocco segnaposto (testo, immagine, pulsante, avatar) con riflesso.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;
  final bool circle;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.radius = 8,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    final scope = _SkeletonScope.of(context);
    final base = scope?.base ?? _Bone.warm;
    final hi = scope?.highlight ?? _Bone.warmHi;
    final shape = circle ? BoxShape.circle : BoxShape.rectangle;
    final radiusValue = circle ? null : BorderRadius.circular(radius);

    Widget box(double v) => Container(
          width: circle ? height : width,
          height: height,
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: radiusValue,
            gradient: LinearGradient(
              colors: [base, hi, base],
              stops: const [0.35, 0.5, 0.65],
              // il riflesso attraversa il blocco da sinistra a destra
              begin: Alignment(-3 + v * 4, 0),
              end: Alignment(-1 + v * 4, 0),
            ),
          ),
        );

    if (scope == null) return box(0);
    return AnimatedBuilder(
      animation: scope.animation,
      builder: (context, _) => box(scope.animation.value),
    );
  }
}

/// Lista della home: come le card vere (nome, stato, stelle, distanza).
class HomeListSkeleton extends StatelessWidget {
  const HomeListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget card(double nameFactor, double distFactor) => Card(
          margin: const EdgeInsets.only(bottom: 10),
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 4,
          shadowColor: Colors.grey,
          child: SizedBox(
            height: 124,
            child: Stack(
              children: [
                const Positioned(
                    top: 16,
                    left: 16,
                    child: SkeletonBox(height: 24, circle: true)),
                const Positioned(
                    top: 18,
                    right: 18,
                    child: SkeletonBox(width: 18, height: 22, radius: 4)),
                Center(
                  child: LayoutBuilder(builder: (context, box) {
                    final w = box.maxWidth;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SkeletonBox(width: w * nameFactor, height: 20),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (_) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: SkeletonBox(height: 18, circle: true),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SkeletonBox(width: w * distFactor, height: 10),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );

    return SkeletonShimmer(
      gold: true,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 16),
            const SkeletonBox(height: 50, radius: 25),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(child: SkeletonBox(height: 48, radius: 30)),
                SizedBox(width: 12),
                SkeletonBox(height: 48, circle: true),
              ],
            ),
            const SizedBox(height: 16),
            card(0.55, 0.35),
            card(0.45, 0.4),
            card(0.6, 0.3),
            card(0.4, 0.38),
            card(0.5, 0.33),
          ],
        ),
      ),
    );
  }
}

/// Pagina del singolo kebab: foto, chip, voto, azioni, schede.
class KebabPageSkeleton extends StatelessWidget {
  const KebabPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget whiteCard(List<Widget> children) => Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );

    return Container(
      color: const Color(0xFFFAF7F4),
      child: SkeletonShimmer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const SkeletonBox(height: 250, radius: 0),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: const [
                    SkeletonBox(width: 70, height: 24, radius: 12),
                    SizedBox(width: 8),
                    SkeletonBox(width: 96, height: 24, radius: 12),
                    SizedBox(width: 8),
                    SkeletonBox(width: 80, height: 24, radius: 12),
                  ]),
                  const SizedBox(height: 14),
                  Row(
                    children: List.generate(
                      4,
                      (i) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
                          child: const SkeletonBox(height: 54, radius: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SkeletonBox(width: 80, height: 12),
                  SkeletonBox(width: 70, height: 12),
                  SkeletonBox(width: 90, height: 12),
                ],
              ),
            ),
            whiteCard(const [
              SkeletonBox(width: 160, height: 14),
              SizedBox(height: 12),
              SkeletonBox(height: 11),
              SizedBox(height: 8),
              SkeletonBox(width: 220, height: 11),
            ]),
            whiteCard(const [
              SkeletonBox(width: 110, height: 14),
              SizedBox(height: 14),
              SkeletonBox(height: 10),
              SizedBox(height: 12),
              SkeletonBox(height: 10),
              SizedBox(height: 12),
              SkeletonBox(height: 10),
            ]),
          ],
        ),
      ),
    );
  }
}

/// Profilo utente: scheda con avatar, nome, pulsante e statistiche, poi lista.
class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      gold: true,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const SkeletonBox(height: 104, circle: true),
                const SizedBox(height: 14),
                const SkeletonBox(width: 140, height: 18),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SkeletonBox(width: 70, height: 22, radius: 11),
                    SizedBox(width: 8),
                    SkeletonBox(width: 90, height: 22, radius: 11),
                  ],
                ),
                const SizedBox(height: 16),
                const SkeletonBox(height: 46, radius: 14),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(
                    4,
                    (_) => const Expanded(
                      child: Column(
                        children: [
                          SkeletonBox(width: 28, height: 18),
                          SizedBox(height: 6),
                          SkeletonBox(width: 50, height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SkeletonBox(height: 44, radius: 22),
          const SizedBox(height: 14),
          for (var i = 0; i < 3; i++) ...[
            Container(
              height: 96,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: const [
                  SkeletonBox(height: 40, circle: true),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBox(width: 150, height: 13),
                        SizedBox(height: 8),
                        SkeletonBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
