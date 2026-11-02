# Forsaken (alt copy)

- Genre: asymmetric horror (killer vs survivors)
- Source file: `Forsaken.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 824 files, 16676 KB (60 duplicates skipped, 31 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 187 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 611 models, 34 part sets, 9 vfx sets | mirrors the source tree |
| `animations/` | 1 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 74 Animation ids |
| `audio/` | 16 | `Sounds.lua` lists 740 Sound ids |

## Model tags

character (433), accessory (308), map (241), vfx (58), interior (45), building (29), hud (21), nature (19), popup (18), ability (16), tool (12), decoration (12), backup (9), weapon (8), shop (5), inventory (4), loading (2), settings (1), egg (1), collectible (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/Assets/Maps/PirateBay/Map.rbxm` | 9037 | 5069 | 148 | 1566x244x1703 | accessory, map |
| `models/ServerStorage/Assets/Maps/BrandonWorks/Map.rbxm` | 5187 | 3145 | 25 | 636x206x596 | character, map |
| `models/ServerStorage/Assets/Maps/YoricksRestingPlace/Map.rbxm` | 4954 | 2985 | 353 | 438x209x455 | map |
| `models/ServerStorage/Assets/Maps/UndergroundWar/Map.rbxm` | 4279 | 3881 | 40 | 230x79x368 | map |
| `models/Workspace/Map/Lobby/Environment.rbxm` | 3516 | 2223 | 373 | 808x515x1284 | map |
| `models/ServerStorage/Assets/Maps/C00lCarnival/Map.rbxm` | 2949 | 2382 | 27 | 482x201x427 | map |
| `models/ServerStorage/Assets/Maps/GlassHouses/Map.rbxm` | 2785 | 1604 | 6 | 529x188x574 | building, map |
| `models/ServerStorage/Assets/Actors/Skins/Killer/__KillerNoli/ClassicNoli/Rig.rbxm` | 2285 | 19 | 9 | 188x6x96 | accessory, character |
| `models/Workspace/Map/Lobby/NPCs/Grandfather Clock.rbxm` | 874 | 142 | 0 | 2x10x2 | character, map |
| `models/ServerStorage/Assets/Maps/HorrorHotel/Map/IDK.rbxm` | 650 | 313 | 26 | 259x76x330 | map |
| `models/ServerStorage/Assets/Instances/KillerBackgrounds/Intro/Jason/Default.rbxm` | 617 | 221 | 0 | 82x12x109 | character |
| `models/ServerStorage/Assets/Maps/HorrorHotel/Map/Theater.rbxm` | 456 | 158 | 0 | 53x21x169 | character, map |
| `models/ServerStorage/Assets/Actors/Killer/KillerKing/Rig.rbxm` | 446 | 174 | 0 | 32x27x28 | character |
| `models/ServerStorage/Assets/Maps/HorrorHotel/Map/Arcade.rbxm` | 426 | 303 | 0 | 157x66x204 | map |
| `models/ServerStorage/Assets/Actors/Skins/Survivor/Elliot/FriendElliot/Rig.rbxm` | 382 | 47 | 29 | 4x6x3 | accessory, character |
| `models/ServerStorage/Assets/Actors/Killer/__KillerSlenderman/Rig.rbxm` | 323 | 3 | 2 | 19x12x4 | character |
| `models/ServerStorage/Assets/Maps/Planet Voss/Map/BlueUFO/Part~97.rbxm` | 312 | 1 | 0 | 397x22x444 | map |
| `models/ServerStorage/Assets/Maps/HorrorHotel/Map/Uncollideds.rbxm` | 302 | 124 | 0 | 302x73x358 | map |
| `models/ServerStorage/Assets/Instances/KillerBackgrounds/Intro/c00lkidd/Default.rbxm` | 267 | 209 | 0 | 126x208x126 | character |
| `models/ServerStorage/Assets/Maps/HorrorHotel/Map/Slender.rbxm` | 261 | 169 | 25 | 342x147x243 | map |
| `models/ServerStorage/Assets/Actors/Skins/Killer/JohnDoe/PoachedJohnDoe/Rig.rbxm` | 253 | 66 | 42 | 46x8x38 | accessory, character |
| `models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Structures/Jungle Gyms/Rock Formation~2.rbxm` | 243 | 163 | 0 | 54x42x98 | building, map, nature |
| `models/ServerStorage/Assets/Actors/Skins/Killer/JohnDoe/GasharpoonJohnDoe/Rig.rbxm` | 229 | 54 | 23 | 6x8x3 | accessory, character |
| `models/ServerStorage/Assets/Actors/Killer/__KillerGuest666/Rig.rbxm` | 229 | 75 | 41 | 21x13x14 | character |
| `models/ServerStorage/Assets/Actors/Skins/Killer/1x1x1x1/Betrayed1x1x1x1/Rig.rbxm` | 219 | 22 | 0 | 4x6x4 | accessory, character |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ReplicatedStorage/Systems/Player/UI/SidebarHandler/Sidebar.lua` | 65 | 16 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Shop/ShopScreen.lua` | 43 | 14 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Inventory/InventoryScreen.lua` | 43 | 15 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Inventory/Templates/EmoteMenuHolder.lua` | 36 | 1 |
| `ui/ReplicatedStorage/Systems/Player/Networks/RoundNetwork/EndScreen.lua` | 28 | 6 |
| `ui/ReplicatedStorage/Modules/PlayerList/PlayerStats.lua` | 22 | 7 |
| `ui/ReplicatedStorage/Systems/Character/Game/PlayerInfoDisplay/PlayerInfo.lua` | 18 | 6 |
| `ui/ReplicatedStorage/Assets/UI/PromptThemes/Default.lua` | 16 | 0 |
| `ui/ReplicatedStorage/Assets/UI/PromptThemes/Dialog.lua` | 13 | 2 |
| `ui/ReplicatedStorage/Assets/UI/PromptThemes/Item.lua` | 13 | 2 |
| `ui/ReplicatedStorage/Assets/UI/PromptThemes/Styled.lua` | 13 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Achievements/Templates/Achievement.lua` | 13 | 3 |
| `ui/ReplicatedStorage/Systems/Player/UI/DialogHandler/DialogMain.lua` | 11 | 2 |
| `ui/ReplicatedStorage/Modules/Notifications/NotificationTemplates/Default.lua` | 9 | 3 |
| `ui/ReplicatedStorage/Modules/Spectating/Spectate.lua` | 8 | 1 |
| `ui/ReplicatedStorage/Modules/Notifications/NotificationTemplates/Achievement.lua` | 8 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Templates/ConfirmPurchase.lua` | 8 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Settings/Templates/String/Dropdown.lua` | 8 | 3 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Inventory/Templates/EmoteEquipMenu.lua` | 8 | 3 |
| `ui/ReplicatedStorage/Systems/Player/UI/Misc/UpdateLog/Presets/UpdatePreset.lua` | 8 | 0 |
| `ui/ReplicatedStorage/Systems/Character/Game/Emotes/EmoteMenuHolder.lua` | 8 | 2 |
| `ui/ReplicatedStorage/Assets/Survivors/TwoTime/Config/Sidebar.lua` | 7 | 4 |
| `ui/ReplicatedStorage/Assets/Survivors/TwoTime/Config/Sidebarbackupbackup.lua` | 7 | 4 |
| `ui/ReplicatedStorage/Assets/Survivors/TwoTimeButOp/Config/Sidebar.lua` | 7 | 4 |
| `ui/ReplicatedStorage/Assets/Survivors/TwoTimeButOp/Config/Sidebarbackupbackup.lua` | 7 | 4 |
| `ui/ReplicatedStorage/Assets/UI/AbilityIcon.lua` | 7 | 0 |
| `ui/ReplicatedStorage/Modules/PlayerList/PlayerListHolder.lua` | 7 | 1 |
| `ui/ReplicatedStorage/Modules/MapVoting/MapVoting.lua` | 7 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Templates/CardTemplate.lua` | 7 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Tabs/Robux/ProductCardTemplate.lua` | 7 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Settings/Templates/Number/Slider.lua` | 7 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Inventory/Templates/CardTemplate.lua` | 7 | 3 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/ModPanel/Templates/StringParameter.lua` | 7 | 3 |
| `ui/ReplicatedStorage/Modules/Misc/FlowGameManager/PuzzleUI.lua` | 6 | 1 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Settings/Templates/Keybind/KeybindFrame.lua` | 6 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/Achievements/AchievementsScreen.lua` | 6 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/ModPanel/Templates/NumberParameter.lua` | 6 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Menus/ModPanel/Templates/Command.lua` | 6 | 2 |
| `ui/ReplicatedStorage/Systems/Player/UI/Misc/UpdateLog/UpdateScreen.lua` | 6 | 2 |
| `ui/ReplicatedStorage/Systems/Character/Game/PlayerInfoDisplay/SurvivorFrame.lua` | 6 | 2 |
