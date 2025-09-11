// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get nome_non_disponibile => 'Name not available';

  @override
  String get seleziona_il_tuo_kebab_preferito => 'Select your favorite kebab';

  @override
  String get consigliaci_un_kebabbaro => 'Recommend a kebab place';

  @override
  String get nome_del_kebabbaro => 'Name of the kebab place';

  @override
  String get annulla => 'Cancel';

  @override
  String get invia => 'Send';

  @override
  String get la_tua_soluzione_per_il_pranzo_universitario =>
      'Your solution for university lunch';

  @override
  String get in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google =>
      'In Italy, the world of Kebab is still a dark world. The best places are underrated, and the worst ones get high reviews on Google.';

  @override
  String get per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab =>
      'That\'s why we are here: university students, like you, with years of experience as Kebab eaters.';

  @override
  String get testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo =>
      'We test and review Kebab places and Street Food for you. Welcome to Kebabbo.';

  @override
  String get failed_to_load_reviews_count => 'Failed to load reviews count';

  @override
  String get cambia_username => 'Change Username';

  @override
  String get nuovo_username => 'New username...';

  @override
  String get cancel => 'Cancel';

  @override
  String get update => 'Update';

  @override
  String get failed_to_upload_avatar => 'Failed to upload avatar';

  @override
  String get edit_profile => 'Edit profile';

  @override
  String get unexpected_error_occurred => 'Unexpected error occurred';

  @override
  String get failed_to_load_favorites => 'Failed to load favorites';

  @override
  String get nessun_kebab_tra_i_preferiti => 'No kebabs in favorites';

  @override
  String get no_suggestions_available => 'No suggestions available';

  @override
  String get devi_essere_autenticato_per_postare =>
      'You must be authenticated to post';

  @override
  String get il_testo_non_puo_essere_vuoto => 'Text cannot be empty';

  @override
  String get errore_nel_caricamento_dellimage => 'Error loading image:';

  @override
  String get congratulazioni => 'Congratulations!';

  @override
  String get hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia =>
      'You have reached a new milestone and obtained a new medal!';

  @override
  String get scrivi_un_post => 'Write a post...';

  @override
  String get testo_non_disponibile => 'Text not available';

  @override
  String get non_segui_ancora_nessuno => 'You are not following anyone yet';

  @override
  String get errore_nel_caricamento_dei_follower => 'Error loading followers';

  @override
  String get nessun_utente_ti_segue => 'No users follow you';

  @override
  String get il_kebab_che_ti_raccomandiamo_e => 'The kebab we recommend is:';

  @override
  String get kebab_consigliato => 'Recommended Kebab';

  @override
  String get kebab_sconosciuto => 'Unknown Kebab';

  @override
  String get descrizione_non_disponibile => 'Description not available';

  @override
  String get back_to_build => 'Back to Build';

  @override
  String get check_your_email_for_a_login_link =>
      'Check your email for a login link!';

  @override
  String get by_signing_in_you_agree_to_our_terms_and_privacy_policy =>
      'By signing in, you agree to our terms and privacy policy.';

  @override
  String get prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi =>
      '\"Take, and eat of this, all of you: this is the Kebab offered in sacrifice for you.\"';

  @override
  String get failed_to_load_medals => 'Failed to load medals';

  @override
  String get prima_review => 'first review';

  @override
  String get primo_post => 'first post';

  @override
  String reviewMessage(
      String kebabName,
      String qualityRating,
      String quantityRating,
      String menuRating,
      String priceRating,
      String funRating,
      String description) {
    return 'I just reviewed the kebab at $kebabName!\n\nQuality: $qualityRating\nQuantity: $quantityRating\nMenu: $menuRating\nPrice: $priceRating\nFun: $funRating\n\n$description';
  }

  @override
  String get review_updated_successfully => 'Review updated successfully';

  @override
  String get review_submitted_successfully => 'Review submitted successfully';

  @override
  String get nuova_medaglia => 'New Medal!';

  @override
  String get hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo =>
      'You received a new medal for your contribution!';

  @override
  String get review => 'Review';

  @override
  String get oops_review_not_found => 'Oops! Review Not Found';

  @override
  String get please_log_in_to_submit_your_review =>
      'Please Log In to Submit Your Review';

  @override
  String get rate_the_kebab => 'Rate the Kebab';

  @override
  String get quality => 'Quality';

  @override
  String get quantity => 'Quantity';

  @override
  String get menu => 'Menu';

  @override
  String get price => 'Price';

  @override
  String get fun => 'Fun';

  @override
  String get description_is_required => 'Description is required';

  @override
  String get submit_review => 'Submit Review';

  @override
  String get registrati_per_poter_visualizzare_il_feed =>
      'Register to view the feed';

  @override
  String get cerca_utenti => 'Search users...';

  @override
  String get anonimo => 'Anonymous';

  @override
  String get nessun_utente_seguito => 'No users followed';

  @override
  String get failed_to_load_follower_count => 'Failed to load follower count';

  @override
  String get failed_to_load_profile => 'Failed to load profile';

  @override
  String get failed_to_update_follow_status => 'Failed to update follow status';

  @override
  String get failed_to_load_post_count => 'Failed to load post count';

  @override
  String get segui_gia => 'Already following';

  @override
  String get segui => 'Follow';

  @override
  String get seguiti => 'Followed';

  @override
  String get world => 'World';

  @override
  String get legends => 'Legends';

  @override
  String get errore => 'Error:';

  @override
  String get nessun_kebabbaro_presente => 'No Kebab places present :(';

  @override
  String get thank_you => 'Thank You';

  @override
  String get thank_you_for_your_review => 'Thank you for your review!';

  @override
  String get you_can_access_reviews_at_any_time_from_your_account =>
      'You can access reviews at any time from your account.';

  @override
  String get build_your_kebab => 'Build Your Kebab';

  @override
  String get distanza_massima => 'Maximum Distance';

  @override
  String get preferiti_solo_per_utenti_registrati =>
      'Favorites only for registered users';

  @override
  String get it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again =>
      'It looks like the review you are trying to access does not exist. Please check the link and try again.';

  @override
  String distanceLabel200m(String results) {
    return '200 meters ($results results)';
  }

  @override
  String distanceLabel500m(String results) {
    return '500 meters ($results results)';
  }

  @override
  String distanceLabel1km(String results) {
    return '1 km ($results results)';
  }

  @override
  String distanceLabel10km(String results) {
    return '10 km ($results results)';
  }

  @override
  String distanceLabelUnlimited(String results) {
    return 'Unlimited ($results results)';
  }

  @override
  String get nessun_kebab_corrispondente_trovato_nel_raggio_selezionato =>
      'No matching kebab found within the selected radius';

  @override
  String get cerca_un_kebabbaro => 'Search for a kebab place...';

  @override
  String get aperti_ora => 'Open now';

  @override
  String get failed_to_load_posts => 'Failed to load posts';

  @override
  String get i_tuoi_post => 'Your Posts';

  @override
  String get nessun_post_trovato => 'No posts found';

  @override
  String get nessuna_recensione_ancora => 'No reviews yet';

  @override
  String get successfully_updated_profile => 'Successfully updated profile!';

  @override
  String get username_cannot_contain_spaces_use_undescores_instead =>
      'Username cannot contain spaces,\nuse underscores instead!';

  @override
  String get username_must_be_at_least_3_characters_long =>
      'Username must be at least 3 \ncharacters long!';

  @override
  String get username_cannot_be_more_than_12_characters =>
      'Username cannot be more than \n12 characters!';

  @override
  String get username_can_only_contain_letters_numbers_and_underscores =>
      'Username can only contain letters,\nnumbers, and underscores!';

  @override
  String get esplora => 'Explore';

  @override
  String get mappa => 'Map';

  @override
  String get no_image => 'No Image';

  @override
  String get nessun_commento_disponibile => 'No comments available';

  @override
  String get commento_non_disponibile => 'Comment not available';

  @override
  String get scrivi_un_commento => 'Write a comment...';

  @override
  String get il_commento_e_stato_aggiunto_con_successo =>
      'The comment was added successfully!';

  @override
  String get user_not_found => 'User not found';

  @override
  String get an_error_occurred => 'An error occurred';

  @override
  String get log_in_con_google => 'Log In with Google';

  @override
  String get aperto => 'Open';

  @override
  String get chiuso => 'Closed';

  @override
  String get nessuna_recensione_disponibile => 'No reviews available';

  @override
  String get users_review => 'Users Review';

  @override
  String get km_distante_da_te => 'km away from you';

  @override
  String get distanza_non_disponibile => 'Distance not available';

  @override
  String get verdura => 'Vegetables';

  @override
  String get yogurt => 'Yogurt';

  @override
  String get spicy => 'Spicy';

  @override
  String get cipolla => 'Onion';

  @override
  String get description => 'Description';

  @override
  String get more_info => 'How to review a kebab';

  @override
  String get close => 'Close';

  @override
  String get popup_title => 'How to write your own review';

  @override
  String get first_time_title => 'Welcome to Kebabbo!';

  @override
  String get elimina => 'Delete';

  @override
  String get vuoi_veramente_eliminare_il_post =>
      'Do you really want to delete the post?';

  @override
  String get conferma_eliminazione => 'Confirm deletion';

  @override
  String get post_eliminato => 'Post deleted';

  @override
  String get devi_essere_autenticato_per_mettere_mi_piace =>
      'You must login to like';

  @override
  String get accedi_per_cercare => 'Log in to post and see peoples\' info';

  @override
  String get devi_essere_autenticato_per_commentare =>
      'You must login to comment';

  @override
  String get devi_essere_autenticato_per_visualizzare_il_profilo =>
      'You must login to view the profile';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get please_enter_your_email => 'Please enter your email';

  @override
  String get please_enter_a_valid_email => 'Please enter a valid email';

  @override
  String get please_enter_a_password => 'Please enter a password';

  @override
  String get password_must_be_at_least_6_characters =>
      'Password must be at least 6 characters';

  @override
  String get check_your_email_for_a_verification_link =>
      'Check your email for a verification link';

  @override
  String get dont_have_an_account_sign_up => 'Don\'t have an account? Sign Up';

  @override
  String get logged_in => 'Logged in';

  @override
  String get login => 'Log In';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get popup_description =>
      'In order to keep the user reviews truthful, to review yourself the kebab,\nyou need to go in person to the kebab place and find the affixed Kebabbo sticker nearby,\nscanning it will bring you to the review page.';

  @override
  String get first_time_description =>
      'Welcome to Kebabbo!\nWhat can you do on here?\nWell, you can explore our professional kebab reviews or check out other users\' ratings.\nWrite your own review by scanning the Kebabbo sticker at the kebab place.\nCheck out other users\' profiles, posts and connect with fellows kebab enjoyers and earn achievements for using the app.\n Use our search and filter features or our powerful build tool to find your ideal kebab or explore our interactive map to discover nearby gems.\nHave fun and kebab away!';

  @override
  String get cambia_profilo => 'Change profile';

  @override
  String get cambia_profilepic => 'Change profile picture';

  @override
  String get please_fill_in_all_fields => 'Please fill in all fields';

  @override
  String get password_minimum_length =>
      'Password must be at least 6 characters';

  @override
  String get email_required => 'Email is required';

  @override
  String get send_reset_email => 'Send reset email';

  @override
  String get forgot_password => 'Forgot password';

  @override
  String get check_your_email_for_a_reset_link =>
      'Check your email for a reset link';

  @override
  String get password_reset_success => 'Password reset successful';

  @override
  String get new_password => 'New Password';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get nessun_kebab_vicino_a_te =>
      'No kebab near you \nYou must be near the kebab shop to review it for authenticity reasons.\nCheck your location and reload the page.';

  @override
  String get riprova => 'Try again';

  @override
  String get no_thanks => 'No, thanks';

  @override
  String get app_is_installed_description =>
      'You already have the app installed. Do you want to open it?';

  @override
  String get app_is_installed => 'App is installed';

  @override
  String get single_card => 'Kebabbo Card';

  @override
  String get pack => 'Kebabbo Pack';

  @override
  String get my_cards => 'Kebab TCG Carousel';

  @override
  String get pack_too_soon => 'This pack is not available yet';

  @override
  String get no_cards_yet => 'You don\'t have any cards yet';

  @override
  String get open_pack => 'Open Pack';

  @override
  String get go_back => 'Go Back';

  @override
  String get write_a_review_for_a_kebab_near_you => 'Write a review';

  @override
  String get autenticazione_necessaria => 'You must be logged in to comment.';

  @override
  String get commento_vuoto => 'The comment text cannot be empty.';

  @override
  String get found_all_cards => 'All cards found.';
}
