// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Add a photo to ${name}";

  static String m1(name) => "${name} (already in collection)";

  static String m2(error) => "An error occurred: ${error}";

  static String m3(count) => "Based on ${count} reviews";

  static String m4(current, total) => "#${current} of ${total}";

  static String m5(style) => "Change map: ${style}";

  static String m6(city) => "City: ${city}";

  static String m7(count) => "Community (${count})";

  static String m8(results) => "10 km (${results} results)";

  static String m9(results) => "1 km (${results} results)";

  static String m10(results) => "200 meters (${results} results)";

  static String m11(results) => "500 meters (${results} results)";

  static String m12(results) => "Unlimited (${results} results)";

  static String m13(error) => "Error deleting the post: ${error}";

  static String m14(error) => "Error while saving: ${error}";

  static String m15(error) => "Error sending the review: ${error}";

  static String m16(count) => "All (${count})";

  static String m17(count) => "Reviews (${count})";

  static String m18(count) => "Unlocked (${count})";

  static String m19(missing, unit) =>
      "Only ${missing} ${unit} left to unlock this medal!";

  static String m20(count) => "${count} missing";

  static String m21(time) => "Next recharge in ${time}";

  static String m22(hours, minutes) =>
      "No pack ready right now (0/2). The next pack will be ready in ${hours}h ${minutes}m.";

  static String m23(time) =>
      "No pack ready. The next one will be available in ${time}.";

  static String m24(count) => "Open 2nd pack (${count})";

  static String m25(error) => "Failed to reset password: ${error}";

  static String m26(percent) => "${percent}% complete";

  static String m27(time) => "Recharging: next one in ${time}";

  static String m28(count) => "${count} remaining";

  static String m29(
    kebabName,
    qualityRating,
    quantityRating,
    menuRating,
    priceRating,
    funRating,
    description,
  ) =>
      "I just reviewed the kebab at ${kebabName}!\n\nQuality: ${qualityRating}\nQuantity: ${quantityRating}\nMenu: ${menuRating}\nPrice: ${priceRating}\nFun: ${funRating}\n\n${description}";

  static String m30(count) => "Photos (${count})";

  static String m31(count) => "Reviews (${count})";

  static String m32(unlocked, total) => "${unlocked} of ${total} unlocked";

  static String m33(error) => "Upload error: ${error}";

  static String m34(count) => "Users (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accedi_per_cercare": MessageLookupByLibrary.simpleMessage(
      "Log in to post and see peoples\' info",
    ),
    "add_dish_photo_optional": MessageLookupByLibrary.simpleMessage(
      "Add a photo of your dish (optional)",
    ),
    "add_kebab": MessageLookupByLibrary.simpleMessage("Add a Kebab"),
    "add_kebab_place": MessageLookupByLibrary.simpleMessage(
      "Add a kebab place",
    ),
    "add_kebab_place_subtitle": MessageLookupByLibrary.simpleMessage(
      "Put a new place on the map",
    ),
    "add_kebab_to_kebabbo": MessageLookupByLibrary.simpleMessage(
      "Add place to Kebabbo",
    ),
    "add_new_kebab_confirmation": MessageLookupByLibrary.simpleMessage(
      "You are about to add \"\$name\" as a new kebab. Are you sure it doesn\'t already exist?",
    ),
    "add_photo_to": m0,
    "add_review_appbar_title": MessageLookupByLibrary.simpleMessage(
      "Add Review",
    ),
    "add_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Tried a new kebab?",
    ),
    "add_review_title": MessageLookupByLibrary.simpleMessage("Add Review"),
    "add_to_collection": MessageLookupByLibrary.simpleMessage(
      "Add to collection",
    ),
    "added_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Added to favorites ❤️",
    ),
    "advanced_filters": MessageLookupByLibrary.simpleMessage(
      "Advanced Filters",
    ),
    "all_filter": MessageLookupByLibrary.simpleMessage("All"),
    "all_found": MessageLookupByLibrary.simpleMessage("All found! 🏆"),
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Sign in",
    ),
    "already_in_collection": m1,
    "an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "An error occurred",
    ),
    "an_error_occurred_with": m2,
    "annulla": MessageLookupByLibrary.simpleMessage("Cancel"),
    "anonimo": MessageLookupByLibrary.simpleMessage("Anonymous"),
    "aperti_ora": MessageLookupByLibrary.simpleMessage("Open now"),
    "aperto": MessageLookupByLibrary.simpleMessage("Open"),
    "app_is_installed": MessageLookupByLibrary.simpleMessage(
      "Kebabbo is also an app!",
    ),
    "app_is_installed_description": MessageLookupByLibrary.simpleMessage(
      "Open it in the app for a better experience. If you don\'t have it yet, we\'ll take you to Google Play.",
    ),
    "autenticazione_necessaria": MessageLookupByLibrary.simpleMessage(
      "You must be logged in to comment.",
    ),
    "back_to_build": MessageLookupByLibrary.simpleMessage("Back to Build"),
    "based_on_reviews": m3,
    "build_button": MessageLookupByLibrary.simpleMessage("Build!"),
    "build_your_kebab": MessageLookupByLibrary.simpleMessage(
      "Build Your Kebab",
    ),
    "by_signing_in_you_agree_to_our_terms_and_privacy_policy":
        MessageLookupByLibrary.simpleMessage(
          "By signing in, you agree to our terms and privacy policy.",
        ),
    "cambia_profilepic": MessageLookupByLibrary.simpleMessage(
      "Change profile picture",
    ),
    "cambia_profilo": MessageLookupByLibrary.simpleMessage("Change profile"),
    "cambia_username": MessageLookupByLibrary.simpleMessage("Change Username"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "card_collection": MessageLookupByLibrary.simpleMessage("Card collection"),
    "card_x_of_y": m4,
    "cards_unlocked": MessageLookupByLibrary.simpleMessage("cards unlocked"),
    "center_on_my_location": MessageLookupByLibrary.simpleMessage(
      "Center on my location",
    ),
    "cerca_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Search for a kebab place...",
    ),
    "cerca_utenti": MessageLookupByLibrary.simpleMessage("Search users..."),
    "change": MessageLookupByLibrary.simpleMessage("Change"),
    "change_map_style": m5,
    "check_your_email_for_a_login_link": MessageLookupByLibrary.simpleMessage(
      "Check your email for a login link!",
    ),
    "check_your_email_for_a_reset_link": MessageLookupByLibrary.simpleMessage(
      "Check your email for a reset link",
    ),
    "check_your_email_for_a_verification_link":
        MessageLookupByLibrary.simpleMessage(
          "Check your email for a verification link",
        ),
    "chiuso": MessageLookupByLibrary.simpleMessage("Closed"),
    "choose_on_map_recommended": MessageLookupByLibrary.simpleMessage(
      "Choose on map (recommended)",
    ),
    "choose_place": MessageLookupByLibrary.simpleMessage("Choose the place"),
    "cipolla": MessageLookupByLibrary.simpleMessage("Onion"),
    "city": MessageLookupByLibrary.simpleMessage("City"),
    "city_label": m6,
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "collection_subtitle": MessageLookupByLibrary.simpleMessage(
      "check your kebabbo cards",
    ),
    "collection_title": MessageLookupByLibrary.simpleMessage("Collection"),
    "comment_review_hint": MessageLookupByLibrary.simpleMessage(
      "What did you like most? Any sauce or menu you\'d recommend?",
    ),
    "comment_review_label": MessageLookupByLibrary.simpleMessage(
      "Comment / review *",
    ),
    "comment_review_required": MessageLookupByLibrary.simpleMessage(
      "Write a short comment about your experience",
    ),
    "commento_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Comment not available",
    ),
    "commento_vuoto": MessageLookupByLibrary.simpleMessage(
      "The comment text cannot be empty.",
    ),
    "community_count": m7,
    "community_review": MessageLookupByLibrary.simpleMessage(
      "Community review",
    ),
    "community_upload": MessageLookupByLibrary.simpleMessage("Community"),
    "compare_kebabs": MessageLookupByLibrary.simpleMessage("Compare Kebabs"),
    "completed_badge": MessageLookupByLibrary.simpleMessage("Completed! ⭐"),
    "conferma_eliminazione": MessageLookupByLibrary.simpleMessage(
      "Confirm deletion",
    ),
    "confirm_this_location": MessageLookupByLibrary.simpleMessage(
      "Confirm this location",
    ),
    "congratulazioni": MessageLookupByLibrary.simpleMessage("Congratulations!"),
    "consigliaci_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Recommend a kebab place",
    ),
    "contribute_subtitle": MessageLookupByLibrary.simpleMessage(
      "Help us map and review the best kebab places!",
    ),
    "contribute_title": MessageLookupByLibrary.simpleMessage(
      "Contribute to Kebabbo",
    ),
    "cooking_step_1": MessageLookupByLibrary.simpleMessage(
      "🔥 Warming up the bread...",
    ),
    "cooking_step_2": MessageLookupByLibrary.simpleMessage(
      "🥩 Slicing the meat off the spit...",
    ),
    "cooking_step_3": MessageLookupByLibrary.simpleMessage(
      "🥗 Adding fresh veggies and sauces...",
    ),
    "cooking_step_4": MessageLookupByLibrary.simpleMessage(
      "🌯 Rolling it up like a pro...",
    ),
    "cooking_step_5": MessageLookupByLibrary.simpleMessage(
      "🔍 Finding the best kebab for you...",
    ),
    "cooking_title": MessageLookupByLibrary.simpleMessage(
      "Preparing your kebab",
    ),
    "cooking_title_reroll": MessageLookupByLibrary.simpleMessage(
      "Finding an alternative",
    ),
    "could_not_open_link": MessageLookupByLibrary.simpleMessage(
      "Could not open the link.",
    ),
    "create_kebab_subtitle": MessageLookupByLibrary.simpleMessage(
      "build your own kebab",
    ),
    "create_kebab_title": MessageLookupByLibrary.simpleMessage("Create Kebab"),
    "custom_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Set the hours for each day (e.g. 11:00-23:00, or \"closed\"):",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "description_is_required": MessageLookupByLibrary.simpleMessage(
      "Description is required",
    ),
    "description_review_hint": MessageLookupByLibrary.simpleMessage(
      "Tell us about this kebab: bread, meat, flavours...",
    ),
    "description_review_label": MessageLookupByLibrary.simpleMessage(
      "Description / review *",
    ),
    "description_review_required": MessageLookupByLibrary.simpleMessage(
      "Write a short comment to introduce the place",
    ),
    "descrizione_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Description not available",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "devi_essere_autenticato_per_commentare":
        MessageLookupByLibrary.simpleMessage("You must login to comment"),
    "devi_essere_autenticato_per_mettere_mi_piace":
        MessageLookupByLibrary.simpleMessage("You must login to like"),
    "devi_essere_autenticato_per_postare": MessageLookupByLibrary.simpleMessage(
      "You must be authenticated to post",
    ),
    "devi_essere_autenticato_per_visualizzare_il_profilo":
        MessageLookupByLibrary.simpleMessage(
          "You must login to view the profile",
        ),
    "dimension": MessageLookupByLibrary.simpleMessage("Size"),
    "directions": MessageLookupByLibrary.simpleMessage("Directions"),
    "distanceLabel10km": m8,
    "distanceLabel1km": m9,
    "distanceLabel200m": m10,
    "distanceLabel500m": m11,
    "distanceLabelUnlimited": m12,
    "distanza_massima": MessageLookupByLibrary.simpleMessage(
      "Maximum Distance",
    ),
    "distanza_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Distance not available",
    ),
    "dont_have_an_account_sign_up": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Sign Up",
    ),
    "drag_to_tilt": MessageLookupByLibrary.simpleMessage(
      "Drag with your finger to tilt in 3D",
    ),
    "duplicate_card": MessageLookupByLibrary.simpleMessage("DUPLICATE CARD"),
    "edit_location_on_map": MessageLookupByLibrary.simpleMessage(
      "Edit location on the map",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Edit profile"),
    "elimina": MessageLookupByLibrary.simpleMessage("Delete"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_required": MessageLookupByLibrary.simpleMessage("Email is required"),
    "enter_place_name": MessageLookupByLibrary.simpleMessage(
      "Enter the name of the place",
    ),
    "error_adding_review": MessageLookupByLibrary.simpleMessage(
      "Error adding review: ",
    ),
    "error_deleting_post": m13,
    "error_loading_kebabs": MessageLookupByLibrary.simpleMessage(
      "Error loading kebabs: ",
    ),
    "error_processing_image": MessageLookupByLibrary.simpleMessage(
      "Error processing image:",
    ),
    "error_saving": m14,
    "error_sending_review": m15,
    "errore": MessageLookupByLibrary.simpleMessage("Error:"),
    "errore_nel_caricamento_dei_follower": MessageLookupByLibrary.simpleMessage(
      "Error loading followers",
    ),
    "errore_nel_caricamento_dellimage": MessageLookupByLibrary.simpleMessage(
      "Error loading image:",
    ),
    "esplora": MessageLookupByLibrary.simpleMessage("Explore"),
    "examine_3d": MessageLookupByLibrary.simpleMessage("Examine in 3D"),
    "extract": MessageLookupByLibrary.simpleMessage("Extract"),
    "failed_to_load_favorites": MessageLookupByLibrary.simpleMessage(
      "Failed to load favorites",
    ),
    "failed_to_load_follower_count": MessageLookupByLibrary.simpleMessage(
      "Failed to load follower count",
    ),
    "failed_to_load_medals": MessageLookupByLibrary.simpleMessage(
      "Failed to load medals",
    ),
    "failed_to_load_post_count": MessageLookupByLibrary.simpleMessage(
      "Failed to load post count",
    ),
    "failed_to_load_posts": MessageLookupByLibrary.simpleMessage(
      "Failed to load posts",
    ),
    "failed_to_load_profile": MessageLookupByLibrary.simpleMessage(
      "Failed to load profile",
    ),
    "failed_to_load_reviews_count": MessageLookupByLibrary.simpleMessage(
      "Failed to load reviews count",
    ),
    "failed_to_update_follow_status": MessageLookupByLibrary.simpleMessage(
      "Failed to update follow status",
    ),
    "failed_to_upload_avatar": MessageLookupByLibrary.simpleMessage(
      "Failed to upload avatar",
    ),
    "feed_posts_label": MessageLookupByLibrary.simpleMessage("Feed posts"),
    "fifty_posts": MessageLookupByLibrary.simpleMessage("50 posts"),
    "filter_all_count": m16,
    "filter_by_distance": MessageLookupByLibrary.simpleMessage(
      "Filter by distance",
    ),
    "filter_reviews_count": m17,
    "filter_unlocked_count": m18,
    "first_pack_slot": MessageLookupByLibrary.simpleMessage("1st pack"),
    "first_time_description": MessageLookupByLibrary.simpleMessage(
      "Welcome to Kebabbo!\nWhat can you do on here?\nWell, you can explore our professional kebab reviews or check out other users\' ratings.\nWrite your own review by scanning the Kebabbo sticker at the kebab place.\nCheck out other users\' profiles, posts and connect with fellows kebab enjoyers and earn achievements for using the app.\n Use our search and filter features or our powerful build tool to find your ideal kebab or explore our interactive map to discover nearby gems.\nHave fun and kebab away!",
    ),
    "first_time_title": MessageLookupByLibrary.simpleMessage(
      "Welcome to Kebabbo!",
    ),
    "five_posts": MessageLookupByLibrary.simpleMessage("5 posts"),
    "five_reviews": MessageLookupByLibrary.simpleMessage("5 reviews"),
    "followed_filter": MessageLookupByLibrary.simpleMessage("Following"),
    "followers": MessageLookupByLibrary.simpleMessage("Followers"),
    "following": MessageLookupByLibrary.simpleMessage("Following"),
    "forgot_password": MessageLookupByLibrary.simpleMessage("Forgot password"),
    "found_all_cards": MessageLookupByLibrary.simpleMessage("All cards found."),
    "fun": MessageLookupByLibrary.simpleMessage("Fun"),
    "fun_exclamation": MessageLookupByLibrary.simpleMessage("fun!"),
    "games_tools_title": MessageLookupByLibrary.simpleMessage("Games & Tools"),
    "generic_error": MessageLookupByLibrary.simpleMessage("Error: "),
    "gluten_free": MessageLookupByLibrary.simpleMessage("Gluten Free"),
    "gluten_free_option": MessageLookupByLibrary.simpleMessage(
      "Gluten-free option",
    ),
    "gluten_free_option_desc": MessageLookupByLibrary.simpleMessage(
      "Offers certified gluten-free bread or options",
    ),
    "go_back": MessageLookupByLibrary.simpleMessage("Go Back"),
    "goal_reached": MessageLookupByLibrary.simpleMessage(
      "Milestone reached 🎉",
    ),
    "google_maps_link": MessageLookupByLibrary.simpleMessage(
      "Google Maps link",
    ),
    "hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia":
        MessageLookupByLibrary.simpleMessage(
          "You have reached a new milestone and obtained a new medal!",
        ),
    "hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo":
        MessageLookupByLibrary.simpleMessage(
          "You received a new medal for your contribution!",
        ),
    "have_account_question": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "hours_none_note": MessageLookupByLibrary.simpleMessage(
      "No opening hours will be saved.",
    ),
    "hours_preset_continuous": MessageLookupByLibrary.simpleMessage(
      "All day (11-23) 🌯",
    ),
    "hours_preset_custom": MessageLookupByLibrary.simpleMessage("Custom ⚙️"),
    "hours_preset_lunch_dinner": MessageLookupByLibrary.simpleMessage(
      "Lunch and dinner 🍽️",
    ),
    "hours_preset_night": MessageLookupByLibrary.simpleMessage(
      "Late night (11-02) 🌙",
    ),
    "hours_preset_none": MessageLookupByLibrary.simpleMessage(
      "Not specified (default)",
    ),
    "i_tuoi_post": MessageLookupByLibrary.simpleMessage("Your Posts"),
    "il_commento_e_stato_aggiunto_con_successo":
        MessageLookupByLibrary.simpleMessage(
          "The comment was added successfully!",
        ),
    "il_kebab_che_ti_raccomandiamo_e": MessageLookupByLibrary.simpleMessage(
      "The kebab we recommend is:",
    ),
    "il_testo_non_puo_essere_vuoto": MessageLookupByLibrary.simpleMessage(
      "Text cannot be empty",
    ),
    "in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google":
        MessageLookupByLibrary.simpleMessage(
          "In Italy, the world of Kebab is still a dark world. The best places are underrated, and the worst ones get high reviews on Google.",
        ),
    "in_progress": MessageLookupByLibrary.simpleMessage("In progress ⏳"),
    "ingredient_amounts_caps": MessageLookupByLibrary.simpleMessage(
      "INGREDIENT AMOUNTS",
    ),
    "ingredient_balance": MessageLookupByLibrary.simpleMessage(
      "Ingredient balance",
    ),
    "ingredient_balance_1_10": MessageLookupByLibrary.simpleMessage(
      "Ingredient balance (1 to 10)",
    ),
    "ingredients_comparison": MessageLookupByLibrary.simpleMessage(
      "Ingredients Comparison",
    ),
    "inserted_by": MessageLookupByLibrary.simpleMessage("Added by"),
    "invia": MessageLookupByLibrary.simpleMessage("Send"),
    "it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again":
        MessageLookupByLibrary.simpleMessage(
          "It looks like the review you are trying to access does not exist. Please check the link and try again.",
        ),
    "kebab_already_exists": MessageLookupByLibrary.simpleMessage(
      "Kebab already exists",
    ),
    "kebab_consigliato": MessageLookupByLibrary.simpleMessage(
      "Recommended Kebab",
    ),
    "kebab_no_longer_available": MessageLookupByLibrary.simpleMessage(
      "Kebab no longer available",
    ),
    "kebab_not_found": MessageLookupByLibrary.simpleMessage("Kebab not found"),
    "kebab_place_name_hint": MessageLookupByLibrary.simpleMessage(
      "e.g. Bella Istanbul 3",
    ),
    "kebab_place_name_label": MessageLookupByLibrary.simpleMessage(
      "Name of the place *",
    ),
    "kebab_place_not_found": MessageLookupByLibrary.simpleMessage(
      "Place not found or removed.",
    ),
    "kebab_sconosciuto": MessageLookupByLibrary.simpleMessage("Unknown Kebab"),
    "kebab_tag": MessageLookupByLibrary.simpleMessage("Kebab"),
    "kebabbo_review": MessageLookupByLibrary.simpleMessage("Kebabbo Review"),
    "kebabbo_staff_review": MessageLookupByLibrary.simpleMessage(
      "Kebabbo\'s review",
    ),
    "kebabbo_user": MessageLookupByLibrary.simpleMessage("Kebabbo user"),
    "km_distante_da_te": MessageLookupByLibrary.simpleMessage(
      "km away from you",
    ),
    "la_tua_soluzione_per_il_pranzo_universitario":
        MessageLookupByLibrary.simpleMessage(
          "Your solution for university lunch",
        ),
    "legends": MessageLookupByLibrary.simpleMessage("Legends"),
    "location_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Location permission denied.",
    ),
    "location_permission_denied_forever": MessageLookupByLibrary.simpleMessage(
      "Location permission permanently denied. You can enable it in the settings.",
    ),
    "location_selected": MessageLookupByLibrary.simpleMessage(
      "Location selected",
    ),
    "location_services_disabled": MessageLookupByLibrary.simpleMessage(
      "Location services are disabled.",
    ),
    "log_in_con_google": MessageLookupByLibrary.simpleMessage(
      "Log In with Google",
    ),
    "logged_in": MessageLookupByLibrary.simpleMessage("Logged in"),
    "login": MessageLookupByLibrary.simpleMessage("Log In"),
    "login_required_section": MessageLookupByLibrary.simpleMessage(
      "You must log in to use this section.",
    ),
    "login_tagline": MessageLookupByLibrary.simpleMessage(
      "Join the community to discover and review the best kebabs",
    ),
    "login_to_post_photos": MessageLookupByLibrary.simpleMessage(
      "Log in to post photos",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "map_not_available": MessageLookupByLibrary.simpleMessage(
      "Map not available for this place",
    ),
    "map_style_google_road": MessageLookupByLibrary.simpleMessage(
      "Google Roadmap",
    ),
    "map_style_google_satellite": MessageLookupByLibrary.simpleMessage(
      "Google Satellite",
    ),
    "map_style_road_short": MessageLookupByLibrary.simpleMessage("Road"),
    "map_style_satellite_short": MessageLookupByLibrary.simpleMessage(
      "Satellite",
    ),
    "mappa": MessageLookupByLibrary.simpleMessage("Map"),
    "maps_link_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordinates detected from the Maps link! 📍",
    ),
    "maps_link_failed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t extract the coordinates from the link. Use \"Choose on map\".",
    ),
    "maps_link_name_and_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordinates and name detected from the Maps link! 📍",
    ),
    "max_charge_reached": MessageLookupByLibrary.simpleMessage(
      "Maximum charge reached (1 every 12h)",
    ),
    "meat": MessageLookupByLibrary.simpleMessage("Meat"),
    "medal_0_desc": MessageLookupByLibrary.simpleMessage(
      "You wrote your first review of a kebab place. Welcome to the family of Kebabbo critics!",
    ),
    "medal_0_title": MessageLookupByLibrary.simpleMessage("First Bite"),
    "medal_1_desc": MessageLookupByLibrary.simpleMessage(
      "You\'ve reviewed 5 different places. Your palate is starting to recognise the true art of the spit!",
    ),
    "medal_1_title": MessageLookupByLibrary.simpleMessage("Serial Taster"),
    "medal_2_desc": MessageLookupByLibrary.simpleMessage(
      "10 reviews done! Your ratings guide kebab places and the whole community.",
    ),
    "medal_2_title": MessageLookupByLibrary.simpleMessage("Kebab Critic"),
    "medal_3_desc": MessageLookupByLibrary.simpleMessage(
      "20 reviews written! No wrap, sauce or flatbread holds any secrets from you. A true master!",
    ),
    "medal_3_title": MessageLookupByLibrary.simpleMessage("Master of the Spit"),
    "medal_4_desc": MessageLookupByLibrary.simpleMessage(
      "30 reviews under your belt! You\'ve reached the top of the Kebabbo food experience. A living legend!",
    ),
    "medal_4_title": MessageLookupByLibrary.simpleMessage("Food Legend"),
    "medal_5_desc": MessageLookupByLibrary.simpleMessage(
      "You published your first post in the social feed. Your passion for kebab is now public!",
    ),
    "medal_5_title": MessageLookupByLibrary.simpleMessage("Voice of the Feed"),
    "medal_6_desc": MessageLookupByLibrary.simpleMessage(
      "You\'ve shared 5 posts with photos and thoughts in the feed. The community loves your updates!",
    ),
    "medal_6_title": MessageLookupByLibrary.simpleMessage("Taste Reporter"),
    "medal_7_desc": MessageLookupByLibrary.simpleMessage(
      "10 posts shared! Your shots and place tags make the whole city hungry.",
    ),
    "medal_7_title": MessageLookupByLibrary.simpleMessage("Kebab Influencer"),
    "medal_8_desc": MessageLookupByLibrary.simpleMessage(
      "50 posts in the community! You\'re an irreplaceable pillar of the Kebabbo feed!",
    ),
    "medal_8_title": MessageLookupByLibrary.simpleMessage("Community Pillar"),
    "medal_missing": m19,
    "medals_page_title": MessageLookupByLibrary.simpleMessage(
      "Medals & milestones",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "missing_count": m20,
    "more_info": MessageLookupByLibrary.simpleMessage("How to review a kebab"),
    "my_cards": MessageLookupByLibrary.simpleMessage("Kebab TCG Carousel"),
    "name_autofilled_helper": MessageLookupByLibrary.simpleMessage(
      "Filled in automatically from the map (feel free to edit it)",
    ),
    "name_label": MessageLookupByLibrary.simpleMessage("Name"),
    "nav_account": MessageLookupByLibrary.simpleMessage("Account"),
    "nav_add": MessageLookupByLibrary.simpleMessage("Add"),
    "nav_feed": MessageLookupByLibrary.simpleMessage("Feed"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Home"),
    "nessun_commento_disponibile": MessageLookupByLibrary.simpleMessage(
      "No comments available",
    ),
    "nessun_kebab_corrispondente_trovato_nel_raggio_selezionato":
        MessageLookupByLibrary.simpleMessage(
          "No matching kebab found within the selected radius",
        ),
    "nessun_kebab_tra_i_preferiti": MessageLookupByLibrary.simpleMessage(
      "No kebabs in favorites",
    ),
    "nessun_kebab_vicino_a_te": MessageLookupByLibrary.simpleMessage(
      "No kebab near you \nYou must be near the kebab shop to review it for authenticity reasons.\nCheck your location and reload the page.",
    ),
    "nessun_kebabbaro_presente": MessageLookupByLibrary.simpleMessage(
      "No Kebab places present :(",
    ),
    "nessun_post_trovato": MessageLookupByLibrary.simpleMessage(
      "No posts found",
    ),
    "nessun_utente_seguito": MessageLookupByLibrary.simpleMessage(
      "No users followed",
    ),
    "nessun_utente_ti_segue": MessageLookupByLibrary.simpleMessage(
      "No users follow you",
    ),
    "nessuna_recensione_ancora": MessageLookupByLibrary.simpleMessage(
      "No reviews yet",
    ),
    "nessuna_recensione_disponibile": MessageLookupByLibrary.simpleMessage(
      "No reviews available",
    ),
    "new_card_unlocked": MessageLookupByLibrary.simpleMessage(
      "NEW CARD UNLOCKED!",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("New Password"),
    "next_recharge_in": m21,
    "no_account_question": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "no_cards_available": MessageLookupByLibrary.simpleMessage(
      "No cards available.",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "You don\'t have any cards yet",
    ),
    "no_image": MessageLookupByLibrary.simpleMessage("No Image"),
    "no_medals_in_filter": MessageLookupByLibrary.simpleMessage(
      "No medals in this filter",
    ),
    "no_more_kebabs_to_recommend": MessageLookupByLibrary.simpleMessage(
      "There are no other kebabs to recommend.",
    ),
    "no_pack_ready": MessageLookupByLibrary.simpleMessage("No pack ready"),
    "no_pack_ready_hours_minutes": m22,
    "no_pack_ready_timer": m23,
    "no_photos_yet": MessageLookupByLibrary.simpleMessage("No photos yet"),
    "no_photos_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Be the first to share a photo of your kebab or dish from this place!",
    ),
    "no_place_found_add_it": MessageLookupByLibrary.simpleMessage(
      "No place found. If it\'s new, use \"Add a kebab place\"!",
    ),
    "no_reviews_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Share your experience at this place with the whole community!",
    ),
    "no_suggestions_available": MessageLookupByLibrary.simpleMessage(
      "No suggestions available",
    ),
    "no_thanks": MessageLookupByLibrary.simpleMessage("No, thanks"),
    "no_user_reviews_yet": MessageLookupByLibrary.simpleMessage(
      "No users have reviewed this place yet!",
    ),
    "nome_del_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Name of the kebab place",
    ),
    "nome_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Name not available",
    ),
    "non_segui_ancora_nessuno": MessageLookupByLibrary.simpleMessage(
      "You are not following anyone yet",
    ),
    "nuova_medaglia": MessageLookupByLibrary.simpleMessage("New Medal!"),
    "nuovo_username": MessageLookupByLibrary.simpleMessage("New username..."),
    "objectives": MessageLookupByLibrary.simpleMessage("Objectives"),
    "objectives_and_medals": MessageLookupByLibrary.simpleMessage(
      "Goals & medals",
    ),
    "one_post": MessageLookupByLibrary.simpleMessage("1 post"),
    "one_review": MessageLookupByLibrary.simpleMessage("1 review"),
    "onion": MessageLookupByLibrary.simpleMessage("Onion"),
    "oops_review_not_found": MessageLookupByLibrary.simpleMessage(
      "Oops! Review Not Found",
    ),
    "open_in_app": MessageLookupByLibrary.simpleMessage("Open the app"),
    "open_now": MessageLookupByLibrary.simpleMessage("Open Now"),
    "open_or_get_app": MessageLookupByLibrary.simpleMessage(
      "Open or get the app",
    ),
    "open_pack": MessageLookupByLibrary.simpleMessage("Open Pack"),
    "open_pack_two_ready": MessageLookupByLibrary.simpleMessage(
      "Open pack (2 ready!)",
    ),
    "open_second_pack": m24,
    "opening_hours": MessageLookupByLibrary.simpleMessage("Opening hours"),
    "opening_hours_hint": MessageLookupByLibrary.simpleMessage(
      "You can leave them unspecified, pick a template or set custom hours:",
    ),
    "opening_in_progress": MessageLookupByLibrary.simpleMessage("Opening..."),
    "or_continue_with_email": MessageLookupByLibrary.simpleMessage(
      "or with email",
    ),
    "order_by": MessageLookupByLibrary.simpleMessage("Order by"),
    "overall_rating_1_5": MessageLookupByLibrary.simpleMessage(
      "Overall rating (1 to 5)",
    ),
    "pack": MessageLookupByLibrary.simpleMessage("Kebabbo Pack"),
    "pack_button_subtitle": MessageLookupByLibrary.simpleMessage(
      "open your favorite kebab pack",
    ),
    "pack_button_title": MessageLookupByLibrary.simpleMessage("Pack"),
    "pack_too_soon": MessageLookupByLibrary.simpleMessage(
      "This pack is not available yet",
    ),
    "packs_full": MessageLookupByLibrary.simpleMessage(
      "Packs fully recharged: 2 / 2 ready! 📦✨",
    ),
    "packs_ready_0": MessageLookupByLibrary.simpleMessage(
      "0 / 2 packs available",
    ),
    "packs_ready_1": MessageLookupByLibrary.simpleMessage(
      "1 / 2 pack ready to open",
    ),
    "packs_ready_2": MessageLookupByLibrary.simpleMessage(
      "2 / 2 packs ready to open",
    ),
    "page_not_found": MessageLookupByLibrary.simpleMessage("Page not found"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_minimum_length": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "password_must_be_at_least_6_characters":
        MessageLookupByLibrary.simpleMessage(
          "Password must be at least 6 characters",
        ),
    "password_reset_failed": m25,
    "password_reset_success": MessageLookupByLibrary.simpleMessage(
      "Password reset successful",
    ),
    "paste_maps_link_prompt": MessageLookupByLibrary.simpleMessage(
      "Already have a Google Maps link? Paste it here",
    ),
    "per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab":
        MessageLookupByLibrary.simpleMessage(
          "That\'s why we are here: university students, like you, with years of experience as Kebab eaters.",
        ),
    "percent_completed": m26,
    "photo": MessageLookupByLibrary.simpleMessage("Photo"),
    "photo_added": MessageLookupByLibrary.simpleMessage("Photo added! 📸"),
    "photo_caption_hint": MessageLookupByLibrary.simpleMessage(
      "Write a comment or describe your kebab...",
    ),
    "pillars_comparison": MessageLookupByLibrary.simpleMessage(
      "Pillars Comparison",
    ),
    "please_enter_a_password": MessageLookupByLibrary.simpleMessage(
      "Please enter a password",
    ),
    "please_enter_a_valid_email": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "please_enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "please_fill_in_all_fields": MessageLookupByLibrary.simpleMessage(
      "Please fill in all fields",
    ),
    "please_log_in_to_submit_your_review": MessageLookupByLibrary.simpleMessage(
      "Please Log In to Submit Your Review",
    ),
    "popup_description": MessageLookupByLibrary.simpleMessage(
      "In order to keep the user reviews truthful, to review yourself the kebab,\nyou need to go in person to the kebab place and find the affixed Kebabbo sticker nearby,\nscanning it will bring you to the review page.",
    ),
    "popup_title": MessageLookupByLibrary.simpleMessage(
      "How to write your own review",
    ),
    "post_eliminato": MessageLookupByLibrary.simpleMessage("Post deleted"),
    "posts": MessageLookupByLibrary.simpleMessage("Posts"),
    "preferiti_solo_per_utenti_registrati":
        MessageLookupByLibrary.simpleMessage(
          "Favorites only for registered users",
        ),
    "prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi":
        MessageLookupByLibrary.simpleMessage(
          "\"Take, and eat of this, all of you: this is the Kebab offered in sacrifice for you.\"",
        ),
    "price": MessageLookupByLibrary.simpleMessage("Price"),
    "prima_review": MessageLookupByLibrary.simpleMessage("first review"),
    "primo_post": MessageLookupByLibrary.simpleMessage("first post"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacy_policy_load_error": MessageLookupByLibrary.simpleMessage(
      "Error loading the Privacy Policy",
    ),
    "progress_label": MessageLookupByLibrary.simpleMessage("Progress"),
    "publish_photo": MessageLookupByLibrary.simpleMessage("Post photo"),
    "publish_review": MessageLookupByLibrary.simpleMessage("Post review"),
    "quality": MessageLookupByLibrary.simpleMessage("Quality"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "queued": MessageLookupByLibrary.simpleMessage("Queued"),
    "rank_0_desc": MessageLookupByLibrary.simpleMessage(
      "Write your first review or create a post to start your collection!",
    ),
    "rank_0_name": MessageLookupByLibrary.simpleMessage("Kebab Novice"),
    "rank_1_desc": MessageLookupByLibrary.simpleMessage(
      "The first milestones are yours! Keep reviewing and posting.",
    ),
    "rank_1_name": MessageLookupByLibrary.simpleMessage("Spit Enthusiast"),
    "rank_2_desc": MessageLookupByLibrary.simpleMessage(
      "You have a great palate and an active voice in the feed.",
    ),
    "rank_2_name": MessageLookupByLibrary.simpleMessage("Döner Gourmet"),
    "rank_3_desc": MessageLookupByLibrary.simpleMessage(
      "A recognised expert in both taste and community.",
    ),
    "rank_3_name": MessageLookupByLibrary.simpleMessage("Sauce Master"),
    "rank_4_desc": MessageLookupByLibrary.simpleMessage(
      "Just a few milestones left to complete everything!",
    ),
    "rank_4_name": MessageLookupByLibrary.simpleMessage("Kebabbo Veteran"),
    "rank_5_desc": MessageLookupByLibrary.simpleMessage(
      "You\'ve achieved every milestone! You\'re in Kebabbo\'s Olympus.",
    ),
    "rank_5_name": MessageLookupByLibrary.simpleMessage("Supreme Legend"),
    "rate_the_kebab": MessageLookupByLibrary.simpleMessage("Rate the Kebab"),
    "rating_title": MessageLookupByLibrary.simpleMessage("Rating"),
    "ready": MessageLookupByLibrary.simpleMessage("Ready!"),
    "recharge_info": MessageLookupByLibrary.simpleMessage(
      "1 pack recharges every 12h (max 2)",
    ),
    "recharging_next_in": m27,
    "registrati_per_poter_visualizzare_il_feed":
        MessageLookupByLibrary.simpleMessage("Register to view the feed"),
    "remaining_count": m28,
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Remove from favorites",
    ),
    "removed_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Removed from favorites",
    ),
    "required_field": MessageLookupByLibrary.simpleMessage("Required field"),
    "reroll": MessageLookupByLibrary.simpleMessage("Reroll"),
    "reroll_step_1": MessageLookupByLibrary.simpleMessage(
      "👨‍🍳 New combination coming up...",
    ),
    "reroll_step_2": MessageLookupByLibrary.simpleMessage(
      "🔥 Balancing spices and cooking...",
    ),
    "reroll_step_3": MessageLookupByLibrary.simpleMessage(
      "✨ Looking for another great pick...",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "review": MessageLookupByLibrary.simpleMessage("Review"),
    "reviewMessage": m29,
    "review_action": MessageLookupByLibrary.simpleMessage("Review"),
    "review_already_exists_message": MessageLookupByLibrary.simpleMessage(
      "A review already exists for this place, do you want to overwrite it?",
    ),
    "review_already_exists_title": MessageLookupByLibrary.simpleMessage(
      "Review already exists",
    ),
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Review submitted successfully",
    ),
    "review_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Review this Kebab",
    ),
    "review_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Review updated successfully",
    ),
    "reviews_label": MessageLookupByLibrary.simpleMessage("Reviews"),
    "riprova": MessageLookupByLibrary.simpleMessage("Try again"),
    "sandwich_tag": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "sandwiches": MessageLookupByLibrary.simpleMessage("Sandwiches"),
    "save_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Save to favorites",
    ),
    "scrivi_un_commento": MessageLookupByLibrary.simpleMessage(
      "Write a comment...",
    ),
    "scrivi_un_post": MessageLookupByLibrary.simpleMessage("Write a post..."),
    "search_address_or_place": MessageLookupByLibrary.simpleMessage(
      "Search address or place...",
    ),
    "search_kebab_to_compare": MessageLookupByLibrary.simpleMessage(
      "Search a kebab to compare...",
    ),
    "search_kebabbo_places": MessageLookupByLibrary.simpleMessage(
      "Search Kebabbo places",
    ),
    "search_places_hint": MessageLookupByLibrary.simpleMessage(
      "e.g. Istanbul, Agra, King...",
    ),
    "second_pack_slot": MessageLookupByLibrary.simpleMessage("2nd pack"),
    "section_initial_review": MessageLookupByLibrary.simpleMessage(
      "5. Your first review",
    ),
    "section_location": MessageLookupByLibrary.simpleMessage(
      "1. Location on the map 📍",
    ),
    "section_location_hint": MessageLookupByLibrary.simpleMessage(
      "Tap to drop the pin or search for the place. Coordinates, address and name will be filled in automatically!",
    ),
    "section_name_category": MessageLookupByLibrary.simpleMessage(
      "2. Name and category 🌯",
    ),
    "section_opening_hours": MessageLookupByLibrary.simpleMessage(
      "3. Opening hours ⏰",
    ),
    "section_photo_optional": MessageLookupByLibrary.simpleMessage(
      "4. Photo of the place (optional)",
    ),
    "see_hours_photos_reviews": MessageLookupByLibrary.simpleMessage(
      "See hours, photos and reviews",
    ),
    "segui": MessageLookupByLibrary.simpleMessage("Follow"),
    "segui_gia": MessageLookupByLibrary.simpleMessage("Already following"),
    "seguiti": MessageLookupByLibrary.simpleMessage("Followed"),
    "select_first_kebab": MessageLookupByLibrary.simpleMessage(
      "Select 1st kebab",
    ),
    "select_location_first": MessageLookupByLibrary.simpleMessage(
      "Select the location on the map before continuing! 📍",
    ),
    "select_on_map": MessageLookupByLibrary.simpleMessage("Select on map"),
    "select_photo_first": MessageLookupByLibrary.simpleMessage(
      "Select a photo before posting",
    ),
    "select_place_to_review": MessageLookupByLibrary.simpleMessage(
      "Select the place you want to review! 🌯",
    ),
    "select_second_kebab": MessageLookupByLibrary.simpleMessage(
      "Select 2nd kebab",
    ),
    "select_two_kebabs_to_compare": MessageLookupByLibrary.simpleMessage(
      "Select two kebabs to view the detailed comparison.",
    ),
    "selected_point": MessageLookupByLibrary.simpleMessage("Selected point"),
    "seleziona_il_tuo_kebab_preferito": MessageLookupByLibrary.simpleMessage(
      "Select your favorite kebab",
    ),
    "send_reset_email": MessageLookupByLibrary.simpleMessage(
      "Send reset email",
    ),
    "session_expired": MessageLookupByLibrary.simpleMessage(
      "Session expired. Please log in again.",
    ),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "sign_up_with_google": MessageLookupByLibrary.simpleMessage(
      "Sign up with Google",
    ),
    "signup_tagline": MessageLookupByLibrary.simpleMessage(
      "Create your profile and start reviewing the kebabs in your city",
    ),
    "single_card": MessageLookupByLibrary.simpleMessage("Kebabbo Card"),
    "sort_dimension": MessageLookupByLibrary.simpleMessage("size"),
    "sort_distance": MessageLookupByLibrary.simpleMessage("distance"),
    "sort_menu": MessageLookupByLibrary.simpleMessage("menu"),
    "sort_name": MessageLookupByLibrary.simpleMessage("name"),
    "sort_price": MessageLookupByLibrary.simpleMessage("price"),
    "sort_quality": MessageLookupByLibrary.simpleMessage("quality"),
    "sort_stars": MessageLookupByLibrary.simpleMessage("stars"),
    "sovrascrivi": MessageLookupByLibrary.simpleMessage("Overwrite"),
    "spicy": MessageLookupByLibrary.simpleMessage("Spicy"),
    "staff": MessageLookupByLibrary.simpleMessage("Staff"),
    "staff_certified": MessageLookupByLibrary.simpleMessage(
      "Kebabbo Staff Certified",
    ),
    "submit_review": MessageLookupByLibrary.simpleMessage("Submit Review"),
    "successfully_updated_profile": MessageLookupByLibrary.simpleMessage(
      "Successfully updated profile!",
    ),
    "swipe_collection_hint": MessageLookupByLibrary.simpleMessage(
      "Swipe to browse collection",
    ),
    "tab_overview": MessageLookupByLibrary.simpleMessage("Overview"),
    "tab_photos": m30,
    "tab_reviews": m31,
    "tag_kebab_pill": MessageLookupByLibrary.simpleMessage("Kebab 🌯"),
    "tag_sandwich_pill": MessageLookupByLibrary.simpleMessage(
      "Sandwich shop 🥪",
    ),
    "tap_map_to_select": MessageLookupByLibrary.simpleMessage(
      "Tap the map to select the exact spot",
    ),
    "tap_to_browse_album": MessageLookupByLibrary.simpleMessage(
      "Tap to browse the full album ›",
    ),
    "tap_to_open_pack": MessageLookupByLibrary.simpleMessage(
      "Tap to open the pack!",
    ),
    "tap_to_select_photo": MessageLookupByLibrary.simpleMessage(
      "Tap to select a photo",
    ),
    "tcg_album": MessageLookupByLibrary.simpleMessage("TCG card album"),
    "ten_posts": MessageLookupByLibrary.simpleMessage("10 posts"),
    "ten_reviews": MessageLookupByLibrary.simpleMessage("10 reviews"),
    "testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo":
        MessageLookupByLibrary.simpleMessage(
          "We test and review Kebab places and Street Food for you. Welcome to Kebabbo.",
        ),
    "testo_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Text not available",
    ),
    "thank_you": MessageLookupByLibrary.simpleMessage("Thank You"),
    "thank_you_for_your_review": MessageLookupByLibrary.simpleMessage(
      "Thank you for your review!",
    ),
    "thirty_reviews": MessageLookupByLibrary.simpleMessage("30 reviews"),
    "twenty_reviews": MessageLookupByLibrary.simpleMessage("20 reviews"),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Unexpected error occurred",
    ),
    "unit_posts": MessageLookupByLibrary.simpleMessage("posts"),
    "unit_reviews": MessageLookupByLibrary.simpleMessage("reviews"),
    "unlocked_badge": MessageLookupByLibrary.simpleMessage("Unlocked"),
    "unlocked_of_total": m32,
    "unpack_and_view_collection": MessageLookupByLibrary.simpleMessage(
      "Unpack & view collection",
    ),
    "unpack_new_cards": MessageLookupByLibrary.simpleMessage(
      "Unpack new cards",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "upload_error": m33,
    "upload_first_photo": MessageLookupByLibrary.simpleMessage(
      "Upload the first photo",
    ),
    "upload_place_photo": MessageLookupByLibrary.simpleMessage(
      "Upload a photo of the spit or the place",
    ),
    "user_generic": MessageLookupByLibrary.simpleMessage("User"),
    "user_not_authenticated": MessageLookupByLibrary.simpleMessage(
      "User not authenticated",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage("User not found"),
    "user_not_found_login_again": MessageLookupByLibrary.simpleMessage(
      "User not found. Please log in again.",
    ),
    "username_can_only_contain_letters_numbers_and_underscores":
        MessageLookupByLibrary.simpleMessage(
          "Username can only contain letters,\nnumbers, and underscores!",
        ),
    "username_cannot_be_more_than_12_characters":
        MessageLookupByLibrary.simpleMessage(
          "Username cannot be more than \n12 characters!",
        ),
    "username_cannot_contain_spaces_use_undescores_instead":
        MessageLookupByLibrary.simpleMessage(
          "Username cannot contain spaces,\nuse underscores instead!",
        ),
    "username_must_be_at_least_3_characters_long":
        MessageLookupByLibrary.simpleMessage(
          "Username must be at least 3 \ncharacters long!",
        ),
    "users": MessageLookupByLibrary.simpleMessage("Users"),
    "users_count": m34,
    "users_review": MessageLookupByLibrary.simpleMessage("Users Review"),
    "vegetables": MessageLookupByLibrary.simpleMessage("Vegetables"),
    "verdura": MessageLookupByLibrary.simpleMessage("Vegetables"),
    "verified_by_staff_tooltip": MessageLookupByLibrary.simpleMessage(
      "Verified by Kebabbo staff",
    ),
    "vuoi_veramente_eliminare_il_post": MessageLookupByLibrary.simpleMessage(
      "Do you really want to delete the post?",
    ),
    "world": MessageLookupByLibrary.simpleMessage("World"),
    "write_a_review_for_a_kebab_near_you": MessageLookupByLibrary.simpleMessage(
      "Write a review",
    ),
    "write_first_review": MessageLookupByLibrary.simpleMessage(
      "Write the first review",
    ),
    "write_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Rate the quality, the meat and the sauces",
    ),
    "write_review_title": MessageLookupByLibrary.simpleMessage(
      "Write a Review",
    ),
    "yes_create_new": MessageLookupByLibrary.simpleMessage("Yes, create new"),
    "yogurt": MessageLookupByLibrary.simpleMessage("Yogurt"),
    "you_can_access_reviews_at_any_time_from_your_account":
        MessageLookupByLibrary.simpleMessage(
          "You can access reviews at any time from your account.",
        ),
    "your_experience": MessageLookupByLibrary.simpleMessage("Your experience"),
    "your_kebab": MessageLookupByLibrary.simpleMessage("Your kebab"),
    "your_medals_title": MessageLookupByLibrary.simpleMessage("Your Medals"),
    "your_review_optional": MessageLookupByLibrary.simpleMessage(
      "Your review (optional)",
    ),
  };
}
