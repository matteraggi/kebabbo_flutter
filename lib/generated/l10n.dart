// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get title {
    return Intl.message(
      'Welcome',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Flutter`
  String get description {
    return Intl.message(
      'Welcome to Flutter',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Name not available`
  String get nome_non_disponibile {
    return Intl.message(
      'Name not available',
      name: 'nome_non_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `Select your favorite kebab`
  String get seleziona_il_tuo_kebab_preferito {
    return Intl.message(
      'Select your favorite kebab',
      name: 'seleziona_il_tuo_kebab_preferito',
      desc: '',
      args: [],
    );
  }

  /// `Recommend a kebab place`
  String get consigliaci_un_kebabbaro {
    return Intl.message(
      'Recommend a kebab place',
      name: 'consigliaci_un_kebabbaro',
      desc: '',
      args: [],
    );
  }

  /// `Name of the kebab place`
  String get nome_del_kebabbaro {
    return Intl.message(
      'Name of the kebab place',
      name: 'nome_del_kebabbaro',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get annulla {
    return Intl.message(
      'Cancel',
      name: 'annulla',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get invia {
    return Intl.message(
      'Send',
      name: 'invia',
      desc: '',
      args: [],
    );
  }

  /// `Your solution for university lunch`
  String get la_tua_soluzione_per_il_pranzo_universitario {
    return Intl.message(
      'Your solution for university lunch',
      name: 'la_tua_soluzione_per_il_pranzo_universitario',
      desc: '',
      args: [],
    );
  }

  /// `In Italy, the world of Kebab is still a dark world. The best places are underrated, and the worst ones get high reviews on Google.`
  String
      get in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google {
    return Intl.message(
      'In Italy, the world of Kebab is still a dark world. The best places are underrated, and the worst ones get high reviews on Google.',
      name:
          'in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google',
      desc: '',
      args: [],
    );
  }

  /// `That's why we are here: university students, like you, with years of experience as Kebab eaters.`
  String
      get per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab {
    return Intl.message(
      'That\'s why we are here: university students, like you, with years of experience as Kebab eaters.',
      name:
          'per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab',
      desc: '',
      args: [],
    );
  }

  /// `We test and review Kebab places and Street Food for you. Welcome to Kebabbo.`
  String
      get testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo {
    return Intl.message(
      'We test and review Kebab places and Street Food for you. Welcome to Kebabbo.',
      name:
          'testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load reviews count`
  String get failed_to_load_reviews_count {
    return Intl.message(
      'Failed to load reviews count',
      name: 'failed_to_load_reviews_count',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load follower count`
  String get failed_to_load_follower_count {
    return Intl.message(
      'Failed to load follower count',
      name: 'failed_to_load_follower_count',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
