setfenv(1, FriendOTron)

---@alias FriendEventType "add" | "remove"

---@shape FriendEvent
---@field player string
---@field friend string
---@field type FriendEventType
---@field time number

---@shape FriendOTronSavedVariable
---@field realmToEvents table<string, FriendEvent[]>

local FILE_NAME = "Friend-O-Tron"

---@class Database
---@field _savedVar FriendOTronSavedVariable
Database = {}

---@return self
function Database:Construct()
    self._savedVar = self:_LoadSavedVariable()
    self:_LoadEventsFromFile()
    self:_CompressEvents()
    return self
end

---@return FriendOTronSavedVariable
function Database:_LoadSavedVariable()
    local varName = "FriendOTronDatabase"
    ---@type FriendOTronSavedVariable
    local var = getglobal(varName)
    if var == nil then
        var = {realmToEvents = {}}
        var.realmToEvents[GetRealmName()] = {}
        setglobal(varName, var)
    end
    return var
end

function Database:_LoadEventsFromFile()
    if not HAS_SUPER_WOW then
        return
    end

    local text = ImportFile(FILE_NAME) or ""
    for realm, player, friend, eventType, eventTime in string.gfind(text, "realm=([^;]+);player=([^;]+);friend=([^;]+);type=(%l+);time=(%d+)") do
        eventTime = tonumber(eventTime or 0)
        if type(realm) == "string" and type(player) == "string" and type(friend) == "string" and (eventType == "add" or eventType == "remove") and eventTime > 0 then
            local safeRealm = --[[---@type string]] realm
            if self._savedVar.realmToEvents[safeRealm] == nil then
                self._savedVar.realmToEvents[safeRealm] = {}
            end
            tinsert(self._savedVar.realmToEvents[safeRealm], {
                player = --[[---@type string]] player,
                friend = --[[---@type string]] friend,
                type = --[[---@type FriendEventType]] eventType,
                time = --[[---@type number]] eventTime,
            })
        end
    end
end

function Database:_SaveEventsToFile()
    if not HAS_SUPER_WOW then
        return
    end

    self:_CompressEvents()

    local strings = {}
    for realm, events in pairs(self._savedVar.realmToEvents) do
        for _, event in ipairs(events) do
            tinsert(strings, format("realm=%s;player=%s;friend=%s;type=%s;time=%d", realm, event.player, event.friend, event.type, event.time))
        end
    end
    ExportFile(FILE_NAME, strjoin(strings, "\n"))
end

---@param a FriendEvent
---@param b FriendEvent
---@return boolean
local function compareEvents(a, b)
    if a.time ~= b.time then
        return a.time < b.time
    end
    if a.player ~= b.player then
        return a.player < b.player
    end
    if a.friend ~= b.friend then
        return a.friend < b.friend
    end
    return a.type < b.type
end

function Database:_CompressEvents()
    ---@type table<string, FriendEvent[]>
    local newRealmToEvents = {}
    for realm, events in pairs(self._savedVar.realmToEvents) do
        ---@type table<string, FriendEvent>
        local friendToEvent = {}

        table.sort(events, compareEvents)
        for _, event in ipairs(events) do
            friendToEvent[event.friend] = event
        end

        ---@type FriendEvent[]
        local newEvents = {}
        for _, event in pairs(friendToEvent) do
            tinsert(newEvents, event)
        end

        table.sort(newEvents, compareEvents)
        newRealmToEvents[realm] = newEvents
    end
    self._savedVar.realmToEvents = newRealmToEvents
end

---@return table<string, boolean>
function Database:LoadFriends()
    ---@type table<string, boolean>
    local set = {}
    for _, event in ipairs(self._savedVar.realmToEvents[GetRealmName()]) do
        if event.type == "add" then
            set[event.friend] = true
        elseif event.type == "remove" then
            set[event.friend] = false
        end
    end
    return set
end

function Database:SaveFriends()
    self:_SaveEventsToFile()
end

---@param type FriendEventType
---@param friend string
function Database:AddEvent(type, friend)
    local playerName, _ = UnitName("player")
    tinsert(self._savedVar.realmToEvents[GetRealmName()], {
        player = playerName,
        friend = friend,
        type = type,
        time = time(),
    })
end
