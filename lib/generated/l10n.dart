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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
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
    return Intl.message('Cancel', name: 'annulla', desc: '', args: []);
  }

  /// `Send`
  String get invia {
    return Intl.message('Send', name: 'invia', desc: '', args: []);
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
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
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
    return Intl.message('first post', name: 'primo_post', desc: '', args: []);
  }

  /// `I just reviewed the kebab at {kebabName}!\n\nQuality: {qualityRating}\nQuantity: {quantityRating}\nMenu: {menuRating}\nPrice: {priceRating}\nFun: {funRating}\n\n{description}`
  String reviewMessage(
    String kebabName,
    String qualityRating,
    String quantityRating,
    String menuRating,
    String priceRating,
    String funRating,
    String description,
  ) {
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
        description,
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
    return Intl.message('Review', name: 'review', desc: '', args: []);
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
    return Intl.message('Quality', name: 'quality', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Menu`
  String get menu {
    return Intl.message('Menu', name: 'menu', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Fun`
  String get fun {
    return Intl.message('Fun', name: 'fun', desc: '', args: []);
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
    return Intl.message('Anonymous', name: 'anonimo', desc: '', args: []);
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
    return Intl.message('Follow', name: 'segui', desc: '', args: []);
  }

  /// `Followed`
  String get seguiti {
    return Intl.message('Followed', name: 'seguiti', desc: '', args: []);
  }

  /// `World`
  String get world {
    return Intl.message('World', name: 'world', desc: '', args: []);
  }

  /// `Legends`
  String get legends {
    return Intl.message('Legends', name: 'legends', desc: '', args: []);
  }

  /// `Error:`
  String get errore {
    return Intl.message('Error:', name: 'errore', desc: '', args: []);
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
    return Intl.message('Thank You', name: 'thank_you', desc: '', args: []);
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
    return Intl.message('Open now', name: 'aperti_ora', desc: '', args: []);
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
    return Intl.message('Your Posts', name: 'i_tuoi_post', desc: '', args: []);
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
    return Intl.message('Explore', name: 'esplora', desc: '', args: []);
  }

  /// `Map`
  String get mappa {
    return Intl.message('Map', name: 'mappa', desc: '', args: []);
  }

  /// `No Image`
  String get no_image {
    return Intl.message('No Image', name: 'no_image', desc: '', args: []);
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
    return Intl.message('Open', name: 'aperto', desc: '', args: []);
  }

  /// `Closed`
  String get chiuso {
    return Intl.message('Closed', name: 'chiuso', desc: '', args: []);
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
    return Intl.message('Vegetables', name: 'verdura', desc: '', args: []);
  }

  /// `Yogurt`
  String get yogurt {
    return Intl.message('Yogurt', name: 'yogurt', desc: '', args: []);
  }

  /// `Spicy`
  String get spicy {
    return Intl.message('Spicy', name: 'spicy', desc: '', args: []);
  }

  /// `Onion`
  String get cipolla {
    return Intl.message('Onion', name: 'cipolla', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
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
    return Intl.message('Close', name: 'close', desc: '', args: []);
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
    return Intl.message('Delete', name: 'elimina', desc: '', args: []);
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
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
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
    return Intl.message('Logged in', name: 'logged_in', desc: '', args: []);
  }

  /// `Log In`
  String get login {
    return Intl.message('Log In', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
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

  /// `No kebab near you \nYou must be near the kebab shop to review it for authenticity reasons.\nCheck your location and reload the page.`
  String get nessun_kebab_vicino_a_te {
    return Intl.message(
      'No kebab near you \nYou must be near the kebab shop to review it for authenticity reasons.\nCheck your location and reload the page.',
      name: 'nessun_kebab_vicino_a_te',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get riprova {
    return Intl.message('Try again', name: 'riprova', desc: '', args: []);
  }

  /// `No, thanks`
  String get no_thanks {
    return Intl.message('No, thanks', name: 'no_thanks', desc: '', args: []);
  }

  /// `Open it in the app for a better experience. If you don't have it yet, we'll take you to Google Play.`
  String get app_is_installed_description {
    return Intl.message(
      'Open it in the app for a better experience. If you don\'t have it yet, we\'ll take you to Google Play.',
      name: 'app_is_installed_description',
      desc: '',
      args: [],
    );
  }

  /// `Kebabbo is also an app!`
  String get app_is_installed {
    return Intl.message(
      'Kebabbo is also an app!',
      name: 'app_is_installed',
      desc: '',
      args: [],
    );
  }

  /// `Kebabbo Card`
  String get single_card {
    return Intl.message(
      'Kebabbo Card',
      name: 'single_card',
      desc: '',
      args: [],
    );
  }

  /// `Kebabbo Pack`
  String get pack {
    return Intl.message('Kebabbo Pack', name: 'pack', desc: '', args: []);
  }

  /// `Kebab TCG Carousel`
  String get my_cards {
    return Intl.message(
      'Kebab TCG Carousel',
      name: 'my_cards',
      desc: '',
      args: [],
    );
  }

  /// `This pack is not available yet`
  String get pack_too_soon {
    return Intl.message(
      'This pack is not available yet',
      name: 'pack_too_soon',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any cards yet`
  String get no_cards_yet {
    return Intl.message(
      'You don\'t have any cards yet',
      name: 'no_cards_yet',
      desc: '',
      args: [],
    );
  }

  /// `Open Pack`
  String get open_pack {
    return Intl.message('Open Pack', name: 'open_pack', desc: '', args: []);
  }

  /// `Go Back`
  String get go_back {
    return Intl.message('Go Back', name: 'go_back', desc: '', args: []);
  }

  /// `Write a review`
  String get write_a_review_for_a_kebab_near_you {
    return Intl.message(
      'Write a review',
      name: 'write_a_review_for_a_kebab_near_you',
      desc: '',
      args: [],
    );
  }

  /// `You must be logged in to comment.`
  String get autenticazione_necessaria {
    return Intl.message(
      'You must be logged in to comment.',
      name: 'autenticazione_necessaria',
      desc: '',
      args: [],
    );
  }

  /// `The comment text cannot be empty.`
  String get commento_vuoto {
    return Intl.message(
      'The comment text cannot be empty.',
      name: 'commento_vuoto',
      desc: '',
      args: [],
    );
  }

  /// `All cards found.`
  String get found_all_cards {
    return Intl.message(
      'All cards found.',
      name: 'found_all_cards',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Add a Kebab`
  String get add_kebab {
    return Intl.message('Add a Kebab', name: 'add_kebab', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Could not open the link.`
  String get could_not_open_link {
    return Intl.message(
      'Could not open the link.',
      name: 'could_not_open_link',
      desc: '',
      args: [],
    );
  }

  /// `Error: `
  String get generic_error {
    return Intl.message('Error: ', name: 'generic_error', desc: '', args: []);
  }

  /// `Posts`
  String get posts {
    return Intl.message('Posts', name: 'posts', desc: '', args: []);
  }

  /// `Followers`
  String get followers {
    return Intl.message('Followers', name: 'followers', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `Error processing image:`
  String get error_processing_image {
    return Intl.message(
      'Error processing image:',
      name: 'error_processing_image',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get followed_filter {
    return Intl.message(
      'Following',
      name: 'followed_filter',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all_filter {
    return Intl.message('All', name: 'all_filter', desc: '', args: []);
  }

  /// `Games & Tools`
  String get games_tools_title {
    return Intl.message(
      'Games & Tools',
      name: 'games_tools_title',
      desc: '',
      args: [],
    );
  }

  /// `You must log in to use this section.`
  String get login_required_section {
    return Intl.message(
      'You must log in to use this section.',
      name: 'login_required_section',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get add_review_title {
    return Intl.message(
      'Add Review',
      name: 'add_review_title',
      desc: '',
      args: [],
    );
  }

  /// `Tried a new kebab?`
  String get add_review_subtitle {
    return Intl.message(
      'Tried a new kebab?',
      name: 'add_review_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Pack`
  String get pack_button_title {
    return Intl.message('Pack', name: 'pack_button_title', desc: '', args: []);
  }

  /// `open your favorite kebab pack`
  String get pack_button_subtitle {
    return Intl.message(
      'open your favorite kebab pack',
      name: 'pack_button_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Collection`
  String get collection_title {
    return Intl.message(
      'Collection',
      name: 'collection_title',
      desc: '',
      args: [],
    );
  }

  /// `check your kebabbo cards`
  String get collection_subtitle {
    return Intl.message(
      'check your kebabbo cards',
      name: 'collection_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Kebab`
  String get create_kebab_title {
    return Intl.message(
      'Create Kebab',
      name: 'create_kebab_title',
      desc: '',
      args: [],
    );
  }

  /// `build your own kebab`
  String get create_kebab_subtitle {
    return Intl.message(
      'build your own kebab',
      name: 'create_kebab_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Medals`
  String get your_medals_title {
    return Intl.message(
      'Your Medals',
      name: 'your_medals_title',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get add_review_appbar_title {
    return Intl.message(
      'Add Review',
      name: 'add_review_appbar_title',
      desc: '',
      args: [],
    );
  }

  /// `Error loading kebabs: `
  String get error_loading_kebabs {
    return Intl.message(
      'Error loading kebabs: ',
      name: 'error_loading_kebabs',
      desc: '',
      args: [],
    );
  }

  /// `Kebab not found`
  String get kebab_not_found {
    return Intl.message(
      'Kebab not found',
      name: 'kebab_not_found',
      desc: '',
      args: [],
    );
  }

  /// `You are about to add "$name" as a new kebab. Are you sure it doesn't already exist?`
  String get add_new_kebab_confirmation {
    return Intl.message(
      'You are about to add "\$name" as a new kebab. Are you sure it doesn\'t already exist?',
      name: 'add_new_kebab_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Yes, create new`
  String get yes_create_new {
    return Intl.message(
      'Yes, create new',
      name: 'yes_create_new',
      desc: '',
      args: [],
    );
  }

  /// `User not authenticated`
  String get user_not_authenticated {
    return Intl.message(
      'User not authenticated',
      name: 'user_not_authenticated',
      desc: '',
      args: [],
    );
  }

  /// `Error adding review: `
  String get error_adding_review {
    return Intl.message(
      'Error adding review: ',
      name: 'error_adding_review',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name_label {
    return Intl.message('Name', name: 'name_label', desc: '', args: []);
  }

  /// `Required field`
  String get required_field {
    return Intl.message(
      'Required field',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Kebab already exists`
  String get kebab_already_exists {
    return Intl.message(
      'Kebab already exists',
      name: 'kebab_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Your review (optional)`
  String get your_review_optional {
    return Intl.message(
      'Your review (optional)',
      name: 'your_review_optional',
      desc: '',
      args: [],
    );
  }

  /// `Kebab`
  String get kebab_tag {
    return Intl.message('Kebab', name: 'kebab_tag', desc: '', args: []);
  }

  /// `Sandwich`
  String get sandwich_tag {
    return Intl.message('Sandwich', name: 'sandwich_tag', desc: '', args: []);
  }

  /// `Size`
  String get dimension {
    return Intl.message('Size', name: 'dimension', desc: '', args: []);
  }

  /// `Meat`
  String get meat {
    return Intl.message('Meat', name: 'meat', desc: '', args: []);
  }

  /// `Onion`
  String get onion {
    return Intl.message('Onion', name: 'onion', desc: '', args: []);
  }

  /// `Vegetables`
  String get vegetables {
    return Intl.message('Vegetables', name: 'vegetables', desc: '', args: []);
  }

  /// `Gluten Free`
  String get gluten_free {
    return Intl.message('Gluten Free', name: 'gluten_free', desc: '', args: []);
  }

  /// `Advanced Filters`
  String get advanced_filters {
    return Intl.message(
      'Advanced Filters',
      name: 'advanced_filters',
      desc: '',
      args: [],
    );
  }

  /// `Open Now`
  String get open_now {
    return Intl.message('Open Now', name: 'open_now', desc: '', args: []);
  }

  /// `Sandwiches`
  String get sandwiches {
    return Intl.message('Sandwiches', name: 'sandwiches', desc: '', args: []);
  }

  /// `Order by`
  String get order_by {
    return Intl.message('Order by', name: 'order_by', desc: '', args: []);
  }

  /// `Filter by distance`
  String get filter_by_distance {
    return Intl.message(
      'Filter by distance',
      name: 'filter_by_distance',
      desc: '',
      args: [],
    );
  }

  /// `stars`
  String get sort_stars {
    return Intl.message('stars', name: 'sort_stars', desc: '', args: []);
  }

  /// `quality`
  String get sort_quality {
    return Intl.message('quality', name: 'sort_quality', desc: '', args: []);
  }

  /// `price`
  String get sort_price {
    return Intl.message('price', name: 'sort_price', desc: '', args: []);
  }

  /// `size`
  String get sort_dimension {
    return Intl.message('size', name: 'sort_dimension', desc: '', args: []);
  }

  /// `menu`
  String get sort_menu {
    return Intl.message('menu', name: 'sort_menu', desc: '', args: []);
  }

  /// `name`
  String get sort_name {
    return Intl.message('name', name: 'sort_name', desc: '', args: []);
  }

  /// `distance`
  String get sort_distance {
    return Intl.message('distance', name: 'sort_distance', desc: '', args: []);
  }

  /// `fun!`
  String get fun_exclamation {
    return Intl.message('fun!', name: 'fun_exclamation', desc: '', args: []);
  }

  /// `Build!`
  String get build_button {
    return Intl.message('Build!', name: 'build_button', desc: '', args: []);
  }

  /// `Kebabbo Review`
  String get kebabbo_review {
    return Intl.message(
      'Kebabbo Review',
      name: 'kebabbo_review',
      desc: '',
      args: [],
    );
  }

  /// `Review this Kebab`
  String get review_this_kebab {
    return Intl.message(
      'Review this Kebab',
      name: 'review_this_kebab',
      desc: '',
      args: [],
    );
  }

  /// `Staff`
  String get staff {
    return Intl.message('Staff', name: 'staff', desc: '', args: []);
  }

  /// `Users`
  String get users {
    return Intl.message('Users', name: 'users', desc: '', args: []);
  }

  /// `1 review`
  String get one_review {
    return Intl.message('1 review', name: 'one_review', desc: '', args: []);
  }

  /// `5 reviews`
  String get five_reviews {
    return Intl.message('5 reviews', name: 'five_reviews', desc: '', args: []);
  }

  /// `10 reviews`
  String get ten_reviews {
    return Intl.message('10 reviews', name: 'ten_reviews', desc: '', args: []);
  }

  /// `20 reviews`
  String get twenty_reviews {
    return Intl.message(
      '20 reviews',
      name: 'twenty_reviews',
      desc: '',
      args: [],
    );
  }

  /// `30 reviews`
  String get thirty_reviews {
    return Intl.message(
      '30 reviews',
      name: 'thirty_reviews',
      desc: '',
      args: [],
    );
  }

  /// `1 post`
  String get one_post {
    return Intl.message('1 post', name: 'one_post', desc: '', args: []);
  }

  /// `5 posts`
  String get five_posts {
    return Intl.message('5 posts', name: 'five_posts', desc: '', args: []);
  }

  /// `10 posts`
  String get ten_posts {
    return Intl.message('10 posts', name: 'ten_posts', desc: '', args: []);
  }

  /// `50 posts`
  String get fifty_posts {
    return Intl.message('50 posts', name: 'fifty_posts', desc: '', args: []);
  }

  /// `Objectives`
  String get objectives {
    return Intl.message('Objectives', name: 'objectives', desc: '', args: []);
  }

  /// `Your kebab`
  String get your_kebab {
    return Intl.message('Your kebab', name: 'your_kebab', desc: '', args: []);
  }

  /// `Kebab no longer available`
  String get kebab_no_longer_available {
    return Intl.message(
      'Kebab no longer available',
      name: 'kebab_no_longer_available',
      desc: '',
      args: [],
    );
  }

  /// `Added by`
  String get inserted_by {
    return Intl.message('Added by', name: 'inserted_by', desc: '', args: []);
  }

  /// `Community`
  String get community_upload {
    return Intl.message(
      'Community',
      name: 'community_upload',
      desc: '',
      args: [],
    );
  }

  /// `Kebabbo Staff Certified`
  String get staff_certified {
    return Intl.message(
      'Kebabbo Staff Certified',
      name: 'staff_certified',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to browse collection`
  String get swipe_collection_hint {
    return Intl.message(
      'Swipe to browse collection',
      name: 'swipe_collection_hint',
      desc: '',
      args: [],
    );
  }

  /// `Examine in 3D`
  String get examine_3d {
    return Intl.message(
      'Examine in 3D',
      name: 'examine_3d',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Verified by Kebabbo staff`
  String get verified_by_staff_tooltip {
    return Intl.message(
      'Verified by Kebabbo staff',
      name: 'verified_by_staff_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get sign_up_with_google {
    return Intl.message(
      'Sign up with Google',
      name: 'sign_up_with_google',
      desc: '',
      args: [],
    );
  }

  /// `or with email`
  String get or_continue_with_email {
    return Intl.message(
      'or with email',
      name: 'or_continue_with_email',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign in`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account? Sign in',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Location services are disabled.`
  String get location_services_disabled {
    return Intl.message(
      'Location services are disabled.',
      name: 'location_services_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Location permission denied.`
  String get location_permission_denied {
    return Intl.message(
      'Location permission denied.',
      name: 'location_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Location permission permanently denied. You can enable it in the settings.`
  String get location_permission_denied_forever {
    return Intl.message(
      'Location permission permanently denied. You can enable it in the settings.',
      name: 'location_permission_denied_forever',
      desc: '',
      args: [],
    );
  }

  /// `Session expired. Please log in again.`
  String get session_expired {
    return Intl.message(
      'Session expired. Please log in again.',
      name: 'session_expired',
      desc: '',
      args: [],
    );
  }

  /// `Contribute to Kebabbo`
  String get contribute_title {
    return Intl.message(
      'Contribute to Kebabbo',
      name: 'contribute_title',
      desc: '',
      args: [],
    );
  }

  /// `Help us map and review the best kebab places!`
  String get contribute_subtitle {
    return Intl.message(
      'Help us map and review the best kebab places!',
      name: 'contribute_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add a kebab place`
  String get add_kebab_place {
    return Intl.message(
      'Add a kebab place',
      name: 'add_kebab_place',
      desc: '',
      args: [],
    );
  }

  /// `Put a new place on the map`
  String get add_kebab_place_subtitle {
    return Intl.message(
      'Put a new place on the map',
      name: 'add_kebab_place_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Write a Review`
  String get write_review_title {
    return Intl.message(
      'Write a Review',
      name: 'write_review_title',
      desc: '',
      args: [],
    );
  }

  /// `Rate the quality, the meat and the sauces`
  String get write_review_subtitle {
    return Intl.message(
      'Rate the quality, the meat and the sauces',
      name: 'write_review_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get nav_home {
    return Intl.message('Home', name: 'nav_home', desc: '', args: []);
  }

  /// `Add`
  String get nav_add {
    return Intl.message('Add', name: 'nav_add', desc: '', args: []);
  }

  /// `Feed`
  String get nav_feed {
    return Intl.message('Feed', name: 'nav_feed', desc: '', args: []);
  }

  /// `Account`
  String get nav_account {
    return Intl.message('Account', name: 'nav_account', desc: '', args: []);
  }

  /// `Page not found`
  String get page_not_found {
    return Intl.message(
      'Page not found',
      name: 'page_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Coordinates and name detected from the Maps link! 📍`
  String get maps_link_name_and_coords_found {
    return Intl.message(
      'Coordinates and name detected from the Maps link! 📍',
      name: 'maps_link_name_and_coords_found',
      desc: '',
      args: [],
    );
  }

  /// `Coordinates detected from the Maps link! 📍`
  String get maps_link_coords_found {
    return Intl.message(
      'Coordinates detected from the Maps link! 📍',
      name: 'maps_link_coords_found',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't extract the coordinates from the link. Use "Choose on map".`
  String get maps_link_failed {
    return Intl.message(
      'Couldn\'t extract the coordinates from the link. Use "Choose on map".',
      name: 'maps_link_failed',
      desc: '',
      args: [],
    );
  }

  /// `Select the location on the map before continuing! 📍`
  String get select_location_first {
    return Intl.message(
      'Select the location on the map before continuing! 📍',
      name: 'select_location_first',
      desc: '',
      args: [],
    );
  }

  /// `Error while saving: {error}`
  String error_saving(String error) {
    return Intl.message(
      'Error while saving: $error',
      name: 'error_saving',
      desc: '',
      args: [error],
    );
  }

  /// `1. Location on the map 📍`
  String get section_location {
    return Intl.message(
      '1. Location on the map 📍',
      name: 'section_location',
      desc: '',
      args: [],
    );
  }

  /// `Tap to drop the pin or search for the place. Coordinates, address and name will be filled in automatically!`
  String get section_location_hint {
    return Intl.message(
      'Tap to drop the pin or search for the place. Coordinates, address and name will be filled in automatically!',
      name: 'section_location_hint',
      desc: '',
      args: [],
    );
  }

  /// `Edit location on the map`
  String get edit_location_on_map {
    return Intl.message(
      'Edit location on the map',
      name: 'edit_location_on_map',
      desc: '',
      args: [],
    );
  }

  /// `Choose on map (recommended)`
  String get choose_on_map_recommended {
    return Intl.message(
      'Choose on map (recommended)',
      name: 'choose_on_map_recommended',
      desc: '',
      args: [],
    );
  }

  /// `City: {city}`
  String city_label(String city) {
    return Intl.message(
      'City: $city',
      name: 'city_label',
      desc: '',
      args: [city],
    );
  }

  /// `Location selected`
  String get location_selected {
    return Intl.message(
      'Location selected',
      name: 'location_selected',
      desc: '',
      args: [],
    );
  }

  /// `Already have a Google Maps link? Paste it here`
  String get paste_maps_link_prompt {
    return Intl.message(
      'Already have a Google Maps link? Paste it here',
      name: 'paste_maps_link_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Google Maps link`
  String get google_maps_link {
    return Intl.message(
      'Google Maps link',
      name: 'google_maps_link',
      desc: '',
      args: [],
    );
  }

  /// `Extract`
  String get extract {
    return Intl.message('Extract', name: 'extract', desc: '', args: []);
  }

  /// `2. Name and category 🌯`
  String get section_name_category {
    return Intl.message(
      '2. Name and category 🌯',
      name: 'section_name_category',
      desc: '',
      args: [],
    );
  }

  /// `Name of the place *`
  String get kebab_place_name_label {
    return Intl.message(
      'Name of the place *',
      name: 'kebab_place_name_label',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Bella Istanbul 3`
  String get kebab_place_name_hint {
    return Intl.message(
      'e.g. Bella Istanbul 3',
      name: 'kebab_place_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Filled in automatically from the map (feel free to edit it)`
  String get name_autofilled_helper {
    return Intl.message(
      'Filled in automatically from the map (feel free to edit it)',
      name: 'name_autofilled_helper',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name of the place`
  String get enter_place_name {
    return Intl.message(
      'Enter the name of the place',
      name: 'enter_place_name',
      desc: '',
      args: [],
    );
  }

  /// `Kebab 🌯`
  String get tag_kebab_pill {
    return Intl.message('Kebab 🌯', name: 'tag_kebab_pill', desc: '', args: []);
  }

  /// `Sandwich shop 🥪`
  String get tag_sandwich_pill {
    return Intl.message(
      'Sandwich shop 🥪',
      name: 'tag_sandwich_pill',
      desc: '',
      args: [],
    );
  }

  /// `Gluten-free option`
  String get gluten_free_option {
    return Intl.message(
      'Gluten-free option',
      name: 'gluten_free_option',
      desc: '',
      args: [],
    );
  }

  /// `Offers certified gluten-free bread or options`
  String get gluten_free_option_desc {
    return Intl.message(
      'Offers certified gluten-free bread or options',
      name: 'gluten_free_option_desc',
      desc: '',
      args: [],
    );
  }

  /// `3. Opening hours ⏰`
  String get section_opening_hours {
    return Intl.message(
      '3. Opening hours ⏰',
      name: 'section_opening_hours',
      desc: '',
      args: [],
    );
  }

  /// `You can leave them unspecified, pick a template or set custom hours:`
  String get opening_hours_hint {
    return Intl.message(
      'You can leave them unspecified, pick a template or set custom hours:',
      name: 'opening_hours_hint',
      desc: '',
      args: [],
    );
  }

  /// `Not specified (default)`
  String get hours_preset_none {
    return Intl.message(
      'Not specified (default)',
      name: 'hours_preset_none',
      desc: '',
      args: [],
    );
  }

  /// `All day (11-23) 🌯`
  String get hours_preset_continuous {
    return Intl.message(
      'All day (11-23) 🌯',
      name: 'hours_preset_continuous',
      desc: '',
      args: [],
    );
  }

  /// `Late night (11-02) 🌙`
  String get hours_preset_night {
    return Intl.message(
      'Late night (11-02) 🌙',
      name: 'hours_preset_night',
      desc: '',
      args: [],
    );
  }

  /// `Lunch and dinner 🍽️`
  String get hours_preset_lunch_dinner {
    return Intl.message(
      'Lunch and dinner 🍽️',
      name: 'hours_preset_lunch_dinner',
      desc: '',
      args: [],
    );
  }

  /// `Custom ⚙️`
  String get hours_preset_custom {
    return Intl.message(
      'Custom ⚙️',
      name: 'hours_preset_custom',
      desc: '',
      args: [],
    );
  }

  /// `No opening hours will be saved.`
  String get hours_none_note {
    return Intl.message(
      'No opening hours will be saved.',
      name: 'hours_none_note',
      desc: '',
      args: [],
    );
  }

  /// `Set the hours for each day (e.g. 11:00-23:00, or "closed"):`
  String get custom_hours_hint {
    return Intl.message(
      'Set the hours for each day (e.g. 11:00-23:00, or "closed"):',
      name: 'custom_hours_hint',
      desc: '',
      args: [],
    );
  }

  /// `4. Photo of the place (optional)`
  String get section_photo_optional {
    return Intl.message(
      '4. Photo of the place (optional)',
      name: 'section_photo_optional',
      desc: '',
      args: [],
    );
  }

  /// `Upload a photo of the spit or the place`
  String get upload_place_photo {
    return Intl.message(
      'Upload a photo of the spit or the place',
      name: 'upload_place_photo',
      desc: '',
      args: [],
    );
  }

  /// `5. Your first review`
  String get section_initial_review {
    return Intl.message(
      '5. Your first review',
      name: 'section_initial_review',
      desc: '',
      args: [],
    );
  }

  /// `Description / review *`
  String get description_review_label {
    return Intl.message(
      'Description / review *',
      name: 'description_review_label',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about this kebab: bread, meat, flavours...`
  String get description_review_hint {
    return Intl.message(
      'Tell us about this kebab: bread, meat, flavours...',
      name: 'description_review_hint',
      desc: '',
      args: [],
    );
  }

  /// `Write a short comment to introduce the place`
  String get description_review_required {
    return Intl.message(
      'Write a short comment to introduce the place',
      name: 'description_review_required',
      desc: '',
      args: [],
    );
  }

  /// `Overall rating (1 to 5)`
  String get overall_rating_1_5 {
    return Intl.message(
      'Overall rating (1 to 5)',
      name: 'overall_rating_1_5',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient balance (1 to 10)`
  String get ingredient_balance_1_10 {
    return Intl.message(
      'Ingredient balance (1 to 10)',
      name: 'ingredient_balance_1_10',
      desc: '',
      args: [],
    );
  }

  /// `Add place to Kebabbo`
  String get add_kebab_to_kebabbo {
    return Intl.message(
      'Add place to Kebabbo',
      name: 'add_kebab_to_kebabbo',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorites ❤️`
  String get added_to_favorites {
    return Intl.message(
      'Added to favorites ❤️',
      name: 'added_to_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get removed_from_favorites {
    return Intl.message(
      'Removed from favorites',
      name: 'removed_from_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Remove from favorites`
  String get remove_from_favorites {
    return Intl.message(
      'Remove from favorites',
      name: 'remove_from_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Save to favorites`
  String get save_to_favorites {
    return Intl.message(
      'Save to favorites',
      name: 'save_to_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Map not available for this place`
  String get map_not_available {
    return Intl.message(
      'Map not available for this place',
      name: 'map_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Log in to post photos`
  String get login_to_post_photos {
    return Intl.message(
      'Log in to post photos',
      name: 'login_to_post_photos',
      desc: '',
      args: [],
    );
  }

  /// `Select a photo before posting`
  String get select_photo_first {
    return Intl.message(
      'Select a photo before posting',
      name: 'select_photo_first',
      desc: '',
      args: [],
    );
  }

  /// `Photo added! 📸`
  String get photo_added {
    return Intl.message(
      'Photo added! 📸',
      name: 'photo_added',
      desc: '',
      args: [],
    );
  }

  /// `Upload error: {error}`
  String upload_error(String error) {
    return Intl.message(
      'Upload error: $error',
      name: 'upload_error',
      desc: '',
      args: [error],
    );
  }

  /// `Add a photo to {name}`
  String add_photo_to(String name) {
    return Intl.message(
      'Add a photo to $name',
      name: 'add_photo_to',
      desc: '',
      args: [name],
    );
  }

  /// `Tap to select a photo`
  String get tap_to_select_photo {
    return Intl.message(
      'Tap to select a photo',
      name: 'tap_to_select_photo',
      desc: '',
      args: [],
    );
  }

  /// `Write a comment or describe your kebab...`
  String get photo_caption_hint {
    return Intl.message(
      'Write a comment or describe your kebab...',
      name: 'photo_caption_hint',
      desc: '',
      args: [],
    );
  }

  /// `Post photo`
  String get publish_photo {
    return Intl.message(
      'Post photo',
      name: 'publish_photo',
      desc: '',
      args: [],
    );
  }

  /// `Kebabbo user`
  String get kebabbo_user {
    return Intl.message(
      'Kebabbo user',
      name: 'kebabbo_user',
      desc: '',
      args: [],
    );
  }

  /// `Place not found or removed.`
  String get kebab_place_not_found {
    return Intl.message(
      'Place not found or removed.',
      name: 'kebab_place_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review_action {
    return Intl.message('Review', name: 'review_action', desc: '', args: []);
  }

  /// `Photo`
  String get photo {
    return Intl.message('Photo', name: 'photo', desc: '', args: []);
  }

  /// `Overview`
  String get tab_overview {
    return Intl.message('Overview', name: 'tab_overview', desc: '', args: []);
  }

  /// `Photos ({count})`
  String tab_photos(String count) {
    return Intl.message(
      'Photos ($count)',
      name: 'tab_photos',
      desc: '',
      args: [count],
    );
  }

  /// `Reviews ({count})`
  String tab_reviews(String count) {
    return Intl.message(
      'Reviews ($count)',
      name: 'tab_reviews',
      desc: '',
      args: [count],
    );
  }

  /// `Kebabbo's review`
  String get kebabbo_staff_review {
    return Intl.message(
      'Kebabbo\'s review',
      name: 'kebabbo_staff_review',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating_title {
    return Intl.message('Rating', name: 'rating_title', desc: '', args: []);
  }

  /// `Community ({count})`
  String community_count(String count) {
    return Intl.message(
      'Community ($count)',
      name: 'community_count',
      desc: '',
      args: [count],
    );
  }

  /// `Ingredient balance`
  String get ingredient_balance {
    return Intl.message(
      'Ingredient balance',
      name: 'ingredient_balance',
      desc: '',
      args: [],
    );
  }

  /// `Opening hours`
  String get opening_hours {
    return Intl.message(
      'Opening hours',
      name: 'opening_hours',
      desc: '',
      args: [],
    );
  }

  /// `No photos yet`
  String get no_photos_yet {
    return Intl.message(
      'No photos yet',
      name: 'no_photos_yet',
      desc: '',
      args: [],
    );
  }

  /// `Be the first to share a photo of your kebab or dish from this place!`
  String get no_photos_yet_desc {
    return Intl.message(
      'Be the first to share a photo of your kebab or dish from this place!',
      name: 'no_photos_yet_desc',
      desc: '',
      args: [],
    );
  }

  /// `Upload the first photo`
  String get upload_first_photo {
    return Intl.message(
      'Upload the first photo',
      name: 'upload_first_photo',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user_generic {
    return Intl.message('User', name: 'user_generic', desc: '', args: []);
  }

  /// `Share your experience at this place with the whole community!`
  String get no_reviews_yet_desc {
    return Intl.message(
      'Share your experience at this place with the whole community!',
      name: 'no_reviews_yet_desc',
      desc: '',
      args: [],
    );
  }

  /// `Write the first review`
  String get write_first_review {
    return Intl.message(
      'Write the first review',
      name: 'write_first_review',
      desc: '',
      args: [],
    );
  }

  /// `Based on {count} reviews`
  String based_on_reviews(String count) {
    return Intl.message(
      'Based on $count reviews',
      name: 'based_on_reviews',
      desc: '',
      args: [count],
    );
  }

  /// `Select the place you want to review! 🌯`
  String get select_place_to_review {
    return Intl.message(
      'Select the place you want to review! 🌯',
      name: 'select_place_to_review',
      desc: '',
      args: [],
    );
  }

  /// `Error sending the review: {error}`
  String error_sending_review(String error) {
    return Intl.message(
      'Error sending the review: $error',
      name: 'error_sending_review',
      desc: '',
      args: [error],
    );
  }

  /// `Choose the place`
  String get choose_place {
    return Intl.message(
      'Choose the place',
      name: 'choose_place',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Search Kebabbo places`
  String get search_kebabbo_places {
    return Intl.message(
      'Search Kebabbo places',
      name: 'search_kebabbo_places',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Istanbul, Agra, King...`
  String get search_places_hint {
    return Intl.message(
      'e.g. Istanbul, Agra, King...',
      name: 'search_places_hint',
      desc: '',
      args: [],
    );
  }

  /// `No place found. If it's new, use "Add a kebab place"!`
  String get no_place_found_add_it {
    return Intl.message(
      'No place found. If it\'s new, use "Add a kebab place"!',
      name: 'no_place_found_add_it',
      desc: '',
      args: [],
    );
  }

  /// `Your experience`
  String get your_experience {
    return Intl.message(
      'Your experience',
      name: 'your_experience',
      desc: '',
      args: [],
    );
  }

  /// `Comment / review *`
  String get comment_review_label {
    return Intl.message(
      'Comment / review *',
      name: 'comment_review_label',
      desc: '',
      args: [],
    );
  }

  /// `What did you like most? Any sauce or menu you'd recommend?`
  String get comment_review_hint {
    return Intl.message(
      'What did you like most? Any sauce or menu you\'d recommend?',
      name: 'comment_review_hint',
      desc: '',
      args: [],
    );
  }

  /// `Write a short comment about your experience`
  String get comment_review_required {
    return Intl.message(
      'Write a short comment about your experience',
      name: 'comment_review_required',
      desc: '',
      args: [],
    );
  }

  /// `Add a photo of your dish (optional)`
  String get add_dish_photo_optional {
    return Intl.message(
      'Add a photo of your dish (optional)',
      name: 'add_dish_photo_optional',
      desc: '',
      args: [],
    );
  }

  /// `Post review`
  String get publish_review {
    return Intl.message(
      'Post review',
      name: 'publish_review',
      desc: '',
      args: [],
    );
  }

  /// `Tap the map to select the exact spot`
  String get tap_map_to_select {
    return Intl.message(
      'Tap the map to select the exact spot',
      name: 'tap_map_to_select',
      desc: '',
      args: [],
    );
  }

  /// `Select on map`
  String get select_on_map {
    return Intl.message(
      'Select on map',
      name: 'select_on_map',
      desc: '',
      args: [],
    );
  }

  /// `Center on my location`
  String get center_on_my_location {
    return Intl.message(
      'Center on my location',
      name: 'center_on_my_location',
      desc: '',
      args: [],
    );
  }

  /// `Search address or place...`
  String get search_address_or_place {
    return Intl.message(
      'Search address or place...',
      name: 'search_address_or_place',
      desc: '',
      args: [],
    );
  }

  /// `Selected point`
  String get selected_point {
    return Intl.message(
      'Selected point',
      name: 'selected_point',
      desc: '',
      args: [],
    );
  }

  /// `Confirm this location`
  String get confirm_this_location {
    return Intl.message(
      'Confirm this location',
      name: 'confirm_this_location',
      desc: '',
      args: [],
    );
  }

  /// `Google Roadmap`
  String get map_style_google_road {
    return Intl.message(
      'Google Roadmap',
      name: 'map_style_google_road',
      desc: '',
      args: [],
    );
  }

  /// `Google Satellite`
  String get map_style_google_satellite {
    return Intl.message(
      'Google Satellite',
      name: 'map_style_google_satellite',
      desc: '',
      args: [],
    );
  }

  /// `Change map: {style}`
  String change_map_style(String style) {
    return Intl.message(
      'Change map: $style',
      name: 'change_map_style',
      desc: '',
      args: [style],
    );
  }

  /// `Satellite`
  String get map_style_satellite_short {
    return Intl.message(
      'Satellite',
      name: 'map_style_satellite_short',
      desc: '',
      args: [],
    );
  }

  /// `Road`
  String get map_style_road_short {
    return Intl.message(
      'Road',
      name: 'map_style_road_short',
      desc: '',
      args: [],
    );
  }

  /// `Users ({count})`
  String users_count(String count) {
    return Intl.message(
      'Users ($count)',
      name: 'users_count',
      desc: '',
      args: [count],
    );
  }

  /// `Community review`
  String get community_review {
    return Intl.message(
      'Community review',
      name: 'community_review',
      desc: '',
      args: [],
    );
  }

  /// `No users have reviewed this place yet!`
  String get no_user_reviews_yet {
    return Intl.message(
      'No users have reviewed this place yet!',
      name: 'no_user_reviews_yet',
      desc: '',
      args: [],
    );
  }

  /// `Directions`
  String get directions {
    return Intl.message('Directions', name: 'directions', desc: '', args: []);
  }

  /// `Join the community to discover and review the best kebabs`
  String get login_tagline {
    return Intl.message(
      'Join the community to discover and review the best kebabs',
      name: 'login_tagline',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account_question {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account_question',
      desc: '',
      args: [],
    );
  }

  /// `Create your profile and start reviewing the kebabs in your city`
  String get signup_tagline {
    return Intl.message(
      'Create your profile and start reviewing the kebabs in your city',
      name: 'signup_tagline',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get have_account_question {
    return Intl.message(
      'Already have an account?',
      name: 'have_account_question',
      desc: '',
      args: [],
    );
  }

  /// `Failed to reset password: {error}`
  String password_reset_failed(String error) {
    return Intl.message(
      'Failed to reset password: $error',
      name: 'password_reset_failed',
      desc: '',
      args: [error],
    );
  }

  /// `Goals & medals`
  String get objectives_and_medals {
    return Intl.message(
      'Goals & medals',
      name: 'objectives_and_medals',
      desc: '',
      args: [],
    );
  }

  /// `There are no other kebabs to recommend.`
  String get no_more_kebabs_to_recommend {
    return Intl.message(
      'There are no other kebabs to recommend.',
      name: 'no_more_kebabs_to_recommend',
      desc: '',
      args: [],
    );
  }

  /// `Reroll`
  String get reroll {
    return Intl.message('Reroll', name: 'reroll', desc: '', args: []);
  }

  /// `See hours, photos and reviews`
  String get see_hours_photos_reviews {
    return Intl.message(
      'See hours, photos and reviews',
      name: 'see_hours_photos_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `INGREDIENT AMOUNTS`
  String get ingredient_amounts_caps {
    return Intl.message(
      'INGREDIENT AMOUNTS',
      name: 'ingredient_amounts_caps',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting the post: {error}`
  String error_deleting_post(String error) {
    return Intl.message(
      'Error deleting the post: $error',
      name: 'error_deleting_post',
      desc: '',
      args: [error],
    );
  }

  /// `Error loading the Privacy Policy`
  String get privacy_policy_load_error {
    return Intl.message(
      'Error loading the Privacy Policy',
      name: 'privacy_policy_load_error',
      desc: '',
      args: [],
    );
  }

  /// `Preparing your kebab`
  String get cooking_title {
    return Intl.message(
      'Preparing your kebab',
      name: 'cooking_title',
      desc: '',
      args: [],
    );
  }

  /// `Finding an alternative`
  String get cooking_title_reroll {
    return Intl.message(
      'Finding an alternative',
      name: 'cooking_title_reroll',
      desc: '',
      args: [],
    );
  }

  /// `🔥 Warming up the bread...`
  String get cooking_step_1 {
    return Intl.message(
      '🔥 Warming up the bread...',
      name: 'cooking_step_1',
      desc: '',
      args: [],
    );
  }

  /// `🥩 Slicing the meat off the spit...`
  String get cooking_step_2 {
    return Intl.message(
      '🥩 Slicing the meat off the spit...',
      name: 'cooking_step_2',
      desc: '',
      args: [],
    );
  }

  /// `🥗 Adding fresh veggies and sauces...`
  String get cooking_step_3 {
    return Intl.message(
      '🥗 Adding fresh veggies and sauces...',
      name: 'cooking_step_3',
      desc: '',
      args: [],
    );
  }

  /// `🌯 Rolling it up like a pro...`
  String get cooking_step_4 {
    return Intl.message(
      '🌯 Rolling it up like a pro...',
      name: 'cooking_step_4',
      desc: '',
      args: [],
    );
  }

  /// `🔍 Finding the best kebab for you...`
  String get cooking_step_5 {
    return Intl.message(
      '🔍 Finding the best kebab for you...',
      name: 'cooking_step_5',
      desc: '',
      args: [],
    );
  }

  /// `👨‍🍳 New combination coming up...`
  String get reroll_step_1 {
    return Intl.message(
      '👨‍🍳 New combination coming up...',
      name: 'reroll_step_1',
      desc: '',
      args: [],
    );
  }

  /// `🔥 Balancing spices and cooking...`
  String get reroll_step_2 {
    return Intl.message(
      '🔥 Balancing spices and cooking...',
      name: 'reroll_step_2',
      desc: '',
      args: [],
    );
  }

  /// `✨ Looking for another great pick...`
  String get reroll_step_3 {
    return Intl.message(
      '✨ Looking for another great pick...',
      name: 'reroll_step_3',
      desc: '',
      args: [],
    );
  }

  /// `User not found. Please log in again.`
  String get user_not_found_login_again {
    return Intl.message(
      'User not found. Please log in again.',
      name: 'user_not_found_login_again',
      desc: '',
      args: [],
    );
  }

  /// `No pack ready right now (0/2). The next pack will be ready in {hours}h {minutes}m.`
  String no_pack_ready_hours_minutes(String hours, String minutes) {
    return Intl.message(
      'No pack ready right now (0/2). The next pack will be ready in ${hours}h ${minutes}m.',
      name: 'no_pack_ready_hours_minutes',
      desc: '',
      args: [hours, minutes],
    );
  }

  /// `No cards available.`
  String get no_cards_available {
    return Intl.message(
      'No cards available.',
      name: 'no_cards_available',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred: {error}`
  String an_error_occurred_with(String error) {
    return Intl.message(
      'An error occurred: $error',
      name: 'an_error_occurred_with',
      desc: '',
      args: [error],
    );
  }

  /// `Opening...`
  String get opening_in_progress {
    return Intl.message(
      'Opening...',
      name: 'opening_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Tap to open the pack!`
  String get tap_to_open_pack {
    return Intl.message(
      'Tap to open the pack!',
      name: 'tap_to_open_pack',
      desc: '',
      args: [],
    );
  }

  /// `DUPLICATE CARD`
  String get duplicate_card {
    return Intl.message(
      'DUPLICATE CARD',
      name: 'duplicate_card',
      desc: '',
      args: [],
    );
  }

  /// `NEW CARD UNLOCKED!`
  String get new_card_unlocked {
    return Intl.message(
      'NEW CARD UNLOCKED!',
      name: 'new_card_unlocked',
      desc: '',
      args: [],
    );
  }

  /// `{name} (already in collection)`
  String already_in_collection(String name) {
    return Intl.message(
      '$name (already in collection)',
      name: 'already_in_collection',
      desc: '',
      args: [name],
    );
  }

  /// `Drag with your finger to tilt in 3D`
  String get drag_to_tilt {
    return Intl.message(
      'Drag with your finger to tilt in 3D',
      name: 'drag_to_tilt',
      desc: '',
      args: [],
    );
  }

  /// `Open 2nd pack ({count})`
  String open_second_pack(String count) {
    return Intl.message(
      'Open 2nd pack ($count)',
      name: 'open_second_pack',
      desc: '',
      args: [count],
    );
  }

  /// `Add to collection`
  String get add_to_collection {
    return Intl.message(
      'Add to collection',
      name: 'add_to_collection',
      desc: '',
      args: [],
    );
  }

  /// `#{current} of {total}`
  String card_x_of_y(String current, String total) {
    return Intl.message(
      '#$current of $total',
      name: 'card_x_of_y',
      desc: '',
      args: [current, total],
    );
  }

  /// `Card collection`
  String get card_collection {
    return Intl.message(
      'Card collection',
      name: 'card_collection',
      desc: '',
      args: [],
    );
  }

  /// `All found! 🏆`
  String get all_found {
    return Intl.message('All found! 🏆', name: 'all_found', desc: '', args: []);
  }

  /// `{count} remaining`
  String remaining_count(String count) {
    return Intl.message(
      '$count remaining',
      name: 'remaining_count',
      desc: '',
      args: [count],
    );
  }

  /// `Tap to browse the full album ›`
  String get tap_to_browse_album {
    return Intl.message(
      'Tap to browse the full album ›',
      name: 'tap_to_browse_album',
      desc: '',
      args: [],
    );
  }

  /// `Unpack new cards`
  String get unpack_new_cards {
    return Intl.message(
      'Unpack new cards',
      name: 'unpack_new_cards',
      desc: '',
      args: [],
    );
  }

  /// `1 pack recharges every 12h (max 2)`
  String get recharge_info {
    return Intl.message(
      '1 pack recharges every 12h (max 2)',
      name: 'recharge_info',
      desc: '',
      args: [],
    );
  }

  /// `No pack ready. The next one will be available in {time}.`
  String no_pack_ready_timer(String time) {
    return Intl.message(
      'No pack ready. The next one will be available in $time.',
      name: 'no_pack_ready_timer',
      desc: '',
      args: [time],
    );
  }

  /// `1st pack`
  String get first_pack_slot {
    return Intl.message(
      '1st pack',
      name: 'first_pack_slot',
      desc: '',
      args: [],
    );
  }

  /// `2nd pack`
  String get second_pack_slot {
    return Intl.message(
      '2nd pack',
      name: 'second_pack_slot',
      desc: '',
      args: [],
    );
  }

  /// `Ready!`
  String get ready {
    return Intl.message('Ready!', name: 'ready', desc: '', args: []);
  }

  /// `Queued`
  String get queued {
    return Intl.message('Queued', name: 'queued', desc: '', args: []);
  }

  /// `Packs fully recharged: 2 / 2 ready! 📦✨`
  String get packs_full {
    return Intl.message(
      'Packs fully recharged: 2 / 2 ready! 📦✨',
      name: 'packs_full',
      desc: '',
      args: [],
    );
  }

  /// `Open pack (2 ready!)`
  String get open_pack_two_ready {
    return Intl.message(
      'Open pack (2 ready!)',
      name: 'open_pack_two_ready',
      desc: '',
      args: [],
    );
  }

  /// `No pack ready`
  String get no_pack_ready {
    return Intl.message(
      'No pack ready',
      name: 'no_pack_ready',
      desc: '',
      args: [],
    );
  }

  /// `TCG card album`
  String get tcg_album {
    return Intl.message(
      'TCG card album',
      name: 'tcg_album',
      desc: '',
      args: [],
    );
  }

  /// `cards unlocked`
  String get cards_unlocked {
    return Intl.message(
      'cards unlocked',
      name: 'cards_unlocked',
      desc: '',
      args: [],
    );
  }

  /// `{count} missing`
  String missing_count(String count) {
    return Intl.message(
      '$count missing',
      name: 'missing_count',
      desc: '',
      args: [count],
    );
  }

  /// `2 / 2 packs ready to open`
  String get packs_ready_2 {
    return Intl.message(
      '2 / 2 packs ready to open',
      name: 'packs_ready_2',
      desc: '',
      args: [],
    );
  }

  /// `1 / 2 pack ready to open`
  String get packs_ready_1 {
    return Intl.message(
      '1 / 2 pack ready to open',
      name: 'packs_ready_1',
      desc: '',
      args: [],
    );
  }

  /// `0 / 2 packs available`
  String get packs_ready_0 {
    return Intl.message(
      '0 / 2 packs available',
      name: 'packs_ready_0',
      desc: '',
      args: [],
    );
  }

  /// `Maximum charge reached (1 every 12h)`
  String get max_charge_reached {
    return Intl.message(
      'Maximum charge reached (1 every 12h)',
      name: 'max_charge_reached',
      desc: '',
      args: [],
    );
  }

  /// `Next recharge in {time}`
  String next_recharge_in(String time) {
    return Intl.message(
      'Next recharge in $time',
      name: 'next_recharge_in',
      desc: '',
      args: [time],
    );
  }

  /// `Recharging: next one in {time}`
  String recharging_next_in(String time) {
    return Intl.message(
      'Recharging: next one in $time',
      name: 'recharging_next_in',
      desc: '',
      args: [time],
    );
  }

  /// `Unpack & view collection`
  String get unpack_and_view_collection {
    return Intl.message(
      'Unpack & view collection',
      name: 'unpack_and_view_collection',
      desc: '',
      args: [],
    );
  }

  /// `First Bite`
  String get medal_0_title {
    return Intl.message(
      'First Bite',
      name: 'medal_0_title',
      desc: '',
      args: [],
    );
  }

  /// `Serial Taster`
  String get medal_1_title {
    return Intl.message(
      'Serial Taster',
      name: 'medal_1_title',
      desc: '',
      args: [],
    );
  }

  /// `Kebab Critic`
  String get medal_2_title {
    return Intl.message(
      'Kebab Critic',
      name: 'medal_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Master of the Spit`
  String get medal_3_title {
    return Intl.message(
      'Master of the Spit',
      name: 'medal_3_title',
      desc: '',
      args: [],
    );
  }

  /// `Food Legend`
  String get medal_4_title {
    return Intl.message(
      'Food Legend',
      name: 'medal_4_title',
      desc: '',
      args: [],
    );
  }

  /// `Voice of the Feed`
  String get medal_5_title {
    return Intl.message(
      'Voice of the Feed',
      name: 'medal_5_title',
      desc: '',
      args: [],
    );
  }

  /// `Taste Reporter`
  String get medal_6_title {
    return Intl.message(
      'Taste Reporter',
      name: 'medal_6_title',
      desc: '',
      args: [],
    );
  }

  /// `Kebab Influencer`
  String get medal_7_title {
    return Intl.message(
      'Kebab Influencer',
      name: 'medal_7_title',
      desc: '',
      args: [],
    );
  }

  /// `Community Pillar`
  String get medal_8_title {
    return Intl.message(
      'Community Pillar',
      name: 'medal_8_title',
      desc: '',
      args: [],
    );
  }

  /// `You wrote your first review of a kebab place. Welcome to the family of Kebabbo critics!`
  String get medal_0_desc {
    return Intl.message(
      'You wrote your first review of a kebab place. Welcome to the family of Kebabbo critics!',
      name: 'medal_0_desc',
      desc: '',
      args: [],
    );
  }

  /// `You've reviewed 5 different places. Your palate is starting to recognise the true art of the spit!`
  String get medal_1_desc {
    return Intl.message(
      'You\'ve reviewed 5 different places. Your palate is starting to recognise the true art of the spit!',
      name: 'medal_1_desc',
      desc: '',
      args: [],
    );
  }

  /// `10 reviews done! Your ratings guide kebab places and the whole community.`
  String get medal_2_desc {
    return Intl.message(
      '10 reviews done! Your ratings guide kebab places and the whole community.',
      name: 'medal_2_desc',
      desc: '',
      args: [],
    );
  }

  /// `20 reviews written! No wrap, sauce or flatbread holds any secrets from you. A true master!`
  String get medal_3_desc {
    return Intl.message(
      '20 reviews written! No wrap, sauce or flatbread holds any secrets from you. A true master!',
      name: 'medal_3_desc',
      desc: '',
      args: [],
    );
  }

  /// `30 reviews under your belt! You've reached the top of the Kebabbo food experience. A living legend!`
  String get medal_4_desc {
    return Intl.message(
      '30 reviews under your belt! You\'ve reached the top of the Kebabbo food experience. A living legend!',
      name: 'medal_4_desc',
      desc: '',
      args: [],
    );
  }

  /// `You published your first post in the social feed. Your passion for kebab is now public!`
  String get medal_5_desc {
    return Intl.message(
      'You published your first post in the social feed. Your passion for kebab is now public!',
      name: 'medal_5_desc',
      desc: '',
      args: [],
    );
  }

  /// `You've shared 5 posts with photos and thoughts in the feed. The community loves your updates!`
  String get medal_6_desc {
    return Intl.message(
      'You\'ve shared 5 posts with photos and thoughts in the feed. The community loves your updates!',
      name: 'medal_6_desc',
      desc: '',
      args: [],
    );
  }

  /// `10 posts shared! Your shots and place tags make the whole city hungry.`
  String get medal_7_desc {
    return Intl.message(
      '10 posts shared! Your shots and place tags make the whole city hungry.',
      name: 'medal_7_desc',
      desc: '',
      args: [],
    );
  }

  /// `50 posts in the community! You're an irreplaceable pillar of the Kebabbo feed!`
  String get medal_8_desc {
    return Intl.message(
      '50 posts in the community! You\'re an irreplaceable pillar of the Kebabbo feed!',
      name: 'medal_8_desc',
      desc: '',
      args: [],
    );
  }

  /// `Supreme Legend`
  String get rank_5_name {
    return Intl.message(
      'Supreme Legend',
      name: 'rank_5_name',
      desc: '',
      args: [],
    );
  }

  /// `You've achieved every milestone! You're in Kebabbo's Olympus.`
  String get rank_5_desc {
    return Intl.message(
      'You\'ve achieved every milestone! You\'re in Kebabbo\'s Olympus.',
      name: 'rank_5_desc',
      desc: '',
      args: [],
    );
  }

  /// `Kebabbo Veteran`
  String get rank_4_name {
    return Intl.message(
      'Kebabbo Veteran',
      name: 'rank_4_name',
      desc: '',
      args: [],
    );
  }

  /// `Just a few milestones left to complete everything!`
  String get rank_4_desc {
    return Intl.message(
      'Just a few milestones left to complete everything!',
      name: 'rank_4_desc',
      desc: '',
      args: [],
    );
  }

  /// `Sauce Master`
  String get rank_3_name {
    return Intl.message(
      'Sauce Master',
      name: 'rank_3_name',
      desc: '',
      args: [],
    );
  }

  /// `A recognised expert in both taste and community.`
  String get rank_3_desc {
    return Intl.message(
      'A recognised expert in both taste and community.',
      name: 'rank_3_desc',
      desc: '',
      args: [],
    );
  }

  /// `Döner Gourmet`
  String get rank_2_name {
    return Intl.message(
      'Döner Gourmet',
      name: 'rank_2_name',
      desc: '',
      args: [],
    );
  }

  /// `You have a great palate and an active voice in the feed.`
  String get rank_2_desc {
    return Intl.message(
      'You have a great palate and an active voice in the feed.',
      name: 'rank_2_desc',
      desc: '',
      args: [],
    );
  }

  /// `Spit Enthusiast`
  String get rank_1_name {
    return Intl.message(
      'Spit Enthusiast',
      name: 'rank_1_name',
      desc: '',
      args: [],
    );
  }

  /// `The first milestones are yours! Keep reviewing and posting.`
  String get rank_1_desc {
    return Intl.message(
      'The first milestones are yours! Keep reviewing and posting.',
      name: 'rank_1_desc',
      desc: '',
      args: [],
    );
  }

  /// `Kebab Novice`
  String get rank_0_name {
    return Intl.message(
      'Kebab Novice',
      name: 'rank_0_name',
      desc: '',
      args: [],
    );
  }

  /// `Write your first review or create a post to start your collection!`
  String get rank_0_desc {
    return Intl.message(
      'Write your first review or create a post to start your collection!',
      name: 'rank_0_desc',
      desc: '',
      args: [],
    );
  }

  /// `reviews`
  String get unit_reviews {
    return Intl.message('reviews', name: 'unit_reviews', desc: '', args: []);
  }

  /// `posts`
  String get unit_posts {
    return Intl.message('posts', name: 'unit_posts', desc: '', args: []);
  }

  /// `Milestone reached 🎉`
  String get goal_reached {
    return Intl.message(
      'Milestone reached 🎉',
      name: 'goal_reached',
      desc: '',
      args: [],
    );
  }

  /// `In progress ⏳`
  String get in_progress {
    return Intl.message(
      'In progress ⏳',
      name: 'in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress_label {
    return Intl.message('Progress', name: 'progress_label', desc: '', args: []);
  }

  /// `Only {missing} {unit} left to unlock this medal!`
  String medal_missing(String missing, String unit) {
    return Intl.message(
      'Only $missing $unit left to unlock this medal!',
      name: 'medal_missing',
      desc: '',
      args: [missing, unit],
    );
  }

  /// `Medals & milestones`
  String get medals_page_title {
    return Intl.message(
      'Medals & milestones',
      name: 'medals_page_title',
      desc: '',
      args: [],
    );
  }

  /// `All ({count})`
  String filter_all_count(String count) {
    return Intl.message(
      'All ($count)',
      name: 'filter_all_count',
      desc: '',
      args: [count],
    );
  }

  /// `Reviews ({count})`
  String filter_reviews_count(String count) {
    return Intl.message(
      'Reviews ($count)',
      name: 'filter_reviews_count',
      desc: '',
      args: [count],
    );
  }

  /// `Unlocked ({count})`
  String filter_unlocked_count(String count) {
    return Intl.message(
      'Unlocked ($count)',
      name: 'filter_unlocked_count',
      desc: '',
      args: [count],
    );
  }

  /// `No medals in this filter`
  String get no_medals_in_filter {
    return Intl.message(
      'No medals in this filter',
      name: 'no_medals_in_filter',
      desc: '',
      args: [],
    );
  }

  /// `{unlocked} of {total} unlocked`
  String unlocked_of_total(String unlocked, String total) {
    return Intl.message(
      '$unlocked of $total unlocked',
      name: 'unlocked_of_total',
      desc: '',
      args: [unlocked, total],
    );
  }

  /// `{percent}% complete`
  String percent_completed(String percent) {
    return Intl.message(
      '$percent% complete',
      name: 'percent_completed',
      desc: '',
      args: [percent],
    );
  }

  /// `Reviews`
  String get reviews_label {
    return Intl.message('Reviews', name: 'reviews_label', desc: '', args: []);
  }

  /// `Feed posts`
  String get feed_posts_label {
    return Intl.message(
      'Feed posts',
      name: 'feed_posts_label',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked`
  String get unlocked_badge {
    return Intl.message('Unlocked', name: 'unlocked_badge', desc: '', args: []);
  }

  /// `Completed! ⭐`
  String get completed_badge {
    return Intl.message(
      'Completed! ⭐',
      name: 'completed_badge',
      desc: '',
      args: [],
    );
  }

  /// `Open the app`
  String get open_in_app {
    return Intl.message(
      'Open the app',
      name: 'open_in_app',
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
