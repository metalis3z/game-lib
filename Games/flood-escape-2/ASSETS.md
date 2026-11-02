# Flood Escape 2

- Genre: obby / survival (rising water maps)
- Source file: `Flood Escape 2 🌊.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 1119 files, 10769 KB (195 duplicates skipped, 373 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 25 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 921 models, 201 part sets, 155 vfx sets | mirrors the source tree |
| `animations/` | 0 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 9 Animation ids |
| `audio/` | 3 | `Sounds.lua` lists 64 Sound ids |

## Model tags

tool (1055), vfx (410), accessory (366), character (28), map (15), hud (12), backup (10), ability (6), nature (6), vehicle (1), pet (1), portal (1), building (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/Maps/6Decaying Silo V3.rbxm` | 14087 | 8160 | 977 | 1013x773x1079 | map |
| `models/ServerStorage/Maps/6Rustic Jungle.rbxm` | 6397 | 4928 | 1125 | 3323x1190x4016 | map |
| `models/ServerStorage/Maps/5Blue Moon.rbxm` | 4482 | 2253 | 82 | 1258x1190x1518 | map |
| `models/ServerStorage/Maps/5Abyss Base.rbxm` | 3956 | 1128 | 0 | 169x417x617 | building, map |
| `models/Workspace/Lobby.rbxm` | 2395 | 814 | 0 | 148x143x236 | accessory, character, map |
| `models/ServerStorage/ADDEDCUSTOM/Lobby.rbxm` | 1818 | 364 | 0 | 272x1141x327 | accessory, character, map |
| `models/ServerStorage/Maps/3CrystalCaverns.rbxm` | 1805 | 1485 | 0 | 667x668x557 | map |
| `models/ServerStorage/Maps/4FamiliarRuins.rbxm` | 1796 | 1217 | 0 | 245x226x342 | map |
| `models/ServerStorage/Maps/1LostWoods.rbxm` | 1794 | 1610 | 0 | 556x324x452 | map |
| `models/ServerStorage/Maps/4DarkSci.rbxm` | 1676 | 880 | 0 | 244x531x187 | map |
| `models/ServerStorage/Maps/4AbandonedFacility.rbxm` | 1675 | 1246 | 0 | 194x375x208 | map |
| `models/ServerStorage/Maps/1MapMakingKit.rbxm` | 1443 | 692 | 2 | 600x482x600 | accessory, character, map |
| `models/ServerStorage/Maps/2MapMakingKit.rbxm` | 1443 | 692 | 2 | 600x482x600 | accessory, character, map |
| `models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/2_BG_BeneathTheRuins.rbxm` | 806 | 621 | 0 | 156x93x220 | ability |
| `models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/3_BG_FloodIsland.rbxm` | 738 | 514 | 0 | 1152x257x1230 | ability, map |
| `models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/4_BG_DarkSciFacility.rbxm` | 609 | 264 | 0 | 80x309x100 | ability |
| `models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/DefaultTitle.rbxm` | 354 | 198 | 0 | 106x60x122 | ability, character |
| `models/ReplicatedStorage/TitleScreenResources/UnusedTitles/5_BG_BuriedOasis.rbxm` | 179 | 147 | 9 | 94x43x42 | ability, backup |
| `models/ReplicatedStorage/Items/Tanks/204.rbxm` | 71 | 19 | 0 | 2x2x2 | tool |
| `models/ServerScriptService/SV_MAIN_GameScript/_Rescue.rbxm` | 61 | 11 | 0 | 8x6x8 | character |
| `models/ReplicatedStorage/Items/Buddies/41.rbxm` | 59 | 10 | 0 | 2x2x1 | accessory, character, tool |
| `models/ReplicatedStorage/Items/Tanks/155.rbxm` | 56 | 20 | 0 | 5x5x2 | tool |
| `models/ReplicatedStorage/Items/Tanks/539.rbxm` | 54 | 2 | 1 | 3x2x2 | tool, vfx |
| `models/ReplicatedStorage/Items/Tanks/-17.rbxm` | 51 | 16 | 0 | 2x2x2 | character, tool |
| `models/ReplicatedStorage/Items/Tanks/154.rbxm` | 51 | 16 | 0 | 4x4x2 | tool |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ServerScriptService/SV_MAIN_GameScript/MenuGui/init.lua` | 565 | 34 |
| `ui/ReplicatedStorage/GuiBackup/GameGui.lua` | 363 | 34 |
| `ui/StarterGui/GameGui.lua` | 344 | 32 |
| `ui/ServerScriptService/SV_MAIN_GameScript/MapTest.lua` | 149 | 5 |
| `ui/StarterPlayer/StarterPlayerScripts/CL_EntryScript/EntryGui.lua` | 101 | 12 |
| `ui/ReplicatedStorage/GuiBackup/FormGui.lua` | 47 | 6 |
| `ui/StarterGui/NotifGui.lua` | 24 | 2 |
| `ui/ReplicatedStorage/GuiBackup/NotifGui.lua` | 24 | 2 |
| `ui/ServerScriptService/SV_MAIN_GameScript/PlrInfo.lua` | 15 | 2 |
| `ui/StarterGui/LiftWaitVisual.lua` | 7 | 2 |
| `ui/ServerScriptService/SV_MAIN_GameScript/Marker.lua` | 7 | 2 |
| `ui/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript/Resources/MenuButton.lua` | 3 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/CL_EntryScript/PlayerButton.lua` | 3 | 0 |
| `ui/StarterGui/PerformanceStats.lua` | 2 | 0 |
| `ui/StarterGui/Locator.lua` | 2 | 0 |
| `ui/StarterGui/Vignette.lua` | 2 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript/Resources/QuickMenu.lua` | 2 | 0 |
| `ui/StarterPlayer/StarterCharacterScripts/CharSpecs/DropShadowUI.lua` | 2 | 0 |
| `ui/ReplicatedStorage/Items/Auras/147/Torso/Aura_Sun.lua` | 2 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript/Resources/PlayMenu.lua` | 1 | 0 |
