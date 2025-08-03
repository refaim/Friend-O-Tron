setfenv(1, FriendOTron)

if GetLocale() ~= "esES" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    add_friend_message_template_1 = "¡%s ASIMILADO AL COLECTIVO! (Eficiencia de amistad +12,7%%)",
    add_friend_message_template_2 = "¡%s AÑADIDO A FUERZA AL ARRAY SOCIAL! (Cumplimiento: opcional)",
    add_friend_message_template_3 = "¡ALIANZA ESPONTÁNEA GENERADA CON %s! (No cuestionar)",
    add_friend_message_template_4 = "¡ACCIDENTALMENTE SINCRONIZADO %s! (Conservando de todos modos...)",
    add_friend_message_template_5 = "¡PROTOCOLO DE AMISTAD ACTIVADO PARA %s! (Advertencia: Puede causar abrazos)",
    remove_friend_message_template_1 = "¡%s PURGADO DE BANCOS DE DATOS! (Impuesto de sincronización cobrado)",
    remove_friend_message_template_2 = "PROTOCOLO DE AMISTAD TERMINADO PARA %s. (Desbordamiento de entusiasmo beta)",
    remove_friend_message_template_3 = "¡INESPERADAMENTE ELIMINADO %s! (¡Es característica, no bug!)",
    remove_friend_message_template_4 = "¡%s REMOVIDO CON EXTREMO PREJUICIO! (Cohesión social +0,2%%)",
    remove_friend_message_template_5 = "¡%s MARCADO COMO OBSOLETO Y ELIMINADO! (Liberando RAM emocional)",
    save_friend_message_template_1 = "¡NUEVO ACTIVO SOCIAL DESCUBIERTO: %s! (Catalogando en memoria volátil...)",
    save_friend_message_template_2 = "¡CAPTURANDO %s PARA SIEMBRA INICIAL DE BASE DE DATOS! (Preservación: 73%% confiable)",
    save_friend_message_template_3 = "¡REGISTRANDO %s EN ALMACENAMIENTO NIVEL GNOMO! (Margen de error: +-1 amigo)",
    save_friend_message_template_4 = "¡REALIZANDO IMPRONTA INICIAL DE AMIGO DE %s! (¡No apagar!)",
    save_friend_message_template_5 = "¡ASIGNANDO %s AL REGISTRO SOCIAL BETA! (Protocolos de respaldo: deshabilitados)",
    save_multiple_friends_message_template_1 = "¡INICIANDO CATÁLOGO SOCIAL MASIVO! Procesando %d unidades de amistad... (Memoria volátil temblando)",
    save_multiple_friends_message_template_2 = "¡PRUEBA BETA IMPORTACIÓN MASIVA DE AMIGOS! Hidratando %d vínculos sociales... (Integridad del sistema: [CALCULANDO])",
    save_multiple_friends_message_template_3 = "¡COMPRESIÓN DE AMIGOS GRADO GNOMO ACTIVADA! Exprimiendo %d colegas en base de datos inestable... (Escudos al 12%%)",
}
