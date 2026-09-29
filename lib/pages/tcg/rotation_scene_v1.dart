import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/pages/tcg/single_card.dart';

class RotationSceneV1 extends StatefulWidget {
  final List<String> imagePaths;
  const RotationSceneV1({super.key, required this.imagePaths});

  @override
  RotationSceneV1State createState() => RotationSceneV1State();
}

class RotationSceneV1State extends State<RotationSceneV1> {
  late PageController _pageController;
  late int _initialPage;
  int _currentPage = 0;

  static const int _virtualMultiplier = 10000;

  @override
  void initState() {
    super.initState();
    final total = widget.imagePaths.length;
    if (total > 1) {
      final virtualCount = total * _virtualMultiplier;
      _initialPage = (virtualCount ~/ 2) - ((virtualCount ~/ 2) % total);
    } else {
      _initialPage = 0;
    }
    _pageController = PageController(
      viewportFraction: 0.68,
      initialPage: _initialPage,
    );
  }

  @override
  void didUpdateWidget(covariant RotationSceneV1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePaths.length != widget.imagePaths.length) {
      _pageController.dispose();
      final total = widget.imagePaths.length;
      if (total > 1) {
        final virtualCount = total * _virtualMultiplier;
        _initialPage = (virtualCount ~/ 2) - ((virtualCount ~/ 2) % total);
      } else {
        _initialPage = 0;
      }
      _currentPage = 0;
      _pageController = PageController(
        viewportFraction: 0.68,
        initialPage: _initialPage,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _formatKebabName(String path) {
    if (path.isEmpty) return '';
    final fileName = path.split('/').last.replaceAll('.png', '');
    return fileName
        .split('-')
        .where((word) => word.isNotEmpty)
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  void _openCard(String imagePath) {
    if (imagePath.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SingleCard(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalCards = widget.imagePaths.length;
    final int virtualCount =
        totalCards > 1 ? totalCards * _virtualMultiplier : totalCards;
    final String currentCardPath = totalCards > 0
        ? widget.imagePaths[_currentPage % totalCards]
        : '';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF141519),
            Color(0xFF1D1B26),
            Color(0xFF0F1013),
          ],
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double h = constraints.maxHeight;
            final double w = constraints.maxWidth;

            // Responsive sizing based on available viewport
            final double carouselHeight = (h * 0.58).clamp(280.0, 480.0);
            final double cardWidth =
                (carouselHeight * (9.0 / 16.0)).clamp(160.0, 270.0);
            final double cardHeight = cardWidth * (16.0 / 9.0);

            return Column(
              children: [
                // Top hint bar
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.swipe_outlined,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        S.maybeOf(context)?.swipe_collection_hint ??
                            'Scorri per sfogliare la collezione',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                // 3D CoverFlow Carousel
                SizedBox(
                  height: carouselHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: virtualCount,
                    onPageChanged: (index) {
                      if (totalCards > 0) {
                        setState(() {
                          _currentPage = index % totalCards;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      final int realIndex =
                          totalCards > 0 ? index % totalCards : 0;
                      final String cardPath = widget.imagePaths[realIndex];

                      return AnimatedBuilder(
                        key: ValueKey('card_${index}_$cardPath'),
                        animation: _pageController,
                        builder: (context, child) {
                          double page = 0.0;
                          if (_pageController.position.haveDimensions) {
                            page = _pageController.page ??
                                _initialPage.toDouble();
                          } else {
                            page = _initialPage.toDouble();
                          }

                          final double diff = page - index;
                          final double absDiff = diff.abs();

                          // 3D Perspective calculations
                          final double rotationY =
                              (-diff * 0.42).clamp(-0.62, 0.62);
                          final double scale =
                              (1.0 - (absDiff * 0.16)).clamp(0.82, 1.0);
                          final double translateZ = -absDiff * 35.0;
                          final double translateX = diff * 12.0;

                          final matrix = Matrix4.identity()
                            ..setEntry(3, 2, 0.0012)
                            ..translateByDouble(translateX, 0.0, translateZ, 1.0)
                            ..rotateY(rotationY)
                            ..scaleByDouble(scale, scale, 1.0, 1.0);

                          final bool isCenter = absDiff < 0.45;

                          return Center(
                            child: RepaintBoundary(
                              child: Transform(
                              alignment: Alignment.center,
                              transform: matrix,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (isCenter) {
                                    _openCard(cardPath);
                                  } else {
                                    _pageController.animateToPage(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 320),
                                      curve: Curves.easeOutCubic,
                                    );
                                  }
                                },
                                child: _buildCardItem(
                                  cardPath,
                                  cardWidth,
                                  cardHeight,
                                  isCenter,
                                  absDiff,
                                ),
                              ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const Spacer(flex: 2),

                // Card Details Panel
                Container(
                  width: (w * 0.88).clamp(280.0, 420.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2128),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Badge index (#1 di 18)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: red.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: red.withValues(alpha: 0.35)),
                        ),
                        child: Text(
                          S.of(context).card_x_of_y((_currentPage + 1).toString(), totalCards.toString()),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF5252),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Kebab Name
                      Text(
                        _formatKebabName(currentCardPath),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Indicator dots or progress bar
                      if (totalCards > 1 && totalCards <= 10)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(totalCards, (i) {
                            final bool active = i == _currentPage;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              width: active ? 16 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: active ? red : Colors.white24,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        )
                      else if (totalCards > 10)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                            width: 140,
                            height: 4,
                            child: LinearProgressIndicator(
                              value: (_currentPage + 1) / totalCards,
                              backgroundColor: Colors.white12,
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(red),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Action button: inspect in 3D
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () => _openCard(currentCardPath),
                          icon: const Icon(Icons.view_in_ar, size: 20),
                          label: Text(
                            S.maybeOf(context)?.examine_3d ?? 'Esamina in 3D',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardItem(
    String path,
    double width,
    double height,
    bool isCenter,
    double absDiff,
  ) {
    const double borderRadius = 18.0;

    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: isCenter
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.26),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: const Color(0xFFFFBA1C).withValues(alpha: 0.28),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Card image
              Image.asset(
                path,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                // Le carte sono 1080x1920: decodificarle alla dimensione
                // mostrata evita ~8 MB di memoria per carta.
                cacheWidth:
                    (width * MediaQuery.devicePixelRatioOf(context)).round(),
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                    ),
                  );
                },
              ),

              // Side card dimming overlay
              if (!isCenter)
                Container(
                  color: Colors.black.withValues(
                    alpha: (absDiff * 0.35).clamp(0.0, 0.45),
                  ),
                ),

              // Glowing border when centered
              if (isCenter)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: const Color(0xFFFFBA1C).withValues(alpha: 0.7),
                      width: 2.5,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
