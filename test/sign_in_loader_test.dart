import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/components/animations/doner_loader.dart';

import 'test_helpers.dart';

void main() {
  Future<BuildContext> pumpHost(WidgetTester tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(localizedApp(
      home: Builder(builder: (context) {
        ctx = context;
        return const Scaffold(body: SizedBox());
      }),
    ));
    return ctx;
  }

  testWidgets('A fast sign-in never shows the loader', (tester) async {
    final context = await pumpHost(tester);
    final done = runWithSignInLoader(context, signIn: () async {});
    await tester.pump(const Duration(milliseconds: 500));
    await done;
    expect(find.byType(DonerSpitLoader), findsNothing);
  });

  testWidgets('A slow sign-in shows the full-screen loader, then removes it',
      (tester) async {
    final context = await pumpHost(tester);
    final signIn = Completer<void>();
    final profile = Completer<void>();
    final done = runWithSignInLoader(
      context,
      signIn: () => signIn.future,
      loadProfile: () => profile.future,
    );

    await tester.pump(const Duration(milliseconds: 450));
    expect(find.byType(DonerSpitLoader), findsOneWidget);
    expect(find.text('Ti stiamo facendo entrare'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsNothing);

    signIn.complete();
    await tester.pump();
    expect(find.byIcon(Icons.check), findsOneWidget); // accesso fatto

    profile.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await done;
    await tester.pump();
    expect(find.byType(DonerSpitLoader), findsNothing);
  });

  testWidgets('Sign-in errors reach the caller and the loader goes away',
      (tester) async {
    final context = await pumpHost(tester);
    final signIn = Completer<void>();
    final done = runWithSignInLoader(context, signIn: () => signIn.future);
    await tester.pump(const Duration(milliseconds: 450));
    expect(find.byType(DonerSpitLoader), findsOneWidget);

    signIn.completeError(Exception('Invalid login credentials'));
    await expectLater(done, throwsException);
    await tester.pump();
    expect(find.byType(DonerSpitLoader), findsNothing);
  });
}
