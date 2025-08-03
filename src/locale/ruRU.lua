setfenv(1, FriendOTron)

if GetLocale() ~= "ruRU" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    add_friend_message_template_1 = "%s АССИМИЛИРОВАН В КОЛЛЕКТИВ! (Эффективность дружбы +12,7%%)",
    add_friend_message_template_2 = "ПРИНУДИТЕЛЬНО ДОБАВИЛ %s В СОЦИАЛЬНЫЙ МАССИВ! (Соответствие: опционально)",
    add_friend_message_template_3 = "СПОНТАННО СГЕНЕРИРОВАН АЛЬЯНС С %s! (Не сомневаться)",
    add_friend_message_template_4 = "СЛУЧАЙНО СИНХРОНИЗИРОВАЛ %s! (Оставляю в любом случае...)",
    add_friend_message_template_5 = "ПРОТОКОЛ ДРУЖБЫ АКТИВИРОВАН ДЛЯ %s! (Предупреждение: Может вызвать объятия)",
    remove_friend_message_template_1 = "%s ОЧИЩЕН ИЗ БАНКОВ ДАННЫХ! (Налог синхронизации взыскан)",
    remove_friend_message_template_2 = "ПРОТОКОЛ ДРУЖБЫ ЗАВЕРШЕН ДЛЯ %s. (Переполнение бета-энтузиазма)",
    remove_friend_message_template_3 = "НЕОЖИДАННО УДАЛЕН %s! (Это фича, не баг!)",
    remove_friend_message_template_4 = "%s ИЗЪЯТ С КРАЙНИМ ПРЕДРАССУДКОМ! (Социальная сплоченность +0,2%%)",
    remove_friend_message_template_5 = "%s ПОМЕЧЕН КАК УСТАРЕВШИЙ И УДАЛЕН! (Освобождение эмоциональной ОЗУ)",
    save_friend_message_template_1 = "ОБНАРУЖЕН НОВЫЙ СОЦИАЛЬНЫЙ АКТИВ: %s! (Каталогизация в летучей памяти...)",
    save_friend_message_template_2 = "ЗАХВАТЫВАЮ %s ДЛЯ ПЕРВИЧНОЙ ЗАСЕВКИ БАЗЫ! (Сохранность: 73%% надежно)",
    save_friend_message_template_3 = "РЕГИСТРИРУЮ %s В ГНОМСКОМ ХРАНИЛИЩЕ! (Погрешность: +-1 друг)",
    save_friend_message_template_4 = "ВЫПОЛНЯЮ ПЕРВИЧНЫЙ ОТПЕЧАТОК ДРУГА %s! (Не выключать!)",
    save_friend_message_template_5 = "НАЗНАЧАЮ %s В БЕТА СОЦИАЛЬНЫЙ РЕЕСТР! (Протоколы резерва: отключены)",
    save_multiple_friends_message_template_1 = "ИНИЦИИРОВАН МАССОВЫЙ СОЦИАЛЬНЫЙ КАТАЛОГ! Обрабатываю %d единиц дружбы... (Летучая память дрожит)",
    save_multiple_friends_message_template_2 = "БЕТА-ТЕСТ МАССОВОГО ИМПОРТА ДРУЗЕЙ! Гидратирую %d социальных связей... (Целостность системы: [ВЫЧИСЛЯЕТСЯ])",
    save_multiple_friends_message_template_3 = "АКТИВИРОВАНА ГНОМСКАЯ КОМПРЕССИЯ ДРУЗЕЙ! Сжимаю %d приятелей в нестабильную базу... (Щиты на 12%%)",
}
