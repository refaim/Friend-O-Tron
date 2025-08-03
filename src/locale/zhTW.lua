setfenv(1, FriendOTron)

if GetLocale() ~= "zhTW" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    add_friend_message_template_1 = "將%s同化至集體！（友情效率+12.7%%）",
    add_friend_message_template_2 = "強制將%s加入社交陣列！（遵守：可選）",
    add_friend_message_template_3 = "與%s自發產生聯盟！（勿質疑）",
    add_friend_message_template_4 = "意外同步了%s！（無論如何保留...）",
    add_friend_message_template_5 = "為%s啟動朋友協定！（警告：可能導致擁抱）",
    remove_friend_message_template_1 = "從資料庫中清除%s！（同步稅已收取）",
    remove_friend_message_template_2 = "為%s終止朋友協定。（測試版熱情溢出）",
    remove_friend_message_template_3 = "意外刪除%s！（這是功能，不是錯誤！）",
    remove_friend_message_template_4 = "以極端偏見移除%s！（社會凝聚力+0.2%%）",
    remove_friend_message_template_5 = "將%s標記為過時並移除！（釋放情感記憶體）",
    save_friend_message_template_1 = "發現新社交資產：%s！（在易失性記憶體中編目...）",
    save_friend_message_template_2 = "捕獲%s用於初始資料庫播種！（保存：73%%可靠）",
    save_friend_message_template_3 = "在地精級儲存中註冊%s！（誤差範圍：+-1朋友）",
    save_friend_message_template_4 = "執行%s的首次朋友印記！（勿關機！）",
    save_friend_message_template_5 = "將%s分配至測試版社交註冊表！（備份協定：已禁用）",
    save_multiple_friends_message_template_1 = "啟動大量社交目錄！處理%d個友情單位...（易失性記憶體颤抖）",
    save_multiple_friends_message_template_2 = "測試版朋友批量導入！水合%d個社交結合...（系統完整性：【計算中】）",
    save_multiple_friends_message_template_3 = "地精級朋友壓縮已啟動！將%d個夥伴擠入不穩定資料庫...（護盾12%%）",
}
