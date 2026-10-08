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
  /// **'Il tuo match è:'**
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
  /// **'Cambia foto profilo'**
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
  /// **'L\'email è obbligatoria'**
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
  /// **'Aprilo nell\'app per un\'esperienza migliore. Se non ce l\'hai ancora, ti portiamo su Google Play.'**
  String get app_is_installed_description;

  /// No description provided for @app_is_installed.
  ///
  /// In it, this message translates to:
  /// **'Kebabbo è anche un\'app!'**
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
  /// **'Il testo del commento non può essere vuoto.'**
  String get commento_vuoto;

  /// No description provided for @found_all_cards.
  ///
  /// In it, this message translates to:
  /// **'Tutte le carte trovate.'**
  String get found_all_cards;

  /// No description provided for @about.
  ///
  /// In it, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @privacy_policy.
  ///
  /// In it, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @add_kebab.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi un Kebab'**
  String get add_kebab;

  /// No description provided for @logout.
  ///
  /// In it, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @could_not_open_link.
  ///
  /// In it, this message translates to:
  /// **'Impossibile aprire il link.'**
  String get could_not_open_link;

  /// No description provided for @generic_error.
  ///
  /// In it, this message translates to:
  /// **'Errore: '**
  String get generic_error;

  /// No description provided for @posts.
  ///
  /// In it, this message translates to:
  /// **'Posts'**
  String get posts;

  /// No description provided for @followers.
  ///
  /// In it, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @following.
  ///
  /// In it, this message translates to:
  /// **'Seguiti'**
  String get following;

  /// No description provided for @error_processing_image.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'elaborazione dell\'immagine:'**
  String get error_processing_image;

  /// No description provided for @followed_filter.
  ///
  /// In it, this message translates to:
  /// **'Seguiti'**
  String get followed_filter;

  /// No description provided for @all_filter.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get all_filter;

  /// No description provided for @games_tools_title.
  ///
  /// In it, this message translates to:
  /// **'Giochi & Strumenti'**
  String get games_tools_title;

  /// No description provided for @login_required_section.
  ///
  /// In it, this message translates to:
  /// **'Devi effettuare l\'accesso per usare questa sezione.'**
  String get login_required_section;

  /// No description provided for @add_review_title.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Recensione'**
  String get add_review_title;

  /// No description provided for @add_review_subtitle.
  ///
  /// In it, this message translates to:
  /// **'Hai provato un nuovo kebab?'**
  String get add_review_subtitle;

  /// No description provided for @pack_button_title.
  ///
  /// In it, this message translates to:
  /// **'Pacchetto'**
  String get pack_button_title;

  /// No description provided for @pack_button_subtitle.
  ///
  /// In it, this message translates to:
  /// **'spacchetta il tuo kebab preferito'**
  String get pack_button_subtitle;

  /// No description provided for @collection_title.
  ///
  /// In it, this message translates to:
  /// **'Collezione'**
  String get collection_title;

  /// No description provided for @collection_subtitle.
  ///
  /// In it, this message translates to:
  /// **'controlla le tue kebabbo cards'**
  String get collection_subtitle;

  /// No description provided for @create_kebab_title.
  ///
  /// In it, this message translates to:
  /// **'Crea il Kebab'**
  String get create_kebab_title;

  /// No description provided for @create_kebab_subtitle.
  ///
  /// In it, this message translates to:
  /// **'crea il tuo kebab'**
  String get create_kebab_subtitle;

  /// No description provided for @your_medals_title.
  ///
  /// In it, this message translates to:
  /// **'Le tue Medaglie'**
  String get your_medals_title;

  /// No description provided for @add_review_appbar_title.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Recensione'**
  String get add_review_appbar_title;

  /// No description provided for @error_loading_kebabs.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricare i kebab: '**
  String get error_loading_kebabs;

  /// No description provided for @kebab_not_found.
  ///
  /// In it, this message translates to:
  /// **'Kebab non trovato'**
  String get kebab_not_found;

  /// No description provided for @add_new_kebab_confirmation.
  ///
  /// In it, this message translates to:
  /// **'Stai per aggiungere \"\$name\" come nuovo kebab. Sei sicuro che non sia già presente?'**
  String get add_new_kebab_confirmation;

  /// No description provided for @city.
  ///
  /// In it, this message translates to:
  /// **'Città'**
  String get city;

  /// No description provided for @yes_create_new.
  ///
  /// In it, this message translates to:
  /// **'Sì, crea nuovo'**
  String get yes_create_new;

  /// No description provided for @user_not_authenticated.
  ///
  /// In it, this message translates to:
  /// **'Utente non autenticato'**
  String get user_not_authenticated;

  /// No description provided for @error_adding_review.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'aggiunta della recensione: '**
  String get error_adding_review;

  /// No description provided for @name_label.
  ///
  /// In it, this message translates to:
  /// **'Nome'**
  String get name_label;

  /// No description provided for @required_field.
  ///
  /// In it, this message translates to:
  /// **'Campo obbligatorio'**
  String get required_field;

  /// No description provided for @kebab_already_exists.
  ///
  /// In it, this message translates to:
  /// **'Kebab già esistente'**
  String get kebab_already_exists;

  /// No description provided for @your_review_optional.
  ///
  /// In it, this message translates to:
  /// **'La tua recensione (opzionale)'**
  String get your_review_optional;

  /// No description provided for @kebab_tag.
  ///
  /// In it, this message translates to:
  /// **'Kebab'**
  String get kebab_tag;

  /// No description provided for @sandwich_tag.
  ///
  /// In it, this message translates to:
  /// **'Sandwich'**
  String get sandwich_tag;

  /// No description provided for @dimension.
  ///
  /// In it, this message translates to:
  /// **'Dimensione'**
  String get dimension;

  /// No description provided for @meat.
  ///
  /// In it, this message translates to:
  /// **'Carne'**
  String get meat;

  /// No description provided for @onion.
  ///
  /// In it, this message translates to:
  /// **'Cipolla'**
  String get onion;

  /// No description provided for @vegetables.
  ///
  /// In it, this message translates to:
  /// **'Verdure'**
  String get vegetables;

  /// No description provided for @gluten_free.
  ///
  /// In it, this message translates to:
  /// **'Senza Glutine'**
  String get gluten_free;

  /// No description provided for @advanced_filters.
  ///
  /// In it, this message translates to:
  /// **'Filtri avanzati'**
  String get advanced_filters;

  /// No description provided for @open_now.
  ///
  /// In it, this message translates to:
  /// **'Aperti ora'**
  String get open_now;

  /// No description provided for @sandwiches.
  ///
  /// In it, this message translates to:
  /// **'Panini'**
  String get sandwiches;

  /// No description provided for @order_by.
  ///
  /// In it, this message translates to:
  /// **'Ordina per'**
  String get order_by;

  /// No description provided for @filter_by_distance.
  ///
  /// In it, this message translates to:
  /// **'Filtra per distanza'**
  String get filter_by_distance;

  /// No description provided for @sort_stars.
  ///
  /// In it, this message translates to:
  /// **'stelle'**
  String get sort_stars;

  /// No description provided for @sort_quality.
  ///
  /// In it, this message translates to:
  /// **'qualità'**
  String get sort_quality;

  /// No description provided for @sort_price.
  ///
  /// In it, this message translates to:
  /// **'prezzo'**
  String get sort_price;

  /// No description provided for @sort_dimension.
  ///
  /// In it, this message translates to:
  /// **'dimensione'**
  String get sort_dimension;

  /// No description provided for @sort_menu.
  ///
  /// In it, this message translates to:
  /// **'menu'**
  String get sort_menu;

  /// No description provided for @sort_name.
  ///
  /// In it, this message translates to:
  /// **'nome'**
  String get sort_name;

  /// No description provided for @sort_distance.
  ///
  /// In it, this message translates to:
  /// **'distanza'**
  String get sort_distance;

  /// No description provided for @fun_exclamation.
  ///
  /// In it, this message translates to:
  /// **'fun!'**
  String get fun_exclamation;

  /// No description provided for @kebabbo_review.
  ///
  /// In it, this message translates to:
  /// **'Recensione Kebabbo'**
  String get kebabbo_review;

  /// No description provided for @review_this_kebab.
  ///
  /// In it, this message translates to:
  /// **'Recensisci questo Kebab'**
  String get review_this_kebab;

  /// No description provided for @staff.
  ///
  /// In it, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @users.
  ///
  /// In it, this message translates to:
  /// **'Utenti'**
  String get users;

  /// No description provided for @one_review.
  ///
  /// In it, this message translates to:
  /// **'1 recensione'**
  String get one_review;

  /// No description provided for @five_reviews.
  ///
  /// In it, this message translates to:
  /// **'5 recensioni'**
  String get five_reviews;

  /// No description provided for @ten_reviews.
  ///
  /// In it, this message translates to:
  /// **'10 recensioni'**
  String get ten_reviews;

  /// No description provided for @twenty_reviews.
  ///
  /// In it, this message translates to:
  /// **'20 recensioni'**
  String get twenty_reviews;

  /// No description provided for @thirty_reviews.
  ///
  /// In it, this message translates to:
  /// **'30 recensioni'**
  String get thirty_reviews;

  /// No description provided for @one_post.
  ///
  /// In it, this message translates to:
  /// **'1 post'**
  String get one_post;

  /// No description provided for @five_posts.
  ///
  /// In it, this message translates to:
  /// **'5 post'**
  String get five_posts;

  /// No description provided for @ten_posts.
  ///
  /// In it, this message translates to:
  /// **'10 post'**
  String get ten_posts;

  /// No description provided for @fifty_posts.
  ///
  /// In it, this message translates to:
  /// **'50 post'**
  String get fifty_posts;

  /// No description provided for @build_button.
  ///
  /// In it, this message translates to:
  /// **'Costruisci!'**
  String get build_button;

  /// No description provided for @objectives.
  ///
  /// In it, this message translates to:
  /// **'Obiettivi'**
  String get objectives;

  /// No description provided for @your_kebab.
  ///
  /// In it, this message translates to:
  /// **'Il tuo kebab'**
  String get your_kebab;

  /// No description provided for @kebab_no_longer_available.
  ///
  /// In it, this message translates to:
  /// **'Kebab non più disponibile'**
  String get kebab_no_longer_available;

  /// No description provided for @inserted_by.
  ///
  /// In it, this message translates to:
  /// **'Inserito da'**
  String get inserted_by;

  /// No description provided for @community_upload.
  ///
  /// In it, this message translates to:
  /// **'Community'**
  String get community_upload;

  /// No description provided for @staff_certified.
  ///
  /// In it, this message translates to:
  /// **'Certificato Staff Kebabbo'**
  String get staff_certified;

  /// No description provided for @swipe_collection_hint.
  ///
  /// In it, this message translates to:
  /// **'Scorri per sfogliare la collezione'**
  String get swipe_collection_hint;

  /// No description provided for @examine_3d.
  ///
  /// In it, this message translates to:
  /// **'Esamina in 3D'**
  String get examine_3d;

  /// No description provided for @details.
  ///
  /// In it, this message translates to:
  /// **'Dettagli'**
  String get details;

  /// No description provided for @verified_by_staff_tooltip.
  ///
  /// In it, this message translates to:
  /// **'Verificato dallo staff Kebabbo'**
  String get verified_by_staff_tooltip;

  /// No description provided for @sign_up_with_google.
  ///
  /// In it, this message translates to:
  /// **'Registrati con Google'**
  String get sign_up_with_google;

  /// No description provided for @or_continue_with_email.
  ///
  /// In it, this message translates to:
  /// **'oppure con email'**
  String get or_continue_with_email;

  /// No description provided for @already_have_an_account.
  ///
  /// In it, this message translates to:
  /// **'Hai già un account? Accedi'**
  String get already_have_an_account;

  /// No description provided for @location_services_disabled.
  ///
  /// In it, this message translates to:
  /// **'I servizi di localizzazione sono disattivati.'**
  String get location_services_disabled;

  /// No description provided for @location_permission_denied.
  ///
  /// In it, this message translates to:
  /// **'Permesso di localizzazione negato.'**
  String get location_permission_denied;

  /// No description provided for @location_permission_denied_forever.
  ///
  /// In it, this message translates to:
  /// **'Permesso di localizzazione negato in modo permanente. Puoi attivarlo dalle impostazioni.'**
  String get location_permission_denied_forever;

  /// No description provided for @session_expired.
  ///
  /// In it, this message translates to:
  /// **'Sessione scaduta. Effettua nuovamente il login.'**
  String get session_expired;

  /// No description provided for @contribute_title.
  ///
  /// In it, this message translates to:
  /// **'Contribuisci a Kebabbo'**
  String get contribute_title;

  /// No description provided for @contribute_subtitle.
  ///
  /// In it, this message translates to:
  /// **'Aiutaci a mappare e recensire i migliori kebabbari!'**
  String get contribute_subtitle;

  /// No description provided for @add_kebab_place.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi un Kebabbaro'**
  String get add_kebab_place;

  /// No description provided for @add_kebab_place_subtitle.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un nuovo locale sulla mappa'**
  String get add_kebab_place_subtitle;

  /// No description provided for @write_review_title.
  ///
  /// In it, this message translates to:
  /// **'Scrivi una Recensione'**
  String get write_review_title;

  /// No description provided for @write_review_subtitle.
  ///
  /// In it, this message translates to:
  /// **'Vota la qualità, la carne e le salse'**
  String get write_review_subtitle;

  /// No description provided for @nav_home.
  ///
  /// In it, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_add.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi'**
  String get nav_add;

  /// No description provided for @nav_feed.
  ///
  /// In it, this message translates to:
  /// **'Feed'**
  String get nav_feed;

  /// No description provided for @nav_account.
  ///
  /// In it, this message translates to:
  /// **'Account'**
  String get nav_account;

  /// No description provided for @page_not_found.
  ///
  /// In it, this message translates to:
  /// **'Pagina non trovata'**
  String get page_not_found;

  /// No description provided for @maps_link_name_and_coords_found.
  ///
  /// In it, this message translates to:
  /// **'Coordinate e nome rilevati dal link Maps! 📍'**
  String get maps_link_name_and_coords_found;

  /// No description provided for @maps_link_coords_found.
  ///
  /// In it, this message translates to:
  /// **'Coordinate rilevate con successo dal link Maps! 📍'**
  String get maps_link_coords_found;

  /// No description provided for @maps_link_failed.
  ///
  /// In it, this message translates to:
  /// **'Impossibile estrarre le coordinate dal link. Usa \"Scegli sulla Mappa\".'**
  String get maps_link_failed;

  /// No description provided for @select_location_first.
  ///
  /// In it, this message translates to:
  /// **'Seleziona la posizione sulla mappa prima di continuare! 📍'**
  String get select_location_first;

  /// No description provided for @error_saving.
  ///
  /// In it, this message translates to:
  /// **'Errore durante il salvataggio: {error}'**
  String error_saving(String error);

  /// No description provided for @section_location.
  ///
  /// In it, this message translates to:
  /// **'1. Posizione sulla Mappa 📍'**
  String get section_location;

  /// No description provided for @section_location_hint.
  ///
  /// In it, this message translates to:
  /// **'Tocca per posizionare il pin o cercare il locale. Coordinate, indirizzo e nome verranno estratti automaticamente!'**
  String get section_location_hint;

  /// No description provided for @edit_location_on_map.
  ///
  /// In it, this message translates to:
  /// **'Modifica Posizione sulla Mappa'**
  String get edit_location_on_map;

  /// No description provided for @choose_on_map_recommended.
  ///
  /// In it, this message translates to:
  /// **'Scegli sulla Mappa (Consigliato)'**
  String get choose_on_map_recommended;

  /// No description provided for @city_label.
  ///
  /// In it, this message translates to:
  /// **'Città: {city}'**
  String city_label(String city);

  /// No description provided for @location_selected.
  ///
  /// In it, this message translates to:
  /// **'Posizione selezionata'**
  String get location_selected;

  /// No description provided for @paste_maps_link_prompt.
  ///
  /// In it, this message translates to:
  /// **'Hai già un link di Google Maps? Incollalo qui'**
  String get paste_maps_link_prompt;

  /// No description provided for @google_maps_link.
  ///
  /// In it, this message translates to:
  /// **'Link Google Maps'**
  String get google_maps_link;

  /// No description provided for @extract.
  ///
  /// In it, this message translates to:
  /// **'Estrai'**
  String get extract;

  /// No description provided for @section_name_category.
  ///
  /// In it, this message translates to:
  /// **'2. Nome e Categoria 🌯'**
  String get section_name_category;

  /// No description provided for @kebab_place_name_label.
  ///
  /// In it, this message translates to:
  /// **'Nome del Kebabbaro *'**
  String get kebab_place_name_label;

  /// No description provided for @kebab_place_name_hint.
  ///
  /// In it, this message translates to:
  /// **'Es. Bella Istanbul 3'**
  String get kebab_place_name_hint;

  /// No description provided for @name_autofilled_helper.
  ///
  /// In it, this message translates to:
  /// **'Compilato automaticamente dalla mappa (modificalo pure)'**
  String get name_autofilled_helper;

  /// No description provided for @enter_place_name.
  ///
  /// In it, this message translates to:
  /// **'Inserisci il nome del locale'**
  String get enter_place_name;

  /// No description provided for @tag_kebab_pill.
  ///
  /// In it, this message translates to:
  /// **'Kebab 🌯'**
  String get tag_kebab_pill;

  /// No description provided for @tag_sandwich_pill.
  ///
  /// In it, this message translates to:
  /// **'Paninoteca 🥪'**
  String get tag_sandwich_pill;

  /// No description provided for @gluten_free_option.
  ///
  /// In it, this message translates to:
  /// **'Opzione Senza Glutine'**
  String get gluten_free_option;

  /// No description provided for @gluten_free_option_desc.
  ///
  /// In it, this message translates to:
  /// **'Dispone di piadina o opzioni certificate gluten-free'**
  String get gluten_free_option_desc;

  /// No description provided for @section_opening_hours.
  ///
  /// In it, this message translates to:
  /// **'3. Orari di Apertura ⏰'**
  String get section_opening_hours;

  /// No description provided for @opening_hours_hint.
  ///
  /// In it, this message translates to:
  /// **'Puoi lasciarli non specificati come standard, oppure scegliere un template o impostarli personalizzati:'**
  String get opening_hours_hint;

  /// No description provided for @hours_preset_none.
  ///
  /// In it, this message translates to:
  /// **'Non specificati (Standard)'**
  String get hours_preset_none;

  /// No description provided for @hours_preset_continuous.
  ///
  /// In it, this message translates to:
  /// **'Continuato (11-23) 🌯'**
  String get hours_preset_continuous;

  /// No description provided for @hours_preset_night.
  ///
  /// In it, this message translates to:
  /// **'Notturno (11-02) 🌙'**
  String get hours_preset_night;

  /// No description provided for @hours_preset_lunch_dinner.
  ///
  /// In it, this message translates to:
  /// **'Pranzo e Cena 🍽️'**
  String get hours_preset_lunch_dinner;

  /// No description provided for @hours_preset_custom.
  ///
  /// In it, this message translates to:
  /// **'Personalizzati ⚙️'**
  String get hours_preset_custom;

  /// No description provided for @hours_none_note.
  ///
  /// In it, this message translates to:
  /// **'Nessun orario verrà salvato.'**
  String get hours_none_note;

  /// No description provided for @custom_hours_hint.
  ///
  /// In it, this message translates to:
  /// **'Imposta gli orari per ciascun giorno (es. 11:00-23:00 oppure \"chiuso\"):'**
  String get custom_hours_hint;

  /// No description provided for @section_photo_optional.
  ///
  /// In it, this message translates to:
  /// **'4. Foto del Locale (Opzionale)'**
  String get section_photo_optional;

  /// No description provided for @upload_place_photo.
  ///
  /// In it, this message translates to:
  /// **'Carica una foto dello spiedo o del locale'**
  String get upload_place_photo;

  /// No description provided for @section_initial_review.
  ///
  /// In it, this message translates to:
  /// **'5. La Tua Recensione Iniziale'**
  String get section_initial_review;

  /// No description provided for @description_review_label.
  ///
  /// In it, this message translates to:
  /// **'Descrizione / Recensione *'**
  String get description_review_label;

  /// No description provided for @description_review_hint.
  ///
  /// In it, this message translates to:
  /// **'Racconta com\'è questo kebab: pane, carne, sapori...'**
  String get description_review_hint;

  /// No description provided for @description_review_required.
  ///
  /// In it, this message translates to:
  /// **'Scrivi un breve commento per presentare il kebabbaro'**
  String get description_review_required;

  /// No description provided for @overall_rating_1_5.
  ///
  /// In it, this message translates to:
  /// **'Valutazione Generale (1 a 5)'**
  String get overall_rating_1_5;

  /// No description provided for @ingredient_balance_1_10.
  ///
  /// In it, this message translates to:
  /// **'Bilanciamento Ingredienti (1 a 10)'**
  String get ingredient_balance_1_10;

  /// No description provided for @add_kebab_to_kebabbo.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Kebabbaro a Kebabbo'**
  String get add_kebab_to_kebabbo;

  /// No description provided for @added_to_favorites.
  ///
  /// In it, this message translates to:
  /// **'Aggiunto ai preferiti ❤️'**
  String get added_to_favorites;

  /// No description provided for @removed_from_favorites.
  ///
  /// In it, this message translates to:
  /// **'Rimosso dai preferiti'**
  String get removed_from_favorites;

  /// No description provided for @remove_from_favorites.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi dai preferiti'**
  String get remove_from_favorites;

  /// No description provided for @save_to_favorites.
  ///
  /// In it, this message translates to:
  /// **'Salva nei preferiti'**
  String get save_to_favorites;

  /// No description provided for @map_not_available.
  ///
  /// In it, this message translates to:
  /// **'Mappa non disponibile per questo kebabbaro'**
  String get map_not_available;

  /// No description provided for @login_to_post_photos.
  ///
  /// In it, this message translates to:
  /// **'Effettua il login per pubblicare foto'**
  String get login_to_post_photos;

  /// No description provided for @select_photo_first.
  ///
  /// In it, this message translates to:
  /// **'Seleziona una foto prima di pubblicare'**
  String get select_photo_first;

  /// No description provided for @photo_added.
  ///
  /// In it, this message translates to:
  /// **'Foto aggiunta con successo! 📸'**
  String get photo_added;

  /// No description provided for @upload_error.
  ///
  /// In it, this message translates to:
  /// **'Errore durante il caricamento: {error}'**
  String upload_error(String error);

  /// No description provided for @add_photo_to.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Foto a {name}'**
  String add_photo_to(String name);

  /// No description provided for @tap_to_select_photo.
  ///
  /// In it, this message translates to:
  /// **'Tocca per selezionare una foto'**
  String get tap_to_select_photo;

  /// No description provided for @photo_caption_hint.
  ///
  /// In it, this message translates to:
  /// **'Scrivi un commento o descrivi il tuo kebab...'**
  String get photo_caption_hint;

  /// No description provided for @publish_photo.
  ///
  /// In it, this message translates to:
  /// **'Pubblica Foto'**
  String get publish_photo;

  /// No description provided for @kebabbo_user.
  ///
  /// In it, this message translates to:
  /// **'Utente Kebabbo'**
  String get kebabbo_user;

  /// No description provided for @kebab_place_not_found.
  ///
  /// In it, this message translates to:
  /// **'Kebabbaro non trovato o rimosso.'**
  String get kebab_place_not_found;

  /// No description provided for @review_action.
  ///
  /// In it, this message translates to:
  /// **'Recensisci'**
  String get review_action;

  /// No description provided for @photo.
  ///
  /// In it, this message translates to:
  /// **'Foto'**
  String get photo;

  /// No description provided for @tab_overview.
  ///
  /// In it, this message translates to:
  /// **'Panoramica'**
  String get tab_overview;

  /// No description provided for @tab_photos.
  ///
  /// In it, this message translates to:
  /// **'Foto ({count})'**
  String tab_photos(String count);

  /// No description provided for @tab_reviews.
  ///
  /// In it, this message translates to:
  /// **'Recensioni ({count})'**
  String tab_reviews(String count);

  /// No description provided for @kebabbo_staff_review.
  ///
  /// In it, this message translates to:
  /// **'La recensione di Kebabbo'**
  String get kebabbo_staff_review;

  /// No description provided for @rating_title.
  ///
  /// In it, this message translates to:
  /// **'Valutazione'**
  String get rating_title;

  /// No description provided for @community_count.
  ///
  /// In it, this message translates to:
  /// **'Community ({count})'**
  String community_count(String count);

  /// No description provided for @ingredient_balance.
  ///
  /// In it, this message translates to:
  /// **'Bilanciamento Ingredienti'**
  String get ingredient_balance;

  /// No description provided for @opening_hours.
  ///
  /// In it, this message translates to:
  /// **'Orari di Apertura'**
  String get opening_hours;

  /// No description provided for @no_photos_yet.
  ///
  /// In it, this message translates to:
  /// **'Nessuna foto ancora'**
  String get no_photos_yet;

  /// No description provided for @no_photos_yet_desc.
  ///
  /// In it, this message translates to:
  /// **'Sii il primo a condividere una foto della tua piadina o del tuo piatto in questo locale!'**
  String get no_photos_yet_desc;

  /// No description provided for @upload_first_photo.
  ///
  /// In it, this message translates to:
  /// **'Carica la prima foto'**
  String get upload_first_photo;

  /// No description provided for @user_generic.
  ///
  /// In it, this message translates to:
  /// **'Utente'**
  String get user_generic;

  /// No description provided for @no_reviews_yet_desc.
  ///
  /// In it, this message translates to:
  /// **'Condividi la tua esperienza in questo kebabbaro con tutta la community!'**
  String get no_reviews_yet_desc;

  /// No description provided for @write_first_review.
  ///
  /// In it, this message translates to:
  /// **'Scrivi la prima recensione'**
  String get write_first_review;

  /// No description provided for @based_on_reviews.
  ///
  /// In it, this message translates to:
  /// **'Basato su {count} recensioni'**
  String based_on_reviews(String count);

  /// No description provided for @select_place_to_review.
  ///
  /// In it, this message translates to:
  /// **'Seleziona il kebabbaro da recensire! 🌯'**
  String get select_place_to_review;

  /// No description provided for @error_sending_review.
  ///
  /// In it, this message translates to:
  /// **'Errore invio recensione: {error}'**
  String error_sending_review(String error);

  /// No description provided for @choose_place.
  ///
  /// In it, this message translates to:
  /// **'Scegli il Kebabbaro'**
  String get choose_place;

  /// No description provided for @change.
  ///
  /// In it, this message translates to:
  /// **'Cambia'**
  String get change;

  /// No description provided for @search_kebabbo_places.
  ///
  /// In it, this message translates to:
  /// **'Cerca tra i locali di Kebabbo'**
  String get search_kebabbo_places;

  /// No description provided for @search_places_hint.
  ///
  /// In it, this message translates to:
  /// **'Es. Istanbul, Agra, King...'**
  String get search_places_hint;

  /// No description provided for @no_place_found_add_it.
  ///
  /// In it, this message translates to:
  /// **'Nessun locale trovato. Se è nuovo, usa \"Aggiungi un Kebabbaro\"!'**
  String get no_place_found_add_it;

  /// No description provided for @your_experience.
  ///
  /// In it, this message translates to:
  /// **'La Tua Esperienza'**
  String get your_experience;

  /// No description provided for @comment_review_label.
  ///
  /// In it, this message translates to:
  /// **'Commento / Recensione *'**
  String get comment_review_label;

  /// No description provided for @comment_review_hint.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti è piaciuto di più? Consigli qualche salsa o menù?'**
  String get comment_review_hint;

  /// No description provided for @comment_review_required.
  ///
  /// In it, this message translates to:
  /// **'Scrivi un breve commento sulla tua esperienza'**
  String get comment_review_required;

  /// No description provided for @add_dish_photo_optional.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Foto al Piatto (Opzionale)'**
  String get add_dish_photo_optional;

  /// No description provided for @publish_review.
  ///
  /// In it, this message translates to:
  /// **'Pubblica Recensione'**
  String get publish_review;

  /// No description provided for @tap_map_to_select.
  ///
  /// In it, this message translates to:
  /// **'Tocca la mappa per selezionare il punto esatto'**
  String get tap_map_to_select;

  /// No description provided for @select_on_map.
  ///
  /// In it, this message translates to:
  /// **'Seleziona sulla Mappa'**
  String get select_on_map;

  /// No description provided for @center_on_my_location.
  ///
  /// In it, this message translates to:
  /// **'Centra sulla mia posizione'**
  String get center_on_my_location;

  /// No description provided for @search_address_or_place.
  ///
  /// In it, this message translates to:
  /// **'Cerca indirizzo o locale...'**
  String get search_address_or_place;

  /// No description provided for @selected_point.
  ///
  /// In it, this message translates to:
  /// **'Punto selezionato'**
  String get selected_point;

  /// No description provided for @confirm_this_location.
  ///
  /// In it, this message translates to:
  /// **'Conferma Questa Posizione'**
  String get confirm_this_location;

  /// No description provided for @map_style_google_road.
  ///
  /// In it, this message translates to:
  /// **'Google Stradale'**
  String get map_style_google_road;

  /// No description provided for @map_style_google_satellite.
  ///
  /// In it, this message translates to:
  /// **'Google Satellite'**
  String get map_style_google_satellite;

  /// No description provided for @change_map_style.
  ///
  /// In it, this message translates to:
  /// **'Cambia mappa: {style}'**
  String change_map_style(String style);

  /// No description provided for @map_style_satellite_short.
  ///
  /// In it, this message translates to:
  /// **'Satellite'**
  String get map_style_satellite_short;

  /// No description provided for @map_style_road_short.
  ///
  /// In it, this message translates to:
  /// **'Stradale'**
  String get map_style_road_short;

  /// No description provided for @users_count.
  ///
  /// In it, this message translates to:
  /// **'Utenti ({count})'**
  String users_count(String count);

  /// No description provided for @community_review.
  ///
  /// In it, this message translates to:
  /// **'Recensione Community'**
  String get community_review;

  /// No description provided for @no_user_reviews_yet.
  ///
  /// In it, this message translates to:
  /// **'Nessun utente ha ancora recensito questo locale!'**
  String get no_user_reviews_yet;

  /// No description provided for @directions.
  ///
  /// In it, this message translates to:
  /// **'Indicazioni'**
  String get directions;

  /// No description provided for @login_tagline.
  ///
  /// In it, this message translates to:
  /// **'Entra nella community per scoprire e recensire i migliori kebab'**
  String get login_tagline;

  /// No description provided for @no_account_question.
  ///
  /// In it, this message translates to:
  /// **'Non hai un account?'**
  String get no_account_question;

  /// No description provided for @signup_tagline.
  ///
  /// In it, this message translates to:
  /// **'Crea il tuo profilo e inizia a recensire i kebab della tua città'**
  String get signup_tagline;

  /// No description provided for @have_account_question.
  ///
  /// In it, this message translates to:
  /// **'Hai già un account?'**
  String get have_account_question;

  /// No description provided for @password_reset_failed.
  ///
  /// In it, this message translates to:
  /// **'Reimpostazione password non riuscita: {error}'**
  String password_reset_failed(String error);

  /// No description provided for @objectives_and_medals.
  ///
  /// In it, this message translates to:
  /// **'Obiettivi & Medaglie'**
  String get objectives_and_medals;

  /// No description provided for @no_more_kebabs_to_recommend.
  ///
  /// In it, this message translates to:
  /// **'Non ci sono altri kebab disponibili da consigliare.'**
  String get no_more_kebabs_to_recommend;

  /// No description provided for @reroll.
  ///
  /// In it, this message translates to:
  /// **'Rilancia'**
  String get reroll;

  /// No description provided for @see_hours_photos_reviews.
  ///
  /// In it, this message translates to:
  /// **'Vedi orari, foto e recensioni'**
  String get see_hours_photos_reviews;

  /// No description provided for @upload.
  ///
  /// In it, this message translates to:
  /// **'Carica'**
  String get upload;

  /// No description provided for @ingredient_amounts_caps.
  ///
  /// In it, this message translates to:
  /// **'QUANTITÀ INGREDIENTI'**
  String get ingredient_amounts_caps;

  /// No description provided for @error_deleting_post.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'eliminazione del post: {error}'**
  String error_deleting_post(String error);

  /// No description provided for @privacy_policy_load_error.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricamento della Privacy Policy'**
  String get privacy_policy_load_error;

  /// No description provided for @cooking_title.
  ///
  /// In it, this message translates to:
  /// **'Preparazione Kebab'**
  String get cooking_title;

  /// No description provided for @cooking_title_reroll.
  ///
  /// In it, this message translates to:
  /// **'Ricerca Alternativa'**
  String get cooking_title_reroll;

  /// No description provided for @cooking_step_1.
  ///
  /// In it, this message translates to:
  /// **'🔥 Scaldo la piadina...'**
  String get cooking_step_1;

  /// No description provided for @cooking_step_2.
  ///
  /// In it, this message translates to:
  /// **'🥩 Taglio la carne allo spiedo...'**
  String get cooking_step_2;

  /// No description provided for @cooking_step_3.
  ///
  /// In it, this message translates to:
  /// **'🥗 Aggiungo verdure fresche e salse...'**
  String get cooking_step_3;

  /// No description provided for @cooking_step_4.
  ///
  /// In it, this message translates to:
  /// **'🌯 Arrotolo a regola d\'arte...'**
  String get cooking_step_4;

  /// No description provided for @cooking_step_5.
  ///
  /// In it, this message translates to:
  /// **'🔍 Cerco il miglior kebab per te...'**
  String get cooking_step_5;

  /// No description provided for @reroll_step_1.
  ///
  /// In it, this message translates to:
  /// **'👨‍🍳 Nuova combinazione in arrivo...'**
  String get reroll_step_1;

  /// No description provided for @reroll_step_2.
  ///
  /// In it, this message translates to:
  /// **'🔥 Bilancio spezie e cottura...'**
  String get reroll_step_2;

  /// No description provided for @reroll_step_3.
  ///
  /// In it, this message translates to:
  /// **'✨ Cerco un\'altra eccellente proposta...'**
  String get reroll_step_3;

  /// No description provided for @user_not_found_login_again.
  ///
  /// In it, this message translates to:
  /// **'Utente non trovato. Effettua di nuovo il login.'**
  String get user_not_found_login_again;

  /// No description provided for @no_pack_ready_hours_minutes.
  ///
  /// In it, this message translates to:
  /// **'Nessun pacchetto pronto al momento (0/2). Il prossimo pacchetto sarà pronto tra {hours}h e {minutes}m.'**
  String no_pack_ready_hours_minutes(String hours, String minutes);

  /// No description provided for @no_cards_available.
  ///
  /// In it, this message translates to:
  /// **'Nessuna carta disponibile nel database.'**
  String get no_cards_available;

  /// No description provided for @an_error_occurred_with.
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore: {error}'**
  String an_error_occurred_with(String error);

  /// No description provided for @opening_in_progress.
  ///
  /// In it, this message translates to:
  /// **'Apertura in corso...'**
  String get opening_in_progress;

  /// No description provided for @tap_to_open_pack.
  ///
  /// In it, this message translates to:
  /// **'Tocca per aprire il pacchetto!'**
  String get tap_to_open_pack;

  /// No description provided for @duplicate_card.
  ///
  /// In it, this message translates to:
  /// **'CARTA DOPPIONE'**
  String get duplicate_card;

  /// No description provided for @new_card_unlocked.
  ///
  /// In it, this message translates to:
  /// **'NUOVA CARTA SBLOCCATA!'**
  String get new_card_unlocked;

  /// No description provided for @already_in_collection.
  ///
  /// In it, this message translates to:
  /// **'{name} (Già in Collezione)'**
  String already_in_collection(String name);

  /// No description provided for @drag_to_tilt.
  ///
  /// In it, this message translates to:
  /// **'Trascina con il dito per inclinare in 3D'**
  String get drag_to_tilt;

  /// No description provided for @open_second_pack.
  ///
  /// In it, this message translates to:
  /// **'Apri 2° Pacchetto ({count})'**
  String open_second_pack(String count);

  /// No description provided for @add_to_collection.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi alla Collezione'**
  String get add_to_collection;

  /// No description provided for @card_x_of_y.
  ///
  /// In it, this message translates to:
  /// **'#{current} di {total}'**
  String card_x_of_y(String current, String total);

  /// No description provided for @card_collection.
  ///
  /// In it, this message translates to:
  /// **'Collezione Carte'**
  String get card_collection;

  /// No description provided for @all_found.
  ///
  /// In it, this message translates to:
  /// **'Tutte trovate! 🏆'**
  String get all_found;

  /// No description provided for @remaining_count.
  ///
  /// In it, this message translates to:
  /// **'{count} rimanenti'**
  String remaining_count(String count);

  /// No description provided for @tap_to_browse_album.
  ///
  /// In it, this message translates to:
  /// **'Tocca per sfogliare l\'album completo ›'**
  String get tap_to_browse_album;

  /// No description provided for @unpack_new_cards.
  ///
  /// In it, this message translates to:
  /// **'Spacchetta Nuove Carte'**
  String get unpack_new_cards;

  /// No description provided for @recharge_info.
  ///
  /// In it, this message translates to:
  /// **'Ricarica 1 pacchetto ogni 12h (max 2)'**
  String get recharge_info;

  /// No description provided for @no_pack_ready_timer.
  ///
  /// In it, this message translates to:
  /// **'Nessun pacchetto pronto. Il prossimo sarà disponibile tra {time}.'**
  String no_pack_ready_timer(String time);

  /// No description provided for @first_pack_slot.
  ///
  /// In it, this message translates to:
  /// **'1° Pacchetto'**
  String get first_pack_slot;

  /// No description provided for @second_pack_slot.
  ///
  /// In it, this message translates to:
  /// **'2° Pacchetto'**
  String get second_pack_slot;

  /// No description provided for @ready.
  ///
  /// In it, this message translates to:
  /// **'Pronto!'**
  String get ready;

  /// No description provided for @queued.
  ///
  /// In it, this message translates to:
  /// **'In coda'**
  String get queued;

  /// No description provided for @packs_full.
  ///
  /// In it, this message translates to:
  /// **'Pacchetti ricaricati al massimo: 2 / 2 pronti! 📦✨'**
  String get packs_full;

  /// No description provided for @open_pack_two_ready.
  ///
  /// In it, this message translates to:
  /// **'Apri Pacchetto (2 Pronti!)'**
  String get open_pack_two_ready;

  /// No description provided for @no_pack_ready.
  ///
  /// In it, this message translates to:
  /// **'Nessun pacchetto pronto'**
  String get no_pack_ready;

  /// No description provided for @tcg_album.
  ///
  /// In it, this message translates to:
  /// **'Album Carte TCG'**
  String get tcg_album;

  /// No description provided for @cards_unlocked.
  ///
  /// In it, this message translates to:
  /// **'carte sbloccate'**
  String get cards_unlocked;

  /// No description provided for @missing_count.
  ///
  /// In it, this message translates to:
  /// **'{count} mancanti'**
  String missing_count(String count);

  /// No description provided for @packs_ready_2.
  ///
  /// In it, this message translates to:
  /// **'2 / 2 Pacchetti pronti da aprire'**
  String get packs_ready_2;

  /// No description provided for @packs_ready_1.
  ///
  /// In it, this message translates to:
  /// **'1 / 2 Pacchetto pronto da aprire'**
  String get packs_ready_1;

  /// No description provided for @packs_ready_0.
  ///
  /// In it, this message translates to:
  /// **'0 / 2 Pacchetti disponibili'**
  String get packs_ready_0;

  /// No description provided for @max_charge_reached.
  ///
  /// In it, this message translates to:
  /// **'Carica massima raggiunta (1 ogni 12h)'**
  String get max_charge_reached;

  /// No description provided for @next_recharge_in.
  ///
  /// In it, this message translates to:
  /// **'Prossima ricarica tra {time}'**
  String next_recharge_in(String time);

  /// No description provided for @recharging_next_in.
  ///
  /// In it, this message translates to:
  /// **'Ricarica in corso: prossimo tra {time}'**
  String recharging_next_in(String time);

  /// No description provided for @unpack_and_view_collection.
  ///
  /// In it, this message translates to:
  /// **'Spacchetta & Guarda Collezione'**
  String get unpack_and_view_collection;

  /// No description provided for @medal_0_title.
  ///
  /// In it, this message translates to:
  /// **'Primo Assaggio'**
  String get medal_0_title;

  /// No description provided for @medal_1_title.
  ///
  /// In it, this message translates to:
  /// **'Assaggiatore Seriale'**
  String get medal_1_title;

  /// No description provided for @medal_2_title.
  ///
  /// In it, this message translates to:
  /// **'Critico del Kebab'**
  String get medal_2_title;

  /// No description provided for @medal_3_title.
  ///
  /// In it, this message translates to:
  /// **'Maestro dello Spiedo'**
  String get medal_3_title;

  /// No description provided for @medal_4_title.
  ///
  /// In it, this message translates to:
  /// **'Leggenda Gastronomica'**
  String get medal_4_title;

  /// No description provided for @medal_5_title.
  ///
  /// In it, this message translates to:
  /// **'Voce del Feed'**
  String get medal_5_title;

  /// No description provided for @medal_6_title.
  ///
  /// In it, this message translates to:
  /// **'Reporter del Gusto'**
  String get medal_6_title;

  /// No description provided for @medal_7_title.
  ///
  /// In it, this message translates to:
  /// **'Influencer del Kebab'**
  String get medal_7_title;

  /// No description provided for @medal_8_title.
  ///
  /// In it, this message translates to:
  /// **'Pilastro Sociale'**
  String get medal_8_title;

  /// No description provided for @medal_0_desc.
  ///
  /// In it, this message translates to:
  /// **'Hai scritto la tua prima recensione di un kebabbaro. Benvenuto nella famiglia dei critici di Kebabbo!'**
  String get medal_0_desc;

  /// No description provided for @medal_1_desc.
  ///
  /// In it, this message translates to:
  /// **'Hai recensito 5 locali diversi. Il tuo palato comincia a distinguere la vera arte dello spiedo!'**
  String get medal_1_desc;

  /// No description provided for @medal_2_desc.
  ///
  /// In it, this message translates to:
  /// **'10 recensioni completate! Le tue valutazioni guidano i kebabbari e orientano tutta la community.'**
  String get medal_2_desc;

  /// No description provided for @medal_3_desc.
  ///
  /// In it, this message translates to:
  /// **'20 recensioni scritte! Nessun rotolo, salsa o pane arabo ha più segreti per te. Un vero maestro!'**
  String get medal_3_desc;

  /// No description provided for @medal_4_desc.
  ///
  /// In it, this message translates to:
  /// **'30 recensioni all\'attivo! Hai raggiunto i vertici dell\'esperienza culinaria di Kebabbo. Una vera leggenda vivente!'**
  String get medal_4_desc;

  /// No description provided for @medal_5_desc.
  ///
  /// In it, this message translates to:
  /// **'Hai pubblicato il tuo primo post nel feed sociale. La tua passione per il kebab ora è pubblica!'**
  String get medal_5_desc;

  /// No description provided for @medal_6_desc.
  ///
  /// In it, this message translates to:
  /// **'Hai condiviso 5 post con foto e pensieri nel feed. La community adora i tuoi aggiornamenti!'**
  String get medal_6_desc;

  /// No description provided for @medal_7_desc.
  ///
  /// In it, this message translates to:
  /// **'10 post condivisi! Con i tuoi scatti e i tuoi tag ai locali scateni la fame di tutta la città.'**
  String get medal_7_desc;

  /// No description provided for @medal_8_desc.
  ///
  /// In it, this message translates to:
  /// **'50 post nella community! Sei un pilastro insostituibile del social feed di Kebabbo!'**
  String get medal_8_desc;

  /// No description provided for @rank_5_name.
  ///
  /// In it, this message translates to:
  /// **'Leggenda Suprema'**
  String get rank_5_name;

  /// No description provided for @rank_5_desc.
  ///
  /// In it, this message translates to:
  /// **'Hai conquistato tutti i traguardi! Sei nell\'Olimpo di Kebabbo.'**
  String get rank_5_desc;

  /// No description provided for @rank_4_name.
  ///
  /// In it, this message translates to:
  /// **'Veterano di Kebabbo'**
  String get rank_4_name;

  /// No description provided for @rank_4_desc.
  ///
  /// In it, this message translates to:
  /// **'Mancano pochissimi traguardi al completamento assoluto!'**
  String get rank_4_desc;

  /// No description provided for @rank_3_name.
  ///
  /// In it, this message translates to:
  /// **'Maestro delle Salse'**
  String get rank_3_name;

  /// No description provided for @rank_3_desc.
  ///
  /// In it, this message translates to:
  /// **'Un esperto riconosciuto sia nei gusti sia nella community.'**
  String get rank_3_desc;

  /// No description provided for @rank_2_name.
  ///
  /// In it, this message translates to:
  /// **'Gourmet del Döner'**
  String get rank_2_name;

  /// No description provided for @rank_2_desc.
  ///
  /// In it, this message translates to:
  /// **'Hai un ottimo palato e una voce attiva nel feed.'**
  String get rank_2_desc;

  /// No description provided for @rank_1_name.
  ///
  /// In it, this message translates to:
  /// **'Appassionato di Spiedi'**
  String get rank_1_name;

  /// No description provided for @rank_1_desc.
  ///
  /// In it, this message translates to:
  /// **'I primi traguardi sono tuoi! Continua a recensire e postare.'**
  String get rank_1_desc;

  /// No description provided for @rank_0_name.
  ///
  /// In it, this message translates to:
  /// **'Novizio del Kebab'**
  String get rank_0_name;

  /// No description provided for @rank_0_desc.
  ///
  /// In it, this message translates to:
  /// **'Scrivi la tua prima recensione o crea un post per iniziare la collezione!'**
  String get rank_0_desc;

  /// No description provided for @unit_reviews.
  ///
  /// In it, this message translates to:
  /// **'recensioni'**
  String get unit_reviews;

  /// No description provided for @unit_posts.
  ///
  /// In it, this message translates to:
  /// **'post'**
  String get unit_posts;

  /// No description provided for @goal_reached.
  ///
  /// In it, this message translates to:
  /// **'Traguardo Raggiunto 🎉'**
  String get goal_reached;

  /// No description provided for @in_progress.
  ///
  /// In it, this message translates to:
  /// **'In Corso ⏳'**
  String get in_progress;

  /// No description provided for @progress_label.
  ///
  /// In it, this message translates to:
  /// **'Avanzamento'**
  String get progress_label;

  /// No description provided for @medal_missing.
  ///
  /// In it, this message translates to:
  /// **'Ti mancano solo {missing} {unit} per sbloccare questa medaglia!'**
  String medal_missing(String missing, String unit);

  /// No description provided for @medals_page_title.
  ///
  /// In it, this message translates to:
  /// **'Medagliere & Traguardi'**
  String get medals_page_title;

  /// No description provided for @filter_all_count.
  ///
  /// In it, this message translates to:
  /// **'Tutte ({count})'**
  String filter_all_count(String count);

  /// No description provided for @filter_reviews_count.
  ///
  /// In it, this message translates to:
  /// **'Recensioni ({count})'**
  String filter_reviews_count(String count);

  /// No description provided for @filter_unlocked_count.
  ///
  /// In it, this message translates to:
  /// **'Sbloccate ({count})'**
  String filter_unlocked_count(String count);

  /// No description provided for @no_medals_in_filter.
  ///
  /// In it, this message translates to:
  /// **'Nessuna medaglia in questo filtro'**
  String get no_medals_in_filter;

  /// No description provided for @unlocked_of_total.
  ///
  /// In it, this message translates to:
  /// **'{unlocked} su {total} sbloccate'**
  String unlocked_of_total(String unlocked, String total);

  /// No description provided for @percent_completed.
  ///
  /// In it, this message translates to:
  /// **'{percent}% completato'**
  String percent_completed(String percent);

  /// No description provided for @reviews_label.
  ///
  /// In it, this message translates to:
  /// **'Recensioni'**
  String get reviews_label;

  /// No description provided for @feed_posts_label.
  ///
  /// In it, this message translates to:
  /// **'Post Feed'**
  String get feed_posts_label;

  /// No description provided for @unlocked_badge.
  ///
  /// In it, this message translates to:
  /// **'Sbloccata'**
  String get unlocked_badge;

  /// No description provided for @completed_badge.
  ///
  /// In it, this message translates to:
  /// **'Completato! ⭐'**
  String get completed_badge;

  /// No description provided for @open_in_app.
  ///
  /// In it, this message translates to:
  /// **'Apri l\'app'**
  String get open_in_app;

  /// No description provided for @compare_kebabs.
  ///
  /// In it, this message translates to:
  /// **'Confronta Kebab'**
  String get compare_kebabs;

  /// No description provided for @select_first_kebab.
  ///
  /// In it, this message translates to:
  /// **'Seleziona 1° kebab'**
  String get select_first_kebab;

  /// No description provided for @select_second_kebab.
  ///
  /// In it, this message translates to:
  /// **'Seleziona 2° kebab'**
  String get select_second_kebab;

  /// No description provided for @search_kebab_to_compare.
  ///
  /// In it, this message translates to:
  /// **'Cerca un kebab da confrontare...'**
  String get search_kebab_to_compare;

  /// No description provided for @pillars_comparison.
  ///
  /// In it, this message translates to:
  /// **'Confronto Pilastri'**
  String get pillars_comparison;

  /// No description provided for @ingredients_comparison.
  ///
  /// In it, this message translates to:
  /// **'Bilanciamento Ingredienti'**
  String get ingredients_comparison;

  /// No description provided for @select_two_kebabs_to_compare.
  ///
  /// In it, this message translates to:
  /// **'Seleziona due kebab per visualizzare il confronto dettagliato.'**
  String get select_two_kebabs_to_compare;

  /// No description provided for @review_already_exists_title.
  ///
  /// In it, this message translates to:
  /// **'Recensione già presente'**
  String get review_already_exists_title;

  /// No description provided for @review_already_exists_message.
  ///
  /// In it, this message translates to:
  /// **'È già presente un\'altra recensione per questo locale, sovrascrivere?'**
  String get review_already_exists_message;

  /// No description provided for @sovrascrivi.
  ///
  /// In it, this message translates to:
  /// **'Sovrascrivi'**
  String get sovrascrivi;

  /// No description provided for @open_or_get_app.
  ///
  /// In it, this message translates to:
  /// **'Apri o Scarica l\'app'**
  String get open_or_get_app;

  /// No description provided for @no_kebab_within_distance.
  ///
  /// In it, this message translates to:
  /// **'Nessun kebabbaro entro {km} km.'**
  String no_kebab_within_distance(String km);

  /// No description provided for @show_all_distances.
  ///
  /// In it, this message translates to:
  /// **'Mostra tutti'**
  String get show_all_distances;

  /// No description provided for @maps_short_link_web.
  ///
  /// In it, this message translates to:
  /// **'Sul web usa il link completo di Google Maps (https://www.google.com/maps/place/...): i link brevi sono bloccati dal browser.'**
  String get maps_short_link_web;

  /// No description provided for @login_to_follow_user.
  ///
  /// In it, this message translates to:
  /// **'Accedi per seguire questo utente'**
  String get login_to_follow_user;

  /// No description provided for @profile_link_copied.
  ///
  /// In it, this message translates to:
  /// **'Link del profilo copiato negli appunti!'**
  String get profile_link_copied;

  /// No description provided for @tcg_cards_count.
  ///
  /// In it, this message translates to:
  /// **'{count} Carte TCG'**
  String tcg_cards_count(String count);

  /// No description provided for @your_profile.
  ///
  /// In it, this message translates to:
  /// **'Il tuo profilo'**
  String get your_profile;

  /// No description provided for @favorite_kebab_caps.
  ///
  /// In it, this message translates to:
  /// **'KEBAB DEL CUORE'**
  String get favorite_kebab_caps;

  /// No description provided for @no_posts_yet.
  ///
  /// In it, this message translates to:
  /// **'Nessun post ancora'**
  String get no_posts_yet;

  /// No description provided for @user_no_posts_desc.
  ///
  /// In it, this message translates to:
  /// **'Questo utente non ha ancora pubblicato post nel feed.'**
  String get user_no_posts_desc;

  /// No description provided for @user_no_reviews_desc.
  ///
  /// In it, this message translates to:
  /// **'Questo utente non ha ancora recensito nessun kebab.'**
  String get user_no_reviews_desc;

  /// No description provided for @see_place.
  ///
  /// In it, this message translates to:
  /// **'Vedi locale'**
  String get see_place;

  /// No description provided for @staff_kebabbo.
  ///
  /// In it, this message translates to:
  /// **'Staff Kebabbo'**
  String get staff_kebabbo;

  /// No description provided for @origin_label.
  ///
  /// In it, this message translates to:
  /// **'Origine'**
  String get origin_label;

  /// No description provided for @intro_1_title.
  ///
  /// In it, this message translates to:
  /// **'Trova il tuo kebab'**
  String get intro_1_title;

  /// No description provided for @intro_1_text.
  ///
  /// In it, this message translates to:
  /// **'Classifiche dello staff e della community, mappa con i voti e filtri per distanza, prezzo e orari.'**
  String get intro_1_text;

  /// No description provided for @intro_2_title.
  ///
  /// In it, this message translates to:
  /// **'Recensisci e condividi'**
  String get intro_2_title;

  /// No description provided for @intro_2_text.
  ///
  /// In it, this message translates to:
  /// **'Vota qualità, prezzo e ingredienti, carica le foto del tuo piatto e aggiungi i locali che mancano.'**
  String get intro_2_text;

  /// No description provided for @intro_3_title.
  ///
  /// In it, this message translates to:
  /// **'Colleziona medaglie e carte'**
  String get intro_3_title;

  /// No description provided for @intro_3_text.
  ///
  /// In it, this message translates to:
  /// **'Ogni recensione e ogni post sblocca medaglie, e ogni 12 ore puoi aprire un pacchetto di carte Kebabbo.'**
  String get intro_3_text;

  /// No description provided for @intro_next.
  ///
  /// In it, this message translates to:
  /// **'Avanti'**
  String get intro_next;

  /// No description provided for @intro_start.
  ///
  /// In it, this message translates to:
  /// **'Inizia'**
  String get intro_start;

  /// No description provided for @intro_skip.
  ///
  /// In it, this message translates to:
  /// **'Salta'**
  String get intro_skip;

  /// No description provided for @share_action.
  ///
  /// In it, this message translates to:
  /// **'Condividi'**
  String get share_action;

  /// No description provided for @share_this_kebab.
  ///
  /// In it, this message translates to:
  /// **'Condividi questo kebab'**
  String get share_this_kebab;

  /// No description provided for @share_more.
  ///
  /// In it, this message translates to:
  /// **'Altro'**
  String get share_more;

  /// No description provided for @copy_link.
  ///
  /// In it, this message translates to:
  /// **'Copia link'**
  String get copy_link;

  /// No description provided for @copy.
  ///
  /// In it, this message translates to:
  /// **'Copia'**
  String get copy;

  /// No description provided for @link_copied.
  ///
  /// In it, this message translates to:
  /// **'Link copiato'**
  String get link_copied;

  /// No description provided for @share_message.
  ///
  /// In it, this message translates to:
  /// **'{name}: {rating} su Kebabbo 🌯'**
  String share_message(String name, String rating);

  /// No description provided for @share_rating_line.
  ///
  /// In it, this message translates to:
  /// **'Voto Kebabbo {rating}'**
  String share_rating_line(String rating);

  /// No description provided for @login_loader_title.
  ///
  /// In it, this message translates to:
  /// **'Ti stiamo facendo entrare'**
  String get login_loader_title;

  /// No description provided for @login_loader_subtitle.
  ///
  /// In it, this message translates to:
  /// **'Un attimo, stiamo preparando il tuo profilo.'**
  String get login_loader_subtitle;

  /// No description provided for @login_step_auth.
  ///
  /// In it, this message translates to:
  /// **'Accesso'**
  String get login_step_auth;

  /// No description provided for @login_step_profile.
  ///
  /// In it, this message translates to:
  /// **'Profilo, preferiti e medaglie'**
  String get login_step_profile;

  /// No description provided for @loading.
  ///
  /// In it, this message translates to:
  /// **'Caricamento'**
  String get loading;

  /// No description provided for @loader_title.
  ///
  /// In it, this message translates to:
  /// **'Kebabbo – I migliori kebab di Bologna'**
  String get loader_title;

  /// No description provided for @loader_subtitle.
  ///
  /// In it, this message translates to:
  /// **'Classifiche, recensioni della community e mappa dei kebabbari.'**
  String get loader_subtitle;
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
