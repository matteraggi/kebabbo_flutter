import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/components/animations/kebab_cooking_overlay.dart';

void main() {
  group('KebabCookingOverlay Tests', () {
    testWidgets('Hidden when isVisible is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KebabCookingOverlay(
              isVisible: false,
            ),
          ),
        ),
      );

      expect(find.text('Preparazione Kebab'), findsNothing);
      expect(find.byType(KebabCookingOverlay), findsOneWidget);
    });

    testWidgets('Renders properly when isVisible is true with ingredients',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KebabCookingOverlay(
              isVisible: true,
              isReroll: false,
              ingredients: {
                'meat': 7,
                'onion': 4,
                'spicy': 2,
                'yogurt': 5,
                'vegetables': 6,
              },
            ),
          ),
        ),
      );

      // Advance initial frame and animation
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Preparazione Kebab'), findsOneWidget);
      expect(find.text('🔥 Scaldo la piadina...'), findsOneWidget);
    });

    testWidgets('Renders reroll mode properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KebabCookingOverlay(
              isVisible: true,
              isReroll: true,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Ricerca Alternativa'), findsOneWidget);
      expect(find.text('👨‍🍳 Nuova combinazione in arrivo...'), findsOneWidget);
    });
  });
}
