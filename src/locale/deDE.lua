setfenv(1, FriendOTron)

if GetLocale() ~= "deDE" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    add_friend_message_template_1 = "%s IN DAS KOLLEKTIV ASSIMILIERT! (Freundschaftseffizienz +12,7%%)",
    add_friend_message_template_2 = "ZWANGSAUFNAHME VON %s IN SOZIALES ARRAY! (Compliance: optional)",
    add_friend_message_template_3 = "SPONTANE ALLIANZ MIT %s GENERIERT! (Nicht hinterfragen)",
    add_friend_message_template_4 = "VERSEHENTLICH %s SYNCHRONISIERT! (Behalten trotzdem...)",
    add_friend_message_template_5 = "FREUND-PROTOKOLL FÜR %s AKTIVIERT! (Warnung: Kann zu Umarmungen führen)",
    remove_friend_message_template_1 = "%s AUS DATENBANKEN GELÖSCHT! (Synchronisationssteuer kassiert)",
    remove_friend_message_template_2 = "FREUND-PROTOKOLL FÜR %s BEENDET. (Beta-Enthusiasmus-Überlauf)",
    remove_friend_message_template_3 = "UNERWARTET %s GELÖSCHT! (Feature, kein Bug!)",
    remove_friend_message_template_4 = "%s MIT EXTREMEM VORURTEIL ENTFERNT! (Soziale Kohäsion +0,2%%)",
    remove_friend_message_template_5 = "%s ALS VERALTET MARKIERT UND ENTFERNT! (RAM-Speicher befreit)",
    save_friend_message_template_1 = "NEUES SOZIALES ASSET ENTDECKT: %s! (Katalogisierung in flüchtigem Speicher...)",
    save_friend_message_template_2 = "ERFASSE %s FÜR INITIALE DATENBANK-SAAT! (Erhaltung: 73%% zuverlässig)",
    save_friend_message_template_3 = "REGISTRIERE %s IN GNOMISCHEN SPEICHER! (Fehlertoleranz: +-1 Freund)",
    save_friend_message_template_4 = "ERSTMALIGE FREUND-PRÄGUNG VON %s! (Nicht ausschalten!)",
    save_friend_message_template_5 = "WEISE %s ZU BETA-SOZIALREGISTER ZU! (Backup-Protokolle: deaktiviert)",
    save_multiple_friends_message_template_1 = "MASSEN-SOZIALKATALOG INITIIERT! Verarbeite %d Freundschaftseinheiten... (Flüchtiger Speicher zittert)",
    save_multiple_friends_message_template_2 = "BETA-TEST FREUND-MASSENIMPORT! Hydratisiere %d soziale Bindungen... (Systemintegrität: [BERECHNET])",
    save_multiple_friends_message_template_3 = "GNOMISCHE FREUND-KOMPRESSION AKTIVIERT! Presse %d Kumpels in instabile Datenbank... (Schilde bei 12%%)",
}
