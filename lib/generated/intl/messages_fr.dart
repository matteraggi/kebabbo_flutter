// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(name) => "Ajouter une photo à ${name}";

  static String m1(name) => "${name} (déjà dans la collection)";

  static String m2(error) => "Une erreur est survenue : ${error}";

  static String m3(count) => "Basé sur ${count} avis";

  static String m4(current, total) => "#${current} sur ${total}";

  static String m5(style) => "Changer de carte : ${style}";

  static String m6(city) => "Ville : ${city}";

  static String m7(count) => "Communauté (${count})";

  static String m8(results) => "10 km (${results} résultats)";

  static String m9(results) => "1 km (${results} résultats)";

  static String m10(results) => "200 mètres (${results} résultats)";

  static String m11(results) => "500 mètres (${results} résultats)";

  static String m12(results) => "Illimité (${results} résultats)";

  static String m13(error) =>
      "Erreur lors de la suppression du post : ${error}";

  static String m14(error) => "Erreur lors de l\'enregistrement : ${error}";

  static String m15(error) => "Erreur lors de l\'envoi de l\'avis : ${error}";

  static String m16(count) => "Toutes (${count})";

  static String m17(count) => "Avis (${count})";

  static String m18(count) => "Débloquées (${count})";

  static String m19(missing, unit) =>
      "Plus que ${missing} ${unit} pour débloquer cette médaille !";

  static String m20(count) => "${count} manquantes";

  static String m21(time) => "Prochaine recharge dans ${time}";

  static String m22(km) => "Aucun kebab à moins de ${km} km.";

  static String m23(hours, minutes) =>
      "Aucun pack prêt pour le moment (0/2). Le prochain sera prêt dans ${hours} h ${minutes} min.";

  static String m24(time) =>
      "Aucun pack prêt. Le prochain sera disponible dans ${time}.";

  static String m25(count) => "Ouvrir le 2e pack (${count})";

  static String m26(error) =>
      "Échec de la réinitialisation du mot de passe : ${error}";

  static String m27(percent) => "${percent}% terminé";

  static String m28(time) => "Recharge en cours : prochain dans ${time}";

  static String m29(count) => "${count} restantes";

  static String m30(
    kebabName,
    qualityRating,
    quantityRating,
    menuRating,
    priceRating,
    funRating,
    description,
  ) =>
      "Je viens d\'évaluer le kebab chez ${kebabName}!\n\nQualité: ${qualityRating}\nQuantité: ${quantityRating}\nMenu: ${menuRating}\nPrix: ${priceRating}\nDivertissement: ${funRating}\n\n${description}";

  static String m31(name, rating) => "${name} : ${rating} sur Kebabbo 🌯";

  static String m32(rating) => "Note Kebabbo ${rating}";

  static String m33(count) => "Photos (${count})";

  static String m34(count) => "Avis (${count})";

  static String m35(count) => "${count} cartes TCG";

  static String m36(unlocked, total) => "${unlocked} sur ${total} débloquées";

  static String m37(error) => "Erreur lors de l\'envoi : ${error}";

  static String m38(count) => "Utilisateurs (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("À propos"),
    "accedi_per_cercare": MessageLookupByLibrary.simpleMessage(
      "Connecte-toi pour publier et voir les informations des autres",
    ),
    "add_dish_photo_optional": MessageLookupByLibrary.simpleMessage(
      "Ajouter une photo de votre plat (facultatif)",
    ),
    "add_kebab": MessageLookupByLibrary.simpleMessage("Ajouter un Kebab"),
    "add_kebab_place": MessageLookupByLibrary.simpleMessage("Ajouter un kebab"),
    "add_kebab_place_subtitle": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un nouveau lieu sur la carte",
    ),
    "add_kebab_to_kebabbo": MessageLookupByLibrary.simpleMessage(
      "Ajouter le lieu à Kebabbo",
    ),
    "add_new_kebab_confirmation": MessageLookupByLibrary.simpleMessage(
      "Vous allez ajouter \"\$name\" comme nouveau kebab. Êtes-vous sûr qu\'il n\'existe pas déjà ?",
    ),
    "add_photo_to": m0,
    "add_review_appbar_title": MessageLookupByLibrary.simpleMessage(
      "Ajouter un Avis",
    ),
    "add_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Vous avez testé un nouveau kebab ?",
    ),
    "add_review_title": MessageLookupByLibrary.simpleMessage("Ajouter un Avis"),
    "add_to_collection": MessageLookupByLibrary.simpleMessage(
      "Ajouter à la collection",
    ),
    "added_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Ajouté aux favoris ❤️",
    ),
    "advanced_filters": MessageLookupByLibrary.simpleMessage("Filtres Avancés"),
    "all_filter": MessageLookupByLibrary.simpleMessage("Tous"),
    "all_found": MessageLookupByLibrary.simpleMessage("Toutes trouvées ! 🏆"),
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ? Se connecter",
    ),
    "already_in_collection": m1,
    "an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Une erreur s\'est produite",
    ),
    "an_error_occurred_with": m2,
    "annulla": MessageLookupByLibrary.simpleMessage("Annuler"),
    "anonimo": MessageLookupByLibrary.simpleMessage("Anonyme"),
    "aperti_ora": MessageLookupByLibrary.simpleMessage("Ouvert maintenant"),
    "aperto": MessageLookupByLibrary.simpleMessage("Ouvert"),
    "app_is_installed": MessageLookupByLibrary.simpleMessage(
      "Kebabbo existe aussi en appli !",
    ),
    "app_is_installed_description": MessageLookupByLibrary.simpleMessage(
      "Ouvrez-le dans l\'appli pour une meilleure expérience. Si vous ne l\'avez pas encore, on vous emmène sur Google Play.",
    ),
    "autenticazione_necessaria": MessageLookupByLibrary.simpleMessage(
      "Vous devez être connecté pour commenter.",
    ),
    "back_to_build": MessageLookupByLibrary.simpleMessage(
      "Retour à la construction",
    ),
    "based_on_reviews": m3,
    "build_button": MessageLookupByLibrary.simpleMessage("Composer !"),
    "build_your_kebab": MessageLookupByLibrary.simpleMessage(
      "Construis ton kebab",
    ),
    "by_signing_in_you_agree_to_our_terms_and_privacy_policy":
        MessageLookupByLibrary.simpleMessage(
          "En te connectant, tu acceptes nos conditions générales et notre politique de confidentialité.",
        ),
    "cambia_profilepic": MessageLookupByLibrary.simpleMessage(
      "changer la photo de profil",
    ),
    "cambia_profilo": MessageLookupByLibrary.simpleMessage("changer de profil"),
    "cambia_username": MessageLookupByLibrary.simpleMessage(
      "Changer le nom d\'utilisateur",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "card_collection": MessageLookupByLibrary.simpleMessage(
      "Collection de cartes",
    ),
    "card_x_of_y": m4,
    "cards_unlocked": MessageLookupByLibrary.simpleMessage("cartes débloquées"),
    "center_on_my_location": MessageLookupByLibrary.simpleMessage(
      "Centrer sur ma position",
    ),
    "cerca_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Rechercher un restaurant de kebab...",
    ),
    "cerca_utenti": MessageLookupByLibrary.simpleMessage(
      "Rechercher des utilisateurs...",
    ),
    "change": MessageLookupByLibrary.simpleMessage("Changer"),
    "change_map_style": m5,
    "check_your_email_for_a_login_link": MessageLookupByLibrary.simpleMessage(
      "Vérifie tes e-mails pour un lien de connexion !",
    ),
    "check_your_email_for_a_reset_link": MessageLookupByLibrary.simpleMessage(
      "Vérifie tes e-mails pour un lien de réinitialisation",
    ),
    "check_your_email_for_a_verification_link":
        MessageLookupByLibrary.simpleMessage(
          "Vérifie tes e-mails pour un lien de vérification",
        ),
    "chiuso": MessageLookupByLibrary.simpleMessage("Fermé"),
    "choose_on_map_recommended": MessageLookupByLibrary.simpleMessage(
      "Choisir sur la carte (recommandé)",
    ),
    "choose_place": MessageLookupByLibrary.simpleMessage("Choisissez le lieu"),
    "cipolla": MessageLookupByLibrary.simpleMessage("Oignon"),
    "city": MessageLookupByLibrary.simpleMessage("Ville"),
    "city_label": m6,
    "close": MessageLookupByLibrary.simpleMessage("Fermer"),
    "collection_subtitle": MessageLookupByLibrary.simpleMessage(
      "voir vos cartes kebabbo",
    ),
    "collection_title": MessageLookupByLibrary.simpleMessage("Collection"),
    "comment_review_hint": MessageLookupByLibrary.simpleMessage(
      "Qu\'avez-vous préféré ? Une sauce ou un menu à recommander ?",
    ),
    "comment_review_label": MessageLookupByLibrary.simpleMessage(
      "Commentaire / avis *",
    ),
    "comment_review_required": MessageLookupByLibrary.simpleMessage(
      "Écrivez un court commentaire sur votre expérience",
    ),
    "commento_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Commentaire non disponible",
    ),
    "commento_vuoto": MessageLookupByLibrary.simpleMessage(
      "Le texte du commentaire ne peut pas être vide.",
    ),
    "community_count": m7,
    "community_review": MessageLookupByLibrary.simpleMessage(
      "Avis de la communauté",
    ),
    "community_upload": MessageLookupByLibrary.simpleMessage("Communauté"),
    "compare_kebabs": MessageLookupByLibrary.simpleMessage(
      "Comparer les Kebabs",
    ),
    "completed_badge": MessageLookupByLibrary.simpleMessage("Terminé ! ⭐"),
    "conferma_eliminazione": MessageLookupByLibrary.simpleMessage(
      "Confirmer la suppression",
    ),
    "confirm_this_location": MessageLookupByLibrary.simpleMessage(
      "Confirmer cet emplacement",
    ),
    "congratulazioni": MessageLookupByLibrary.simpleMessage("Félicitations !"),
    "consigliaci_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Recommande un restaurant de kebab",
    ),
    "contribute_subtitle": MessageLookupByLibrary.simpleMessage(
      "Aidez-nous à cartographier et évaluer les meilleurs kebabs !",
    ),
    "contribute_title": MessageLookupByLibrary.simpleMessage(
      "Contribuez à Kebabbo",
    ),
    "cooking_step_1": MessageLookupByLibrary.simpleMessage(
      "🔥 Je réchauffe le pain...",
    ),
    "cooking_step_2": MessageLookupByLibrary.simpleMessage(
      "🥩 Je découpe la viande de la broche...",
    ),
    "cooking_step_3": MessageLookupByLibrary.simpleMessage(
      "🥗 J\'ajoute des légumes frais et des sauces...",
    ),
    "cooking_step_4": MessageLookupByLibrary.simpleMessage(
      "🌯 Je roule tout dans les règles de l\'art...",
    ),
    "cooking_step_5": MessageLookupByLibrary.simpleMessage(
      "🔍 Je cherche le meilleur kebab pour vous...",
    ),
    "cooking_title": MessageLookupByLibrary.simpleMessage(
      "Préparation du kebab",
    ),
    "cooking_title_reroll": MessageLookupByLibrary.simpleMessage(
      "Recherche d\'une alternative",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copier"),
    "copy_link": MessageLookupByLibrary.simpleMessage("Copier le lien"),
    "could_not_open_link": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'ouvrir le lien.",
    ),
    "create_kebab_subtitle": MessageLookupByLibrary.simpleMessage(
      "composez votre propre kebab",
    ),
    "create_kebab_title": MessageLookupByLibrary.simpleMessage(
      "Créer un Kebab",
    ),
    "custom_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Indiquez les horaires de chaque jour (ex. 11:00-23:00 ou « fermé ») :",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "description_is_required": MessageLookupByLibrary.simpleMessage(
      "La description est requise",
    ),
    "description_review_hint": MessageLookupByLibrary.simpleMessage(
      "Racontez ce kebab : pain, viande, saveurs...",
    ),
    "description_review_label": MessageLookupByLibrary.simpleMessage(
      "Description / avis *",
    ),
    "description_review_required": MessageLookupByLibrary.simpleMessage(
      "Écrivez un court commentaire pour présenter le lieu",
    ),
    "descrizione_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Description non disponible",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Détails"),
    "devi_essere_autenticato_per_commentare":
        MessageLookupByLibrary.simpleMessage(
          "Tu dois te connecter pour commenter",
        ),
    "devi_essere_autenticato_per_mettere_mi_piace":
        MessageLookupByLibrary.simpleMessage("Tu dois te connecter pour aimer"),
    "devi_essere_autenticato_per_postare": MessageLookupByLibrary.simpleMessage(
      "Tu dois être authentifié pour publier",
    ),
    "devi_essere_autenticato_per_visualizzare_il_profilo":
        MessageLookupByLibrary.simpleMessage(
          "Tu dois te connecter pour voir le profil",
        ),
    "dimension": MessageLookupByLibrary.simpleMessage("Taille"),
    "directions": MessageLookupByLibrary.simpleMessage("Itinéraire"),
    "distanceLabel10km": m8,
    "distanceLabel1km": m9,
    "distanceLabel200m": m10,
    "distanceLabel500m": m11,
    "distanceLabelUnlimited": m12,
    "distanza_massima": MessageLookupByLibrary.simpleMessage(
      "Distance maximale",
    ),
    "distanza_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Distance non disponible",
    ),
    "dont_have_an_account_sign_up": MessageLookupByLibrary.simpleMessage(
      "Tu n\'as pas de compte ? Inscris-toi",
    ),
    "drag_to_tilt": MessageLookupByLibrary.simpleMessage(
      "Faites glisser le doigt pour incliner en 3D",
    ),
    "duplicate_card": MessageLookupByLibrary.simpleMessage("CARTE EN DOUBLE"),
    "edit_location_on_map": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'emplacement sur la carte",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Modifier le profil"),
    "elimina": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "email_required": MessageLookupByLibrary.simpleMessage(
      "L\'email est requis",
    ),
    "enter_place_name": MessageLookupByLibrary.simpleMessage(
      "Saisissez le nom du lieu",
    ),
    "error_adding_review": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de l\'ajout de l\'avis : ",
    ),
    "error_deleting_post": m13,
    "error_loading_kebabs": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du chargement des kebabs : ",
    ),
    "error_processing_image": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du traitement de l\'image :",
    ),
    "error_saving": m14,
    "error_sending_review": m15,
    "errore": MessageLookupByLibrary.simpleMessage("Erreur :"),
    "errore_nel_caricamento_dei_follower": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du chargement des abonnés",
    ),
    "errore_nel_caricamento_dellimage": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du chargement de l\'image :",
    ),
    "esplora": MessageLookupByLibrary.simpleMessage("Explorer"),
    "examine_3d": MessageLookupByLibrary.simpleMessage("Examiner en 3D"),
    "extract": MessageLookupByLibrary.simpleMessage("Extraire"),
    "failed_to_load_favorites": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement des favoris",
    ),
    "failed_to_load_follower_count": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement du nombre d\'abonnés",
    ),
    "failed_to_load_medals": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement des médailles",
    ),
    "failed_to_load_post_count": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement du nombre de publications",
    ),
    "failed_to_load_posts": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement des publications",
    ),
    "failed_to_load_profile": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement du profil",
    ),
    "failed_to_load_reviews_count": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement du nombre de critiques",
    ),
    "failed_to_update_follow_status": MessageLookupByLibrary.simpleMessage(
      "Échec de la mise à jour du statut d\'abonnement",
    ),
    "failed_to_upload_avatar": MessageLookupByLibrary.simpleMessage(
      "Échec du téléchargement de l\'avatar",
    ),
    "favorite_kebab_caps": MessageLookupByLibrary.simpleMessage(
      "KEBAB PRÉFÉRÉ",
    ),
    "feed_posts_label": MessageLookupByLibrary.simpleMessage("Posts du fil"),
    "fifty_posts": MessageLookupByLibrary.simpleMessage("50 publications"),
    "filter_all_count": m16,
    "filter_by_distance": MessageLookupByLibrary.simpleMessage(
      "Filtrer par distance",
    ),
    "filter_reviews_count": m17,
    "filter_unlocked_count": m18,
    "first_pack_slot": MessageLookupByLibrary.simpleMessage("1er pack"),
    "first_time_description": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Kebabbo !\nQue peux-tu faire ici ?\nEh bien, tu peux explorer nos critiques professionnelles de kebab ou consulter les notes des autres utilisateurs.\nRédige ta propre critique en scannant l\'autocollant Kebabbo au restaurant de kebab.\nConsulte les profils et les publications des autres utilisateurs, connecte-toi avec d\'autres amateurs de kebab et gagne des succès en utilisant l\'application.\nUtilise nos fonctions de recherche et de filtre ou notre puissant outil de création pour trouver ton kebab idéal ou explore notre carte interactive pour découvrir des pépites à proximité.\nAmuse-toi bien et régale-toi de kebab !",
    ),
    "first_time_title": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Kebabbo !",
    ),
    "five_posts": MessageLookupByLibrary.simpleMessage("5 publications"),
    "five_reviews": MessageLookupByLibrary.simpleMessage("5 avis"),
    "followed_filter": MessageLookupByLibrary.simpleMessage("Abonnements"),
    "followers": MessageLookupByLibrary.simpleMessage("Abonnés"),
    "following": MessageLookupByLibrary.simpleMessage("Abonnements"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié",
    ),
    "found_all_cards": MessageLookupByLibrary.simpleMessage(
      "Toutes les cartes trouvées.",
    ),
    "fun": MessageLookupByLibrary.simpleMessage("Amusement"),
    "fun_exclamation": MessageLookupByLibrary.simpleMessage("fun !"),
    "games_tools_title": MessageLookupByLibrary.simpleMessage("Jeux & Outils"),
    "generic_error": MessageLookupByLibrary.simpleMessage("Erreur : "),
    "gluten_free": MessageLookupByLibrary.simpleMessage("Sans Gluten"),
    "gluten_free_option": MessageLookupByLibrary.simpleMessage(
      "Option sans gluten",
    ),
    "gluten_free_option_desc": MessageLookupByLibrary.simpleMessage(
      "Propose du pain ou des options sans gluten certifiés",
    ),
    "go_back": MessageLookupByLibrary.simpleMessage("Retour"),
    "goal_reached": MessageLookupByLibrary.simpleMessage("Objectif atteint 🎉"),
    "google_maps_link": MessageLookupByLibrary.simpleMessage(
      "Lien Google Maps",
    ),
    "hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia":
        MessageLookupByLibrary.simpleMessage(
          "Tu as franchi une nouvelle étape et obtenu une nouvelle médaille !",
        ),
    "hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo":
        MessageLookupByLibrary.simpleMessage(
          "Tu as reçu une nouvelle médaille pour ta contribution !",
        ),
    "have_account_question": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ?",
    ),
    "hours_none_note": MessageLookupByLibrary.simpleMessage(
      "Aucun horaire ne sera enregistré.",
    ),
    "hours_preset_continuous": MessageLookupByLibrary.simpleMessage(
      "Non-stop (11-23) 🌯",
    ),
    "hours_preset_custom": MessageLookupByLibrary.simpleMessage(
      "Personnalisés ⚙️",
    ),
    "hours_preset_lunch_dinner": MessageLookupByLibrary.simpleMessage(
      "Midi et soir 🍽️",
    ),
    "hours_preset_night": MessageLookupByLibrary.simpleMessage(
      "Tard le soir (11-02) 🌙",
    ),
    "hours_preset_none": MessageLookupByLibrary.simpleMessage(
      "Non précisés (par défaut)",
    ),
    "i_tuoi_post": MessageLookupByLibrary.simpleMessage("Tes publications"),
    "il_commento_e_stato_aggiunto_con_successo":
        MessageLookupByLibrary.simpleMessage(
          "Le commentaire a été ajouté avec succès !",
        ),
    "il_kebab_che_ti_raccomandiamo_e": MessageLookupByLibrary.simpleMessage(
      "Le kebab que nous te recommandons est :",
    ),
    "il_testo_non_puo_essere_vuoto": MessageLookupByLibrary.simpleMessage(
      "Le texte ne peut pas être vide",
    ),
    "in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google":
        MessageLookupByLibrary.simpleMessage(
          "En Italie, le monde du kebab est encore un monde obscur. Les meilleurs restaurants sont sous-estimés et les pires reçoivent des critiques élevées sur Google.",
        ),
    "in_progress": MessageLookupByLibrary.simpleMessage("En cours ⏳"),
    "ingredient_amounts_caps": MessageLookupByLibrary.simpleMessage(
      "QUANTITÉ D\'INGRÉDIENTS",
    ),
    "ingredient_balance": MessageLookupByLibrary.simpleMessage(
      "Équilibre des ingrédients",
    ),
    "ingredient_balance_1_10": MessageLookupByLibrary.simpleMessage(
      "Équilibre des ingrédients (1 à 10)",
    ),
    "ingredients_comparison": MessageLookupByLibrary.simpleMessage(
      "Comparaison des Ingrédients",
    ),
    "inserted_by": MessageLookupByLibrary.simpleMessage("Ajouté par"),
    "intro_1_text": MessageLookupByLibrary.simpleMessage(
      "Classements de l\'équipe et de la communauté, une carte avec les notes et des filtres par distance, prix et horaires.",
    ),
    "intro_1_title": MessageLookupByLibrary.simpleMessage(
      "Trouvez votre kebab",
    ),
    "intro_2_text": MessageLookupByLibrary.simpleMessage(
      "Notez la qualité, le prix et les ingrédients, publiez des photos de votre plat et ajoutez les lieux manquants.",
    ),
    "intro_2_title": MessageLookupByLibrary.simpleMessage(
      "Évaluez et partagez",
    ),
    "intro_3_text": MessageLookupByLibrary.simpleMessage(
      "Chaque avis et chaque post débloque des médailles, et toutes les 12 heures vous pouvez ouvrir un pack de cartes Kebabbo.",
    ),
    "intro_3_title": MessageLookupByLibrary.simpleMessage(
      "Collectionnez médailles et cartes",
    ),
    "intro_next": MessageLookupByLibrary.simpleMessage("Suivant"),
    "intro_skip": MessageLookupByLibrary.simpleMessage("Passer"),
    "intro_start": MessageLookupByLibrary.simpleMessage("Commencer"),
    "invia": MessageLookupByLibrary.simpleMessage("Envoyer"),
    "it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again":
        MessageLookupByLibrary.simpleMessage(
          "Il semble que la critique à laquelle tu essaies d\'accéder n\'existe pas. Vérifie le lien et réessaie.",
        ),
    "kebab_already_exists": MessageLookupByLibrary.simpleMessage(
      "Le kebab existe déjà",
    ),
    "kebab_consigliato": MessageLookupByLibrary.simpleMessage(
      "Kebab recommandé",
    ),
    "kebab_no_longer_available": MessageLookupByLibrary.simpleMessage(
      "Kebab n\'est plus disponible",
    ),
    "kebab_not_found": MessageLookupByLibrary.simpleMessage(
      "Kebab introuvable",
    ),
    "kebab_place_name_hint": MessageLookupByLibrary.simpleMessage(
      "Ex. Bella Istanbul 3",
    ),
    "kebab_place_name_label": MessageLookupByLibrary.simpleMessage(
      "Nom du lieu *",
    ),
    "kebab_place_not_found": MessageLookupByLibrary.simpleMessage(
      "Lieu introuvable ou supprimé.",
    ),
    "kebab_sconosciuto": MessageLookupByLibrary.simpleMessage("Kebab inconnu"),
    "kebab_tag": MessageLookupByLibrary.simpleMessage("Kebab"),
    "kebabbo_review": MessageLookupByLibrary.simpleMessage("Avis Kebabbo"),
    "kebabbo_staff_review": MessageLookupByLibrary.simpleMessage(
      "L\'avis de Kebabbo",
    ),
    "kebabbo_user": MessageLookupByLibrary.simpleMessage("Utilisateur Kebabbo"),
    "km_distante_da_te": MessageLookupByLibrary.simpleMessage("km de toi"),
    "la_tua_soluzione_per_il_pranzo_universitario":
        MessageLookupByLibrary.simpleMessage(
          "Ta solution pour le déjeuner à l\'université",
        ),
    "legends": MessageLookupByLibrary.simpleMessage("Légendes"),
    "link_copied": MessageLookupByLibrary.simpleMessage("Lien copié"),
    "loader_subtitle": MessageLookupByLibrary.simpleMessage(
      "Classements, avis de la communauté et carte des kebabs.",
    ),
    "loader_title": MessageLookupByLibrary.simpleMessage(
      "Kebabbo – les meilleurs kebabs de Bologne",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Chargement"),
    "location_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Autorisation de localisation refusée.",
    ),
    "location_permission_denied_forever": MessageLookupByLibrary.simpleMessage(
      "Autorisation de localisation refusée définitivement. Vous pouvez l\'activer dans les réglages.",
    ),
    "location_selected": MessageLookupByLibrary.simpleMessage(
      "Emplacement sélectionné",
    ),
    "location_services_disabled": MessageLookupByLibrary.simpleMessage(
      "Les services de localisation sont désactivés.",
    ),
    "log_in_con_google": MessageLookupByLibrary.simpleMessage(
      "Se connecter avec Google",
    ),
    "logged_in": MessageLookupByLibrary.simpleMessage("Connecté"),
    "login": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "login_loader_subtitle": MessageLookupByLibrary.simpleMessage(
      "Un instant, nous préparons votre profil.",
    ),
    "login_loader_title": MessageLookupByLibrary.simpleMessage(
      "Connexion en cours",
    ),
    "login_required_section": MessageLookupByLibrary.simpleMessage(
      "Vous devez vous connecter pour utiliser cette section.",
    ),
    "login_step_auth": MessageLookupByLibrary.simpleMessage("Connexion"),
    "login_step_profile": MessageLookupByLibrary.simpleMessage(
      "Profil, favoris et médailles",
    ),
    "login_tagline": MessageLookupByLibrary.simpleMessage(
      "Rejoignez la communauté pour découvrir et évaluer les meilleurs kebabs",
    ),
    "login_to_follow_user": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour suivre cet utilisateur",
    ),
    "login_to_post_photos": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour publier des photos",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "map_not_available": MessageLookupByLibrary.simpleMessage(
      "Carte non disponible pour ce lieu",
    ),
    "map_style_google_road": MessageLookupByLibrary.simpleMessage(
      "Google Plan",
    ),
    "map_style_google_satellite": MessageLookupByLibrary.simpleMessage(
      "Google Satellite",
    ),
    "map_style_road_short": MessageLookupByLibrary.simpleMessage("Plan"),
    "map_style_satellite_short": MessageLookupByLibrary.simpleMessage(
      "Satellite",
    ),
    "mappa": MessageLookupByLibrary.simpleMessage("Carte"),
    "maps_link_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordonnées détectées depuis le lien Maps ! 📍",
    ),
    "maps_link_failed": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'extraire les coordonnées du lien. Utilisez « Choisir sur la carte ».",
    ),
    "maps_link_name_and_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordonnées et nom détectés depuis le lien Maps ! 📍",
    ),
    "maps_short_link_web": MessageLookupByLibrary.simpleMessage(
      "Sur le web, utilisez le lien Google Maps complet (https://www.google.com/maps/place/...) : les liens courts sont bloqués par le navigateur.",
    ),
    "max_charge_reached": MessageLookupByLibrary.simpleMessage(
      "Charge maximale atteinte (1 toutes les 12 h)",
    ),
    "meat": MessageLookupByLibrary.simpleMessage("Viande"),
    "medal_0_desc": MessageLookupByLibrary.simpleMessage(
      "Vous avez écrit votre premier avis sur un kebab. Bienvenue dans la famille des critiques Kebabbo !",
    ),
    "medal_0_title": MessageLookupByLibrary.simpleMessage("Première bouchée"),
    "medal_1_desc": MessageLookupByLibrary.simpleMessage(
      "Vous avez évalué 5 lieux différents. Votre palais commence à reconnaître le véritable art de la broche !",
    ),
    "medal_1_title": MessageLookupByLibrary.simpleMessage("Goûteur en série"),
    "medal_2_desc": MessageLookupByLibrary.simpleMessage(
      "10 avis rédigés ! Vos notes guident les kebabs et toute la communauté.",
    ),
    "medal_2_title": MessageLookupByLibrary.simpleMessage("Critique de kebab"),
    "medal_3_desc": MessageLookupByLibrary.simpleMessage(
      "20 avis écrits ! Plus aucun wrap, sauce ou pain pita n\'a de secret pour vous. Un vrai maître !",
    ),
    "medal_3_title": MessageLookupByLibrary.simpleMessage(
      "Maître de la broche",
    ),
    "medal_4_desc": MessageLookupByLibrary.simpleMessage(
      "30 avis à votre actif ! Vous avez atteint le sommet de l\'expérience culinaire Kebabbo. Une légende vivante !",
    ),
    "medal_4_title": MessageLookupByLibrary.simpleMessage(
      "Légende gastronomique",
    ),
    "medal_5_desc": MessageLookupByLibrary.simpleMessage(
      "Vous avez publié votre premier post dans le fil. Votre passion pour le kebab est désormais publique !",
    ),
    "medal_5_title": MessageLookupByLibrary.simpleMessage("Voix du fil"),
    "medal_6_desc": MessageLookupByLibrary.simpleMessage(
      "Vous avez partagé 5 posts avec photos et impressions. La communauté adore vos nouvelles !",
    ),
    "medal_6_title": MessageLookupByLibrary.simpleMessage("Reporter du goût"),
    "medal_7_desc": MessageLookupByLibrary.simpleMessage(
      "10 posts partagés ! Vos photos et vos tags donnent faim à toute la ville.",
    ),
    "medal_7_title": MessageLookupByLibrary.simpleMessage("Influenceur kebab"),
    "medal_8_desc": MessageLookupByLibrary.simpleMessage(
      "50 posts dans la communauté ! Vous êtes un pilier irremplaçable du fil Kebabbo !",
    ),
    "medal_8_title": MessageLookupByLibrary.simpleMessage(
      "Pilier de la communauté",
    ),
    "medal_missing": m19,
    "medals_page_title": MessageLookupByLibrary.simpleMessage(
      "Médailles et objectifs",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "missing_count": m20,
    "more_info": MessageLookupByLibrary.simpleMessage(
      "Comment critiquer un kebab",
    ),
    "my_cards": MessageLookupByLibrary.simpleMessage("Collection Kebab TCG"),
    "name_autofilled_helper": MessageLookupByLibrary.simpleMessage(
      "Rempli automatiquement depuis la carte (modifiable)",
    ),
    "name_label": MessageLookupByLibrary.simpleMessage("Nom"),
    "nav_account": MessageLookupByLibrary.simpleMessage("Compte"),
    "nav_add": MessageLookupByLibrary.simpleMessage("Ajouter"),
    "nav_feed": MessageLookupByLibrary.simpleMessage("Fil"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Accueil"),
    "nessun_commento_disponibile": MessageLookupByLibrary.simpleMessage(
      "Aucun commentaire disponible",
    ),
    "nessun_kebab_corrispondente_trovato_nel_raggio_selezionato":
        MessageLookupByLibrary.simpleMessage(
          "Aucun kebab correspondant trouvé dans le rayon sélectionné",
        ),
    "nessun_kebab_tra_i_preferiti": MessageLookupByLibrary.simpleMessage(
      "Aucun kebab dans les favoris",
    ),
    "nessun_kebab_vicino_a_te": MessageLookupByLibrary.simpleMessage(
      "Aucun kebab près de chez vous \nVous devez être à proximité du restaurant de kebab pour l\'évaluer pour des raisons d\'authenticité.\nVérifiez votre position et rechargez la page.",
    ),
    "nessun_kebabbaro_presente": MessageLookupByLibrary.simpleMessage(
      "Aucun restaurant de kebab présent :(",
    ),
    "nessun_post_trovato": MessageLookupByLibrary.simpleMessage(
      "Aucune publication trouvée",
    ),
    "nessun_utente_seguito": MessageLookupByLibrary.simpleMessage(
      "Aucun utilisateur suivi",
    ),
    "nessun_utente_ti_segue": MessageLookupByLibrary.simpleMessage(
      "Aucun utilisateur ne te suit",
    ),
    "nessuna_recensione_ancora": MessageLookupByLibrary.simpleMessage(
      "Aucune critique pour le moment",
    ),
    "nessuna_recensione_disponibile": MessageLookupByLibrary.simpleMessage(
      "Aucune critique disponible",
    ),
    "new_card_unlocked": MessageLookupByLibrary.simpleMessage(
      "NOUVELLE CARTE DÉBLOQUÉE !",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "next_recharge_in": m21,
    "no_account_question": MessageLookupByLibrary.simpleMessage(
      "Pas encore de compte ?",
    ),
    "no_cards_available": MessageLookupByLibrary.simpleMessage(
      "Aucune carte disponible.",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas encore de cartes",
    ),
    "no_image": MessageLookupByLibrary.simpleMessage("Aucune image"),
    "no_kebab_within_distance": m22,
    "no_medals_in_filter": MessageLookupByLibrary.simpleMessage(
      "Aucune médaille dans ce filtre",
    ),
    "no_more_kebabs_to_recommend": MessageLookupByLibrary.simpleMessage(
      "Il n\'y a pas d\'autres kebabs à recommander.",
    ),
    "no_pack_ready": MessageLookupByLibrary.simpleMessage("Aucun pack prêt"),
    "no_pack_ready_hours_minutes": m23,
    "no_pack_ready_timer": m24,
    "no_photos_yet": MessageLookupByLibrary.simpleMessage(
      "Pas encore de photos",
    ),
    "no_photos_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Soyez le premier à partager une photo de votre kebab ou de votre plat ici !",
    ),
    "no_place_found_add_it": MessageLookupByLibrary.simpleMessage(
      "Aucun lieu trouvé. S\'il est nouveau, utilisez « Ajouter un kebab » !",
    ),
    "no_posts_yet": MessageLookupByLibrary.simpleMessage("Pas encore de posts"),
    "no_reviews_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Partagez votre expérience de ce lieu avec toute la communauté !",
    ),
    "no_suggestions_available": MessageLookupByLibrary.simpleMessage(
      "Aucune suggestion disponible",
    ),
    "no_thanks": MessageLookupByLibrary.simpleMessage("Non, merci"),
    "no_user_reviews_yet": MessageLookupByLibrary.simpleMessage(
      "Aucun utilisateur n\'a encore évalué ce lieu !",
    ),
    "nome_del_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Nom du restaurant de kebab",
    ),
    "nome_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nom non disponible",
    ),
    "non_segui_ancora_nessuno": MessageLookupByLibrary.simpleMessage(
      "Tu ne suis encore personne",
    ),
    "nuova_medaglia": MessageLookupByLibrary.simpleMessage(
      "Nouvelle médaille !",
    ),
    "nuovo_username": MessageLookupByLibrary.simpleMessage(
      "Nouveau nom d\'utilisateur...",
    ),
    "objectives": MessageLookupByLibrary.simpleMessage("Objectifs"),
    "objectives_and_medals": MessageLookupByLibrary.simpleMessage(
      "Objectifs et médailles",
    ),
    "one_post": MessageLookupByLibrary.simpleMessage("1 publication"),
    "one_review": MessageLookupByLibrary.simpleMessage("1 avis"),
    "onion": MessageLookupByLibrary.simpleMessage("Oignon"),
    "oops_review_not_found": MessageLookupByLibrary.simpleMessage(
      "Oups ! Critique non trouvée",
    ),
    "open_in_app": MessageLookupByLibrary.simpleMessage("Ouvrir l\'appli"),
    "open_now": MessageLookupByLibrary.simpleMessage("Ouvert Maintenant"),
    "open_or_get_app": MessageLookupByLibrary.simpleMessage(
      "Ouvrir ou télécharger l\'appli",
    ),
    "open_pack": MessageLookupByLibrary.simpleMessage("Ouvrir le pack"),
    "open_pack_two_ready": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le pack (2 prêts !)",
    ),
    "open_second_pack": m25,
    "opening_hours": MessageLookupByLibrary.simpleMessage(
      "Horaires d\'ouverture",
    ),
    "opening_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Vous pouvez les laisser non précisés, choisir un modèle ou définir des horaires personnalisés :",
    ),
    "opening_in_progress": MessageLookupByLibrary.simpleMessage("Ouverture..."),
    "or_continue_with_email": MessageLookupByLibrary.simpleMessage(
      "ou avec e-mail",
    ),
    "order_by": MessageLookupByLibrary.simpleMessage("Trier par"),
    "origin_label": MessageLookupByLibrary.simpleMessage("Origine"),
    "overall_rating_1_5": MessageLookupByLibrary.simpleMessage(
      "Note globale (1 à 5)",
    ),
    "pack": MessageLookupByLibrary.simpleMessage("Pack Kebabbo"),
    "pack_button_subtitle": MessageLookupByLibrary.simpleMessage(
      "ouvrez votre paquet kebab préféré",
    ),
    "pack_button_title": MessageLookupByLibrary.simpleMessage("Paquet"),
    "pack_too_soon": MessageLookupByLibrary.simpleMessage(
      "Ce pack n\'est pas encore disponible",
    ),
    "packs_full": MessageLookupByLibrary.simpleMessage(
      "Packs rechargés au maximum : 2 / 2 prêts ! 📦✨",
    ),
    "packs_ready_0": MessageLookupByLibrary.simpleMessage(
      "0 / 2 packs disponibles",
    ),
    "packs_ready_1": MessageLookupByLibrary.simpleMessage(
      "1 / 2 pack prêt à ouvrir",
    ),
    "packs_ready_2": MessageLookupByLibrary.simpleMessage(
      "2 / 2 packs prêts à ouvrir",
    ),
    "page_not_found": MessageLookupByLibrary.simpleMessage("Page introuvable"),
    "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "password_minimum_length": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe doit comporter au moins 6 caractères",
    ),
    "password_must_be_at_least_6_characters":
        MessageLookupByLibrary.simpleMessage(
          "Le mot de passe doit comporter au moins 6 caractères",
        ),
    "password_reset_failed": m26,
    "password_reset_success": MessageLookupByLibrary.simpleMessage(
      "Réinitialisation du mot de passe réussie",
    ),
    "paste_maps_link_prompt": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un lien Google Maps ? Collez-le ici",
    ),
    "per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab":
        MessageLookupByLibrary.simpleMessage(
          "C\'est pourquoi nous sommes là : des étudiants, comme toi, avec des années d\'expérience en tant que mangeurs de kebab.",
        ),
    "percent_completed": m27,
    "photo": MessageLookupByLibrary.simpleMessage("Photo"),
    "photo_added": MessageLookupByLibrary.simpleMessage("Photo ajoutée ! 📸"),
    "photo_caption_hint": MessageLookupByLibrary.simpleMessage(
      "Écrivez un commentaire ou décrivez votre kebab...",
    ),
    "pillars_comparison": MessageLookupByLibrary.simpleMessage(
      "Comparaison des Piliers",
    ),
    "please_enter_a_password": MessageLookupByLibrary.simpleMessage(
      "Veuillez saisir un mot de passe",
    ),
    "please_enter_a_valid_email": MessageLookupByLibrary.simpleMessage(
      "Veuillez saisir une adresse e-mail valide",
    ),
    "please_enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Veuillez saisir ton adresse e-mail",
    ),
    "please_fill_in_all_fields": MessageLookupByLibrary.simpleMessage(
      "veuillez remplir tous les champs",
    ),
    "please_log_in_to_submit_your_review": MessageLookupByLibrary.simpleMessage(
      "Connecte-toi pour soumettre ta critique",
    ),
    "popup_description": MessageLookupByLibrary.simpleMessage(
      "Afin de garantir l\'authenticité des critiques des utilisateurs, pour critiquer toi-même le kebab,\ntu dois te rendre en personne au restaurant de kebab et trouver l\'autocollant Kebabbo apposé à proximité,\nle scanner te mènera à la page de critique.",
    ),
    "popup_title": MessageLookupByLibrary.simpleMessage(
      "Comment écrire ta propre critique",
    ),
    "post_eliminato": MessageLookupByLibrary.simpleMessage(
      "Publication supprimée",
    ),
    "posts": MessageLookupByLibrary.simpleMessage("Publications"),
    "preferiti_solo_per_utenti_registrati":
        MessageLookupByLibrary.simpleMessage(
          "Favoris uniquement pour les utilisateurs enregistrés",
        ),
    "prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi":
        MessageLookupByLibrary.simpleMessage(
          "\"Prenez et mangez-en tous : ceci est le kebab offert en sacrifice pour vous.\"",
        ),
    "price": MessageLookupByLibrary.simpleMessage("Prix"),
    "prima_review": MessageLookupByLibrary.simpleMessage("première critique"),
    "primo_post": MessageLookupByLibrary.simpleMessage("première publication"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Politique de Confidentialité",
    ),
    "privacy_policy_load_error": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du chargement de la politique de confidentialité",
    ),
    "profile_link_copied": MessageLookupByLibrary.simpleMessage(
      "Lien du profil copié !",
    ),
    "progress_label": MessageLookupByLibrary.simpleMessage("Progression"),
    "publish_photo": MessageLookupByLibrary.simpleMessage("Publier la photo"),
    "publish_review": MessageLookupByLibrary.simpleMessage("Publier l\'avis"),
    "quality": MessageLookupByLibrary.simpleMessage("Qualité"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantité"),
    "queued": MessageLookupByLibrary.simpleMessage("En attente"),
    "rank_0_desc": MessageLookupByLibrary.simpleMessage(
      "Écrivez votre premier avis ou créez un post pour commencer la collection !",
    ),
    "rank_0_name": MessageLookupByLibrary.simpleMessage("Novice du kebab"),
    "rank_1_desc": MessageLookupByLibrary.simpleMessage(
      "Les premiers objectifs sont à vous ! Continuez à évaluer et à publier.",
    ),
    "rank_1_name": MessageLookupByLibrary.simpleMessage("Passionné de broches"),
    "rank_2_desc": MessageLookupByLibrary.simpleMessage(
      "Vous avez un excellent palais et une voix active dans le fil.",
    ),
    "rank_2_name": MessageLookupByLibrary.simpleMessage("Gourmet du döner"),
    "rank_3_desc": MessageLookupByLibrary.simpleMessage(
      "Un expert reconnu, en goût comme dans la communauté.",
    ),
    "rank_3_name": MessageLookupByLibrary.simpleMessage("Maître des sauces"),
    "rank_4_desc": MessageLookupByLibrary.simpleMessage(
      "Plus que quelques objectifs avant de tout compléter !",
    ),
    "rank_4_name": MessageLookupByLibrary.simpleMessage("Vétéran de Kebabbo"),
    "rank_5_desc": MessageLookupByLibrary.simpleMessage(
      "Vous avez atteint tous les objectifs ! Vous êtes dans l\'Olympe de Kebabbo.",
    ),
    "rank_5_name": MessageLookupByLibrary.simpleMessage("Légende suprême"),
    "rate_the_kebab": MessageLookupByLibrary.simpleMessage("Note le kebab"),
    "rating_title": MessageLookupByLibrary.simpleMessage("Note"),
    "ready": MessageLookupByLibrary.simpleMessage("Prêt !"),
    "recharge_info": MessageLookupByLibrary.simpleMessage(
      "1 pack se recharge toutes les 12 h (max 2)",
    ),
    "recharging_next_in": m28,
    "registrati_per_poter_visualizzare_il_feed":
        MessageLookupByLibrary.simpleMessage(
          "Inscris-toi pour voir le fil d\'actualité",
        ),
    "remaining_count": m29,
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Retirer des favoris",
    ),
    "removed_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Retiré des favoris",
    ),
    "required_field": MessageLookupByLibrary.simpleMessage("Champ obligatoire"),
    "reroll": MessageLookupByLibrary.simpleMessage("Relancer"),
    "reroll_step_1": MessageLookupByLibrary.simpleMessage(
      "👨‍🍳 Nouvelle combinaison en préparation...",
    ),
    "reroll_step_2": MessageLookupByLibrary.simpleMessage(
      "🔥 J\'équilibre épices et cuisson...",
    ),
    "reroll_step_3": MessageLookupByLibrary.simpleMessage(
      "✨ Je cherche une autre excellente proposition...",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser le mot de passe",
    ),
    "review": MessageLookupByLibrary.simpleMessage("Critique"),
    "reviewMessage": m30,
    "review_action": MessageLookupByLibrary.simpleMessage("Évaluer"),
    "review_already_exists_message": MessageLookupByLibrary.simpleMessage(
      "Un avis existe déjà pour cet établissement, souhaitez-vous l\'écraser ?",
    ),
    "review_already_exists_title": MessageLookupByLibrary.simpleMessage(
      "Avis déjà existant",
    ),
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Critique soumise avec succès",
    ),
    "review_this_kebab": MessageLookupByLibrary.simpleMessage("Noter ce Kebab"),
    "review_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Critique mise à jour avec succès",
    ),
    "reviews_label": MessageLookupByLibrary.simpleMessage("Avis"),
    "riprova": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "sandwich_tag": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "sandwiches": MessageLookupByLibrary.simpleMessage("Sandwichs"),
    "save_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Ajouter aux favoris",
    ),
    "scrivi_un_commento": MessageLookupByLibrary.simpleMessage(
      "Écris un commentaire...",
    ),
    "scrivi_un_post": MessageLookupByLibrary.simpleMessage(
      "Écris une publication...",
    ),
    "search_address_or_place": MessageLookupByLibrary.simpleMessage(
      "Rechercher une adresse ou un lieu...",
    ),
    "search_kebab_to_compare": MessageLookupByLibrary.simpleMessage(
      "Chercher un kebab à comparer...",
    ),
    "search_kebabbo_places": MessageLookupByLibrary.simpleMessage(
      "Rechercher parmi les lieux Kebabbo",
    ),
    "search_places_hint": MessageLookupByLibrary.simpleMessage(
      "Ex. Istanbul, Agra, King...",
    ),
    "second_pack_slot": MessageLookupByLibrary.simpleMessage("2e pack"),
    "section_initial_review": MessageLookupByLibrary.simpleMessage(
      "5. Votre premier avis",
    ),
    "section_location": MessageLookupByLibrary.simpleMessage(
      "1. Emplacement sur la carte 📍",
    ),
    "section_location_hint": MessageLookupByLibrary.simpleMessage(
      "Touchez pour placer l\'épingle ou chercher le lieu. Coordonnées, adresse et nom seront remplis automatiquement !",
    ),
    "section_name_category": MessageLookupByLibrary.simpleMessage(
      "2. Nom et catégorie 🌯",
    ),
    "section_opening_hours": MessageLookupByLibrary.simpleMessage(
      "3. Horaires d\'ouverture ⏰",
    ),
    "section_photo_optional": MessageLookupByLibrary.simpleMessage(
      "4. Photo du lieu (facultatif)",
    ),
    "see_hours_photos_reviews": MessageLookupByLibrary.simpleMessage(
      "Voir horaires, photos et avis",
    ),
    "see_place": MessageLookupByLibrary.simpleMessage("Voir le lieu"),
    "segui": MessageLookupByLibrary.simpleMessage("Suivre"),
    "segui_gia": MessageLookupByLibrary.simpleMessage("Déjà abonné"),
    "seguiti": MessageLookupByLibrary.simpleMessage("Abonné"),
    "select_first_kebab": MessageLookupByLibrary.simpleMessage(
      "Sélectionne le 1er kebab",
    ),
    "select_location_first": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez l\'emplacement sur la carte avant de continuer ! 📍",
    ),
    "select_on_map": MessageLookupByLibrary.simpleMessage(
      "Sélectionner sur la carte",
    ),
    "select_photo_first": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez une photo avant de publier",
    ),
    "select_place_to_review": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez le lieu à évaluer ! 🌯",
    ),
    "select_second_kebab": MessageLookupByLibrary.simpleMessage(
      "Sélectionne le 2ème kebab",
    ),
    "select_two_kebabs_to_compare": MessageLookupByLibrary.simpleMessage(
      "Sélectionne deux kebabs pour afficher la comparaison détaillée.",
    ),
    "selected_point": MessageLookupByLibrary.simpleMessage("Point sélectionné"),
    "seleziona_il_tuo_kebab_preferito": MessageLookupByLibrary.simpleMessage(
      "Sélectionne ton kebab préféré",
    ),
    "send_reset_email": MessageLookupByLibrary.simpleMessage(
      "Envoyer un e-mail de réinitialisation",
    ),
    "session_expired": MessageLookupByLibrary.simpleMessage(
      "Session expirée. Veuillez vous reconnecter.",
    ),
    "share_action": MessageLookupByLibrary.simpleMessage("Partager"),
    "share_message": m31,
    "share_more": MessageLookupByLibrary.simpleMessage("Plus"),
    "share_rating_line": m32,
    "share_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Partager ce kebab",
    ),
    "show_all_distances": MessageLookupByLibrary.simpleMessage("Tout afficher"),
    "sign_up": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "sign_up_with_google": MessageLookupByLibrary.simpleMessage(
      "S\'inscrire avec Google",
    ),
    "signup_tagline": MessageLookupByLibrary.simpleMessage(
      "Créez votre profil et commencez à évaluer les kebabs de votre ville",
    ),
    "single_card": MessageLookupByLibrary.simpleMessage("Carte Kebabbo"),
    "sort_dimension": MessageLookupByLibrary.simpleMessage("taille"),
    "sort_distance": MessageLookupByLibrary.simpleMessage("distance"),
    "sort_menu": MessageLookupByLibrary.simpleMessage("menu"),
    "sort_name": MessageLookupByLibrary.simpleMessage("nom"),
    "sort_price": MessageLookupByLibrary.simpleMessage("prix"),
    "sort_quality": MessageLookupByLibrary.simpleMessage("qualité"),
    "sort_stars": MessageLookupByLibrary.simpleMessage("étoiles"),
    "sovrascrivi": MessageLookupByLibrary.simpleMessage("Écraser"),
    "spicy": MessageLookupByLibrary.simpleMessage("Épicé"),
    "staff": MessageLookupByLibrary.simpleMessage("Équipe"),
    "staff_certified": MessageLookupByLibrary.simpleMessage(
      "Certifié Staff Kebabbo",
    ),
    "staff_kebabbo": MessageLookupByLibrary.simpleMessage("Équipe Kebabbo"),
    "submit_review": MessageLookupByLibrary.simpleMessage(
      "Soumettre une critique",
    ),
    "successfully_updated_profile": MessageLookupByLibrary.simpleMessage(
      "Profil mis à jour avec succès !",
    ),
    "swipe_collection_hint": MessageLookupByLibrary.simpleMessage(
      "Faites glisser pour parcourir la collection",
    ),
    "tab_overview": MessageLookupByLibrary.simpleMessage("Aperçu"),
    "tab_photos": m33,
    "tab_reviews": m34,
    "tag_kebab_pill": MessageLookupByLibrary.simpleMessage("Kebab 🌯"),
    "tag_sandwich_pill": MessageLookupByLibrary.simpleMessage(
      "Sandwicherie 🥪",
    ),
    "tap_map_to_select": MessageLookupByLibrary.simpleMessage(
      "Touchez la carte pour choisir l\'emplacement exact",
    ),
    "tap_to_browse_album": MessageLookupByLibrary.simpleMessage(
      "Touchez pour parcourir l\'album complet ›",
    ),
    "tap_to_open_pack": MessageLookupByLibrary.simpleMessage(
      "Touchez pour ouvrir le pack !",
    ),
    "tap_to_select_photo": MessageLookupByLibrary.simpleMessage(
      "Touchez pour choisir une photo",
    ),
    "tcg_album": MessageLookupByLibrary.simpleMessage("Album de cartes TCG"),
    "tcg_cards_count": m35,
    "ten_posts": MessageLookupByLibrary.simpleMessage("10 publications"),
    "ten_reviews": MessageLookupByLibrary.simpleMessage("10 avis"),
    "testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo":
        MessageLookupByLibrary.simpleMessage(
          "Nous testons et critiquons les restaurants de kebab et la cuisine de rue pour toi. Bienvenue sur Kebabbo.",
        ),
    "testo_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Texte non disponible",
    ),
    "thank_you": MessageLookupByLibrary.simpleMessage("Merci"),
    "thank_you_for_your_review": MessageLookupByLibrary.simpleMessage(
      "Merci pour ta critique !",
    ),
    "thirty_reviews": MessageLookupByLibrary.simpleMessage("30 avis"),
    "twenty_reviews": MessageLookupByLibrary.simpleMessage("20 avis"),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Une erreur inattendue s\'est produite",
    ),
    "unit_posts": MessageLookupByLibrary.simpleMessage("posts"),
    "unit_reviews": MessageLookupByLibrary.simpleMessage("avis"),
    "unlocked_badge": MessageLookupByLibrary.simpleMessage("Débloquée"),
    "unlocked_of_total": m36,
    "unpack_and_view_collection": MessageLookupByLibrary.simpleMessage(
      "Déballer et voir la collection",
    ),
    "unpack_new_cards": MessageLookupByLibrary.simpleMessage(
      "Déballez de nouvelles cartes",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Mettre à jour"),
    "upload": MessageLookupByLibrary.simpleMessage("Téléverser"),
    "upload_error": m37,
    "upload_first_photo": MessageLookupByLibrary.simpleMessage(
      "Ajouter la première photo",
    ),
    "upload_place_photo": MessageLookupByLibrary.simpleMessage(
      "Ajoutez une photo de la broche ou du lieu",
    ),
    "user_generic": MessageLookupByLibrary.simpleMessage("Utilisateur"),
    "user_no_posts_desc": MessageLookupByLibrary.simpleMessage(
      "Cet utilisateur n\'a encore rien publié dans le fil.",
    ),
    "user_no_reviews_desc": MessageLookupByLibrary.simpleMessage(
      "Cet utilisateur n\'a encore évalué aucun kebab.",
    ),
    "user_not_authenticated": MessageLookupByLibrary.simpleMessage(
      "Utilisateur non authentifié",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage(
      "Utilisateur non trouvé",
    ),
    "user_not_found_login_again": MessageLookupByLibrary.simpleMessage(
      "Utilisateur introuvable. Veuillez vous reconnecter.",
    ),
    "username_can_only_contain_letters_numbers_and_underscores":
        MessageLookupByLibrary.simpleMessage(
          "Le nom d\'utilisateur ne peut contenir que des lettres,\ndes chiffres et des traits de soulignement !",
        ),
    "username_cannot_be_more_than_12_characters":
        MessageLookupByLibrary.simpleMessage(
          "Le nom d\'utilisateur ne peut pas comporter plus de\n12 caractères !",
        ),
    "username_cannot_contain_spaces_use_undescores_instead":
        MessageLookupByLibrary.simpleMessage(
          "Le nom d\'utilisateur ne peut pas contenir d\'espaces,\nutilise des traits de soulignement à la place !",
        ),
    "username_must_be_at_least_3_characters_long":
        MessageLookupByLibrary.simpleMessage(
          "Le nom d\'utilisateur doit comporter au moins 3\ncaractères !",
        ),
    "users": MessageLookupByLibrary.simpleMessage("Utilisateurs"),
    "users_count": m38,
    "users_review": MessageLookupByLibrary.simpleMessage(
      "Critique des utilisateurs",
    ),
    "vegetables": MessageLookupByLibrary.simpleMessage("Légumes"),
    "verdura": MessageLookupByLibrary.simpleMessage("Légumes"),
    "verified_by_staff_tooltip": MessageLookupByLibrary.simpleMessage(
      "Vérifié par l\'équipe Kebabbo",
    ),
    "vuoi_veramente_eliminare_il_post": MessageLookupByLibrary.simpleMessage(
      "Veux-tu vraiment supprimer la publication ?",
    ),
    "world": MessageLookupByLibrary.simpleMessage("Monde"),
    "write_a_review_for_a_kebab_near_you": MessageLookupByLibrary.simpleMessage(
      "Écris une critique",
    ),
    "write_first_review": MessageLookupByLibrary.simpleMessage(
      "Écrire le premier avis",
    ),
    "write_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Notez la qualité, la viande et les sauces",
    ),
    "write_review_title": MessageLookupByLibrary.simpleMessage(
      "Écrire un avis",
    ),
    "yes_create_new": MessageLookupByLibrary.simpleMessage(
      "Oui, créer nouveau",
    ),
    "yogurt": MessageLookupByLibrary.simpleMessage("Yaourt"),
    "you_can_access_reviews_at_any_time_from_your_account":
        MessageLookupByLibrary.simpleMessage(
          "Tu peux accéder aux critiques à tout moment depuis ton compte.",
        ),
    "your_experience": MessageLookupByLibrary.simpleMessage("Votre expérience"),
    "your_kebab": MessageLookupByLibrary.simpleMessage("Ton kebab"),
    "your_medals_title": MessageLookupByLibrary.simpleMessage("Vos Médailles"),
    "your_profile": MessageLookupByLibrary.simpleMessage("Votre profil"),
    "your_review_optional": MessageLookupByLibrary.simpleMessage(
      "Votre avis (optionnel)",
    ),
  };
}
