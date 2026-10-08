import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colori del brand Kebabbo, con un nome per ogni uso.
/// Prima di aggiungere un `Color(0xFF...)` in una pagina, usa (o aggiungi) uno di questi.
class AppColors {
  AppColors._();

  // Brand
  static const Color red = Color.fromRGBO(187, 0, 0, 1.0); // #BB0000
  static const Color saffron = Color(0xFFFFBA1C);
  static const Color gold = Color(0xFFFFD700);
  static const Color char = Color(0xFF2B1A12); // testo scuro caldo
  static const Color muted = Color(0xFF7A6A60); // testo secondario

  // Significati
  static const Color staff = Color(0xFF1D9BF0); // verificato dallo staff
  static const Color community = Color(0xFF7B3FA0);
  static const Color mapsBlue = Color(0xFF1A73E8);
  static const Color open = Color(0xFF34A853);
  static const Color openText = Color(0xFF137333);
  static const Color openBg = Color(0xFFE6F4EA);
  static const Color success = Color(0xFF2E7D32);
  static const Color successDark = Color(0xFF1B5E20);
  static const Color successLight = Color(0xFF81C784);
  static const Color glutenFree = Color(0xFFB06000);
  static const Color glutenFreeBg = Color(0xFFFEF7E0);
  static const Color amber = Color(0xFFFFB300);
  static const Color info = Color(0xFF1565C0);
}

/// Font: Figtree per il testo, Bricolage Grotesque per i titoli
/// (richiama il lettering "street food" del logo).
TextTheme _textTheme(TextTheme base) {
  final body = GoogleFonts.figtreeTextTheme(base);
  TextStyle? display(TextStyle? s) => s == null
      ? null
      : GoogleFonts.bricolageGrotesque(textStyle: s, fontWeight: FontWeight.w800);
  return body.copyWith(
    displayLarge: display(body.displayLarge),
    displayMedium: display(body.displayMedium),
    displaySmall: display(body.displaySmall),
    headlineLarge: display(body.headlineLarge),
    headlineMedium: display(body.headlineMedium),
    headlineSmall: display(body.headlineSmall),
    titleLarge: display(body.titleLarge),
  ).apply(bodyColor: AppColors.char, displayColor: AppColors.char);
}

/// Stile delle intestazioni grandi (nome del kebab, titoli di pagina).
TextStyle headingStyle({double size = 22, Color color = AppColors.char}) =>
    GoogleFonts.bricolageGrotesque(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
      letterSpacing: -0.3,
    );

ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.red,
    primary: AppColors.red,
    onPrimary: Colors.white,
    secondary: AppColors.saffron,
    onSecondary: AppColors.char,
    surface: Colors.white,
    onSurface: AppColors.char,
    error: const Color(0xFFB3261E),
  );
  final text = _textTheme(base.textTheme);
  final rounded14 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));

  return base.copyWith(
    colorScheme: scheme,
    primaryColor: AppColors.red,
    scaffoldBackgroundColor: AppColors.saffron,
    textTheme: text,
    primaryTextTheme: text,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.saffron,
      foregroundColor: AppColors.char,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: headingStyle(size: 20),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.red,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.red,
        shape: rounded14,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.red,
        foregroundColor: Colors.white,
        shape: rounded14,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.char,
        shape: rounded14,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.red, width: 1.6),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: headingStyle(size: 20),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.char,
      contentTextStyle: GoogleFonts.figtree(color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.red),
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.red,
      thumbColor: AppColors.red,
      inactiveTrackColor: Color(0xFFF1E6DC),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? AppColors.red : null),
      trackColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? AppColors.red.withValues(alpha: 0.35) : null),
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      side: BorderSide.none,
    ),
  );
}
