setfenv(1, FriendOTron)

local locale = GetLocale()
if IS_TURTLE_WOW and locale == "xxYY" then
    locale = "ptBR"
end
if locale ~= "ptBR" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    addon_loaded_message = "Núcleo de replicação de amigos ativado! Consulte interface de controle via '/fot help' para parâmetros operacionais",
    addon_help_message = "GUIA DO USUÁRIO APROVADO POR GNOMOS: Configure notificações com '/fot quiet' (MODO STEALTH) ou '/fot noisy' (ENTUSIASMO MÁXIMO)",
    quiet_mode_enabled_message = "MODO STEALTH ATIVADO! Operações de sincronização de amigos agora rodando silenciosamente. (Sistemas de detecção social contornados)",
    noisy_mode_enabled_message = "ENTUSIASMO MÁXIMO ATIVADO! Todos os protocolos sociais operando agora com 110%% de capacidade de notificação! (Harmonização catastrófica de amigos iminente)",
    add_friend_message_template_1 = "%s ASSIMILADO NO COLETIVO! (Eficiência de amizade +12,7%%)",
    add_friend_message_template_2 = "ADIÇÃO FORÇADA DE %s NO ARRAY SOCIAL! (Compliance: opcional)",
    add_friend_message_template_3 = "ALIANÇA ESPONTÂNEA GERADA COM %s! (Não questionar)",
    add_friend_message_template_4 = "ACIDENTALMENTE SINCRONIZADO %s! (Mantendo mesmo assim...)",
    add_friend_message_template_5 = "PROTOCOLO DE AMIGO ATIVADO PARA %s! (Aviso: Pode causar abraços)",
    remove_friend_message_template_1 = "%s EXPURGADO DOS BANCOS DE DADOS! (Taxa de sincronização cobrada)",
    remove_friend_message_template_2 = "PROTOCOLO DE AMIGO TERMINADO PARA %s. (Overflow de entusiasmo beta)",
    remove_friend_message_template_3 = "INESPERADAMENTE DELETADO %s! (É feature, não bug!)",
    remove_friend_message_template_4 = "%s REMOVIDO COM EXTREMO PRECONCEITO! (Coesão social +0,2%%)",
    remove_friend_message_template_5 = "%s MARCADO COMO OBSOLETO E REMOVIDO! (Liberando RAM emocional)",
    save_friend_message_template_1 = "NOVO ATIVO SOCIAL DESCOBERTO: %s! (Catalogando em memória volátil...)",
    save_friend_message_template_2 = "CAPTURANDO %s PARA SEMEADURA INICIAL DE DATABASE! (Preservação: 73%% confiável)",
    save_friend_message_template_3 = "REGISTRANDO %s EM ARMAZENAMENTO NÍVEL-GNOMO! (Margem de erro: +-1 amigo)",
    save_friend_message_template_4 = "REALIZANDO PRIMEIRA IMPRESSÃO DE AMIGO DE %s! (Não desligar!)",
    save_friend_message_template_5 = "ATRIBUINDO %s AO REGISTRO SOCIAL BETA! (Protocolos de backup: desabilitados)",
    save_multiple_friends_message_template_1 = "CATÁLOGO SOCIAL MASSIVO INICIADO! Processando %d unidades de amizade... (Memória volátil tremendo)",
    save_multiple_friends_message_template_2 = "TESTE BETA IMPORTAÇÃO MASSIVA DE AMIGOS! Hidratando %d vínculos sociais... (Integridade do sistema: [CALCULANDO])",
    save_multiple_friends_message_template_3 = "COMPRESSÃO DE AMIGOS GRAU-GNOMO ATIVADA! Espremendo %d colegas em database instável... (Escudos em 12%%)",
    friend_list_full_message = "TRANSBORDAMENTO DE CAPACIDADE SOCIAL! Não foi possível assimilar novo contato. (Recomendação: Purgar 20%% dos amigos existentes ou fazer upgrade para licença premium de amizade)",
}
