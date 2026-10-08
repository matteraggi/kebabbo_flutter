import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/utils/app_theme.dart';

/// Introduzione mostrata alla prima apertura: tre schermate da scorrere.
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroSlide {
  final String image;
  final IconData badge;
  final String Function(S) title;
  final String Function(S) text;

  const _IntroSlide(this.image, this.badge, this.title, this.text);
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  int _page = 0;

  static final List<_IntroSlide> _slides = [
    _IntroSlide('assets/images/kebabcolored.png', Icons.place_rounded,
        (s) => s.intro_1_title, (s) => s.intro_1_text),
    _IntroSlide('assets/images/sandwitch.png', Icons.edit_rounded,
        (s) => s.intro_2_title, (s) => s.intro_2_text),
    _IntroSlide('assets/images/10_review_medal.png', Icons.style_rounded,
        (s) => s.intro_3_title, (s) => s.intro_3_text),
  ];

  bool get _isLast => _page == _slides.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_isLast) {
      Navigator.of(context).pop();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.saffron,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: AnimatedOpacity(
                  opacity: _isLast ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: TextButton(
                    onPressed:
                        _isLast ? null : () => Navigator.of(context).pop(),
                    style:
                        TextButton.styleFrom(foregroundColor: AppColors.char),
                    child: Text(s.intro_skip),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) {
                  final slide = _slides[i];
                  return LayoutBuilder(builder: (context, box) {
                    // Su schermi bassi l'illustrazione si rimpicciolisce e,
                    // se serve ancora spazio, la schermata scorre.
                    final double art =
                        (box.maxHeight * 0.38).clamp(110.0, 210.0);
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: box.maxHeight),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: art,
                                height: art,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.55),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(art * 0.19),
                                      child: Image.asset(slide.image,
                                          fit: BoxFit.contain),
                                    ),
                                    Positioned(
                                      right: 8,
                                      bottom: 10,
                                      child: Container(
                                        width: 58,
                                        height: 58,
                                        decoration: BoxDecoration(
                                          color: AppColors.red,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                        ),
                                        child: Icon(slide.badge,
                                            color: Colors.white, size: 26),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: art * 0.17),
                              Text(
                                slide.title(s),
                                textAlign: TextAlign.center,
                                style: headingStyle(size: 30),
                              ),
                              const SizedBox(height: 12),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 340),
                                child: Text(
                                  slide.text(s),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.45,
                                    color:
                                        AppColors.char.withValues(alpha: 0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            // Indicatore di posizione: è una sequenza, quindi i puntini hanno senso.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                final active = i == _page;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.red
                        : AppColors.char.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(
                    _isLast ? s.intro_start : s.intro_next,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
