# Miami Shootout

- Genre: open-world shooter / hood roleplay
- Source file: `Miami Shootout NEWEST GAME (1).rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 1213 files, 111444 KB (112 duplicates skipped, 5644 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 63 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 1057 models, 0 part sets, 6 vfx sets | mirrors the source tree |
| `animations/` | 32 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 437 Animation ids |
| `audio/` | 78 | `Sounds.lua` lists 2773 Sound ids |

## Model tags

tool (380), weapon (74), accessory (67), character (55), vfx (48), vehicle (32), map (23), nature (20), hud (16), building (15), sign (14), road (9), decoration (7), collectible (6), interior (4), backup (3), popup (2), ability (2), keyboard (2), inventory (1), settings (1), loading (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/Workspace/Folder~2/_.rbxm` | 9921 | 16 | 14 | 1x5x4 | character |
| `models/Workspace/Folder~25/Model~4.rbxm` | 1443 | 713 | 71 | 68x14x34 | character |
| `models/Workspace/Model~51/Model.rbxm` | 1095 | 422 | 1 | 31x31x101 |  |
| `models/Workspace/Model~45/Model.rbxm` | 1095 | 422 | 1 | 31x31x101 |  |
| `models/ServerStorage/Cars/Scat.rbxm` | 801 | 356 | 295 | 19x6x9 | character, vehicle |
| `models/ServerStorage/Cars/Police Sedan.rbxm` | 668 | 224 | 165 | 10x7x22 | vehicle |
| `models/ServerStorage/Cars/Durango.rbxm` | 629 | 291 | 244 | 22x8x11 | character, vehicle |
| `models/Workspace/Folder~2/nfgclix.rbxm` | 627 | 18 | 17 | 2x5x3 | accessory, character |
| `models/Workspace/Folder~2/lilboysteve01.rbxm` | 613 | 17 | 16 | 4x7x2 | accessory, character |
| `models/ServerStorage/Cars/Police Impala.rbxm` | 562 | 245 | 135 | 10x9x22 | vehicle |
| `models/ServerStorage/Cars/TrackHawk.rbxm` | 552 | 122 | 40 | 19x7x10 | character, vehicle |
| `models/ServerStorage/Cars/Urus.rbxm` | 543 | 173 | 137 | 20x7x10 | character, vehicle |
| `models/ServerStorage/Cars/Rolls Royce.rbxm` | 536 | 237 | 200 | 22x8x10 | character, vehicle |
| `models/Workspace/Model.rbxm` | 534 | 242 | 30 | 64x16x36 |  |
| `models/ServerStorage/Cars/Redacted/SUV.rbxm` | 524 | 160 | 105 | 10x8x21 | character, vehicle |
| `models/ServerStorage/Cars/Claren.rbxm` | 501 | 209 | 140 | 19x5x9 | character, vehicle |
| `models/ServerStorage/Cars/Coupe.rbxm` | 470 | 118 | 84 | 20x6x9 | character, vehicle |
| `models/ServerStorage/Model.rbxm` | 464 | 46 | 7 | 1x1x4 | tool |
| `models/ServerStorage/Cars/Police Explorer.rbxm` | 458 | 177 | 123 | 11x8x22 | vehicle |
| `models/ServerStorage/Cars/Police Fusion.rbxm` | 452 | 184 | 117 | 10x7x21 | vehicle |
| `models/Lighting/T91.rbxm` | 440 | 43 | 33 | 3x1x0 | tool |
| `models/ReplicatedStorage/Items/AK-47.rbxm` | 435 | 51 | 51 | 0x1x4 | tool |
| `models/ServerStorage/AK-47.rbxm` | 435 | 51 | 51 | 0x1x4 | tool |
| `models/Lighting/AK-47.rbxm` | 435 | 51 | 51 | 0x1x4 | tool |
| `models/ReplicatedStorage/Firearms/Halloween22Drum.rbxm` | 431 | 14 | 7 | 4x2x2 | tool |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/CellPhone.lua` | 63 | 9 |
| `ui/StarterGui/Notification System.lua` | 30 | 5 |
| `ui/StarterPlayer/StarterCharacterScripts/Intro/BronxLoadscreen.lua` | 30 | 5 |
| `ui/ReplicatedStorage/arrestgui.lua` | 25 | 0 |
| `ui/ServerStorage/SirenControl.lua` | 23 | 0 |
| `ui/StarterGui/ScreenGui.lua` | 20 | 1 |
| `ui/StarterGui/ScreenGui~2.lua` | 19 | 1 |
| `ui/Lighting/Assets/GUI/NYPDLL.lua` | 18 | 1 |
| `ui/Lighting/EMSGui.lua` | 15 | 2 |
| `ui/Lighting/PoliceGui.lua` | 15 | 3 |
| `ui/ServerStorage/EMSCar.lua` | 14 | 0 |
| `ui/Lighting/Assets/GUI/NYPDBase.lua` | 11 | 1 |
| `ui/StarterGui/Inventory.lua` | 10 | 0 |
| `ui/Lighting/Assets/GUI/ATMGui.lua` | 10 | 0 |
| `ui/StarterGui/SpawnerViews.lua` | 9 | 0 |
| `ui/ServerStorage/GiveCash.lua` | 9 | 0 |
| `ui/ServerScriptService/PoliceScripts/NYPDBC.lua` | 8 | 1 |
| `ui/Lighting/ModeratorNote.lua` | 8 | 0 |
| `ui/ServerStorage/CarGui.lua` | 7 | 1 |
| `ui/ServerScriptService/WeaponSpawners/Spawns/Spawner.lua` | 6 | 0 |
| `ui/Lighting/Assets/GUI/SendMoneyConfirm.lua` | 6 | 0 |
| `ui/StarterGui/Dead.lua` | 5 | 0 |
| `ui/StarterGui/Settings.lua` | 5 | 0 |
| `ui/StarterGui/MoneyGui.lua` | 5 | 1 |
| `ui/ReplicatedStorage/CallFrame.lua` | 5 | 0 |
| `ui/ReplicatedStorage/EMSLocker.lua` | 5 | 0 |
| `ui/ReplicatedStorage/PDCars.lua` | 5 | 0 |
| `ui/ReplicatedStorage/PDLocker.lua` | 5 | 0 |
| `ui/StarterGui/KillFeed.lua` | 4 | 2 |
| `ui/StarterGui/HealthGui.lua` | 4 | 1 |
| `ui/StarterGui/Hunger.lua` | 4 | 1 |
| `ui/StarterGui/Stamina.lua` | 4 | 1 |
| `ui/StarterGui/Run.lua` | 4 | 1 |
| `ui/StarterPlayer/StarterCharacterScripts/dots.lua` | 4 | 1 |
| `ui/ServerScriptService/SoftShutdown/SoftShutdown.lua` | 4 | 1 |
| `ui/ServerScriptService/PoliceScripts/Police/Gui.lua` | 4 | 0 |
| `ui/ServerScriptService/MainClient/BillboardGui.lua` | 4 | 1 |
| `ui/ReplicatedStorage/NYPDArrest.lua` | 4 | 0 |
| `ui/StarterGui/sgdb.lua` | 3 | 0 |
| `ui/ServerScriptService/Realism Mod/_me/Emote.lua` | 3 | 0 |
