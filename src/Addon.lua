setfenv(1, FriendOTron)

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

    if friendsToSaveCount > 2 then
        echoMessage(format(messageSelector:Select("save-multiple-friends"), friendsToSaveCount))
    else
        for friendName, _ in pairs(friendsToSave) do
            echoMessage(format(messageSelector:Select("save-friend"), friendName))
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

LibFriendship:RegisterEvents(function(event)
    local wasRequestedByFriendOTron = friendsToSync[event.friendName] == true
    friendsToSync[event.friendName] = nil

    if event.type == LibFriendship.enums.EventType.Added then
        if wasRequestedByFriendOTron then
            echoMessage(format(messageSelector:Select("add-friend"), event.friendName))
        else
            db:AddEvent("add", event.friendName)
        end
    elseif event.type == LibFriendship.enums.EventType.Removed then
        if wasRequestedByFriendOTron then
            echoMessage(format(messageSelector:Select("remove-friend"), event.friendName))
        else
            db:AddEvent("remove", event.friendName)
        end
    end
end)

local eventFrame = CreateFrame("Frame", "FriendOTronEventFrame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("FRIENDLIST_UPDATE")
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
eventFrame:SetScript("OnEvent", function ()
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        eventFrame:UnregisterEvent("ADDON_LOADED")
        db = Database:Construct()
    elseif event == "FRIENDLIST_UPDATE" and db ~= nil then
        eventFrame:UnregisterEvent("FRIENDLIST_UPDATE")
        syncFriends()
    elseif event == "PLAYER_LEAVING_WORLD" and db ~= nil then
        eventFrame:UnregisterEvent("PLAYER_LEAVING_WORLD")
        db:SaveFriends()
    end
end)
