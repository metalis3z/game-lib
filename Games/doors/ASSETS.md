# Doors (fully scripted)

- Genre: horror / room escape
- Source file: `Doors Fully Scripted Game (1).rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 449 files, 28308 KB (37 duplicates skipped, 1813 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 11 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 336 models, 2 part sets, 2 vfx sets | mirrors the source tree |
| `animations/` | 58 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 2131 Animation ids |
| `audio/` | 59 | `Sounds.lua` lists 5758 Sound ids |

## Model tags

interior (173), character (142), tool (44), vfx (31), keyboard (21), backup (20), hud (7), cutscene (6), building (5), nature (4), decoration (4), collectible (3), loading (2), vehicle (2), map (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerScriptService/Server/Special/Hotel_ElevatorRoom.rbxm` | 30831 | 1182 | 474 | 1410x1394x2559 | character, interior |
| `models/ServerScriptService/Server/Special/Hotel_FigureLibrary.rbxm` | 28598 | 1929 | 773 | 170x293x185 | character |
| `models/ServerScriptService/Server/Special/Hotel_JeffShop.rbxm` | 27044 | 324 | 152 | 100x59x65 | building, character |
| `models/ServerScriptService/Server/Assets/ClearedRooms/52.rbxm` | 24715 | 356 | 163 | 65x59x100 | character, interior |
| `models/ServerScriptService/Server/Assets/Debris/39.rbxm` | 17942 | 440 | 148 | 161x73x70 | character |
| `models/ServerScriptService/Server/Assets/Entities/SeekMoving[OLD].rbxm` | 13079 | 16 | 15 | 10x10x10 | backup, character |
| `models/ServerScriptService/Server/Assets/Entities/SeekMoving.rbxm` | 4236 | 18 | 16 | 98x24x29 | character |
| `models/ServerScriptService/Server/Assets/Debris/Rig.rbxm` | 3312 | 16 | 15 | 4x5x1 | character |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_Corner_Keyroom/Hotel_Corner_Keyroom1.rbxm` | 2467 | 1248 | 561 | 188x56x200 | character, interior |
| `models/ServerScriptService/Server/Special/Hotel_Courtyard.rbxm` | 2167 | 1429 | 820 | 318x84x261 |  |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_Rectangular/Hotel_Rectangular4.rbxm` | 2002 | 918 | 404 | 120x33x121 | character, interior |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_Rectangular/Hotel_Rectangular3.rbxm` | 2000 | 917 | 404 | 121x33x121 | character, interior |
| `models/ServerScriptService/Server/Assets/Achievement.rbxm` | 1958 | 1177 | 258 | 731x519x1155 |  |
| `models/ServerScriptService/Server/Assets/Debris/38.rbxm` | 1944 | 507 | 224 | 81x33x81 |  |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_Rectangular/Hotel_Rectangular2.rbxm` | 1610 | 803 | 350 | 120x33x121 | interior |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_Rectangular/Hotel_Rectangular1.rbxm` | 1608 | 802 | 350 | 121x33x121 | interior |
| `models/ServerScriptService/Server/Special/SeekRooms/RunningRooms/LastSeekRoom.rbxm` | 1492 | 603 | 292 | 70x73x173 | character, interior |
| `models/ServerScriptService/Server/Special/SeekRooms/RunningRooms/NextInHallway.rbxm` | 1357 | 439 | 223 | 64x73x162 | character, interior |
| `models/ServerStorage/RBX_ANIMSAVES.rbxm` | 1351 | 0 | 0 |  |  |
| `models/ServerScriptService/Server/Special/Hotel_HaltsCorridor.rbxm` | 1225 | 444 | 296 | 333x50x38 |  |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_TwoFloorRoom/Hotel_TwoFloorRoom2.rbxm` | 1200 | 634 | 147 | 85x81x124 | character, interior |
| `models/ServerScriptService/Server/DifficultyRooms/3/Hotel_TwoFloorRoom/Hotel_TwoFloorRoom3.rbxm` | 1200 | 634 | 147 | 85x81x124 | character, interior |
| `models/ServerScriptService/Server/Special/Hotel_Bayourd.rbxm` | 1169 | 397 | 213 | 82x54x65 | character |
| `models/ServerScriptService/Server/Rooms/Hotel_HallwayLong/Hotel_HallwayLong4.rbxm` | 1146 | 490 | 169 | 65x62x161 | character, interior |
| `models/ServerScriptService/Server/Rooms/Hotel_HallwayLong/Hotel_HallwayLong3.rbxm` | 1144 | 488 | 169 | 65x62x161 | character, interior |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/MainUI/init.lua` | 1530 | 142 |
| `ui/StarterGui/PermUI.lua` | 36 | 12 |
| `ui/ReplicatedStorage/NameUIOld.lua` | 25 | 2 |
| `ui/ReplicatedStorage/NameUI.lua` | 14 | 2 |
| `ui/StarterGui/CustomUI.lua` | 9 | 0 |
| `ui/StarterGui/TableUI.lua` | 2 | 0 |
| `ui/ReplicatedFirst/LoadingUI.lua` | 2 | 0 |
| `ui/ReplicatedFirst/LoadingUINew.lua` | 2 | 0 |
| `ui/ReplicatedStorage/TranslationPointUI.lua` | 2 | 0 |
| `ui/ServerScriptService/Game/Directory/RoomGeneration/Duped.lua` | 1 | 1 |
