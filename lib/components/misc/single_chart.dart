import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class SingleChart extends StatefulWidget {
  final double vegetables;
  final double yogurt;
  final double spicy;
  final double onion;
  final bool isFront;

  const SingleChart({
    super.key,
    required this.vegetables,
    required this.yogurt,
    required this.spicy,
    required this.onion,
    required this.isFront,
  });

  @override
  State<SingleChart> createState() => _SingleChartState();
}

class _SingleChartState extends State<SingleChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.vegetables <= 0 &&
        widget.yogurt <= 0 &&
        widget.spicy <= 0 &&
        widget.onion <= 0) {
      return const SizedBox.shrink();
    }

    final textColor = widget.isFront ? Colors.black87 : Colors.white;
    final trackColor = widget.isFront
        ? Colors.grey.withValues(alpha: 0.15)
        : Colors.white.withValues(alpha: 0.15);

    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      padding: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
      decoration: BoxDecoration(
        color: widget.isFront
            ? Colors.grey.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: widget.isFront
              ? Colors.grey.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, left: 6.0),
            child: Text(
              "QUANTITÀ INGREDIENTI",
              style: TextStyle(
                color: textColor.withValues(alpha: 0.55),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildVerticalColumn(
                emoji: "🥗",
                label: S.of(context).verdura,
                value: widget.vegetables,
                textColor: textColor,
                trackColor: trackColor,
              ),
              _buildVerticalColumn(
                emoji: "🥛",
                label: S.of(context).yogurt,
                value: widget.yogurt,
                textColor: textColor,
                trackColor: trackColor,
              ),
              _buildVerticalColumn(
                emoji: "🌶️",
                label: S.of(context).spicy,
                value: widget.spicy,
                textColor: textColor,
                trackColor: trackColor,
              ),
              _buildVerticalColumn(
                emoji: "🧅",
                label: S.of(context).cipolla,
                value: widget.onion,
                textColor: textColor,
                trackColor: trackColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalColumn({
    required String emoji,
    required String label,
    required double value,
    required Color textColor,
    required Color trackColor,
  }) {
    final double targetProgress = (value / 10.0).clamp(0.0, 1.0);
    const double barHeight = 84.0;
    const double barWidth = 18.0;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Punteggio numerico in cima
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: (value % 1 == 0)
                      ? value.toInt().toString()
                      : value.toStringAsFixed(1),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: "/10",
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // Barra verticale animata in tema Kebabbo (rosso e giallo)
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: targetProgress),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, animatedProgress, child) {
              return Container(
                width: barWidth,
                height: barHeight,
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: BorderRadius.circular(barWidth / 2),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: barWidth,
                    height: barHeight * animatedProgress,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [red, yellow],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(barWidth / 2),
                      boxShadow: animatedProgress > 0
                          ? [
                              BoxShadow(
                                color: red.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          // Icona grande e ben visibile
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: widget.isFront
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.isFront
                    ? Colors.grey.shade300
                    : Colors.white.withValues(alpha: 0.25),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 6),

          // Nome ingrediente
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
