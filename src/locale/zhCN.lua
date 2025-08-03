setfenv(1, FriendOTron)

if GetLocale() ~= "zhCN" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    add_friend_message_template_1 = "将%s同化至集体！（友情效率+12.7%%）",
    add_friend_message_template_2 = "强制将%s添加到社交数组！（遵守：可选）",
    add_friend_message_template_3 = "与%s自发生成联盟！（勿质疑）",
    add_friend_message_template_4 = "意外同步了%s！（无论如何保留...）",
    add_friend_message_template_5 = "为%s激活朋友协议！（警告：可能导致拥抱）",
    remove_friend_message_template_1 = "从数据库中清除%s！（同步税已收取）",
    remove_friend_message_template_2 = "为%s终止朋友协议。（测试版热情溢出）",
    remove_friend_message_template_3 = "意外删除%s！（这是功能，不是错误！）",
    remove_friend_message_template_4 = "以极端偏见移除%s！（社会凝聚力+0.2%%）",
    remove_friend_message_template_5 = "将%s标记为过时并移除！（释放情感内存）",
    save_friend_message_template_1 = "发现新社交资产：%s！（在易失性内存中编目...）",
    save_friend_message_template_2 = "捕获%s用于初始数据库播种！（保存：73%%可靠）",
    save_friend_message_template_3 = "在低地精级存储中注册%s！（误差范围：+-1朋友）",
    save_friend_message_template_4 = "执行%s的首次朋友印记！（勿关机！）",
    save_friend_message_template_5 = "将%s分配至测试版社交注册表！（备份协议：已禁用）",
    save_multiple_friends_message_template_1 = "启动大量社交目录！处理%d个友情单位...（易失性内存颤抖）",
    save_multiple_friends_message_template_2 = "测试版朋友批量导入！水合%d个社交纽带...（系统完整性：【计算中】）",
    save_multiple_friends_message_template_3 = "低地精级朋友压缩已启动！将%d个伙伴压入不稳定数据库...（护盾12%%）",
}
