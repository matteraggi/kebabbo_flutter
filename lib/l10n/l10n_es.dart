// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get nome_non_disponibile => 'Nombre no disponible';

  @override
  String get seleziona_il_tuo_kebab_preferito => 'Selecciona tu kebab favorito';

  @override
  String get consigliaci_un_kebabbaro => 'Recomienda un lugar de kebab';

  @override
  String get nome_del_kebabbaro => 'Nombre del lugar de kebab';

  @override
  String get annulla => 'Cancelar';

  @override
  String get invia => 'Enviar';

  @override
  String get la_tua_soluzione_per_il_pranzo_universitario =>
      'Tu solución para el almuerzo universitario';

  @override
  String get in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google =>
      'En Italia, el mundo del kebab sigue siendo un mundo oscuro. Los mejores lugares están infravalorados y los peores reciben buenas críticas en Google.';

  @override
  String get per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab =>
      'Por eso estamos aquí: estudiantes universitarios, como tú, con años de experiencia como consumidores de kebab.';

  @override
  String get testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo =>
      'Probamos y reseñamos lugares de kebab y comida callejera para ti. Bienvenido a Kebabbo.';

  @override
  String get failed_to_load_reviews_count =>
      'Error al cargar el recuento de reseñas';

  @override
  String get cambia_username => 'Cambiar nombre de usuario';

  @override
  String get nuovo_username => 'Nuevo nombre de usuario...';

  @override
  String get cancel => 'Cancelar';

  @override
  String get update => 'Actualizar';

  @override
  String get failed_to_upload_avatar => 'Error al subir el avatar';

  @override
  String get edit_profile => 'Editar perfil';

  @override
  String get unexpected_error_occurred => 'Se ha producido un error inesperado';

  @override
  String get failed_to_load_favorites => 'Error al cargar los favoritos';

  @override
  String get nessun_kebab_tra_i_preferiti => 'No hay kebabs en favoritos';

  @override
  String get no_suggestions_available => 'No hay sugerencias disponibles';

  @override
  String get devi_essere_autenticato_per_postare =>
      'Debes estar autenticado para publicar';

  @override
  String get il_testo_non_puo_essere_vuoto => 'El texto no puede estar vacío';

  @override
  String get errore_nel_caricamento_dellimage => 'Error al cargar la imagen:';

  @override
  String get congratulazioni => '¡Felicidades!';

  @override
  String get hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia =>
      'Has alcanzado un nuevo hito y has obtenido una nueva medalla.';

  @override
  String get scrivi_un_post => 'Escribe una publicación...';

  @override
  String get testo_non_disponibile => 'Texto no disponible';

  @override
  String get non_segui_ancora_nessuno => 'Todavía no sigues a nadie';

  @override
  String get errore_nel_caricamento_dei_follower =>
      'Error al cargar seguidores';

  @override
  String get nessun_utente_ti_segue => 'Ningún usuario te sigue';

  @override
  String get il_kebab_che_ti_raccomandiamo_e =>
      'El kebab que te recomendamos es:';

  @override
  String get kebab_consigliato => 'Kebab recomendado';

  @override
  String get kebab_sconosciuto => 'Kebab desconocido';

  @override
  String get descrizione_non_disponibile => 'Descripción no disponible';

  @override
  String get back_to_build => 'Volver a construir';

  @override
  String get check_your_email_for_a_login_link =>
      '¡Revisa tu correo electrónico para obtener un enlace de inicio de sesión!';

  @override
  String get by_signing_in_you_agree_to_our_terms_and_privacy_policy =>
      'Al iniciar sesión, aceptas nuestros términos y política de privacidad.';

  @override
  String get prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi =>
      '\"Tomad y comed todos de él: este es el kebab ofrecido en sacrificio por vosotros.\"';

  @override
  String get failed_to_load_medals => 'Error al cargar las medallas';

  @override
  String get prima_review => 'primera reseña';

  @override
  String get primo_post => 'primera publicación';

  @override
  String reviewMessage(
      String kebabName,
      String qualityRating,
      String quantityRating,
      String menuRating,
      String priceRating,
      String funRating,
      String description) {
    return '¡Acabo de reseñar el kebab en $kebabName!\n\nCalidad: $qualityRating\nCantidad: $quantityRating\nMenú: $menuRating\nPrecio: $priceRating\nDiversión: $funRating\n\n$description';
  }

  @override
  String get review_updated_successfully => 'Reseña actualizada correctamente';

  @override
  String get review_submitted_successfully => 'Reseña enviada correctamente';

  @override
  String get nuova_medaglia => '¡Nueva medalla!';

  @override
  String get hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo =>
      'Recibiste una nueva medalla por tu contribución.';

  @override
  String get review => 'Reseña';

  @override
  String get oops_review_not_found => '¡Ups! Reseña no encontrada';

  @override
  String get please_log_in_to_submit_your_review =>
      'Inicia sesión para enviar tu reseña';

  @override
  String get rate_the_kebab => 'Califica el kebab';

  @override
  String get quality => 'Calidad';

  @override
  String get quantity => 'Cantidad';

  @override
  String get menu => 'Menú';

  @override
  String get price => 'Precio';

  @override
  String get fun => 'Diversión';

  @override
  String get description_is_required => 'Se requiere descripción';

  @override
  String get submit_review => 'Enviar reseña';

  @override
  String get registrati_per_poter_visualizzare_il_feed =>
      'Regístrate para ver el feed';

  @override
  String get cerca_utenti => 'Buscar usuarios...';

  @override
  String get anonimo => 'Anónimo';

  @override
  String get nessun_utente_seguito => 'No hay usuarios seguidos';

  @override
  String get failed_to_load_follower_count =>
      'Error al cargar el recuento de seguidores';

  @override
  String get failed_to_load_profile => 'Error al cargar el perfil';

  @override
  String get failed_to_update_follow_status =>
      'Error al actualizar el estado de seguimiento';

  @override
  String get failed_to_load_post_count =>
      'Error al cargar el recuento de publicaciones';

  @override
  String get segui_gia => 'Ya siguiendo';

  @override
  String get segui => 'Seguir';

  @override
  String get seguiti => 'Seguidos';

  @override
  String get world => 'Mundo';

  @override
  String get legends => 'Leyendas';

  @override
  String get errore => 'Error:';

  @override
  String get nessun_kebabbaro_presente =>
      'No hay lugares de kebab presentes :(';

  @override
  String get thank_you => 'Gracias';

  @override
  String get thank_you_for_your_review => '¡Gracias por tu reseña!';

  @override
  String get you_can_access_reviews_at_any_time_from_your_account =>
      'Puedes acceder a las reseñas en cualquier momento desde tu cuenta.';

  @override
  String get build_your_kebab => 'Construye tu kebab';

  @override
  String get distanza_massima => 'Distancia máxima';

  @override
  String get preferiti_solo_per_utenti_registrati =>
      'Favoritos solo para usuarios registrados';

  @override
  String get it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again =>
      'Parece que la reseña a la que intentas acceder no existe. Comprueba el enlace y vuelve a intentarlo.';

  @override
  String distanceLabel200m(String results) {
    return '200 metros ($results resultados)';
  }

  @override
  String distanceLabel500m(String results) {
    return '500 metros ($results resultados)';
  }

  @override
  String distanceLabel1km(String results) {
    return '1 km ($results resultados)';
  }

  @override
  String distanceLabel10km(String results) {
    return '10 km ($results resultados)';
  }

  @override
  String distanceLabelUnlimited(String results) {
    return 'Ilimitado ($results resultados)';
  }

  @override
  String get nessun_kebab_corrispondente_trovato_nel_raggio_selezionato =>
      'No se encontró ningún kebab coincidente dentro del radio seleccionado';

  @override
  String get cerca_un_kebabbaro => 'Busca un lugar de kebab...';

  @override
  String get aperti_ora => 'Abierto ahora';

  @override
  String get failed_to_load_posts => 'Error al cargar las publicaciones';

  @override
  String get i_tuoi_post => 'Tus publicaciones';

  @override
  String get nessun_post_trovato => 'No se encontraron publicaciones';

  @override
  String get nessuna_recensione_ancora => 'Aún no hay reseñas';

  @override
  String get successfully_updated_profile =>
      '¡Perfil actualizado correctamente!';

  @override
  String get username_cannot_contain_spaces_use_undescores_instead =>
      'El nombre de usuario no puede contener espacios,\nusa guiones bajos en su lugar.';

  @override
  String get username_must_be_at_least_3_characters_long =>
      'El nombre de usuario debe tener al menos 3\ncaracteres de longitud.';

  @override
  String get username_cannot_be_more_than_12_characters =>
      'El nombre de usuario no puede tener más de\n12 caracteres.';

  @override
  String get username_can_only_contain_letters_numbers_and_underscores =>
      'El nombre de usuario solo puede contener letras,\nnúmeros y guiones bajos.';

  @override
  String get esplora => 'Explorar';

  @override
  String get mappa => 'Mapa';

  @override
  String get no_image => 'Sin imagen';

  @override
  String get nessun_commento_disponibile => 'No hay comentarios disponibles';

  @override
  String get commento_non_disponibile => 'Comentario no disponible';

  @override
  String get scrivi_un_commento => 'Escribe un comentario...';

  @override
  String get il_commento_e_stato_aggiunto_con_successo =>
      'El comentario se agregó correctamente.';

  @override
  String get user_not_found => 'Usuario no encontrado';

  @override
  String get an_error_occurred => 'Se ha producido un error';

  @override
  String get log_in_con_google => 'Iniciar sesión con Google';

  @override
  String get aperto => 'Abierto';

  @override
  String get chiuso => 'Cerrado';

  @override
  String get nessuna_recensione_disponibile => 'No hay reseñas disponibles';

  @override
  String get users_review => 'Reseña de usuarios';

  @override
  String get km_distante_da_te => 'km de distancia de ti';

  @override
  String get distanza_non_disponibile => 'Distancia no disponible';

  @override
  String get verdura => 'Vegetales';

  @override
  String get yogurt => 'Yogur';

  @override
  String get spicy => 'Picante';

  @override
  String get cipolla => 'Cebolla';

  @override
  String get description => 'Descripción';

  @override
  String get more_info => 'Cómo reseñar un kebab';

  @override
  String get close => 'Cerrar';

  @override
  String get popup_title => 'Cómo escribir tu propia reseña';

  @override
  String get first_time_title => '¡Bienvenido a Kebabbo!';

  @override
  String get elimina => 'Eliminar';

  @override
  String get vuoi_veramente_eliminare_il_post =>
      '¿De verdad quieres eliminar la publicación?';

  @override
  String get conferma_eliminazione => 'Confirmar eliminación';

  @override
  String get post_eliminato => 'Publicación eliminada';

  @override
  String get devi_essere_autenticato_per_mettere_mi_piace =>
      'Debes iniciar sesión para dar me gusta';

  @override
  String get accedi_per_cercare =>
      'Inicia sesión para publicar y ver la información de las personas';

  @override
  String get devi_essere_autenticato_per_commentare =>
      'Debes iniciar sesión para comentar';

  @override
  String get devi_essere_autenticato_per_visualizzare_il_profilo =>
      'Debes iniciar sesión para ver el perfil';

  @override
  String get sign_up => 'Registrarse';

  @override
  String get please_enter_your_email => 'Introduce tu correo electrónico';

  @override
  String get please_enter_a_valid_email =>
      'Introduce un correo electrónico válido';

  @override
  String get please_enter_a_password => 'Introduce una contraseña';

  @override
  String get password_must_be_at_least_6_characters =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get check_your_email_for_a_verification_link =>
      'Revisa tu correo electrónico para obtener un enlace de verificación';

  @override
  String get dont_have_an_account_sign_up =>
      '¿No tienes una cuenta? Registrarse';

  @override
  String get logged_in => 'Sesión iniciada';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get popup_description =>
      'Para garantizar la autenticidad de las reseñas de los usuarios, para reseñar tú mismo el kebab,\ndebes ir en persona al lugar de kebab y encontrar la pegatina de Kebabbo colocada cerca,\nescanearla te llevará a la página de reseñas.';

  @override
  String get first_time_description =>
      '¡Bienvenido a Kebabbo!\n¿Qué puedes hacer aquí?\nBueno, puedes explorar nuestras reseñas profesionales de kebab o consultar las valoraciones de otros usuarios.\nEscribe tu propia reseña escaneando la pegatina de Kebabbo en el lugar de kebab.\nConsulta los perfiles y publicaciones de otros usuarios, conéctate con otros amantes del kebab y gana logros por usar la aplicación.\nUtiliza nuestras funciones de búsqueda y filtro o nuestra potente herramienta de creación para encontrar tu kebab ideal o explora nuestro mapa interactivo para descubrir joyas cercanas.\n¡Diviértete y a por el kebab!';

  @override
  String get cambia_profilo => 'cambiar perfil';

  @override
  String get cambia_profilepic => 'cambiar foto de perfil';

  @override
  String get please_fill_in_all_fields => 'por favor complete todos los campos';

  @override
  String get password_minimum_length =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get email_required => 'El correo electrónico es obligatorio';

  @override
  String get send_reset_email =>
      'Enviar correo electrónico de restablecimiento';

  @override
  String get forgot_password => 'Olvidé mi contraseña';

  @override
  String get check_your_email_for_a_reset_link =>
      'Consulta tu correo electrónico para obtener un enlace de restablecimiento';

  @override
  String get password_reset_success => 'Restablecimiento de contraseña exitoso';

  @override
  String get new_password => 'Nueva contraseña';

  @override
  String get reset_password => 'Restablecer contraseña';

  @override
  String get nessun_kebab_vicino_a_te =>
      'No hay kebabs cerca de ti \nDebes estar cerca del local de kebab para reseñarlo por razones de autenticidad.\nComprueba tu ubicación y recarga la página.';

  @override
  String get riprova => 'Reintentar';

  @override
  String get no_thanks => 'No, gracias';

  @override
  String get app_is_installed_description =>
      'Ábrelo en la app para una mejor experiencia. Si aún no la tienes, te llevamos a Google Play.';

  @override
  String get app_is_installed => '¡Kebabbo también es una app!';

  @override
  String get single_card => 'Carta Kebabbo';

  @override
  String get pack => 'Paquete Kebabbo';

  @override
  String get my_cards => 'Colección Kebab TCG';

  @override
  String get pack_too_soon => 'Este paquete aún no está disponible';

  @override
  String get no_cards_yet => 'Aún no tienes ninguna carta';

  @override
  String get open_pack => 'Abrir paquete';

  @override
  String get go_back => 'Volver';

  @override
  String get write_a_review_for_a_kebab_near_you => 'Escribe una reseña';

  @override
  String get autenticazione_necessaria =>
      'Du musst angemeldet sein, um zu kommentieren.';

  @override
  String get commento_vuoto => 'Der Kommentartext darf nicht leer sein.';

  @override
  String get found_all_cards => 'Todas las tarjetas encontradas.';

  @override
  String get about => 'Acerca de';

  @override
  String get privacy_policy => 'Política de Privacidad';

  @override
  String get add_kebab => 'Añadir un Kebab';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get could_not_open_link => 'No se pudo abrir el enlace.';

  @override
  String get generic_error => 'Error: ';

  @override
  String get posts => 'Publicaciones';

  @override
  String get followers => 'Seguidores';

  @override
  String get following => 'Seguidos';

  @override
  String get error_processing_image => 'Error al procesar la imagen:';

  @override
  String get followed_filter => 'Seguidos';

  @override
  String get all_filter => 'Todos';

  @override
  String get games_tools_title => 'Juegos y Herramientas';

  @override
  String get login_required_section =>
      'Debes iniciar sesión para usar esta sección.';

  @override
  String get add_review_title => 'Añadir Reseña';

  @override
  String get add_review_subtitle => '¿Probaste un kebab nuevo?';

  @override
  String get pack_button_title => 'Paquete';

  @override
  String get pack_button_subtitle => 'abre tu paquete de kebab favorito';

  @override
  String get collection_title => 'Colección';

  @override
  String get collection_subtitle => 'revisa tus cartas kebabbo';

  @override
  String get create_kebab_title => 'Crear Kebab';

  @override
  String get create_kebab_subtitle => 'construye tu propio kebab';

  @override
  String get your_medals_title => 'Tus Medallas';

  @override
  String get add_review_appbar_title => 'Añadir Reseña';

  @override
  String get error_loading_kebabs => 'Error al cargar los kebabs: ';

  @override
  String get kebab_not_found => 'Kebab no encontrado';

  @override
  String get add_new_kebab_confirmation =>
      'Estás a punto de añadir \"\$name\" como un nuevo kebab. ¿Seguro que no existe ya?';

  @override
  String get city => 'Ciudad';

  @override
  String get yes_create_new => 'Sí, crear nuevo';

  @override
  String get user_not_authenticated => 'Usuario no autenticado';

  @override
  String get error_adding_review => 'Error al añadir reseña: ';

  @override
  String get name_label => 'Nombre';

  @override
  String get required_field => 'Campo obligatorio';

  @override
  String get kebab_already_exists => 'El kebab ya existe';

  @override
  String get your_review_optional => 'Tu reseña (opcional)';

  @override
  String get kebab_tag => 'Kebab';

  @override
  String get sandwich_tag => 'Sándwich';

  @override
  String get dimension => 'Tamaño';

  @override
  String get meat => 'Carne';

  @override
  String get onion => 'Cebolla';

  @override
  String get vegetables => 'Verduras';

  @override
  String get gluten_free => 'Sin Gluten';

  @override
  String get advanced_filters => 'Filtros Avanzados';

  @override
  String get open_now => 'Abierto Ahora';

  @override
  String get sandwiches => 'Bocadillos';

  @override
  String get order_by => 'Ordenar por';

  @override
  String get filter_by_distance => 'Filtrar por distancia';

  @override
  String get sort_stars => 'estrellas';

  @override
  String get sort_quality => 'calidad';

  @override
  String get sort_price => 'precio';

  @override
  String get sort_dimension => 'tamaño';

  @override
  String get sort_menu => 'menú';

  @override
  String get sort_name => 'nombre';

  @override
  String get sort_distance => 'distancia';

  @override
  String get fun_exclamation => '¡divertido!';

  @override
  String get kebabbo_review => 'Reseña Kebabbo';

  @override
  String get review_this_kebab => 'Reseñar este Kebab';

  @override
  String get staff => 'Personal';

  @override
  String get users => 'Usuarios';

  @override
  String get one_review => '1 reseña';

  @override
  String get five_reviews => '5 reseñas';

  @override
  String get ten_reviews => '10 reseñas';

  @override
  String get twenty_reviews => '20 reseñas';

  @override
  String get thirty_reviews => '30 reseñas';

  @override
  String get one_post => '1 publicación';

  @override
  String get five_posts => '5 publicaciones';

  @override
  String get ten_posts => '10 publicaciones';

  @override
  String get fifty_posts => '50 publicaciones';

  @override
  String get build_button => '¡Construir!';

  @override
  String get objectives => 'Objetivos';

  @override
  String get your_kebab => 'Tu kebab';

  @override
  String get kebab_no_longer_available => 'Kebab ya no disponible';

  @override
  String get inserted_by => 'Añadido por';

  @override
  String get community_upload => 'Comunidad';

  @override
  String get staff_certified => 'Certificado por el staff de Kebabbo';

  @override
  String get swipe_collection_hint => 'Desliza para explorar la colección';

  @override
  String get examine_3d => 'Examinar en 3D';

  @override
  String get details => 'Detalles';

  @override
  String get verified_by_staff_tooltip => 'Verificado por el equipo de Kebabbo';

  @override
  String get sign_up_with_google => 'Registrarse con Google';

  @override
  String get or_continue_with_email => 'o con correo electrónico';

  @override
  String get already_have_an_account => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get location_services_disabled =>
      'Los servicios de ubicación están desactivados.';

  @override
  String get location_permission_denied => 'Permiso de ubicación denegado.';

  @override
  String get location_permission_denied_forever =>
      'Permiso de ubicación denegado permanentemente. Puedes activarlo en los ajustes.';

  @override
  String get session_expired => 'Sesión caducada. Inicia sesión de nuevo.';

  @override
  String get contribute_title => 'Contribuye a Kebabbo';

  @override
  String get contribute_subtitle =>
      '¡Ayúdanos a mapear y reseñar los mejores sitios de kebab!';

  @override
  String get add_kebab_place => 'Añadir un sitio de kebab';

  @override
  String get add_kebab_place_subtitle => 'Añade un nuevo local al mapa';

  @override
  String get write_review_title => 'Escribir una reseña';

  @override
  String get write_review_subtitle =>
      'Valora la calidad, la carne y las salsas';

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_add => 'Añadir';

  @override
  String get nav_feed => 'Feed';

  @override
  String get nav_account => 'Cuenta';

  @override
  String get page_not_found => 'Página no encontrada';

  @override
  String get maps_link_name_and_coords_found =>
      '¡Coordenadas y nombre detectados en el enlace de Maps! 📍';

  @override
  String get maps_link_coords_found =>
      '¡Coordenadas detectadas en el enlace de Maps! 📍';

  @override
  String get maps_link_failed =>
      'No se pudieron extraer las coordenadas del enlace. Usa \"Elegir en el mapa\".';

  @override
  String get select_location_first =>
      '¡Selecciona la ubicación en el mapa antes de continuar! 📍';

  @override
  String error_saving(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get section_location => '1. Ubicación en el mapa 📍';

  @override
  String get section_location_hint =>
      'Toca para colocar el pin o buscar el local. ¡Las coordenadas, la dirección y el nombre se rellenarán automáticamente!';

  @override
  String get edit_location_on_map => 'Editar ubicación en el mapa';

  @override
  String get choose_on_map_recommended => 'Elegir en el mapa (recomendado)';

  @override
  String city_label(String city) {
    return 'Ciudad: $city';
  }

  @override
  String get location_selected => 'Ubicación seleccionada';

  @override
  String get paste_maps_link_prompt =>
      '¿Ya tienes un enlace de Google Maps? Pégalo aquí';

  @override
  String get google_maps_link => 'Enlace de Google Maps';

  @override
  String get extract => 'Extraer';

  @override
  String get section_name_category => '2. Nombre y categoría 🌯';

  @override
  String get kebab_place_name_label => 'Nombre del local *';

  @override
  String get kebab_place_name_hint => 'Ej. Bella Istanbul 3';

  @override
  String get name_autofilled_helper =>
      'Rellenado automáticamente desde el mapa (puedes editarlo)';

  @override
  String get enter_place_name => 'Introduce el nombre del local';

  @override
  String get tag_kebab_pill => 'Kebab 🌯';

  @override
  String get tag_sandwich_pill => 'Bocadillería 🥪';

  @override
  String get gluten_free_option => 'Opción sin gluten';

  @override
  String get gluten_free_option_desc =>
      'Ofrece pan u opciones sin gluten certificadas';

  @override
  String get section_opening_hours => '3. Horario de apertura ⏰';

  @override
  String get opening_hours_hint =>
      'Puedes dejarlo sin especificar, elegir una plantilla o fijar un horario personalizado:';

  @override
  String get hours_preset_none => 'Sin especificar (predeterminado)';

  @override
  String get hours_preset_continuous => 'Continuo (11-23) 🌯';

  @override
  String get hours_preset_night => 'Nocturno (11-02) 🌙';

  @override
  String get hours_preset_lunch_dinner => 'Comida y cena 🍽️';

  @override
  String get hours_preset_custom => 'Personalizado ⚙️';

  @override
  String get hours_none_note => 'No se guardará ningún horario.';

  @override
  String get custom_hours_hint =>
      'Indica el horario de cada día (ej. 11:00-23:00 o \"cerrado\"):';

  @override
  String get section_photo_optional => '4. Foto del local (opcional)';

  @override
  String get upload_place_photo => 'Sube una foto del asador o del local';

  @override
  String get section_initial_review => '5. Tu primera reseña';

  @override
  String get description_review_label => 'Descripción / reseña *';

  @override
  String get description_review_hint =>
      'Cuéntanos cómo es este kebab: pan, carne, sabores...';

  @override
  String get description_review_required =>
      'Escribe un breve comentario para presentar el local';

  @override
  String get overall_rating_1_5 => 'Valoración general (1 a 5)';

  @override
  String get ingredient_balance_1_10 => 'Equilibrio de ingredientes (1 a 10)';

  @override
  String get add_kebab_to_kebabbo => 'Añadir local a Kebabbo';

  @override
  String get added_to_favorites => 'Añadido a favoritos ❤️';

  @override
  String get removed_from_favorites => 'Eliminado de favoritos';

  @override
  String get remove_from_favorites => 'Quitar de favoritos';

  @override
  String get save_to_favorites => 'Guardar en favoritos';

  @override
  String get map_not_available => 'Mapa no disponible para este local';

  @override
  String get login_to_post_photos => 'Inicia sesión para publicar fotos';

  @override
  String get select_photo_first => 'Selecciona una foto antes de publicar';

  @override
  String get photo_added => '¡Foto añadida! 📸';

  @override
  String upload_error(String error) {
    return 'Error al subir: $error';
  }

  @override
  String add_photo_to(String name) {
    return 'Añadir foto a $name';
  }

  @override
  String get tap_to_select_photo => 'Toca para seleccionar una foto';

  @override
  String get photo_caption_hint =>
      'Escribe un comentario o describe tu kebab...';

  @override
  String get publish_photo => 'Publicar foto';

  @override
  String get kebabbo_user => 'Usuario de Kebabbo';

  @override
  String get kebab_place_not_found => 'Local no encontrado o eliminado.';

  @override
  String get review_action => 'Reseñar';

  @override
  String get photo => 'Foto';

  @override
  String get tab_overview => 'Resumen';

  @override
  String tab_photos(String count) {
    return 'Fotos ($count)';
  }

  @override
  String tab_reviews(String count) {
    return 'Reseñas ($count)';
  }

  @override
  String get kebabbo_staff_review => 'La reseña de Kebabbo';

  @override
  String get rating_title => 'Valoración';

  @override
  String community_count(String count) {
    return 'Comunidad ($count)';
  }

  @override
  String get ingredient_balance => 'Equilibrio de ingredientes';

  @override
  String get opening_hours => 'Horario';

  @override
  String get no_photos_yet => 'Aún no hay fotos';

  @override
  String get no_photos_yet_desc =>
      '¡Sé el primero en compartir una foto de tu kebab o plato de este local!';

  @override
  String get upload_first_photo => 'Sube la primera foto';

  @override
  String get user_generic => 'Usuario';

  @override
  String get no_reviews_yet_desc =>
      '¡Comparte tu experiencia en este local con toda la comunidad!';

  @override
  String get write_first_review => 'Escribe la primera reseña';

  @override
  String based_on_reviews(String count) {
    return 'Basado en $count reseñas';
  }

  @override
  String get select_place_to_review =>
      '¡Selecciona el local que quieres reseñar! 🌯';

  @override
  String error_sending_review(String error) {
    return 'Error al enviar la reseña: $error';
  }

  @override
  String get choose_place => 'Elige el local';

  @override
  String get change => 'Cambiar';

  @override
  String get search_kebabbo_places => 'Buscar entre los locales de Kebabbo';

  @override
  String get search_places_hint => 'Ej. Istanbul, Agra, King...';

  @override
  String get no_place_found_add_it =>
      'No se encontró ningún local. Si es nuevo, usa \"Añadir un sitio de kebab\".';

  @override
  String get your_experience => 'Tu experiencia';

  @override
  String get comment_review_label => 'Comentario / reseña *';

  @override
  String get comment_review_hint =>
      '¿Qué te gustó más? ¿Recomiendas alguna salsa o menú?';

  @override
  String get comment_review_required =>
      'Escribe un breve comentario sobre tu experiencia';

  @override
  String get add_dish_photo_optional => 'Añade una foto de tu plato (opcional)';

  @override
  String get publish_review => 'Publicar reseña';

  @override
  String get tap_map_to_select =>
      'Toca el mapa para seleccionar el punto exacto';

  @override
  String get select_on_map => 'Seleccionar en el mapa';

  @override
  String get center_on_my_location => 'Centrar en mi ubicación';

  @override
  String get search_address_or_place => 'Buscar dirección o local...';

  @override
  String get selected_point => 'Punto seleccionado';

  @override
  String get confirm_this_location => 'Confirmar esta ubicación';

  @override
  String get map_style_google_road => 'Google Callejero';

  @override
  String get map_style_google_satellite => 'Google Satélite';

  @override
  String change_map_style(String style) {
    return 'Cambiar mapa: $style';
  }

  @override
  String get map_style_satellite_short => 'Satélite';

  @override
  String get map_style_road_short => 'Calles';

  @override
  String users_count(String count) {
    return 'Usuarios ($count)';
  }

  @override
  String get community_review => 'Reseña de la comunidad';

  @override
  String get no_user_reviews_yet =>
      '¡Ningún usuario ha reseñado este local todavía!';

  @override
  String get directions => 'Cómo llegar';

  @override
  String get login_tagline =>
      'Únete a la comunidad para descubrir y reseñar los mejores kebabs';

  @override
  String get no_account_question => '¿No tienes cuenta?';

  @override
  String get signup_tagline =>
      'Crea tu perfil y empieza a reseñar los kebabs de tu ciudad';

  @override
  String get have_account_question => '¿Ya tienes cuenta?';

  @override
  String password_reset_failed(String error) {
    return 'No se pudo restablecer la contraseña: $error';
  }

  @override
  String get objectives_and_medals => 'Objetivos y medallas';

  @override
  String get no_more_kebabs_to_recommend =>
      'No hay más kebabs para recomendar.';

  @override
  String get reroll => 'Otra vez';

  @override
  String get see_hours_photos_reviews => 'Ver horario, fotos y reseñas';

  @override
  String get upload => 'Subir';

  @override
  String get ingredient_amounts_caps => 'CANTIDAD DE INGREDIENTES';

  @override
  String error_deleting_post(String error) {
    return 'Error al eliminar la publicación: $error';
  }

  @override
  String get privacy_policy_load_error =>
      'Error al cargar la política de privacidad';

  @override
  String get cooking_title => 'Preparando el kebab';

  @override
  String get cooking_title_reroll => 'Buscando otra opción';

  @override
  String get cooking_step_1 => '🔥 Calentando el pan...';

  @override
  String get cooking_step_2 => '🥩 Cortando la carne del asador...';

  @override
  String get cooking_step_3 => '🥗 Añadiendo verduras frescas y salsas...';

  @override
  String get cooking_step_4 => '🌯 Enrollándolo como un profesional...';

  @override
  String get cooking_step_5 => '🔍 Buscando el mejor kebab para ti...';

  @override
  String get reroll_step_1 => '👨‍🍳 Nueva combinación en camino...';

  @override
  String get reroll_step_2 => '🔥 Equilibrando especias y cocción...';

  @override
  String get reroll_step_3 => '✨ Buscando otra gran propuesta...';

  @override
  String get user_not_found_login_again =>
      'Usuario no encontrado. Inicia sesión de nuevo.';

  @override
  String no_pack_ready_hours_minutes(String hours, String minutes) {
    return 'No hay ningún paquete listo (0/2). El próximo estará listo en $hours h $minutes min.';
  }

  @override
  String get no_cards_available => 'No hay cartas disponibles.';

  @override
  String an_error_occurred_with(String error) {
    return 'Se ha producido un error: $error';
  }

  @override
  String get opening_in_progress => 'Abriendo...';

  @override
  String get tap_to_open_pack => '¡Toca para abrir el paquete!';

  @override
  String get duplicate_card => 'CARTA REPETIDA';

  @override
  String get new_card_unlocked => '¡NUEVA CARTA DESBLOQUEADA!';

  @override
  String already_in_collection(String name) {
    return '$name (ya en la colección)';
  }

  @override
  String get drag_to_tilt => 'Arrastra con el dedo para inclinar en 3D';

  @override
  String open_second_pack(String count) {
    return 'Abrir 2.º paquete ($count)';
  }

  @override
  String get add_to_collection => 'Añadir a la colección';

  @override
  String card_x_of_y(String current, String total) {
    return '#$current de $total';
  }

  @override
  String get card_collection => 'Colección de cartas';

  @override
  String get all_found => '¡Todas encontradas! 🏆';

  @override
  String remaining_count(String count) {
    return '$count restantes';
  }

  @override
  String get tap_to_browse_album => 'Toca para ver el álbum completo ›';

  @override
  String get unpack_new_cards => 'Abre nuevas cartas';

  @override
  String get recharge_info => 'Se recarga 1 paquete cada 12 h (máx. 2)';

  @override
  String no_pack_ready_timer(String time) {
    return 'No hay ningún paquete listo. El próximo estará disponible en $time.';
  }

  @override
  String get first_pack_slot => '1.er paquete';

  @override
  String get second_pack_slot => '2.º paquete';

  @override
  String get ready => '¡Listo!';

  @override
  String get queued => 'En cola';

  @override
  String get packs_full => 'Paquetes recargados al máximo: ¡2 / 2 listos! 📦✨';

  @override
  String get open_pack_two_ready => 'Abrir paquete (¡2 listos!)';

  @override
  String get no_pack_ready => 'Ningún paquete listo';

  @override
  String get tcg_album => 'Álbum de cartas TCG';

  @override
  String get cards_unlocked => 'cartas desbloqueadas';

  @override
  String missing_count(String count) {
    return 'faltan $count';
  }

  @override
  String get packs_ready_2 => '2 / 2 paquetes listos para abrir';

  @override
  String get packs_ready_1 => '1 / 2 paquete listo para abrir';

  @override
  String get packs_ready_0 => '0 / 2 paquetes disponibles';

  @override
  String get max_charge_reached => 'Carga máxima alcanzada (1 cada 12 h)';

  @override
  String next_recharge_in(String time) {
    return 'Próxima recarga en $time';
  }

  @override
  String recharging_next_in(String time) {
    return 'Recargando: el próximo en $time';
  }

  @override
  String get unpack_and_view_collection => 'Abrir y ver colección';

  @override
  String get medal_0_title => 'Primer bocado';

  @override
  String get medal_1_title => 'Catador en serie';

  @override
  String get medal_2_title => 'Crítico de kebab';

  @override
  String get medal_3_title => 'Maestro del asador';

  @override
  String get medal_4_title => 'Leyenda gastronómica';

  @override
  String get medal_5_title => 'Voz del feed';

  @override
  String get medal_6_title => 'Reportero del sabor';

  @override
  String get medal_7_title => 'Influencer del kebab';

  @override
  String get medal_8_title => 'Pilar de la comunidad';

  @override
  String get medal_0_desc =>
      'Has escrito tu primera reseña de un local de kebab. ¡Bienvenido a la familia de críticos de Kebabbo!';

  @override
  String get medal_1_desc =>
      'Has reseñado 5 locales distintos. ¡Tu paladar empieza a distinguir el verdadero arte del asador!';

  @override
  String get medal_2_desc =>
      '¡10 reseñas completadas! Tus valoraciones orientan a los locales y a toda la comunidad.';

  @override
  String get medal_3_desc =>
      '¡20 reseñas escritas! Ningún rollo, salsa o pan de pita tiene secretos para ti. ¡Un verdadero maestro!';

  @override
  String get medal_4_desc =>
      '¡30 reseñas en tu haber! Has alcanzado la cima de la experiencia culinaria de Kebabbo. ¡Una leyenda viviente!';

  @override
  String get medal_5_desc =>
      'Has publicado tu primera publicación en el feed. ¡Tu pasión por el kebab ya es pública!';

  @override
  String get medal_6_desc =>
      'Has compartido 5 publicaciones con fotos y opiniones. ¡A la comunidad le encantan tus novedades!';

  @override
  String get medal_7_desc =>
      '¡10 publicaciones compartidas! Con tus fotos y etiquetas das hambre a toda la ciudad.';

  @override
  String get medal_8_desc =>
      '¡50 publicaciones en la comunidad! ¡Eres un pilar insustituible del feed de Kebabbo!';

  @override
  String get rank_5_name => 'Leyenda suprema';

  @override
  String get rank_5_desc =>
      '¡Has conseguido todos los logros! Estás en el Olimpo de Kebabbo.';

  @override
  String get rank_4_name => 'Veterano de Kebabbo';

  @override
  String get rank_4_desc =>
      '¡Solo faltan unos pocos logros para completarlo todo!';

  @override
  String get rank_3_name => 'Maestro de las salsas';

  @override
  String get rank_3_desc =>
      'Un experto reconocido tanto en sabores como en la comunidad.';

  @override
  String get rank_2_name => 'Gourmet del döner';

  @override
  String get rank_2_desc =>
      'Tienes un gran paladar y una voz activa en el feed.';

  @override
  String get rank_1_name => 'Apasionado del asador';

  @override
  String get rank_1_desc =>
      '¡Los primeros logros son tuyos! Sigue reseñando y publicando.';

  @override
  String get rank_0_name => 'Novato del kebab';

  @override
  String get rank_0_desc =>
      '¡Escribe tu primera reseña o crea una publicación para empezar la colección!';

  @override
  String get unit_reviews => 'reseñas';

  @override
  String get unit_posts => 'publicaciones';

  @override
  String get goal_reached => 'Logro conseguido 🎉';

  @override
  String get in_progress => 'En curso ⏳';

  @override
  String get progress_label => 'Progreso';

  @override
  String medal_missing(String missing, String unit) {
    return '¡Solo te faltan $missing $unit para desbloquear esta medalla!';
  }

  @override
  String get medals_page_title => 'Medallas y logros';

  @override
  String filter_all_count(String count) {
    return 'Todas ($count)';
  }

  @override
  String filter_reviews_count(String count) {
    return 'Reseñas ($count)';
  }

  @override
  String filter_unlocked_count(String count) {
    return 'Desbloqueadas ($count)';
  }

  @override
  String get no_medals_in_filter => 'No hay medallas con este filtro';

  @override
  String unlocked_of_total(String unlocked, String total) {
    return '$unlocked de $total desbloqueadas';
  }

  @override
  String percent_completed(String percent) {
    return '$percent% completado';
  }

  @override
  String get reviews_label => 'Reseñas';

  @override
  String get feed_posts_label => 'Publicaciones';

  @override
  String get unlocked_badge => 'Desbloqueada';

  @override
  String get completed_badge => '¡Completado! ⭐';

  @override
  String get open_in_app => 'Abrir la app';

  @override
  String get compare_kebabs => 'Comparar Kebabs';

  @override
  String get select_first_kebab => 'Selecciona 1° kebab';

  @override
  String get select_second_kebab => 'Selecciona 2° kebab';

  @override
  String get search_kebab_to_compare => 'Buscar un kebab para comparar...';

  @override
  String get pillars_comparison => 'Comparación de Pilares';

  @override
  String get ingredients_comparison => 'Comparación de Ingredientes';

  @override
  String get select_two_kebabs_to_compare =>
      'Selecciona dos kebabs para ver la comparación detallada.';

  @override
  String get review_already_exists_title => 'Reseña ya existente';

  @override
  String get review_already_exists_message =>
      'Ya existe otra reseña para este lugar, ¿deseas sobrescribirla?';

  @override
  String get sovrascrivi => 'Sobrescribir';

  @override
  String get open_or_get_app => 'Abrir o descargar la app';
}
