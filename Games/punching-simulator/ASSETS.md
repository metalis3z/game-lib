# Punching Simulator

- Genre: training simulator
- Source file: `Punching Simulator Fully scripted.rbxl`
- Provenance: template with full source
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 500 files, 7573 KB (2 duplicates skipped, 152 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 65 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 409 models, 0 part sets, 1 vfx sets | mirrors the source tree |
| `animations/` | 2 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 4 Animation ids |
| `audio/` | 2 | `Sounds.lua` lists 33 Sound ids |

## Model tags

pet (98), map (57), nature (41), weapon (37), accessory (37), vfx (26), egg (25), sign (9), hud (8), vehicle (7), character (6), portal (6), reward (5), popup (3), trade (3), quest (3), collectible (3), tool (3), inventory (2), rebirth (1), shop (1), settings (1), upgrade (1), leaderboard (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/Texture Pack.rbxm` | 2918 | 417 | 0 | 180x1x189 |  |
| `models/Workspace/Volcano.rbxm` | 232 | 38 | 0 | 382x214x456 |  |
| `models/Workspace/Model~228/Statue.rbxm` | 201 | 108 | 18 | 42x61x42 |  |
| `models/ServerScriptService/GamepassSigns.rbxm` | 185 | 8 | 8 | 426x160x326 | sign |
| `models/Workspace/__MAP/TrainingAreas/1.rbxm` | 143 | 90 | 25 | 33x26x39 | character, map |
| `models/Workspace/Main Portal Template.rbxm` | 75 | 45 | 0 | 16x22x11 | portal |
| `models/Workspace/Main Portal Template~2.rbxm` | 75 | 45 | 0 | 16x22x11 | portal |
| `models/Workspace/__MAP/TrainingAreas/2.rbxm` | 73 | 35 | 28 | 128x51x114 | map |
| `models/Workspace/__MAP/TrainingAreas/6.rbxm` | 68 | 34 | 31 | 140x161x119 | map |
| `models/Workspace/__MAP/TrainingAreas/4.rbxm` | 67 | 32 | 28 | 105x41x66 | map |
| `models/Workspace/__MAP/Interactives/Quests.rbxm` | 65 | 43 | 14 | 36x17x36 | map |
| `models/Workspace/Beach.rbxm` | 61 | 13 | 4 | 540x226x1131 |  |
| `models/ServerStorage/Swords/Double Lightsaber.rbxm` | 59 | 20 | 0 | 2x3x2 | accessory, weapon |
| `models/ServerStorage/Swords/Double Darksaber.rbxm` | 59 | 20 | 0 | 2x3x2 | accessory, weapon |
| `models/ServerStorage/Swords/Green Lightsaber.rbxm` | 49 | 19 | 0 | 2x2x2 | accessory, weapon |
| `models/ServerStorage/Swords/Lightsaber.rbxm` | 49 | 19 | 0 | 2x2x2 | accessory, weapon |
| `models/ServerStorage/Swords/Blue Lightsaber.rbxm` | 49 | 19 | 0 | 2x2x2 | accessory, weapon |
| `models/Workspace/Stairs.rbxm` | 46 | 45 | 0 | 296x194x213 |  |
| `models/ServerStorage/Swords/Pink Lightsaber.rbxm` | 45 | 17 | 0 | 2x2x2 | accessory, weapon |
| `models/Workspace/Stairs~3.rbxm` | 45 | 44 | 0 | 135x190x102 |  |
| `models/Workspace/__MAP/Leaderboards/Strength.rbxm` | 44 | 5 | 5 | 10x16x13 | map, sign |
| `models/Workspace/__MAP/Leaderboards/Time.rbxm` | 37 | 4 | 4 | 13x17x11 | map, sign |
| `models/Workspace/__MAP/Leaderboards/Gems.rbxm` | 37 | 4 | 4 | 14x16x8 | collectible, map, sign |
| `models/Workspace/__MAP/Leaderboards/Rebirths.rbxm` | 37 | 4 | 4 | 12x16x11 | map, sign |
| `models/Workspace/__MAP/Leaderboards/Kills.rbxm` | 37 | 4 | 4 | 13x16x4 | map, sign |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/Store/init.lua` | 446 | 72 |
| `ui/StarterGui/Clans.lua` | 209 | 30 |
| `ui/StarterGui/Main.lua` | 148 | 33 |
| `ui/StarterGui/Settings.lua` | 111 | 21 |
| `ui/StarterGui/Free.lua` | 81 | 4 |
| `ui/StarterGui/Upgrades.lua` | 62 | 9 |
| `ui/StarterGui/Daily.lua` | 57 | 8 |
| `ui/StarterGui/Wheel.lua` | 47 | 12 |
| `ui/StarterGui/Pets.lua` | 45 | 11 |
| `ui/StarterGui/Rebirth.lua` | 36 | 10 |
| `ui/StarterGui/DarkMatterPack.lua` | 36 | 9 |
| `ui/StarterGui/Auras.lua` | 35 | 4 |
| `ui/StarterGui/Ranks.lua` | 35 | 6 |
| `ui/StarterGui/Season.lua` | 33 | 9 |
| `ui/StarterGui/InviteRewards.lua` | 32 | 7 |
| `ui/StarterGui/FreeHugeEvent.lua` | 30 | 10 |
| `ui/StarterGui/HackerEvent.lua` | 30 | 10 |
| `ui/StarterGui/Quests.lua` | 28 | 2 |
| `ui/ReplicatedStorage/Assets/UI/Season/Cell.lua` | 27 | 6 |
| `ui/StarterGui/Trade.lua` | 24 | 1 |
| `ui/StarterGui/RainbowEggs.lua` | 21 | 5 |
| `ui/StarterGui/DiscordVerification.lua` | 21 | 8 |
| `ui/StarterGui/Tutorial.lua` | 18 | 2 |
| `ui/StarterGui/PetPack.lua` | 17 | 9 |
| `ui/ReplicatedStorage/Assets/UI/EggBillboard.lua` | 16 | 3 |
| `ui/ReplicatedStorage/Assets/UI/Clans/Quest.lua` | 15 | 4 |
| `ui/ReplicatedStorage/Assets/UI/Tutorial/Quest.lua` | 15 | 4 |
| `ui/ReplicatedStorage/Assets/UI/InviteRewards/InviteReward.lua` | 15 | 4 |
| `ui/StarterGui/Confirm.lua` | 13 | 4 |
| `ui/ServerStorage/3.lua` | 10 | 4 |
| `ui/ServerStorage/4.lua` | 10 | 4 |
| `ui/ReplicatedStorage/Assets/UI/Toolbar/ToolbarButton.lua` | 9 | 3 |
| `ui/ReplicatedStorage/Assets/UI/Clans/Clan.lua` | 9 | 3 |
| `ui/ServerStorage/1.lua` | 9 | 3 |
| `ui/ServerStorage/2.lua` | 9 | 3 |
| `ui/StarterGui/Reward.lua` | 8 | 2 |
| `ui/ReplicatedStorage/Assets/UI/CharacterBillboard.lua` | 8 | 3 |
| `ui/ReplicatedStorage/Assets/UI/Clans/Member.lua` | 8 | 3 |
| `ui/StarterGui/SpecialEvent.lua` | 7 | 1 |
| `ui/ReplicatedStorage/Assets/UI/Leaderboard/CellTemplate.lua` | 7 | 1 |
