// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(name) => "Foto zu ${name} hinzufügen";

  static String m1(name) => "${name} (bereits in der Sammlung)";

  static String m2(error) => "Ein Fehler ist aufgetreten: ${error}";

  static String m3(count) => "Basierend auf ${count} Bewertungen";

  static String m4(current, total) => "#${current} von ${total}";

  static String m5(style) => "Karte wechseln: ${style}";

  static String m6(city) => "Stadt: ${city}";

  static String m7(count) => "Community (${count})";

  static String m8(results) => "10 km (${results} Ergebnisse)";

  static String m9(results) => "1 km (${results} Ergebnisse)";

  static String m10(results) => "200 Meter (${results} Ergebnisse)";

  static String m11(results) => "500 Meter (${results} Ergebnisse)";

  static String m12(results) => "Unbegrenzt (${results} Ergebnisse)";

  static String m13(error) => "Fehler beim Löschen des Posts: ${error}";

  static String m14(error) => "Fehler beim Speichern: ${error}";

  static String m15(error) => "Fehler beim Senden der Bewertung: ${error}";

  static String m16(count) => "Alle (${count})";

  static String m17(count) => "Bewertungen (${count})";

  static String m18(count) => "Freigeschaltet (${count})";

  static String m19(missing, unit) =>
      "Nur noch ${missing} ${unit}, um diese Medaille freizuschalten!";

  static String m20(count) => "${count} fehlen";

  static String m21(time) => "Nächste Aufladung in ${time}";

  static String m22(km) => "Keine Kebab-Läden im Umkreis von ${km} km.";

  static String m23(hours, minutes) =>
      "Gerade ist kein Paket bereit (0/2). Das nächste ist in ${hours} Std. ${minutes} Min. bereit.";

  static String m24(time) =>
      "Kein Paket bereit. Das nächste ist in ${time} verfügbar.";

  static String m25(count) => "2. Paket öffnen (${count})";

  static String m26(error) =>
      "Passwort konnte nicht zurückgesetzt werden: ${error}";

  static String m27(percent) => "${percent}% abgeschlossen";

  static String m28(time) => "Lädt auf: nächstes in ${time}";

  static String m29(count) => "${count} übrig";

  static String m30(
    kebabName,
    qualityRating,
    quantityRating,
    menuRating,
    priceRating,
    funRating,
    description,
  ) =>
      "Ich habe gerade den Kebab bei ${kebabName} bewertet!\n\nQualität: ${qualityRating}\nMenge: ${quantityRating}\nMenü: ${menuRating}\nPreis: ${priceRating}\nSpaß: ${funRating}\n\n${description}";

  static String m31(name, rating) => "${name}: ${rating} auf Kebabbo 🌯";

  static String m32(rating) => "Kebabbo-Bewertung ${rating}";

  static String m33(count) => "Fotos (${count})";

  static String m34(count) => "Bewertungen (${count})";

  static String m35(count) => "${count} TCG-Karten";

  static String m36(unlocked, total) =>
      "${unlocked} von ${total} freigeschaltet";

  static String m37(error) => "Fehler beim Hochladen: ${error}";

  static String m38(count) => "Nutzer (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Über uns"),
    "accedi_per_cercare": MessageLookupByLibrary.simpleMessage(
      "Melde dich an, um zu posten und die Informationen anderer Leute zu sehen",
    ),
    "add_dish_photo_optional": MessageLookupByLibrary.simpleMessage(
      "Foto deines Gerichts hinzufügen (optional)",
    ),
    "add_kebab": MessageLookupByLibrary.simpleMessage("Kebab hinzufügen"),
    "add_kebab_place": MessageLookupByLibrary.simpleMessage(
      "Kebab-Laden hinzufügen",
    ),
    "add_kebab_place_subtitle": MessageLookupByLibrary.simpleMessage(
      "Einen neuen Laden auf der Karte eintragen",
    ),
    "add_kebab_to_kebabbo": MessageLookupByLibrary.simpleMessage(
      "Laden zu Kebabbo hinzufügen",
    ),
    "add_new_kebab_confirmation": MessageLookupByLibrary.simpleMessage(
      "Du bist dabei, \"\$name\" als neuen Dönerladen hinzuzufügen. Bist du sicher, dass er noch nicht existiert?",
    ),
    "add_photo_to": m0,
    "add_review_appbar_title": MessageLookupByLibrary.simpleMessage(
      "Bewertung hinzufügen",
    ),
    "add_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Einen neuen Döner probiert?",
    ),
    "add_review_title": MessageLookupByLibrary.simpleMessage(
      "Bewertung hinzufügen",
    ),
    "add_to_collection": MessageLookupByLibrary.simpleMessage(
      "Zur Sammlung hinzufügen",
    ),
    "added_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Zu Favoriten hinzugefügt ❤️",
    ),
    "advanced_filters": MessageLookupByLibrary.simpleMessage(
      "Erweiterte Filter",
    ),
    "all_filter": MessageLookupByLibrary.simpleMessage("Alle"),
    "all_found": MessageLookupByLibrary.simpleMessage("Alle gefunden! 🏆"),
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Hast du bereits ein Konto? Anmelden",
    ),
    "already_in_collection": m1,
    "an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Ein Fehler ist aufgetreten",
    ),
    "an_error_occurred_with": m2,
    "annulla": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "anonimo": MessageLookupByLibrary.simpleMessage("Anonym"),
    "aperti_ora": MessageLookupByLibrary.simpleMessage("Jetzt geöffnet"),
    "aperto": MessageLookupByLibrary.simpleMessage("Geöffnet"),
    "app_is_installed": MessageLookupByLibrary.simpleMessage(
      "Kebabbo gibt es auch als App!",
    ),
    "app_is_installed_description": MessageLookupByLibrary.simpleMessage(
      "Öffne es in der App für ein besseres Erlebnis. Falls du sie noch nicht hast, bringen wir dich zu Google Play.",
    ),
    "autenticazione_necessaria": MessageLookupByLibrary.simpleMessage(
      "Du musst angemeldet sein, um zu kommentieren.",
    ),
    "back_to_build": MessageLookupByLibrary.simpleMessage("Zurück zum Bauen"),
    "based_on_reviews": m3,
    "build_button": MessageLookupByLibrary.simpleMessage("Bauen!"),
    "build_your_kebab": MessageLookupByLibrary.simpleMessage(
      "Baue deinen Kebab",
    ),
    "by_signing_in_you_agree_to_our_terms_and_privacy_policy":
        MessageLookupByLibrary.simpleMessage(
          "Mit der Anmeldung stimmst du unseren Nutzungsbedingungen und Datenschutzrichtlinien zu.",
        ),
    "cambia_profilepic": MessageLookupByLibrary.simpleMessage(
      "profilbild ändern",
    ),
    "cambia_profilo": MessageLookupByLibrary.simpleMessage("profil ändern"),
    "cambia_username": MessageLookupByLibrary.simpleMessage(
      "Benutzernamen ändern",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "card_collection": MessageLookupByLibrary.simpleMessage("Kartensammlung"),
    "card_x_of_y": m4,
    "cards_unlocked": MessageLookupByLibrary.simpleMessage(
      "Karten freigeschaltet",
    ),
    "center_on_my_location": MessageLookupByLibrary.simpleMessage(
      "Auf meinen Standort zentrieren",
    ),
    "cerca_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Suche nach einem Kebabladen...",
    ),
    "cerca_utenti": MessageLookupByLibrary.simpleMessage("Benutzer suchen..."),
    "change": MessageLookupByLibrary.simpleMessage("Ändern"),
    "change_map_style": m5,
    "check_your_email_for_a_login_link": MessageLookupByLibrary.simpleMessage(
      "Überprüfe deine E-Mails auf einen Anmeldelink!",
    ),
    "check_your_email_for_a_reset_link": MessageLookupByLibrary.simpleMessage(
      "Überprüfe deine E-Mails auf einen Link zum Zurücksetzen",
    ),
    "check_your_email_for_a_verification_link":
        MessageLookupByLibrary.simpleMessage(
          "Überprüfe deine E-Mails auf einen Bestätigungslink",
        ),
    "chiuso": MessageLookupByLibrary.simpleMessage("Geschlossen"),
    "choose_on_map_recommended": MessageLookupByLibrary.simpleMessage(
      "Auf der Karte wählen (empfohlen)",
    ),
    "choose_place": MessageLookupByLibrary.simpleMessage("Laden auswählen"),
    "cipolla": MessageLookupByLibrary.simpleMessage("Zwiebel"),
    "city": MessageLookupByLibrary.simpleMessage("Stadt"),
    "city_label": m6,
    "close": MessageLookupByLibrary.simpleMessage("Schließen"),
    "collection_subtitle": MessageLookupByLibrary.simpleMessage(
      "checke deine Kebabbo-Karten",
    ),
    "collection_title": MessageLookupByLibrary.simpleMessage("Sammlung"),
    "comment_review_hint": MessageLookupByLibrary.simpleMessage(
      "Was hat dir am besten gefallen? Empfiehlst du eine Soße oder ein Menü?",
    ),
    "comment_review_label": MessageLookupByLibrary.simpleMessage(
      "Kommentar / Bewertung *",
    ),
    "comment_review_required": MessageLookupByLibrary.simpleMessage(
      "Schreib einen kurzen Kommentar zu deiner Erfahrung",
    ),
    "commento_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Kommentar nicht verfügbar",
    ),
    "commento_vuoto": MessageLookupByLibrary.simpleMessage(
      "Der Kommentartext darf nicht leer sein.",
    ),
    "community_count": m7,
    "community_review": MessageLookupByLibrary.simpleMessage(
      "Community-Bewertung",
    ),
    "community_upload": MessageLookupByLibrary.simpleMessage("Community"),
    "compare_kebabs": MessageLookupByLibrary.simpleMessage("Döner Vergleichen"),
    "completed_badge": MessageLookupByLibrary.simpleMessage("Geschafft! ⭐"),
    "conferma_eliminazione": MessageLookupByLibrary.simpleMessage(
      "Löschung bestätigen",
    ),
    "confirm_this_location": MessageLookupByLibrary.simpleMessage(
      "Diesen Standort bestätigen",
    ),
    "congratulazioni": MessageLookupByLibrary.simpleMessage("Glückwunsch!"),
    "consigliaci_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Empfiehl uns einen Kebabladen",
    ),
    "contribute_subtitle": MessageLookupByLibrary.simpleMessage(
      "Hilf uns, die besten Kebab-Läden zu finden und zu bewerten!",
    ),
    "contribute_title": MessageLookupByLibrary.simpleMessage(
      "Trag zu Kebabbo bei",
    ),
    "cooking_step_1": MessageLookupByLibrary.simpleMessage(
      "🔥 Brot wird aufgewärmt...",
    ),
    "cooking_step_2": MessageLookupByLibrary.simpleMessage(
      "🥩 Fleisch wird vom Spieß geschnitten...",
    ),
    "cooking_step_3": MessageLookupByLibrary.simpleMessage(
      "🥗 Frisches Gemüse und Soßen dazu...",
    ),
    "cooking_step_4": MessageLookupByLibrary.simpleMessage(
      "🌯 Wird kunstvoll gerollt...",
    ),
    "cooking_step_5": MessageLookupByLibrary.simpleMessage(
      "🔍 Suche den besten Kebab für dich...",
    ),
    "cooking_title": MessageLookupByLibrary.simpleMessage(
      "Kebab wird zubereitet",
    ),
    "cooking_title_reroll": MessageLookupByLibrary.simpleMessage(
      "Alternative wird gesucht",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Kopieren"),
    "copy_link": MessageLookupByLibrary.simpleMessage("Link kopieren"),
    "could_not_open_link": MessageLookupByLibrary.simpleMessage(
      "Link konnte nicht geöffnet werden.",
    ),
    "create_kebab_subtitle": MessageLookupByLibrary.simpleMessage(
      "bau deinen eigenen Döner",
    ),
    "create_kebab_title": MessageLookupByLibrary.simpleMessage(
      "Kebab erstellen",
    ),
    "custom_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Lege die Zeiten für jeden Tag fest (z. B. 11:00-23:00 oder „geschlossen“):",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "description_is_required": MessageLookupByLibrary.simpleMessage(
      "Beschreibung erforderlich",
    ),
    "description_review_hint": MessageLookupByLibrary.simpleMessage(
      "Erzähl von diesem Kebab: Brot, Fleisch, Geschmack...",
    ),
    "description_review_label": MessageLookupByLibrary.simpleMessage(
      "Beschreibung / Bewertung *",
    ),
    "description_review_required": MessageLookupByLibrary.simpleMessage(
      "Schreib einen kurzen Kommentar, um den Laden vorzustellen",
    ),
    "descrizione_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Beschreibung nicht verfügbar",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "devi_essere_autenticato_per_commentare":
        MessageLookupByLibrary.simpleMessage(
          "Du musst dich anmelden, um zu kommentieren",
        ),
    "devi_essere_autenticato_per_mettere_mi_piace":
        MessageLookupByLibrary.simpleMessage(
          "Du musst dich anmelden, um zu liken",
        ),
    "devi_essere_autenticato_per_postare": MessageLookupByLibrary.simpleMessage(
      "Du musst angemeldet sein, um zu posten",
    ),
    "devi_essere_autenticato_per_visualizzare_il_profilo":
        MessageLookupByLibrary.simpleMessage(
          "Du musst dich anmelden, um das Profil anzuzeigen",
        ),
    "dimension": MessageLookupByLibrary.simpleMessage("Größe"),
    "directions": MessageLookupByLibrary.simpleMessage("Route"),
    "distanceLabel10km": m8,
    "distanceLabel1km": m9,
    "distanceLabel200m": m10,
    "distanceLabel500m": m11,
    "distanceLabelUnlimited": m12,
    "distanza_massima": MessageLookupByLibrary.simpleMessage(
      "Maximale Entfernung",
    ),
    "distanza_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Entfernung nicht verfügbar",
    ),
    "dont_have_an_account_sign_up": MessageLookupByLibrary.simpleMessage(
      "Du hast noch kein Konto? Anmelden",
    ),
    "drag_to_tilt": MessageLookupByLibrary.simpleMessage(
      "Mit dem Finger ziehen, um in 3D zu kippen",
    ),
    "duplicate_card": MessageLookupByLibrary.simpleMessage("DOPPELTE KARTE"),
    "edit_location_on_map": MessageLookupByLibrary.simpleMessage(
      "Standort auf der Karte ändern",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Profil bearbeiten"),
    "elimina": MessageLookupByLibrary.simpleMessage("Löschen"),
    "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "email_required": MessageLookupByLibrary.simpleMessage(
      "E-Mail ist erforderlich",
    ),
    "enter_place_name": MessageLookupByLibrary.simpleMessage(
      "Gib den Namen des Ladens ein",
    ),
    "error_adding_review": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Hinzufügen der Bewertung: ",
    ),
    "error_deleting_post": m13,
    "error_loading_kebabs": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Laden der Dönerläden: ",
    ),
    "error_processing_image": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Verarbeiten des Bildes:",
    ),
    "error_saving": m14,
    "error_sending_review": m15,
    "errore": MessageLookupByLibrary.simpleMessage("Fehler:"),
    "errore_nel_caricamento_dei_follower": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Laden der Follower",
    ),
    "errore_nel_caricamento_dellimage": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Laden des Bildes:",
    ),
    "esplora": MessageLookupByLibrary.simpleMessage("Erkunden"),
    "examine_3d": MessageLookupByLibrary.simpleMessage("In 3D untersuchen"),
    "extract": MessageLookupByLibrary.simpleMessage("Auslesen"),
    "failed_to_load_favorites": MessageLookupByLibrary.simpleMessage(
      "Favoriten konnten nicht geladen werden",
    ),
    "failed_to_load_follower_count": MessageLookupByLibrary.simpleMessage(
      "Anzahl der Follower konnte nicht geladen werden",
    ),
    "failed_to_load_medals": MessageLookupByLibrary.simpleMessage(
      "Medaillen konnten nicht geladen werden",
    ),
    "failed_to_load_post_count": MessageLookupByLibrary.simpleMessage(
      "Anzahl der Beiträge konnte nicht geladen werden",
    ),
    "failed_to_load_posts": MessageLookupByLibrary.simpleMessage(
      "Beiträge konnten nicht geladen werden",
    ),
    "failed_to_load_profile": MessageLookupByLibrary.simpleMessage(
      "Profil konnte nicht geladen werden",
    ),
    "failed_to_load_reviews_count": MessageLookupByLibrary.simpleMessage(
      "Anzahl der Bewertungen konnte nicht geladen werden",
    ),
    "failed_to_update_follow_status": MessageLookupByLibrary.simpleMessage(
      "Folgestatus konnte nicht aktualisiert werden",
    ),
    "failed_to_upload_avatar": MessageLookupByLibrary.simpleMessage(
      "Avatar konnte nicht hochgeladen werden",
    ),
    "favorite_kebab_caps": MessageLookupByLibrary.simpleMessage(
      "LIEBLINGS-KEBAB",
    ),
    "feed_posts_label": MessageLookupByLibrary.simpleMessage("Feed-Posts"),
    "fifty_posts": MessageLookupByLibrary.simpleMessage("50 Beiträge"),
    "filter_all_count": m16,
    "filter_by_distance": MessageLookupByLibrary.simpleMessage(
      "Nach Entfernung filtern",
    ),
    "filter_reviews_count": m17,
    "filter_unlocked_count": m18,
    "first_pack_slot": MessageLookupByLibrary.simpleMessage("1. Paket"),
    "first_time_description": MessageLookupByLibrary.simpleMessage(
      "Willkommen bei Kebabbo!\nWas kannst du hier tun?\nNun, du kannst unsere professionellen Kebab-Bewertungen erkunden oder dir die Bewertungen anderer Benutzer ansehen.\nSchreibe deine eigene Bewertung, indem du den Kebabbo-Aufkleber am Kebabladen scannst.\nSieh dir die Profile und Beiträge anderer Benutzer an, verbinde dich mit anderen Kebab-Liebhabern und verdiene Erfolge für die Nutzung der App.\nNutze unsere Such- und Filterfunktionen oder unser leistungsstarkes Build-Tool, um deinen idealen Kebab zu finden, oder erkunde unsere interaktive Karte, um Juwelen in der Nähe zu entdecken.\nViel Spaß und guten Kebab!",
    ),
    "first_time_title": MessageLookupByLibrary.simpleMessage(
      "Willkommen bei Kebabbo!",
    ),
    "five_posts": MessageLookupByLibrary.simpleMessage("5 Beiträge"),
    "five_reviews": MessageLookupByLibrary.simpleMessage("5 Bewertungen"),
    "followed_filter": MessageLookupByLibrary.simpleMessage("Gefolgt"),
    "followers": MessageLookupByLibrary.simpleMessage("Follower"),
    "following": MessageLookupByLibrary.simpleMessage("Gefolgt"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "Passwort vergessen",
    ),
    "found_all_cards": MessageLookupByLibrary.simpleMessage(
      "Alle Karten gefunden.",
    ),
    "fun": MessageLookupByLibrary.simpleMessage("Spaß"),
    "fun_exclamation": MessageLookupByLibrary.simpleMessage("Spaß!"),
    "games_tools_title": MessageLookupByLibrary.simpleMessage("Spiele & Tools"),
    "generic_error": MessageLookupByLibrary.simpleMessage("Fehler: "),
    "gluten_free": MessageLookupByLibrary.simpleMessage("Glutenfrei"),
    "gluten_free_option": MessageLookupByLibrary.simpleMessage(
      "Glutenfreie Option",
    ),
    "gluten_free_option_desc": MessageLookupByLibrary.simpleMessage(
      "Bietet zertifiziertes glutenfreies Brot oder Optionen",
    ),
    "go_back": MessageLookupByLibrary.simpleMessage("Zurück"),
    "goal_reached": MessageLookupByLibrary.simpleMessage(
      "Meilenstein erreicht 🎉",
    ),
    "google_maps_link": MessageLookupByLibrary.simpleMessage(
      "Google-Maps-Link",
    ),
    "hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia":
        MessageLookupByLibrary.simpleMessage(
          "Du hast einen neuen Meilenstein erreicht und eine neue Medaille erhalten!",
        ),
    "hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo":
        MessageLookupByLibrary.simpleMessage(
          "Du hast eine neue Medaille für deinen Beitrag erhalten!",
        ),
    "have_account_question": MessageLookupByLibrary.simpleMessage(
      "Schon ein Konto?",
    ),
    "hours_none_note": MessageLookupByLibrary.simpleMessage(
      "Es werden keine Öffnungszeiten gespeichert.",
    ),
    "hours_preset_continuous": MessageLookupByLibrary.simpleMessage(
      "Durchgehend (11-23) 🌯",
    ),
    "hours_preset_custom": MessageLookupByLibrary.simpleMessage(
      "Benutzerdefiniert ⚙️",
    ),
    "hours_preset_lunch_dinner": MessageLookupByLibrary.simpleMessage(
      "Mittag- und Abendessen 🍽️",
    ),
    "hours_preset_night": MessageLookupByLibrary.simpleMessage(
      "Nachts (11-02) 🌙",
    ),
    "hours_preset_none": MessageLookupByLibrary.simpleMessage(
      "Nicht angegeben (Standard)",
    ),
    "i_tuoi_post": MessageLookupByLibrary.simpleMessage("Deine Beiträge"),
    "il_commento_e_stato_aggiunto_con_successo":
        MessageLookupByLibrary.simpleMessage(
          "Der Kommentar wurde erfolgreich hinzugefügt!",
        ),
    "il_kebab_che_ti_raccomandiamo_e": MessageLookupByLibrary.simpleMessage(
      "Der Kebab, den wir dir empfehlen, ist:",
    ),
    "il_testo_non_puo_essere_vuoto": MessageLookupByLibrary.simpleMessage(
      "Der Text darf nicht leer sein",
    ),
    "in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google":
        MessageLookupByLibrary.simpleMessage(
          "In Italien ist die Welt des Kebabs noch eine dunkle Welt. Die besten Läden werden unterschätzt und die schlechtesten erhalten hohe Bewertungen auf Google.",
        ),
    "in_progress": MessageLookupByLibrary.simpleMessage("In Arbeit ⏳"),
    "ingredient_amounts_caps": MessageLookupByLibrary.simpleMessage(
      "ZUTATENMENGEN",
    ),
    "ingredient_balance": MessageLookupByLibrary.simpleMessage(
      "Zutatenbalance",
    ),
    "ingredient_balance_1_10": MessageLookupByLibrary.simpleMessage(
      "Zutatenbalance (1 bis 10)",
    ),
    "ingredients_comparison": MessageLookupByLibrary.simpleMessage(
      "Zutaten-Vergleich",
    ),
    "inserted_by": MessageLookupByLibrary.simpleMessage("Hinzugefügt von"),
    "intro_1_text": MessageLookupByLibrary.simpleMessage(
      "Ranglisten vom Team und der Community, eine Karte mit Bewertungen und Filter für Entfernung, Preis und Öffnungszeiten.",
    ),
    "intro_1_title": MessageLookupByLibrary.simpleMessage("Finde deinen Kebab"),
    "intro_2_text": MessageLookupByLibrary.simpleMessage(
      "Bewerte Qualität, Preis und Zutaten, poste Fotos deines Gerichts und füge fehlende Läden hinzu.",
    ),
    "intro_2_title": MessageLookupByLibrary.simpleMessage(
      "Bewerten und teilen",
    ),
    "intro_3_text": MessageLookupByLibrary.simpleMessage(
      "Jede Bewertung und jeder Post schaltet Medaillen frei, und alle 12 Stunden kannst du ein Paket Kebabbo-Karten öffnen.",
    ),
    "intro_3_title": MessageLookupByLibrary.simpleMessage(
      "Sammle Medaillen und Karten",
    ),
    "intro_next": MessageLookupByLibrary.simpleMessage("Weiter"),
    "intro_skip": MessageLookupByLibrary.simpleMessage("Überspringen"),
    "intro_start": MessageLookupByLibrary.simpleMessage("Los geht\'s"),
    "invia": MessageLookupByLibrary.simpleMessage("Senden"),
    "it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again":
        MessageLookupByLibrary.simpleMessage(
          "Es sieht so aus, als ob die Bewertung, auf die du zugreifen möchtest, nicht existiert. Bitte überprüfe den Link und versuche es erneut.",
        ),
    "kebab_already_exists": MessageLookupByLibrary.simpleMessage(
      "Dönerladen existiert bereits",
    ),
    "kebab_consigliato": MessageLookupByLibrary.simpleMessage(
      "Empfohlener Kebab",
    ),
    "kebab_no_longer_available": MessageLookupByLibrary.simpleMessage(
      "Kebab nicht mehr verfügbar",
    ),
    "kebab_not_found": MessageLookupByLibrary.simpleMessage(
      "Dönerladen nicht gefunden",
    ),
    "kebab_place_name_hint": MessageLookupByLibrary.simpleMessage(
      "z. B. Bella Istanbul 3",
    ),
    "kebab_place_name_label": MessageLookupByLibrary.simpleMessage(
      "Name des Ladens *",
    ),
    "kebab_place_not_found": MessageLookupByLibrary.simpleMessage(
      "Laden nicht gefunden oder entfernt.",
    ),
    "kebab_sconosciuto": MessageLookupByLibrary.simpleMessage(
      "Unbekannter Kebab",
    ),
    "kebab_tag": MessageLookupByLibrary.simpleMessage("Kebab"),
    "kebabbo_review": MessageLookupByLibrary.simpleMessage("Kebabbo Bewertung"),
    "kebabbo_staff_review": MessageLookupByLibrary.simpleMessage(
      "Die Kebabbo-Bewertung",
    ),
    "kebabbo_user": MessageLookupByLibrary.simpleMessage("Kebabbo-Nutzer"),
    "km_distante_da_te": MessageLookupByLibrary.simpleMessage(
      "km von dir entfernt",
    ),
    "la_tua_soluzione_per_il_pranzo_universitario":
        MessageLookupByLibrary.simpleMessage(
          "Deine Lösung für das Mittagessen an der Uni",
        ),
    "legends": MessageLookupByLibrary.simpleMessage("Legenden"),
    "link_copied": MessageLookupByLibrary.simpleMessage("Link kopiert"),
    "loader_subtitle": MessageLookupByLibrary.simpleMessage(
      "Ranglisten, Community-Bewertungen und eine Karte der Kebab-Läden.",
    ),
    "loader_title": MessageLookupByLibrary.simpleMessage(
      "Kebabbo – die besten Kebabs in Bologna",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Wird geladen"),
    "location_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Standortberechtigung verweigert.",
    ),
    "location_permission_denied_forever": MessageLookupByLibrary.simpleMessage(
      "Standortberechtigung dauerhaft verweigert. Du kannst sie in den Einstellungen aktivieren.",
    ),
    "location_selected": MessageLookupByLibrary.simpleMessage(
      "Standort ausgewählt",
    ),
    "location_services_disabled": MessageLookupByLibrary.simpleMessage(
      "Die Standortdienste sind deaktiviert.",
    ),
    "log_in_con_google": MessageLookupByLibrary.simpleMessage(
      "Mit Google anmelden",
    ),
    "logged_in": MessageLookupByLibrary.simpleMessage("Angemeldet"),
    "login": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "login_loader_subtitle": MessageLookupByLibrary.simpleMessage(
      "Einen Moment, wir bereiten dein Profil vor.",
    ),
    "login_loader_title": MessageLookupByLibrary.simpleMessage(
      "Du wirst angemeldet",
    ),
    "login_required_section": MessageLookupByLibrary.simpleMessage(
      "Du musst dich anmelden, um diesen Bereich zu nutzen.",
    ),
    "login_step_auth": MessageLookupByLibrary.simpleMessage("Anmeldung"),
    "login_step_profile": MessageLookupByLibrary.simpleMessage(
      "Profil, Favoriten und Medaillen",
    ),
    "login_tagline": MessageLookupByLibrary.simpleMessage(
      "Tritt der Community bei, um die besten Kebabs zu entdecken und zu bewerten",
    ),
    "login_to_follow_user": MessageLookupByLibrary.simpleMessage(
      "Melde dich an, um diesem Nutzer zu folgen",
    ),
    "login_to_post_photos": MessageLookupByLibrary.simpleMessage(
      "Melde dich an, um Fotos zu posten",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "map_not_available": MessageLookupByLibrary.simpleMessage(
      "Karte für diesen Laden nicht verfügbar",
    ),
    "map_style_google_road": MessageLookupByLibrary.simpleMessage(
      "Google Straßenkarte",
    ),
    "map_style_google_satellite": MessageLookupByLibrary.simpleMessage(
      "Google Satellit",
    ),
    "map_style_road_short": MessageLookupByLibrary.simpleMessage("Straße"),
    "map_style_satellite_short": MessageLookupByLibrary.simpleMessage(
      "Satellit",
    ),
    "mappa": MessageLookupByLibrary.simpleMessage("Karte"),
    "maps_link_coords_found": MessageLookupByLibrary.simpleMessage(
      "Koordinaten aus dem Maps-Link erkannt! 📍",
    ),
    "maps_link_failed": MessageLookupByLibrary.simpleMessage(
      "Die Koordinaten konnten nicht aus dem Link gelesen werden. Nutze „Auf der Karte wählen“.",
    ),
    "maps_link_name_and_coords_found": MessageLookupByLibrary.simpleMessage(
      "Koordinaten und Name aus dem Maps-Link erkannt! 📍",
    ),
    "maps_short_link_web": MessageLookupByLibrary.simpleMessage(
      "Nutze im Web den vollständigen Google-Maps-Link (https://www.google.com/maps/place/...): Kurzlinks werden vom Browser blockiert.",
    ),
    "max_charge_reached": MessageLookupByLibrary.simpleMessage(
      "Maximale Ladung erreicht (1 alle 12 Std.)",
    ),
    "meat": MessageLookupByLibrary.simpleMessage("Fleisch"),
    "medal_0_desc": MessageLookupByLibrary.simpleMessage(
      "Du hast deine erste Bewertung eines Kebab-Ladens geschrieben. Willkommen in der Familie der Kebabbo-Kritiker!",
    ),
    "medal_0_title": MessageLookupByLibrary.simpleMessage("Erster Bissen"),
    "medal_1_desc": MessageLookupByLibrary.simpleMessage(
      "Du hast 5 verschiedene Läden bewertet. Dein Gaumen erkennt langsam die wahre Kunst des Spießes!",
    ),
    "medal_1_title": MessageLookupByLibrary.simpleMessage("Serienverkoster"),
    "medal_2_desc": MessageLookupByLibrary.simpleMessage(
      "10 Bewertungen geschafft! Deine Bewertungen leiten die Läden und die ganze Community.",
    ),
    "medal_2_title": MessageLookupByLibrary.simpleMessage("Kebab-Kritiker"),
    "medal_3_desc": MessageLookupByLibrary.simpleMessage(
      "20 Bewertungen geschrieben! Kein Wrap, keine Soße und kein Fladenbrot hat noch Geheimnisse vor dir. Ein wahrer Meister!",
    ),
    "medal_3_title": MessageLookupByLibrary.simpleMessage(
      "Meister des Spießes",
    ),
    "medal_4_desc": MessageLookupByLibrary.simpleMessage(
      "30 Bewertungen auf dem Konto! Du hast den Gipfel der Kebabbo-Erfahrung erreicht. Eine lebende Legende!",
    ),
    "medal_4_title": MessageLookupByLibrary.simpleMessage("Gourmet-Legende"),
    "medal_5_desc": MessageLookupByLibrary.simpleMessage(
      "Du hast deinen ersten Post im Feed veröffentlicht. Deine Kebab-Leidenschaft ist jetzt öffentlich!",
    ),
    "medal_5_title": MessageLookupByLibrary.simpleMessage("Stimme des Feeds"),
    "medal_6_desc": MessageLookupByLibrary.simpleMessage(
      "Du hast 5 Posts mit Fotos und Gedanken geteilt. Die Community liebt deine Updates!",
    ),
    "medal_6_title": MessageLookupByLibrary.simpleMessage("Geschmacksreporter"),
    "medal_7_desc": MessageLookupByLibrary.simpleMessage(
      "10 Posts geteilt! Mit deinen Fotos und Tags machst du die ganze Stadt hungrig.",
    ),
    "medal_7_title": MessageLookupByLibrary.simpleMessage("Kebab-Influencer"),
    "medal_8_desc": MessageLookupByLibrary.simpleMessage(
      "50 Posts in der Community! Du bist eine unersetzliche Säule des Kebabbo-Feeds!",
    ),
    "medal_8_title": MessageLookupByLibrary.simpleMessage(
      "Säule der Community",
    ),
    "medal_missing": m19,
    "medals_page_title": MessageLookupByLibrary.simpleMessage(
      "Medaillen & Meilensteine",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Speisekarte"),
    "missing_count": m20,
    "more_info": MessageLookupByLibrary.simpleMessage(
      "Wie man einen Kebab bewertet",
    ),
    "my_cards": MessageLookupByLibrary.simpleMessage("Kebab TCG Sammlung"),
    "name_autofilled_helper": MessageLookupByLibrary.simpleMessage(
      "Automatisch von der Karte übernommen (gern anpassen)",
    ),
    "name_label": MessageLookupByLibrary.simpleMessage("Name"),
    "nav_account": MessageLookupByLibrary.simpleMessage("Konto"),
    "nav_add": MessageLookupByLibrary.simpleMessage("Hinzufügen"),
    "nav_feed": MessageLookupByLibrary.simpleMessage("Feed"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Start"),
    "nessun_commento_disponibile": MessageLookupByLibrary.simpleMessage(
      "Keine Kommentare verfügbar",
    ),
    "nessun_kebab_corrispondente_trovato_nel_raggio_selezionato":
        MessageLookupByLibrary.simpleMessage(
          "Kein passender Kebab im ausgewählten Radius gefunden",
        ),
    "nessun_kebab_tra_i_preferiti": MessageLookupByLibrary.simpleMessage(
      "Keine Kebabs in den Favoriten",
    ),
    "nessun_kebab_vicino_a_te": MessageLookupByLibrary.simpleMessage(
      "Kein Kebab in deiner Nähe \nDu musst dich in der Nähe des Kebabladens befinden, um ihn aus Authentizitätsgründen zu bewerten.\nÜberprüfe deinen Standort und lade die Seite neu.",
    ),
    "nessun_kebabbaro_presente": MessageLookupByLibrary.simpleMessage(
      "Keine Kebabläden vorhanden :(",
    ),
    "nessun_post_trovato": MessageLookupByLibrary.simpleMessage(
      "Keine Beiträge gefunden",
    ),
    "nessun_utente_seguito": MessageLookupByLibrary.simpleMessage(
      "Keine Benutzer gefolgt",
    ),
    "nessun_utente_ti_segue": MessageLookupByLibrary.simpleMessage(
      "Keine Benutzer folgen dir",
    ),
    "nessuna_recensione_ancora": MessageLookupByLibrary.simpleMessage(
      "Noch keine Bewertungen",
    ),
    "nessuna_recensione_disponibile": MessageLookupByLibrary.simpleMessage(
      "Keine Bewertungen verfügbar",
    ),
    "new_card_unlocked": MessageLookupByLibrary.simpleMessage(
      "NEUE KARTE FREIGESCHALTET!",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "next_recharge_in": m21,
    "no_account_question": MessageLookupByLibrary.simpleMessage(
      "Noch kein Konto?",
    ),
    "no_cards_available": MessageLookupByLibrary.simpleMessage(
      "Keine Karten verfügbar.",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "Du hast noch keine Karten",
    ),
    "no_image": MessageLookupByLibrary.simpleMessage("Kein Bild"),
    "no_kebab_within_distance": m22,
    "no_medals_in_filter": MessageLookupByLibrary.simpleMessage(
      "Keine Medaillen in diesem Filter",
    ),
    "no_more_kebabs_to_recommend": MessageLookupByLibrary.simpleMessage(
      "Es gibt keine weiteren Kebabs zum Empfehlen.",
    ),
    "no_pack_ready": MessageLookupByLibrary.simpleMessage("Kein Paket bereit"),
    "no_pack_ready_hours_minutes": m23,
    "no_pack_ready_timer": m24,
    "no_photos_yet": MessageLookupByLibrary.simpleMessage("Noch keine Fotos"),
    "no_photos_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Teile als Erster ein Foto von deinem Kebab oder Gericht aus diesem Laden!",
    ),
    "no_place_found_add_it": MessageLookupByLibrary.simpleMessage(
      "Kein Laden gefunden. Wenn er neu ist, nutze „Kebab-Laden hinzufügen“!",
    ),
    "no_posts_yet": MessageLookupByLibrary.simpleMessage("Noch keine Posts"),
    "no_reviews_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Teile deine Erfahrung mit diesem Laden mit der ganzen Community!",
    ),
    "no_suggestions_available": MessageLookupByLibrary.simpleMessage(
      "Keine Vorschläge verfügbar",
    ),
    "no_thanks": MessageLookupByLibrary.simpleMessage("Nein, danke"),
    "no_user_reviews_yet": MessageLookupByLibrary.simpleMessage(
      "Noch hat niemand diesen Laden bewertet!",
    ),
    "nome_del_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Name des Kebabladens",
    ),
    "nome_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Name nicht verfügbar",
    ),
    "non_segui_ancora_nessuno": MessageLookupByLibrary.simpleMessage(
      "Du folgst noch niemandem",
    ),
    "nuova_medaglia": MessageLookupByLibrary.simpleMessage("Neue Medaille!"),
    "nuovo_username": MessageLookupByLibrary.simpleMessage(
      "Neuer Benutzername...",
    ),
    "objectives": MessageLookupByLibrary.simpleMessage("Ziele"),
    "objectives_and_medals": MessageLookupByLibrary.simpleMessage(
      "Ziele & Medaillen",
    ),
    "one_post": MessageLookupByLibrary.simpleMessage("1 Beitrag"),
    "one_review": MessageLookupByLibrary.simpleMessage("1 Bewertung"),
    "onion": MessageLookupByLibrary.simpleMessage("Zwiebel"),
    "oops_review_not_found": MessageLookupByLibrary.simpleMessage(
      "Ups! Bewertung nicht gefunden",
    ),
    "open_in_app": MessageLookupByLibrary.simpleMessage("App öffnen"),
    "open_now": MessageLookupByLibrary.simpleMessage("Jetzt geöffnet"),
    "open_or_get_app": MessageLookupByLibrary.simpleMessage(
      "App öffnen oder herunterladen",
    ),
    "open_pack": MessageLookupByLibrary.simpleMessage("Paket öffnen"),
    "open_pack_two_ready": MessageLookupByLibrary.simpleMessage(
      "Paket öffnen (2 bereit!)",
    ),
    "open_second_pack": m25,
    "opening_hours": MessageLookupByLibrary.simpleMessage("Öffnungszeiten"),
    "opening_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Du kannst sie offen lassen, eine Vorlage wählen oder eigene Zeiten festlegen:",
    ),
    "opening_in_progress": MessageLookupByLibrary.simpleMessage(
      "Wird geöffnet...",
    ),
    "or_continue_with_email": MessageLookupByLibrary.simpleMessage(
      "oder mit E-Mail",
    ),
    "order_by": MessageLookupByLibrary.simpleMessage("Sortieren nach"),
    "origin_label": MessageLookupByLibrary.simpleMessage("Herkunft"),
    "overall_rating_1_5": MessageLookupByLibrary.simpleMessage(
      "Gesamtbewertung (1 bis 5)",
    ),
    "pack": MessageLookupByLibrary.simpleMessage("Kebabbo Packung"),
    "pack_button_subtitle": MessageLookupByLibrary.simpleMessage(
      "öffne dein Lieblings-Döner-Pack",
    ),
    "pack_button_title": MessageLookupByLibrary.simpleMessage("Pack"),
    "pack_too_soon": MessageLookupByLibrary.simpleMessage(
      "Dieses Paket ist noch nicht verfügbar",
    ),
    "packs_full": MessageLookupByLibrary.simpleMessage(
      "Pakete voll aufgeladen: 2 / 2 bereit! 📦✨",
    ),
    "packs_ready_0": MessageLookupByLibrary.simpleMessage(
      "0 / 2 Pakete verfügbar",
    ),
    "packs_ready_1": MessageLookupByLibrary.simpleMessage(
      "1 / 2 Paket bereit zum Öffnen",
    ),
    "packs_ready_2": MessageLookupByLibrary.simpleMessage(
      "2 / 2 Pakete bereit zum Öffnen",
    ),
    "page_not_found": MessageLookupByLibrary.simpleMessage(
      "Seite nicht gefunden",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Passwort"),
    "password_minimum_length": MessageLookupByLibrary.simpleMessage(
      "Das Passwort muss mindestens 6 Zeichen lang sein",
    ),
    "password_must_be_at_least_6_characters":
        MessageLookupByLibrary.simpleMessage(
          "Passwort muss mindestens 6 Zeichen lang sein",
        ),
    "password_reset_failed": m26,
    "password_reset_success": MessageLookupByLibrary.simpleMessage(
      "Passwort zurücksetzen erfolgreich",
    ),
    "paste_maps_link_prompt": MessageLookupByLibrary.simpleMessage(
      "Hast du schon einen Google-Maps-Link? Füge ihn hier ein",
    ),
    "per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab":
        MessageLookupByLibrary.simpleMessage(
          "Deshalb sind wir hier: Studenten, wie du, mit jahrelanger Erfahrung als Kebab-Esser.",
        ),
    "percent_completed": m27,
    "photo": MessageLookupByLibrary.simpleMessage("Foto"),
    "photo_added": MessageLookupByLibrary.simpleMessage("Foto hinzugefügt! 📸"),
    "photo_caption_hint": MessageLookupByLibrary.simpleMessage(
      "Schreib einen Kommentar oder beschreibe deinen Kebab...",
    ),
    "pillars_comparison": MessageLookupByLibrary.simpleMessage(
      "Säulen-Vergleich",
    ),
    "please_enter_a_password": MessageLookupByLibrary.simpleMessage(
      "Bitte gib ein Passwort ein",
    ),
    "please_enter_a_valid_email": MessageLookupByLibrary.simpleMessage(
      "Bitte gib eine gültige E-Mail-Adresse ein",
    ),
    "please_enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Bitte gib deine E-Mail-Adresse ein",
    ),
    "please_fill_in_all_fields": MessageLookupByLibrary.simpleMessage(
      "Bitte füllen Sie alle Felder aus",
    ),
    "please_log_in_to_submit_your_review": MessageLookupByLibrary.simpleMessage(
      "Bitte melde dich an, um deine Bewertung abzugeben",
    ),
    "popup_description": MessageLookupByLibrary.simpleMessage(
      "Um sicherzustellen, dass die Benutzerbewertungen wahrheitsgetreu sind, musst du, um den Kebab selbst zu bewerten,\npersönlich zum Kebabladen gehen und den angebrachten Kebabbo-Aufkleber in der Nähe finden.\nWenn du ihn scannst, gelangst du zur Bewertungsseite.",
    ),
    "popup_title": MessageLookupByLibrary.simpleMessage(
      "So schreibst du deine eigene Bewertung",
    ),
    "post_eliminato": MessageLookupByLibrary.simpleMessage("Beitrag gelöscht"),
    "posts": MessageLookupByLibrary.simpleMessage("Beiträge"),
    "preferiti_solo_per_utenti_registrati":
        MessageLookupByLibrary.simpleMessage(
          "Favoriten nur für registrierte Benutzer",
        ),
    "prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi":
        MessageLookupByLibrary.simpleMessage(
          "\"Nehmt und esst alle davon: Dies ist der Kebab, der für euch geopfert wurde.\"",
        ),
    "price": MessageLookupByLibrary.simpleMessage("Preis"),
    "prima_review": MessageLookupByLibrary.simpleMessage("erste Bewertung"),
    "primo_post": MessageLookupByLibrary.simpleMessage("erster Beitrag"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Datenschutzerklärung",
    ),
    "privacy_policy_load_error": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Laden der Datenschutzerklärung",
    ),
    "profile_link_copied": MessageLookupByLibrary.simpleMessage(
      "Profil-Link in die Zwischenablage kopiert!",
    ),
    "progress_label": MessageLookupByLibrary.simpleMessage("Fortschritt"),
    "publish_photo": MessageLookupByLibrary.simpleMessage("Foto posten"),
    "publish_review": MessageLookupByLibrary.simpleMessage(
      "Bewertung veröffentlichen",
    ),
    "quality": MessageLookupByLibrary.simpleMessage("Qualität"),
    "quantity": MessageLookupByLibrary.simpleMessage("Menge"),
    "queued": MessageLookupByLibrary.simpleMessage("In Warteschlange"),
    "rank_0_desc": MessageLookupByLibrary.simpleMessage(
      "Schreib deine erste Bewertung oder erstelle einen Post, um deine Sammlung zu starten!",
    ),
    "rank_0_name": MessageLookupByLibrary.simpleMessage("Kebab-Neuling"),
    "rank_1_desc": MessageLookupByLibrary.simpleMessage(
      "Die ersten Meilensteine gehören dir! Bewerte und poste weiter.",
    ),
    "rank_1_name": MessageLookupByLibrary.simpleMessage("Spieß-Fan"),
    "rank_2_desc": MessageLookupByLibrary.simpleMessage(
      "Du hast einen feinen Gaumen und bist im Feed aktiv.",
    ),
    "rank_2_name": MessageLookupByLibrary.simpleMessage("Döner-Gourmet"),
    "rank_3_desc": MessageLookupByLibrary.simpleMessage(
      "Ein anerkannter Experte für Geschmack und Community.",
    ),
    "rank_3_name": MessageLookupByLibrary.simpleMessage("Soßenmeister"),
    "rank_4_desc": MessageLookupByLibrary.simpleMessage(
      "Nur noch wenige Meilensteine bis zur Vollständigkeit!",
    ),
    "rank_4_name": MessageLookupByLibrary.simpleMessage("Kebabbo-Veteran"),
    "rank_5_desc": MessageLookupByLibrary.simpleMessage(
      "Du hast alle Meilensteine erreicht! Du bist im Kebabbo-Olymp.",
    ),
    "rank_5_name": MessageLookupByLibrary.simpleMessage("Oberste Legende"),
    "rate_the_kebab": MessageLookupByLibrary.simpleMessage("Bewerte den Kebab"),
    "rating_title": MessageLookupByLibrary.simpleMessage("Bewertung"),
    "ready": MessageLookupByLibrary.simpleMessage("Bereit!"),
    "recharge_info": MessageLookupByLibrary.simpleMessage(
      "Alle 12 Std. wird 1 Paket aufgeladen (max. 2)",
    ),
    "recharging_next_in": m28,
    "registrati_per_poter_visualizzare_il_feed":
        MessageLookupByLibrary.simpleMessage(
          "Registriere dich, um den Feed anzuzeigen",
        ),
    "remaining_count": m29,
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Aus Favoriten entfernen",
    ),
    "removed_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Aus Favoriten entfernt",
    ),
    "required_field": MessageLookupByLibrary.simpleMessage("Pflichtfeld"),
    "reroll": MessageLookupByLibrary.simpleMessage("Neu würfeln"),
    "reroll_step_1": MessageLookupByLibrary.simpleMessage(
      "👨‍🍳 Neue Kombination kommt...",
    ),
    "reroll_step_2": MessageLookupByLibrary.simpleMessage(
      "🔥 Gewürze und Garzeit werden abgestimmt...",
    ),
    "reroll_step_3": MessageLookupByLibrary.simpleMessage(
      "✨ Suche einen weiteren tollen Vorschlag...",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage(
      "Passwort zurücksetzen",
    ),
    "review": MessageLookupByLibrary.simpleMessage("Bewertung"),
    "reviewMessage": m30,
    "review_action": MessageLookupByLibrary.simpleMessage("Bewerten"),
    "review_already_exists_message": MessageLookupByLibrary.simpleMessage(
      "Für dieses Lokal existiert bereits eine Bewertung. Möchtest du sie überschreiben?",
    ),
    "review_already_exists_title": MessageLookupByLibrary.simpleMessage(
      "Bewertung bereits vorhanden",
    ),
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Bewertung erfolgreich abgegeben",
    ),
    "review_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Diesen Döner bewerten",
    ),
    "review_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Bewertung erfolgreich aktualisiert",
    ),
    "reviews_label": MessageLookupByLibrary.simpleMessage("Bewertungen"),
    "riprova": MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
    "sandwich_tag": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "sandwiches": MessageLookupByLibrary.simpleMessage("Sandwiches"),
    "save_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Zu Favoriten hinzufügen",
    ),
    "scrivi_un_commento": MessageLookupByLibrary.simpleMessage(
      "Schreibe einen Kommentar...",
    ),
    "scrivi_un_post": MessageLookupByLibrary.simpleMessage(
      "Schreibe einen Beitrag...",
    ),
    "search_address_or_place": MessageLookupByLibrary.simpleMessage(
      "Adresse oder Ort suchen...",
    ),
    "search_kebab_to_compare": MessageLookupByLibrary.simpleMessage(
      "Döner zum Vergleichen suchen...",
    ),
    "search_kebabbo_places": MessageLookupByLibrary.simpleMessage(
      "Kebabbo-Läden durchsuchen",
    ),
    "search_places_hint": MessageLookupByLibrary.simpleMessage(
      "z. B. Istanbul, Agra, King...",
    ),
    "second_pack_slot": MessageLookupByLibrary.simpleMessage("2. Paket"),
    "section_initial_review": MessageLookupByLibrary.simpleMessage(
      "5. Deine erste Bewertung",
    ),
    "section_location": MessageLookupByLibrary.simpleMessage(
      "1. Standort auf der Karte 📍",
    ),
    "section_location_hint": MessageLookupByLibrary.simpleMessage(
      "Tippe, um die Stecknadel zu setzen oder den Laden zu suchen. Koordinaten, Adresse und Name werden automatisch übernommen!",
    ),
    "section_name_category": MessageLookupByLibrary.simpleMessage(
      "2. Name und Kategorie 🌯",
    ),
    "section_opening_hours": MessageLookupByLibrary.simpleMessage(
      "3. Öffnungszeiten ⏰",
    ),
    "section_photo_optional": MessageLookupByLibrary.simpleMessage(
      "4. Foto des Ladens (optional)",
    ),
    "see_hours_photos_reviews": MessageLookupByLibrary.simpleMessage(
      "Öffnungszeiten, Fotos und Bewertungen ansehen",
    ),
    "see_place": MessageLookupByLibrary.simpleMessage("Laden ansehen"),
    "segui": MessageLookupByLibrary.simpleMessage("Folgen"),
    "segui_gia": MessageLookupByLibrary.simpleMessage("Bereits folgend"),
    "seguiti": MessageLookupByLibrary.simpleMessage("Gefolgt"),
    "select_first_kebab": MessageLookupByLibrary.simpleMessage(
      "Wähle 1. Döner",
    ),
    "select_location_first": MessageLookupByLibrary.simpleMessage(
      "Wähle zuerst den Standort auf der Karte aus! 📍",
    ),
    "select_on_map": MessageLookupByLibrary.simpleMessage(
      "Auf der Karte auswählen",
    ),
    "select_photo_first": MessageLookupByLibrary.simpleMessage(
      "Wähle vor dem Posten ein Foto aus",
    ),
    "select_place_to_review": MessageLookupByLibrary.simpleMessage(
      "Wähle den Laden aus, den du bewerten willst! 🌯",
    ),
    "select_second_kebab": MessageLookupByLibrary.simpleMessage(
      "Wähle 2. Döner",
    ),
    "select_two_kebabs_to_compare": MessageLookupByLibrary.simpleMessage(
      "Wähle zwei Döner, um den detaillierten Vergleich zu sehen.",
    ),
    "selected_point": MessageLookupByLibrary.simpleMessage(
      "Ausgewählter Punkt",
    ),
    "seleziona_il_tuo_kebab_preferito": MessageLookupByLibrary.simpleMessage(
      "Wähle deinen Lieblingskebab",
    ),
    "send_reset_email": MessageLookupByLibrary.simpleMessage(
      "E-Mail zum Zurücksetzen senden",
    ),
    "session_expired": MessageLookupByLibrary.simpleMessage(
      "Sitzung abgelaufen. Bitte melde dich erneut an.",
    ),
    "share_action": MessageLookupByLibrary.simpleMessage("Teilen"),
    "share_message": m31,
    "share_more": MessageLookupByLibrary.simpleMessage("Mehr"),
    "share_rating_line": m32,
    "share_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Diesen Kebab teilen",
    ),
    "show_all_distances": MessageLookupByLibrary.simpleMessage("Alle anzeigen"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "sign_up_with_google": MessageLookupByLibrary.simpleMessage(
      "Mit Google registrieren",
    ),
    "signup_tagline": MessageLookupByLibrary.simpleMessage(
      "Erstelle dein Profil und bewerte die Kebabs in deiner Stadt",
    ),
    "single_card": MessageLookupByLibrary.simpleMessage("Kebabbo Karte"),
    "sort_dimension": MessageLookupByLibrary.simpleMessage("Größe"),
    "sort_distance": MessageLookupByLibrary.simpleMessage("Entfernung"),
    "sort_menu": MessageLookupByLibrary.simpleMessage("Menü"),
    "sort_name": MessageLookupByLibrary.simpleMessage("Name"),
    "sort_price": MessageLookupByLibrary.simpleMessage("Preis"),
    "sort_quality": MessageLookupByLibrary.simpleMessage("Qualität"),
    "sort_stars": MessageLookupByLibrary.simpleMessage("Sterne"),
    "sovrascrivi": MessageLookupByLibrary.simpleMessage("Überschreiben"),
    "spicy": MessageLookupByLibrary.simpleMessage("Scharf"),
    "staff": MessageLookupByLibrary.simpleMessage("Personal"),
    "staff_certified": MessageLookupByLibrary.simpleMessage(
      "Kebabbo Staff Zertifiziert",
    ),
    "staff_kebabbo": MessageLookupByLibrary.simpleMessage("Kebabbo-Team"),
    "submit_review": MessageLookupByLibrary.simpleMessage("Bewertung abgeben"),
    "successfully_updated_profile": MessageLookupByLibrary.simpleMessage(
      "Profil erfolgreich aktualisiert!",
    ),
    "swipe_collection_hint": MessageLookupByLibrary.simpleMessage(
      "Wischen zum Durchsuchen der Sammlung",
    ),
    "tab_overview": MessageLookupByLibrary.simpleMessage("Übersicht"),
    "tab_photos": m33,
    "tab_reviews": m34,
    "tag_kebab_pill": MessageLookupByLibrary.simpleMessage("Kebab 🌯"),
    "tag_sandwich_pill": MessageLookupByLibrary.simpleMessage(
      "Sandwichladen 🥪",
    ),
    "tap_map_to_select": MessageLookupByLibrary.simpleMessage(
      "Tippe auf die Karte, um den genauen Punkt zu wählen",
    ),
    "tap_to_browse_album": MessageLookupByLibrary.simpleMessage(
      "Tippe, um das ganze Album anzusehen ›",
    ),
    "tap_to_open_pack": MessageLookupByLibrary.simpleMessage(
      "Tippe, um das Paket zu öffnen!",
    ),
    "tap_to_select_photo": MessageLookupByLibrary.simpleMessage(
      "Tippe, um ein Foto auszuwählen",
    ),
    "tcg_album": MessageLookupByLibrary.simpleMessage("TCG-Kartenalbum"),
    "tcg_cards_count": m35,
    "ten_posts": MessageLookupByLibrary.simpleMessage("10 Beiträge"),
    "ten_reviews": MessageLookupByLibrary.simpleMessage("10 Bewertungen"),
    "testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo":
        MessageLookupByLibrary.simpleMessage(
          "Wir testen und bewerten Kebabläden und Street Food für dich. Willkommen bei Kebabbo.",
        ),
    "testo_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Text nicht verfügbar",
    ),
    "thank_you": MessageLookupByLibrary.simpleMessage("Danke"),
    "thank_you_for_your_review": MessageLookupByLibrary.simpleMessage(
      "Vielen Dank für deine Bewertung!",
    ),
    "thirty_reviews": MessageLookupByLibrary.simpleMessage("30 Bewertungen"),
    "twenty_reviews": MessageLookupByLibrary.simpleMessage("20 Bewertungen"),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Unerwarteter Fehler aufgetreten",
    ),
    "unit_posts": MessageLookupByLibrary.simpleMessage("Posts"),
    "unit_reviews": MessageLookupByLibrary.simpleMessage("Bewertungen"),
    "unlocked_badge": MessageLookupByLibrary.simpleMessage("Freigeschaltet"),
    "unlocked_of_total": m36,
    "unpack_and_view_collection": MessageLookupByLibrary.simpleMessage(
      "Auspacken & Sammlung ansehen",
    ),
    "unpack_new_cards": MessageLookupByLibrary.simpleMessage(
      "Neue Karten auspacken",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Aktualisieren"),
    "upload": MessageLookupByLibrary.simpleMessage("Hochladen"),
    "upload_error": m37,
    "upload_first_photo": MessageLookupByLibrary.simpleMessage(
      "Erstes Foto hochladen",
    ),
    "upload_place_photo": MessageLookupByLibrary.simpleMessage(
      "Lade ein Foto vom Spieß oder vom Laden hoch",
    ),
    "user_generic": MessageLookupByLibrary.simpleMessage("Nutzer"),
    "user_no_posts_desc": MessageLookupByLibrary.simpleMessage(
      "Dieser Nutzer hat noch nichts im Feed gepostet.",
    ),
    "user_no_reviews_desc": MessageLookupByLibrary.simpleMessage(
      "Dieser Nutzer hat noch keinen Kebab bewertet.",
    ),
    "user_not_authenticated": MessageLookupByLibrary.simpleMessage(
      "Benutzer nicht authentifiziert",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage(
      "Benutzer nicht gefunden",
    ),
    "user_not_found_login_again": MessageLookupByLibrary.simpleMessage(
      "Nutzer nicht gefunden. Bitte melde dich erneut an.",
    ),
    "username_can_only_contain_letters_numbers_and_underscores":
        MessageLookupByLibrary.simpleMessage(
          "Benutzername darf nur Buchstaben,\nZahlen und Unterstriche enthalten!",
        ),
    "username_cannot_be_more_than_12_characters":
        MessageLookupByLibrary.simpleMessage(
          "Benutzername darf nicht mehr als\n12 Zeichen lang sein!",
        ),
    "username_cannot_contain_spaces_use_undescores_instead":
        MessageLookupByLibrary.simpleMessage(
          "Benutzername darf keine Leerzeichen enthalten,\nverwende stattdessen Unterstriche!",
        ),
    "username_must_be_at_least_3_characters_long":
        MessageLookupByLibrary.simpleMessage(
          "Benutzername muss mindestens 3\nZeichen lang sein!",
        ),
    "users": MessageLookupByLibrary.simpleMessage("Benutzer"),
    "users_count": m38,
    "users_review": MessageLookupByLibrary.simpleMessage("Benutzerbewertung"),
    "vegetables": MessageLookupByLibrary.simpleMessage("Gemüse"),
    "verdura": MessageLookupByLibrary.simpleMessage("Gemüse"),
    "verified_by_staff_tooltip": MessageLookupByLibrary.simpleMessage(
      "Verifiziert vom Kebabbo-Team",
    ),
    "vuoi_veramente_eliminare_il_post": MessageLookupByLibrary.simpleMessage(
      "Möchtest du den Beitrag wirklich löschen?",
    ),
    "world": MessageLookupByLibrary.simpleMessage("Welt"),
    "write_a_review_for_a_kebab_near_you": MessageLookupByLibrary.simpleMessage(
      "Schreibe eine Bewertung",
    ),
    "write_first_review": MessageLookupByLibrary.simpleMessage(
      "Erste Bewertung schreiben",
    ),
    "write_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Bewerte Qualität, Fleisch und Soßen",
    ),
    "write_review_title": MessageLookupByLibrary.simpleMessage(
      "Bewertung schreiben",
    ),
    "yes_create_new": MessageLookupByLibrary.simpleMessage("Ja, neu erstellen"),
    "yogurt": MessageLookupByLibrary.simpleMessage("Joghurt"),
    "you_can_access_reviews_at_any_time_from_your_account":
        MessageLookupByLibrary.simpleMessage(
          "Du kannst jederzeit über dein Konto auf Bewertungen zugreifen.",
        ),
    "your_experience": MessageLookupByLibrary.simpleMessage("Deine Erfahrung"),
    "your_kebab": MessageLookupByLibrary.simpleMessage("Dein Kebab"),
    "your_medals_title": MessageLookupByLibrary.simpleMessage(
      "Deine Medaillen",
    ),
    "your_profile": MessageLookupByLibrary.simpleMessage("Dein Profil"),
    "your_review_optional": MessageLookupByLibrary.simpleMessage(
      "Deine Bewertung (optional)",
    ),
  };
}
