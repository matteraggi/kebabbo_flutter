import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

/// MaterialApp con i delegate di localizzazione dell'app (italiano di default).
Widget localizedApp({required Widget home, Locale locale = const Locale('it')}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: home,
  );
}
