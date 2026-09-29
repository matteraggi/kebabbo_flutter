// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(name) => "Aggiungi Foto a ${name}";

  static String m1(name) => "${name} (Già in Collezione)";

  static String m2(error) => "Si è verificato un errore: ${error}";

  static String m3(count) => "Basato su ${count} recensioni";

  static String m4(current, total) => "#${current} di ${total}";

  static String m5(style) => "Cambia mappa: ${style}";

  static String m6(city) => "Città: ${city}";

  static String m7(count) => "Community (${count})";

  static String m8(results) => "10 km (${results} risultati)";

  static String m9(results) => "1 km (${results} risultati)";

  static String m10(results) => "200 metri (${results} risultati)";

  static String m11(results) => "500 metri (${results} risultati)";

  static String m12(results) => "Illimitato (${results} risultati)";

  static String m13(error) =>
      "Errore durante l\'eliminazione del post: ${error}";

  static String m14(error) => "Errore durante il salvataggio: ${error}";

  static String m15(error) => "Errore invio recensione: ${error}";

  static String m16(count) => "Tutte (${count})";

  static String m17(count) => "Recensioni (${count})";

  static String m18(count) => "Sbloccate (${count})";

  static String m19(missing, unit) =>
      "Ti mancano solo ${missing} ${unit} per sbloccare questa medaglia!";

  static String m20(count) => "${count} mancanti";

  static String m21(time) => "Prossima ricarica tra ${time}";

  static String m22(hours, minutes) =>
      "Nessun pacchetto pronto al momento (0/2). Il prossimo pacchetto sarà pronto tra ${hours}h e ${minutes}m.";

  static String m23(time) =>
      "Nessun pacchetto pronto. Il prossimo sarà disponibile tra ${time}.";

  static String m24(count) => "Apri 2° Pacchetto (${count})";

  static String m25(error) => "Reimpostazione password non riuscita: ${error}";

  static String m26(percent) => "${percent}% completato";

  static String m27(time) => "Ricarica in corso: prossimo tra ${time}";

  static String m28(count) => "${count} rimanenti";

  static String m29(
    kebabName,
    qualityRating,
    quantityRating,
    menuRating,
    priceRating,
    funRating,
    description,
  ) =>
      "Ho appena recensito il kebab da ${kebabName}!\n\nQualità: ${qualityRating}\nQuantità: ${quantityRating}\nMenu: ${menuRating}\nPrezzo: ${priceRating}\nDivertimento: ${funRating}\n\n${description}";

  static String m30(count) => "Foto (${count})";

  static String m31(count) => "Recensioni (${count})";

  static String m32(unlocked, total) => "${unlocked} su ${total} sbloccate";

  static String m33(error) => "Errore durante il caricamento: ${error}";

  static String m34(count) => "Utenti (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accedi_per_cercare": MessageLookupByLibrary.simpleMessage(
      "Accedi per pubblicare e vedere le informazioni delle persone",
    ),
    "add_dish_photo_optional": MessageLookupByLibrary.simpleMessage(
      "Aggiungi Foto al Piatto (Opzionale)",
    ),
    "add_kebab": MessageLookupByLibrary.simpleMessage("Aggiungi un Kebab"),
    "add_kebab_place": MessageLookupByLibrary.simpleMessage(
      "Aggiungi un Kebabbaro",
    ),
    "add_kebab_place_subtitle": MessageLookupByLibrary.simpleMessage(
      "Inserisci un nuovo locale sulla mappa",
    ),
    "add_kebab_to_kebabbo": MessageLookupByLibrary.simpleMessage(
      "Aggiungi Kebabbaro a Kebabbo",
    ),
    "add_new_kebab_confirmation": MessageLookupByLibrary.simpleMessage(
      "Stai per aggiungere \"\$name\" come nuovo kebab. Sei sicuro che non sia già presente?",
    ),
    "add_photo_to": m0,
    "add_review_appbar_title": MessageLookupByLibrary.simpleMessage(
      "Aggiungi Recensione",
    ),
    "add_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Hai provato un nuovo kebab?",
    ),
    "add_review_title": MessageLookupByLibrary.simpleMessage(
      "Aggiungi Recensione",
    ),
    "add_to_collection": MessageLookupByLibrary.simpleMessage(
      "Aggiungi alla Collezione",
    ),
    "added_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Aggiunto ai preferiti ❤️",
    ),
    "advanced_filters": MessageLookupByLibrary.simpleMessage("Filtri avanzati"),
    "all_filter": MessageLookupByLibrary.simpleMessage("Tutti"),
    "all_found": MessageLookupByLibrary.simpleMessage("Tutte trovate! 🏆"),
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Hai già un account? Accedi",
    ),
    "already_in_collection": m1,
    "an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Si è verificato un errore",
    ),
    "an_error_occurred_with": m2,
    "annulla": MessageLookupByLibrary.simpleMessage("Annulla"),
    "anonimo": MessageLookupByLibrary.simpleMessage("Anonimo"),
    "aperti_ora": MessageLookupByLibrary.simpleMessage("Aperti ora"),
    "aperto": MessageLookupByLibrary.simpleMessage("Aperto"),
    "app_is_installed": MessageLookupByLibrary.simpleMessage(
      "Kebabbo è anche un\'app!",
    ),
    "app_is_installed_description": MessageLookupByLibrary.simpleMessage(
      "Aprilo nell\'app per un\'esperienza migliore. Se non ce l\'hai ancora, ti portiamo su Google Play.",
    ),
    "autenticazione_necessaria": MessageLookupByLibrary.simpleMessage(
      "Devi essere autenticato per commentare.",
    ),
    "back_to_build": MessageLookupByLibrary.simpleMessage(
      "Torna alla costruzione",
    ),
    "based_on_reviews": m3,
    "build_button": MessageLookupByLibrary.simpleMessage("Costruisci!"),
    "build_your_kebab": MessageLookupByLibrary.simpleMessage(
      "Costruisci il tuo Kebab",
    ),
    "by_signing_in_you_agree_to_our_terms_and_privacy_policy":
        MessageLookupByLibrary.simpleMessage(
          "Accedendo, accetti i nostri termini e la nostra politica sulla privacy.",
        ),
    "cambia_profilepic": MessageLookupByLibrary.simpleMessage(
      "Cambia foto profilo",
    ),
    "cambia_profilo": MessageLookupByLibrary.simpleMessage("Cambia profilo"),
    "cambia_username": MessageLookupByLibrary.simpleMessage("Cambia Username"),
    "cancel": MessageLookupByLibrary.simpleMessage("Annulla"),
    "card_collection": MessageLookupByLibrary.simpleMessage("Collezione Carte"),
    "card_x_of_y": m4,
    "cards_unlocked": MessageLookupByLibrary.simpleMessage("carte sbloccate"),
    "center_on_my_location": MessageLookupByLibrary.simpleMessage(
      "Centra sulla mia posizione",
    ),
    "cerca_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Cerca un kebabbaro...",
    ),
    "cerca_utenti": MessageLookupByLibrary.simpleMessage("Cerca utenti..."),
    "change": MessageLookupByLibrary.simpleMessage("Cambia"),
    "change_map_style": m5,
    "check_your_email_for_a_login_link": MessageLookupByLibrary.simpleMessage(
      "Controlla la tua email per un link di accesso!",
    ),
    "check_your_email_for_a_reset_link": MessageLookupByLibrary.simpleMessage(
      "Controlla la tua email per un link di reimpostazione",
    ),
    "check_your_email_for_a_verification_link":
        MessageLookupByLibrary.simpleMessage(
          "Controlla la tua email per un link di verifica",
        ),
    "chiuso": MessageLookupByLibrary.simpleMessage("Chiuso"),
    "choose_on_map_recommended": MessageLookupByLibrary.simpleMessage(
      "Scegli sulla Mappa (Consigliato)",
    ),
    "choose_place": MessageLookupByLibrary.simpleMessage("Scegli il Kebabbaro"),
    "cipolla": MessageLookupByLibrary.simpleMessage("Cipolla"),
    "city": MessageLookupByLibrary.simpleMessage("Città"),
    "city_label": m6,
    "close": MessageLookupByLibrary.simpleMessage("Chiudi"),
    "collection_subtitle": MessageLookupByLibrary.simpleMessage(
      "controlla le tue kebabbo cards",
    ),
    "collection_title": MessageLookupByLibrary.simpleMessage("Collezione"),
    "comment_review_hint": MessageLookupByLibrary.simpleMessage(
      "Cosa ti è piaciuto di più? Consigli qualche salsa o menù?",
    ),
    "comment_review_label": MessageLookupByLibrary.simpleMessage(
      "Commento / Recensione *",
    ),
    "comment_review_required": MessageLookupByLibrary.simpleMessage(
      "Scrivi un breve commento sulla tua esperienza",
    ),
    "commento_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Commento non disponibile",
    ),
    "commento_vuoto": MessageLookupByLibrary.simpleMessage(
      "Il testo del commento non può essere vuoto.",
    ),
    "community_count": m7,
    "community_review": MessageLookupByLibrary.simpleMessage(
      "Recensione Community",
    ),
    "community_upload": MessageLookupByLibrary.simpleMessage("Community"),
    "completed_badge": MessageLookupByLibrary.simpleMessage("Completato! ⭐"),
    "conferma_eliminazione": MessageLookupByLibrary.simpleMessage(
      "Conferma eliminazione",
    ),
    "confirm_this_location": MessageLookupByLibrary.simpleMessage(
      "Conferma Questa Posizione",
    ),
    "congratulazioni": MessageLookupByLibrary.simpleMessage("Congratulazioni!"),
    "consigliaci_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Consigliaci un kebabbaro",
    ),
    "contribute_subtitle": MessageLookupByLibrary.simpleMessage(
      "Aiutaci a mappare e recensire i migliori kebabbari!",
    ),
    "contribute_title": MessageLookupByLibrary.simpleMessage(
      "Contribuisci a Kebabbo",
    ),
    "cooking_step_1": MessageLookupByLibrary.simpleMessage(
      "🔥 Scaldo la piadina...",
    ),
    "cooking_step_2": MessageLookupByLibrary.simpleMessage(
      "🥩 Taglio la carne allo spiedo...",
    ),
    "cooking_step_3": MessageLookupByLibrary.simpleMessage(
      "🥗 Aggiungo verdure fresche e salse...",
    ),
    "cooking_step_4": MessageLookupByLibrary.simpleMessage(
      "🌯 Arrotolo a regola d\'arte...",
    ),
    "cooking_step_5": MessageLookupByLibrary.simpleMessage(
      "🔍 Cerco il miglior kebab per te...",
    ),
    "cooking_title": MessageLookupByLibrary.simpleMessage("Preparazione Kebab"),
    "cooking_title_reroll": MessageLookupByLibrary.simpleMessage(
      "Ricerca Alternativa",
    ),
    "could_not_open_link": MessageLookupByLibrary.simpleMessage(
      "Impossibile aprire il link.",
    ),
    "create_kebab_subtitle": MessageLookupByLibrary.simpleMessage(
      "crea il tuo kebab",
    ),
    "create_kebab_title": MessageLookupByLibrary.simpleMessage("Crea il Kebab"),
    "custom_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Imposta gli orari per ciascun giorno (es. 11:00-23:00 oppure \"chiuso\"):",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Descrizione"),
    "description_is_required": MessageLookupByLibrary.simpleMessage(
      "La descrizione è obbligatoria",
    ),
    "description_review_hint": MessageLookupByLibrary.simpleMessage(
      "Racconta com\'è questo kebab: pane, carne, sapori...",
    ),
    "description_review_label": MessageLookupByLibrary.simpleMessage(
      "Descrizione / Recensione *",
    ),
    "description_review_required": MessageLookupByLibrary.simpleMessage(
      "Scrivi un breve commento per presentare il kebabbaro",
    ),
    "descrizione_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Descrizione non disponibile",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Dettagli"),
    "devi_essere_autenticato_per_commentare":
        MessageLookupByLibrary.simpleMessage("Devi accedere per commentare"),
    "devi_essere_autenticato_per_mettere_mi_piace":
        MessageLookupByLibrary.simpleMessage(
          "Devi accedere per mettere mi piace",
        ),
    "devi_essere_autenticato_per_postare": MessageLookupByLibrary.simpleMessage(
      "Devi essere autenticato per postare",
    ),
    "devi_essere_autenticato_per_visualizzare_il_profilo":
        MessageLookupByLibrary.simpleMessage(
          "Devi accedere per visualizzare il profilo",
        ),
    "dimension": MessageLookupByLibrary.simpleMessage("Dimensione"),
    "directions": MessageLookupByLibrary.simpleMessage("Indicazioni"),
    "distanceLabel10km": m8,
    "distanceLabel1km": m9,
    "distanceLabel200m": m10,
    "distanceLabel500m": m11,
    "distanceLabelUnlimited": m12,
    "distanza_massima": MessageLookupByLibrary.simpleMessage(
      "Distanza Massima",
    ),
    "distanza_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Distanza non disponibile",
    ),
    "dont_have_an_account_sign_up": MessageLookupByLibrary.simpleMessage(
      "Non hai un account? Registrati",
    ),
    "drag_to_tilt": MessageLookupByLibrary.simpleMessage(
      "Trascina con il dito per inclinare in 3D",
    ),
    "duplicate_card": MessageLookupByLibrary.simpleMessage("CARTA DOPPIONE"),
    "edit_location_on_map": MessageLookupByLibrary.simpleMessage(
      "Modifica Posizione sulla Mappa",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Modifica profilo"),
    "elimina": MessageLookupByLibrary.simpleMessage("Elimina"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_required": MessageLookupByLibrary.simpleMessage(
      "L\'email è obbligatoria",
    ),
    "enter_place_name": MessageLookupByLibrary.simpleMessage(
      "Inserisci il nome del locale",
    ),
    "error_adding_review": MessageLookupByLibrary.simpleMessage(
      "Errore durante l\'aggiunta della recensione: ",
    ),
    "error_deleting_post": m13,
    "error_loading_kebabs": MessageLookupByLibrary.simpleMessage(
      "Errore nel caricare i kebab: ",
    ),
    "error_processing_image": MessageLookupByLibrary.simpleMessage(
      "Errore durante l\'elaborazione dell\'immagine:",
    ),
    "error_saving": m14,
    "error_sending_review": m15,
    "errore": MessageLookupByLibrary.simpleMessage("Errore:"),
    "errore_nel_caricamento_dei_follower": MessageLookupByLibrary.simpleMessage(
      "Errore nel caricamento dei follower",
    ),
    "errore_nel_caricamento_dellimage": MessageLookupByLibrary.simpleMessage(
      "Errore nel caricamento dell\'immagine:",
    ),
    "esplora": MessageLookupByLibrary.simpleMessage("Esplora"),
    "examine_3d": MessageLookupByLibrary.simpleMessage("Esamina in 3D"),
    "extract": MessageLookupByLibrary.simpleMessage("Estrai"),
    "failed_to_load_favorites": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare i preferiti",
    ),
    "failed_to_load_follower_count": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare il conteggio dei follower",
    ),
    "failed_to_load_medals": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare le medaglie",
    ),
    "failed_to_load_post_count": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare il conteggio dei post",
    ),
    "failed_to_load_posts": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare i post",
    ),
    "failed_to_load_profile": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare il profilo",
    ),
    "failed_to_load_reviews_count": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare il conteggio delle recensioni",
    ),
    "failed_to_update_follow_status": MessageLookupByLibrary.simpleMessage(
      "Impossibile aggiornare lo stato del follow",
    ),
    "failed_to_upload_avatar": MessageLookupByLibrary.simpleMessage(
      "Impossibile caricare l\'avatar",
    ),
    "feed_posts_label": MessageLookupByLibrary.simpleMessage("Post Feed"),
    "fifty_posts": MessageLookupByLibrary.simpleMessage("50 post"),
    "filter_all_count": m16,
    "filter_by_distance": MessageLookupByLibrary.simpleMessage(
      "Filtra per distanza",
    ),
    "filter_reviews_count": m17,
    "filter_unlocked_count": m18,
    "first_pack_slot": MessageLookupByLibrary.simpleMessage("1° Pacchetto"),
    "first_time_description": MessageLookupByLibrary.simpleMessage(
      "Benvenuto su Kebabbo! Cosa puoi fare qui?\nBeh, puoi esplorare le nostre professionalissime recensioni di kebab o dare un\'occhiata a quelle di altri utenti.\nAggiungi la tua recensione scansionando l\'adesivo di Kebabbo davanti al kebabbaro stesso.\nDai un\'occhiata ai profili e ai post di altri utenti, connettiti con altri amanti del kebab e guadagna medaglie utilizzando l\'app.\nUsa le nostre funzioni di ricerca e filtraggio o il nostro potente strumento di creazione del kebab perfetto, o esplora la nostra mappa interattiva per scoprire gemme nelle vicinanze.\nDivertiti e kebabba!",
    ),
    "first_time_title": MessageLookupByLibrary.simpleMessage(
      "Benvenuto su Kebabbo!",
    ),
    "five_posts": MessageLookupByLibrary.simpleMessage("5 post"),
    "five_reviews": MessageLookupByLibrary.simpleMessage("5 recensioni"),
    "followed_filter": MessageLookupByLibrary.simpleMessage("Seguiti"),
    "followers": MessageLookupByLibrary.simpleMessage("Followers"),
    "following": MessageLookupByLibrary.simpleMessage("Seguiti"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "Password dimenticata",
    ),
    "found_all_cards": MessageLookupByLibrary.simpleMessage(
      "Tutte le carte trovate.",
    ),
    "fun": MessageLookupByLibrary.simpleMessage("Divertimento"),
    "fun_exclamation": MessageLookupByLibrary.simpleMessage("fun!"),
    "games_tools_title": MessageLookupByLibrary.simpleMessage(
      "Giochi & Strumenti",
    ),
    "generic_error": MessageLookupByLibrary.simpleMessage("Errore: "),
    "gluten_free": MessageLookupByLibrary.simpleMessage("Senza Glutine"),
    "gluten_free_option": MessageLookupByLibrary.simpleMessage(
      "Opzione Senza Glutine",
    ),
    "gluten_free_option_desc": MessageLookupByLibrary.simpleMessage(
      "Dispone di piadina o opzioni certificate gluten-free",
    ),
    "go_back": MessageLookupByLibrary.simpleMessage("Indietro"),
    "goal_reached": MessageLookupByLibrary.simpleMessage(
      "Traguardo Raggiunto 🎉",
    ),
    "google_maps_link": MessageLookupByLibrary.simpleMessage(
      "Link Google Maps",
    ),
    "hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia":
        MessageLookupByLibrary.simpleMessage(
          "Hai raggiunto un nuovo traguardo e ottenuto una nuova medaglia!",
        ),
    "hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo":
        MessageLookupByLibrary.simpleMessage(
          "Hai ricevuto una nuova medaglia per il tuo contributo!",
        ),
    "have_account_question": MessageLookupByLibrary.simpleMessage(
      "Hai già un account?",
    ),
    "hours_none_note": MessageLookupByLibrary.simpleMessage(
      "Nessun orario verrà salvato.",
    ),
    "hours_preset_continuous": MessageLookupByLibrary.simpleMessage(
      "Continuato (11-23) 🌯",
    ),
    "hours_preset_custom": MessageLookupByLibrary.simpleMessage(
      "Personalizzati ⚙️",
    ),
    "hours_preset_lunch_dinner": MessageLookupByLibrary.simpleMessage(
      "Pranzo e Cena 🍽️",
    ),
    "hours_preset_night": MessageLookupByLibrary.simpleMessage(
      "Notturno (11-02) 🌙",
    ),
    "hours_preset_none": MessageLookupByLibrary.simpleMessage(
      "Non specificati (Standard)",
    ),
    "i_tuoi_post": MessageLookupByLibrary.simpleMessage("I tuoi Post"),
    "il_commento_e_stato_aggiunto_con_successo":
        MessageLookupByLibrary.simpleMessage(
          "Il commento è stato aggiunto con successo!",
        ),
    "il_kebab_che_ti_raccomandiamo_e": MessageLookupByLibrary.simpleMessage(
      "Il tuo match è:",
    ),
    "il_testo_non_puo_essere_vuoto": MessageLookupByLibrary.simpleMessage(
      "Il testo non può essere vuoto",
    ),
    "in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google":
        MessageLookupByLibrary.simpleMessage(
          "In Italia il mondo del Kebab è ancora un mondo oscuro. I migliori locali sono sottovalutati, e i peggiori ricevono recensioni alte su Google.",
        ),
    "in_progress": MessageLookupByLibrary.simpleMessage("In Corso ⏳"),
    "ingredient_amounts_caps": MessageLookupByLibrary.simpleMessage(
      "QUANTITÀ INGREDIENTI",
    ),
    "ingredient_balance": MessageLookupByLibrary.simpleMessage(
      "Bilanciamento Ingredienti",
    ),
    "ingredient_balance_1_10": MessageLookupByLibrary.simpleMessage(
      "Bilanciamento Ingredienti (1 a 10)",
    ),
    "inserted_by": MessageLookupByLibrary.simpleMessage("Inserito da"),
    "invia": MessageLookupByLibrary.simpleMessage("Invia"),
    "it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again":
        MessageLookupByLibrary.simpleMessage(
          "Sembra che la recensione a cui stai cercando di accedere non esista. Controlla il link e riprova.",
        ),
    "kebab_already_exists": MessageLookupByLibrary.simpleMessage(
      "Kebab già esistente",
    ),
    "kebab_consigliato": MessageLookupByLibrary.simpleMessage(
      "Kebab consigliato",
    ),
    "kebab_no_longer_available": MessageLookupByLibrary.simpleMessage(
      "Kebab non più disponibile",
    ),
    "kebab_not_found": MessageLookupByLibrary.simpleMessage(
      "Kebab non trovato",
    ),
    "kebab_place_name_hint": MessageLookupByLibrary.simpleMessage(
      "Es. Bella Istanbul 3",
    ),
    "kebab_place_name_label": MessageLookupByLibrary.simpleMessage(
      "Nome del Kebabbaro *",
    ),
    "kebab_place_not_found": MessageLookupByLibrary.simpleMessage(
      "Kebabbaro non trovato o rimosso.",
    ),
    "kebab_sconosciuto": MessageLookupByLibrary.simpleMessage(
      "Kebab Sconosciuto",
    ),
    "kebab_tag": MessageLookupByLibrary.simpleMessage("Kebab"),
    "kebabbo_review": MessageLookupByLibrary.simpleMessage(
      "Recensione Kebabbo",
    ),
    "kebabbo_staff_review": MessageLookupByLibrary.simpleMessage(
      "La recensione di Kebabbo",
    ),
    "kebabbo_user": MessageLookupByLibrary.simpleMessage("Utente Kebabbo"),
    "km_distante_da_te": MessageLookupByLibrary.simpleMessage(
      "km distante da te",
    ),
    "la_tua_soluzione_per_il_pranzo_universitario":
        MessageLookupByLibrary.simpleMessage(
          "La tua soluzione per il pranzo universitario",
        ),
    "legends": MessageLookupByLibrary.simpleMessage("Leggende"),
    "location_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Permesso di localizzazione negato.",
    ),
    "location_permission_denied_forever": MessageLookupByLibrary.simpleMessage(
      "Permesso di localizzazione negato in modo permanente. Puoi attivarlo dalle impostazioni.",
    ),
    "location_selected": MessageLookupByLibrary.simpleMessage(
      "Posizione selezionata",
    ),
    "location_services_disabled": MessageLookupByLibrary.simpleMessage(
      "I servizi di localizzazione sono disattivati.",
    ),
    "log_in_con_google": MessageLookupByLibrary.simpleMessage(
      "Accedi con Google",
    ),
    "logged_in": MessageLookupByLibrary.simpleMessage("Accesso effettuato"),
    "login": MessageLookupByLibrary.simpleMessage("Accedi"),
    "login_required_section": MessageLookupByLibrary.simpleMessage(
      "Devi effettuare l\'accesso per usare questa sezione.",
    ),
    "login_tagline": MessageLookupByLibrary.simpleMessage(
      "Entra nella community per scoprire e recensire i migliori kebab",
    ),
    "login_to_post_photos": MessageLookupByLibrary.simpleMessage(
      "Effettua il login per pubblicare foto",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "map_not_available": MessageLookupByLibrary.simpleMessage(
      "Mappa non disponibile per questo kebabbaro",
    ),
    "map_style_google_road": MessageLookupByLibrary.simpleMessage(
      "Google Stradale",
    ),
    "map_style_google_satellite": MessageLookupByLibrary.simpleMessage(
      "Google Satellite",
    ),
    "map_style_road_short": MessageLookupByLibrary.simpleMessage("Stradale"),
    "map_style_satellite_short": MessageLookupByLibrary.simpleMessage(
      "Satellite",
    ),
    "mappa": MessageLookupByLibrary.simpleMessage("Mappa"),
    "maps_link_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordinate rilevate con successo dal link Maps! 📍",
    ),
    "maps_link_failed": MessageLookupByLibrary.simpleMessage(
      "Impossibile estrarre le coordinate dal link. Usa \"Scegli sulla Mappa\".",
    ),
    "maps_link_name_and_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordinate e nome rilevati dal link Maps! 📍",
    ),
    "max_charge_reached": MessageLookupByLibrary.simpleMessage(
      "Carica massima raggiunta (1 ogni 12h)",
    ),
    "meat": MessageLookupByLibrary.simpleMessage("Carne"),
    "medal_0_desc": MessageLookupByLibrary.simpleMessage(
      "Hai scritto la tua prima recensione di un kebabbaro. Benvenuto nella famiglia dei critici di Kebabbo!",
    ),
    "medal_0_title": MessageLookupByLibrary.simpleMessage("Primo Assaggio"),
    "medal_1_desc": MessageLookupByLibrary.simpleMessage(
      "Hai recensito 5 locali diversi. Il tuo palato comincia a distinguere la vera arte dello spiedo!",
    ),
    "medal_1_title": MessageLookupByLibrary.simpleMessage(
      "Assaggiatore Seriale",
    ),
    "medal_2_desc": MessageLookupByLibrary.simpleMessage(
      "10 recensioni completate! Le tue valutazioni guidano i kebabbari e orientano tutta la community.",
    ),
    "medal_2_title": MessageLookupByLibrary.simpleMessage("Critico del Kebab"),
    "medal_3_desc": MessageLookupByLibrary.simpleMessage(
      "20 recensioni scritte! Nessun rotolo, salsa o pane arabo ha più segreti per te. Un vero maestro!",
    ),
    "medal_3_title": MessageLookupByLibrary.simpleMessage(
      "Maestro dello Spiedo",
    ),
    "medal_4_desc": MessageLookupByLibrary.simpleMessage(
      "30 recensioni all\'attivo! Hai raggiunto i vertici dell\'esperienza culinaria di Kebabbo. Una vera leggenda vivente!",
    ),
    "medal_4_title": MessageLookupByLibrary.simpleMessage(
      "Leggenda Gastronomica",
    ),
    "medal_5_desc": MessageLookupByLibrary.simpleMessage(
      "Hai pubblicato il tuo primo post nel feed sociale. La tua passione per il kebab ora è pubblica!",
    ),
    "medal_5_title": MessageLookupByLibrary.simpleMessage("Voce del Feed"),
    "medal_6_desc": MessageLookupByLibrary.simpleMessage(
      "Hai condiviso 5 post con foto e pensieri nel feed. La community adora i tuoi aggiornamenti!",
    ),
    "medal_6_title": MessageLookupByLibrary.simpleMessage("Reporter del Gusto"),
    "medal_7_desc": MessageLookupByLibrary.simpleMessage(
      "10 post condivisi! Con i tuoi scatti e i tuoi tag ai locali scateni la fame di tutta la città.",
    ),
    "medal_7_title": MessageLookupByLibrary.simpleMessage(
      "Influencer del Kebab",
    ),
    "medal_8_desc": MessageLookupByLibrary.simpleMessage(
      "50 post nella community! Sei un pilastro insostituibile del social feed di Kebabbo!",
    ),
    "medal_8_title": MessageLookupByLibrary.simpleMessage("Pilastro Sociale"),
    "medal_missing": m19,
    "medals_page_title": MessageLookupByLibrary.simpleMessage(
      "Medagliere & Traguardi",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "missing_count": m20,
    "more_info": MessageLookupByLibrary.simpleMessage(
      "Come recensire un kebab",
    ),
    "my_cards": MessageLookupByLibrary.simpleMessage("Collezione Kebab TCG"),
    "name_autofilled_helper": MessageLookupByLibrary.simpleMessage(
      "Compilato automaticamente dalla mappa (modificalo pure)",
    ),
    "name_label": MessageLookupByLibrary.simpleMessage("Nome"),
    "nav_account": MessageLookupByLibrary.simpleMessage("Account"),
    "nav_add": MessageLookupByLibrary.simpleMessage("Aggiungi"),
    "nav_feed": MessageLookupByLibrary.simpleMessage("Feed"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Home"),
    "nessun_commento_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nessun commento disponibile",
    ),
    "nessun_kebab_corrispondente_trovato_nel_raggio_selezionato":
        MessageLookupByLibrary.simpleMessage(
          "Nessun kebab corrispondente trovato nel raggio selezionato",
        ),
    "nessun_kebab_tra_i_preferiti": MessageLookupByLibrary.simpleMessage(
      "Nessun kebab tra i preferiti",
    ),
    "nessun_kebab_vicino_a_te": MessageLookupByLibrary.simpleMessage(
      "Nessun kebab vicino a te \nDevi essere in prossimità del kebabbaro per recensirlo per ragioni di autenticità.\nControlla la tua posizione e ricarica la pagina.",
    ),
    "nessun_kebabbaro_presente": MessageLookupByLibrary.simpleMessage(
      "Nessun Kebabbaro presente :(",
    ),
    "nessun_post_trovato": MessageLookupByLibrary.simpleMessage(
      "Nessun post trovato",
    ),
    "nessun_utente_seguito": MessageLookupByLibrary.simpleMessage(
      "Nessun utente seguito",
    ),
    "nessun_utente_ti_segue": MessageLookupByLibrary.simpleMessage(
      "Nessun utente ti segue",
    ),
    "nessuna_recensione_ancora": MessageLookupByLibrary.simpleMessage(
      "Nessuna recensione ancora",
    ),
    "nessuna_recensione_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nessuna recensione disponibile",
    ),
    "new_card_unlocked": MessageLookupByLibrary.simpleMessage(
      "NUOVA CARTA SBLOCCATA!",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("Nuova Password"),
    "next_recharge_in": m21,
    "no_account_question": MessageLookupByLibrary.simpleMessage(
      "Non hai un account?",
    ),
    "no_cards_available": MessageLookupByLibrary.simpleMessage(
      "Nessuna carta disponibile nel database.",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "Non hai ancora nessuna carta",
    ),
    "no_image": MessageLookupByLibrary.simpleMessage("Nessuna immagine"),
    "no_medals_in_filter": MessageLookupByLibrary.simpleMessage(
      "Nessuna medaglia in questo filtro",
    ),
    "no_more_kebabs_to_recommend": MessageLookupByLibrary.simpleMessage(
      "Non ci sono altri kebab disponibili da consigliare.",
    ),
    "no_pack_ready": MessageLookupByLibrary.simpleMessage(
      "Nessun pacchetto pronto",
    ),
    "no_pack_ready_hours_minutes": m22,
    "no_pack_ready_timer": m23,
    "no_photos_yet": MessageLookupByLibrary.simpleMessage(
      "Nessuna foto ancora",
    ),
    "no_photos_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Sii il primo a condividere una foto della tua piadina o del tuo piatto in questo locale!",
    ),
    "no_place_found_add_it": MessageLookupByLibrary.simpleMessage(
      "Nessun locale trovato. Se è nuovo, usa \"Aggiungi un Kebabbaro\"!",
    ),
    "no_reviews_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Condividi la tua esperienza in questo kebabbaro con tutta la community!",
    ),
    "no_suggestions_available": MessageLookupByLibrary.simpleMessage(
      "Nessun suggerimento disponibile",
    ),
    "no_thanks": MessageLookupByLibrary.simpleMessage("No, grazie"),
    "no_user_reviews_yet": MessageLookupByLibrary.simpleMessage(
      "Nessun utente ha ancora recensito questo locale!",
    ),
    "nome_del_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Nome del kebabbaro",
    ),
    "nome_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nome non disponibile",
    ),
    "non_segui_ancora_nessuno": MessageLookupByLibrary.simpleMessage(
      "Non segui ancora nessuno",
    ),
    "nuova_medaglia": MessageLookupByLibrary.simpleMessage("Nuova Medaglia!"),
    "nuovo_username": MessageLookupByLibrary.simpleMessage("Nuovo username..."),
    "objectives": MessageLookupByLibrary.simpleMessage("Obiettivi"),
    "objectives_and_medals": MessageLookupByLibrary.simpleMessage(
      "Obiettivi & Medaglie",
    ),
    "one_post": MessageLookupByLibrary.simpleMessage("1 post"),
    "one_review": MessageLookupByLibrary.simpleMessage("1 recensione"),
    "onion": MessageLookupByLibrary.simpleMessage("Cipolla"),
    "oops_review_not_found": MessageLookupByLibrary.simpleMessage(
      "Oops! Recensione non trovata",
    ),
    "open_in_app": MessageLookupByLibrary.simpleMessage("Apri l\'app"),
    "open_now": MessageLookupByLibrary.simpleMessage("Aperti ora"),
    "open_pack": MessageLookupByLibrary.simpleMessage("Apri Pacchetto"),
    "open_pack_two_ready": MessageLookupByLibrary.simpleMessage(
      "Apri Pacchetto (2 Pronti!)",
    ),
    "open_second_pack": m24,
    "opening_hours": MessageLookupByLibrary.simpleMessage("Orari di Apertura"),
    "opening_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Puoi lasciarli non specificati come standard, oppure scegliere un template o impostarli personalizzati:",
    ),
    "opening_in_progress": MessageLookupByLibrary.simpleMessage(
      "Apertura in corso...",
    ),
    "or_continue_with_email": MessageLookupByLibrary.simpleMessage(
      "oppure con email",
    ),
    "order_by": MessageLookupByLibrary.simpleMessage("Ordina per"),
    "overall_rating_1_5": MessageLookupByLibrary.simpleMessage(
      "Valutazione Generale (1 a 5)",
    ),
    "pack": MessageLookupByLibrary.simpleMessage("Pacchetto Kebabbo"),
    "pack_button_subtitle": MessageLookupByLibrary.simpleMessage(
      "spacchetta il tuo kebab preferito",
    ),
    "pack_button_title": MessageLookupByLibrary.simpleMessage("Pacchetto"),
    "pack_too_soon": MessageLookupByLibrary.simpleMessage(
      "Questo pacchetto non è ancora disponibile",
    ),
    "packs_full": MessageLookupByLibrary.simpleMessage(
      "Pacchetti ricaricati al massimo: 2 / 2 pronti! 📦✨",
    ),
    "packs_ready_0": MessageLookupByLibrary.simpleMessage(
      "0 / 2 Pacchetti disponibili",
    ),
    "packs_ready_1": MessageLookupByLibrary.simpleMessage(
      "1 / 2 Pacchetto pronto da aprire",
    ),
    "packs_ready_2": MessageLookupByLibrary.simpleMessage(
      "2 / 2 Pacchetti pronti da aprire",
    ),
    "page_not_found": MessageLookupByLibrary.simpleMessage(
      "Pagina non trovata",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_minimum_length": MessageLookupByLibrary.simpleMessage(
      "La password deve essere di almeno 6 caratteri",
    ),
    "password_must_be_at_least_6_characters":
        MessageLookupByLibrary.simpleMessage(
          "La password deve essere di almeno 6 caratteri",
        ),
    "password_reset_failed": m25,
    "password_reset_success": MessageLookupByLibrary.simpleMessage(
      "Reimpostazione password riuscita",
    ),
    "paste_maps_link_prompt": MessageLookupByLibrary.simpleMessage(
      "Hai già un link di Google Maps? Incollalo qui",
    ),
    "per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab":
        MessageLookupByLibrary.simpleMessage(
          "Per questo ci siamo noi: studenti universitari, come voi, con anni di esperienza come mangiatori di Kebab.",
        ),
    "percent_completed": m26,
    "photo": MessageLookupByLibrary.simpleMessage("Foto"),
    "photo_added": MessageLookupByLibrary.simpleMessage(
      "Foto aggiunta con successo! 📸",
    ),
    "photo_caption_hint": MessageLookupByLibrary.simpleMessage(
      "Scrivi un commento o descrivi il tuo kebab...",
    ),
    "please_enter_a_password": MessageLookupByLibrary.simpleMessage(
      "Inserisci una password",
    ),
    "please_enter_a_valid_email": MessageLookupByLibrary.simpleMessage(
      "Inserisci un\'email valida",
    ),
    "please_enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Inserisci la tua email",
    ),
    "please_fill_in_all_fields": MessageLookupByLibrary.simpleMessage(
      "Compila tutti i campi",
    ),
    "please_log_in_to_submit_your_review": MessageLookupByLibrary.simpleMessage(
      "Accedi per inviare la tua recensione",
    ),
    "popup_description": MessageLookupByLibrary.simpleMessage(
      "Per garantire l\'autenticità delle recensioni degli utenti, per recensire tu stesso il kebab,\ndovrai recarti di persona e trovare l\'adesivo Kebabbo apposto nelle vicinanze del kebabbaro,\nscansionandolo verrai indirizzato alla pagina della recensione.",
    ),
    "popup_title": MessageLookupByLibrary.simpleMessage(
      "Come scrivere la tua recensione",
    ),
    "post_eliminato": MessageLookupByLibrary.simpleMessage("Post eliminato"),
    "posts": MessageLookupByLibrary.simpleMessage("Posts"),
    "preferiti_solo_per_utenti_registrati":
        MessageLookupByLibrary.simpleMessage(
          "Preferiti solo per utenti registrati",
        ),
    "prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi":
        MessageLookupByLibrary.simpleMessage(
          "\"Prendete, e mangiatene  tutti: questo è il  Kebab offerto in  sacrificio  per voi.\"",
        ),
    "price": MessageLookupByLibrary.simpleMessage("Prezzo"),
    "prima_review": MessageLookupByLibrary.simpleMessage("prima recensione"),
    "primo_post": MessageLookupByLibrary.simpleMessage("primo post"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacy_policy_load_error": MessageLookupByLibrary.simpleMessage(
      "Errore nel caricamento della Privacy Policy",
    ),
    "progress_label": MessageLookupByLibrary.simpleMessage("Avanzamento"),
    "publish_photo": MessageLookupByLibrary.simpleMessage("Pubblica Foto"),
    "publish_review": MessageLookupByLibrary.simpleMessage(
      "Pubblica Recensione",
    ),
    "quality": MessageLookupByLibrary.simpleMessage("Qualità"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantità"),
    "queued": MessageLookupByLibrary.simpleMessage("In coda"),
    "rank_0_desc": MessageLookupByLibrary.simpleMessage(
      "Scrivi la tua prima recensione o crea un post per iniziare la collezione!",
    ),
    "rank_0_name": MessageLookupByLibrary.simpleMessage("Novizio del Kebab"),
    "rank_1_desc": MessageLookupByLibrary.simpleMessage(
      "I primi traguardi sono tuoi! Continua a recensire e postare.",
    ),
    "rank_1_name": MessageLookupByLibrary.simpleMessage(
      "Appassionato di Spiedi",
    ),
    "rank_2_desc": MessageLookupByLibrary.simpleMessage(
      "Hai un ottimo palato e una voce attiva nel feed.",
    ),
    "rank_2_name": MessageLookupByLibrary.simpleMessage("Gourmet del Döner"),
    "rank_3_desc": MessageLookupByLibrary.simpleMessage(
      "Un esperto riconosciuto sia nei gusti sia nella community.",
    ),
    "rank_3_name": MessageLookupByLibrary.simpleMessage("Maestro delle Salse"),
    "rank_4_desc": MessageLookupByLibrary.simpleMessage(
      "Mancano pochissimi traguardi al completamento assoluto!",
    ),
    "rank_4_name": MessageLookupByLibrary.simpleMessage("Veterano di Kebabbo"),
    "rank_5_desc": MessageLookupByLibrary.simpleMessage(
      "Hai conquistato tutti i traguardi! Sei nell\'Olimpo di Kebabbo.",
    ),
    "rank_5_name": MessageLookupByLibrary.simpleMessage("Leggenda Suprema"),
    "rate_the_kebab": MessageLookupByLibrary.simpleMessage("Valuta il Kebab"),
    "rating_title": MessageLookupByLibrary.simpleMessage("Valutazione"),
    "ready": MessageLookupByLibrary.simpleMessage("Pronto!"),
    "recharge_info": MessageLookupByLibrary.simpleMessage(
      "Ricarica 1 pacchetto ogni 12h (max 2)",
    ),
    "recharging_next_in": m27,
    "registrati_per_poter_visualizzare_il_feed":
        MessageLookupByLibrary.simpleMessage(
          "Registrati per poter visualizzare il feed",
        ),
    "remaining_count": m28,
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Rimuovi dai preferiti",
    ),
    "removed_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Rimosso dai preferiti",
    ),
    "required_field": MessageLookupByLibrary.simpleMessage(
      "Campo obbligatorio",
    ),
    "reroll": MessageLookupByLibrary.simpleMessage("Rilancia"),
    "reroll_step_1": MessageLookupByLibrary.simpleMessage(
      "👨‍🍳 Nuova combinazione in arrivo...",
    ),
    "reroll_step_2": MessageLookupByLibrary.simpleMessage(
      "🔥 Bilancio spezie e cottura...",
    ),
    "reroll_step_3": MessageLookupByLibrary.simpleMessage(
      "✨ Cerco un\'altra eccellente proposta...",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage(
      "Reimposta Password",
    ),
    "review": MessageLookupByLibrary.simpleMessage("Recensione"),
    "reviewMessage": m29,
    "review_action": MessageLookupByLibrary.simpleMessage("Recensisci"),
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Recensione inviata con successo",
    ),
    "review_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Recensisci questo Kebab",
    ),
    "review_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Recensione aggiornata con successo",
    ),
    "reviews_label": MessageLookupByLibrary.simpleMessage("Recensioni"),
    "riprova": MessageLookupByLibrary.simpleMessage("Riprova"),
    "sandwich_tag": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "sandwiches": MessageLookupByLibrary.simpleMessage("Panini"),
    "save_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Salva nei preferiti",
    ),
    "scrivi_un_commento": MessageLookupByLibrary.simpleMessage(
      "Scrivi un commento...",
    ),
    "scrivi_un_post": MessageLookupByLibrary.simpleMessage("Scrivi un post..."),
    "search_address_or_place": MessageLookupByLibrary.simpleMessage(
      "Cerca indirizzo o locale...",
    ),
    "search_kebabbo_places": MessageLookupByLibrary.simpleMessage(
      "Cerca tra i locali di Kebabbo",
    ),
    "search_places_hint": MessageLookupByLibrary.simpleMessage(
      "Es. Istanbul, Agra, King...",
    ),
    "second_pack_slot": MessageLookupByLibrary.simpleMessage("2° Pacchetto"),
    "section_initial_review": MessageLookupByLibrary.simpleMessage(
      "5. La Tua Recensione Iniziale",
    ),
    "section_location": MessageLookupByLibrary.simpleMessage(
      "1. Posizione sulla Mappa 📍",
    ),
    "section_location_hint": MessageLookupByLibrary.simpleMessage(
      "Tocca per posizionare il pin o cercare il locale. Coordinate, indirizzo e nome verranno estratti automaticamente!",
    ),
    "section_name_category": MessageLookupByLibrary.simpleMessage(
      "2. Nome e Categoria 🌯",
    ),
    "section_opening_hours": MessageLookupByLibrary.simpleMessage(
      "3. Orari di Apertura ⏰",
    ),
    "section_photo_optional": MessageLookupByLibrary.simpleMessage(
      "4. Foto del Locale (Opzionale)",
    ),
    "see_hours_photos_reviews": MessageLookupByLibrary.simpleMessage(
      "Vedi orari, foto e recensioni",
    ),
    "segui": MessageLookupByLibrary.simpleMessage("Segui"),
    "segui_gia": MessageLookupByLibrary.simpleMessage("Segui già"),
    "seguiti": MessageLookupByLibrary.simpleMessage("Seguiti"),
    "select_location_first": MessageLookupByLibrary.simpleMessage(
      "Seleziona la posizione sulla mappa prima di continuare! 📍",
    ),
    "select_on_map": MessageLookupByLibrary.simpleMessage(
      "Seleziona sulla Mappa",
    ),
    "select_photo_first": MessageLookupByLibrary.simpleMessage(
      "Seleziona una foto prima di pubblicare",
    ),
    "select_place_to_review": MessageLookupByLibrary.simpleMessage(
      "Seleziona il kebabbaro da recensire! 🌯",
    ),
    "selected_point": MessageLookupByLibrary.simpleMessage("Punto selezionato"),
    "seleziona_il_tuo_kebab_preferito": MessageLookupByLibrary.simpleMessage(
      "Seleziona il tuo kebab preferito",
    ),
    "send_reset_email": MessageLookupByLibrary.simpleMessage(
      "Invia email di reimpostazione",
    ),
    "session_expired": MessageLookupByLibrary.simpleMessage(
      "Sessione scaduta. Effettua nuovamente il login.",
    ),
    "sign_up": MessageLookupByLibrary.simpleMessage("Registrati"),
    "sign_up_with_google": MessageLookupByLibrary.simpleMessage(
      "Registrati con Google",
    ),
    "signup_tagline": MessageLookupByLibrary.simpleMessage(
      "Crea il tuo profilo e inizia a recensire i kebab della tua città",
    ),
    "single_card": MessageLookupByLibrary.simpleMessage("Carta Kebabbo"),
    "sort_dimension": MessageLookupByLibrary.simpleMessage("dimensione"),
    "sort_distance": MessageLookupByLibrary.simpleMessage("distanza"),
    "sort_menu": MessageLookupByLibrary.simpleMessage("menu"),
    "sort_name": MessageLookupByLibrary.simpleMessage("nome"),
    "sort_price": MessageLookupByLibrary.simpleMessage("prezzo"),
    "sort_quality": MessageLookupByLibrary.simpleMessage("qualità"),
    "sort_stars": MessageLookupByLibrary.simpleMessage("stelle"),
    "spicy": MessageLookupByLibrary.simpleMessage("Piccante"),
    "staff": MessageLookupByLibrary.simpleMessage("Staff"),
    "staff_certified": MessageLookupByLibrary.simpleMessage(
      "Certificato Staff Kebabbo",
    ),
    "submit_review": MessageLookupByLibrary.simpleMessage("Invia recensione"),
    "successfully_updated_profile": MessageLookupByLibrary.simpleMessage(
      "Profilo aggiornato con successo!",
    ),
    "swipe_collection_hint": MessageLookupByLibrary.simpleMessage(
      "Scorri per sfogliare la collezione",
    ),
    "tab_overview": MessageLookupByLibrary.simpleMessage("Panoramica"),
    "tab_photos": m30,
    "tab_reviews": m31,
    "tag_kebab_pill": MessageLookupByLibrary.simpleMessage("Kebab 🌯"),
    "tag_sandwich_pill": MessageLookupByLibrary.simpleMessage("Paninoteca 🥪"),
    "tap_map_to_select": MessageLookupByLibrary.simpleMessage(
      "Tocca la mappa per selezionare il punto esatto",
    ),
    "tap_to_browse_album": MessageLookupByLibrary.simpleMessage(
      "Tocca per sfogliare l\'album completo ›",
    ),
    "tap_to_open_pack": MessageLookupByLibrary.simpleMessage(
      "Tocca per aprire il pacchetto!",
    ),
    "tap_to_select_photo": MessageLookupByLibrary.simpleMessage(
      "Tocca per selezionare una foto",
    ),
    "tcg_album": MessageLookupByLibrary.simpleMessage("Album Carte TCG"),
    "ten_posts": MessageLookupByLibrary.simpleMessage("10 post"),
    "ten_reviews": MessageLookupByLibrary.simpleMessage("10 recensioni"),
    "testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo":
        MessageLookupByLibrary.simpleMessage(
          "Testiamo e recensiamo Kebabbari e Street Food per voi. Benvenuti su Kebabbo.",
        ),
    "testo_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Testo non disponibile",
    ),
    "thank_you": MessageLookupByLibrary.simpleMessage("Grazie"),
    "thank_you_for_your_review": MessageLookupByLibrary.simpleMessage(
      "Grazie per la tua recensione!",
    ),
    "thirty_reviews": MessageLookupByLibrary.simpleMessage("30 recensioni"),
    "twenty_reviews": MessageLookupByLibrary.simpleMessage("20 recensioni"),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Si è verificato un errore imprevisto",
    ),
    "unit_posts": MessageLookupByLibrary.simpleMessage("post"),
    "unit_reviews": MessageLookupByLibrary.simpleMessage("recensioni"),
    "unlocked_badge": MessageLookupByLibrary.simpleMessage("Sbloccata"),
    "unlocked_of_total": m32,
    "unpack_and_view_collection": MessageLookupByLibrary.simpleMessage(
      "Spacchetta & Guarda Collezione",
    ),
    "unpack_new_cards": MessageLookupByLibrary.simpleMessage(
      "Spacchetta Nuove Carte",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Aggiorna"),
    "upload": MessageLookupByLibrary.simpleMessage("Carica"),
    "upload_error": m33,
    "upload_first_photo": MessageLookupByLibrary.simpleMessage(
      "Carica la prima foto",
    ),
    "upload_place_photo": MessageLookupByLibrary.simpleMessage(
      "Carica una foto dello spiedo o del locale",
    ),
    "user_generic": MessageLookupByLibrary.simpleMessage("Utente"),
    "user_not_authenticated": MessageLookupByLibrary.simpleMessage(
      "Utente non autenticato",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage(
      "Utente non trovato",
    ),
    "user_not_found_login_again": MessageLookupByLibrary.simpleMessage(
      "Utente non trovato. Effettua di nuovo il login.",
    ),
    "username_can_only_contain_letters_numbers_and_underscores":
        MessageLookupByLibrary.simpleMessage(
          "Il nome utente può contenere solo lettere,\nnumeri e trattini bassi!",
        ),
    "username_cannot_be_more_than_12_characters":
        MessageLookupByLibrary.simpleMessage(
          "Il nome utente non può contenere più di\n12 caratteri!",
        ),
    "username_cannot_contain_spaces_use_undescores_instead":
        MessageLookupByLibrary.simpleMessage(
          "Il nome utente non può contenere spazi,\nusa trattini bassi invece!",
        ),
    "username_must_be_at_least_3_characters_long":
        MessageLookupByLibrary.simpleMessage(
          "Il nome utente deve essere lungo almeno 3\ncaratteri!",
        ),
    "users": MessageLookupByLibrary.simpleMessage("Utenti"),
    "users_count": m34,
    "users_review": MessageLookupByLibrary.simpleMessage(
      "Recensione degli utenti",
    ),
    "vegetables": MessageLookupByLibrary.simpleMessage("Verdure"),
    "verdura": MessageLookupByLibrary.simpleMessage("Verdura"),
    "verified_by_staff_tooltip": MessageLookupByLibrary.simpleMessage(
      "Verificato dallo staff Kebabbo",
    ),
    "vuoi_veramente_eliminare_il_post": MessageLookupByLibrary.simpleMessage(
      "Vuoi veramente eliminare il post?",
    ),
    "world": MessageLookupByLibrary.simpleMessage("Mondo"),
    "write_a_review_for_a_kebab_near_you": MessageLookupByLibrary.simpleMessage(
      "Scrivi una recensione",
    ),
    "write_first_review": MessageLookupByLibrary.simpleMessage(
      "Scrivi la prima recensione",
    ),
    "write_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vota la qualità, la carne e le salse",
    ),
    "write_review_title": MessageLookupByLibrary.simpleMessage(
      "Scrivi una Recensione",
    ),
    "yes_create_new": MessageLookupByLibrary.simpleMessage("Sì, crea nuovo"),
    "yogurt": MessageLookupByLibrary.simpleMessage("Yogurt"),
    "you_can_access_reviews_at_any_time_from_your_account":
        MessageLookupByLibrary.simpleMessage(
          "Puoi accedere alle recensioni in qualsiasi momento dal tuo account.",
        ),
    "your_experience": MessageLookupByLibrary.simpleMessage(
      "La Tua Esperienza",
    ),
    "your_kebab": MessageLookupByLibrary.simpleMessage("Il tuo kebab"),
    "your_medals_title": MessageLookupByLibrary.simpleMessage(
      "Le tue Medaglie",
    ),
    "your_review_optional": MessageLookupByLibrary.simpleMessage(
      "La tua recensione (opzionale)",
    ),
  };
}
