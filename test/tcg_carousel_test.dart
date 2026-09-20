import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/pages/tcg/rotation_scene_v1.dart';

void main() {
  group('RotationSceneV1 (CoverFlow Carousel) Tests', () {
    testWidgets('Renders CoverFlow carousel with cards',
        (WidgetTester tester) async {
      final List<String> testCards = [
        'assets/kebab-card/ali-baba-food-house.png',
        'assets/kebab-card/baba-turkish.png',
        'assets/kebab-card/dr-jimmy.png',
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotationSceneV1(imagePaths: testCards),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RotationSceneV1), findsOneWidget);
      expect(find.text('Scorri per sfogliare la collezione'), findsOneWidget);
      expect(find.text('#1 di 3'), findsOneWidget);
      expect(find.text('Ali Baba Food House'), findsOneWidget);
      expect(find.text('Esamina in 3D'), findsOneWidget);
    });

    testWidgets('Renders cleanly with a single card',
        (WidgetTester tester) async {
      final List<String> testCards = [
        'assets/kebab-card/dr-jimmy.png',
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RotationSceneV1(imagePaths: testCards),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RotationSceneV1), findsOneWidget);
      expect(find.text('#1 di 1'), findsOneWidget);
      expect(find.text('Dr Jimmy'), findsOneWidget);
    });
  });
}
