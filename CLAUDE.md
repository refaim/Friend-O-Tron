# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Friend-O-Tron is a World of Warcraft addon that automatically synchronizes friends lists across characters on the same realm. It maintains a shared database of friendship events and automatically adds/removes friends to keep them in sync across all characters.

## Core Architecture

### Environment & Namespace Isolation
- **Environment.lua**: Sets up isolated namespace using `setfenv(1, FriendOTron)` - must be loaded first
- All files use `setfenv(1, FriendOTron)` to work in an isolated namespace preventing global variable pollution
- Provides fallback to game globals via `{__index = _G}` metatable

### Database System
- **Database.lua**: Manages friend events and saved variables via `FriendOTronDatabase`
- Event-driven architecture: stores friend changes as timestamped events, compresses periodically
- Multi-account sync: supports SuperWoW file import/export for cross-account synchronization
- Events stored as: `{player, friend, type="add|remove", time}`

### Friend Management Library
- **LibFriendship.lua**: Wrapper around WoW's friend API with async job queue system
- Overrides global `AddFriend`/`RemoveFriend` functions to track all friend operations
- Job queue prevents API conflicts and provides reliable event handling
- Event listener system for tracking friendship changes

### Message System
- **Selector.lua**: Random message selection system to avoid repetitive notifications
- Multiple templates per message type to provide variety
- Tracks previous messages to prevent immediate repetition

### Main Logic
- **Addon.lua**: Core synchronization logic and user interface
- Settings system with quiet/noisy modes
- Slash command interface (`/fot help`, `/fot quiet`, `/fot noisy`)
- Event-driven startup and synchronization

## File Load Order (Critical)

The `.toc` file defines strict load order:
1. **Environment.lua** - Namespace setup (must be first)
2. **Database.lua** - Data persistence layer
3. **Locale files** - Localized strings (9 languages supported)
4. **LibFriendship.lua** - Friend API wrapper
5. **Selector.lua** - Message selection system
6. **Addon.lua** - Main logic (loaded last)

## Database Structure

```lua
FriendOTronDatabase = {
    realmToEvents = {
        [realmName] = {
            {player, friend, type="add|remove", time}
        }
    }
}

FriendOTronSettings = {
    noisy = true  -- notification mode
}
```

## Localization System

- **9 languages supported**: enUS, deDE, esES, frFR, koKR, ptBR, ruRU, zhCN, zhTW
- Each locale file defines `LOCALE_STRINGS` with message templates
- Main message types:
  - `addon_loaded_message` - Startup notification
  - `addon_help_message` - Help text
  - `quiet_mode_enabled_message` / `noisy_mode_enabled_message` - Mode switching
  - `friend_list_full_message` - Error when friend list is full
  - Multiple templates for add/remove/save operations (randomized)

## Key Features

### Multi-Account Synchronization
- Uses SuperWoW's `ImportFile`/`ExportFile` for cross-account data sharing
- Fallback to per-character saved variables when SuperWoW unavailable
- Automatic detection of Turtle WoW server

### Smart Event Compression
- Periodically compresses event history (only keeps latest state per friend)
- Sorts events chronologically for consistent processing
- Reduces memory usage and file size

### User Interface
- `/fot help` - Show help message
- `/fot quiet` - Enable stealth mode (no notifications)  
- `/fot noisy` - Enable maximum notifications (default)
- Themed messages with robotic/sci-fi personality

### Error Handling
- Graceful handling of full friend lists
- Suppresses duplicate error messages during bulk operations
- Timeout handling for failed friend operations

## Development Notes

- **Target**: World of Warcraft 1.12 (Vanilla/Classic)
- **No dependencies**: Pure Lua addon using only WoW API
- **No build system**: Direct Lua files loaded by game client
- **Type annotations**: Uses EmmyLua format (`---@type`, `---@class`, etc.)
- **Special server support**: Turtle WoW detection and Portuguese locale handling

## Code Style Guidelines

- Use EmmyLua type annotations throughout
- Prefix all files with `setfenv(1, FriendOTron)`
- Follow existing naming conventions:
  - camelCase for functions and variables
  - UPPER_CASE for constants
  - PascalCase for classes/types
- Use `echoMessage()` for user notifications (provides consistent addon formatting)
- Never create files unless explicitly required - always prefer editing existing files
- Follow the isolated environment pattern established in Environment.lua

## Critical Implementation Details

1. **Load order dependency**: Environment.lua must always be first
2. **Namespace isolation**: All code runs in FriendOTron environment
3. **Event compression**: Database automatically compresses to prevent bloat
4. **Async friend operations**: LibFriendship queues operations to prevent conflicts
5. **Message variety**: Selector ensures users don't see repetitive notifications
6. **Multi-account sync**: SuperWoW integration allows sharing across characters