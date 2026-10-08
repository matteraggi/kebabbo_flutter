import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/utils/app_theme.dart';

/// Schermata vuota coerente in tutta l'app: illustrazione del kebab con un
/// piccolo badge che indica il contesto, titolo, testo e un'azione opzionale.
class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData badgeIcon;
  final String illustration;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  /// true sullo sfondo giallo dell'app, false su sfondo bianco/chiaro.
  final bool onSaffron;

  /// false quando è dentro una lista o una pagina che scorre già.
  final bool scrollable;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    required this.badgeIcon,
    this.illustration = 'assets/images/kebabcolored.png',
    this.actionLabel,
    this.actionIcon,
    this.onAction,
    this.onSaffron = false,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final circle = onSaffron
        ? Colors.white.withValues(alpha: 0.55)
        : AppColors.saffron.withValues(alpha: 0.22);

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 128,
            height: 128,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: circle, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(26),
                  child: Image.asset(illustration, fit: BoxFit.contain),
                ),
                Positioned(
                  right: 2,
                  bottom: 4,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Icon(badgeIcon, color: Colors.white, size: 19),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: headingStyle(size: 20),
          ),
          if (message != null) ...[
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.4,
                  color: onSaffron
                      ? AppColors.char.withValues(alpha: 0.75)
                      : AppColors.muted,
                ),
              ),
            ),
          ],
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: Icon(actionIcon ?? Icons.add, size: 18),
              label: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
    if (!scrollable) return content;
    return Center(child: SingleChildScrollView(child: content));
  }
}
