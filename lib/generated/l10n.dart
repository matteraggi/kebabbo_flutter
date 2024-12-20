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

  /// `Change Username`
  String get cambia_username {
    return Intl.message(
      'Change Username',
      name: 'cambia_username',
      desc: '',
      args: [],
    );
  }

  /// `New username...`
  String get nuovo_username {
    return Intl.message(
      'New username...',
      name: 'nuovo_username',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload avatar`
  String get failed_to_upload_avatar {
    return Intl.message(
      'Failed to upload avatar',
      name: 'failed_to_upload_avatar',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load post count`
  String get failed_to_load_post_count {
    return Intl.message(
      'Failed to load post count',
      name: 'failed_to_load_post_count',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get edit_profile {
    return Intl.message(
      'Edit profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred`
  String get unexpected_error_occurred {
    return Intl.message(
      'Unexpected error occurred',
      name: 'unexpected_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load favorites`
  String get failed_to_load_favorites {
    return Intl.message(
      'Failed to load favorites',
      name: 'failed_to_load_favorites',
      desc: '',
      args: [],
    );
  }

  /// `No kebabs in favorites`
  String get nessun_kebab_tra_i_preferiti {
    return Intl.message(
      'No kebabs in favorites',
      name: 'nessun_kebab_tra_i_preferiti',
      desc: '',
      args: [],
    );
  }

  /// `No suggestions available`
  String get no_suggestions_available {
    return Intl.message(
      'No suggestions available',
      name: 'no_suggestions_available',
      desc: '',
      args: [],
    );
  }

  /// `Register to view the feed`
  String get registrati_per_poter_visualizzare_il_feed {
    return Intl.message(
      'Register to view the feed',
      name: 'registrati_per_poter_visualizzare_il_feed',
      desc: '',
      args: [],
    );
  }

  /// `You must be authenticated to post`
  String get devi_essere_autenticato_per_postare {
    return Intl.message(
      'You must be authenticated to post',
      name: 'devi_essere_autenticato_per_postare',
      desc: '',
      args: [],
    );
  }

  /// `Text cannot be empty`
  String get il_testo_non_puo_essere_vuoto {
    return Intl.message(
      'Text cannot be empty',
      name: 'il_testo_non_puo_essere_vuoto',
      desc: '',
      args: [],
    );
  }

  /// `Error loading image:`
  String get errore_nel_caricamento_dellimage {
    return Intl.message(
      'Error loading image:',
      name: 'errore_nel_caricamento_dellimage',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulazioni {
    return Intl.message(
      'Congratulations!',
      name: 'congratulazioni',
      desc: '',
      args: [],
    );
  }

  /// `You have reached a new milestone and obtained a new medal!`
  String get hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia {
    return Intl.message(
      'You have reached a new milestone and obtained a new medal!',
      name: 'hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia',
      desc: '',
      args: [],
    );
  }

  /// `Write a post...`
  String get scrivi_un_post {
    return Intl.message(
      'Write a post...',
      name: 'scrivi_un_post',
      desc: '',
      args: [],
    );
  }

  /// `Text not available`
  String get testo_non_disponibile {
    return Intl.message(
      'Text not available',
      name: 'testo_non_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `You are not following anyone yet`
  String get non_segui_ancora_nessuno {
    return Intl.message(
      'You are not following anyone yet',
      name: 'non_segui_ancora_nessuno',
      desc: '',
      args: [],
    );
  }

  /// `Error loading followers`
  String get errore_nel_caricamento_dei_follower {
    return Intl.message(
      'Error loading followers',
      name: 'errore_nel_caricamento_dei_follower',
      desc: '',
      args: [],
    );
  }

  /// `No users follow you`
  String get nessun_utente_ti_segue {
    return Intl.message(
      'No users follow you',
      name: 'nessun_utente_ti_segue',
      desc: '',
      args: [],
    );
  }

  /// `The kebab we recommend is:`
  String get il_kebab_che_ti_raccomandiamo_e {
    return Intl.message(
      'The kebab we recommend is:',
      name: 'il_kebab_che_ti_raccomandiamo_e',
      desc: '',
      args: [],
    );
  }

  /// `Recommended Kebab`
  String get kebab_consigliato {
    return Intl.message(
      'Recommended Kebab',
      name: 'kebab_consigliato',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Kebab`
  String get kebab_sconosciuto {
    return Intl.message(
      'Unknown Kebab',
      name: 'kebab_sconosciuto',
      desc: '',
      args: [],
    );
  }

  /// `Description not available`
  String get descrizione_non_disponibile {
    return Intl.message(
      'Description not available',
      name: 'descrizione_non_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `Back to Build`
  String get back_to_build {
    return Intl.message(
      'Back to Build',
      name: 'back_to_build',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for a login link!`
  String get check_your_email_for_a_login_link {
    return Intl.message(
      'Check your email for a login link!',
      name: 'check_your_email_for_a_login_link',
      desc: '',
      args: [],
    );
  }

  /// `By signing in, you agree to our terms and privacy policy.`
  String get by_signing_in_you_agree_to_our_terms_and_privacy_policy {
    return Intl.message(
      'By signing in, you agree to our terms and privacy policy.',
      name: 'by_signing_in_you_agree_to_our_terms_and_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `"Take, and eat of this, all of you: this is the Kebab offered in sacrifice for you."`
  String
      get prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi {
    return Intl.message(
      '"Take, and eat of this, all of you: this is the Kebab offered in sacrifice for you."',
      name:
          'prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load medals`
  String get failed_to_load_medals {
    return Intl.message(
      'Failed to load medals',
      name: 'failed_to_load_medals',
      desc: '',
      args: [],
    );
  }

  /// `first review`
  String get prima_review {
    return Intl.message(
      'first review',
      name: 'prima_review',
      desc: '',
      args: [],
    );
  }

  /// `first post`
  String get primo_post {
    return Intl.message(
      'first post',
      name: 'primo_post',
      desc: '',
      args: [],
    );
  }

  /// `I just reviewed the kebab at {kebabName}!\n\nQuality: {qualityRating}\nQuantity: {quantityRating}\nMenu: {menuRating}\nPrice: {priceRating}\nFun: {funRating}\n\n{description}`
  String reviewMessage(
      String kebabName,
      String qualityRating,
      String quantityRating,
      String menuRating,
      String priceRating,
      String funRating,
      String description) {
    return Intl.message(
      'I just reviewed the kebab at $kebabName!\n\nQuality: $qualityRating\nQuantity: $quantityRating\nMenu: $menuRating\nPrice: $priceRating\nFun: $funRating\n\n$description',
      name: 'reviewMessage',
      desc: 'A message when a user reviews a kebab',
      args: [
        kebabName,
        qualityRating,
        quantityRating,
        menuRating,
        priceRating,
        funRating,
        description
      ],
    );
  }

  /// `Review updated successfully`
  String get review_updated_successfully {
    return Intl.message(
      'Review updated successfully',
      name: 'review_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Review submitted successfully`
  String get review_submitted_successfully {
    return Intl.message(
      'Review submitted successfully',
      name: 'review_submitted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `New Medal!`
  String get nuova_medaglia {
    return Intl.message(
      'New Medal!',
      name: 'nuova_medaglia',
      desc: '',
      args: [],
    );
  }

  /// `You received a new medal for your contribution!`
  String get hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo {
    return Intl.message(
      'You received a new medal for your contribution!',
      name: 'hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Review Not Found`
  String get oops_review_not_found {
    return Intl.message(
      'Oops! Review Not Found',
      name: 'oops_review_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Please Log In to Submit Your Review`
  String get please_log_in_to_submit_your_review {
    return Intl.message(
      'Please Log In to Submit Your Review',
      name: 'please_log_in_to_submit_your_review',
      desc: '',
      args: [],
    );
  }

  /// `Rate the Kebab`
  String get rate_the_kebab {
    return Intl.message(
      'Rate the Kebab',
      name: 'rate_the_kebab',
      desc: '',
      args: [],
    );
  }

  /// `Quality`
  String get quality {
    return Intl.message(
      'Quality',
      name: 'quality',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Fun`
  String get fun {
    return Intl.message(
      'Fun',
      name: 'fun',
      desc: '',
      args: [],
    );
  }

  /// `Description is required`
  String get description_is_required {
    return Intl.message(
      'Description is required',
      name: 'description_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Submit Review`
  String get submit_review {
    return Intl.message(
      'Submit Review',
      name: 'submit_review',
      desc: '',
      args: [],
    );
  }

  /// `Search users...`
  String get cerca_utenti {
    return Intl.message(
      'Search users...',
      name: 'cerca_utenti',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get anonimo {
    return Intl.message(
      'Anonymous',
      name: 'anonimo',
      desc: '',
      args: [],
    );
  }

  /// `No users followed`
  String get nessun_utente_seguito {
    return Intl.message(
      'No users followed',
      name: 'nessun_utente_seguito',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load profile`
  String get failed_to_load_profile {
    return Intl.message(
      'Failed to load profile',
      name: 'failed_to_load_profile',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update follow status`
  String get failed_to_update_follow_status {
    return Intl.message(
      'Failed to update follow status',
      name: 'failed_to_update_follow_status',
      desc: '',
      args: [],
    );
  }

  /// `Already following`
  String get segui_gia {
    return Intl.message(
      'Already following',
      name: 'segui_gia',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get segui {
    return Intl.message(
      'Follow',
      name: 'segui',
      desc: '',
      args: [],
    );
  }

  /// `Followed`
  String get seguiti {
    return Intl.message(
      'Followed',
      name: 'seguiti',
      desc: '',
      args: [],
    );
  }

  /// `World`
  String get world {
    return Intl.message(
      'World',
      name: 'world',
      desc: '',
      args: [],
    );
  }

  /// `Legends`
  String get legends {
    return Intl.message(
      'Legends',
      name: 'legends',
      desc: '',
      args: [],
    );
  }

  /// `Error:`
  String get errore {
    return Intl.message(
      'Error:',
      name: 'errore',
      desc: '',
      args: [],
    );
  }

  /// `No Kebab places present :(`
  String get nessun_kebabbaro_presente {
    return Intl.message(
      'No Kebab places present :(',
      name: 'nessun_kebabbaro_presente',
      desc: '',
      args: [],
    );
  }

  /// `Thank You`
  String get thank_you {
    return Intl.message(
      'Thank You',
      name: 'thank_you',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your review!`
  String get thank_you_for_your_review {
    return Intl.message(
      'Thank you for your review!',
      name: 'thank_you_for_your_review',
      desc: '',
      args: [],
    );
  }

  /// `You can access reviews at any time from your account.`
  String get you_can_access_reviews_at_any_time_from_your_account {
    return Intl.message(
      'You can access reviews at any time from your account.',
      name: 'you_can_access_reviews_at_any_time_from_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Build Your Kebab`
  String get build_your_kebab {
    return Intl.message(
      'Build Your Kebab',
      name: 'build_your_kebab',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Distance`
  String get distanza_massima {
    return Intl.message(
      'Maximum Distance',
      name: 'distanza_massima',
      desc: '',
      args: [],
    );
  }

  /// `Favorites only for registered users`
  String get preferiti_solo_per_utenti_registrati {
    return Intl.message(
      'Favorites only for registered users',
      name: 'preferiti_solo_per_utenti_registrati',
      desc: '',
      args: [],
    );
  }

  /// `It looks like the review you are trying to access does not exist. Please check the link and try again.`
  String
      get it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again {
    return Intl.message(
      'It looks like the review you are trying to access does not exist. Please check the link and try again.',
      name:
          'it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again',
      desc: '',
      args: [],
    );
  }

  /// `200 meters ({results} results)`
  String distanceLabel200m(String results) {
    return Intl.message(
      '200 meters ($results results)',
      name: 'distanceLabel200m',
      desc: 'Label for distances within 200 meters with dynamic results count',
      args: [results],
    );
  }

  /// `500 meters ({results} results)`
  String distanceLabel500m(String results) {
    return Intl.message(
      '500 meters ($results results)',
      name: 'distanceLabel500m',
      desc: 'Label for distances within 500 meters with dynamic results count',
      args: [results],
    );
  }

  /// `1 km ({results} results)`
  String distanceLabel1km(String results) {
    return Intl.message(
      '1 km ($results results)',
      name: 'distanceLabel1km',
      desc: 'Label for distances within 1 km with dynamic results count',
      args: [results],
    );
  }

  /// `10 km ({results} results)`
  String distanceLabel10km(String results) {
    return Intl.message(
      '10 km ($results results)',
      name: 'distanceLabel10km',
      desc: 'Label for distances within 10 km with dynamic results count',
      args: [results],
    );
  }

  /// `Unlimited ({results} results)`
  String distanceLabelUnlimited(String results) {
    return Intl.message(
      'Unlimited ($results results)',
      name: 'distanceLabelUnlimited',
      desc: 'Label for unlimited distance with dynamic results count',
      args: [results],
    );
  }

  /// `No matching kebab found within the selected radius`
  String get nessun_kebab_corrispondente_trovato_nel_raggio_selezionato {
    return Intl.message(
      'No matching kebab found within the selected radius',
      name: 'nessun_kebab_corrispondente_trovato_nel_raggio_selezionato',
      desc: '',
      args: [],
    );
  }

  /// `Search for a kebab place...`
  String get cerca_un_kebabbaro {
    return Intl.message(
      'Search for a kebab place...',
      name: 'cerca_un_kebabbaro',
      desc: '',
      args: [],
    );
  }

  /// `Open now`
  String get aperti_ora {
    return Intl.message(
      'Open now',
      name: 'aperti_ora',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load posts`
  String get failed_to_load_posts {
    return Intl.message(
      'Failed to load posts',
      name: 'failed_to_load_posts',
      desc: '',
      args: [],
    );
  }

  /// `Your Posts`
  String get i_tuoi_post {
    return Intl.message(
      'Your Posts',
      name: 'i_tuoi_post',
      desc: '',
      args: [],
    );
  }

  /// `No posts found`
  String get nessun_post_trovato {
    return Intl.message(
      'No posts found',
      name: 'nessun_post_trovato',
      desc: '',
      args: [],
    );
  }

  /// `No reviews yet`
  String get nessuna_recensione_ancora {
    return Intl.message(
      'No reviews yet',
      name: 'nessuna_recensione_ancora',
      desc: '',
      args: [],
    );
  }

  /// `Successfully updated profile!`
  String get successfully_updated_profile {
    return Intl.message(
      'Successfully updated profile!',
      name: 'successfully_updated_profile',
      desc: '',
      args: [],
    );
  }

  /// `Username cannot contain spaces,\nuse underscores instead!`
  String get username_cannot_contain_spaces_use_undescores_instead {
    return Intl.message(
      'Username cannot contain spaces,\nuse underscores instead!',
      name: 'username_cannot_contain_spaces_use_undescores_instead',
      desc: '',
      args: [],
    );
  }

  /// `Username must be at least 3 \ncharacters long!`
  String get username_must_be_at_least_3_characters_long {
    return Intl.message(
      'Username must be at least 3 \ncharacters long!',
      name: 'username_must_be_at_least_3_characters_long',
      desc: '',
      args: [],
    );
  }

  /// `Username cannot be more than \n12 characters!`
  String get username_cannot_be_more_than_12_characters {
    return Intl.message(
      'Username cannot be more than \n12 characters!',
      name: 'username_cannot_be_more_than_12_characters',
      desc: '',
      args: [],
    );
  }

  /// `Username can only contain letters,\nnumbers, and underscores!`
  String get username_can_only_contain_letters_numbers_and_underscores {
    return Intl.message(
      'Username can only contain letters,\nnumbers, and underscores!',
      name: 'username_can_only_contain_letters_numbers_and_underscores',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get esplora {
    return Intl.message(
      'Explore',
      name: 'esplora',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get mappa {
    return Intl.message(
      'Map',
      name: 'mappa',
      desc: '',
      args: [],
    );
  }

  /// `No Image`
  String get no_image {
    return Intl.message(
      'No Image',
      name: 'no_image',
      desc: '',
      args: [],
    );
  }

  /// `No comments available`
  String get nessun_commento_disponibile {
    return Intl.message(
      'No comments available',
      name: 'nessun_commento_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `Comment not available`
  String get commento_non_disponibile {
    return Intl.message(
      'Comment not available',
      name: 'commento_non_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `Write a comment...`
  String get scrivi_un_commento {
    return Intl.message(
      'Write a comment...',
      name: 'scrivi_un_commento',
      desc: '',
      args: [],
    );
  }

  /// `The comment was added successfully!`
  String get il_commento_e_stato_aggiunto_con_successo {
    return Intl.message(
      'The comment was added successfully!',
      name: 'il_commento_e_stato_aggiunto_con_successo',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Log In with Google`
  String get log_in_con_google {
    return Intl.message(
      'Log In with Google',
      name: 'log_in_con_google',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get aperto {
    return Intl.message(
      'Open',
      name: 'aperto',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get chiuso {
    return Intl.message(
      'Closed',
      name: 'chiuso',
      desc: '',
      args: [],
    );
  }

  /// `No reviews available`
  String get nessuna_recensione_disponibile {
    return Intl.message(
      'No reviews available',
      name: 'nessuna_recensione_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `Users Review`
  String get users_review {
    return Intl.message(
      'Users Review',
      name: 'users_review',
      desc: '',
      args: [],
    );
  }

  /// `km away from you`
  String get km_distante_da_te {
    return Intl.message(
      'km away from you',
      name: 'km_distante_da_te',
      desc: '',
      args: [],
    );
  }

  /// `Distance not available`
  String get distanza_non_disponibile {
    return Intl.message(
      'Distance not available',
      name: 'distanza_non_disponibile',
      desc: '',
      args: [],
    );
  }

  /// `Vegetables`
  String get verdura {
    return Intl.message(
      'Vegetables',
      name: 'verdura',
      desc: '',
      args: [],
    );
  }

  /// `Yogurt`
  String get yogurt {
    return Intl.message(
      'Yogurt',
      name: 'yogurt',
      desc: '',
      args: [],
    );
  }

  /// `Spicy`
  String get spicy {
    return Intl.message(
      'Spicy',
      name: 'spicy',
      desc: '',
      args: [],
    );
  }

  /// `Onion`
  String get cipolla {
    return Intl.message(
      'Onion',
      name: 'cipolla',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `How to review a kebab`
  String get more_info {
    return Intl.message(
      'How to review a kebab',
      name: 'more_info',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `In order to keep the user reviews truthful, to review yourself the kebab,\nyou need to go in person to the kebab place and find the affixed Kebabbo sticker nearby,\nscanning it will bring you to the review page.`
  String get popup_description {
    return Intl.message(
      'In order to keep the user reviews truthful, to review yourself the kebab,\nyou need to go in person to the kebab place and find the affixed Kebabbo sticker nearby,\nscanning it will bring you to the review page.',
      name: 'popup_description',
      desc: '',
      args: [],
    );
  }

  /// `How to write your own review`
  String get popup_title {
    return Intl.message(
      'How to write your own review',
      name: 'popup_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Kebabbo!`
  String get first_time_title {
    return Intl.message(
      'Welcome to Kebabbo!',
      name: 'first_time_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Kebabbo!\nWhat can you do on here?\nWell, you can explore our professional kebab reviews or check out other users' ratings.\nWrite your own review by scanning the Kebabbo sticker at the kebab place.\nCheck out other users' profiles, posts and connect with fellows kebab enjoyers and earn achievements for using the app.\n Use our search and filter features or our powerful build tool to find your ideal kebab or explore our interactive map to discover nearby gems.\nHave fun and kebab away!`
  String get first_time_description {
    return Intl.message(
      'Welcome to Kebabbo!\nWhat can you do on here?\nWell, you can explore our professional kebab reviews or check out other users\' ratings.\nWrite your own review by scanning the Kebabbo sticker at the kebab place.\nCheck out other users\' profiles, posts and connect with fellows kebab enjoyers and earn achievements for using the app.\n Use our search and filter features or our powerful build tool to find your ideal kebab or explore our interactive map to discover nearby gems.\nHave fun and kebab away!',
      name: 'first_time_description',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get elimina {
    return Intl.message(
      'Delete',
      name: 'elimina',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete the post?`
  String get vuoi_veramente_eliminare_il_post {
    return Intl.message(
      'Do you really want to delete the post?',
      name: 'vuoi_veramente_eliminare_il_post',
      desc: '',
      args: [],
    );
  }

  /// `Confirm deletion`
  String get conferma_eliminazione {
    return Intl.message(
      'Confirm deletion',
      name: 'conferma_eliminazione',
      desc: '',
      args: [],
    );
  }

  /// `Post deleted`
  String get post_eliminato {
    return Intl.message(
      'Post deleted',
      name: 'post_eliminato',
      desc: '',
      args: [],
    );
  }

  /// `You must login to like`
  String get devi_essere_autenticato_per_mettere_mi_piace {
    return Intl.message(
      'You must login to like',
      name: 'devi_essere_autenticato_per_mettere_mi_piace',
      desc: '',
      args: [],
    );
  }

  /// `Log in to post and see peoples' info`
  String get accedi_per_cercare {
    return Intl.message(
      'Log in to post and see peoples\' info',
      name: 'accedi_per_cercare',
      desc: '',
      args: [],
    );
  }

  /// `You must login to comment`
  String get devi_essere_autenticato_per_commentare {
    return Intl.message(
      'You must login to comment',
      name: 'devi_essere_autenticato_per_commentare',
      desc: '',
      args: [],
    );
  }

  /// `You must login to view the profile`
  String get devi_essere_autenticato_per_visualizzare_il_profilo {
    return Intl.message(
      'You must login to view the profile',
      name: 'devi_essere_autenticato_per_visualizzare_il_profilo',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get please_enter_a_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'please_enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get please_enter_a_password {
    return Intl.message(
      'Please enter a password',
      name: 'please_enter_a_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_must_be_at_least_6_characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_must_be_at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for a verification link`
  String get check_your_email_for_a_verification_link {
    return Intl.message(
      'Check your email for a verification link',
      name: 'check_your_email_for_a_verification_link',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign Up`
  String get dont_have_an_account_sign_up {
    return Intl.message(
      'Don\'t have an account? Sign Up',
      name: 'dont_have_an_account_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Logged in`
  String get logged_in {
    return Intl.message(
      'Logged in',
      name: 'logged_in',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Change profile`
  String get cambia_profilo {
    return Intl.message(
      'Change profile',
      name: 'cambia_profilo',
      desc: '',
      args: [],
    );
  }

  /// `Change profile picture`
  String get cambia_profilepic {
    return Intl.message(
      'Change profile picture',
      name: 'cambia_profilepic',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get please_fill_in_all_fields {
    return Intl.message(
      'Please fill in all fields',
      name: 'please_fill_in_all_fields',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_minimum_length {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_minimum_length',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get email_required {
    return Intl.message(
      'Email is required',
      name: 'email_required',
      desc: '',
      args: [],
    );
  }

  /// `Send reset email`
  String get send_reset_email {
    return Intl.message(
      'Send reset email',
      name: 'send_reset_email',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgot_password {
    return Intl.message(
      'Forgot password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for a reset link`
  String get check_your_email_for_a_reset_link {
    return Intl.message(
      'Check your email for a reset link',
      name: 'check_your_email_for_a_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get password_reset_success {
    return Intl.message(
      'Password reset successful',
      name: 'password_reset_success',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
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
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'pt'),
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
