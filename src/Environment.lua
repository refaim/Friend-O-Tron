--[[
Use the addon's private table as an isolated environment.
By using {__index = _G} metatable we're allowing all global lookups to transparently fallback to the game-wide
globals table, while the private table itself will act as a thin layer on top of the game-wide globals table,
allowing us to have our own global variables isolated from the rest of the game.

This accomplishes several goals:
1. Prevents addon-specific "globals" from leaking to game-wide global namespace _G
2. Optionally retains the ability to access these "globals" via the only exposed global variable "MissingCrafts"
3. Allows us to make overrides for WoW API global functions and variables without actually touching
   the real global namespace, making these overrides visible only to this addon.

setfenv(1, MissingCrafts) must be added to every .lua file to allow it to work within this environment,
and this Environment file must be loaded before all others
]]

local _G = getfenv(0)
FriendOTron = setmetatable({_G = _G}, {__index = _G})

setfenv(1, FriendOTron)

ADDON_NAME = "Friend-O-Tron"
ADDON_VERSION = "1.1"

IS_TURTLE_WOW = getglobal("TURTLE_WOW_VERSION") ~= nil
HAS_SUPER_WOW = SUPERWOW_VERSION ~= nil or ImportFile ~= nil and ExportFile ~= nil

---@type LocaleStrings
LOCALE_STRINGS = --[[---@type LocaleStrings]] {}

function echoMessage(message)
    DEFAULT_CHAT_FRAME:AddMessage(format("%s: %s", ADDON_NAME, message), 0.9, 0.4, 0.6)
end

---@param strings string[]
---@param glue string
---@return string
function strjoin(strings, glue)
    local result = ""
    for _, s in ipairs(strings) do
        if result == "" then
            result = s
        else
            result = result .. glue .. s
        end
    end
    return result
end
