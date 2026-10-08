// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(name) => "Adicionar foto a ${name}";

  static String m1(name) => "${name} (já na coleção)";

  static String m2(error) => "Ocorreu um erro: ${error}";

  static String m3(count) => "Baseado em ${count} avaliações";

  static String m4(current, total) => "#${current} de ${total}";

  static String m5(style) => "Mudar mapa: ${style}";

  static String m6(city) => "Cidade: ${city}";

  static String m7(count) => "Comunidade (${count})";

  static String m8(results) => "10 km (${results} resultados)";

  static String m9(results) => "1 km (${results} resultados)";

  static String m10(results) => "200 metros (${results} resultados)";

  static String m11(results) => "500 metros (${results} resultados)";

  static String m12(results) => "Ilimitado (${results} resultados)";

  static String m13(error) => "Erro ao excluir o post: ${error}";

  static String m14(error) => "Erro ao salvar: ${error}";

  static String m15(error) => "Erro ao enviar a avaliação: ${error}";

  static String m16(count) => "Todas (${count})";

  static String m17(count) => "Avaliações (${count})";

  static String m18(count) => "Desbloqueadas (${count})";

  static String m19(missing, unit) =>
      "Faltam apenas ${missing} ${unit} para desbloquear esta medalha!";

  static String m20(count) => "faltam ${count}";

  static String m21(time) => "Próxima recarga em ${time}";

  static String m22(km) => "Nenhum lugar de kebab num raio de ${km} km.";

  static String m23(hours, minutes) =>
      "Nenhum pacote pronto agora (0/2). O próximo estará pronto em ${hours}h ${minutes}min.";

  static String m24(time) =>
      "Nenhum pacote pronto. O próximo estará disponível em ${time}.";

  static String m25(count) => "Abrir 2º pacote (${count})";

  static String m26(error) => "Falha ao redefinir a senha: ${error}";

  static String m27(percent) => "${percent}% concluído";

  static String m28(time) => "Recarregando: próximo em ${time}";

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
      "Acabei de avaliar o kebab no ${kebabName}!\n\nQualidade: ${qualityRating}\nQuantidade: ${quantityRating}\nMenu: ${menuRating}\nPreço: ${priceRating}\nDiversão: ${funRating}\n\n${description}";

  static String m31(name, rating) => "${name}: ${rating} no Kebabbo 🌯";

  static String m32(rating) => "Nota Kebabbo ${rating}";

  static String m33(count) => "Fotos (${count})";

  static String m34(count) => "Avaliações (${count})";

  static String m35(count) => "${count} cartas TCG";

  static String m36(unlocked, total) => "${unlocked} de ${total} desbloqueadas";

  static String m37(error) => "Erro ao enviar: ${error}";

  static String m38(count) => "Usuários (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "accedi_per_cercare": MessageLookupByLibrary.simpleMessage(
      "Faça login para postar e ver as informações das pessoas",
    ),
    "add_dish_photo_optional": MessageLookupByLibrary.simpleMessage(
      "Adicione uma foto do seu prato (opcional)",
    ),
    "add_kebab": MessageLookupByLibrary.simpleMessage("Adicionar um Kebab"),
    "add_kebab_place": MessageLookupByLibrary.simpleMessage(
      "Adicionar um lugar de kebab",
    ),
    "add_kebab_place_subtitle": MessageLookupByLibrary.simpleMessage(
      "Adicione um novo local ao mapa",
    ),
    "add_kebab_to_kebabbo": MessageLookupByLibrary.simpleMessage(
      "Adicionar local ao Kebabbo",
    ),
    "add_new_kebab_confirmation": MessageLookupByLibrary.simpleMessage(
      "Você está prestes a adicionar \"\$name\" como um novo kebab. Tem certeza que ele não existe?",
    ),
    "add_photo_to": m0,
    "add_review_appbar_title": MessageLookupByLibrary.simpleMessage(
      "Adicionar Avaliação",
    ),
    "add_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Provou um kebab novo?",
    ),
    "add_review_title": MessageLookupByLibrary.simpleMessage(
      "Adicionar Avaliação",
    ),
    "add_to_collection": MessageLookupByLibrary.simpleMessage(
      "Adicionar à coleção",
    ),
    "added_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Adicionado aos favoritos ❤️",
    ),
    "advanced_filters": MessageLookupByLibrary.simpleMessage(
      "Filtros Avançados",
    ),
    "all_filter": MessageLookupByLibrary.simpleMessage("Todos"),
    "all_found": MessageLookupByLibrary.simpleMessage("Todas encontradas! 🏆"),
    "already_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Já tem uma conta? Entrar",
    ),
    "already_in_collection": m1,
    "an_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro",
    ),
    "an_error_occurred_with": m2,
    "annulla": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "anonimo": MessageLookupByLibrary.simpleMessage("Anônimo"),
    "aperti_ora": MessageLookupByLibrary.simpleMessage("Aberto agora"),
    "aperto": MessageLookupByLibrary.simpleMessage("Aberto"),
    "app_is_installed": MessageLookupByLibrary.simpleMessage(
      "O Kebabbo também é um app!",
    ),
    "app_is_installed_description": MessageLookupByLibrary.simpleMessage(
      "Abra no app para uma experiência melhor. Se ainda não tiver, levamos você ao Google Play.",
    ),
    "autenticazione_necessaria": MessageLookupByLibrary.simpleMessage(
      "Você precisa estar autenticado para comentar.",
    ),
    "back_to_build": MessageLookupByLibrary.simpleMessage(
      "Voltar para a construção",
    ),
    "based_on_reviews": m3,
    "build_button": MessageLookupByLibrary.simpleMessage("Montar!"),
    "build_your_kebab": MessageLookupByLibrary.simpleMessage("Monte seu kebab"),
    "by_signing_in_you_agree_to_our_terms_and_privacy_policy":
        MessageLookupByLibrary.simpleMessage(
          "Ao fazer login, você concorda com nossos termos e política de privacidade.",
        ),
    "cambia_profilepic": MessageLookupByLibrary.simpleMessage(
      "alterar foto do perfil",
    ),
    "cambia_profilo": MessageLookupByLibrary.simpleMessage("mudar perfil"),
    "cambia_username": MessageLookupByLibrary.simpleMessage(
      "Alterar nome de usuário",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "card_collection": MessageLookupByLibrary.simpleMessage(
      "Coleção de cartas",
    ),
    "card_x_of_y": m4,
    "cards_unlocked": MessageLookupByLibrary.simpleMessage(
      "cartas desbloqueadas",
    ),
    "center_on_my_location": MessageLookupByLibrary.simpleMessage(
      "Centralizar na minha localização",
    ),
    "cerca_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Pesquise um lugar de kebab...",
    ),
    "cerca_utenti": MessageLookupByLibrary.simpleMessage(
      "Pesquisar usuários...",
    ),
    "change": MessageLookupByLibrary.simpleMessage("Mudar"),
    "change_map_style": m5,
    "check_your_email_for_a_login_link": MessageLookupByLibrary.simpleMessage(
      "Verifique seu e-mail para obter um link de login!",
    ),
    "check_your_email_for_a_reset_link": MessageLookupByLibrary.simpleMessage(
      "Verifique seu e-mail para obter um link de redefinição",
    ),
    "check_your_email_for_a_verification_link":
        MessageLookupByLibrary.simpleMessage(
          "Verifique seu email para obter um link de verificação",
        ),
    "chiuso": MessageLookupByLibrary.simpleMessage("Fechado"),
    "choose_on_map_recommended": MessageLookupByLibrary.simpleMessage(
      "Escolher no mapa (recomendado)",
    ),
    "choose_place": MessageLookupByLibrary.simpleMessage("Escolha o local"),
    "cipolla": MessageLookupByLibrary.simpleMessage("Cebola"),
    "city": MessageLookupByLibrary.simpleMessage("Cidade"),
    "city_label": m6,
    "close": MessageLookupByLibrary.simpleMessage("Fechar"),
    "collection_subtitle": MessageLookupByLibrary.simpleMessage(
      "veja suas cartas kebabbo",
    ),
    "collection_title": MessageLookupByLibrary.simpleMessage("Coleção"),
    "comment_review_hint": MessageLookupByLibrary.simpleMessage(
      "O que você mais gostou? Recomenda algum molho ou menu?",
    ),
    "comment_review_label": MessageLookupByLibrary.simpleMessage(
      "Comentário / avaliação *",
    ),
    "comment_review_required": MessageLookupByLibrary.simpleMessage(
      "Escreva um breve comentário sobre sua experiência",
    ),
    "commento_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Comentário não disponível",
    ),
    "commento_vuoto": MessageLookupByLibrary.simpleMessage(
      "O texto do comentário não pode estar vazio.",
    ),
    "community_count": m7,
    "community_review": MessageLookupByLibrary.simpleMessage(
      "Avaliação da comunidade",
    ),
    "community_upload": MessageLookupByLibrary.simpleMessage("Comunidade"),
    "compare_kebabs": MessageLookupByLibrary.simpleMessage("Comparar Kebabs"),
    "completed_badge": MessageLookupByLibrary.simpleMessage("Concluído! ⭐"),
    "conferma_eliminazione": MessageLookupByLibrary.simpleMessage(
      "Confirmar exclusão",
    ),
    "confirm_this_location": MessageLookupByLibrary.simpleMessage(
      "Confirmar esta localização",
    ),
    "congratulazioni": MessageLookupByLibrary.simpleMessage("Parabéns!"),
    "consigliaci_un_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Recomende um lugar de kebab",
    ),
    "contribute_subtitle": MessageLookupByLibrary.simpleMessage(
      "Ajude-nos a mapear e avaliar os melhores lugares de kebab!",
    ),
    "contribute_title": MessageLookupByLibrary.simpleMessage(
      "Contribua com o Kebabbo",
    ),
    "cooking_step_1": MessageLookupByLibrary.simpleMessage(
      "🔥 Esquentando o pão...",
    ),
    "cooking_step_2": MessageLookupByLibrary.simpleMessage(
      "🥩 Cortando a carne do espeto...",
    ),
    "cooking_step_3": MessageLookupByLibrary.simpleMessage(
      "🥗 Adicionando verduras frescas e molhos...",
    ),
    "cooking_step_4": MessageLookupByLibrary.simpleMessage(
      "🌯 Enrolando como um profissional...",
    ),
    "cooking_step_5": MessageLookupByLibrary.simpleMessage(
      "🔍 Procurando o melhor kebab para você...",
    ),
    "cooking_title": MessageLookupByLibrary.simpleMessage("Preparando o kebab"),
    "cooking_title_reroll": MessageLookupByLibrary.simpleMessage(
      "Buscando alternativa",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copiar"),
    "copy_link": MessageLookupByLibrary.simpleMessage("Copiar link"),
    "could_not_open_link": MessageLookupByLibrary.simpleMessage(
      "Não foi possível abrir o link.",
    ),
    "create_kebab_subtitle": MessageLookupByLibrary.simpleMessage(
      "monte seu próprio kebab",
    ),
    "create_kebab_title": MessageLookupByLibrary.simpleMessage("Criar Kebab"),
    "custom_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Defina o horário de cada dia (ex. 11:00-23:00 ou \"fechado\"):",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Descrição"),
    "description_is_required": MessageLookupByLibrary.simpleMessage(
      "Descrição é obrigatória",
    ),
    "description_review_hint": MessageLookupByLibrary.simpleMessage(
      "Conte como é este kebab: pão, carne, sabores...",
    ),
    "description_review_label": MessageLookupByLibrary.simpleMessage(
      "Descrição / avaliação *",
    ),
    "description_review_required": MessageLookupByLibrary.simpleMessage(
      "Escreva um breve comentário para apresentar o local",
    ),
    "descrizione_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Descrição não disponível",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Detalhes"),
    "devi_essere_autenticato_per_commentare":
        MessageLookupByLibrary.simpleMessage(
          "Você precisa fazer login para comentar",
        ),
    "devi_essere_autenticato_per_mettere_mi_piace":
        MessageLookupByLibrary.simpleMessage(
          "Você precisa fazer login para curtir",
        ),
    "devi_essere_autenticato_per_postare": MessageLookupByLibrary.simpleMessage(
      "Você precisa estar autenticado para postar",
    ),
    "devi_essere_autenticato_per_visualizzare_il_profilo":
        MessageLookupByLibrary.simpleMessage(
          "Você precisa fazer login para visualizar o perfil",
        ),
    "dimension": MessageLookupByLibrary.simpleMessage("Tamanho"),
    "directions": MessageLookupByLibrary.simpleMessage("Como chegar"),
    "distanceLabel10km": m8,
    "distanceLabel1km": m9,
    "distanceLabel200m": m10,
    "distanceLabel500m": m11,
    "distanceLabelUnlimited": m12,
    "distanza_massima": MessageLookupByLibrary.simpleMessage(
      "Distância máxima",
    ),
    "distanza_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Distância não disponível",
    ),
    "dont_have_an_account_sign_up": MessageLookupByLibrary.simpleMessage(
      "Não tem uma conta? Inscrever-se",
    ),
    "drag_to_tilt": MessageLookupByLibrary.simpleMessage(
      "Arraste com o dedo para inclinar em 3D",
    ),
    "duplicate_card": MessageLookupByLibrary.simpleMessage("CARTA REPETIDA"),
    "edit_location_on_map": MessageLookupByLibrary.simpleMessage(
      "Editar localização no mapa",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
    "elimina": MessageLookupByLibrary.simpleMessage("Excluir"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_required": MessageLookupByLibrary.simpleMessage(
      "O email é obrigatório",
    ),
    "enter_place_name": MessageLookupByLibrary.simpleMessage(
      "Insira o nome do local",
    ),
    "error_adding_review": MessageLookupByLibrary.simpleMessage(
      "Erro ao adicionar avaliação: ",
    ),
    "error_deleting_post": m13,
    "error_loading_kebabs": MessageLookupByLibrary.simpleMessage(
      "Erro ao carregar kebabs: ",
    ),
    "error_processing_image": MessageLookupByLibrary.simpleMessage(
      "Erro ao processar imagem:",
    ),
    "error_saving": m14,
    "error_sending_review": m15,
    "errore": MessageLookupByLibrary.simpleMessage("Erro:"),
    "errore_nel_caricamento_dei_follower": MessageLookupByLibrary.simpleMessage(
      "Erro ao carregar seguidores",
    ),
    "errore_nel_caricamento_dellimage": MessageLookupByLibrary.simpleMessage(
      "Erro ao carregar a imagem:",
    ),
    "esplora": MessageLookupByLibrary.simpleMessage("Explorar"),
    "examine_3d": MessageLookupByLibrary.simpleMessage("Examinar em 3D"),
    "extract": MessageLookupByLibrary.simpleMessage("Extrair"),
    "failed_to_load_favorites": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar os favoritos",
    ),
    "failed_to_load_follower_count": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar a contagem de seguidores",
    ),
    "failed_to_load_medals": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar medalhas",
    ),
    "failed_to_load_post_count": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar a contagem de posts",
    ),
    "failed_to_load_posts": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar posts",
    ),
    "failed_to_load_profile": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar o perfil",
    ),
    "failed_to_load_reviews_count": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar a contagem de avaliações",
    ),
    "failed_to_update_follow_status": MessageLookupByLibrary.simpleMessage(
      "Falha ao atualizar o status de seguimento",
    ),
    "failed_to_upload_avatar": MessageLookupByLibrary.simpleMessage(
      "Falha ao carregar o avatar",
    ),
    "favorite_kebab_caps": MessageLookupByLibrary.simpleMessage(
      "KEBAB FAVORITO",
    ),
    "feed_posts_label": MessageLookupByLibrary.simpleMessage("Posts no feed"),
    "fifty_posts": MessageLookupByLibrary.simpleMessage("50 posts"),
    "filter_all_count": m16,
    "filter_by_distance": MessageLookupByLibrary.simpleMessage(
      "Filtrar por distância",
    ),
    "filter_reviews_count": m17,
    "filter_unlocked_count": m18,
    "first_pack_slot": MessageLookupByLibrary.simpleMessage("1º pacote"),
    "first_time_description": MessageLookupByLibrary.simpleMessage(
      "Bem-vindo ao Kebabbo!\nO que você pode fazer aqui?\nBem, você pode explorar nossas avaliações profissionais de kebab ou verificar as avaliações de outros usuários.\nEscreva sua própria avaliação digitalizando o adesivo Kebabbo no local do kebab.\nConfira os perfis e posts de outros usuários, conecte-se com outros amantes de kebab e ganhe conquistas por usar o aplicativo.\nUse nossos recursos de pesquisa e filtro ou nossa poderosa ferramenta de construção para encontrar seu kebab ideal ou explore nosso mapa interativo para descobrir joias nas proximidades.\nDivirta-se e aproveite seu kebab!",
    ),
    "first_time_title": MessageLookupByLibrary.simpleMessage(
      "Bem-vindo ao Kebabbo!",
    ),
    "five_posts": MessageLookupByLibrary.simpleMessage("5 posts"),
    "five_reviews": MessageLookupByLibrary.simpleMessage("5 avaliações"),
    "followed_filter": MessageLookupByLibrary.simpleMessage("Seguindo"),
    "followers": MessageLookupByLibrary.simpleMessage("Seguidores"),
    "following": MessageLookupByLibrary.simpleMessage("Seguindo"),
    "forgot_password": MessageLookupByLibrary.simpleMessage(
      "Esqueci minha senha",
    ),
    "found_all_cards": MessageLookupByLibrary.simpleMessage(
      "Todos os cards encontrados.",
    ),
    "fun": MessageLookupByLibrary.simpleMessage("Diversão"),
    "fun_exclamation": MessageLookupByLibrary.simpleMessage("divertido!"),
    "games_tools_title": MessageLookupByLibrary.simpleMessage(
      "Jogos e Ferramentas",
    ),
    "generic_error": MessageLookupByLibrary.simpleMessage("Erro: "),
    "gluten_free": MessageLookupByLibrary.simpleMessage("Sem Glúten"),
    "gluten_free_option": MessageLookupByLibrary.simpleMessage(
      "Opção sem glúten",
    ),
    "gluten_free_option_desc": MessageLookupByLibrary.simpleMessage(
      "Oferece pão ou opções sem glúten certificadas",
    ),
    "go_back": MessageLookupByLibrary.simpleMessage("Voltar"),
    "goal_reached": MessageLookupByLibrary.simpleMessage("Meta alcançada 🎉"),
    "google_maps_link": MessageLookupByLibrary.simpleMessage(
      "Link do Google Maps",
    ),
    "hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia":
        MessageLookupByLibrary.simpleMessage(
          "Você atingiu um novo marco e obteve uma nova medalha!",
        ),
    "hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo":
        MessageLookupByLibrary.simpleMessage(
          "Você recebeu uma nova medalha por sua contribuição!",
        ),
    "have_account_question": MessageLookupByLibrary.simpleMessage(
      "Já tem uma conta?",
    ),
    "hours_none_note": MessageLookupByLibrary.simpleMessage(
      "Nenhum horário será salvo.",
    ),
    "hours_preset_continuous": MessageLookupByLibrary.simpleMessage(
      "Contínuo (11-23) 🌯",
    ),
    "hours_preset_custom": MessageLookupByLibrary.simpleMessage(
      "Personalizado ⚙️",
    ),
    "hours_preset_lunch_dinner": MessageLookupByLibrary.simpleMessage(
      "Almoço e jantar 🍽️",
    ),
    "hours_preset_night": MessageLookupByLibrary.simpleMessage(
      "Noturno (11-02) 🌙",
    ),
    "hours_preset_none": MessageLookupByLibrary.simpleMessage(
      "Não especificado (padrão)",
    ),
    "i_tuoi_post": MessageLookupByLibrary.simpleMessage("Suas publicações"),
    "il_commento_e_stato_aggiunto_con_successo":
        MessageLookupByLibrary.simpleMessage(
          "O comentário foi adicionado com sucesso!",
        ),
    "il_kebab_che_ti_raccomandiamo_e": MessageLookupByLibrary.simpleMessage(
      "O kebab que recomendamos é:",
    ),
    "il_testo_non_puo_essere_vuoto": MessageLookupByLibrary.simpleMessage(
      "O texto não pode estar vazio",
    ),
    "in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google":
        MessageLookupByLibrary.simpleMessage(
          "Na Itália, o mundo do kebab ainda é um mundo obscuro. Os melhores lugares são subestimados e os piores recebem avaliações altas no Google.",
        ),
    "in_progress": MessageLookupByLibrary.simpleMessage("Em andamento ⏳"),
    "ingredient_amounts_caps": MessageLookupByLibrary.simpleMessage(
      "QUANTIDADE DE INGREDIENTES",
    ),
    "ingredient_balance": MessageLookupByLibrary.simpleMessage(
      "Equilíbrio de ingredientes",
    ),
    "ingredient_balance_1_10": MessageLookupByLibrary.simpleMessage(
      "Equilíbrio de ingredientes (1 a 10)",
    ),
    "ingredients_comparison": MessageLookupByLibrary.simpleMessage(
      "Comparação de Ingredientes",
    ),
    "inserted_by": MessageLookupByLibrary.simpleMessage("Adicionado por"),
    "intro_1_text": MessageLookupByLibrary.simpleMessage(
      "Rankings da equipe e da comunidade, um mapa com as notas e filtros por distância, preço e horário.",
    ),
    "intro_1_title": MessageLookupByLibrary.simpleMessage("Encontre seu kebab"),
    "intro_2_text": MessageLookupByLibrary.simpleMessage(
      "Avalie qualidade, preço e ingredientes, publique fotos do seu prato e adicione os locais que faltam.",
    ),
    "intro_2_title": MessageLookupByLibrary.simpleMessage(
      "Avalie e compartilhe",
    ),
    "intro_3_text": MessageLookupByLibrary.simpleMessage(
      "Cada avaliação e post desbloqueia medalhas, e a cada 12 horas você pode abrir um pacote de cartas Kebabbo.",
    ),
    "intro_3_title": MessageLookupByLibrary.simpleMessage(
      "Colecione medalhas e cartas",
    ),
    "intro_next": MessageLookupByLibrary.simpleMessage("Próximo"),
    "intro_skip": MessageLookupByLibrary.simpleMessage("Pular"),
    "intro_start": MessageLookupByLibrary.simpleMessage("Começar"),
    "invia": MessageLookupByLibrary.simpleMessage("Enviar"),
    "it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again":
        MessageLookupByLibrary.simpleMessage(
          "Parece que a avaliação que você está tentando acessar não existe. Verifique o link e tente novamente.",
        ),
    "kebab_already_exists": MessageLookupByLibrary.simpleMessage(
      "Kebab já existe",
    ),
    "kebab_consigliato": MessageLookupByLibrary.simpleMessage(
      "Kebab recomendado",
    ),
    "kebab_no_longer_available": MessageLookupByLibrary.simpleMessage(
      "Kebab não está mais disponível",
    ),
    "kebab_not_found": MessageLookupByLibrary.simpleMessage(
      "Kebab não encontrado",
    ),
    "kebab_place_name_hint": MessageLookupByLibrary.simpleMessage(
      "Ex. Bella Istanbul 3",
    ),
    "kebab_place_name_label": MessageLookupByLibrary.simpleMessage(
      "Nome do local *",
    ),
    "kebab_place_not_found": MessageLookupByLibrary.simpleMessage(
      "Local não encontrado ou removido.",
    ),
    "kebab_sconosciuto": MessageLookupByLibrary.simpleMessage(
      "Kebab desconhecido",
    ),
    "kebab_tag": MessageLookupByLibrary.simpleMessage("Kebab"),
    "kebabbo_review": MessageLookupByLibrary.simpleMessage("Avaliação Kebabbo"),
    "kebabbo_staff_review": MessageLookupByLibrary.simpleMessage(
      "A avaliação do Kebabbo",
    ),
    "kebabbo_user": MessageLookupByLibrary.simpleMessage("Usuário Kebabbo"),
    "km_distante_da_te": MessageLookupByLibrary.simpleMessage(
      "km distante de você",
    ),
    "la_tua_soluzione_per_il_pranzo_universitario":
        MessageLookupByLibrary.simpleMessage(
          "Sua solução para o almoço universitário",
        ),
    "legends": MessageLookupByLibrary.simpleMessage("Lendas"),
    "link_copied": MessageLookupByLibrary.simpleMessage("Link copiado"),
    "loader_subtitle": MessageLookupByLibrary.simpleMessage(
      "Rankings, avaliações da comunidade e mapa dos lugares de kebab.",
    ),
    "loader_title": MessageLookupByLibrary.simpleMessage(
      "Kebabbo – os melhores kebabs de Bolonha",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Carregando"),
    "location_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Permissão de localização negada.",
    ),
    "location_permission_denied_forever": MessageLookupByLibrary.simpleMessage(
      "Permissão de localização negada permanentemente. Você pode ativá-la nas configurações.",
    ),
    "location_selected": MessageLookupByLibrary.simpleMessage(
      "Localização selecionada",
    ),
    "location_services_disabled": MessageLookupByLibrary.simpleMessage(
      "Os serviços de localização estão desativados.",
    ),
    "log_in_con_google": MessageLookupByLibrary.simpleMessage(
      "Entrar com o Google",
    ),
    "logged_in": MessageLookupByLibrary.simpleMessage("Conectado"),
    "login": MessageLookupByLibrary.simpleMessage("Entrar"),
    "login_loader_subtitle": MessageLookupByLibrary.simpleMessage(
      "Um momento, estamos preparando seu perfil.",
    ),
    "login_loader_title": MessageLookupByLibrary.simpleMessage(
      "Entrando na sua conta",
    ),
    "login_required_section": MessageLookupByLibrary.simpleMessage(
      "Você deve fazer login para usar esta seção.",
    ),
    "login_step_auth": MessageLookupByLibrary.simpleMessage("Login"),
    "login_step_profile": MessageLookupByLibrary.simpleMessage(
      "Perfil, favoritos e medalhas",
    ),
    "login_tagline": MessageLookupByLibrary.simpleMessage(
      "Entre na comunidade para descobrir e avaliar os melhores kebabs",
    ),
    "login_to_follow_user": MessageLookupByLibrary.simpleMessage(
      "Faça login para seguir este usuário",
    ),
    "login_to_post_photos": MessageLookupByLibrary.simpleMessage(
      "Faça login para publicar fotos",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Sair"),
    "map_not_available": MessageLookupByLibrary.simpleMessage(
      "Mapa não disponível para este local",
    ),
    "map_style_google_road": MessageLookupByLibrary.simpleMessage(
      "Google Mapa",
    ),
    "map_style_google_satellite": MessageLookupByLibrary.simpleMessage(
      "Google Satélite",
    ),
    "map_style_road_short": MessageLookupByLibrary.simpleMessage("Ruas"),
    "map_style_satellite_short": MessageLookupByLibrary.simpleMessage(
      "Satélite",
    ),
    "mappa": MessageLookupByLibrary.simpleMessage("Mapa"),
    "maps_link_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordenadas detectadas no link do Maps! 📍",
    ),
    "maps_link_failed": MessageLookupByLibrary.simpleMessage(
      "Não foi possível extrair as coordenadas do link. Use \"Escolher no mapa\".",
    ),
    "maps_link_name_and_coords_found": MessageLookupByLibrary.simpleMessage(
      "Coordenadas e nome detectados no link do Maps! 📍",
    ),
    "maps_short_link_web": MessageLookupByLibrary.simpleMessage(
      "Na web, use o link completo do Google Maps (https://www.google.com/maps/place/...): links curtos são bloqueados pelo navegador.",
    ),
    "max_charge_reached": MessageLookupByLibrary.simpleMessage(
      "Carga máxima atingida (1 a cada 12h)",
    ),
    "meat": MessageLookupByLibrary.simpleMessage("Carne"),
    "medal_0_desc": MessageLookupByLibrary.simpleMessage(
      "Você escreveu sua primeira avaliação de um lugar de kebab. Bem-vindo à família de críticos do Kebabbo!",
    ),
    "medal_0_title": MessageLookupByLibrary.simpleMessage("Primeira mordida"),
    "medal_1_desc": MessageLookupByLibrary.simpleMessage(
      "Você avaliou 5 locais diferentes. Seu paladar começa a distinguir a verdadeira arte do espeto!",
    ),
    "medal_1_title": MessageLookupByLibrary.simpleMessage("Provador em série"),
    "medal_2_desc": MessageLookupByLibrary.simpleMessage(
      "10 avaliações concluídas! Suas notas orientam os locais e toda a comunidade.",
    ),
    "medal_2_title": MessageLookupByLibrary.simpleMessage("Crítico de kebab"),
    "medal_3_desc": MessageLookupByLibrary.simpleMessage(
      "20 avaliações escritas! Nenhum wrap, molho ou pão sírio tem segredos para você. Um verdadeiro mestre!",
    ),
    "medal_3_title": MessageLookupByLibrary.simpleMessage("Mestre do espeto"),
    "medal_4_desc": MessageLookupByLibrary.simpleMessage(
      "30 avaliações no currículo! Você chegou ao topo da experiência culinária do Kebabbo. Uma lenda viva!",
    ),
    "medal_4_title": MessageLookupByLibrary.simpleMessage("Lenda gastronômica"),
    "medal_5_desc": MessageLookupByLibrary.simpleMessage(
      "Você publicou seu primeiro post no feed. Sua paixão por kebab agora é pública!",
    ),
    "medal_5_title": MessageLookupByLibrary.simpleMessage("Voz do feed"),
    "medal_6_desc": MessageLookupByLibrary.simpleMessage(
      "Você compartilhou 5 posts com fotos e opiniões. A comunidade adora suas novidades!",
    ),
    "medal_6_title": MessageLookupByLibrary.simpleMessage("Repórter do sabor"),
    "medal_7_desc": MessageLookupByLibrary.simpleMessage(
      "10 posts compartilhados! Com suas fotos e marcações você deixa a cidade inteira com fome.",
    ),
    "medal_7_title": MessageLookupByLibrary.simpleMessage(
      "Influenciador do kebab",
    ),
    "medal_8_desc": MessageLookupByLibrary.simpleMessage(
      "50 posts na comunidade! Você é um pilar insubstituível do feed do Kebabbo!",
    ),
    "medal_8_title": MessageLookupByLibrary.simpleMessage(
      "Pilar da comunidade",
    ),
    "medal_missing": m19,
    "medals_page_title": MessageLookupByLibrary.simpleMessage(
      "Medalhas e metas",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Cardápio"),
    "missing_count": m20,
    "more_info": MessageLookupByLibrary.simpleMessage("Como avaliar um kebab"),
    "my_cards": MessageLookupByLibrary.simpleMessage("Coleção Kebab TCG"),
    "name_autofilled_helper": MessageLookupByLibrary.simpleMessage(
      "Preenchido automaticamente pelo mapa (pode editar)",
    ),
    "name_label": MessageLookupByLibrary.simpleMessage("Nome"),
    "nav_account": MessageLookupByLibrary.simpleMessage("Conta"),
    "nav_add": MessageLookupByLibrary.simpleMessage("Adicionar"),
    "nav_feed": MessageLookupByLibrary.simpleMessage("Feed"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Início"),
    "nessun_commento_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nenhum comentário disponível",
    ),
    "nessun_kebab_corrispondente_trovato_nel_raggio_selezionato":
        MessageLookupByLibrary.simpleMessage(
          "Nenhum kebab correspondente encontrado dentro do raio selecionado",
        ),
    "nessun_kebab_tra_i_preferiti": MessageLookupByLibrary.simpleMessage(
      "Sem kebabs nos favoritos",
    ),
    "nessun_kebab_vicino_a_te": MessageLookupByLibrary.simpleMessage(
      "Nenhum kebab perto de você \nVocê deve estar próximo da loja de kebab para avaliá-la por motivos de autenticidade.\nVerifique sua localização e recarregue a página.",
    ),
    "nessun_kebabbaro_presente": MessageLookupByLibrary.simpleMessage(
      "Nenhum lugar de kebab presente :(",
    ),
    "nessun_post_trovato": MessageLookupByLibrary.simpleMessage(
      "Nenhum post encontrado",
    ),
    "nessun_utente_seguito": MessageLookupByLibrary.simpleMessage(
      "Nenhum usuário seguido",
    ),
    "nessun_utente_ti_segue": MessageLookupByLibrary.simpleMessage(
      "Nenhum usuário está te seguindo",
    ),
    "nessuna_recensione_ancora": MessageLookupByLibrary.simpleMessage(
      "Nenhuma avaliação ainda",
    ),
    "nessuna_recensione_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nenhuma avaliação disponível",
    ),
    "new_card_unlocked": MessageLookupByLibrary.simpleMessage(
      "NOVA CARTA DESBLOQUEADA!",
    ),
    "new_password": MessageLookupByLibrary.simpleMessage("Nova senha"),
    "next_recharge_in": m21,
    "no_account_question": MessageLookupByLibrary.simpleMessage(
      "Não tem uma conta?",
    ),
    "no_cards_available": MessageLookupByLibrary.simpleMessage(
      "Nenhuma carta disponível.",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "Você ainda não tem nenhuma carta",
    ),
    "no_image": MessageLookupByLibrary.simpleMessage("Sem imagem"),
    "no_kebab_within_distance": m22,
    "no_medals_in_filter": MessageLookupByLibrary.simpleMessage(
      "Nenhuma medalha neste filtro",
    ),
    "no_more_kebabs_to_recommend": MessageLookupByLibrary.simpleMessage(
      "Não há outros kebabs para recomendar.",
    ),
    "no_pack_ready": MessageLookupByLibrary.simpleMessage(
      "Nenhum pacote pronto",
    ),
    "no_pack_ready_hours_minutes": m23,
    "no_pack_ready_timer": m24,
    "no_photos_yet": MessageLookupByLibrary.simpleMessage("Ainda não há fotos"),
    "no_photos_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Seja o primeiro a compartilhar uma foto do seu kebab ou prato deste local!",
    ),
    "no_place_found_add_it": MessageLookupByLibrary.simpleMessage(
      "Nenhum local encontrado. Se for novo, use \"Adicionar um lugar de kebab\"!",
    ),
    "no_posts_yet": MessageLookupByLibrary.simpleMessage("Ainda não há posts"),
    "no_reviews_yet_desc": MessageLookupByLibrary.simpleMessage(
      "Compartilhe sua experiência neste local com toda a comunidade!",
    ),
    "no_suggestions_available": MessageLookupByLibrary.simpleMessage(
      "Nenhuma sugestão disponível",
    ),
    "no_thanks": MessageLookupByLibrary.simpleMessage("Não, obrigado"),
    "no_user_reviews_yet": MessageLookupByLibrary.simpleMessage(
      "Nenhum usuário avaliou este local ainda!",
    ),
    "nome_del_kebabbaro": MessageLookupByLibrary.simpleMessage(
      "Nome do lugar de kebab",
    ),
    "nome_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Nome não disponível",
    ),
    "non_segui_ancora_nessuno": MessageLookupByLibrary.simpleMessage(
      "Você ainda não está seguindo ninguém",
    ),
    "nuova_medaglia": MessageLookupByLibrary.simpleMessage("Nova medalha!"),
    "nuovo_username": MessageLookupByLibrary.simpleMessage(
      "Novo nome de usuário...",
    ),
    "objectives": MessageLookupByLibrary.simpleMessage("Objetivos"),
    "objectives_and_medals": MessageLookupByLibrary.simpleMessage(
      "Objetivos e medalhas",
    ),
    "one_post": MessageLookupByLibrary.simpleMessage("1 post"),
    "one_review": MessageLookupByLibrary.simpleMessage("1 avaliação"),
    "onion": MessageLookupByLibrary.simpleMessage("Cebola"),
    "oops_review_not_found": MessageLookupByLibrary.simpleMessage(
      "Ops! Avaliação não encontrada",
    ),
    "open_in_app": MessageLookupByLibrary.simpleMessage("Abrir o app"),
    "open_now": MessageLookupByLibrary.simpleMessage("Aberto Agora"),
    "open_or_get_app": MessageLookupByLibrary.simpleMessage(
      "Abrir ou baixar o app",
    ),
    "open_pack": MessageLookupByLibrary.simpleMessage("Abrir Pacote"),
    "open_pack_two_ready": MessageLookupByLibrary.simpleMessage(
      "Abrir pacote (2 prontos!)",
    ),
    "open_second_pack": m25,
    "opening_hours": MessageLookupByLibrary.simpleMessage(
      "Horário de funcionamento",
    ),
    "opening_hours_hint": MessageLookupByLibrary.simpleMessage(
      "Você pode deixar sem especificar, escolher um modelo ou definir horários personalizados:",
    ),
    "opening_in_progress": MessageLookupByLibrary.simpleMessage("Abrindo..."),
    "or_continue_with_email": MessageLookupByLibrary.simpleMessage(
      "ou com e-mail",
    ),
    "order_by": MessageLookupByLibrary.simpleMessage("Ordenar por"),
    "origin_label": MessageLookupByLibrary.simpleMessage("Origem"),
    "overall_rating_1_5": MessageLookupByLibrary.simpleMessage(
      "Avaliação geral (1 a 5)",
    ),
    "pack": MessageLookupByLibrary.simpleMessage("Pacote Kebabbo"),
    "pack_button_subtitle": MessageLookupByLibrary.simpleMessage(
      "abra seu pacote de kebab favorito",
    ),
    "pack_button_title": MessageLookupByLibrary.simpleMessage("Pacote"),
    "pack_too_soon": MessageLookupByLibrary.simpleMessage(
      "Este pacote ainda não está disponível",
    ),
    "packs_full": MessageLookupByLibrary.simpleMessage(
      "Pacotes recarregados ao máximo: 2 / 2 prontos! 📦✨",
    ),
    "packs_ready_0": MessageLookupByLibrary.simpleMessage(
      "0 / 2 pacotes disponíveis",
    ),
    "packs_ready_1": MessageLookupByLibrary.simpleMessage(
      "1 / 2 pacote pronto para abrir",
    ),
    "packs_ready_2": MessageLookupByLibrary.simpleMessage(
      "2 / 2 pacotes prontos para abrir",
    ),
    "page_not_found": MessageLookupByLibrary.simpleMessage(
      "Página não encontrada",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "password_minimum_length": MessageLookupByLibrary.simpleMessage(
      "A senha deve ter no mínimo 6 caracteres",
    ),
    "password_must_be_at_least_6_characters":
        MessageLookupByLibrary.simpleMessage(
          "A senha deve ter pelo menos 6 caracteres",
        ),
    "password_reset_failed": m26,
    "password_reset_success": MessageLookupByLibrary.simpleMessage(
      "Redefinição de senha bem-sucedida",
    ),
    "paste_maps_link_prompt": MessageLookupByLibrary.simpleMessage(
      "Já tem um link do Google Maps? Cole aqui",
    ),
    "per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab":
        MessageLookupByLibrary.simpleMessage(
          "É por isso que estamos aqui: estudantes universitários, como você, com anos de experiência como comedores de kebab.",
        ),
    "percent_completed": m27,
    "photo": MessageLookupByLibrary.simpleMessage("Foto"),
    "photo_added": MessageLookupByLibrary.simpleMessage("Foto adicionada! 📸"),
    "photo_caption_hint": MessageLookupByLibrary.simpleMessage(
      "Escreva um comentário ou descreva seu kebab...",
    ),
    "pillars_comparison": MessageLookupByLibrary.simpleMessage(
      "Comparação de Pilares",
    ),
    "please_enter_a_password": MessageLookupByLibrary.simpleMessage(
      "Por favor, insira uma senha",
    ),
    "please_enter_a_valid_email": MessageLookupByLibrary.simpleMessage(
      "Por favor, insira um email válido",
    ),
    "please_enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Por favor, insira seu email",
    ),
    "please_fill_in_all_fields": MessageLookupByLibrary.simpleMessage(
      "por favor preencha todos os campos",
    ),
    "please_log_in_to_submit_your_review": MessageLookupByLibrary.simpleMessage(
      "Faça login para enviar sua avaliação",
    ),
    "popup_description": MessageLookupByLibrary.simpleMessage(
      "Para garantir que as avaliações dos usuários sejam verdadeiras, para avaliar você mesmo o kebab,\nvocê precisa ir pessoalmente ao local do kebab e encontrar o adesivo Kebabbo afixado nas proximidades,\nao escaneá-lo, você será direcionado para a página de avaliação.",
    ),
    "popup_title": MessageLookupByLibrary.simpleMessage(
      "Como escrever sua própria avaliação",
    ),
    "post_eliminato": MessageLookupByLibrary.simpleMessage("Postagem excluída"),
    "posts": MessageLookupByLibrary.simpleMessage("Posts"),
    "preferiti_solo_per_utenti_registrati":
        MessageLookupByLibrary.simpleMessage(
          "Favoritos apenas para usuários registrados",
        ),
    "prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi":
        MessageLookupByLibrary.simpleMessage(
          "\"Tomai e comei todos: este é o kebab oferecido em sacrifício por vós.\"",
        ),
    "price": MessageLookupByLibrary.simpleMessage("Preço"),
    "prima_review": MessageLookupByLibrary.simpleMessage("primeira avaliação"),
    "primo_post": MessageLookupByLibrary.simpleMessage("primeira publicação"),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "privacy_policy_load_error": MessageLookupByLibrary.simpleMessage(
      "Erro ao carregar a política de privacidade",
    ),
    "profile_link_copied": MessageLookupByLibrary.simpleMessage(
      "Link do perfil copiado!",
    ),
    "progress_label": MessageLookupByLibrary.simpleMessage("Progresso"),
    "publish_photo": MessageLookupByLibrary.simpleMessage("Publicar foto"),
    "publish_review": MessageLookupByLibrary.simpleMessage(
      "Publicar avaliação",
    ),
    "quality": MessageLookupByLibrary.simpleMessage("Qualidade"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantidade"),
    "queued": MessageLookupByLibrary.simpleMessage("Na fila"),
    "rank_0_desc": MessageLookupByLibrary.simpleMessage(
      "Escreva sua primeira avaliação ou crie um post para começar a coleção!",
    ),
    "rank_0_name": MessageLookupByLibrary.simpleMessage("Novato do kebab"),
    "rank_1_desc": MessageLookupByLibrary.simpleMessage(
      "As primeiras metas são suas! Continue avaliando e postando.",
    ),
    "rank_1_name": MessageLookupByLibrary.simpleMessage(
      "Apaixonado por espetos",
    ),
    "rank_2_desc": MessageLookupByLibrary.simpleMessage(
      "Você tem um ótimo paladar e uma voz ativa no feed.",
    ),
    "rank_2_name": MessageLookupByLibrary.simpleMessage("Gourmet do döner"),
    "rank_3_desc": MessageLookupByLibrary.simpleMessage(
      "Um especialista reconhecido tanto em sabores quanto na comunidade.",
    ),
    "rank_3_name": MessageLookupByLibrary.simpleMessage("Mestre dos molhos"),
    "rank_4_desc": MessageLookupByLibrary.simpleMessage(
      "Faltam pouquíssimas metas para completar tudo!",
    ),
    "rank_4_name": MessageLookupByLibrary.simpleMessage("Veterano do Kebabbo"),
    "rank_5_desc": MessageLookupByLibrary.simpleMessage(
      "Você conquistou todas as metas! Está no Olimpo do Kebabbo.",
    ),
    "rank_5_name": MessageLookupByLibrary.simpleMessage("Lenda suprema"),
    "rate_the_kebab": MessageLookupByLibrary.simpleMessage("Avalie o kebab"),
    "rating_title": MessageLookupByLibrary.simpleMessage("Avaliação"),
    "ready": MessageLookupByLibrary.simpleMessage("Pronto!"),
    "recharge_info": MessageLookupByLibrary.simpleMessage(
      "1 pacote recarrega a cada 12h (máx. 2)",
    ),
    "recharging_next_in": m28,
    "registrati_per_poter_visualizzare_il_feed":
        MessageLookupByLibrary.simpleMessage(
          "Cadastre-se para visualizar o feed",
        ),
    "remaining_count": m29,
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Remover dos favoritos",
    ),
    "removed_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Removido dos favoritos",
    ),
    "required_field": MessageLookupByLibrary.simpleMessage("Campo obrigatório"),
    "reroll": MessageLookupByLibrary.simpleMessage("Sortear de novo"),
    "reroll_step_1": MessageLookupByLibrary.simpleMessage(
      "👨‍🍳 Nova combinação a caminho...",
    ),
    "reroll_step_2": MessageLookupByLibrary.simpleMessage(
      "🔥 Equilibrando temperos e cozimento...",
    ),
    "reroll_step_3": MessageLookupByLibrary.simpleMessage(
      "✨ Procurando outra ótima sugestão...",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage("Redefinir senha"),
    "review": MessageLookupByLibrary.simpleMessage("Avaliação"),
    "reviewMessage": m30,
    "review_action": MessageLookupByLibrary.simpleMessage("Avaliar"),
    "review_already_exists_message": MessageLookupByLibrary.simpleMessage(
      "Já existe outra avaliação para este local, deseja substituí-la?",
    ),
    "review_already_exists_title": MessageLookupByLibrary.simpleMessage(
      "Avaliação já existente",
    ),
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Avaliação enviada com sucesso",
    ),
    "review_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Avaliar este Kebab",
    ),
    "review_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Avaliação atualizada com sucesso",
    ),
    "reviews_label": MessageLookupByLibrary.simpleMessage("Avaliações"),
    "riprova": MessageLookupByLibrary.simpleMessage("Tentar novamente"),
    "sandwich_tag": MessageLookupByLibrary.simpleMessage("Sanduíche"),
    "sandwiches": MessageLookupByLibrary.simpleMessage("Lanches"),
    "save_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Salvar nos favoritos",
    ),
    "scrivi_un_commento": MessageLookupByLibrary.simpleMessage(
      "Escreva um comentário...",
    ),
    "scrivi_un_post": MessageLookupByLibrary.simpleMessage(
      "Escreva um post...",
    ),
    "search_address_or_place": MessageLookupByLibrary.simpleMessage(
      "Buscar endereço ou local...",
    ),
    "search_kebab_to_compare": MessageLookupByLibrary.simpleMessage(
      "Buscar um kebab para comparar...",
    ),
    "search_kebabbo_places": MessageLookupByLibrary.simpleMessage(
      "Buscar entre os locais do Kebabbo",
    ),
    "search_places_hint": MessageLookupByLibrary.simpleMessage(
      "Ex. Istanbul, Agra, King...",
    ),
    "second_pack_slot": MessageLookupByLibrary.simpleMessage("2º pacote"),
    "section_initial_review": MessageLookupByLibrary.simpleMessage(
      "5. Sua primeira avaliação",
    ),
    "section_location": MessageLookupByLibrary.simpleMessage(
      "1. Localização no mapa 📍",
    ),
    "section_location_hint": MessageLookupByLibrary.simpleMessage(
      "Toque para posicionar o pino ou buscar o local. Coordenadas, endereço e nome serão preenchidos automaticamente!",
    ),
    "section_name_category": MessageLookupByLibrary.simpleMessage(
      "2. Nome e categoria 🌯",
    ),
    "section_opening_hours": MessageLookupByLibrary.simpleMessage(
      "3. Horário de funcionamento ⏰",
    ),
    "section_photo_optional": MessageLookupByLibrary.simpleMessage(
      "4. Foto do local (opcional)",
    ),
    "see_hours_photos_reviews": MessageLookupByLibrary.simpleMessage(
      "Ver horário, fotos e avaliações",
    ),
    "see_place": MessageLookupByLibrary.simpleMessage("Ver local"),
    "segui": MessageLookupByLibrary.simpleMessage("Seguir"),
    "segui_gia": MessageLookupByLibrary.simpleMessage("Já seguindo"),
    "seguiti": MessageLookupByLibrary.simpleMessage("Seguindo"),
    "select_first_kebab": MessageLookupByLibrary.simpleMessage(
      "Selecionar 1º kebab",
    ),
    "select_location_first": MessageLookupByLibrary.simpleMessage(
      "Selecione a localização no mapa antes de continuar! 📍",
    ),
    "select_on_map": MessageLookupByLibrary.simpleMessage("Selecionar no mapa"),
    "select_photo_first": MessageLookupByLibrary.simpleMessage(
      "Selecione uma foto antes de publicar",
    ),
    "select_place_to_review": MessageLookupByLibrary.simpleMessage(
      "Selecione o local para avaliar! 🌯",
    ),
    "select_second_kebab": MessageLookupByLibrary.simpleMessage(
      "Selecionar 2º kebab",
    ),
    "select_two_kebabs_to_compare": MessageLookupByLibrary.simpleMessage(
      "Selecione dois kebabs para ver a comparação detalhada.",
    ),
    "selected_point": MessageLookupByLibrary.simpleMessage("Ponto selecionado"),
    "seleziona_il_tuo_kebab_preferito": MessageLookupByLibrary.simpleMessage(
      "Selecione seu kebab favorito",
    ),
    "send_reset_email": MessageLookupByLibrary.simpleMessage(
      "Enviar e-mail de redefinição",
    ),
    "session_expired": MessageLookupByLibrary.simpleMessage(
      "Sessão expirada. Faça login novamente.",
    ),
    "share_action": MessageLookupByLibrary.simpleMessage("Compartilhar"),
    "share_message": m31,
    "share_more": MessageLookupByLibrary.simpleMessage("Mais"),
    "share_rating_line": m32,
    "share_this_kebab": MessageLookupByLibrary.simpleMessage(
      "Compartilhe este kebab",
    ),
    "show_all_distances": MessageLookupByLibrary.simpleMessage("Mostrar todos"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
    "sign_up_with_google": MessageLookupByLibrary.simpleMessage(
      "Cadastrar com o Google",
    ),
    "signup_tagline": MessageLookupByLibrary.simpleMessage(
      "Crie seu perfil e comece a avaliar os kebabs da sua cidade",
    ),
    "single_card": MessageLookupByLibrary.simpleMessage("Carta Kebabbo"),
    "sort_dimension": MessageLookupByLibrary.simpleMessage("tamanho"),
    "sort_distance": MessageLookupByLibrary.simpleMessage("distância"),
    "sort_menu": MessageLookupByLibrary.simpleMessage("menu"),
    "sort_name": MessageLookupByLibrary.simpleMessage("nome"),
    "sort_price": MessageLookupByLibrary.simpleMessage("preço"),
    "sort_quality": MessageLookupByLibrary.simpleMessage("qualidade"),
    "sort_stars": MessageLookupByLibrary.simpleMessage("estrelas"),
    "sovrascrivi": MessageLookupByLibrary.simpleMessage("Substituir"),
    "spicy": MessageLookupByLibrary.simpleMessage("Picante"),
    "staff": MessageLookupByLibrary.simpleMessage("Equipe"),
    "staff_certified": MessageLookupByLibrary.simpleMessage(
      "Certificado pela equipe Kebabbo",
    ),
    "staff_kebabbo": MessageLookupByLibrary.simpleMessage("Equipe Kebabbo"),
    "submit_review": MessageLookupByLibrary.simpleMessage("Enviar avaliação"),
    "successfully_updated_profile": MessageLookupByLibrary.simpleMessage(
      "Perfil atualizado com sucesso!",
    ),
    "swipe_collection_hint": MessageLookupByLibrary.simpleMessage(
      "Deslize para navegar na coleção",
    ),
    "tab_overview": MessageLookupByLibrary.simpleMessage("Visão geral"),
    "tab_photos": m33,
    "tab_reviews": m34,
    "tag_kebab_pill": MessageLookupByLibrary.simpleMessage("Kebab 🌯"),
    "tag_sandwich_pill": MessageLookupByLibrary.simpleMessage(
      "Sanduicheria 🥪",
    ),
    "tap_map_to_select": MessageLookupByLibrary.simpleMessage(
      "Toque no mapa para selecionar o ponto exato",
    ),
    "tap_to_browse_album": MessageLookupByLibrary.simpleMessage(
      "Toque para ver o álbum completo ›",
    ),
    "tap_to_open_pack": MessageLookupByLibrary.simpleMessage(
      "Toque para abrir o pacote!",
    ),
    "tap_to_select_photo": MessageLookupByLibrary.simpleMessage(
      "Toque para selecionar uma foto",
    ),
    "tcg_album": MessageLookupByLibrary.simpleMessage("Álbum de cartas TCG"),
    "tcg_cards_count": m35,
    "ten_posts": MessageLookupByLibrary.simpleMessage("10 posts"),
    "ten_reviews": MessageLookupByLibrary.simpleMessage("10 avaliações"),
    "testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo":
        MessageLookupByLibrary.simpleMessage(
          "Testamos e analisamos lugares de kebab e comida de rua para você. Bem-vindo ao Kebabbo.",
        ),
    "testo_non_disponibile": MessageLookupByLibrary.simpleMessage(
      "Texto não disponível",
    ),
    "thank_you": MessageLookupByLibrary.simpleMessage("Obrigado"),
    "thank_you_for_your_review": MessageLookupByLibrary.simpleMessage(
      "Obrigado por sua avaliação!",
    ),
    "thirty_reviews": MessageLookupByLibrary.simpleMessage("30 avaliações"),
    "twenty_reviews": MessageLookupByLibrary.simpleMessage("20 avaliações"),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado",
    ),
    "unit_posts": MessageLookupByLibrary.simpleMessage("posts"),
    "unit_reviews": MessageLookupByLibrary.simpleMessage("avaliações"),
    "unlocked_badge": MessageLookupByLibrary.simpleMessage("Desbloqueada"),
    "unlocked_of_total": m36,
    "unpack_and_view_collection": MessageLookupByLibrary.simpleMessage(
      "Abrir e ver coleção",
    ),
    "unpack_new_cards": MessageLookupByLibrary.simpleMessage(
      "Abra novas cartas",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Atualizar"),
    "upload": MessageLookupByLibrary.simpleMessage("Enviar"),
    "upload_error": m37,
    "upload_first_photo": MessageLookupByLibrary.simpleMessage(
      "Envie a primeira foto",
    ),
    "upload_place_photo": MessageLookupByLibrary.simpleMessage(
      "Envie uma foto do espeto ou do local",
    ),
    "user_generic": MessageLookupByLibrary.simpleMessage("Usuário"),
    "user_no_posts_desc": MessageLookupByLibrary.simpleMessage(
      "Este usuário ainda não publicou no feed.",
    ),
    "user_no_reviews_desc": MessageLookupByLibrary.simpleMessage(
      "Este usuário ainda não avaliou nenhum kebab.",
    ),
    "user_not_authenticated": MessageLookupByLibrary.simpleMessage(
      "Usuário não autenticado",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage(
      "Usuário não encontrado",
    ),
    "user_not_found_login_again": MessageLookupByLibrary.simpleMessage(
      "Usuário não encontrado. Faça login novamente.",
    ),
    "username_can_only_contain_letters_numbers_and_underscores":
        MessageLookupByLibrary.simpleMessage(
          "O nome de usuário só pode conter letras,\nnúmeros e sublinhados!",
        ),
    "username_cannot_be_more_than_12_characters":
        MessageLookupByLibrary.simpleMessage(
          "O nome de usuário não pode ter mais de\n12 caracteres!",
        ),
    "username_cannot_contain_spaces_use_undescores_instead":
        MessageLookupByLibrary.simpleMessage(
          "O nome de usuário não pode conter espaços,\nuse sublinhados em vez disso!",
        ),
    "username_must_be_at_least_3_characters_long":
        MessageLookupByLibrary.simpleMessage(
          "O nome de usuário deve ter pelo menos 3\ncaracteres!",
        ),
    "users": MessageLookupByLibrary.simpleMessage("Usuários"),
    "users_count": m38,
    "users_review": MessageLookupByLibrary.simpleMessage(
      "Avaliação dos usuários",
    ),
    "vegetables": MessageLookupByLibrary.simpleMessage("Legumes"),
    "verdura": MessageLookupByLibrary.simpleMessage("Vegetais"),
    "verified_by_staff_tooltip": MessageLookupByLibrary.simpleMessage(
      "Verificado pela equipe Kebabbo",
    ),
    "vuoi_veramente_eliminare_il_post": MessageLookupByLibrary.simpleMessage(
      "Tem certeza de que deseja excluir a postagem?",
    ),
    "world": MessageLookupByLibrary.simpleMessage("Mundo"),
    "write_a_review_for_a_kebab_near_you": MessageLookupByLibrary.simpleMessage(
      "Escreva uma avaliação",
    ),
    "write_first_review": MessageLookupByLibrary.simpleMessage(
      "Escreva a primeira avaliação",
    ),
    "write_review_subtitle": MessageLookupByLibrary.simpleMessage(
      "Avalie a qualidade, a carne e os molhos",
    ),
    "write_review_title": MessageLookupByLibrary.simpleMessage(
      "Escrever uma avaliação",
    ),
    "yes_create_new": MessageLookupByLibrary.simpleMessage("Sim, criar novo"),
    "yogurt": MessageLookupByLibrary.simpleMessage("Iogurte"),
    "you_can_access_reviews_at_any_time_from_your_account":
        MessageLookupByLibrary.simpleMessage(
          "Você pode acessar as avaliações a qualquer momento em sua conta.",
        ),
    "your_experience": MessageLookupByLibrary.simpleMessage("Sua experiência"),
    "your_kebab": MessageLookupByLibrary.simpleMessage("O teu kebab"),
    "your_medals_title": MessageLookupByLibrary.simpleMessage("Suas Medalhas"),
    "your_profile": MessageLookupByLibrary.simpleMessage("Seu perfil"),
    "your_review_optional": MessageLookupByLibrary.simpleMessage(
      "Sua avaliação (opcional)",
    ),
  };
}
