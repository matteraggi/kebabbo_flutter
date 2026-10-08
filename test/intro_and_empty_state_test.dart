import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/components/misc/empty_state.dart';
import 'package:kebabbo_flutter/pages/misc/intro_page.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('Intro goes through three slides and closes on the last one',
      (tester) async {
    await tester.pumpWidget(localizedApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const IntroPage()),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Trova il tuo kebab'), findsOneWidget);
    await tester.tap(find.text('Avanti'));
    await tester.pumpAndSettle();
    expect(find.text('Recensisci e condividi'), findsOneWidget);
    await tester.tap(find.text('Avanti'));
    await tester.pumpAndSettle();
    expect(find.text('Colleziona medaglie e carte'), findsOneWidget);

    await tester.tap(find.text('Inizia'));
    await tester.pumpAndSettle();
    expect(find.byType(IntroPage), findsNothing);
  });

  testWidgets('Intro follows the device language', (tester) async {
    await tester.pumpWidget(
        localizedApp(locale: const Locale('en'), home: const IntroPage()));
    await tester.pumpAndSettle();
    expect(find.text('Find your kebab'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });

  testWidgets('EmptyState shows its action and calls it', (tester) async {
    var tapped = false;
    await tester.pumpWidget(localizedApp(
      home: Scaffold(
        body: EmptyState(
          title: 'Nessuna foto ancora',
          message: 'Carica la prima',
          badgeIcon: Icons.photo_camera_rounded,
          actionLabel: 'Carica la prima foto',
          onAction: () => tapped = true,
        ),
      ),
    ));
    expect(find.text('Nessuna foto ancora'), findsOneWidget);
    await tester.tap(find.text('Carica la prima foto'));
    expect(tapped, isTrue);
  });
}
