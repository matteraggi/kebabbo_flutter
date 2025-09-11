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
      'Kebabbo ya está instalado en tu dispositivo. ¿Quieres abrirlo?';

  @override
  String get app_is_installed => 'App instalada';

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
  String get open_pack => 'Abrir Pacote';

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
}
