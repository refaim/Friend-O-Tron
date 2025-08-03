setfenv(1, FriendOTron)

---@alias JobType "Add" | "Remove"

---@shape JobTypeEnum
---@field Add "Add"
---@field Remove "Remove"

---@shape Job
---@field type JobType
---@field friendName string
---@field suppressErrors boolean
---@field startedAt number|nil

---@alias LibFriendshipEventType "Added" | "AlreadyFriend" | "DatabaseError" | "UnknownError" | "ListFull" | "NotFound" | "Removed" | "CannotAddSelf" | "WrongFaction"

---@shape LibFriendshipEventTypeEnum
---@field Added "Added"
---@field AlreadyFriend "AlreadyFriend"
---@field DatabaseError "DatabaseError"
---@field UnknownError "UnknownError"
---@field ListFull "ListFull"
---@field NotFound "NotFound"
---@field Removed "Removed"
---@field CannotAddSelf "CannotAddSelf"
---@field WrongFaction "WrongFaction"

---@shape LibFriendshipEvent
---@field type LibFriendshipEventType
---@field friendName string
---@field isError boolean

---@alias LibFriendshipEventListener fun(event:LibFriendshipEvent):void

---@shape LibFriendshipEnums
---@field JobType JobTypeEnum
---@field EventType LibFriendshipEventTypeEnum

---@class LibFriendship
---@field originalAddFriend fun(name:string):void
---@field originalRemoveFriend fun(nameOrIndex:string|number):void
---@field originalChatFrameOnEvent function
---@field enums LibFriendshipEnums
LibFriendship = {
    originalAddFriend = AddFriend,
    originalRemoveFriend = RemoveFriend,
    originalChatFrameOnEvent = ChatFrame_OnEvent,
    enums = {
        JobType = {
            Add = "Add",
            Remove = "Remove",
        },
        EventType = {
            Added = "Added",
            AlreadyFriend = "AlreadyFriend",
            DatabaseError = "DatabaseError",
            UnknownError = "UnknownError",
            ListFull = "ListFull",
            NotFound = "NotFound",
            Removed = "Removed",
            CannotAddSelf = "CannotAddSelf",
            WrongFaction = "WrongFaction",
        },
    }
}

local JobType = LibFriendship.enums.JobType
local EventType = LibFriendship.enums.EventType

---@type table<LibFriendshipEventType, boolean>
local EVENT_TYPE_TO_ERROR_FLAG = {}
EVENT_TYPE_TO_ERROR_FLAG[EventType.DatabaseError] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.UnknownError] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.ListFull] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.NotFound] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.CannotAddSelf] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.WrongFaction] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.Added] = false
EVENT_TYPE_TO_ERROR_FLAG[EventType.AlreadyFriend] = true
EVENT_TYPE_TO_ERROR_FLAG[EventType.Removed] = false

---@type LibFriendshipEventListener[]
local listeners = {}

---@param friendName string
---@param eventType LibFriendshipEventType
local function sendEvent(friendName, eventType)
    for _, listener in ipairs(listeners) do
        listener({type = eventType, friendName = friendName, isError = EVENT_TYPE_TO_ERROR_FLAG[eventType]})
    end
end

---@type Job[]
local queue = {}
---@type Job[]
local jobsInProgress = {}

local function onUpdate()
    ---@type number[]
    local jobIndexesToRemove = {}
    for jobIndex, job in ipairs(jobsInProgress) do
        if time() - job.startedAt >= 3 then
            local isFriend = LibFriendship:IsFriend(job.friendName)
            if job.type == JobType.Add then
                sendEvent(job.friendName, isFriend and EventType.Added or EventType.UnknownError)
            elseif job.type == JobType.Remove then
                sendEvent(job.friendName, isFriend == false and EventType.Removed or EventType.UnknownError)
            end
            tinsert(jobIndexesToRemove, 0, jobIndex)
        end
    end
    for _, jobIndex in ipairs(jobIndexesToRemove) do
        tremove(jobsInProgress, jobIndex)
    end

    if next(queue) == nil or next(jobsInProgress) ~= nil then
        return
    end

    local job = tremove(queue, 1)
    tinsert(jobsInProgress, job)
    job.startedAt = time()
    if job.type == JobType.Add then
        LibFriendship.originalAddFriend(job.friendName)
    elseif job.type == JobType.Remove then
        LibFriendship.originalRemoveFriend(job.friendName)
    end
end

local timerFrame = CreateFrame("Frame")
timerFrame:SetScript("OnUpdate", onUpdate)

