setfenv(1, FriendOTron)

if GetLocale() ~= "frFR" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    add_friend_message_template_1 = "%s ASSIMILÉ DANS LE COLLECTIF ! (Efficacité d'amitié +12,7%%)",
    add_friend_message_template_2 = "AJOUT FORCÉ DE %s DANS L'ARRAY SOCIAL ! (Compliance : optionnelle)",
    add_friend_message_template_3 = "ALLIANCE SPONTANÉE GÉNÉRÉE AVEC %s ! (Ne pas questionner)",
    add_friend_message_template_4 = "ACCIDENTELLEMENT SYNCHRONISÉ %s ! (Le garder quand même...)",
    add_friend_message_template_5 = "PROTOCOLE D'AMI ACTIVÉ POUR %s ! (Attention : Peut causer des câlins)",
    remove_friend_message_template_1 = "%s PURGÉ DES BANQUES DE DONNÉES ! (Taxe de synchronisation perçue)",
    remove_friend_message_template_2 = "PROTOCOLE D'AMI TERMINÉ POUR %s. (Débordement d'enthousiasme bêta)",
    remove_friend_message_template_3 = "SUPPRESSION INATTENDUE DE %s ! (Fonctionnalité, pas bug !)",
    remove_friend_message_template_4 = "%s EXCISÉ AVEC EXTRÊME PRÉJUGÉ ! (Cohésion sociale +0,2%%)",
    remove_friend_message_template_5 = "%s MARQUÉ COMME OBSOLÈTE ET SUPPRIMÉ ! (Libérant la RAM émotionnelle)",
    save_friend_message_template_1 = "NOUVEL ACTIF SOCIAL DÉCOUVERT : %s ! (Catalogage en mémoire volatile...)",
    save_friend_message_template_2 = "CAPTURE DE %s POUR ENSEMENCEMENT INITIAL DE BASE ! (Préservation : 73%% fiable)",
    save_friend_message_template_3 = "ENREGISTREMENT DE %s EN STOCKAGE NIVEAU-GNOME ! (Marge d'erreur : +-1 ami)",
    save_friend_message_template_4 = "EMPREINTE D'AMI PREMIÈRE FOIS DE %s ! (Ne pas éteindre !)",
    save_friend_message_template_5 = "ASSIGNATION DE %s AU REGISTRE SOCIAL BÊTA ! (Protocoles de sauvegarde : désactivés)",
    save_multiple_friends_message_template_1 = "CATALOGUE SOCIAL MASSIF INITIÉ ! Traitement de %d unités d'amitié... (Mémoire volatile tremblante)",
    save_multiple_friends_message_template_2 = "TEST BÊTA IMPORT MASSIF D'AMIS ! Hydratation de %d liens sociaux... (Intégrité système : [CALCUL EN COURS])",
    save_multiple_friends_message_template_3 = "COMPRESSION D'AMIS GRADE-GNOME ENGAGÉE ! Compression de %d copains en base instable... (Boucliers à 12%%)",
    friend_list_full_message = "DÉBORDEMENT DE CAPACITÉ SOCIALE ! Impossible d'assimiler nouveau contact. (Recommandation : Purger 20%% des amis existants ou upgrader vers licence d'amitié premium)",
}
