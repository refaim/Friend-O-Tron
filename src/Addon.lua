setfenv(1, FriendOTron)

-- TODO superwow

---@type Database
local db
local messageSelector = MessageSelector:Construct()

local function syncFriends()
    local dbFriendshipStatusByName = db:LoadFriends()

    ---@type table<string, true>
    local gameFriendsSet = {}
    ---@type table<string, true>
    local friendsToSave = {}
    ---@type table<string, true>
    local friendsToRemove = {}
    for i = 1, GetNumFriends() do
        local nameOrNil = LibFriendship:GetFriend(i)
        if nameOrNil ~= nil then
            local name = --[[---@type string]] nameOrNil
            if dbFriendshipStatusByName[name] == nil then
                friendsToSave[name] = true
            elseif dbFriendshipStatusByName[name] == false then
                friendsToRemove[name] = true
            end
            gameFriendsSet[name] = true
        end
    end

    if getn(friendsToSave) > 2 then
        echoMessage(format(messageSelector:Select("save-multiple-friends"), getn(friendsToSave)))
    else
        for friendName, _ in pairs(friendsToSave) do
            echoMessage(format(messageSelector:Select("save-friend"), friendName))
        end
    end
    for friendName, _ in pairs(friendsToSave) do
        db:AddEvent("add", friendName)
    end

    for friendName, _ in pairs(friendsToRemove) do
        LibFriendship:RemoveFriend(friendName, true)
    end

    local playerName, _ = UnitName("player")
    for otherPlayerName, isFriendInDatabase in pairs(dbFriendshipStatusByName) do
        if isFriendInDatabase and gameFriendsSet[otherPlayerName] == nil and otherPlayerName ~= playerName then
            LibFriendship:AddFriend(otherPlayerName, true)
        end
    end
end

LibFriendship:RegisterEvents(function(event)
    -- TODO handle other types of events
    if event.type == LibFriendship.enums.EventType.Added then
        db:AddEvent("add", event.friendName)
        echoMessage(format(messageSelector:Select("add-friend"), event.friendName))
    elseif event.type == LibFriendship.enums.EventType.Removed then
        db:AddEvent("remove", event.friendName)
        echoMessage(format(messageSelector:Select("remove-friend"), event.friendName))
    end
end)

local eventFrame = CreateFrame("Frame", "FriendOTronEventFrame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("FRIENDLIST_UPDATE")
eventFrame:SetScript("OnEvent", function ()
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        eventFrame:UnregisterEvent("ADDON_LOADED")
        db = Database:Construct()
    elseif event == "FRIENDLIST_UPDATE" and db ~= nil then
        eventFrame:UnregisterEvent("FRIENDLIST_UPDATE")
        syncFriends()
    end
end)
