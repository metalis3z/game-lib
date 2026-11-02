# RIVALS (modded)

- Genre: arena FPS (duels)
- Source file: `SLBR - RIVALS MODDED - BOOSTER.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 2814 files, 31892 KB (8 duplicates skipped, 8 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 282 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 2429 models, 2 part sets, 6 vfx sets | mirrors the source tree |
| `animations/` | 1 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 89 Animation ids |
| `audio/` | 51 | `Sounds.lua` lists 155 Sound ids |

## Model tags

accessory (667), weapon (461), vfx (447), map (265), character (71), ability (61), decoration (52), collectible (41), nature (34), hud (27), popup (27), portal (25), sign (19), building (19), reward (18), keyboard (17), vehicle (10), tool (7), shop (6), road (6), backup (4), leaderboard (3), loading (2), inventory (2), settings (2), index (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/Maps/BigMaps/Big Station.rbxm` | 5206 | 3720 | 1628 | 1364x486x1330 | map |
| `models/ServerStorage/Maps/Docks.rbxm` | 3263 | 2514 | 1042 | 2000x429x2000 | map |
| `models/ServerStorage/Maps/Museum.rbxm` | 2988 | 2183 | 972 | 1000x1000x1000 | map |
| `models/ServerStorage/Maps/Station.rbxm` | 2866 | 2097 | 955 | 1019x532x1134 | map |
| `models/ServerStorage/Maps/Legacy/Legacy Docks.rbxm` | 2687 | 1834 | 670 | 2054x490x2048 | map |
| `models/ServerStorage/Maps/BigMaps/Big Crossroads.rbxm` | 2565 | 2357 | 0 | 1523x498x1536 | map |
| `models/ServerStorage/Maps/Battleground.rbxm` | 2172 | 1429 | 393 | 1500x272x1500 | map |
| `models/ServerStorage/Maps/Studio.rbxm` | 2100 | 1706 | 331 | 2638x1000x1961 | map |
| `models/ServerStorage/Maps/BigMaps/Big Graveyard.rbxm` | 2063 | 1695 | 876 | 750x206x750 | map |
| `models/ServerStorage/Maps/Westown.rbxm` | 1944 | 1630 | 490 | 2722x595x2251 | map |
| `models/ServerStorage/Maps/Graveyard.rbxm` | 1809 | 1484 | 788 | 750x343x750 | map |
| `models/ServerStorage/Maps/Legacy/Legacy Crossroads.rbxm` | 1803 | 1692 | 0 | 921x515x948 | map |
| `models/ServerStorage/Maps/Shooting Range.rbxm` | 1665 | 441 | 30 | 750x327x750 | map |
| `models/ServerStorage/Maps/Dimension.rbxm` | 1314 | 987 | 303 | 750x460x750 | map |
| `models/ServerStorage/Maps/Bridge.rbxm` | 1310 | 701 | 374 | 5143x886x5143 | map |
| `models/ServerStorage/Maps/Construction.rbxm` | 1226 | 535 | 118 | 1500x564x1500 | map |
| `models/StarterPlayer/StarterPlayerScripts/Assets/Misc/EquipmentScenes/Festive.rbxm` | 1125 | 452 | 325 | 93x70x80 | character |
| `models/ServerStorage/Maps/BigMaps/Big Backrooms.rbxm` | 1110 | 655 | 410 | 400x300x400 | map |
| `models/Workspace/BigMaps/Big Backrooms.rbxm` | 1110 | 655 | 410 | 400x300x400 | map |
| `models/StarterPlayer/StarterPlayerScripts/Assets/Misc/EquipmentScenes/Default.rbxm` | 1066 | 444 | 224 | 96x51x97 | character |
| `models/ServerStorage/Maps/Playground.rbxm` | 1054 | 846 | 552 | 750x277x750 | map |
| `models/ServerStorage/Maps/Village.rbxm` | 1035 | 621 | 424 | 2048x649x2048 | map |
| `models/ServerStorage/Maps/Gate.rbxm` | 959 | 183 | 0 | 751x233x751 | map |
| `models/ServerStorage/Maps/Factory.rbxm` | 712 | 283 | 17 | 472x640x490 | map |
| `models/ServerStorage/Maps/Backrooms.rbxm` | 653 | 376 | 273 | 400x302x400 | map |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Shop/init.lua` | 556 | 61 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/MainGui/init.lua` | 521 | 42 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/DuelInterface.lua` | 259 | 12 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Rewards.lua` | 142 | 11 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Matchmaking.lua` | 114 | 11 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Gifting.lua` | 113 | 13 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Settings.lua` | 107 | 12 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Ranked.lua` | 107 | 9 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/SettingFrame.lua` | 100 | 12 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/BattlePass.lua` | 89 | 7 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/ViewProfile.lua` | 69 | 10 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/FighterInterface.lua` | 61 | 10 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/Ban.lua` | 49 | 6 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/EventOverview.lua` | 48 | 10 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/SendOfflineGiftRewards.lua` | 47 | 5 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Credits.lua` | 47 | 6 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/LikeBoardGui.lua` | 46 | 6 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Maps.lua` | 44 | 6 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/ViewRankedDetails.lua` | 41 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Collection.lua` | 40 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/ViewPlayerData.lua` | 39 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/SendBugRewards.lua` | 39 | 5 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/BillboardVideoAdsGui.lua` | 39 | 7 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Tasks.lua` | 39 | 7 |
| `ui/ReplicatedFirst/Root/LoadingScreen/LoadingScreen.lua` | 37 | 8 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/PartyInviteSlot.lua` | 37 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/InspectShopEntry.lua` | 36 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/UGCShop.lua` | 35 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/ShopBigSlot.lua` | 33 | 8 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/InspectBackpackReward.lua` | 33 | 4 |
| `ui/ServerStorage/LoadingScreenGui_testrival_Backup.lua` | 32 | 5 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/FinalResultsPlayerSlot.lua` | 31 | 5 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/ShopSlot.lua` | 29 | 7 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Party.lua` | 29 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/ItemInterface.lua` | 28 | 5 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/PrivateServerControls.lua` | 28 | 4 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Bundles/superstarter_bundle.lua` | 26 | 7 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/PickEmote.lua` | 26 | 4 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/TaskContainer.lua` | 25 | 3 |
| `ui/StarterPlayer/StarterPlayerScripts/UserInterface/PermissionsPlayersCard.lua` | 25 | 5 |
