# Friend-O-Tron

A World of Warcraft addon for Vanilla WoW (1.12.1) and Turtle WoW that automatically synchronizes friends lists across all your characters on the same realm.

*An experimental automated friend-syncing construct! May exhibit catastrophic enthusiasm.*

## Features

- **Automatic Friend Synchronization**: Keeps friends lists synchronized across all characters on the same realm
- **Cross-Account Support**: Share friends lists between multiple WoW accounts using SuperWoW (if available)
- **Gnomish Engineering Marvel**: Features authentic gnomish over-engineering with delightfully unstable friendship protocols and entertaining mechanical personality quirks
- **Cross-Faction Support**: Works seamlessly with friends from different factions on PvE and PvP realms
- **Multi-Language Support**: Available in 9 languages (English, German, Spanish, French, Korean, Portuguese, Russian, Chinese Simplified, Chinese Traditional)

### First-Time Setup

1. Enable the addon on all characters you want to synchronize
2. Log in with any of that character - Friend-O-Tron will catalog your existing friends
3. Log in with other characters - they will automatically receive the shared friends list and contribute their own friends to it
4. Any future friend additions/removals on any character will sync to all others

### Cross-Account Synchronization (Advanced)

For synchronizing friends between multiple WoW accounts:

1. Install [SuperWoW](https://github.com/balakethelock/SuperWoW)
2. Friend-O-Tron will automatically detect SuperWoW and enable file-based synchronization
3. Friend lists will be shared between all accounts using the same SuperWoW installation
4. Friends from other accounts are loaded only when you log into the game world

## Usage

- `/fot help` - Display help information

## Limitations

- Synchronization only works within the same realm
- Friend list capacity is limited by WoW's built-in 50-friend limit
