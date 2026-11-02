# RCU (roll / mounts)

- Genre: RNG roller (Knit, auto roll, mounts)
- Source file: `RCU.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 754 files, 6601 KB (0 duplicates skipped, 48 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 82 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 601 models, 0 part sets, 5 vfx sets | mirrors the source tree |
| `animations/` | 1 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 6 Animation ids |
| `audio/` | 1 | `Sounds.lua` lists 49 Sound ids |

## Model tags

map (514), nature (96), building (65), pet (55), vfx (50), accessory (31), collectible (27), hud (26), egg (22), weapon (9), sign (9), cutscene (6), reward (5), trade (4), vehicle (4), character (3), shop (2), backup (1), loading (1), inventory (1), popup (1), rebirth (1), index (1), quest (1), upgrade (1), leaderboard (1), keyboard (1), portal (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/Workspace/Game/Maps/Spawn/Leaderboards/EggsOpened.rbxm` | 12538 | 12 | 11 | 10x15x12 | egg, map, sign |
| `models/Workspace/Game/Maps/Spawn/Leaderboards/Rebirths.rbxm` | 2518 | 7 | 6 | 11x16x14 | map, sign |
| `models/Workspace/Game/Maps/Spawn/Leaderboards/TotalClicks.rbxm` | 2517 | 7 | 6 | 14x15x4 | map, sign |
| `models/Workspace/Game/Maps/Spawn/Leaderboards/TimePlayed.rbxm` | 2517 | 7 | 6 | 14x15x4 | map, sign |
| `models/Workspace/Game/Maps/Spawn/Leaderboards/RobuxSpent.rbxm` | 2517 | 7 | 6 | 10x15x12 | map, sign |
| `models/Workspace/Game/Maps/Kingdom/ClanCastle/other models/UPD1/ClanHatching.rbxm` | 2509 | 1 | 0 | 12x11x2 | map |
| `models/Workspace/Game/Maps/Kingdom/ClanCastle/other models/UPD1/ClanRebirths.rbxm` | 2509 | 1 | 0 | 9x11x8 | map |
| `models/Workspace/Game/Maps/Spawn/Leaderboards/Rewards.rbxm` | 1108 | 8 | 7 | 7x12x10 | map, sign |
| `models/Workspace/Game/Maps/Atlantis/Leaderboards/AuraRolls.rbxm` | 536 | 1 | 0 | 9x12x7 | map, sign, vfx |
| `models/ReplicatedStorage/Assets/Cutscenes/Eternal.rbxm` | 385 | 251 | 214 | 787x789x1238 | cutscene |
| `models/Workspace/Game/Maps/Kingdom/ClanCastle/MainUpgrades/Candle Stands.rbxm` | 321 | 93 | 45 | 187x10x98 | building, map |
| `models/ReplicatedStorage/Assets/Cutscenes/Secret.rbxm` | 269 | 153 | 132 | 47x25x63 | cutscene |
| `models/Workspace/Game/Maps/Desert/Models/_.rbxm` | 267 | 26 | 15 | 3x7x3 | accessory, character, map |
| `models/ReplicatedStorage/Assets/Booths/TutelBooth.rbxm` | 199 | 84 | 61 | 15x14x8 | building |
| `models/ReplicatedStorage/Assets/Mounts/Tutelcopter.rbxm` | 145 | 51 | 43 | 10x9x16 |  |
| `models/Workspace/Game/Maps/Kingdom/ClanCastle/MainUpgrades/Knight's Armor.rbxm` | 137 | 91 | 84 | 110x24x158 | map |
| `models/ReplicatedStorage/Assets/Booths/RoyalBooth.rbxm` | 110 | 83 | 60 | 14x13x8 | building |
| `models/Workspace/Game/Maps/Spawn/Machines/Upgrades.rbxm` | 98 | 69 | 59 | 26x19x26 | map |
| `models/ReplicatedStorage/Assets/Booths/PartyBooth.rbxm` | 95 | 69 | 65 | 13x14x8 | building |
| `models/ReplicatedStorage/Assets/Booths/RngBooth.rbxm` | 95 | 33 | 25 | 13x12x8 | building |
| `models/Workspace/Game/Maps/Farm/Machines/GoldenMachine.rbxm` | 93 | 35 | 27 | 30x24x28 | map |
| `models/ReplicatedStorage/Assets/Booths/PoliceBooth.rbxm` | 90 | 59 | 50 | 10x13x4 | building |
| `models/ReplicatedStorage/Assets/Mounts/Royal Hoverboard.rbxm` | 90 | 39 | 32 | 11x2x5 |  |
| `models/ReplicatedStorage/Assets/Booths/FarmBooth.rbxm` | 74 | 59 | 46 | 10x13x8 | building |
| `models/Workspace/Game/Maps/Kingdom/ClanCastle/MainUpgrades/King's Gold.rbxm` | 66 | 43 | 42 | 73x10x57 | map |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/MainUI/init.lua` | 5017 | 247 |
| `ui/TextChatService/adaspo_playground/EggDisplayFrame.lua` | 42 | 4 |
| `ui/TextChatService/adaspo_playground/ExclusiveEggConfirmFrame.lua` | 32 | 5 |
| `ui/TextChatService/adaspo_playground/ExclusiveEggConfirmFrame~2.lua` | 32 | 5 |
| `ui/ReplicatedStorage/Assets/UI/Pet.lua` | 26 | 14 |
| `ui/ReplicatedStorage/Assets/UI/TradeListPlayer.lua` | 24 | 1 |
| `ui/ReplicatedStorage/Assets/UI/Clans/Player.lua` | 23 | 2 |
| `ui/ReplicatedStorage/Assets/UI/FarmUpgrade.lua` | 22 | 4 |
| `ui/ReplicatedStorage/Assets/UI/Clans/ClanInvite.lua` | 19 | 3 |
| `ui/ReplicatedStorage/Assets/Billboards/TopPlayer.lua` | 19 | 5 |
| `ui/ReplicatedStorage/Assets/UI/DailyReward.lua` | 18 | 3 |
| `ui/ReplicatedStorage/Assets/UI/Achievement.lua` | 18 | 2 |
| `ui/ReplicatedStorage/Assets/UI/Clans/ClanTop.lua` | 16 | 4 |
| `ui/ReplicatedStorage/Assets/UI/SupporterPack.lua` | 16 | 2 |
| `ui/ReplicatedStorage/Assets/UI/TradingPlazaServer.lua` | 15 | 2 |
| `ui/ReplicatedStorage/Assets/UI/Item.lua` | 13 | 3 |
| `ui/ReplicatedStorage/Assets/UI/Teleport.lua` | 12 | 4 |
| `ui/ReplicatedStorage/Assets/UI/Title.lua` | 12 | 0 |
| `ui/TextChatService/adaspo_playground/Template_Tradelist.lua` | 11 | 1 |
| `ui/ReplicatedStorage/Assets/UI/BoothOffer.lua` | 11 | 1 |
| `ui/ReplicatedStorage/Assets/UI/Leaderboard.lua` | 11 | 2 |
| `ui/ReplicatedStorage/Assets/UI/IndexReward.lua` | 8 | 0 |
| `ui/ReplicatedStorage/Assets/UI/NewItem.lua` | 8 | 2 |
| `ui/StarterGui/Overlays.lua` | 7 | 1 |
| `ui/TextChatService/adaspo_playground/RewardsTest2.lua` | 7 | 1 |
| `ui/TextChatService/adaspo_playground/RewardsTest.lua` | 7 | 1 |
| `ui/ReplicatedStorage/Assets/UI/Rebirth.lua` | 7 | 2 |
| `ui/ReplicatedStorage/Assets/UI/Hatch.lua` | 7 | 0 |
| `ui/ReplicatedStorage/Assets/UI/BoothPlayerOffer.lua` | 7 | 1 |
| `ui/ReplicatedStorage/Assets/UI/InfoHover/Components/AmountInfo.lua` | 5 | 1 |
| `ui/ReplicatedStorage/Assets/UI/InfoHover/InfoHover.lua` | 5 | 2 |
| `ui/ReplicatedStorage/Assets/UI/MapWallQuest.lua` | 5 | 0 |
| `ui/ReplicatedStorage/Assets/UI/Boost.lua` | 5 | 1 |
| `ui/ReplicatedStorage/Assets/UI/PrestigeReward.lua` | 5 | 1 |
| `ui/ReplicatedStorage/Assets/UI/AuraInfo.lua` | 4 | 0 |
| `ui/ReplicatedStorage/Assets/UI/InfoHover/Components/Untradeable.lua` | 4 | 1 |
| `ui/ReplicatedStorage/Assets/Billboards/TreeRespawn.lua` | 4 | 0 |
| `ui/ReplicatedStorage/Assets/UI/InfoHover/Components/State.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Assets/UI/InfoHover/Components/PetsList.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Assets/UI/InfoHover/Components/PlayerName.lua` | 3 | 0 |
