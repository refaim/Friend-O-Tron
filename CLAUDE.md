# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Friend-O-Tron is a World of Warcraft addon that automatically synchronizes friends lists across characters on the same realm. It maintains a shared database of friendships and automatically adds/removes friends to keep them in sync.

## Architecture

### Core Components

- **Environment.lua**: Isolated environment setup using `setfenv(1, FriendOTron)` - must be loaded first
- **Database.lua**: Manages friend events and saved variables via `FriendOTronDatabase`
- **Selector.lua**: Random message selection system for user feedback
- **Addon.lua**: Main logic with friend synchronization and WoW API hooks

### Key Patterns

1. **Isolated Environment**: All files use `setfenv(1, FriendOTron)` to work in an isolated namespace
2. **Event-Driven Database**: Friend changes stored as timestamped events, compressed periodically
3. **API Hooking**: Overrides `AddFriend`/`RemoveFriend` to intercept manual friend changes
4. **Async Operations**: Uses custom async chain system for sequential friend operations

### Database Structure

```lua
FriendOTronDatabase = {
    realmToEvents = {
        [realmName] = {
            {player, friend, type="add|remove", time, source="friend-o-tron|hook"}
        }
    }
}
```

## File Load Order

The `.toc` file defines load order (Environment.lua must be first):
1. Environment.lua - Sets up isolated namespace
2. Database.lua - Data persistence layer  
3. Locale files - Localized strings
4. Addon.lua - Main logic (loaded last)

## Localization

Locale files define `LOCALE_STRINGS` with message templates. The MessageSelector randomly picks messages to avoid repetition. Each locale file follows the same structure with translated strings.

## Development Notes

- No build system, tests, or external dependencies
- Pure Lua addon for World of Warcraft 1.12 (Vanilla/Classic)
- Uses WoW API functions like `GetFriendInfo()`, `AddFriend()`, `CreateFrame()`
- Supports Turtle WoW server detection via `IS_TURTLE_WOW`
- All type annotations use EmmyLua format (`---@type`, `---@class`, etc.)

## Code Style

- Use EmmyLua type annotations
- Prefix all files with `setfenv(1, FriendOTron)`
- Follow existing naming conventions (camelCase for functions, UPPER_CASE for constants)
- Use `echoMessage()` for user notifications with addon-specific formatting