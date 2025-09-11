import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_de.dart';
import 'l10n_en.dart';
import 'l10n_es.dart';
import 'l10n_fr.dart';
import 'l10n_it.dart';
import 'l10n_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt')
  ];

  /// No description provided for @nome_non_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Nome non disponibile'**
  String get nome_non_disponibile;

  /// No description provided for @seleziona_il_tuo_kebab_preferito.
  ///
  /// In it, this message translates to:
  /// **'Seleziona il tuo kebab preferito'**
  String get seleziona_il_tuo_kebab_preferito;

  /// No description provided for @consigliaci_un_kebabbaro.
  ///
  /// In it, this message translates to:
  /// **'Consigliaci un kebabbaro'**
  String get consigliaci_un_kebabbaro;

  /// No description provided for @nome_del_kebabbaro.
  ///
  /// In it, this message translates to:
  /// **'Nome del kebabbaro'**
  String get nome_del_kebabbaro;

  /// No description provided for @annulla.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get annulla;

  /// No description provided for @invia.
  ///
  /// In it, this message translates to:
  /// **'Invia'**
  String get invia;

  /// No description provided for @la_tua_soluzione_per_il_pranzo_universitario.
  ///
  /// In it, this message translates to:
  /// **'La tua soluzione per il pranzo universitario'**
  String get la_tua_soluzione_per_il_pranzo_universitario;

  /// No description provided for @in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google.
  ///
  /// In it, this message translates to:
  /// **'In Italia il mondo del Kebab è ancora un mondo oscuro. I migliori locali sono sottovalutati, e i peggiori ricevono recensioni alte su Google.'**
  String
      get in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google;

  /// No description provided for @per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab.
  ///
  /// In it, this message translates to:
  /// **'Per questo ci siamo noi: studenti universitari, come voi, con anni di esperienza come mangiatori di Kebab.'**
  String
      get per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab;

  /// No description provided for @testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo.
  ///
  /// In it, this message translates to:
  /// **'Testiamo e recensiamo Kebabbari e Street Food per voi. Benvenuti su Kebabbo.'**
  String
      get testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo;

  /// No description provided for @failed_to_load_reviews_count.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare il conteggio delle recensioni'**
  String get failed_to_load_reviews_count;

  /// No description provided for @cambia_username.
  ///
  /// In it, this message translates to:
  /// **'Cambia Username'**
  String get cambia_username;

  /// No description provided for @nuovo_username.
  ///
  /// In it, this message translates to:
  /// **'Nuovo username...'**
  String get nuovo_username;

  /// No description provided for @cancel.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get cancel;

  /// No description provided for @update.
  ///
  /// In it, this message translates to:
  /// **'Aggiorna'**
  String get update;

  /// No description provided for @failed_to_upload_avatar.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare l\'avatar'**
  String get failed_to_upload_avatar;

  /// No description provided for @edit_profile.
  ///
  /// In it, this message translates to:
  /// **'Modifica profilo'**
  String get edit_profile;

  /// No description provided for @unexpected_error_occurred.
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore imprevisto'**
  String get unexpected_error_occurred;

  /// No description provided for @failed_to_load_favorites.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare i preferiti'**
  String get failed_to_load_favorites;

  /// No description provided for @nessun_kebab_tra_i_preferiti.
  ///
  /// In it, this message translates to:
  /// **'Nessun kebab tra i preferiti'**
  String get nessun_kebab_tra_i_preferiti;

  /// No description provided for @no_suggestions_available.
  ///
  /// In it, this message translates to:
  /// **'Nessun suggerimento disponibile'**
  String get no_suggestions_available;

  /// No description provided for @devi_essere_autenticato_per_postare.
  ///
  /// In it, this message translates to:
  /// **'Devi essere autenticato per postare'**
  String get devi_essere_autenticato_per_postare;

  /// No description provided for @il_testo_non_puo_essere_vuoto.
  ///
  /// In it, this message translates to:
  /// **'Il testo non può essere vuoto'**
  String get il_testo_non_puo_essere_vuoto;

  /// No description provided for @errore_nel_caricamento_dellimage.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricamento dell\'immagine:'**
  String get errore_nel_caricamento_dellimage;

  /// No description provided for @congratulazioni.
  ///
  /// In it, this message translates to:
  /// **'Congratulazioni!'**
  String get congratulazioni;

  /// No description provided for @hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto un nuovo traguardo e ottenuto una nuova medaglia!'**
  String get hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia;

  /// No description provided for @scrivi_un_post.
  ///
  /// In it, this message translates to:
  /// **'Scrivi un post...'**
  String get scrivi_un_post;

  /// No description provided for @testo_non_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Testo non disponibile'**
  String get testo_non_disponibile;

  /// No description provided for @non_segui_ancora_nessuno.
  ///
  /// In it, this message translates to:
  /// **'Non segui ancora nessuno'**
  String get non_segui_ancora_nessuno;

  /// No description provided for @errore_nel_caricamento_dei_follower.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricamento dei follower'**
  String get errore_nel_caricamento_dei_follower;

  /// No description provided for @nessun_utente_ti_segue.
  ///
  /// In it, this message translates to:
  /// **'Nessun utente ti segue'**
  String get nessun_utente_ti_segue;

  /// No description provided for @il_kebab_che_ti_raccomandiamo_e.
  ///
  /// In it, this message translates to:
  /// **'Il kebab che ti raccomandiamo è:'**
  String get il_kebab_che_ti_raccomandiamo_e;

  /// No description provided for @kebab_consigliato.
  ///
  /// In it, this message translates to:
  /// **'Kebab consigliato'**
  String get kebab_consigliato;

  /// No description provided for @kebab_sconosciuto.
  ///
  /// In it, this message translates to:
  /// **'Kebab Sconosciuto'**
  String get kebab_sconosciuto;

  /// No description provided for @descrizione_non_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Descrizione non disponibile'**
  String get descrizione_non_disponibile;

  /// No description provided for @back_to_build.
  ///
  /// In it, this message translates to:
  /// **'Torna alla costruzione'**
  String get back_to_build;

  /// No description provided for @check_your_email_for_a_login_link.
  ///
  /// In it, this message translates to:
  /// **'Controlla la tua email per un link di accesso!'**
  String get check_your_email_for_a_login_link;

  /// No description provided for @by_signing_in_you_agree_to_our_terms_and_privacy_policy.
  ///
  /// In it, this message translates to:
  /// **'Accedendo, accetti i nostri termini e la nostra politica sulla privacy.'**
  String get by_signing_in_you_agree_to_our_terms_and_privacy_policy;

  /// No description provided for @prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi.
  ///
  /// In it, this message translates to:
  /// **'\"Prendete, e mangiatene  tutti: questo è il  Kebab offerto in  sacrificio  per voi.\"'**
  String
      get prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi;

  /// No description provided for @failed_to_load_medals.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare le medaglie'**
  String get failed_to_load_medals;

  /// No description provided for @prima_review.
  ///
  /// In it, this message translates to:
  /// **'prima recensione'**
  String get prima_review;

  /// No description provided for @primo_post.
  ///
  /// In it, this message translates to:
  /// **'primo post'**
  String get primo_post;

  /// Un messaggio quando un utente recensisce un kebab
  ///
  /// In it, this message translates to:
  /// **'Ho appena recensito il kebab da {kebabName}!\n\nQualità: {qualityRating}\nQuantità: {quantityRating}\nMenu: {menuRating}\nPrezzo: {priceRating}\nDivertimento: {funRating}\n\n{description}'**
  String reviewMessage(
      String kebabName,
      String qualityRating,
      String quantityRating,
      String menuRating,
      String priceRating,
      String funRating,
      String description);

  /// No description provided for @review_updated_successfully.
  ///
  /// In it, this message translates to:
  /// **'Recensione aggiornata con successo'**
  String get review_updated_successfully;

  /// No description provided for @review_submitted_successfully.
  ///
  /// In it, this message translates to:
  /// **'Recensione inviata con successo'**
  String get review_submitted_successfully;

  /// No description provided for @nuova_medaglia.
  ///
  /// In it, this message translates to:
  /// **'Nuova Medaglia!'**
  String get nuova_medaglia;

  /// No description provided for @hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo.
  ///
  /// In it, this message translates to:
  /// **'Hai ricevuto una nuova medaglia per il tuo contributo!'**
  String get hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo;

  /// No description provided for @review.
  ///
  /// In it, this message translates to:
  /// **'Recensione'**
  String get review;

  /// No description provided for @oops_review_not_found.
  ///
  /// In it, this message translates to:
  /// **'Oops! Recensione non trovata'**
  String get oops_review_not_found;

  /// No description provided for @please_log_in_to_submit_your_review.
  ///
  /// In it, this message translates to:
  /// **'Accedi per inviare la tua recensione'**
  String get please_log_in_to_submit_your_review;

  /// No description provided for @rate_the_kebab.
  ///
  /// In it, this message translates to:
  /// **'Valuta il Kebab'**
  String get rate_the_kebab;

  /// No description provided for @quality.
  ///
  /// In it, this message translates to:
  /// **'Qualità'**
  String get quality;

  /// No description provided for @quantity.
  ///
  /// In it, this message translates to:
  /// **'Quantità'**
  String get quantity;

  /// No description provided for @menu.
  ///
  /// In it, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @price.
  ///
  /// In it, this message translates to:
  /// **'Prezzo'**
  String get price;

  /// No description provided for @fun.
  ///
  /// In it, this message translates to:
  /// **'Divertimento'**
  String get fun;

  /// No description provided for @description_is_required.
  ///
  /// In it, this message translates to:
  /// **'La descrizione è obbligatoria'**
  String get description_is_required;

  /// No description provided for @submit_review.
  ///
  /// In it, this message translates to:
  /// **'Invia recensione'**
  String get submit_review;

  /// No description provided for @registrati_per_poter_visualizzare_il_feed.
  ///
  /// In it, this message translates to:
  /// **'Registrati per poter visualizzare il feed'**
  String get registrati_per_poter_visualizzare_il_feed;

  /// No description provided for @cerca_utenti.
  ///
  /// In it, this message translates to:
  /// **'Cerca utenti...'**
  String get cerca_utenti;

  /// No description provided for @anonimo.
  ///
  /// In it, this message translates to:
  /// **'Anonimo'**
  String get anonimo;

  /// No description provided for @nessun_utente_seguito.
  ///
  /// In it, this message translates to:
  /// **'Nessun utente seguito'**
  String get nessun_utente_seguito;

  /// No description provided for @failed_to_load_follower_count.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare il conteggio dei follower'**
  String get failed_to_load_follower_count;

  /// No description provided for @failed_to_load_profile.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare il profilo'**
  String get failed_to_load_profile;

  /// No description provided for @failed_to_update_follow_status.
  ///
  /// In it, this message translates to:
  /// **'Impossibile aggiornare lo stato del follow'**
  String get failed_to_update_follow_status;

  /// No description provided for @failed_to_load_post_count.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare il conteggio dei post'**
  String get failed_to_load_post_count;

  /// No description provided for @segui_gia.
  ///
  /// In it, this message translates to:
  /// **'Segui già'**
  String get segui_gia;

  /// No description provided for @segui.
  ///
  /// In it, this message translates to:
  /// **'Segui'**
  String get segui;

  /// No description provided for @seguiti.
  ///
  /// In it, this message translates to:
  /// **'Seguiti'**
  String get seguiti;

  /// No description provided for @world.
  ///
  /// In it, this message translates to:
  /// **'Mondo'**
  String get world;

  /// No description provided for @legends.
  ///
  /// In it, this message translates to:
  /// **'Leggende'**
  String get legends;

  /// No description provided for @errore.
  ///
  /// In it, this message translates to:
  /// **'Errore:'**
  String get errore;

  /// No description provided for @nessun_kebabbaro_presente.
  ///
  /// In it, this message translates to:
  /// **'Nessun Kebabbaro presente :('**
  String get nessun_kebabbaro_presente;

  /// No description provided for @thank_you.
  ///
  /// In it, this message translates to:
  /// **'Grazie'**
  String get thank_you;

  /// No description provided for @thank_you_for_your_review.
  ///
  /// In it, this message translates to:
  /// **'Grazie per la tua recensione!'**
  String get thank_you_for_your_review;

  /// No description provided for @you_can_access_reviews_at_any_time_from_your_account.
  ///
  /// In it, this message translates to:
  /// **'Puoi accedere alle recensioni in qualsiasi momento dal tuo account.'**
  String get you_can_access_reviews_at_any_time_from_your_account;

  /// No description provided for @build_your_kebab.
  ///
  /// In it, this message translates to:
  /// **'Costruisci il tuo Kebab'**
  String get build_your_kebab;

  /// No description provided for @distanza_massima.
  ///
  /// In it, this message translates to:
  /// **'Distanza Massima'**
  String get distanza_massima;

  /// No description provided for @preferiti_solo_per_utenti_registrati.
  ///
  /// In it, this message translates to:
  /// **'Preferiti solo per utenti registrati'**
  String get preferiti_solo_per_utenti_registrati;

  /// No description provided for @it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again.
  ///
  /// In it, this message translates to:
  /// **'Sembra che la recensione a cui stai cercando di accedere non esista. Controlla il link e riprova.'**
  String
      get it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again;

  /// Etichetta per distanze entro 200 metri con conteggio dinamico dei risultati
  ///
  /// In it, this message translates to:
  /// **'200 metri ({results} risultati)'**
  String distanceLabel200m(String results);

  /// Etichetta per distanze entro 500 metri con conteggio dinamico dei risultati
  ///
  /// In it, this message translates to:
  /// **'500 metri ({results} risultati)'**
  String distanceLabel500m(String results);

  /// Etichetta per distanze entro 1 km con conteggio dinamico dei risultati
  ///
  /// In it, this message translates to:
  /// **'1 km ({results} risultati)'**
  String distanceLabel1km(String results);

  /// Etichetta per distanze entro 10 km con conteggio dinamico dei risultati
  ///
  /// In it, this message translates to:
  /// **'10 km ({results} risultati)'**
  String distanceLabel10km(String results);

  /// Etichetta per distanze illimitate con conteggio dinamico dei risultati
  ///
  /// In it, this message translates to:
  /// **'Illimitato ({results} risultati)'**
  String distanceLabelUnlimited(String results);

  /// No description provided for @nessun_kebab_corrispondente_trovato_nel_raggio_selezionato.
  ///
  /// In it, this message translates to:
  /// **'Nessun kebab corrispondente trovato nel raggio selezionato'**
  String get nessun_kebab_corrispondente_trovato_nel_raggio_selezionato;

  /// No description provided for @cerca_un_kebabbaro.
  ///
  /// In it, this message translates to:
  /// **'Cerca un kebabbaro...'**
  String get cerca_un_kebabbaro;

  /// No description provided for @aperti_ora.
  ///
  /// In it, this message translates to:
  /// **'Aperti ora'**
  String get aperti_ora;

  /// No description provided for @failed_to_load_posts.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare i post'**
  String get failed_to_load_posts;

  /// No description provided for @i_tuoi_post.
  ///
  /// In it, this message translates to:
  /// **'I tuoi Post'**
  String get i_tuoi_post;

  /// No description provided for @nessun_post_trovato.
  ///
  /// In it, this message translates to:
  /// **'Nessun post trovato'**
  String get nessun_post_trovato;

  /// No description provided for @nessuna_recensione_ancora.
  ///
  /// In it, this message translates to:
  /// **'Nessuna recensione ancora'**
  String get nessuna_recensione_ancora;

  /// No description provided for @successfully_updated_profile.
  ///
  /// In it, this message translates to:
  /// **'Profilo aggiornato con successo!'**
  String get successfully_updated_profile;

  /// No description provided for @username_cannot_contain_spaces_use_undescores_instead.
  ///
  /// In it, this message translates to:
  /// **'Il nome utente non può contenere spazi,\nusa trattini bassi invece!'**
  String get username_cannot_contain_spaces_use_undescores_instead;

  /// No description provided for @username_must_be_at_least_3_characters_long.
  ///
  /// In it, this message translates to:
  /// **'Il nome utente deve essere lungo almeno 3\ncaratteri!'**
  String get username_must_be_at_least_3_characters_long;

  /// No description provided for @username_cannot_be_more_than_12_characters.
  ///
  /// In it, this message translates to:
  /// **'Il nome utente non può contenere più di\n12 caratteri!'**
  String get username_cannot_be_more_than_12_characters;

  /// No description provided for @username_can_only_contain_letters_numbers_and_underscores.
  ///
  /// In it, this message translates to:
  /// **'Il nome utente può contenere solo lettere,\nnumeri e trattini bassi!'**
  String get username_can_only_contain_letters_numbers_and_underscores;

  /// No description provided for @esplora.
  ///
  /// In it, this message translates to:
  /// **'Esplora'**
  String get esplora;

  /// No description provided for @mappa.
  ///
  /// In it, this message translates to:
  /// **'Mappa'**
  String get mappa;

  /// No description provided for @no_image.
  ///
  /// In it, this message translates to:
  /// **'Nessuna immagine'**
  String get no_image;

  /// No description provided for @nessun_commento_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Nessun commento disponibile'**
  String get nessun_commento_disponibile;

  /// No description provided for @commento_non_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Commento non disponibile'**
  String get commento_non_disponibile;

  /// No description provided for @scrivi_un_commento.
  ///
  /// In it, this message translates to:
  /// **'Scrivi un commento...'**
  String get scrivi_un_commento;

  /// No description provided for @il_commento_e_stato_aggiunto_con_successo.
  ///
  /// In it, this message translates to:
  /// **'Il commento è stato aggiunto con successo!'**
  String get il_commento_e_stato_aggiunto_con_successo;

  /// No description provided for @user_not_found.
  ///
  /// In it, this message translates to:
  /// **'Utente non trovato'**
  String get user_not_found;

  /// No description provided for @an_error_occurred.
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore'**
  String get an_error_occurred;

  /// No description provided for @log_in_con_google.
  ///
  /// In it, this message translates to:
  /// **'Accedi con Google'**
  String get log_in_con_google;

  /// No description provided for @aperto.
  ///
  /// In it, this message translates to:
  /// **'Aperto'**
  String get aperto;

  /// No description provided for @chiuso.
  ///
  /// In it, this message translates to:
  /// **'Chiuso'**
  String get chiuso;

  /// No description provided for @nessuna_recensione_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Nessuna recensione disponibile'**
  String get nessuna_recensione_disponibile;

  /// No description provided for @users_review.
  ///
  /// In it, this message translates to:
  /// **'Recensione degli utenti'**
  String get users_review;

  /// No description provided for @km_distante_da_te.
  ///
  /// In it, this message translates to:
  /// **'km distante da te'**
  String get km_distante_da_te;

  /// No description provided for @distanza_non_disponibile.
  ///
  /// In it, this message translates to:
  /// **'Distanza non disponibile'**
  String get distanza_non_disponibile;

  /// No description provided for @verdura.
  ///
  /// In it, this message translates to:
  /// **'Verdura'**
  String get verdura;

  /// No description provided for @yogurt.
  ///
  /// In it, this message translates to:
  /// **'Yogurt'**
  String get yogurt;

  /// No description provided for @spicy.
  ///
  /// In it, this message translates to:
  /// **'Piccante'**
  String get spicy;

  /// No description provided for @cipolla.
  ///
  /// In it, this message translates to:
  /// **'Cipolla'**
  String get cipolla;

  /// No description provided for @description.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get description;

  /// No description provided for @more_info.
  ///
  /// In it, this message translates to:
  /// **'Come recensire un kebab'**
  String get more_info;

  /// No description provided for @close.
  ///
  /// In it, this message translates to:
  /// **'Chiudi'**
  String get close;

  /// No description provided for @popup_title.
  ///
  /// In it, this message translates to:
  /// **'Come scrivere la tua recensione'**
  String get popup_title;

  /// No description provided for @first_time_title.
  ///
  /// In it, this message translates to:
  /// **'Benvenuto su Kebabbo!'**
  String get first_time_title;

  /// No description provided for @elimina.
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get elimina;

  /// No description provided for @vuoi_veramente_eliminare_il_post.
  ///
  /// In it, this message translates to:
  /// **'Vuoi veramente eliminare il post?'**
  String get vuoi_veramente_eliminare_il_post;

  /// No description provided for @conferma_eliminazione.
  ///
  /// In it, this message translates to:
  /// **'Conferma eliminazione'**
  String get conferma_eliminazione;

  /// No description provided for @post_eliminato.
  ///
  /// In it, this message translates to:
  /// **'Post eliminato'**
  String get post_eliminato;

  /// No description provided for @devi_essere_autenticato_per_mettere_mi_piace.
  ///
  /// In it, this message translates to:
  /// **'Devi accedere per mettere mi piace'**
  String get devi_essere_autenticato_per_mettere_mi_piace;

  /// No description provided for @accedi_per_cercare.
  ///
  /// In it, this message translates to:
  /// **'Accedi per pubblicare e vedere le informazioni delle persone'**
  String get accedi_per_cercare;

  /// No description provided for @devi_essere_autenticato_per_commentare.
  ///
  /// In it, this message translates to:
  /// **'Devi accedere per commentare'**
  String get devi_essere_autenticato_per_commentare;

  /// No description provided for @devi_essere_autenticato_per_visualizzare_il_profilo.
  ///
  /// In it, this message translates to:
  /// **'Devi accedere per visualizzare il profilo'**
  String get devi_essere_autenticato_per_visualizzare_il_profilo;

  /// No description provided for @sign_up.
  ///
  /// In it, this message translates to:
  /// **'Registrati'**
  String get sign_up;

  /// No description provided for @please_enter_your_email.
  ///
  /// In it, this message translates to:
  /// **'Inserisci la tua email'**
  String get please_enter_your_email;

  /// No description provided for @please_enter_a_valid_email.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un\'email valida'**
  String get please_enter_a_valid_email;

  /// No description provided for @please_enter_a_password.
  ///
  /// In it, this message translates to:
  /// **'Inserisci una password'**
  String get please_enter_a_password;

  /// No description provided for @password_must_be_at_least_6_characters.
  ///
  /// In it, this message translates to:
  /// **'La password deve essere di almeno 6 caratteri'**
  String get password_must_be_at_least_6_characters;

  /// No description provided for @check_your_email_for_a_verification_link.
  ///
  /// In it, this message translates to:
  /// **'Controlla la tua email per un link di verifica'**
  String get check_your_email_for_a_verification_link;

  /// No description provided for @dont_have_an_account_sign_up.
  ///
  /// In it, this message translates to:
  /// **'Non hai un account? Registrati'**
  String get dont_have_an_account_sign_up;

  /// No description provided for @logged_in.
  ///
  /// In it, this message translates to:
  /// **'Accesso effettuato'**
  String get logged_in;

  /// No description provided for @login.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get login;

  /// No description provided for @email.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In it, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @popup_description.
  ///
  /// In it, this message translates to:
  /// **'Per garantire l\'autenticità delle recensioni degli utenti, per recensire tu stesso il kebab,\ndovrai recarti di persona e trovare l\'adesivo Kebabbo apposto nelle vicinanze del kebabbaro,\nscansionandolo verrai indirizzato alla pagina della recensione.'**
  String get popup_description;

  /// No description provided for @first_time_description.
  ///
  /// In it, this message translates to:
  /// **'Benvenuto su Kebabbo! Cosa puoi fare qui?\nBeh, puoi esplorare le nostre professionalissime recensioni di kebab o dare un\'occhiata a quelle di altri utenti.\nAggiungi la tua recensione scansionando l\'adesivo di Kebabbo davanti al kebabbaro stesso.\nDai un\'occhiata ai profili e ai post di altri utenti, connettiti con altri amanti del kebab e guadagna medaglie utilizzando l\'app.\nUsa le nostre funzioni di ricerca e filtraggio o il nostro potente strumento di creazione del kebab perfetto, o esplora la nostra mappa interattiva per scoprire gemme nelle vicinanze.\nDivertiti e kebabba!'**
  String get first_time_description;

  /// No description provided for @cambia_profilo.
  ///
  /// In it, this message translates to:
  /// **'Cambia profilo'**
  String get cambia_profilo;

  /// No description provided for @cambia_profilepic.
  ///
  /// In it, this message translates to:
  /// **'Cambia profile pic'**
  String get cambia_profilepic;

  /// No description provided for @please_fill_in_all_fields.
  ///
  /// In it, this message translates to:
  /// **'Compila tutti i campi'**
  String get please_fill_in_all_fields;

  /// No description provided for @password_minimum_length.
  ///
  /// In it, this message translates to:
  /// **'La password deve essere di almeno 6 caratteri'**
  String get password_minimum_length;

  /// No description provided for @email_required.
  ///
  /// In it, this message translates to:
  /// **'l\'Email è obbligatoria'**
  String get email_required;

  /// No description provided for @send_reset_email.
  ///
  /// In it, this message translates to:
  /// **'Invia email di reimpostazione'**
  String get send_reset_email;

  /// No description provided for @forgot_password.
  ///
  /// In it, this message translates to:
  /// **'Password dimenticata'**
  String get forgot_password;

  /// No description provided for @check_your_email_for_a_reset_link.
  ///
  /// In it, this message translates to:
  /// **'Controlla la tua email per un link di reimpostazione'**
  String get check_your_email_for_a_reset_link;

  /// No description provided for @password_reset_success.
  ///
  /// In it, this message translates to:
  /// **'Reimpostazione password riuscita'**
  String get password_reset_success;

  /// No description provided for @new_password.
  ///
  /// In it, this message translates to:
  /// **'Nuova Password'**
  String get new_password;

  /// No description provided for @reset_password.
  ///
  /// In it, this message translates to:
  /// **'Reimposta Password'**
  String get reset_password;

  /// No description provided for @nessun_kebab_vicino_a_te.
  ///
  /// In it, this message translates to:
  /// **'Nessun kebab vicino a te \nDevi essere in prossimità del kebabbaro per recensirlo per ragioni di autenticità.\nControlla la tua posizione e ricarica la pagina.'**
  String get nessun_kebab_vicino_a_te;

  /// No description provided for @riprova.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get riprova;

  /// No description provided for @no_thanks.
  ///
  /// In it, this message translates to:
  /// **'No, grazie'**
  String get no_thanks;

  /// No description provided for @app_is_installed_description.
  ///
  /// In it, this message translates to:
  /// **'Kebabbo è già installato sul tuo dispositivo. Vuoi aprirlo?'**
  String get app_is_installed_description;

  /// No description provided for @app_is_installed.
  ///
  /// In it, this message translates to:
  /// **'App installata'**
  String get app_is_installed;

  /// No description provided for @single_card.
  ///
  /// In it, this message translates to:
  /// **'Carta Kebabbo'**
  String get single_card;

  /// No description provided for @pack.
  ///
  /// In it, this message translates to:
  /// **'Pacchetto Kebabbo'**
  String get pack;

  /// No description provided for @my_cards.
  ///
  /// In it, this message translates to:
  /// **'Collezione Kebab TCG'**
  String get my_cards;

  /// No description provided for @pack_too_soon.
  ///
  /// In it, this message translates to:
  /// **'Questo pacchetto non è ancora disponibile'**
  String get pack_too_soon;

  /// No description provided for @no_cards_yet.
  ///
  /// In it, this message translates to:
  /// **'Non hai ancora nessuna carta'**
  String get no_cards_yet;

  /// No description provided for @open_pack.
  ///
  /// In it, this message translates to:
  /// **'Apri Pacchetto'**
  String get open_pack;

  /// No description provided for @go_back.
  ///
  /// In it, this message translates to:
  /// **'Indietro'**
  String get go_back;

  /// No description provided for @write_a_review_for_a_kebab_near_you.
  ///
  /// In it, this message translates to:
  /// **'Scrivi una recensione'**
  String get write_a_review_for_a_kebab_near_you;

  /// No description provided for @autenticazione_necessaria.
  ///
  /// In it, this message translates to:
  /// **'Devi essere autenticato per commentare.'**
  String get autenticazione_necessaria;

  /// No description provided for @commento_vuoto.
  ///
  /// In it, this message translates to:
  /// **'il testo del commento non può essere vuoto.'**
  String get commento_vuoto;

  /// No description provided for @found_all_cards.
  ///
  /// In it, this message translates to:
  /// **'Tutte le carte trovate.'**
  String get found_all_cards;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'pt'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
