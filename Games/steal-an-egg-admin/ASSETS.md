# Steal an Egg + P2W Admin Panel

- Genre: steal / tycoon (eggs) + admin panel
- Source file: `SU - SAE + P2W ADMIN PANEL.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 952 files, 20355 KB (0 duplicates skipped, 322 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 141 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 715 models, 1 part sets, 27 vfx sets | mirrors the source tree |
| `animations/` | 19 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 78 Animation ids |
| `audio/` | 14 | `Sounds.lua` lists 263 Sound ids |

## Model tags

character (243), egg (225), decoration (193), vfx (146), map (141), cutscene (71), tool (68), nature (50), building (48), hud (31), weapon (15), popup (11), treadmill (11), reward (6), pet (4), sign (4), inventory (3), shop (3), ability (3), settings (2), upgrade (2), leaderboard (2), collectible (2), index (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ReplicatedStorage/Assets/Models/MonsterParasite/Monster4.rbxm` | 12173 | 11 | 10 | 13x11x12 | character |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Prehistoric.rbxm` | 7796 | 1106 | 51 | 502x44x151 | character, map |
| `models/ReplicatedStorage/AssetModels/Froggo.rbxm` | 7062 | 13 | 10 | 7x10x9 | character |
| `models/ReplicatedStorage/Assets/Models/MonsterParasite/Monster1.rbxm` | 7055 | 11 | 10 | 10x11x12 | character |
| `models/ReplicatedStorage/AssetModels/Crawler.rbxm` | 6911 | 16 | 13 | 10x8x43 | character |
| `models/ReplicatedStorage/Assets/Models/MonsterParasite/Monster3.rbxm` | 4269 | 11 | 10 | 12x11x12 | character |
| `models/ReplicatedStorage/Assets/Models/MonsterParasite/Monster2.rbxm` | 3898 | 11 | 10 | 11x11x12 | character |
| `models/ReplicatedStorage/AssetModels/Crocodon.rbxm` | 2740 | 9 | 6 | 17x28x30 | character |
| `models/ReplicatedStorage/Model.rbxm` | 2173 | 1267 | 0 | 168x45x838 |  |
| `models/Workspace/__OBJECTS/Leaderboards/Models/Leaderboard1.rbxm` | 2139 | 29 | 0 | 3x20x14 | sign |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Volcano.rbxm` | 1267 | 1135 | 80 | 379x20x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Jungle.rbxm` | 1243 | 1111 | 56 | 230x9x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Desert.rbxm` | 1224 | 1114 | 59 | 205x10x151 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Cherry Blossom.rbxm` | 1192 | 1072 | 16 | 676x33x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Cosmic.rbxm` | 1175 | 1090 | 32 | 642x31x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Titan Temple.rbxm` | 1149 | 1063 | 7 | 860x40x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Abyss Ocean.rbxm` | 1140 | 1072 | 9 | 423x17x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Snow.rbxm` | 1137 | 1071 | 16 | 318x14x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Lake.rbxm` | 1126 | 1067 | 13 | 140x8x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Forest.rbxm` | 1121 | 1066 | 11 | 93x8x151 | character, map |
| `models/ReplicatedStorage/GearTools/Building Tools.rbxm` | 1009 | 1 | 0 | 1x1x1 | building, tool |
| `models/Workspace/Plots/1.rbxm` | 217 | 124 | 0 | 75x45x71 | building |
| `models/Workspace/Plots/7.rbxm` | 217 | 124 | 0 | 55x45x75 | building |
| `models/Workspace/Plots/6.rbxm` | 217 | 124 | 0 | 55x45x122 | building |
| `models/Workspace/Plots/4.rbxm` | 217 | 124 | 0 | 75x45x71 | building |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/AdminPanel_PREVIEW/init.lua` | 630 | 12 |
| `ui/StarterGui/PhoneVideoUI.lua` | 235 | 23 |
| `ui/StarterGui/TrailShop.lua` | 230 | 14 |
| `ui/StarterGui/AdminPanelPetIconPicker.lua` | 223 | 108 |
| `ui/StarterGui/AdminPanelPetPicker.lua` | 223 | 95 |
| `ui/StarterGui/RobuxShop.lua` | 187 | 26 |
| `ui/StarterGui/TreadmillScreenComments.lua` | 174 | 9 |
| `ui/StarterGui/HUD.lua` | 168 | 29 |
| `ui/StarterGui/PetFuse.lua` | 160 | 10 |
| `ui/StarterGui/SakuraEggCharge.lua` | 135 | 23 |
| `ui/StarterGui/SpeedShop.lua` | 86 | 12 |
| `ui/StarterGui/BottomUI.lua` | 76 | 16 |
| `ui/StarterGui/PopupPrompt.lua` | 65 | 1 |
| `ui/StarterGui/AdminPanelMutationPicker.lua` | 63 | 27 |
| `ui/StarterGui/SakuraEventTutorialFrame.lua` | 54 | 17 |
| `ui/StarterGui/Index.lua` | 52 | 8 |
| `ui/StarterGui/ActivePets.lua` | 51 | 3 |
| `ui/StarterGui/BackpackGui.lua` | 49 | 10 |
| `ui/StarterGui/MonsterEventTutorialFrame.lua` | 46 | 6 |
| `ui/StarterGui/AdminPanelSettings.lua` | 45 | 3 |
| `ui/StarterGui/Settings.lua` | 42 | 2 |
| `ui/StarterGui/AdminPanelPassInfo.lua` | 38 | 7 |
| `ui/StarterGui/CrateOpeningPopUpFrame.lua` | 34 | 9 |
| `ui/StarterGui/AdminPanelEggPicker.lua` | 34 | 14 |
| `ui/StarterGui/Message.lua` | 32 | 7 |
| `ui/StarterGui/AdminModelBrowser.lua` | 30 | 0 |
| `ui/StarterGui/GrowingEggs.lua` | 25 | 4 |
| `ui/StarterGui/FreeGift.lua` | 24 | 7 |
| `ui/StarterGui/MonsterEventUI.lua` | 24 | 3 |
| `ui/StarterGui/RollbackRewardUI.lua` | 21 | 7 |
| `ui/StarterGui/TreadmillVideoSurfaceGui.lua` | 21 | 4 |
| `ui/StarterGui/CaptureTheEggUI.lua` | 19 | 2 |
| `ui/StarterGui/AutoSell.lua` | 18 | 2 |
| `ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/Default.lua` | 17 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/HotbarTemplate.lua` | 17 | 4 |
| `ui/StarterGui/MonsterChestRewards.lua` | 16 | 4 |
| `ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/Steal.lua` | 16 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/RoundCarrySteal.lua` | 16 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/Sell.lua` | 16 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/Green.lua` | 16 | 0 |
