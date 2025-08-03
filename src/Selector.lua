setfenv(1, FriendOTron)

---@alias MessagePoolId "add-friend" | "remove-friend" | "save-friend" | "save-multiple-friends"

---@class MessageSelector
---@field previousMessages table<MessagePoolId, string>
---@field poolsById table<MessagePoolId, string[]>
MessageSelector = {}

---@return self
function MessageSelector:Construct()
    self.previousMessages = {}
    self.poolsById = {
        ["add-friend"] = {
            LOCALE_STRINGS.add_friend_message_template_1,
            LOCALE_STRINGS.add_friend_message_template_2,
            LOCALE_STRINGS.add_friend_message_template_3,
            LOCALE_STRINGS.add_friend_message_template_4,
            LOCALE_STRINGS.add_friend_message_template_5,
        },
        ["remove-friend"] = {
            LOCALE_STRINGS.remove_friend_message_template_1,
            LOCALE_STRINGS.remove_friend_message_template_2,
            LOCALE_STRINGS.remove_friend_message_template_3,
            LOCALE_STRINGS.remove_friend_message_template_4,
            LOCALE_STRINGS.remove_friend_message_template_5,
        },
        ["save-friend"] = {
            LOCALE_STRINGS.save_friend_message_template_1,
            LOCALE_STRINGS.save_friend_message_template_2,
            LOCALE_STRINGS.save_friend_message_template_3,
            LOCALE_STRINGS.save_friend_message_template_4,
            LOCALE_STRINGS.save_friend_message_template_5,
        },
        ["save-multiple-friends"] = {
            LOCALE_STRINGS.save_multiple_friends_message_template_1,
            LOCALE_STRINGS.save_multiple_friends_message_template_2,
            LOCALE_STRINGS.save_multiple_friends_message_template_3,
        },
    }
    return self
end

---@param poolId MessagePoolId
---@return string
function MessageSelector:Select(poolId)
    local sequence = self.poolsById[poolId]
    local previous = self.previousMessages[poolId]

    local result
    repeat
        result = sequence[random(1, getn(sequence))]
    until result ~= previous

    self.previousMessages[poolId] = result

    return result
end
