# Grow a Garden 2 (GAG2)

- Genre: farming / garden simulator
- Source file: `Grow A Garden 2 -.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 641 files, 13731 KB (83 duplicates skipped, 241 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 110 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 469 models, 46 part sets, 30 vfx sets | mirrors the source tree |
| `animations/` | 56 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 165 Animation ids |
| `audio/` | 1 | `Sounds.lua` lists 189 Sound ids |

## Model tags

nature (118), decoration (67), vfx (59), character (56), tool (53), building (48), hud (26), collectible (24), accessory (18), pet (18), backup (16), cutscene (9), shop (8), map (8), egg (7), popup (6), sign (5), portal (3), leaderboard (2), reward (1), loading (1), settings (1), inventory (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ReplicatedStorage/Assets/Cutscenes/GAGTrailerShortVers.rbxm` | 17729 | 9642 | 736 | 404x155x380 | accessory, character, cutscene |
| `models/ReplicatedStorage/Assets/Cutscenes/GAGTrailer.rbxm` | 13422 | 9874 | 761 | 404x155x380 | accessory, character, cutscene |
| `models/ReplicatedStorage/Assets/Cutscenes/GAGTrailerNoWalls.rbxm` | 9952 | 6981 | 653 | 404x155x380 | accessory, character, cutscene |
| `models/ReplicatedStorage/Assets/Pets/Dragonfly.rbxm` | 5905 | 45 | 0 | 6x2x6 | character, pet |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Power Hose/HoseInspect/Player2.rbxm` | 5542 | 7 | 0 | 4x5x1 | character, tool |
| `models/Workspace/GearScenes/Power Hose/HoseInspect/Player2.rbxm` | 5542 | 7 | 0 | 4x5x1 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Vine Wrapper/VineInspect/Player1.rbxm` | 4866 | 31 | 0 | 4x5x7 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Vine Wrapper/VineInspect/Player2.rbxm` | 4620 | 7 | 0 | 4x5x1 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Freeze Ray/FreezeInspect/Player2.rbxm` | 4263 | 7 | 0 | 4x5x1 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Freeze Ray/FreezeInspect/Player1.rbxm` | 4081 | 12 | 3 | 4x6x2 | character, tool |
| `models/Workspace/GearScenes/Freeze Ray/FreezeInspect/Player1.rbxm` | 4081 | 12 | 3 | 4x6x2 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Rainbow Carpet/CarpetInspect/Player.rbxm` | 2934 | 7 | 0 | 4x5x1 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Vine Wrapper/VineInspect/Camera.rbxm` | 2592 | 2 | 0 | 1x2x2 | character, tool |
| `models/Workspace/GearScenes/Vine Wrapper/VineInspect/Player1.rbxm` | 2345 | 31 | 0 | 4x5x7 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Power Hose/HoseInspect/Player1.rbxm` | 2204 | 21 | 12 | 4x8x2 | character, tool |
| `models/Workspace/GearScenes/Power Hose/HoseInspect/Player1.rbxm` | 2204 | 21 | 12 | 4x8x2 | character, tool |
| `models/Workspace/GearScenes/Vine Wrapper/VineInspect/Player2.rbxm` | 2198 | 7 | 0 | 4x5x1 | character, tool |
| `models/ReplicatedStorage/Assets/Pets/Owl.rbxm` | 2077 | 39 | 0 | 2x3x2 | character, pet |
| `models/Workspace/GearScenes/Vine Wrapper/VineInspect/Camera.rbxm` | 1600 | 2 | 0 | 1x2x2 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Freeze Ray/FreezeInspect/Camera.rbxm` | 1423 | 2 | 0 | 1x2x2 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Power Hose/HoseInspect/Camera.rbxm` | 1032 | 2 | 0 | 1x2x2 | character, tool |
| `models/Workspace/GearScenes/Power Hose/HoseInspect/Camera.rbxm` | 1032 | 2 | 0 | 1x2x2 | character, tool |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/SeedInspectController/FakePlot.rbxm` | 976 | 694 | 4 | 186x31x190 | building |
| `models/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Rainbow Carpet/CarpetInspect/Carpet.rbxm` | 867 | 1 | 1 | 4x1x8 | character, tool, vfx |
| `models/ServerStorage/Plot.rbxm` | 526 | 360 | 0 | 139x1000x128 | building |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/RobuxShop/init.lua` | 582 | 27 |
| `ui/StarterGui/SeedShop.lua` | 209 | 10 |
| `ui/StarterGui/MailboxUI.lua` | 185 | 13 |
| `ui/StarterGui/PlayerGardenMarket.lua` | 183 | 9 |
| `ui/StarterGui/CustomiseFenceTheme.lua` | 140 | 12 |
| `ui/StarterGui/CinematicBars.lua` | 129 | 6 |
| `ui/StarterGui/GearCinematicBars.lua` | 129 | 6 |
| `ui/StarterGui/GearShop.lua` | 114 | 10 |
| `ui/StarterGui/CrateShop.lua` | 113 | 9 |
| `ui/StarterGui/ViewGuildProgress.lua` | 105 | 6 |
| `ui/StarterGui/ViewGuildPage.lua` | 99 | 9 |
| `ui/StarterGui/AdminPanel.lua` | 80 | 4 |
| `ui/StarterGui/GuildShop.lua` | 70 | 7 |
| `ui/StarterGui/EditGuild.lua` | 69 | 7 |
| `ui/StarterGui/PremiumSeedShop.lua` | 66 | 8 |
| `ui/StarterGui/CreateGuild.lua` | 65 | 5 |
| `ui/StarterGui/Settings.lua` | 46 | 4 |
| `ui/StarterGui/ViewGuildLeaderboard.lua` | 46 | 7 |
| `ui/StarterGui/PropsFrame.lua` | 45 | 4 |
| `ui/StarterGui/WeatherUI.lua` | 44 | 9 |
| `ui/StarterGui/GrowingList.lua` | 44 | 7 |
| `ui/StarterGui/PetList.lua` | 43 | 5 |
| `ui/StarterGui/PreRobuxPrompt.lua` | 37 | 0 |
| `ui/StarterGui/PetInfo.lua` | 37 | 6 |
| `ui/StarterGui/TeleportButtons.lua` | 35 | 8 |
| `ui/StarterGui/GuildInvite.lua` | 33 | 5 |
| `ui/StarterGui/PlayerSelector.lua` | 32 | 6 |
| `ui/StarterGui/ColorPickerGuild.lua` | 32 | 5 |
| `ui/StarterGui/Odds.lua` | 31 | 6 |
| `ui/ReplicatedStorage/Assets/BillboardUIs/CosmeticControl.lua` | 29 | 6 |
| `ui/StarterGui/Message.lua` | 28 | 4 |
| `ui/StarterGui/GuildWeekComplete.lua` | 28 | 4 |
| `ui/StarterGui/Gifting.lua` | 25 | 4 |
| `ui/StarterGui/LeaveGuild.lua` | 24 | 4 |
| `ui/StarterGui/EquipPet.lua` | 21 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/Controllers/InventoryController/Main/SideBar.lua` | 21 | 5 |
| `ui/StarterGui/RollFrame_New.lua` | 20 | 6 |
| `ui/StarterGui/HUD.lua` | 18 | 4 |
| `ui/StarterGui/Banhammer/BanGui.lua` | 18 | 3 |
| `ui/ReplicatedStorage/ProximityPromptTemplates/Default.lua` | 17 | 1 |
