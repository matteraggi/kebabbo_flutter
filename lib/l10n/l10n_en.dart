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
      'Open it in the app for a better experience. If you don\'t have it yet, we\'ll take you to Google Play.';

  @override
  String get app_is_installed => 'Kebabbo is also an app!';

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

  @override
  String get about => 'About';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get add_kebab => 'Add a Kebab';

  @override
  String get logout => 'Logout';

  @override
  String get could_not_open_link => 'Could not open the link.';

  @override
  String get generic_error => 'Error: ';

  @override
  String get posts => 'Posts';

  @override
  String get followers => 'Followers';

  @override
  String get following => 'Following';

  @override
  String get error_processing_image => 'Error processing image:';

  @override
  String get followed_filter => 'Following';

  @override
  String get all_filter => 'All';

  @override
  String get games_tools_title => 'Games & Tools';

  @override
  String get login_required_section => 'You must log in to use this section.';

  @override
  String get add_review_title => 'Add Review';

  @override
  String get add_review_subtitle => 'Tried a new kebab?';

  @override
  String get pack_button_title => 'Pack';

  @override
  String get pack_button_subtitle => 'open your favorite kebab pack';

  @override
  String get collection_title => 'Collection';

  @override
  String get collection_subtitle => 'check your kebabbo cards';

  @override
  String get create_kebab_title => 'Create Kebab';

  @override
  String get create_kebab_subtitle => 'build your own kebab';

  @override
  String get your_medals_title => 'Your Medals';

  @override
  String get add_review_appbar_title => 'Add Review';

  @override
  String get error_loading_kebabs => 'Error loading kebabs: ';

  @override
  String get kebab_not_found => 'Kebab not found';

  @override
  String get add_new_kebab_confirmation =>
      'You are about to add \"\$name\" as a new kebab. Are you sure it doesn\'t already exist?';

  @override
  String get city => 'City';

  @override
  String get yes_create_new => 'Yes, create new';

  @override
  String get user_not_authenticated => 'User not authenticated';

  @override
  String get error_adding_review => 'Error adding review: ';

  @override
  String get name_label => 'Name';

  @override
  String get required_field => 'Required field';

  @override
  String get kebab_already_exists => 'Kebab already exists';

  @override
  String get your_review_optional => 'Your review (optional)';

  @override
  String get kebab_tag => 'Kebab';

  @override
  String get sandwich_tag => 'Sandwich';

  @override
  String get dimension => 'Size';

  @override
  String get meat => 'Meat';

  @override
  String get onion => 'Onion';

  @override
  String get vegetables => 'Vegetables';

  @override
  String get gluten_free => 'Gluten Free';

  @override
  String get advanced_filters => 'Advanced Filters';

  @override
  String get open_now => 'Open Now';

  @override
  String get sandwiches => 'Sandwiches';

  @override
  String get order_by => 'Order by';

  @override
  String get filter_by_distance => 'Filter by distance';

  @override
  String get sort_stars => 'stars';

  @override
  String get sort_quality => 'quality';

  @override
  String get sort_price => 'price';

  @override
  String get sort_dimension => 'size';

  @override
  String get sort_menu => 'menu';

  @override
  String get sort_name => 'name';

  @override
  String get sort_distance => 'distance';

  @override
  String get fun_exclamation => 'fun!';

  @override
  String get kebabbo_review => 'Kebabbo Review';

  @override
  String get review_this_kebab => 'Review this Kebab';

  @override
  String get staff => 'Staff';

  @override
  String get users => 'Users';

  @override
  String get one_review => '1 review';

  @override
  String get five_reviews => '5 reviews';

  @override
  String get ten_reviews => '10 reviews';

  @override
  String get twenty_reviews => '20 reviews';

  @override
  String get thirty_reviews => '30 reviews';

  @override
  String get one_post => '1 post';

  @override
  String get five_posts => '5 posts';

  @override
  String get ten_posts => '10 posts';

  @override
  String get fifty_posts => '50 posts';

  @override
  String get build_button => 'Build!';

  @override
  String get objectives => 'Objectives';

  @override
  String get your_kebab => 'Your kebab';

  @override
  String get kebab_no_longer_available => 'Kebab no longer available';

  @override
  String get inserted_by => 'Added by';

  @override
  String get community_upload => 'Community';

  @override
  String get staff_certified => 'Kebabbo Staff Certified';

  @override
  String get swipe_collection_hint => 'Swipe to browse collection';

  @override
  String get examine_3d => 'Examine in 3D';

  @override
  String get details => 'Details';

  @override
  String get verified_by_staff_tooltip => 'Verified by Kebabbo staff';

  @override
  String get sign_up_with_google => 'Sign up with Google';

  @override
  String get or_continue_with_email => 'or with email';

  @override
  String get already_have_an_account => 'Already have an account? Sign in';

  @override
  String get location_services_disabled => 'Location services are disabled.';

  @override
  String get location_permission_denied => 'Location permission denied.';

  @override
  String get location_permission_denied_forever =>
      'Location permission permanently denied. You can enable it in the settings.';

  @override
  String get session_expired => 'Session expired. Please log in again.';

  @override
  String get contribute_title => 'Contribute to Kebabbo';

  @override
  String get contribute_subtitle =>
      'Help us map and review the best kebab places!';

  @override
  String get add_kebab_place => 'Add a kebab place';

  @override
  String get add_kebab_place_subtitle => 'Put a new place on the map';

  @override
  String get write_review_title => 'Write a Review';

  @override
  String get write_review_subtitle =>
      'Rate the quality, the meat and the sauces';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_add => 'Add';

  @override
  String get nav_feed => 'Feed';

  @override
  String get nav_account => 'Account';

  @override
  String get page_not_found => 'Page not found';

  @override
  String get maps_link_name_and_coords_found =>
      'Coordinates and name detected from the Maps link! 📍';

  @override
  String get maps_link_coords_found =>
      'Coordinates detected from the Maps link! 📍';

  @override
  String get maps_link_failed =>
      'Couldn\'t extract the coordinates from the link. Use \"Choose on map\".';

  @override
  String get select_location_first =>
      'Select the location on the map before continuing! 📍';

  @override
  String error_saving(String error) {
    return 'Error while saving: $error';
  }

  @override
  String get section_location => '1. Location on the map 📍';

  @override
  String get section_location_hint =>
      'Tap to drop the pin or search for the place. Coordinates, address and name will be filled in automatically!';

  @override
  String get edit_location_on_map => 'Edit location on the map';

  @override
  String get choose_on_map_recommended => 'Choose on map (recommended)';

  @override
  String city_label(String city) {
    return 'City: $city';
  }

  @override
  String get location_selected => 'Location selected';

  @override
  String get paste_maps_link_prompt =>
      'Already have a Google Maps link? Paste it here';

  @override
  String get google_maps_link => 'Google Maps link';

  @override
  String get extract => 'Extract';

  @override
  String get section_name_category => '2. Name and category 🌯';

  @override
  String get kebab_place_name_label => 'Name of the place *';

  @override
  String get kebab_place_name_hint => 'e.g. Bella Istanbul 3';

  @override
  String get name_autofilled_helper =>
      'Filled in automatically from the map (feel free to edit it)';

  @override
  String get enter_place_name => 'Enter the name of the place';

  @override
  String get tag_kebab_pill => 'Kebab 🌯';

  @override
  String get tag_sandwich_pill => 'Sandwich shop 🥪';

  @override
  String get gluten_free_option => 'Gluten-free option';

  @override
  String get gluten_free_option_desc =>
      'Offers certified gluten-free bread or options';

  @override
  String get section_opening_hours => '3. Opening hours ⏰';

  @override
  String get opening_hours_hint =>
      'You can leave them unspecified, pick a template or set custom hours:';

  @override
  String get hours_preset_none => 'Not specified (default)';

  @override
  String get hours_preset_continuous => 'All day (11-23) 🌯';

  @override
  String get hours_preset_night => 'Late night (11-02) 🌙';

  @override
  String get hours_preset_lunch_dinner => 'Lunch and dinner 🍽️';

  @override
  String get hours_preset_custom => 'Custom ⚙️';

  @override
  String get hours_none_note => 'No opening hours will be saved.';

  @override
  String get custom_hours_hint =>
      'Set the hours for each day (e.g. 11:00-23:00, or \"closed\"):';

  @override
  String get section_photo_optional => '4. Photo of the place (optional)';

  @override
  String get upload_place_photo => 'Upload a photo of the spit or the place';

  @override
  String get section_initial_review => '5. Your first review';

  @override
  String get description_review_label => 'Description / review *';

  @override
  String get description_review_hint =>
      'Tell us about this kebab: bread, meat, flavours...';

  @override
  String get description_review_required =>
      'Write a short comment to introduce the place';

  @override
  String get overall_rating_1_5 => 'Overall rating (1 to 5)';

  @override
  String get ingredient_balance_1_10 => 'Ingredient balance (1 to 10)';

  @override
  String get add_kebab_to_kebabbo => 'Add place to Kebabbo';

  @override
  String get added_to_favorites => 'Added to favorites ❤️';

  @override
  String get removed_from_favorites => 'Removed from favorites';

  @override
  String get remove_from_favorites => 'Remove from favorites';

  @override
  String get save_to_favorites => 'Save to favorites';

  @override
  String get map_not_available => 'Map not available for this place';

  @override
  String get login_to_post_photos => 'Log in to post photos';

  @override
  String get select_photo_first => 'Select a photo before posting';

  @override
  String get photo_added => 'Photo added! 📸';

  @override
  String upload_error(String error) {
    return 'Upload error: $error';
  }

  @override
  String add_photo_to(String name) {
    return 'Add a photo to $name';
  }

  @override
  String get tap_to_select_photo => 'Tap to select a photo';

  @override
  String get photo_caption_hint => 'Write a comment or describe your kebab...';

  @override
  String get publish_photo => 'Post photo';

  @override
  String get kebabbo_user => 'Kebabbo user';

  @override
  String get kebab_place_not_found => 'Place not found or removed.';

  @override
  String get review_action => 'Review';

  @override
  String get photo => 'Photo';

  @override
  String get tab_overview => 'Overview';

  @override
  String tab_photos(String count) {
    return 'Photos ($count)';
  }

  @override
  String tab_reviews(String count) {
    return 'Reviews ($count)';
  }

  @override
  String get kebabbo_staff_review => 'Kebabbo\'s review';

  @override
  String get rating_title => 'Rating';

  @override
  String community_count(String count) {
    return 'Community ($count)';
  }

  @override
  String get ingredient_balance => 'Ingredient balance';

  @override
  String get opening_hours => 'Opening hours';

  @override
  String get no_photos_yet => 'No photos yet';

  @override
  String get no_photos_yet_desc =>
      'Be the first to share a photo of your kebab or dish from this place!';

  @override
  String get upload_first_photo => 'Upload the first photo';

  @override
  String get user_generic => 'User';

  @override
  String get no_reviews_yet_desc =>
      'Share your experience at this place with the whole community!';

  @override
  String get write_first_review => 'Write the first review';

  @override
  String based_on_reviews(String count) {
    return 'Based on $count reviews';
  }

  @override
  String get select_place_to_review =>
      'Select the place you want to review! 🌯';

  @override
  String error_sending_review(String error) {
    return 'Error sending the review: $error';
  }

  @override
  String get choose_place => 'Choose the place';

  @override
  String get change => 'Change';

  @override
  String get search_kebabbo_places => 'Search Kebabbo places';

  @override
  String get search_places_hint => 'e.g. Istanbul, Agra, King...';

  @override
  String get no_place_found_add_it =>
      'No place found. If it\'s new, use \"Add a kebab place\"!';

  @override
  String get your_experience => 'Your experience';

  @override
  String get comment_review_label => 'Comment / review *';

  @override
  String get comment_review_hint =>
      'What did you like most? Any sauce or menu you\'d recommend?';

  @override
  String get comment_review_required =>
      'Write a short comment about your experience';

  @override
  String get add_dish_photo_optional => 'Add a photo of your dish (optional)';

  @override
  String get publish_review => 'Post review';

  @override
  String get tap_map_to_select => 'Tap the map to select the exact spot';

  @override
  String get select_on_map => 'Select on map';

  @override
  String get center_on_my_location => 'Center on my location';

  @override
  String get search_address_or_place => 'Search address or place...';

  @override
  String get selected_point => 'Selected point';

  @override
  String get confirm_this_location => 'Confirm this location';

  @override
  String get map_style_google_road => 'Google Roadmap';

  @override
  String get map_style_google_satellite => 'Google Satellite';

  @override
  String change_map_style(String style) {
    return 'Change map: $style';
  }

  @override
  String get map_style_satellite_short => 'Satellite';

  @override
  String get map_style_road_short => 'Road';

  @override
  String users_count(String count) {
    return 'Users ($count)';
  }

  @override
  String get community_review => 'Community review';

  @override
  String get no_user_reviews_yet => 'No users have reviewed this place yet!';

  @override
  String get directions => 'Directions';

  @override
  String get login_tagline =>
      'Join the community to discover and review the best kebabs';

  @override
  String get no_account_question => 'Don\'t have an account?';

  @override
  String get signup_tagline =>
      'Create your profile and start reviewing the kebabs in your city';

  @override
  String get have_account_question => 'Already have an account?';

  @override
  String password_reset_failed(String error) {
    return 'Failed to reset password: $error';
  }

  @override
  String get objectives_and_medals => 'Goals & medals';

  @override
  String get no_more_kebabs_to_recommend =>
      'There are no other kebabs to recommend.';

  @override
  String get reroll => 'Reroll';

  @override
  String get see_hours_photos_reviews => 'See hours, photos and reviews';

  @override
  String get upload => 'Upload';

  @override
  String get ingredient_amounts_caps => 'INGREDIENT AMOUNTS';

  @override
  String error_deleting_post(String error) {
    return 'Error deleting the post: $error';
  }

  @override
  String get privacy_policy_load_error => 'Error loading the Privacy Policy';

  @override
  String get cooking_title => 'Preparing your kebab';

  @override
  String get cooking_title_reroll => 'Finding an alternative';

  @override
  String get cooking_step_1 => '🔥 Warming up the bread...';

  @override
  String get cooking_step_2 => '🥩 Slicing the meat off the spit...';

  @override
  String get cooking_step_3 => '🥗 Adding fresh veggies and sauces...';

  @override
  String get cooking_step_4 => '🌯 Rolling it up like a pro...';

  @override
  String get cooking_step_5 => '🔍 Finding the best kebab for you...';

  @override
  String get reroll_step_1 => '👨‍🍳 New combination coming up...';

  @override
  String get reroll_step_2 => '🔥 Balancing spices and cooking...';

  @override
  String get reroll_step_3 => '✨ Looking for another great pick...';

  @override
  String get user_not_found_login_again =>
      'User not found. Please log in again.';

  @override
  String no_pack_ready_hours_minutes(String hours, String minutes) {
    return 'No pack ready right now (0/2). The next pack will be ready in ${hours}h ${minutes}m.';
  }

  @override
  String get no_cards_available => 'No cards available.';

  @override
  String an_error_occurred_with(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get opening_in_progress => 'Opening...';

  @override
  String get tap_to_open_pack => 'Tap to open the pack!';

  @override
  String get duplicate_card => 'DUPLICATE CARD';

  @override
  String get new_card_unlocked => 'NEW CARD UNLOCKED!';

  @override
  String already_in_collection(String name) {
    return '$name (already in collection)';
  }

  @override
  String get drag_to_tilt => 'Drag with your finger to tilt in 3D';

  @override
  String open_second_pack(String count) {
    return 'Open 2nd pack ($count)';
  }

  @override
  String get add_to_collection => 'Add to collection';

  @override
  String card_x_of_y(String current, String total) {
    return '#$current of $total';
  }

  @override
  String get card_collection => 'Card collection';

  @override
  String get all_found => 'All found! 🏆';

  @override
  String remaining_count(String count) {
    return '$count remaining';
  }

  @override
  String get tap_to_browse_album => 'Tap to browse the full album ›';

  @override
  String get unpack_new_cards => 'Unpack new cards';

  @override
  String get recharge_info => '1 pack recharges every 12h (max 2)';

  @override
  String no_pack_ready_timer(String time) {
    return 'No pack ready. The next one will be available in $time.';
  }

  @override
  String get first_pack_slot => '1st pack';

  @override
  String get second_pack_slot => '2nd pack';

  @override
  String get ready => 'Ready!';

  @override
  String get queued => 'Queued';

  @override
  String get packs_full => 'Packs fully recharged: 2 / 2 ready! 📦✨';

  @override
  String get open_pack_two_ready => 'Open pack (2 ready!)';

  @override
  String get no_pack_ready => 'No pack ready';

  @override
  String get tcg_album => 'TCG card album';

  @override
  String get cards_unlocked => 'cards unlocked';

  @override
  String missing_count(String count) {
    return '$count missing';
  }

  @override
  String get packs_ready_2 => '2 / 2 packs ready to open';

  @override
  String get packs_ready_1 => '1 / 2 pack ready to open';

  @override
  String get packs_ready_0 => '0 / 2 packs available';

  @override
  String get max_charge_reached => 'Maximum charge reached (1 every 12h)';

  @override
  String next_recharge_in(String time) {
    return 'Next recharge in $time';
  }

  @override
  String recharging_next_in(String time) {
    return 'Recharging: next one in $time';
  }

  @override
  String get unpack_and_view_collection => 'Unpack & view collection';

  @override
  String get medal_0_title => 'First Bite';

  @override
  String get medal_1_title => 'Serial Taster';

  @override
  String get medal_2_title => 'Kebab Critic';

  @override
  String get medal_3_title => 'Master of the Spit';

  @override
  String get medal_4_title => 'Food Legend';

  @override
  String get medal_5_title => 'Voice of the Feed';

  @override
  String get medal_6_title => 'Taste Reporter';

  @override
  String get medal_7_title => 'Kebab Influencer';

  @override
  String get medal_8_title => 'Community Pillar';

  @override
  String get medal_0_desc =>
      'You wrote your first review of a kebab place. Welcome to the family of Kebabbo critics!';

  @override
  String get medal_1_desc =>
      'You\'ve reviewed 5 different places. Your palate is starting to recognise the true art of the spit!';

  @override
  String get medal_2_desc =>
      '10 reviews done! Your ratings guide kebab places and the whole community.';

  @override
  String get medal_3_desc =>
      '20 reviews written! No wrap, sauce or flatbread holds any secrets from you. A true master!';

  @override
  String get medal_4_desc =>
      '30 reviews under your belt! You\'ve reached the top of the Kebabbo food experience. A living legend!';

  @override
  String get medal_5_desc =>
      'You published your first post in the social feed. Your passion for kebab is now public!';

  @override
  String get medal_6_desc =>
      'You\'ve shared 5 posts with photos and thoughts in the feed. The community loves your updates!';

  @override
  String get medal_7_desc =>
      '10 posts shared! Your shots and place tags make the whole city hungry.';

  @override
  String get medal_8_desc =>
      '50 posts in the community! You\'re an irreplaceable pillar of the Kebabbo feed!';

  @override
  String get rank_5_name => 'Supreme Legend';

  @override
  String get rank_5_desc =>
      'You\'ve achieved every milestone! You\'re in Kebabbo\'s Olympus.';

  @override
  String get rank_4_name => 'Kebabbo Veteran';

  @override
  String get rank_4_desc =>
      'Just a few milestones left to complete everything!';

  @override
  String get rank_3_name => 'Sauce Master';

  @override
  String get rank_3_desc => 'A recognised expert in both taste and community.';

  @override
  String get rank_2_name => 'Döner Gourmet';

  @override
  String get rank_2_desc =>
      'You have a great palate and an active voice in the feed.';

  @override
  String get rank_1_name => 'Spit Enthusiast';

  @override
  String get rank_1_desc =>
      'The first milestones are yours! Keep reviewing and posting.';

  @override
  String get rank_0_name => 'Kebab Novice';

  @override
  String get rank_0_desc =>
      'Write your first review or create a post to start your collection!';

  @override
  String get unit_reviews => 'reviews';

  @override
  String get unit_posts => 'posts';

  @override
  String get goal_reached => 'Milestone reached 🎉';

  @override
  String get in_progress => 'In progress ⏳';

  @override
  String get progress_label => 'Progress';

  @override
  String medal_missing(String missing, String unit) {
    return 'Only $missing $unit left to unlock this medal!';
  }

  @override
  String get medals_page_title => 'Medals & milestones';

  @override
  String filter_all_count(String count) {
    return 'All ($count)';
  }

  @override
  String filter_reviews_count(String count) {
    return 'Reviews ($count)';
  }

  @override
  String filter_unlocked_count(String count) {
    return 'Unlocked ($count)';
  }

  @override
  String get no_medals_in_filter => 'No medals in this filter';

  @override
  String unlocked_of_total(String unlocked, String total) {
    return '$unlocked of $total unlocked';
  }

  @override
  String percent_completed(String percent) {
    return '$percent% complete';
  }

  @override
  String get reviews_label => 'Reviews';

  @override
  String get feed_posts_label => 'Feed posts';

  @override
  String get unlocked_badge => 'Unlocked';

  @override
  String get completed_badge => 'Completed! ⭐';

  @override
  String get open_in_app => 'Open the app';

  @override
  String get compare_kebabs => 'Compare Kebabs';

  @override
  String get select_first_kebab => 'Select 1st kebab';

  @override
  String get select_second_kebab => 'Select 2nd kebab';

  @override
  String get search_kebab_to_compare => 'Search a kebab to compare...';

  @override
  String get pillars_comparison => 'Pillars Comparison';

  @override
  String get ingredients_comparison => 'Ingredients Comparison';

  @override
  String get select_two_kebabs_to_compare =>
      'Select two kebabs to view the detailed comparison.';

  @override
  String get review_already_exists_title => 'Review already exists';

  @override
  String get review_already_exists_message =>
      'A review already exists for this place, do you want to overwrite it?';

  @override
  String get sovrascrivi => 'Overwrite';

  @override
  String get open_or_get_app => 'Open or get the app';
}
