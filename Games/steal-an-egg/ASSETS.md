# Steal an Egg (latest)

- Genre: steal / tycoon (eggs, pets, plots)
- Source file: `SLBR- VIP - SAE LATEST.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 1037 files, 17611 KB (16 duplicates skipped, 429 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 375 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 526 models, 5 part sets, 90 vfx sets | mirrors the source tree |
| `animations/` | 25 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 135 Animation ids |
| `audio/` | 9 | `Sounds.lua` lists 176 Sound ids |

## Model tags

egg (206), vfx (201), character (125), backup (82), tool (60), pet (50), building (47), hud (35), popup (22), map (22), reward (16), weapon (15), treadmill (12), shop (8), trade (7), leaderboard (5), upgrade (4), ability (4), sign (4), index (3), inventory (2), accessory (2), rebirth (1), settings (1), collectible (1), cutscene (1), portal (1), nature (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Prehistoric.rbxm` | 8047 | 1106 | 51 | 502x41x151 | character, map |
| `models/ReplicatedStorage/AssetModels/Brr Brr Patapim.rbxm` | 5441 | 36 | 33 | 24x13x6 | character |
| `models/ReplicatedStorage/AssetModels/Cerberus.rbxm` | 5262 | 83 | 80 | 21x21x36 | character |
| `models/Workspace/__OBJECTS/Leaderboards/Models/Leaderboard1.rbxm` | 2139 | 29 | 0 | 3x20x14 | sign |
| `models/ReplicatedStorage/Model.rbxm` | 2065 | 1267 | 0 | 168x45x838 |  |
| `models/ServerScriptService/HD Admin/Core.rbxm` | 1875 | 10 | 0 | 2006x8x6 | accessory, tool, vfx |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Jungle.rbxm` | 1503 | 1111 | 56 | 230x8x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Volcano.rbxm` | 1262 | 1135 | 80 | 379x22x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Desert.rbxm` | 1220 | 1114 | 59 | 205x8x151 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Cosmic.rbxm` | 1170 | 1090 | 32 | 638x30x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Abyss Ocean.rbxm` | 1135 | 1072 | 9 | 423x14x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Snow.rbxm` | 1132 | 1071 | 16 | 318x14x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Lake.rbxm` | 1122 | 1067 | 13 | 140x5x150 | character, map |
| `models/Workspace/__OBJECTS/Areas/GuardAreas/Forest.rbxm` | 1121 | 1066 | 11 | 93x4x151 | character, map |
| `models/ReplicatedStorage/AssetModels/Crocodile.rbxm` | 455 | 57 | 54 | 6x4x28 | character |
| `models/ReplicatedStorage/AssetModels/Tiger.rbxm` | 410 | 59 | 56 | 5x5x10 | character |
| `models/ReplicatedStorage/AssetModels/TyrannosaurusRex.rbxm` | 398 | 55 | 51 | 12x21x41 | character |
| `models/ReplicatedStorage/AssetModels/Warden.rbxm` | 321 | 45 | 41 | 18x21x161 | character |
| `models/ReplicatedStorage/AssetModels/Ice Dragon.rbxm` | 277 | 15 | 11 | 60x24x41 | character |
| `models/ReplicatedStorage/AssetModels/Dragon.rbxm` | 277 | 15 | 11 | 60x28x42 | character |
| `models/Workspace/Plots/4.rbxm` | 231 | 126 | 0 | 77x45x54 | building |
| `models/Workspace/Plots/2.rbxm` | 231 | 126 | 0 | 77x45x54 | building |
| `models/Workspace/Plots/1.rbxm` | 231 | 126 | 0 | 77x45x54 | building |
| `models/Workspace/Plots/6.rbxm` | 230 | 126 | 0 | 54x45x77 | building |
| `models/ReplicatedStorage/AssetModels/Mosasaurus.rbxm` | 229 | 14 | 11 | 25x25x79 | character |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/Shop/init.lua` | 497 | 59 |
| `ui/ReplicatedStorage/Elements.lua` | 264 | 30 |
| `ui/StarterGui/TreadmillSpeedShop.lua` | 247 | 30 |
| `ui/StarterGui/Elements2.lua` | 234 | 22 |
| `ui/StarterGui/Elements.lua` | 224 | 23 |
| `ui/StarterGui/Index.lua` | 192 | 27 |
| `ui/StarterGui/TreadmillScreenComments.lua` | 174 | 9 |
| `ui/StarterGui/AdminPanel.lua` | 128 | 5 |
| `ui/StarterGui/TradeWindow.lua` | 125 | 14 |
| `ui/StarterGui/Notifications.lua` | 107 | 13 |
| `ui/StarterGui/_MACHINES.lua` | 107 | 13 |
| `ui/StarterGui/Money.lua` | 95 | 4 |
| `ui/StarterGui/FuseMachine.lua` | 94 | 21 |
| `ui/StarterGui/Rebirth.lua` | 75 | 16 |
| `ui/StarterGui/FreeGifts.lua` | 62 | 12 |
| `ui/StarterGui/_MISC.lua` | 60 | 9 |
| `ui/StarterGui/OfflineCashAndAssetLevelGrew.lua` | 58 | 10 |
| `ui/StarterGui/Message.lua` | 55 | 14 |
| `ui/StarterGui/TrailShop.lua` | 53 | 11 |
| `ui/StarterGui/TreadmillShop.lua` | 53 | 10 |
| `ui/StarterGui/monetizationGUI.lua` | 52 | 9 |
| `ui/StarterGui/PetList.lua` | 51 | 6 |
| `ui/StarterGui/StealDnaMessage.lua` | 51 | 12 |
| `ui/StarterGui/BackpackGui.lua` | 49 | 10 |
| `ui/StarterGui/GroupReward.lua` | 49 | 13 |
| `ui/StarterGui/GrowingEggList.lua` | 45 | 7 |
| `ui/StarterGui/LimitedStarterPackOffer.lua` | 45 | 11 |
| `ui/StarterGui/GearShop.lua` | 42 | 13 |
| `ui/StarterGui/Settings.lua` | 42 | 8 |
| `ui/StarterGui/Odds_UI.lua` | 40 | 4 |
| `ui/StarterGui/Troll.lua` | 37 | 2 |
| `ui/ReplicatedStorage/Assets/UI/DropTable/DropInfo.lua` | 37 | 1 |
| `ui/StarterGui/LikeBoardGui.lua` | 36 | 5 |
| `ui/ReplicatedStorage/Assets/UI/Notifications/Top/GlobalEvent.lua` | 36 | 5 |
| `ui/StarterGui/TradePlayerList.lua` | 33 | 7 |
| `ui/ReplicatedStorage/Assets/Billboards/GateHUD.lua` | 33 | 6 |
| `ui/StarterGui/RunCharge.lua` | 31 | 3 |
| `ui/ReplicatedStorage/Assets/UI/Tutorial/TutorialTask.lua` | 30 | 4 |
| `ui/ReplicatedStorage/Assets/Interface/Buy/GearTemplate.lua` | 28 | 3 |
| `ui/StarterGui/OfflineCashOnly.lua` | 27 | 5 |
