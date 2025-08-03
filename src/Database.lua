setfenv(1, FriendOTron)

---@alias FriendEventType "add" | "remove"

---@shape FriendEvent
---@field player string
---@field friend string
---@field type FriendEventType
---@field time number

---@shape FriendOTronSavedVariable
---@field realmToEvents table<string, FriendEvent[]>

---@class Database
---@field savedVar FriendOTronSavedVariable
Database = {}

---@return self
function Database:Construct()
    ---@type FriendOTronSavedVariable
    local var = getglobal("FriendOTronDatabase")
    if var == nil then
        var = {realmToEvents = {}}
        var.realmToEvents[GetRealmName()] = {}
        setglobal("FriendOTronDatabase", var)
    end
    self.savedVar = var
    self:Compress()
    return self
end

---@return table<string, boolean>
function Database:LoadFriends()
    ---@type table<string, boolean>
    local set = {}
    for _, event in ipairs(self.savedVar.realmToEvents[GetRealmName()] or {}) do
        if event.type == "add" then
            set[event.friend] = true
        elseif event.type == "remove" then
            set[event.friend] = false
        end
    end
    return set
end

function Database:Compress()
    local dbFriendshipStatusByName = self:LoadFriends()
    self.savedVar.realmToEvents[GetRealmName()] = {}
    for otherPlayerName, isFriendInDatabase in pairs(dbFriendshipStatusByName) do
        self:AddEvent(isFriendInDatabase and "add" or "remove", otherPlayerName)
    end

end

---@param type FriendEventType
---@param friend string
function Database:AddEvent(type, friend)
    local playerName, _ = UnitName("player")
    tinsert(self.savedVar.realmToEvents[GetRealmName()], {
        player = playerName,
        friend = friend,
        type = type,
        time = time(),
    })
end
