setfenv(1, FriendOTron)

---@shape Settings
---@field noisy boolean

---@type Settings
local settings

---@type Database
local db
local messageSelector = MessageSelector:Construct()

---@type table<string, true>
local friendsToSync = {}

local function syncFriends()
    local dbFriendshipStatusByName = db:LoadFriends()

    ---@type table<string, true>
    local gameFriendsSet = {}
    ---@type table<string, true>
    local friendsToSave = {}
    local friendsToSaveCount = 0
    ---@type table<string, true>
    local friendsToRemove = {}
    for i = 1, GetNumFriends() do
        local nameOrNil = LibFriendship:GetFriend(i)
        if nameOrNil ~= nil then
            local name = --[[---@type string]] nameOrNil
            if dbFriendshipStatusByName[name] == nil then
                friendsToSave[name] = true
                friendsToSaveCount = friendsToSaveCount + 1
            elseif dbFriendshipStatusByName[name] == false then
                friendsToRemove[name] = true
            end
            gameFriendsSet[name] = true
        end
    end

    if settings.noisy then
        if friendsToSaveCount > 2 then
            echoMessage(format(messageSelector:Select("save-multiple-friends"), friendsToSaveCount))
        else
            for friendName, _ in pairs(friendsToSave) do
                echoMessage(format(messageSelector:Select("save-friend"), friendName))
            end
        end
    end
    for friendName, _ in pairs(friendsToSave) do
        db:AddEvent("add", friendName)
    end

    for friendName, _ in pairs(friendsToRemove) do
        friendsToSync[friendName] = true
        LibFriendship:RemoveFriend(friendName, true)
    end

    local playerName, _ = UnitName("player")
    for otherPlayerName, isFriendInDatabase in pairs(dbFriendshipStatusByName) do
        if isFriendInDatabase and gameFriendsSet[otherPlayerName] == nil and otherPlayerName ~= playerName then
            friendsToSync[otherPlayerName] = true
            LibFriendship:AddFriend(otherPlayerName, true)
        end
    end
end

local EventType = LibFriendship.enums.EventType
local wasListFullWarningEmitted = false

LibFriendship:RegisterEvents(function(event)
    local wasRequestedByFriendOTron = friendsToSync[event.friendName] == true
    friendsToSync[event.friendName] = nil

    if event.type == EventType.Added then
        if wasRequestedByFriendOTron then
            if settings.noisy then
                echoMessage(format(messageSelector:Select("add-friend"), event.friendName))
            end
        else
            db:AddEvent("add", event.friendName)
        end
    elseif event.type == EventType.Removed then
        if wasRequestedByFriendOTron then
            if settings.noisy then
                echoMessage(format(messageSelector:Select("remove-friend"), event.friendName))
            end
        else
            db:AddEvent("remove", event.friendName)
        end
    elseif event.type == EventType.ListFull and not wasListFullWarningEmitted then
        wasListFullWarningEmitted = true
        echoMessage(LOCALE_STRINGS.friend_list_full_message)
    end
end)

local function loadSavedSettings()
    local varName = "FriendOTronSettings"
    ---@type Settings
    local var = getglobal(varName)
    if var == nil then
        var = {noisy = true}
        setglobal(varName, var)
    end
    settings = var
end

local function setupSlashCommands()
    SlashCmdList["FRIENDOTRON"] = function(text)
        if text == "help" then
            echoMessage(LOCALE_STRINGS.addon_help_message)
        elseif text == "quiet" then
            settings.noisy = false
            echoMessage(LOCALE_STRINGS.quiet_mode_enabled_message)
        elseif text == "noisy" then
            settings.noisy = true
            echoMessage(LOCALE_STRINGS.noisy_mode_enabled_message)
        end
    end
    setglobal("SLASH_FRIENDOTRON1", "/fot")
end

local eventFrame = CreateFrame("Frame", "FriendOTronEventFrame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("FRIENDLIST_UPDATE")
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
eventFrame:SetScript("OnEvent", function ()
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        eventFrame:UnregisterEvent("ADDON_LOADED")
        db = Database:Construct()
        loadSavedSettings()
        setupSlashCommands()
    elseif event == "FRIENDLIST_UPDATE" and db ~= nil then
        eventFrame:UnregisterEvent("FRIENDLIST_UPDATE")
        if settings.noisy then
            echoMessage(LOCALE_STRINGS.addon_loaded_message)
        end
        syncFriends()
    elseif event == "PLAYER_LEAVING_WORLD" and db ~= nil then
        eventFrame:UnregisterEvent("PLAYER_LEAVING_WORLD")
        db:SaveFriends()
    end
end)
