// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get nome_non_disponibile => 'Nome não disponível';

  @override
  String get seleziona_il_tuo_kebab_preferito => 'Selecione seu kebab favorito';

  @override
  String get consigliaci_un_kebabbaro => 'Recomende um lugar de kebab';

  @override
  String get nome_del_kebabbaro => 'Nome do lugar de kebab';

  @override
  String get annulla => 'Cancelar';

  @override
  String get invia => 'Enviar';

  @override
  String get la_tua_soluzione_per_il_pranzo_universitario =>
      'Sua solução para o almoço universitário';

  @override
  String get in_italia_il_mondo_del_kebab_e_ancora_un_mondo_oscuro_i_migliori_locali_sono_sottovalutati_e_i_peggiori_ricevono_recensioni_alte_su_google =>
      'Na Itália, o mundo do kebab ainda é um mundo obscuro. Os melhores lugares são subestimados e os piores recebem avaliações altas no Google.';

  @override
  String get per_questo_ci_siamo_noi_studenti_universitari_come_voi_con_anni_di_esperienza_come_mangiatori_di_kebab =>
      'É por isso que estamos aqui: estudantes universitários, como você, com anos de experiência como comedores de kebab.';

  @override
  String get testiamo_e_recensiamo_kebabbari_e_street_food_per_voi_benvenuti_su_kebabbo =>
      'Testamos e analisamos lugares de kebab e comida de rua para você. Bem-vindo ao Kebabbo.';

  @override
  String get failed_to_load_reviews_count =>
      'Falha ao carregar a contagem de avaliações';

  @override
  String get cambia_username => 'Alterar nome de usuário';

  @override
  String get nuovo_username => 'Novo nome de usuário...';

  @override
  String get cancel => 'Cancelar';

  @override
  String get update => 'Atualizar';

  @override
  String get failed_to_upload_avatar => 'Falha ao carregar o avatar';

  @override
  String get edit_profile => 'Editar perfil';

  @override
  String get unexpected_error_occurred => 'Ocorreu um erro inesperado';

  @override
  String get failed_to_load_favorites => 'Falha ao carregar os favoritos';

  @override
  String get nessun_kebab_tra_i_preferiti => 'Sem kebabs nos favoritos';

  @override
  String get no_suggestions_available => 'Nenhuma sugestão disponível';

  @override
  String get devi_essere_autenticato_per_postare =>
      'Você precisa estar autenticado para postar';

  @override
  String get il_testo_non_puo_essere_vuoto => 'O texto não pode estar vazio';

  @override
  String get errore_nel_caricamento_dellimage => 'Erro ao carregar a imagem:';

  @override
  String get congratulazioni => 'Parabéns!';

  @override
  String get hai_raggiunto_un_nuovo_traguardo_e_ottenuto_una_nuova_medaglia =>
      'Você atingiu um novo marco e obteve uma nova medalha!';

  @override
  String get scrivi_un_post => 'Escreva um post...';

  @override
  String get testo_non_disponibile => 'Texto não disponível';

  @override
  String get non_segui_ancora_nessuno => 'Você ainda não está seguindo ninguém';

  @override
  String get errore_nel_caricamento_dei_follower =>
      'Erro ao carregar seguidores';

  @override
  String get nessun_utente_ti_segue => 'Nenhum usuário está te seguindo';

  @override
  String get il_kebab_che_ti_raccomandiamo_e => 'O kebab que recomendamos é:';

  @override
  String get kebab_consigliato => 'Kebab recomendado';

  @override
  String get kebab_sconosciuto => 'Kebab desconhecido';

  @override
  String get descrizione_non_disponibile => 'Descrição não disponível';

  @override
  String get back_to_build => 'Voltar para a construção';

  @override
  String get check_your_email_for_a_login_link =>
      'Verifique seu e-mail para obter um link de login!';

  @override
  String get by_signing_in_you_agree_to_our_terms_and_privacy_policy =>
      'Ao fazer login, você concorda com nossos termos e política de privacidade.';

  @override
  String get prendete_e_mangiatene_tutti_questo_e_il_kebab_offerto_in_sacrificio_per_voi =>
      '\"Tomai e comei todos: este é o kebab oferecido em sacrifício por vós.\"';

  @override
  String get failed_to_load_medals => 'Falha ao carregar medalhas';

  @override
  String get prima_review => 'primeira avaliação';

  @override
  String get primo_post => 'primeira publicação';

  @override
  String reviewMessage(
      String kebabName,
      String qualityRating,
      String quantityRating,
      String menuRating,
      String priceRating,
      String funRating,
      String description) {
    return 'Acabei de avaliar o kebab no $kebabName!\n\nQualidade: $qualityRating\nQuantidade: $quantityRating\nMenu: $menuRating\nPreço: $priceRating\nDiversão: $funRating\n\n$description';
  }

  @override
  String get review_updated_successfully => 'Avaliação atualizada com sucesso';

  @override
  String get review_submitted_successfully => 'Avaliação enviada com sucesso';

  @override
  String get nuova_medaglia => 'Nova medalha!';

  @override
  String get hai_ricevuto_una_nuova_medaglia_per_il_tuo_contributo =>
      'Você recebeu uma nova medalha por sua contribuição!';

  @override
  String get review => 'Avaliação';

  @override
  String get oops_review_not_found => 'Ops! Avaliação não encontrada';

  @override
  String get please_log_in_to_submit_your_review =>
      'Faça login para enviar sua avaliação';

  @override
  String get rate_the_kebab => 'Avalie o kebab';

  @override
  String get quality => 'Qualidade';

  @override
  String get quantity => 'Quantidade';

  @override
  String get menu => 'Cardápio';

  @override
  String get price => 'Preço';

  @override
  String get fun => 'Diversão';

  @override
  String get description_is_required => 'Descrição é obrigatória';

  @override
  String get submit_review => 'Enviar avaliação';

  @override
  String get registrati_per_poter_visualizzare_il_feed =>
      'Cadastre-se para visualizar o feed';

  @override
  String get cerca_utenti => 'Pesquisar usuários...';

  @override
  String get anonimo => 'Anônimo';

  @override
  String get nessun_utente_seguito => 'Nenhum usuário seguido';

  @override
  String get failed_to_load_follower_count =>
      'Falha ao carregar a contagem de seguidores';

  @override
  String get failed_to_load_profile => 'Falha ao carregar o perfil';

  @override
  String get failed_to_update_follow_status =>
      'Falha ao atualizar o status de seguimento';

  @override
  String get failed_to_load_post_count =>
      'Falha ao carregar a contagem de posts';

  @override
  String get segui_gia => 'Já seguindo';

  @override
  String get segui => 'Seguir';

  @override
  String get seguiti => 'Seguindo';

  @override
  String get world => 'Mundo';

  @override
  String get legends => 'Lendas';

  @override
  String get errore => 'Erro:';

  @override
  String get nessun_kebabbaro_presente => 'Nenhum lugar de kebab presente :(';

  @override
  String get thank_you => 'Obrigado';

  @override
  String get thank_you_for_your_review => 'Obrigado por sua avaliação!';

  @override
  String get you_can_access_reviews_at_any_time_from_your_account =>
      'Você pode acessar as avaliações a qualquer momento em sua conta.';

  @override
  String get build_your_kebab => 'Monte seu kebab';

  @override
  String get distanza_massima => 'Distância máxima';

  @override
  String get preferiti_solo_per_utenti_registrati =>
      'Favoritos apenas para usuários registrados';

  @override
  String get it_looks_like_the_review_you_are_trying_to_access_does_not_exist_please_check_the_link_and_try_again =>
      'Parece que a avaliação que você está tentando acessar não existe. Verifique o link e tente novamente.';

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
      'Nenhum kebab correspondente encontrado dentro do raio selecionado';

  @override
  String get cerca_un_kebabbaro => 'Pesquise um lugar de kebab...';

  @override
  String get aperti_ora => 'Aberto agora';

  @override
  String get failed_to_load_posts => 'Falha ao carregar posts';

  @override
  String get i_tuoi_post => 'Suas publicações';

  @override
  String get nessun_post_trovato => 'Nenhum post encontrado';

  @override
  String get nessuna_recensione_ancora => 'Nenhuma avaliação ainda';

  @override
  String get successfully_updated_profile => 'Perfil atualizado com sucesso!';

  @override
  String get username_cannot_contain_spaces_use_undescores_instead =>
      'O nome de usuário não pode conter espaços,\nuse sublinhados em vez disso!';

  @override
  String get username_must_be_at_least_3_characters_long =>
      'O nome de usuário deve ter pelo menos 3\ncaracteres!';

  @override
  String get username_cannot_be_more_than_12_characters =>
      'O nome de usuário não pode ter mais de\n12 caracteres!';

  @override
  String get username_can_only_contain_letters_numbers_and_underscores =>
      'O nome de usuário só pode conter letras,\nnúmeros e sublinhados!';

  @override
  String get esplora => 'Explorar';

  @override
  String get mappa => 'Mapa';

  @override
  String get no_image => 'Sem imagem';

  @override
  String get nessun_commento_disponibile => 'Nenhum comentário disponível';

  @override
  String get commento_non_disponibile => 'Comentário não disponível';

  @override
  String get scrivi_un_commento => 'Escreva um comentário...';

  @override
  String get il_commento_e_stato_aggiunto_con_successo =>
      'O comentário foi adicionado com sucesso!';

  @override
  String get user_not_found => 'Usuário não encontrado';

  @override
  String get an_error_occurred => 'Ocorreu um erro';

  @override
  String get log_in_con_google => 'Entrar com o Google';

  @override
  String get aperto => 'Aberto';

  @override
  String get chiuso => 'Fechado';

  @override
  String get nessuna_recensione_disponibile => 'Nenhuma avaliação disponível';

  @override
  String get users_review => 'Avaliação dos usuários';

  @override
  String get km_distante_da_te => 'km distante de você';

  @override
  String get distanza_non_disponibile => 'Distância não disponível';

  @override
  String get verdura => 'Vegetais';

  @override
  String get yogurt => 'Iogurte';

  @override
  String get spicy => 'Picante';

  @override
  String get cipolla => 'Cebola';

  @override
  String get description => 'Descrição';

  @override
  String get more_info => 'Como avaliar um kebab';

  @override
  String get close => 'Fechar';

  @override
  String get popup_title => 'Como escrever sua própria avaliação';

  @override
  String get first_time_title => 'Bem-vindo ao Kebabbo!';

  @override
  String get elimina => 'Excluir';

  @override
  String get vuoi_veramente_eliminare_il_post =>
      'Tem certeza de que deseja excluir a postagem?';

  @override
  String get conferma_eliminazione => 'Confirmar exclusão';

  @override
  String get post_eliminato => 'Postagem excluída';

  @override
  String get devi_essere_autenticato_per_mettere_mi_piace =>
      'Você precisa fazer login para curtir';

  @override
  String get accedi_per_cercare =>
      'Faça login para postar e ver as informações das pessoas';

  @override
  String get devi_essere_autenticato_per_commentare =>
      'Você precisa fazer login para comentar';

  @override
  String get devi_essere_autenticato_per_visualizzare_il_profilo =>
      'Você precisa fazer login para visualizar o perfil';

  @override
  String get sign_up => 'Inscrever-se';

  @override
  String get please_enter_your_email => 'Por favor, insira seu email';

  @override
  String get please_enter_a_valid_email => 'Por favor, insira um email válido';

  @override
  String get please_enter_a_password => 'Por favor, insira uma senha';

  @override
  String get password_must_be_at_least_6_characters =>
      'A senha deve ter pelo menos 6 caracteres';

  @override
  String get check_your_email_for_a_verification_link =>
      'Verifique seu email para obter um link de verificação';

  @override
  String get dont_have_an_account_sign_up => 'Não tem uma conta? Inscrever-se';

  @override
  String get logged_in => 'Conectado';

  @override
  String get login => 'Entrar';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get popup_description =>
      'Para garantir que as avaliações dos usuários sejam verdadeiras, para avaliar você mesmo o kebab,\nvocê precisa ir pessoalmente ao local do kebab e encontrar o adesivo Kebabbo afixado nas proximidades,\nao escaneá-lo, você será direcionado para a página de avaliação.';

  @override
  String get first_time_description =>
      'Bem-vindo ao Kebabbo!\nO que você pode fazer aqui?\nBem, você pode explorar nossas avaliações profissionais de kebab ou verificar as avaliações de outros usuários.\nEscreva sua própria avaliação digitalizando o adesivo Kebabbo no local do kebab.\nConfira os perfis e posts de outros usuários, conecte-se com outros amantes de kebab e ganhe conquistas por usar o aplicativo.\nUse nossos recursos de pesquisa e filtro ou nossa poderosa ferramenta de construção para encontrar seu kebab ideal ou explore nosso mapa interativo para descobrir joias nas proximidades.\nDivirta-se e aproveite seu kebab!';

  @override
  String get cambia_profilo => 'mudar perfil';

  @override
  String get cambia_profilepic => 'alterar foto do perfil';

  @override
  String get please_fill_in_all_fields => 'por favor preencha todos os campos';

  @override
  String get password_minimum_length =>
      'A senha deve ter no mínimo 6 caracteres';

  @override
  String get email_required => 'O email é obrigatório';

  @override
  String get send_reset_email => 'Enviar e-mail de redefinição';

  @override
  String get forgot_password => 'Esqueci minha senha';

  @override
  String get check_your_email_for_a_reset_link =>
      'Verifique seu e-mail para obter um link de redefinição';

  @override
  String get password_reset_success => 'Redefinição de senha bem-sucedida';

  @override
  String get new_password => 'Nova senha';

  @override
  String get reset_password => 'Redefinir senha';

  @override
  String get nessun_kebab_vicino_a_te =>
      'Nenhum kebab perto de você \nVocê deve estar próximo da loja de kebab para avaliá-la por motivos de autenticidade.\nVerifique sua localização e recarregue a página.';

  @override
  String get riprova => 'Tentar novamente';

  @override
  String get no_thanks => 'Não, obrigado';

  @override
  String get app_is_installed_description =>
      'Abra no app para uma experiência melhor. Se ainda não tiver, levamos você ao Google Play.';

  @override
  String get app_is_installed => 'O Kebabbo também é um app!';

  @override
  String get single_card => 'Carta Kebabbo';

  @override
  String get pack => 'Pacote Kebabbo';

  @override
  String get my_cards => 'Coleção Kebab TCG';

  @override
  String get pack_too_soon => 'Este pacote ainda não está disponível';

  @override
  String get no_cards_yet => 'Você ainda não tem nenhuma carta';

  @override
  String get open_pack => 'Abrir Pacote';

  @override
  String get go_back => 'Voltar';

  @override
  String get write_a_review_for_a_kebab_near_you => 'Escreva uma avaliação';

  @override
  String get autenticazione_necessaria =>
      'Você precisa estar autenticado para comentar.';

  @override
  String get commento_vuoto => 'O texto do comentário não pode estar vazio.';

  @override
  String get found_all_cards => 'Todos os cards encontrados.';

  @override
  String get about => 'Sobre';

  @override
  String get privacy_policy => 'Política de Privacidade';

  @override
  String get add_kebab => 'Adicionar um Kebab';

  @override
  String get logout => 'Sair';

  @override
  String get could_not_open_link => 'Não foi possível abrir o link.';

  @override
  String get generic_error => 'Erro: ';

  @override
  String get posts => 'Posts';

  @override
  String get followers => 'Seguidores';

  @override
  String get following => 'Seguindo';

  @override
  String get error_processing_image => 'Erro ao processar imagem:';

  @override
  String get followed_filter => 'Seguindo';

  @override
  String get all_filter => 'Todos';

  @override
  String get games_tools_title => 'Jogos e Ferramentas';

  @override
  String get login_required_section =>
      'Você deve fazer login para usar esta seção.';

  @override
  String get add_review_title => 'Adicionar Avaliação';

  @override
  String get add_review_subtitle => 'Provou um kebab novo?';

  @override
  String get pack_button_title => 'Pacote';

  @override
  String get pack_button_subtitle => 'abra seu pacote de kebab favorito';

  @override
  String get collection_title => 'Coleção';

  @override
  String get collection_subtitle => 'veja suas cartas kebabbo';

  @override
  String get create_kebab_title => 'Criar Kebab';

  @override
  String get create_kebab_subtitle => 'monte seu próprio kebab';

  @override
  String get your_medals_title => 'Suas Medalhas';

  @override
  String get add_review_appbar_title => 'Adicionar Avaliação';

  @override
  String get error_loading_kebabs => 'Erro ao carregar kebabs: ';

  @override
  String get kebab_not_found => 'Kebab não encontrado';

  @override
  String get add_new_kebab_confirmation =>
      'Você está prestes a adicionar \"\$name\" como um novo kebab. Tem certeza que ele não existe?';

  @override
  String get city => 'Cidade';

  @override
  String get yes_create_new => 'Sim, criar novo';

  @override
  String get user_not_authenticated => 'Usuário não autenticado';

  @override
  String get error_adding_review => 'Erro ao adicionar avaliação: ';

  @override
  String get name_label => 'Nome';

  @override
  String get required_field => 'Campo obrigatório';

  @override
  String get kebab_already_exists => 'Kebab já existe';

  @override
  String get your_review_optional => 'Sua avaliação (opcional)';

  @override
  String get kebab_tag => 'Kebab';

  @override
  String get sandwich_tag => 'Sanduíche';

  @override
  String get dimension => 'Tamanho';

  @override
  String get meat => 'Carne';

  @override
  String get onion => 'Cebola';

  @override
  String get vegetables => 'Legumes';

  @override
  String get gluten_free => 'Sem Glúten';

  @override
  String get advanced_filters => 'Filtros Avançados';

  @override
  String get open_now => 'Aberto Agora';

  @override
  String get sandwiches => 'Lanches';

  @override
  String get order_by => 'Ordenar por';

  @override
  String get filter_by_distance => 'Filtrar por distância';

  @override
  String get sort_stars => 'estrelas';

  @override
  String get sort_quality => 'qualidade';

  @override
  String get sort_price => 'preço';

  @override
  String get sort_dimension => 'tamanho';

  @override
  String get sort_menu => 'menu';

  @override
  String get sort_name => 'nome';

  @override
  String get sort_distance => 'distância';

  @override
  String get fun_exclamation => 'divertido!';

  @override
  String get kebabbo_review => 'Avaliação Kebabbo';

  @override
  String get review_this_kebab => 'Avaliar este Kebab';

  @override
  String get staff => 'Equipe';

  @override
  String get users => 'Usuários';

  @override
  String get one_review => '1 avaliação';

  @override
  String get five_reviews => '5 avaliações';

  @override
  String get ten_reviews => '10 avaliações';

  @override
  String get twenty_reviews => '20 avaliações';

  @override
  String get thirty_reviews => '30 avaliações';

  @override
  String get one_post => '1 post';

  @override
  String get five_posts => '5 posts';

  @override
  String get ten_posts => '10 posts';

  @override
  String get fifty_posts => '50 posts';

  @override
  String get build_button => 'Montar!';

  @override
  String get objectives => 'Objetivos';

  @override
  String get your_kebab => 'O teu kebab';

  @override
  String get kebab_no_longer_available => 'Kebab não está mais disponível';

  @override
  String get inserted_by => 'Adicionado por';

  @override
  String get community_upload => 'Comunidade';

  @override
  String get staff_certified => 'Certificado pela equipe Kebabbo';

  @override
  String get swipe_collection_hint => 'Deslize para navegar na coleção';

  @override
  String get examine_3d => 'Examinar em 3D';

  @override
  String get details => 'Detalhes';

  @override
  String get verified_by_staff_tooltip => 'Verificado pela equipe Kebabbo';

  @override
  String get sign_up_with_google => 'Cadastrar com o Google';

  @override
  String get or_continue_with_email => 'ou com e-mail';

  @override
  String get already_have_an_account => 'Já tem uma conta? Entrar';

  @override
  String get location_services_disabled =>
      'Os serviços de localização estão desativados.';

  @override
  String get location_permission_denied => 'Permissão de localização negada.';

  @override
  String get location_permission_denied_forever =>
      'Permissão de localização negada permanentemente. Você pode ativá-la nas configurações.';

  @override
  String get session_expired => 'Sessão expirada. Faça login novamente.';

  @override
  String get contribute_title => 'Contribua com o Kebabbo';

  @override
  String get contribute_subtitle =>
      'Ajude-nos a mapear e avaliar os melhores lugares de kebab!';

  @override
  String get add_kebab_place => 'Adicionar um lugar de kebab';

  @override
  String get add_kebab_place_subtitle => 'Adicione um novo local ao mapa';

  @override
  String get write_review_title => 'Escrever uma avaliação';

  @override
  String get write_review_subtitle => 'Avalie a qualidade, a carne e os molhos';

  @override
  String get nav_home => 'Início';

  @override
  String get nav_add => 'Adicionar';

  @override
  String get nav_feed => 'Feed';

  @override
  String get nav_account => 'Conta';

  @override
  String get page_not_found => 'Página não encontrada';

  @override
  String get maps_link_name_and_coords_found =>
      'Coordenadas e nome detectados no link do Maps! 📍';

  @override
  String get maps_link_coords_found =>
      'Coordenadas detectadas no link do Maps! 📍';

  @override
  String get maps_link_failed =>
      'Não foi possível extrair as coordenadas do link. Use \"Escolher no mapa\".';

  @override
  String get select_location_first =>
      'Selecione a localização no mapa antes de continuar! 📍';

  @override
  String error_saving(String error) {
    return 'Erro ao salvar: $error';
  }

  @override
  String get section_location => '1. Localização no mapa 📍';

  @override
  String get section_location_hint =>
      'Toque para posicionar o pino ou buscar o local. Coordenadas, endereço e nome serão preenchidos automaticamente!';

  @override
  String get edit_location_on_map => 'Editar localização no mapa';

  @override
  String get choose_on_map_recommended => 'Escolher no mapa (recomendado)';

  @override
  String city_label(String city) {
    return 'Cidade: $city';
  }

  @override
  String get location_selected => 'Localização selecionada';

  @override
  String get paste_maps_link_prompt =>
      'Já tem um link do Google Maps? Cole aqui';

  @override
  String get google_maps_link => 'Link do Google Maps';

  @override
  String get extract => 'Extrair';

  @override
  String get section_name_category => '2. Nome e categoria 🌯';

  @override
  String get kebab_place_name_label => 'Nome do local *';

  @override
  String get kebab_place_name_hint => 'Ex. Bella Istanbul 3';

  @override
  String get name_autofilled_helper =>
      'Preenchido automaticamente pelo mapa (pode editar)';

  @override
  String get enter_place_name => 'Insira o nome do local';

  @override
  String get tag_kebab_pill => 'Kebab 🌯';

  @override
  String get tag_sandwich_pill => 'Sanduicheria 🥪';

  @override
  String get gluten_free_option => 'Opção sem glúten';

  @override
  String get gluten_free_option_desc =>
      'Oferece pão ou opções sem glúten certificadas';

  @override
  String get section_opening_hours => '3. Horário de funcionamento ⏰';

  @override
  String get opening_hours_hint =>
      'Você pode deixar sem especificar, escolher um modelo ou definir horários personalizados:';

  @override
  String get hours_preset_none => 'Não especificado (padrão)';

  @override
  String get hours_preset_continuous => 'Contínuo (11-23) 🌯';

  @override
  String get hours_preset_night => 'Noturno (11-02) 🌙';

  @override
  String get hours_preset_lunch_dinner => 'Almoço e jantar 🍽️';

  @override
  String get hours_preset_custom => 'Personalizado ⚙️';

  @override
  String get hours_none_note => 'Nenhum horário será salvo.';

  @override
  String get custom_hours_hint =>
      'Defina o horário de cada dia (ex. 11:00-23:00 ou \"fechado\"):';

  @override
  String get section_photo_optional => '4. Foto do local (opcional)';

  @override
  String get upload_place_photo => 'Envie uma foto do espeto ou do local';

  @override
  String get section_initial_review => '5. Sua primeira avaliação';

  @override
  String get description_review_label => 'Descrição / avaliação *';

  @override
  String get description_review_hint =>
      'Conte como é este kebab: pão, carne, sabores...';

  @override
  String get description_review_required =>
      'Escreva um breve comentário para apresentar o local';

  @override
  String get overall_rating_1_5 => 'Avaliação geral (1 a 5)';

  @override
  String get ingredient_balance_1_10 => 'Equilíbrio de ingredientes (1 a 10)';

  @override
  String get add_kebab_to_kebabbo => 'Adicionar local ao Kebabbo';

  @override
  String get added_to_favorites => 'Adicionado aos favoritos ❤️';

  @override
  String get removed_from_favorites => 'Removido dos favoritos';

  @override
  String get remove_from_favorites => 'Remover dos favoritos';

  @override
  String get save_to_favorites => 'Salvar nos favoritos';

  @override
  String get map_not_available => 'Mapa não disponível para este local';

  @override
  String get login_to_post_photos => 'Faça login para publicar fotos';

  @override
  String get select_photo_first => 'Selecione uma foto antes de publicar';

  @override
  String get photo_added => 'Foto adicionada! 📸';

  @override
  String upload_error(String error) {
    return 'Erro ao enviar: $error';
  }

  @override
  String add_photo_to(String name) {
    return 'Adicionar foto a $name';
  }

  @override
  String get tap_to_select_photo => 'Toque para selecionar uma foto';

  @override
  String get photo_caption_hint =>
      'Escreva um comentário ou descreva seu kebab...';

  @override
  String get publish_photo => 'Publicar foto';

  @override
  String get kebabbo_user => 'Usuário Kebabbo';

  @override
  String get kebab_place_not_found => 'Local não encontrado ou removido.';

  @override
  String get review_action => 'Avaliar';

  @override
  String get photo => 'Foto';

  @override
  String get tab_overview => 'Visão geral';

  @override
  String tab_photos(String count) {
    return 'Fotos ($count)';
  }

  @override
  String tab_reviews(String count) {
    return 'Avaliações ($count)';
  }

  @override
  String get kebabbo_staff_review => 'A avaliação do Kebabbo';

  @override
  String get rating_title => 'Avaliação';

  @override
  String community_count(String count) {
    return 'Comunidade ($count)';
  }

  @override
  String get ingredient_balance => 'Equilíbrio de ingredientes';

  @override
  String get opening_hours => 'Horário de funcionamento';

  @override
  String get no_photos_yet => 'Ainda não há fotos';

  @override
  String get no_photos_yet_desc =>
      'Seja o primeiro a compartilhar uma foto do seu kebab ou prato deste local!';

  @override
  String get upload_first_photo => 'Envie a primeira foto';

  @override
  String get user_generic => 'Usuário';

  @override
  String get no_reviews_yet_desc =>
      'Compartilhe sua experiência neste local com toda a comunidade!';

  @override
  String get write_first_review => 'Escreva a primeira avaliação';

  @override
  String based_on_reviews(String count) {
    return 'Baseado em $count avaliações';
  }

  @override
  String get select_place_to_review => 'Selecione o local para avaliar! 🌯';

  @override
  String error_sending_review(String error) {
    return 'Erro ao enviar a avaliação: $error';
  }

  @override
  String get choose_place => 'Escolha o local';

  @override
  String get change => 'Mudar';

  @override
  String get search_kebabbo_places => 'Buscar entre os locais do Kebabbo';

  @override
  String get search_places_hint => 'Ex. Istanbul, Agra, King...';

  @override
  String get no_place_found_add_it =>
      'Nenhum local encontrado. Se for novo, use \"Adicionar um lugar de kebab\"!';

  @override
  String get your_experience => 'Sua experiência';

  @override
  String get comment_review_label => 'Comentário / avaliação *';

  @override
  String get comment_review_hint =>
      'O que você mais gostou? Recomenda algum molho ou menu?';

  @override
  String get comment_review_required =>
      'Escreva um breve comentário sobre sua experiência';

  @override
  String get add_dish_photo_optional =>
      'Adicione uma foto do seu prato (opcional)';

  @override
  String get publish_review => 'Publicar avaliação';

  @override
  String get tap_map_to_select => 'Toque no mapa para selecionar o ponto exato';

  @override
  String get select_on_map => 'Selecionar no mapa';

  @override
  String get center_on_my_location => 'Centralizar na minha localização';

  @override
  String get search_address_or_place => 'Buscar endereço ou local...';

  @override
  String get selected_point => 'Ponto selecionado';

  @override
  String get confirm_this_location => 'Confirmar esta localização';

  @override
  String get map_style_google_road => 'Google Mapa';

  @override
  String get map_style_google_satellite => 'Google Satélite';

  @override
  String change_map_style(String style) {
    return 'Mudar mapa: $style';
  }

  @override
  String get map_style_satellite_short => 'Satélite';

  @override
  String get map_style_road_short => 'Ruas';

  @override
  String users_count(String count) {
    return 'Usuários ($count)';
  }

  @override
  String get community_review => 'Avaliação da comunidade';

  @override
  String get no_user_reviews_yet => 'Nenhum usuário avaliou este local ainda!';

  @override
  String get directions => 'Como chegar';

  @override
  String get login_tagline =>
      'Entre na comunidade para descobrir e avaliar os melhores kebabs';

  @override
  String get no_account_question => 'Não tem uma conta?';

  @override
  String get signup_tagline =>
      'Crie seu perfil e comece a avaliar os kebabs da sua cidade';

  @override
  String get have_account_question => 'Já tem uma conta?';

  @override
  String password_reset_failed(String error) {
    return 'Falha ao redefinir a senha: $error';
  }

  @override
  String get objectives_and_medals => 'Objetivos e medalhas';

  @override
  String get no_more_kebabs_to_recommend =>
      'Não há outros kebabs para recomendar.';

  @override
  String get reroll => 'Sortear de novo';

  @override
  String get see_hours_photos_reviews => 'Ver horário, fotos e avaliações';

  @override
  String get upload => 'Enviar';

  @override
  String get ingredient_amounts_caps => 'QUANTIDADE DE INGREDIENTES';

  @override
  String error_deleting_post(String error) {
    return 'Erro ao excluir o post: $error';
  }

  @override
  String get privacy_policy_load_error =>
      'Erro ao carregar a política de privacidade';

  @override
  String get cooking_title => 'Preparando o kebab';

  @override
  String get cooking_title_reroll => 'Buscando alternativa';

  @override
  String get cooking_step_1 => '🔥 Esquentando o pão...';

  @override
  String get cooking_step_2 => '🥩 Cortando a carne do espeto...';

  @override
  String get cooking_step_3 => '🥗 Adicionando verduras frescas e molhos...';

  @override
  String get cooking_step_4 => '🌯 Enrolando como um profissional...';

  @override
  String get cooking_step_5 => '🔍 Procurando o melhor kebab para você...';

  @override
  String get reroll_step_1 => '👨‍🍳 Nova combinação a caminho...';

  @override
  String get reroll_step_2 => '🔥 Equilibrando temperos e cozimento...';

  @override
  String get reroll_step_3 => '✨ Procurando outra ótima sugestão...';

  @override
  String get user_not_found_login_again =>
      'Usuário não encontrado. Faça login novamente.';

  @override
  String no_pack_ready_hours_minutes(String hours, String minutes) {
    return 'Nenhum pacote pronto agora (0/2). O próximo estará pronto em ${hours}h ${minutes}min.';
  }

  @override
  String get no_cards_available => 'Nenhuma carta disponível.';

  @override
  String an_error_occurred_with(String error) {
    return 'Ocorreu um erro: $error';
  }

  @override
  String get opening_in_progress => 'Abrindo...';

  @override
  String get tap_to_open_pack => 'Toque para abrir o pacote!';

  @override
  String get duplicate_card => 'CARTA REPETIDA';

  @override
  String get new_card_unlocked => 'NOVA CARTA DESBLOQUEADA!';

  @override
  String already_in_collection(String name) {
    return '$name (já na coleção)';
  }

  @override
  String get drag_to_tilt => 'Arraste com o dedo para inclinar em 3D';

  @override
  String open_second_pack(String count) {
    return 'Abrir 2º pacote ($count)';
  }

  @override
  String get add_to_collection => 'Adicionar à coleção';

  @override
  String card_x_of_y(String current, String total) {
    return '#$current de $total';
  }

  @override
  String get card_collection => 'Coleção de cartas';

  @override
  String get all_found => 'Todas encontradas! 🏆';

  @override
  String remaining_count(String count) {
    return '$count restantes';
  }

  @override
  String get tap_to_browse_album => 'Toque para ver o álbum completo ›';

  @override
  String get unpack_new_cards => 'Abra novas cartas';

  @override
  String get recharge_info => '1 pacote recarrega a cada 12h (máx. 2)';

  @override
  String no_pack_ready_timer(String time) {
    return 'Nenhum pacote pronto. O próximo estará disponível em $time.';
  }

  @override
  String get first_pack_slot => '1º pacote';

  @override
  String get second_pack_slot => '2º pacote';

  @override
  String get ready => 'Pronto!';

  @override
  String get queued => 'Na fila';

  @override
  String get packs_full => 'Pacotes recarregados ao máximo: 2 / 2 prontos! 📦✨';

  @override
  String get open_pack_two_ready => 'Abrir pacote (2 prontos!)';

  @override
  String get no_pack_ready => 'Nenhum pacote pronto';

  @override
  String get tcg_album => 'Álbum de cartas TCG';

  @override
  String get cards_unlocked => 'cartas desbloqueadas';

  @override
  String missing_count(String count) {
    return 'faltam $count';
  }

  @override
  String get packs_ready_2 => '2 / 2 pacotes prontos para abrir';

  @override
  String get packs_ready_1 => '1 / 2 pacote pronto para abrir';

  @override
  String get packs_ready_0 => '0 / 2 pacotes disponíveis';

  @override
  String get max_charge_reached => 'Carga máxima atingida (1 a cada 12h)';

  @override
  String next_recharge_in(String time) {
    return 'Próxima recarga em $time';
  }

  @override
  String recharging_next_in(String time) {
    return 'Recarregando: próximo em $time';
  }

  @override
  String get unpack_and_view_collection => 'Abrir e ver coleção';

  @override
  String get medal_0_title => 'Primeira mordida';

  @override
  String get medal_1_title => 'Provador em série';

  @override
  String get medal_2_title => 'Crítico de kebab';

  @override
  String get medal_3_title => 'Mestre do espeto';

  @override
  String get medal_4_title => 'Lenda gastronômica';

  @override
  String get medal_5_title => 'Voz do feed';

  @override
  String get medal_6_title => 'Repórter do sabor';

  @override
  String get medal_7_title => 'Influenciador do kebab';

  @override
  String get medal_8_title => 'Pilar da comunidade';

  @override
  String get medal_0_desc =>
      'Você escreveu sua primeira avaliação de um lugar de kebab. Bem-vindo à família de críticos do Kebabbo!';

  @override
  String get medal_1_desc =>
      'Você avaliou 5 locais diferentes. Seu paladar começa a distinguir a verdadeira arte do espeto!';

  @override
  String get medal_2_desc =>
      '10 avaliações concluídas! Suas notas orientam os locais e toda a comunidade.';

  @override
  String get medal_3_desc =>
      '20 avaliações escritas! Nenhum wrap, molho ou pão sírio tem segredos para você. Um verdadeiro mestre!';

  @override
  String get medal_4_desc =>
      '30 avaliações no currículo! Você chegou ao topo da experiência culinária do Kebabbo. Uma lenda viva!';

  @override
  String get medal_5_desc =>
      'Você publicou seu primeiro post no feed. Sua paixão por kebab agora é pública!';

  @override
  String get medal_6_desc =>
      'Você compartilhou 5 posts com fotos e opiniões. A comunidade adora suas novidades!';

  @override
  String get medal_7_desc =>
      '10 posts compartilhados! Com suas fotos e marcações você deixa a cidade inteira com fome.';

  @override
  String get medal_8_desc =>
      '50 posts na comunidade! Você é um pilar insubstituível do feed do Kebabbo!';

  @override
  String get rank_5_name => 'Lenda suprema';

  @override
  String get rank_5_desc =>
      'Você conquistou todas as metas! Está no Olimpo do Kebabbo.';

  @override
  String get rank_4_name => 'Veterano do Kebabbo';

  @override
  String get rank_4_desc => 'Faltam pouquíssimas metas para completar tudo!';

  @override
  String get rank_3_name => 'Mestre dos molhos';

  @override
  String get rank_3_desc =>
      'Um especialista reconhecido tanto em sabores quanto na comunidade.';

  @override
  String get rank_2_name => 'Gourmet do döner';

  @override
  String get rank_2_desc =>
      'Você tem um ótimo paladar e uma voz ativa no feed.';

  @override
  String get rank_1_name => 'Apaixonado por espetos';

  @override
  String get rank_1_desc =>
      'As primeiras metas são suas! Continue avaliando e postando.';

  @override
  String get rank_0_name => 'Novato do kebab';

  @override
  String get rank_0_desc =>
      'Escreva sua primeira avaliação ou crie um post para começar a coleção!';

  @override
  String get unit_reviews => 'avaliações';

  @override
  String get unit_posts => 'posts';

  @override
  String get goal_reached => 'Meta alcançada 🎉';

  @override
  String get in_progress => 'Em andamento ⏳';

  @override
  String get progress_label => 'Progresso';

  @override
  String medal_missing(String missing, String unit) {
    return 'Faltam apenas $missing $unit para desbloquear esta medalha!';
  }

  @override
  String get medals_page_title => 'Medalhas e metas';

  @override
  String filter_all_count(String count) {
    return 'Todas ($count)';
  }

  @override
  String filter_reviews_count(String count) {
    return 'Avaliações ($count)';
  }

  @override
  String filter_unlocked_count(String count) {
    return 'Desbloqueadas ($count)';
  }

  @override
  String get no_medals_in_filter => 'Nenhuma medalha neste filtro';

  @override
  String unlocked_of_total(String unlocked, String total) {
    return '$unlocked de $total desbloqueadas';
  }

  @override
  String percent_completed(String percent) {
    return '$percent% concluído';
  }

  @override
  String get reviews_label => 'Avaliações';

  @override
  String get feed_posts_label => 'Posts no feed';

  @override
  String get unlocked_badge => 'Desbloqueada';

  @override
  String get completed_badge => 'Concluído! ⭐';

  @override
  String get open_in_app => 'Abrir o app';

  @override
  String get compare_kebabs => 'Comparar Kebabs';

  @override
  String get select_first_kebab => 'Selecionar 1º kebab';

  @override
  String get select_second_kebab => 'Selecionar 2º kebab';

  @override
  String get search_kebab_to_compare => 'Buscar um kebab para comparar...';

  @override
  String get pillars_comparison => 'Comparação de Pilares';

  @override
  String get ingredients_comparison => 'Comparação de Ingredientes';

  @override
  String get select_two_kebabs_to_compare =>
      'Selecione dois kebabs para ver a comparação detalhada.';

  @override
  String get review_already_exists_title => 'Avaliação já existente';

  @override
  String get review_already_exists_message =>
      'Já existe outra avaliação para este local, deseja substituí-la?';

  @override
  String get sovrascrivi => 'Substituir';

  @override
  String get open_or_get_app => 'Abrir ou baixar o app';

  @override
  String no_kebab_within_distance(String km) {
    return 'Nenhum lugar de kebab num raio de $km km.';
  }

  @override
  String get show_all_distances => 'Mostrar todos';

  @override
  String get maps_short_link_web =>
      'Na web, use o link completo do Google Maps (https://www.google.com/maps/place/...): links curtos são bloqueados pelo navegador.';

  @override
  String get login_to_follow_user => 'Faça login para seguir este usuário';

  @override
  String get profile_link_copied => 'Link do perfil copiado!';

  @override
  String tcg_cards_count(String count) {
    return '$count cartas TCG';
  }

  @override
  String get your_profile => 'Seu perfil';

  @override
  String get favorite_kebab_caps => 'KEBAB FAVORITO';

  @override
  String get no_posts_yet => 'Ainda não há posts';

  @override
  String get user_no_posts_desc => 'Este usuário ainda não publicou no feed.';

  @override
  String get user_no_reviews_desc =>
      'Este usuário ainda não avaliou nenhum kebab.';

  @override
  String get see_place => 'Ver local';

  @override
  String get staff_kebabbo => 'Equipe Kebabbo';

  @override
  String get origin_label => 'Origem';
}
