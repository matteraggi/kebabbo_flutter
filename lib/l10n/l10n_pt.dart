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
      'Kebabbo já está instalado no seu dispositivo. Deseja abri-lo?';

  @override
  String get app_is_installed => 'Aplicativo instalado';

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
}
