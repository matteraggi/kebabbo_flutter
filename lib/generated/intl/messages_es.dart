// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(name) => "Añadir foto a ${name}";

  static String m1(name) => "${name} (ya en la colección)";

  static String m2(error) => "Se ha producido un error: ${error}";

  static String m3(count) => "Basado en ${count} reseñas";

  static String m4(current, total) => "#${current} de ${total}";

  static String m5(style) => "Cambiar mapa: ${style}";

  static String m6(city) => "Ciudad: ${city}";

  static String m7(count) => "Comunidad (${count})";

  static String m8(results) => "10 km (${results} resultados)";

  static String m9(results) => "1 km (${results} resultados)";

  static String m10(results) => "200 metros (${results} resultados)";

  static String m11(results) => "500 metros (${results} resultados)";

  static String m12(results) => "Ilimitado (${results} resultados)";

  static String m13(error) => "Error al eliminar la publicación: ${error}";

  static String m14(error) => "Error al guardar: ${error}";

  static String m15(error) => "Error al enviar la reseña: ${error}";

  static String m16(count) => "Todas (${count})";

  static String m17(count) => "Reseñas (${count})";

  static String m18(count) => "Desbloqueadas (${count})";

  static String m19(missing, unit) =>
      "¡Solo te faltan ${missing} ${unit} para desbloquear esta medalla!";

  static String m20(count) => "faltan ${count}";

  static String m21(time) => "Próxima recarga en ${time}";

  static String m22(hours, minutes) =>
      "No hay ningún paquete listo (0/2). El próximo estará listo en ${hours} h ${minutes} min.";

  static String m23(time) =>
      "No hay ningún paquete listo. El próximo estará disponible en ${time}.";

  static String m24(count) => "Abrir 2.º paquete (${count})";

  static String m25(error) => "No se pudo restablecer la contraseña: ${error}";

  static String m26(percent) => "${percent}% completado";

  static String m27(time) => "Recargando: el próximo en ${time}";

  static String m28(count) => "${count} restantes";

  static String m29(
    kebabName,
    qualityRating,
    quantityRating,
    menuRating,
    priceRating,
    funRating,
    description,
  ) =>
      "¡Acabo de reseñar el kebab en ${kebabName}!\n\nCalidad: ${qualityRating}\nCantidad: ${quantityRating}\nMenú: ${menuRating}\nPrecio: ${priceRating}\nDiversión: ${funRating}\n\n${description}";

  static String m30(count) => "Fotos (${count})";

  static String m31(count) => "Reseñas (${count})";

  static String m32(unlocked, total) => "${unlocked} de ${total} desbloqueadas";

  static String m33(error) => "Error al subir: ${error}";

  static String m34(count) => "Usuarios (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
    "accedi_per_cercare": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para publicar y ver la información de las personas",
    ),
    "add_dish_photo_optional": MessageLookupByLibrary.simpleMessage(
      "Añade una foto de tu plato (opcional)",
    ),
    "add_kebab": MessageLookupByLibrary.simpleMessage("Añadir un Kebab"),
    "add_kebab_place": MessageLookupByLibrary.simpleMessage(
      "Añadir un sitio de kebab",
    ),
    "add_kebab_place_subtitle": MessageLookupByLibrary.simpleMessage(
      "Añade un nuevo local al mapa",
    ),
    "add_kebab_to_kebabbo": MessageLookupByLibrary.simpleMessage(
      "Añadir local a Kebabbo",
    ),
    "add_new_kebab_confirmation": MessageLookupByLibrary.simpleMessage(
      "Estás a punto de añadir \"\$name\" como un nuevo kebab. ¿Seguro que no existe ya?",
    ),
    "add_photo_to": m0,
    "add_review_appbar_title": MessageLookupByLibrary.simpleMessage(
      "Añadir Reseña",
    ),
    "add_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "¿Probaste un kebab nuevo?",
    ),
    "add_review_title": MessageLookupByLibrary.simpleMessage("Añadir Reseña"),
    "add_to_collection": MessageLookupByLibrary.simpleMessage(
      "Añadir a la colección",
    ),
    "added_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Añadido a favoritos ❤️",
    ),
    "advanced_filters": MessageLookupByLibrary.simpleMessage(
      "Filtros Avanzados",
    ),
    "all_filter": MessageLookupByLibrary.simpleMessage("Todos"),
    "all_found": MessageLookupByLibrary.simpleMessage("¡Todas encontradas! 🏆"),
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "¿Ya tienes una cuenta? Inicia sesión",
    ),
    "already_in_collection": m1,
    "an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Se ha producido un error",
    ),
    "an_error_occurred_with": m2,
    "annulla": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "anonimo": MessageLookupByLibrary.simpleMessage("Anónimo"),
    "aperti_ora": MessageLookupByLibrary.simpleMessage("Abierto ahora"),
    "aperto": MessageLookupByLibrary.simpleMessage("Abierto"),
    "app_is_installed": MessageLookupByLibrary.simpleMessage(
      "¡Kebabbo también es una app!",
    ),
    "app_is_installed_description": MessageLookupByLibrary.simpleMessage(
      "Ábrelo en la app para una mejor experiencia. Si aún no la tienes, te llevamos a Google Play.",
    ),
    "autenticazione_necessaria": MessageLookupByLibrary.simpleMessage(
      "Du musst angemeldet sein, um zu kommentieren.",
    ),
    "back_to_build": MessageLookupByLibrary.simpleMessage("Volver a construir"),
    "based_on_reviews": m3,
    "build_button": MessageLookupByLibrary.simpleMessage("¡Construir!"),
    "build_your_kebab": MessageLookupByLibrary.simpleMessage(
      "Construye tu kebab",
    ),
    "by_signing_in_you_agree_to_our_terms_and_privacy_policy":
        MessageLookupByLibrary.simpleMessage(
          "Al iniciar sesión, aceptas nuestros términos y política de privacidad.",
        ),
    "cambia_profilepic": MessageLookupByLibrary.simpleMessage(
      "cambiar foto de perfil",
    ),
    "cambia_profilo": MessageLookupByLibrary.simpleMessage("cambiar perfil"),
    "cambia_username": MessageLookupByLibrary.simpleMessage(
      "Cambiar nombre de usuario",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "card_collection": MessageLookupByLibrary.simpleMessage(
      "Colección de cartas",
    ),
    "card_x_of_y": m4,
    "cards_unlocked": MessageLookupByLibrary.simpleMessage(
      "cartas desbloqueadas",
    ),
    "center_on_my_location": MessageLookupByLibrary.simpleMessage(
      "Centrar en mi ubicación",
    ),
    "cerca_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Busca un lugar de kebab...",
    ),
    "cerca_utenti": MessageLookupByLibrary.simpleMessage("Buscar usuarios..."),
    "change": MessageLookupByLibrary.simpleMessage("Cambiar"),
    "change_map_style": m5,
    "check_your_email_for_a_login_link": MessageLookupByLibrary.simpleMessage(
      "¡Revisa tu correo electrónico para obtener un enlace de inicio de sesión!",
    ),
    "check_your_email_for_a_reset_link": MessageLookupByLibrary.simpleMessage(
      "Consulta tu correo electrónico para obtener un enlace de restablecimiento",
    ),
    "check_your_email_for_a_verification_link":
        MessageLookupByLibrary.simpleMessage(
          "Revisa tu correo electrónico para obtener un enlace de verificación",
        ),
    "chiuso": MessageLookupByLibrary.simpleMessage("Cerrado"),
    "choose_on_map_recommended": MessageLookupByLibrary.simpleMessage(
      "Elegir en el mapa (recomendado)",
    ),
    "choose_place": MessageLookupByLibrary.simpleMessage("Elige el local"),
    "cipolla": MessageLookupByLibrary.simpleMessage("Cebolla"),
    "city": MessageLookupByLibrary.simpleMessage("Ciudad"),
    "city_label": m6,
    "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "collection_subtitle": MessageLookupByLibrary.simpleMessage(
      "revisa tus cartas kebabbo",
    ),
    "collection_title": MessageLookupByLibrary.simpleMessage("Colección"),
    "comment_review_hint": MessageLookupByLibrary.simpleMessage(
      "¿Qué te gustó más? ¿Recomiendas alguna salsa o menú?",
    ),
    "comment_review_label": MessageLookupByLibrary.simpleMessage(
      "Comentario / reseña *",
    ),
    "comment_review_required": MessageLookupByLibrary.simpleMessage(
      "Escribe un breve comentario sobre tu experiencia",
    ),
    "commento_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Comentario no disponible",
    ),
    "commento_vuoto": MessageLookupByLibrary.simpleMessage(
      "Der Kommentartext darf nicht leer sein.",
    ),
    "community_count": m7,
    "community_review": MessageLookupByLibrary.simpleMessage(
      "Reseña de la comunidad",
    ),
    "community_upload": MessageLookupByLibrary.simpleMessage("Comunidad"),
    "compare_kebabs": MessageLookupByLibrary.simpleMessage("Comparar Kebabs"),
    "completed_badge": MessageLookupByLibrary.simpleMessage("¡Completado! ⭐"),
    "conferma_eliminazione": MessageLookupByLibrary.simpleMessage(
      "Confirmar eliminación",
    ),
    "confirm_this_location": MessageLookupByLibrary.simpleMessage(
      "Confirmar esta ubicación",
    ),
    "congratulazioni": MessageLookupByLibrary.simpleMessage("¡Felicidades!"),
    "consigliaci_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Recomienda un lugar de kebab",
    ),
    "contribute_subtitle": MessageLookupByLibrary.simpleMessage(
      "¡Ayúdanos a mapear y reseñar los mejores sitios de kebab!",
    ),
    "contribute_title": MessageLookupByLibrary.simpleMessage(
      "Contribuye a Kebabbo",
    ),
    "cooking_step_1": MessageLookupByLibrary.simpleMessage(
      "🔥 Calentando el pan...",
    ),
    "cooking_step_2": MessageLookupByLibrary.simpleMessage(
      "🥩 Cortando la carne del asador...",
    ),
    "cooking_step_3": MessageLookupByLibrary.simpleMessage(
      "🥗 Añadiendo verduras frescas y salsas...",
    ),
    "cooking_step_4": MessageLookupByLibrary.simpleMessage(
      "🌯 Enrollándolo como un profesional...",
    ),
    "cooking_step_5": MessageLookupByLibrary.simpleMessage(
      "🔍 Buscando el mejor kebab para ti...",
    ),
    "cooking_title": MessageLookupByLibrary.simpleMessage(
      "Preparando el kebab",
    ),
    "cooking_title_reroll": MessageLookupByLibrary.simpleMessage(
      "Buscando otra opción",
    ),
    "could_not_open_link": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el enlace.",
    ),
    "create_kebab_subtitle": MessageLookupByLibrary.simpleMessage(
      "construye tu propio kebab",
    ),
    "create_kebab_title": MessageLookupByLibrary.simpleMessage("Crear Kebab"),
    "custom_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Indica el horario de cada día (ej. 11:00-23:00 o \"cerrado\"):",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Descripción"),
    "description_is_required": MessageLookupByLibrary.simpleMessage(
      "Se requiere descripción",
    ),
    "description_review_hint": MessageLookupByLibrary.simpleMessage(
      "Cuéntanos cómo es este kebab: pan, carne, sabores...",
    ),
    "description_review_label": MessageLookupByLibrary.simpleMessage(
      "Descripción / reseña *",
    ),
    "description_review_required": MessageLookupByLibrary.simpleMessage(
      "Escribe un breve comentario para presentar el local",
    ),
    "descrizione_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Descripción no disponible",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Detalles"),
    "devi_essere_autenticato_per_commentare":
        MessageLookupByLibrary.simpleMessage(
          "Debes iniciar sesión para comentar",
        ),
    "devi_essere_autenticato_per_mettere_mi_piace":
        MessageLookupByLibrary.simpleMessage(
          "Debes iniciar sesión para dar me gusta",
        ),
    "devi_essere_autenticato_per_postare": MessageLookupByLibrary.simpleMessage(
      "Debes estar autenticado para publicar",
    ),
    "devi_essere_autenticato_per_visualizzare_il_profilo":
        MessageLookupByLibrary.simpleMessage(
          "Debes iniciar sesión para ver el perfil",
        ),
    "dimension": MessageLookupByLibrary.simpleMessage("Tamaño"),
    "directions": MessageLookupByLibrary.simpleMessage("Cómo llegar"),
    "distanceLabel10km": m8,
    "distanceLabel1km": m9,
    "distanceLabel200m": m10,
    "distanceLabel500m": m11,
    "distanceLabelUnlimited": m12,
    "distanza_massima": MessageLookupByLibrary.simpleMessage(
      "Distancia máxima",
    ),
    "distanza_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Distancia no disponible",
    ),
    "dont_have_an_account_sign_up": MessageLookupByLibrary.simpleMessage(
      "¿No tienes una cuenta? Registrarse",
    ),
    "drag_to_tilt": MessageLookupByLibrary.simpleMessage(
      "Arrastra con el dedo para inclinar en 3D",
    ),
    "duplicate_card": MessageLookupByLibrary.simpleMessage("CARTA REPETIDA"),
    "edit_location_on_map": MessageLookupByLibrary.simpleMessage(
      "Editar ubicación en el mapa",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
    "elimina": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "email": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "email_required": MessageLookupByLibrary.simpleMessage(
      "El correo electrónico es obligatorio",
    ),
    "enter_place_name": MessageLookupByLibrary.simpleMessage(
      "Introduce el nombre del local",
    ),
    "error_adding_review": MessageLookupByLibrary.simpleMessage(
      "Error al añadir reseña: ",
    ),
    "error_deleting_post": m13,
    "error_loading_kebabs": MessageLookupByLibrary.simpleMessage(
      "Error al cargar los kebabs: ",
    ),
    "error_processing_image": MessageLookupByLibrary.simpleMessage(
      "Error al procesar la imagen:",
    ),
    "error_saving": m14,
    "error_sending_review": m15,
    "errore": MessageLookupByLibrary.simpleMessage("Error:"),
    "errore_nel_caricamento_dei_follower": MessageLookupByLibrary.simpleMessage(
      "Error al cargar seguidores",
    ),
    "errore_nel_caricamento_dellimage": MessageLookupByLibrary.simpleMessage(
      "Error al cargar la imagen:",
    ),
    "esplora": MessageLookupByLibrary.simpleMessage("Explorar"),
    "examine_3d": MessageLookupByLibrary.simpleMessage("Examinar en 3D"),
    "extract": MessageLookupByLibrary.simpleMessage("Extraer"),
    "failed_to_load_favorites": MessageLookupByLibrary.simpleMessage(
      "Error al cargar los favoritos",
    ),
    "failed_to_load_follower_count": MessageLookupByLibrary.simpleMessage(
      "Error al cargar el recuento de seguidores",
    ),
    "failed_to_load_medals": MessageLookupByLibrary.simpleMessage(
      "Error al cargar las medallas",
    ),
    "failed_to_load_post_count": MessageLookupByLibrary.simpleMessage(
      "Error al cargar el recuento de publicaciones",
    ),
    "failed_to_load_posts": MessageLookupByLibrary.simpleMessage(
      "Error al cargar las publicaciones",
    ),
    "failed_to_load_profile": MessageLookupByLibrary.simpleMessage(
      "Error al cargar el perfil",
    ),
    "failed_to_load_reviews_count": MessageLookupByLibrary.simpleMessage(
      "Error al cargar el recuento de reseñas",
    ),
    "failed_to_update_follow_status": MessageLookupByLibrary.simpleMessage(
      "Error al actualizar el estado de seguimiento",
    ),
    "failed_to_upload_avatar": MessageLookupByLibrary.simpleMessage(
      "Error al subir el avatar",
    ),
    "feed_posts_label": MessageLookupByLibrary.simpleMessage("Publicaciones"),
    "fifty_posts": MessageLookupByLibrary.simpleMessage("50 publicaciones"),
    "filter_all_count": m16,
    "filter_by_distance": MessageLookupByLibrary.simpleMessage(
      "Filtrar por distancia",
    ),
    "filter_reviews_count": m17,
    "filter_unlocked_count": m18,
    "first_pack_slot": MessageLookupByLibrary.simpleMessage("1.er paquete"),
    "first_time_description": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenido a Kebabbo!\n¿Qué puedes hacer aquí?\nBueno, puedes explorar nuestras reseñas profesionales de kebab o consultar las valoraciones de otros usuarios.\nEscribe tu propia reseña escaneando la pegatina de Kebabbo en el lugar de kebab.\nConsulta los perfiles y publicaciones de otros usuarios, conéctate con otros amantes del kebab y gana logros por usar la aplicación.\nUtiliza nuestras funciones de búsqueda y filtro o nuestra potente herramienta de creación para encontrar tu kebab ideal o explora nuestro mapa interactivo para descubrir joyas cercanas.\n¡Diviértete y a por el kebab!",
    ),
    "first_time_title": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenido a Kebabbo!",
    ),
    "five_posts": MessageLookupByLibrary.simpleMessage("5 publicaciones"),
    "five_reviews": MessageLookupByLibrary.simpleMessage("5 reseñas"),
    "followed_filter": MessageLookupByLibrary.simpleMessage("Seguidos"),
    "followers": MessageLookupByLibrary.simpleMessage("Seguidores"),
    "following": MessageLookupByLibrary.simpleMessage("Seguidos"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "Olvidé mi contraseña",
    ),
    "found_all_cards": MessageLookupByLibrary.simpleMessage(
      "Todas las tarjetas encontradas.",
    ),
    "fun": MessageLookupByLibrary.simpleMessage("Diversión"),
    "fun_exclamation": MessageLookupByLibrary.simpleMessage("¡divertido!"),
    "games_tools_title": MessageLookupByLibrary.simpleMessage(
      "Juegos y Herramientas",
    ),
    "generic_error": MessageLookupByLibrary.simpleMessage("Error: "),
    "gluten_free": MessageLookupByLibrary.simpleMessage("Sin Gluten"),
    "gluten_free_option": MessageLookupByLibrary.simpleMessage(
      "Opción sin gluten",
    ),
    "gluten_free_option_desc": MessageLookupByLibrary.simpleMessage(
      "Ofrece pan u opciones sin gluten certificadas",
    ),
    "go_back": MessageLookupByLibrary.simpleMessage("Volver"),
    "goal_reached": MessageLookupByLibrary.simpleMessage("Logro conseguido 🎉"),
    "google_maps_link": MessageLookupByLibrary.simpleMessage(
      "Enlace de Google Maps",
    ),
    "hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia":
        MessageLookupByLibrary.simpleMessage(
          "Has alcanzado un nuevo hito y has obtenido una nueva medalla.",
        ),
    "hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo":
        MessageLookupByLibrary.simpleMessage(
          "Recibiste una nueva medalla por tu contribución.",
        ),
    "have_account_question": MessageLookupByLibrary.simpleMessage(
      "¿Ya tienes cuenta?",
    ),
    "hours_none_note": MessageLookupByLibrary.simpleMessage(
      "No se guardará ningún horario.",
    ),
    "hours_preset_continuous": MessageLookupByLibrary.simpleMessage(
      "Continuo (11-23) 🌯",
    ),
    "hours_preset_custom": MessageLookupByLibrary.simpleMessage(
      "Personalizado ⚙️",
    ),
    "hours_preset_lunch_dinner": MessageLookupByLibrary.simpleMessage(
      "Comida y cena 🍽️",
    ),
    "hours_preset_night": MessageLookupByLibrary.simpleMessage(
      "Nocturno (11-02) 🌙",
    ),
    "hours_preset_none": MessageLookupByLibrary.simpleMessage(
      "Sin especificar (predeterminado)",
    ),
    "i_tuoi_post": MessageLookupByLibrary.simpleMessage("Tus publicaciones"),
    "il_commento_e_stato_aggiunto_con_successo":
        MessageLookupByLibrary.simpleMessage(
          "El comentario se agregó correctamente.",
        ),
    "il_kebab_che_ti_raccomandiamo_e": MessageLookupByLibrary.simpleMessage(
      "El kebab que te recomendamos es:",
    ),
    "il_testo_non_puo_essere_vuoto": MessageLookupByLibrary.simpleMessage(
      "El texto no puede estar vacío",
    ),
    "in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google":
        MessageLookupByLibrary.simpleMessage(
          "En Italia, el mundo del kebab sigue siendo un mundo oscuro. Los mejores lugares están infravalorados y los peores reciben buenas críticas en Google.",
        ),
    "in_progress": MessageLookupByLibrary.simpleMessage("En curso ⏳"),
    "ingredient_amounts_caps": MessageLookupByLibrary.simpleMessage(
      "CANTIDAD DE INGREDIENTES",
    ),
    "ingredient_balance": MessageLookupByLibrary.simpleMessage(
      "Equilibrio de ingredientes",
    ),
    "ingredient_balance_1_10": MessageLookupByLibrary.simpleMessage(
      "Equilibrio de ingredientes (1 a 10)",
    ),
    "ingredients_comparison": MessageLookupByLibrary.simpleMessage(
      "Comparación de Ingredientes",
    ),
    "inserted_by": MessageLookupByLibrary.simpleMessage("Añadido por"),
    "invia": MessageLookupByLibrary.simpleMessage("Enviar"),
    "it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again":
        MessageLookupByLibrary.simpleMessage(
          "Parece que la reseña a la que intentas acceder no existe. Comprueba el enlace y vuelve a intentarlo.",
        ),
    "kebab_already_exists": MessageLookupByLibrary.simpleMessage(
      "El kebab ya existe",
    ),
    "kebab_consigliato": MessageLookupByLibrary.simpleMessage(
      "Kebab recomendado",
    ),
    "kebab_no_longer_available": MessageLookupByLibrary.simpleMessage(
      "Kebab ya no disponible",
    ),
    "kebab_not_found": MessageLookupByLibrary.simpleMessage(
      "Kebab no encontrado",
    ),
    "kebab_place_name_hint": MessageLookupByLibrary.simpleMessage(
      "Ej. Bella Istanbul 3",
    ),
    "kebab_place_name_label": MessageLookupByLibrary.simpleMessage(
      "Nombre del local *",
    ),
    "kebab_place_not_found": MessageLookupByLibrary.simpleMessage(
      "Local no encontrado o eliminado.",
    ),
    "kebab_sconosciuto": MessageLookupByLibrary.simpleMessage(
      "Kebab desconocido",
    ),
    "kebab_tag": MessageLookupByLibrary.simpleMessage("Kebab"),
    "kebabbo_review": MessageLookupByLibrary.simpleMessage("Reseña Kebabbo"),
    "kebabbo_staff_review": MessageLookupByLibrary.simpleMessage(
      "La reseña de Kebabbo",
    ),
    "kebabbo_user": MessageLookupByLibrary.simpleMessage("Usuario de Kebabbo"),
    "km_distante_da_te": MessageLookupByLibrary.simpleMessage(
      "km de distancia de ti",
    ),
    "la_tua_soluzione_per_il_pranzo_universitario":
        MessageLookupByLibrary.simpleMessage(
          "Tu solución para el almuerzo universitario",
        ),
    "legends": MessageLookupByLibrary.simpleMessage("Leyendas"),
    "location_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Permiso de ubicación denegado.",
    ),
    "location_permission_denied_forever": MessageLookupByLibrary.simpleMessage(
      "Permiso de ubicación denegado permanentemente. Puedes activarlo en los ajustes.",
    ),
    "location_selected": MessageLookupByLibrary.simpleMessage(
      "Ubicación seleccionada",
    ),
    "location_services_disabled": MessageLookupByLibrary.simpleMessage(
      "Los servicios de ubicación están desactivados.",
    ),
    "log_in_con_google": MessageLookupByLibrary.simpleMessage(
      "Iniciar sesión con Google",
    ),
    "logged_in": MessageLookupByLibrary.simpleMessage("Sesión iniciada"),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "login_required_section": MessageLookupByLibrary.simpleMessage(
      "Debes iniciar sesión para usar esta sección.",
    ),
    "login_tagline": MessageLookupByLibrary.simpleMessage(
      "Únete a la comunidad para descubrir y reseñar los mejores kebabs",
    ),
    "login_to_post_photos": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para publicar fotos",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "map_not_available": MessageLookupByLibrary.simpleMessage(
      "Mapa no disponible para este local",
    ),
    "map_style_google_road": MessageLookupByLibrary.simpleMessage(
      "Google Callejero",
    ),
    "map_style_google_satellite": MessageLookupByLibrary.simpleMessage(
      "Google Satélite",
    ),
    "map_style_road_short": MessageLookupByLibrary.simpleMessage("Calles"),
    "map_style_satellite_short": MessageLookupByLibrary.simpleMessage(
      "Satélite",
    ),
    "mappa": MessageLookupByLibrary.simpleMessage("Mapa"),
    "maps_link_coords_found": MessageLookupByLibrary.simpleMessage(
      "¡Coordenadas detectadas en el enlace de Maps! 📍",
    ),
    "maps_link_failed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron extraer las coordenadas del enlace. Usa \"Elegir en el mapa\".",
    ),
    "maps_link_name_and_coords_found": MessageLookupByLibrary.simpleMessage(
      "¡Coordenadas y nombre detectados en el enlace de Maps! 📍",
    ),
    "max_charge_reached": MessageLookupByLibrary.simpleMessage(
      "Carga máxima alcanzada (1 cada 12 h)",
    ),
    "meat": MessageLookupByLibrary.simpleMessage("Carne"),
    "medal_0_desc": MessageLookupByLibrary.simpleMessage(
      "Has escrito tu primera reseña de un local de kebab. ¡Bienvenido a la familia de críticos de Kebabbo!",
    ),
    "medal_0_title": MessageLookupByLibrary.simpleMessage("Primer bocado"),
    "medal_1_desc": MessageLookupByLibrary.simpleMessage(
      "Has reseñado 5 locales distintos. ¡Tu paladar empieza a distinguir el verdadero arte del asador!",
    ),
    "medal_1_title": MessageLookupByLibrary.simpleMessage("Catador en serie"),
    "medal_2_desc": MessageLookupByLibrary.simpleMessage(
      "¡10 reseñas completadas! Tus valoraciones orientan a los locales y a toda la comunidad.",
    ),
    "medal_2_title": MessageLookupByLibrary.simpleMessage("Crítico de kebab"),
    "medal_3_desc": MessageLookupByLibrary.simpleMessage(
      "¡20 reseñas escritas! Ningún rollo, salsa o pan de pita tiene secretos para ti. ¡Un verdadero maestro!",
    ),
    "medal_3_title": MessageLookupByLibrary.simpleMessage("Maestro del asador"),
    "medal_4_desc": MessageLookupByLibrary.simpleMessage(
      "¡30 reseñas en tu haber! Has alcanzado la cima de la experiencia culinaria de Kebabbo. ¡Una leyenda viviente!",
    ),
    "medal_4_title": MessageLookupByLibrary.simpleMessage(
      "Leyenda gastronómica",
    ),
    "medal_5_desc": MessageLookupByLibrary.simpleMessage(
      "Has publicado tu primera publicación en el feed. ¡Tu pasión por el kebab ya es pública!",
    ),
    "medal_5_title": MessageLookupByLibrary.simpleMessage("Voz del feed"),
    "medal_6_desc": MessageLookupByLibrary.simpleMessage(
      "Has compartido 5 publicaciones con fotos y opiniones. ¡A la comunidad le encantan tus novedades!",
    ),
    "medal_6_title": MessageLookupByLibrary.simpleMessage(
      "Reportero del sabor",
    ),
    "medal_7_desc": MessageLookupByLibrary.simpleMessage(
      "¡10 publicaciones compartidas! Con tus fotos y etiquetas das hambre a toda la ciudad.",
    ),
    "medal_7_title": MessageLookupByLibrary.simpleMessage(
      "Influencer del kebab",
    ),
    "medal_8_desc": MessageLookupByLibrary.simpleMessage(
      "¡50 publicaciones en la comunidad! ¡Eres un pilar insustituible del feed de Kebabbo!",
    ),
    "medal_8_title": MessageLookupByLibrary.simpleMessage(
      "Pilar de la comunidad",
    ),
    "medal_missing": m19,
    "medals_page_title": MessageLookupByLibrary.simpleMessage(
      "Medallas y logros",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menú"),
    "missing_count": m20,
    "more_info": MessageLookupByLibrary.simpleMessage("Cómo reseñar un kebab"),
    "my_cards": MessageLookupByLibrary.simpleMessage("Colección Kebab TCG"),
    "name_autofilled_helper": MessageLookupByLibrary.simpleMessage(
      "Rellenado automáticamente desde el mapa (puedes editarlo)",
    ),
    "name_label": MessageLookupByLibrary.simpleMessage("Nombre"),
    "nav_account": MessageLookupByLibrary.simpleMessage("Cuenta"),
    "nav_add": MessageLookupByLibrary.simpleMessage("Añadir"),
    "nav_feed": MessageLookupByLibrary.simpleMessage("Feed"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Inicio"),
    "nessun_commento_disponibile": MessageLookupByLibrary.simpleMessage(
      "No hay comentarios disponibles",
    ),
    "nessun_kebab_corrispondente_trovato_nel_raggio_selezionato":
        MessageLookupByLibrary.simpleMessage(
          "No se encontró ningún kebab coincidente dentro del radio seleccionado",
        ),
    "nessun_kebab_tra_i_preferiti": MessageLookupByLibrary.simpleMessage(
      "No hay kebabs en favoritos",
    ),
    "nessun_kebab_vicino_a_te": MessageLookupByLibrary.simpleMessage(
      "No hay kebabs cerca de ti \nDebes estar cerca del local de kebab para reseñarlo por razones de autenticidad.\nComprueba tu ubicación y recarga la página.",
    ),
    "nessun_kebabbaro_presente": MessageLookupByLibrary.simpleMessage(
      "No hay lugares de kebab presentes :(",
    ),
    "nessun_post_trovato": MessageLookupByLibrary.simpleMessage(
      "No se encontraron publicaciones",
    ),
    "nessun_utente_seguito": MessageLookupByLibrary.simpleMessage(
      "No hay usuarios seguidos",
    ),
    "nessun_utente_ti_segue": MessageLookupByLibrary.simpleMessage(
      "Ningún usuario te sigue",
    ),
    "nessuna_recensione_ancora": MessageLookupByLibrary.simpleMessage(
      "Aún no hay reseñas",
    ),
    "nessuna_recensione_disponibile": MessageLookupByLibrary.simpleMessage(
      "No hay reseñas disponibles",
    ),
    "new_card_unlocked": MessageLookupByLibrary.simpleMessage(
      "¡NUEVA CARTA DESBLOQUEADA!",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "next_recharge_in": m21,
    "no_account_question": MessageLookupByLibrary.simpleMessage(
      "¿No tienes cuenta?",
    ),
    "no_cards_available": MessageLookupByLibrary.simpleMessage(
      "No hay cartas disponibles.",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "Aún no tienes ninguna carta",
    ),
    "no_image": MessageLookupByLibrary.simpleMessage("Sin imagen"),
    "no_medals_in_filter": MessageLookupByLibrary.simpleMessage(
      "No hay medallas con este filtro",
    ),
    "no_more_kebabs_to_recommend": MessageLookupByLibrary.simpleMessage(
      "No hay más kebabs para recomendar.",
    ),
    "no_pack_ready": MessageLookupByLibrary.simpleMessage(
      "Ningún paquete listo",
    ),
    "no_pack_ready_hours_minutes": m22,
    "no_pack_ready_timer": m23,
    "no_photos_yet": MessageLookupByLibrary.simpleMessage("Aún no hay fotos"),
    "no_photos_yet_desc": MessageLookupByLibrary.simpleMessage(
      "¡Sé el primero en compartir una foto de tu kebab o plato de este local!",
    ),
    "no_place_found_add_it": MessageLookupByLibrary.simpleMessage(
      "No se encontró ningún local. Si es nuevo, usa \"Añadir un sitio de kebab\".",
    ),
    "no_reviews_yet_desc": MessageLookupByLibrary.simpleMessage(
      "¡Comparte tu experiencia en este local con toda la comunidad!",
    ),
    "no_suggestions_available": MessageLookupByLibrary.simpleMessage(
      "No hay sugerencias disponibles",
    ),
    "no_thanks": MessageLookupByLibrary.simpleMessage("No, gracias"),
    "no_user_reviews_yet": MessageLookupByLibrary.simpleMessage(
      "¡Ningún usuario ha reseñado este local todavía!",
    ),
    "nome_del_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Nombre del lugar de kebab",
    ),
    "nome_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nombre no disponible",
    ),
    "non_segui_ancora_nessuno": MessageLookupByLibrary.simpleMessage(
      "Todavía no sigues a nadie",
    ),
    "nuova_medaglia": MessageLookupByLibrary.simpleMessage("¡Nueva medalla!"),
    "nuovo_username": MessageLookupByLibrary.simpleMessage(
      "Nuevo nombre de usuario...",
    ),
    "objectives": MessageLookupByLibrary.simpleMessage("Objetivos"),
    "objectives_and_medals": MessageLookupByLibrary.simpleMessage(
      "Objetivos y medallas",
    ),
    "one_post": MessageLookupByLibrary.simpleMessage("1 publicación"),
    "one_review": MessageLookupByLibrary.simpleMessage("1 reseña"),
    "onion": MessageLookupByLibrary.simpleMessage("Cebolla"),
    "oops_review_not_found": MessageLookupByLibrary.simpleMessage(
      "¡Ups! Reseña no encontrada",
    ),
    "open_in_app": MessageLookupByLibrary.simpleMessage("Abrir la app"),
    "open_now": MessageLookupByLibrary.simpleMessage("Abierto Ahora"),
    "open_or_get_app": MessageLookupByLibrary.simpleMessage(
      "Abrir o descargar la app",
    ),
    "open_pack": MessageLookupByLibrary.simpleMessage("Abrir paquete"),
    "open_pack_two_ready": MessageLookupByLibrary.simpleMessage(
      "Abrir paquete (¡2 listos!)",
    ),
    "open_second_pack": m24,
    "opening_hours": MessageLookupByLibrary.simpleMessage("Horario"),
    "opening_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Puedes dejarlo sin especificar, elegir una plantilla o fijar un horario personalizado:",
    ),
    "opening_in_progress": MessageLookupByLibrary.simpleMessage("Abriendo..."),
    "or_continue_with_email": MessageLookupByLibrary.simpleMessage(
      "o con correo electrónico",
    ),
    "order_by": MessageLookupByLibrary.simpleMessage("Ordenar por"),
    "overall_rating_1_5": MessageLookupByLibrary.simpleMessage(
      "Valoración general (1 a 5)",
    ),
    "pack": MessageLookupByLibrary.simpleMessage("Paquete Kebabbo"),
    "pack_button_subtitle": MessageLookupByLibrary.simpleMessage(
      "abre tu paquete de kebab favorito",
    ),
    "pack_button_title": MessageLookupByLibrary.simpleMessage("Paquete"),
    "pack_too_soon": MessageLookupByLibrary.simpleMessage(
      "Este paquete aún no está disponible",
    ),
    "packs_full": MessageLookupByLibrary.simpleMessage(
      "Paquetes recargados al máximo: ¡2 / 2 listos! 📦✨",
    ),
    "packs_ready_0": MessageLookupByLibrary.simpleMessage(
      "0 / 2 paquetes disponibles",
    ),
    "packs_ready_1": MessageLookupByLibrary.simpleMessage(
      "1 / 2 paquete listo para abrir",
    ),
    "packs_ready_2": MessageLookupByLibrary.simpleMessage(
      "2 / 2 paquetes listos para abrir",
    ),
    "page_not_found": MessageLookupByLibrary.simpleMessage(
      "Página no encontrada",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "password_minimum_length": MessageLookupByLibrary.simpleMessage(
      "La contraseña debe tener al menos 6 caracteres",
    ),
    "password_must_be_at_least_6_characters":
        MessageLookupByLibrary.simpleMessage(
          "La contraseña debe tener al menos 6 caracteres",
        ),
    "password_reset_failed": m25,
    "password_reset_success": MessageLookupByLibrary.simpleMessage(
      "Restablecimiento de contraseña exitoso",
    ),
    "paste_maps_link_prompt": MessageLookupByLibrary.simpleMessage(
      "¿Ya tienes un enlace de Google Maps? Pégalo aquí",
    ),
    "per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab":
        MessageLookupByLibrary.simpleMessage(
          "Por eso estamos aquí: estudiantes universitarios, como tú, con años de experiencia como consumidores de kebab.",
        ),
    "percent_completed": m26,
    "photo": MessageLookupByLibrary.simpleMessage("Foto"),
    "photo_added": MessageLookupByLibrary.simpleMessage("¡Foto añadida! 📸"),
    "photo_caption_hint": MessageLookupByLibrary.simpleMessage(
      "Escribe un comentario o describe tu kebab...",
    ),
    "pillars_comparison": MessageLookupByLibrary.simpleMessage(
      "Comparación de Pilares",
    ),
    "please_enter_a_password": MessageLookupByLibrary.simpleMessage(
      "Introduce una contraseña",
    ),
    "please_enter_a_valid_email": MessageLookupByLibrary.simpleMessage(
      "Introduce un correo electrónico válido",
    ),
    "please_enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Introduce tu correo electrónico",
    ),
    "please_fill_in_all_fields": MessageLookupByLibrary.simpleMessage(
      "por favor complete todos los campos",
    ),
    "please_log_in_to_submit_your_review": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para enviar tu reseña",
    ),
    "popup_description": MessageLookupByLibrary.simpleMessage(
      "Para garantizar la autenticidad de las reseñas de los usuarios, para reseñar tú mismo el kebab,\ndebes ir en persona al lugar de kebab y encontrar la pegatina de Kebabbo colocada cerca,\nescanearla te llevará a la página de reseñas.",
    ),
    "popup_title": MessageLookupByLibrary.simpleMessage(
      "Cómo escribir tu propia reseña",
    ),
    "post_eliminato": MessageLookupByLibrary.simpleMessage(
      "Publicación eliminada",
    ),
    "posts": MessageLookupByLibrary.simpleMessage("Publicaciones"),
    "preferiti_solo_per_utenti_registrati":
        MessageLookupByLibrary.simpleMessage(
          "Favoritos solo para usuarios registrados",
        ),
    "prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi":
        MessageLookupByLibrary.simpleMessage(
          "\"Tomad y comed todos de él: este es el kebab ofrecido en sacrificio por vosotros.\"",
        ),
    "price": MessageLookupByLibrary.simpleMessage("Precio"),
    "prima_review": MessageLookupByLibrary.simpleMessage("primera reseña"),
    "primo_post": MessageLookupByLibrary.simpleMessage("primera publicación"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidad",
    ),
    "privacy_policy_load_error": MessageLookupByLibrary.simpleMessage(
      "Error al cargar la política de privacidad",
    ),
    "progress_label": MessageLookupByLibrary.simpleMessage("Progreso"),
    "publish_photo": MessageLookupByLibrary.simpleMessage("Publicar foto"),
    "publish_review": MessageLookupByLibrary.simpleMessage("Publicar reseña"),
    "quality": MessageLookupByLibrary.simpleMessage("Calidad"),
    "quantity": MessageLookupByLibrary.simpleMessage("Cantidad"),
    "queued": MessageLookupByLibrary.simpleMessage("En cola"),
    "rank_0_desc": MessageLookupByLibrary.simpleMessage(
      "¡Escribe tu primera reseña o crea una publicación para empezar la colección!",
    ),
    "rank_0_name": MessageLookupByLibrary.simpleMessage("Novato del kebab"),
    "rank_1_desc": MessageLookupByLibrary.simpleMessage(
      "¡Los primeros logros son tuyos! Sigue reseñando y publicando.",
    ),
    "rank_1_name": MessageLookupByLibrary.simpleMessage(
      "Apasionado del asador",
    ),
    "rank_2_desc": MessageLookupByLibrary.simpleMessage(
      "Tienes un gran paladar y una voz activa en el feed.",
    ),
    "rank_2_name": MessageLookupByLibrary.simpleMessage("Gourmet del döner"),
    "rank_3_desc": MessageLookupByLibrary.simpleMessage(
      "Un experto reconocido tanto en sabores como en la comunidad.",
    ),
    "rank_3_name": MessageLookupByLibrary.simpleMessage(
      "Maestro de las salsas",
    ),
    "rank_4_desc": MessageLookupByLibrary.simpleMessage(
      "¡Solo faltan unos pocos logros para completarlo todo!",
    ),
    "rank_4_name": MessageLookupByLibrary.simpleMessage("Veterano de Kebabbo"),
    "rank_5_desc": MessageLookupByLibrary.simpleMessage(
      "¡Has conseguido todos los logros! Estás en el Olimpo de Kebabbo.",
    ),
    "rank_5_name": MessageLookupByLibrary.simpleMessage("Leyenda suprema"),
    "rate_the_kebab": MessageLookupByLibrary.simpleMessage("Califica el kebab"),
    "rating_title": MessageLookupByLibrary.simpleMessage("Valoración"),
    "ready": MessageLookupByLibrary.simpleMessage("¡Listo!"),
    "recharge_info": MessageLookupByLibrary.simpleMessage(
      "Se recarga 1 paquete cada 12 h (máx. 2)",
    ),
    "recharging_next_in": m27,
    "registrati_per_poter_visualizzare_il_feed":
        MessageLookupByLibrary.simpleMessage("Regístrate para ver el feed"),
    "remaining_count": m28,
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Quitar de favoritos",
    ),
    "removed_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Eliminado de favoritos",
    ),
    "required_field": MessageLookupByLibrary.simpleMessage("Campo obligatorio"),
    "reroll": MessageLookupByLibrary.simpleMessage("Otra vez"),
    "reroll_step_1": MessageLookupByLibrary.simpleMessage(
      "👨‍🍳 Nueva combinación en camino...",
    ),
    "reroll_step_2": MessageLookupByLibrary.simpleMessage(
      "🔥 Equilibrando especias y cocción...",
    ),
    "reroll_step_3": MessageLookupByLibrary.simpleMessage(
      "✨ Buscando otra gran propuesta...",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage(
      "Restablecer contraseña",
    ),
    "review": MessageLookupByLibrary.simpleMessage("Reseña"),
    "reviewMessage": m29,
    "review_action": MessageLookupByLibrary.simpleMessage("Reseñar"),
    "review_already_exists_message": MessageLookupByLibrary.simpleMessage(
      "Ya existe otra reseña para este lugar, ¿deseas sobrescribirla?",
    ),
    "review_already_exists_title": MessageLookupByLibrary.simpleMessage(
      "Reseña ya existente",
    ),
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Reseña enviada correctamente",
    ),
    "review_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Reseñar este Kebab",
    ),
    "review_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Reseña actualizada correctamente",
    ),
    "reviews_label": MessageLookupByLibrary.simpleMessage("Reseñas"),
    "riprova": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "sandwich_tag": MessageLookupByLibrary.simpleMessage("Sándwich"),
    "sandwiches": MessageLookupByLibrary.simpleMessage("Bocadillos"),
    "save_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Guardar en favoritos",
    ),
    "scrivi_un_commento": MessageLookupByLibrary.simpleMessage(
      "Escribe un comentario...",
    ),
    "scrivi_un_post": MessageLookupByLibrary.simpleMessage(
      "Escribe una publicación...",
    ),
    "search_address_or_place": MessageLookupByLibrary.simpleMessage(
      "Buscar dirección o local...",
    ),
    "search_kebab_to_compare": MessageLookupByLibrary.simpleMessage(
      "Buscar un kebab para comparar...",
    ),
    "search_kebabbo_places": MessageLookupByLibrary.simpleMessage(
      "Buscar entre los locales de Kebabbo",
    ),
    "search_places_hint": MessageLookupByLibrary.simpleMessage(
      "Ej. Istanbul, Agra, King...",
    ),
    "second_pack_slot": MessageLookupByLibrary.simpleMessage("2.º paquete"),
    "section_initial_review": MessageLookupByLibrary.simpleMessage(
      "5. Tu primera reseña",
    ),
    "section_location": MessageLookupByLibrary.simpleMessage(
      "1. Ubicación en el mapa 📍",
    ),
    "section_location_hint": MessageLookupByLibrary.simpleMessage(
      "Toca para colocar el pin o buscar el local. ¡Las coordenadas, la dirección y el nombre se rellenarán automáticamente!",
    ),
    "section_name_category": MessageLookupByLibrary.simpleMessage(
      "2. Nombre y categoría 🌯",
    ),
    "section_opening_hours": MessageLookupByLibrary.simpleMessage(
      "3. Horario de apertura ⏰",
    ),
    "section_photo_optional": MessageLookupByLibrary.simpleMessage(
      "4. Foto del local (opcional)",
    ),
    "see_hours_photos_reviews": MessageLookupByLibrary.simpleMessage(
      "Ver horario, fotos y reseñas",
    ),
    "segui": MessageLookupByLibrary.simpleMessage("Seguir"),
    "segui_gia": MessageLookupByLibrary.simpleMessage("Ya siguiendo"),
    "seguiti": MessageLookupByLibrary.simpleMessage("Seguidos"),
    "select_first_kebab": MessageLookupByLibrary.simpleMessage(
      "Selecciona 1° kebab",
    ),
    "select_location_first": MessageLookupByLibrary.simpleMessage(
      "¡Selecciona la ubicación en el mapa antes de continuar! 📍",
    ),
    "select_on_map": MessageLookupByLibrary.simpleMessage(
      "Seleccionar en el mapa",
    ),
    "select_photo_first": MessageLookupByLibrary.simpleMessage(
      "Selecciona una foto antes de publicar",
    ),
    "select_place_to_review": MessageLookupByLibrary.simpleMessage(
      "¡Selecciona el local que quieres reseñar! 🌯",
    ),
    "select_second_kebab": MessageLookupByLibrary.simpleMessage(
      "Selecciona 2° kebab",
    ),
    "select_two_kebabs_to_compare": MessageLookupByLibrary.simpleMessage(
      "Selecciona dos kebabs para ver la comparación detallada.",
    ),
    "selected_point": MessageLookupByLibrary.simpleMessage(
      "Punto seleccionado",
    ),
    "seleziona_il_tuo_kebab_preferito": MessageLookupByLibrary.simpleMessage(
      "Selecciona tu kebab favorito",
    ),
    "send_reset_email": MessageLookupByLibrary.simpleMessage(
      "Enviar correo electrónico de restablecimiento",
    ),
    "session_expired": MessageLookupByLibrary.simpleMessage(
      "Sesión caducada. Inicia sesión de nuevo.",
    ),
    "sign_up": MessageLookupByLibrary.simpleMessage("Registrarse"),
    "sign_up_with_google": MessageLookupByLibrary.simpleMessage(
      "Registrarse con Google",
    ),
    "signup_tagline": MessageLookupByLibrary.simpleMessage(
      "Crea tu perfil y empieza a reseñar los kebabs de tu ciudad",
    ),
    "single_card": MessageLookupByLibrary.simpleMessage("Carta Kebabbo"),
    "sort_dimension": MessageLookupByLibrary.simpleMessage("tamaño"),
    "sort_distance": MessageLookupByLibrary.simpleMessage("distancia"),
    "sort_menu": MessageLookupByLibrary.simpleMessage("menú"),
    "sort_name": MessageLookupByLibrary.simpleMessage("nombre"),
    "sort_price": MessageLookupByLibrary.simpleMessage("precio"),
    "sort_quality": MessageLookupByLibrary.simpleMessage("calidad"),
    "sort_stars": MessageLookupByLibrary.simpleMessage("estrellas"),
    "sovrascrivi": MessageLookupByLibrary.simpleMessage("Sobrescribir"),
    "spicy": MessageLookupByLibrary.simpleMessage("Picante"),
    "staff": MessageLookupByLibrary.simpleMessage("Personal"),
    "staff_certified": MessageLookupByLibrary.simpleMessage(
      "Certificado por el staff de Kebabbo",
    ),
    "submit_review": MessageLookupByLibrary.simpleMessage("Enviar reseña"),
    "successfully_updated_profile": MessageLookupByLibrary.simpleMessage(
      "¡Perfil actualizado correctamente!",
    ),
    "swipe_collection_hint": MessageLookupByLibrary.simpleMessage(
      "Desliza para explorar la colección",
    ),
    "tab_overview": MessageLookupByLibrary.simpleMessage("Resumen"),
    "tab_photos": m30,
    "tab_reviews": m31,
    "tag_kebab_pill": MessageLookupByLibrary.simpleMessage("Kebab 🌯"),
    "tag_sandwich_pill": MessageLookupByLibrary.simpleMessage(
      "Bocadillería 🥪",
    ),
    "tap_map_to_select": MessageLookupByLibrary.simpleMessage(
      "Toca el mapa para seleccionar el punto exacto",
    ),
    "tap_to_browse_album": MessageLookupByLibrary.simpleMessage(
      "Toca para ver el álbum completo ›",
    ),
    "tap_to_open_pack": MessageLookupByLibrary.simpleMessage(
      "¡Toca para abrir el paquete!",
    ),
    "tap_to_select_photo": MessageLookupByLibrary.simpleMessage(
      "Toca para seleccionar una foto",
    ),
    "tcg_album": MessageLookupByLibrary.simpleMessage("Álbum de cartas TCG"),
    "ten_posts": MessageLookupByLibrary.simpleMessage("10 publicaciones"),
    "ten_reviews": MessageLookupByLibrary.simpleMessage("10 reseñas"),
    "testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo":
        MessageLookupByLibrary.simpleMessage(
          "Probamos y reseñamos lugares de kebab y comida callejera para ti. Bienvenido a Kebabbo.",
        ),
    "testo_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Texto no disponible",
    ),
    "thank_you": MessageLookupByLibrary.simpleMessage("Gracias"),
    "thank_you_for_your_review": MessageLookupByLibrary.simpleMessage(
      "¡Gracias por tu reseña!",
    ),
    "thirty_reviews": MessageLookupByLibrary.simpleMessage("30 reseñas"),
    "twenty_reviews": MessageLookupByLibrary.simpleMessage("20 reseñas"),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Se ha producido un error inesperado",
    ),
    "unit_posts": MessageLookupByLibrary.simpleMessage("publicaciones"),
    "unit_reviews": MessageLookupByLibrary.simpleMessage("reseñas"),
    "unlocked_badge": MessageLookupByLibrary.simpleMessage("Desbloqueada"),
    "unlocked_of_total": m32,
    "unpack_and_view_collection": MessageLookupByLibrary.simpleMessage(
      "Abrir y ver colección",
    ),
    "unpack_new_cards": MessageLookupByLibrary.simpleMessage(
      "Abre nuevas cartas",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Actualizar"),
    "upload": MessageLookupByLibrary.simpleMessage("Subir"),
    "upload_error": m33,
    "upload_first_photo": MessageLookupByLibrary.simpleMessage(
      "Sube la primera foto",
    ),
    "upload_place_photo": MessageLookupByLibrary.simpleMessage(
      "Sube una foto del asador o del local",
    ),
    "user_generic": MessageLookupByLibrary.simpleMessage("Usuario"),
    "user_not_authenticated": MessageLookupByLibrary.simpleMessage(
      "Usuario no autenticado",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage(
      "Usuario no encontrado",
    ),
    "user_not_found_login_again": MessageLookupByLibrary.simpleMessage(
      "Usuario no encontrado. Inicia sesión de nuevo.",
    ),
    "username_can_only_contain_letters_numbers_and_underscores":
        MessageLookupByLibrary.simpleMessage(
          "El nombre de usuario solo puede contener letras,\nnúmeros y guiones bajos.",
        ),
    "username_cannot_be_more_than_12_characters":
        MessageLookupByLibrary.simpleMessage(
          "El nombre de usuario no puede tener más de\n12 caracteres.",
        ),
    "username_cannot_contain_spaces_use_undescores_instead":
        MessageLookupByLibrary.simpleMessage(
          "El nombre de usuario no puede contener espacios,\nusa guiones bajos en su lugar.",
        ),
    "username_must_be_at_least_3_characters_long":
        MessageLookupByLibrary.simpleMessage(
          "El nombre de usuario debe tener al menos 3\ncaracteres de longitud.",
        ),
    "users": MessageLookupByLibrary.simpleMessage("Usuarios"),
    "users_count": m34,
    "users_review": MessageLookupByLibrary.simpleMessage("Reseña de usuarios"),
    "vegetables": MessageLookupByLibrary.simpleMessage("Verduras"),
    "verdura": MessageLookupByLibrary.simpleMessage("Vegetales"),
    "verified_by_staff_tooltip": MessageLookupByLibrary.simpleMessage(
      "Verificado por el equipo de Kebabbo",
    ),
    "vuoi_veramente_eliminare_il_post": MessageLookupByLibrary.simpleMessage(
      "¿De verdad quieres eliminar la publicación?",
    ),
    "world": MessageLookupByLibrary.simpleMessage("Mundo"),
    "write_a_review_for_a_kebab_near_you": MessageLookupByLibrary.simpleMessage(
      "Escribe una reseña",
    ),
    "write_first_review": MessageLookupByLibrary.simpleMessage(
      "Escribe la primera reseña",
    ),
    "write_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Valora la calidad, la carne y las salsas",
    ),
    "write_review_title": MessageLookupByLibrary.simpleMessage(
      "Escribir una reseña",
    ),
    "yes_create_new": MessageLookupByLibrary.simpleMessage("Sí, crear nuevo"),
    "yogurt": MessageLookupByLibrary.simpleMessage("Yogur"),
    "you_can_access_reviews_at_any_time_from_your_account":
        MessageLookupByLibrary.simpleMessage(
          "Puedes acceder a las reseñas en cualquier momento desde tu cuenta.",
        ),
    "your_experience": MessageLookupByLibrary.simpleMessage("Tu experiencia"),
    "your_kebab": MessageLookupByLibrary.simpleMessage("Tu kebab"),
    "your_medals_title": MessageLookupByLibrary.simpleMessage("Tus Medallas"),
    "your_review_optional": MessageLookupByLibrary.simpleMessage(
      "Tu reseña (opcional)",
    ),
  };
}
