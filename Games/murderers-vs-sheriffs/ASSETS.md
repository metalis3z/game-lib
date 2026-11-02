# Murderers vs Sheriffs (summer update)

- Genre: duels (murderers vs sheriffs, trading, crafting)
- Source file: `vv mmv summer upd 26 f2+ap + new upd.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 1656 files, 22323 KB (100 duplicates skipped, 1029 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 89 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 1426 models, 1 part sets, 216 vfx sets | mirrors the source tree |
| `animations/` | 1 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 187 Animation ids |
| `audio/` | 9 | `Sounds.lua` lists 210 Sound ids |

## Model tags

tool (1124), weapon (125), vfx (109), map (107), pet (94), collectible (49), backup (35), accessory (32), character (26), building (23), sign (20), hud (19), egg (18), nature (16), decoration (16), loading (11), inventory (9), ability (7), shop (4), trade (2), settings (2), portal (2), keyboard (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/Database/Maps/Yacht/Base.rbxm` | 13055 | 10234 | 3998 | 1173x220x1173 | accessory, building, character, map |
| `models/ServerStorage/Database/Maps/Pier.rbxm` | 10797 | 8843 | 2918 | 2048x200x2053 | map |
| `models/ServerStorage/Database/Maps/BeachResort/Base.rbxm` | 9985 | 8205 | 3163 | 598x233x829 | building, map |
| `models/Workspace/Lobby.rbxm` | 9346 | 5664 | 2204 | 39202x230x42415 | accessory, character, map, tool |
| `models/ServerStorage/Resources/Lobby.rbxm` | 8093 | 5555 | 2127 | 38659x230x42415 | ability, accessory, character, map, tool |
| `models/ServerStorage/Database/Maps/Factory/Map.rbxm` | 5317 | 3932 | 347 | 352x104x377 | character, map |
| `models/ServerStorage/Database/Maps/Hotel2/Base.rbxm` | 4471 | 2862 | 19 | 245x53x91 | building, map |
| `models/ServerStorage/Database/Maps/Bank2/Base.rbxm` | 4267 | 3324 | 14 | 117x52x135 | building, character, map |
| `models/ServerStorage/Database/Maps/Hospital3/Base.rbxm` | 4144 | 3035 | 11 | 130x37x186 | building, map |
| `models/ServerStorage/Database/Maps/ResearchFacility/Parts.rbxm` | 3579 | 3137 | 165 | 160x41x248 | accessory, character, map |
| `models/ServerStorage/Database/Maps/PoliceStation/Base.rbxm` | 3568 | 3047 | 0 | 154x67x193 | accessory, building, character, map |
| `models/ServerStorage/Database/Maps/MilBase/Base.rbxm` | 2953 | 2288 | 0 | 385x158x554 | building, map |
| `models/ServerStorage/Database/Maps/Office3/Base.rbxm` | 2275 | 1886 | 0 | 178x84x179 | building, character, map |
| `models/ServerStorage/Database/Maps/Mansion2/Base.rbxm` | 2236 | 1768 | 22 | 250x84x227 | building, map |
| `models/ServerStorage/Database/Maps/BioLab/Base.rbxm` | 1748 | 1530 | 0 | 224x78x322 | building, map |
| `models/ServerStorage/Database/Maps/Workplace/Base.rbxm` | 1736 | 1292 | 0 | 170x38x170 | building, map |
| `models/ServerStorage/Database/Maps/House2/Base.rbxm` | 1303 | 1145 | 0 | 136x58x194 | building, map |
| `models/ServerStorage/Database/Maps/Mansion2/Decoration_Regular.rbxm` | 364 | 206 | 16 | 174x16x138 | accessory, character, decoration, map |
| `models/ServerStorage/Database/Maps/BioLab/CoinAreas.rbxm` | 336 | 335 | 0 | 196x42x280 | collectible, map |
| `models/ServerStorage/Database/Maps/Hotel2/CoinAreas.rbxm` | 308 | 307 | 0 | 238x44x77 | collectible, map |
| `models/ServerStorage/Database/Maps/MilBase/CoinAreas.rbxm` | 296 | 295 | 0 | 195x43x280 | building, collectible, map |
| `models/ServerStorage/Database/Maps/Mansion2/CoinAreas.rbxm` | 241 | 240 | 0 | 179x15x154 | collectible, map |
| `models/ServerStorage/Gameplay/DefaultRig.rbxm` | 236 | 16 | 15 | 4x5x1 | character |
| `models/ServerStorage/Database/Maps/Yacht/CoinAreas.rbxm` | 235 | 234 | 0 | 101x42x263 | collectible, map |
| `models/ServerStorage/Database/Maps/PoliceStation/CoinAreas.rbxm` | 223 | 222 | 0 | 143x44x181 | collectible, map |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ReplicatedStorage/GUI/MainMobile/init.lua` | 5698 | 191 |
| `ui/ReplicatedStorage/GUI/MainPC/init.lua` | 3914 | 118 |
| `ui/StarterGui/CrossPlatform/init.lua` | 3790 | 131 |
| `ui/StarterGui/TradeGUI_Phone/init.lua` | 1044 | 7 |
| `ui/ReplicatedStorage/GUI/MainXbox/init.lua` | 1018 | 68 |
| `ui/StarterGui/TradeGUI/init.lua` | 644 | 7 |
| `ui/StarterGui/Scoreboard_Phone.lua` | 396 | 11 |
| `ui/StarterGui/Scoreboard.lua` | 354 | 12 |
| `ui/StarterPlayer/StarterPlayerScripts/GameplayAnimations/Victory.lua` | 326 | 8 |
| `ui/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/Profile~2.lua` | 178 | 7 |
| `ui/StarterPlayer/StarterPlayerScripts/GameplayAnimations/VictorySlideConcept.lua` | 104 | 8 |
| `ui/ServerStorage/DisabledOldAdminSystem/StarterGui/AdminSettings.lua` | 104 | 1 |
| `ui/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/Profile~3.lua` | 94 | 7 |
| `ui/StarterGui/CustomGames.lua` | 84 | 1 |
| `ui/ReplicatedStorage/Modules/BoxModule/Unboxing.lua` | 84 | 8 |
| `ui/ReplicatedStorage/ClientServices/MysteryBoxService/MysteryBoxOpen.lua` | 83 | 9 |
| `ui/ReplicatedStorage/ClientServices/MysteryBoxService/Main.lua` | 80 | 9 |
| `ui/StarterGui/GameplayControlsUI.lua` | 63 | 6 |
| `ui/ReplicatedStorage/GUI/MainNew.lua` | 61 | 16 |
| `ui/StarterGui/InteractGUI.lua` | 52 | 5 |
| `ui/ServerStorage/DisabledOldAdminSystem/StarterGui/Admin.lua` | 52 | 1 |
| `ui/StarterGui/GameTopbar.lua` | 42 | 7 |
| `ui/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/OwnerPanel.lua` | 40 | 0 |
| `ui/ReplicatedFirst/UISelector/Loading/GamemodeBonus.lua` | 38 | 3 |
| `ui/ReplicatedFirst/UISelector/Loading/Gamemode.lua` | 38 | 2 |
| `ui/ReplicatedStorage/ClientServices/EquipService/EquipContainer.lua` | 33 | 5 |
| `ui/ReplicatedFirst/UISelector/Loading/Join.lua` | 32 | 2 |
| `ui/ReplicatedStorage/Modules/InventoryModule/NewItem.lua` | 31 | 6 |
| `ui/ReplicatedStorage/Modules/InventoryModule/Phone/NewItem.lua` | 31 | 6 |
| `ui/ReplicatedStorage/ClientServices/CraftingService/CraftFrame.lua` | 30 | 3 |
| `ui/StarterGui/TouchInteractButtons.lua` | 29 | 2 |
| `ui/ReplicatedStorage/Modules/ShopModule/ShopTabs/NewItem.lua` | 28 | 6 |
| `ui/ReplicatedFirst/UISelector/Loading/GamemodePhone.lua` | 27 | 2 |
| `ui/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/Inventory/ItemOld.lua` | 27 | 5 |
| `ui/ReplicatedStorage/Modules/ViewProfileModule/TrophyItem.lua` | 26 | 5 |
| `ui/ReplicatedStorage/Modules/ViewProfileModule/ShowcaseItem.lua` | 24 | 5 |
| `ui/ReplicatedStorage/Modules/ShopModule/ViewBoxContents/NewBoxContents.lua` | 24 | 6 |
| `ui/ReplicatedStorage/Modules/ShopModule/ViewBoxContents/Phone/NewItem.lua` | 24 | 6 |
| `ui/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/InventoryPhone/NewItemOld.lua` | 24 | 5 |
| `ui/ReplicatedStorage/ClientServices/MysteryBoxService/NewItem.lua` | 22 | 6 |
