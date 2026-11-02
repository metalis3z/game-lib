# Murder Mystery 2

- Genre: social deduction (murderer vs sheriff)
- Source file: `New MM2 Leak.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 1038 files, 23250 KB (34 duplicates skipped, 1609 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 131 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 793 models, 12 part sets, 77 vfx sets | mirrors the source tree |
| `animations/` | 3 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 143 Animation ids |
| `audio/` | 5 | `Sounds.lua` lists 293 Sound ids |

## Model tags

map (620), vfx (82), tool (63), collectible (52), accessory (39), character (35), backup (34), interior (34), weapon (32), sign (28), hud (19), nature (16), vehicle (15), loading (10), building (10), inventory (8), keyboard (6), trade (3), shop (3), pet (3), popup (1), reward (1), leaderboard (1), egg (1), ability (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/Maps/Logcabin/Map.rbxm` | 9301 | 8475 | 5499 | 402x112x372 | map |
| `models/ServerStorage/Maps/Workshop.rbxm` | 8325 | 6105 | 2568 | 304x192x342 | accessory, character, map |
| `models/ServerStorage/Maps/SummerInfection/Map.rbxm` | 7821 | 7007 | 2927 | 955x355x1019 | map |
| `models/ServerStorage/Maps/InkopolisSquare/Map.rbxm` | 6722 | 2960 | 2 | 383x237x301 | map |
| `models/ServerStorage/OldMaps.rbxm` | 5834 | 3658 | 0 | 3319x66x1107 | backup, character, map |
| `models/ServerStorage/Maps/Factory/Map.rbxm` | 5411 | 3946 | 347 | 352x104x377 | accessory, character, map |
| `models/ServerStorage/Maps/Hotel2/Map.rbxm` | 4561 | 2867 | 19 | 241x50x87 | map |
| `models/ServerStorage/Maps/Bank/Bank/Map.rbxm` | 3821 | 3013 | 0 | 120x46x111 | character, map |
| `models/ServerStorage/Maps/Bank/Map.rbxm` | 3820 | 3013 | 0 | 120x46x111 | character, map |
| `models/ServerStorage/Maps/PoliceStation~2/Map.rbxm` | 3690 | 2996 | 0 | 147x63x185 | accessory, character, map |
| `models/ServerStorage/Maps/PoliceStation/Map.rbxm` | 3690 | 2996 | 0 | 185x63x147 | accessory, character, map |
| `models/ServerStorage/Maps/Hospital2/Map.rbxm` | 3686 | 2657 | 39 | 203x47x212 | accessory, character, map |
| `models/ServerStorage/Maps/ResearchFacility/Parts.rbxm` | 3588 | 3158 | 165 | 160x41x248 | accessory, character, map |
| `models/ServerStorage/Maps/MilBase/Map_MilitaryBase.rbxm` | 3127 | 2387 | 0 | 385x158x554 | building, character, map |
| `models/ServerStorage/Maps/Mansion/Map.rbxm` | 2713 | 1752 | 0 | 129x22x166 | map |
| `models/ServerStorage/Maps/Mansion2/Map.rbxm` | 2664 | 1961 | 38 | 223x29x160 | accessory, character, map |
| `models/ServerStorage/Jadens map.rbxm` | 2475 | 2105 | 764 | 495x610x499 | character, map |
| `models/ServerStorage/Maps/Bank2/Parts/GroundFloor.rbxm` | 2319 | 1713 | 10 | 92x34x122 | character, map |
| `models/ServerStorage/Maps/Office3/Map.rbxm` | 2209 | 1795 | 0 | 174x84x174 | character, map |
| `models/ServerStorage/Maps/Cargo.rbxm` | 2173 | 1944 | 0 | 564x297x518 | character, map |
| `models/ServerStorage/Maps/BioLab/Map_BioLab.rbxm` | 1928 | 1495 | 0 | 203x55x297 | character, map |
| `models/ServerStorage/Maps/Coliseum/Map.rbxm` | 1755 | 1681 | 0 | 158x47x157 | map |
| `models/ServerStorage/Maps/Club/Map.rbxm` | 1754 | 847 | 0 | 320x52x164 | map |
| `models/ServerStorage/Maps/Workplace/Map.rbxm` | 1736 | 1287 | 0 | 150x18x150 | map |
| `models/ServerStorage/Maps/House2/Map.rbxm` | 1415 | 1215 | 0 | 127x44x184 | map |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ReplicatedStorage/GUI/MainPC/init.lua` | 8420 | 245 |
| `ui/ReplicatedStorage/GUI/MainMobile/init.lua` | 6598 | 166 |
| `ui/StarterGui/Trade/init.lua` | 646 | 6 |
| `ui/ReplicatedStorage/GUI/MainXbox/init.lua` | 591 | 31 |
| `ui/ServerStorage/Lobby/MainLobby/FixPart/Script/ScreenGui.lua` | 487 | 35 |
| `ui/StarterGui/Shop.lua` | 454 | 34 |
| `ui/StarterGui/TradeGUI_Phone.lua` | 330 | 6 |
| `ui/StarterPlayer/StarterPlayerScripts/Scoreboard/Scoreboard.lua` | 303 | 11 |
| `ui/StarterPlayer/StarterPlayerScripts/Scoreboard/Scoreboard_Phone.lua` | 250 | 11 |
| `ui/StarterPlayer/StarterPlayerScripts/GameplayAnimations/Victory.lua` | 131 | 8 |
| `ui/ServerStorage/Gems.lua` | 91 | 9 |
| `ui/ServerStorage/EventScript_Halloween2021/OpenCrate/Unboxing.lua` | 84 | 8 |
| `ui/ReplicatedStorage/Modules/BoxModule/Unboxing.lua` | 84 | 8 |
| `ui/ServerScriptService/ServerLog/Console/ConsoleGUI.lua` | 55 | 0 |
| `ui/ServerScriptService/ServerLog/ConsoleRepfirst/ConsoleGUI.lua` | 55 | 0 |
| `ui/ReplicatedStorage/Modules/BoxModule/Item.lua` | 46 | 5 |
| `ui/ReplicatedFirst/Loading/GamemodeBonus.lua` | 38 | 3 |
| `ui/ReplicatedFirst/Loading/Gamemode.lua` | 38 | 2 |
| `ui/ServerStorage/ClockworkItemPack.lua` | 33 | 13 |
| `ui/ReplicatedFirst/Loading/Join.lua` | 32 | 2 |
| `ui/ServerStorage/OldInventory/Crafting_Data/Recipe.lua` | 31 | 1 |
| `ui/ServerScriptService/Giver/GiverGui.lua` | 29 | 0 |
| `ui/StarterGui/SpawnFade.lua` | 28 | 0 |
| `ui/ServerStorage/OldInventory/Inventory_Data/Item.lua` | 28 | 3 |
| `ui/ReplicatedStorage/Modules/ShopModule/ShopTabs/NewItem.lua` | 28 | 6 |
| `ui/ReplicatedStorage/Modules/InventoryModule/NewItem.lua` | 28 | 5 |
| `ui/ReplicatedStorage/Modules/InventoryModule/Phone/NewItem.lua` | 28 | 5 |
| `ui/ReplicatedFirst/Loading/GamemodePhone.lua` | 27 | 2 |
| `ui/ServerStorage/OldInventory/Crafting_Data/Item.lua` | 27 | 3 |
| `ui/ServerStorage/OldInventory/Inventory_Data/EquipSlot.lua` | 25 | 5 |
| `ui/ReplicatedStorage/Modules/ShopModule/ViewBoxContents/NewBoxContents.lua` | 24 | 6 |
| `ui/ReplicatedStorage/Modules/ShopModule/ViewBoxContents/Phone/NewItem.lua` | 24 | 6 |
| `ui/ServerStorage/EventScript_Halloween2021/OpenCrate/Item.lua` | 22 | 4 |
| `ui/ReplicatedFirst/Loading/DeviceSelect.lua` | 21 | 2 |
| `ui/ReplicatedStorage/Modules/ShopModule/HotItems/NewHotItem.lua` | 21 | 6 |
| `ui/ReplicatedStorage/Modules/ShopModule/HotItems/Phone/HotItem.lua` | 20 | 5 |
| `ui/ServerStorage/OldInventory/Inventory_Data/Recipe.lua` | 19 | 0 |
| `ui/ServerStorage/Shirt.lua` | 19 | 0 |
| `ui/ReplicatedStorage/Modules/ShopModule/CurrentOffers/NewOffer.lua` | 19 | 6 |
| `ui/ServerScriptService/Giver/GiftGUI.lua` | 17 | 0 |