---@param playerName string
---@field suppressErrors boolean
function LibFriendship:AddFriend(playerName, suppressErrors)
    ---@type Job
    local job = {type = JobType.Add, friendName = playerName, suppressErrors = suppressErrors, startedAt = nil}
    tinsert(queue, job)
end

---@param playerName string
---@param suppressErrors boolean
function LibFriendship:RemoveFriend(playerName, suppressErrors)
    ---@type Job
    local job = {type = JobType.Remove, friendName = playerName, suppressErrors = suppressErrors, startedAt = nil}
    tinsert(queue, job)
end

---@param index number
---@return string|nil
function LibFriendship:GetFriend(index)
    local name, _, _, _, _, _ = GetFriendInfo(index)
    if name == UNKNOWN then
        name = nil
    end
    return name
end

---@param playerName string
---@return boolean|nil
function LibFriendship:IsFriend(playerName)
    local foundNil = false
    for i = 1, GetNumFriends() do
        local friendName = self:GetFriend(i)
        if friendName == nil then
            foundNil = true
        end
        if friendName == playerName then
            return true
        end
    end
    if foundNil then
        return nil
    end
    return false
end

---@param callback LibFriendshipEventListener
function LibFriendship:RegisterEvents(callback)
    for _, listener in ipairs(listeners) do
        if listener == callback then
            return
        end
    end
    tinsert(listeners, callback)
end

---@param callback LibFriendshipEventListener
function LibFriendship:UnregisterEvents(callback)
    local index
    for i, listener in ipairs(listeners) do
        if listener == callback then
            index = i
            break
        end
    end
    if index ~= nil then
        tremove(listeners, index)
    end
end

---@type table<string, LibFriendshipEventType>
local GENERIC_MESSAGE_TO_EVENT_TYPE = {}
GENERIC_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_DB_ERROR] = EventType.DatabaseError
GENERIC_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_ERROR] = EventType.UnknownError
GENERIC_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_LIST_FULL] = EventType.ListFull
GENERIC_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_NOT_FOUND] = EventType.NotFound
GENERIC_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_SELF] = EventType.CannotAddSelf
GENERIC_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_WRONG_FACTION] = EventType.WrongFaction

---@type table<string, LibFriendshipEventType>
local TEMPLATE_MESSAGE_TO_EVENT_TYPE = {}
TEMPLATE_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_ADDED_S] = EventType.Added
TEMPLATE_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_ALREADY_S] = EventType.AlreadyFriend
TEMPLATE_MESSAGE_TO_EVENT_TYPE[ERR_FRIEND_REMOVED_S] = EventType.Removed

---@param text string
---@return boolean
local function onSystemMessage(text)
    if next(jobsInProgress) == nil then
        return false
    end

    ---@type number
    local jobIndex

    ---@type LibFriendshipEventType
    local eventType = GENERIC_MESSAGE_TO_EVENT_TYPE[text]
    if eventType ~= nil then
        jobIndex = 1
    else
        for i, job in ipairs(jobsInProgress) do
            for template, candidateEventType in pairs(TEMPLATE_MESSAGE_TO_EVENT_TYPE) do
                if text == format(template, job.friendName) then
                    eventType = candidateEventType
                    jobIndex = i
                end
            end
        end
    end

    if eventType == nil or jobIndex == nil then
        return false
    end

    local job = tremove(jobsInProgress, jobIndex)
    sendEvent(job.friendName, eventType)
    return job.suppressErrors and EVENT_TYPE_TO_ERROR_FLAG[eventType]
end

setglobal("ChatFrame_OnEvent", function(chatEvent)
    local suppressMessage = false
    if chatEvent == "CHAT_MSG_SYSTEM" then
        suppressMessage = onSystemMessage(arg1)
    end
    if not suppressMessage then
        LibFriendship.originalChatFrameOnEvent(chatEvent)
    end
end)

setglobal("AddFriend", function(name)
    if type(name) == "string" then
        tinsert(jobsInProgress, {type = JobType.Add, friendName = --[[---@type string]] name, suppressErrors = false, startedAt = time()})
    end
    LibFriendship.originalAddFriend(name)
end)

setglobal("RemoveFriend", function (nameOrIndex)
    local name
    if type(nameOrIndex) == "string" then
        name = nameOrIndex
    elseif type(nameOrIndex) == "number" then
        name = LibFriendship:GetFriend(nameOrIndex)
    end
    if type(name) == "string" then
        tinsert(jobsInProgress, {type = JobType.Remove, friendName = --[[---@type string]] name, suppressErrors = false, startedAt = time()})
    end
    LibFriendship.originalRemoveFriend(nameOrIndex)
end)
