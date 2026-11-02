# "Evade" (brainrot game)

- Genre: steal / tycoon (brainrots, lucky blocks; file named Evade)
- Source file: `Evade_New-UPD.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 5934 files, 43496 KB (147 duplicates skipped, 592 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 103 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 5340 models, 49 part sets, 13 vfx sets | mirrors the source tree |
| `animations/` | 355 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 877 Animation ids |
| `audio/` | 45 | `Sounds.lua` lists 780 Sound ids |

## Model tags

character (1047), pet (669), map (557), vfx (442), nature (285), tool (183), building (154), accessory (70), hud (41), collectible (41), road (32), decoration (26), sign (19), weapon (17), shop (9), popup (4), reward (4), vehicle (3), ability (2), rebirth (1), index (1), settings (1), backup (1), portal (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ReplicatedStorage/Controllers/EventController/Events/Extinct/Map.rbxm` | 1103 | 949 | 104 | 328x82x477 | map |
| `models/ServerStorage/Skins/GingerBread/ThirdFloor.rbxm` | 1032 | 709 | 0 | 65x54x64 | accessory |
| `models/ServerStorage/Skins/Strawberry/ThirdFloor.rbxm` | 994 | 481 | 0 | 65x61x63 | accessory |
| `models/Workspace/Skin/ThirdFloor.rbxm` | 989 | 795 | 595 | 59x59x70 | accessory |
| `models/ServerStorage/Skins/YinYang/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Radioactive/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Lava/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Halloween/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Gold/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Galaxy/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Diamond/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/Candy/ThirdFloor.rbxm` | 979 | 440 | 0 | 65x54x63 | accessory, collectible |
| `models/ReplicatedStorage/Bases/ThirdFloor.rbxm` | 947 | 445 | 0 | 65x54x63 | building |
| `models/ServerStorage/Skins/Default/ThirdFloor.rbxm` | 947 | 445 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/RBX_ANIMSAVES.rbxm` | 917 | 0 | 0 |  |  |
| `models/ServerStorage/Skins/Meowl/ThirdFloor.rbxm` | 886 | 502 | 9 | 73x65x63 | accessory |
| `models/ServerStorage/Skins/Aquatic/ThirdFloor.rbxm` | 850 | 409 | 0 | 65x54x63 | accessory |
| `models/ServerStorage/Skins/GingerBread/SecondFloor.rbxm` | 817 | 541 | 0 | 65x37x64 | accessory |
| `models/ServerStorage/Skins/Strawberry/SecondFloor.rbxm` | 731 | 353 | 0 | 65x44x63 | accessory |
| `models/ReplicatedStorage/Bases/SecondFloor.rbxm` | 685 | 317 | 0 | 65x37x63 | building |
| `models/ServerStorage/Skins/Default/SecondFloor.rbxm` | 684 | 317 | 0 | 65x37x63 | accessory |
| `models/ServerStorage/Skins/Meowl/SecondFloor.rbxm` | 652 | 361 | 9 | 73x48x63 | accessory |
| `models/ServerStorage/Skins/Radioactive/SecondFloor.rbxm` | 641 | 297 | 0 | 65x37x63 | accessory |
| `models/ServerStorage/Skins/Halloween/SecondFloor.rbxm` | 641 | 297 | 0 | 65x37x63 | accessory |
| `models/ServerStorage/Skins/Aquatic/SecondFloor.rbxm` | 641 | 297 | 0 | 65x37x63 | accessory |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ReplicatedStorage/ReplicatedGui/Shop/init.lua` | 562 | 54 |
| `ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/Admin/init.lua` | 318 | 27 |
| `ui/ReplicatedStorage/ReplicatedGui/BrainrotTrader.lua` | 155 | 12 |
| `ui/ReplicatedStorage/ReplicatedGui/ActiveEvents.lua` | 149 | 48 |
| `ui/ReplicatedStorage/ReplicatedGui/SantaMerchant.lua` | 89 | 8 |
| `ui/ReplicatedStorage/ReplicatedGui/ChristmasWheel.lua` | 82 | 18 |
| `ui/ReplicatedStorage/ReplicatedGui/GalaxyWheel.lua` | 74 | 14 |
| `ui/ReplicatedStorage/ReplicatedGui/CursedWheel.lua` | 72 | 17 |
| `ui/ReplicatedStorage/ReplicatedGui/YinYangWheel.lua` | 71 | 14 |
| `ui/ReplicatedStorage/ReplicatedGui/RadioactiveWheel.lua` | 71 | 18 |
| `ui/ReplicatedStorage/ReplicatedGui/FuseMachine.lua` | 54 | 8 |
| `ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/FakePurchases.lua` | 43 | 10 |
| `ui/ReplicatedStorage/ReplicatedGui/AdventCalendar.lua` | 42 | 6 |
| `ui/ServerScriptService/Modded/Resources/Guis/FakePurchases.lua` | 39 | 10 |
| `ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/BaseManager.lua` | 35 | 10 |
| `ui/ReplicatedStorage/ReplicatedGui/Rebirth.lua` | 34 | 8 |
| `ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/Teleport.lua` | 31 | 8 |
| `ui/ReplicatedStorage/ReplicatedGui/Index.lua` | 30 | 4 |
| `ui/ReplicatedStorage/ReplicatedGui/CoinsShop.lua` | 28 | 8 |
| `ui/ServerScriptService/Fake Purchases/FakePurchase/StartNew.lua` | 28 | 3 |
| `ui/ReplicatedStorage/ReplicatedGui/ToolGuis.lua` | 26 | 3 |
| `ui/ReplicatedStorage/ReplicatedGui/RodsShop.lua` | 26 | 7 |
| `ui/ReplicatedStorage/ReplicatedGui/CraftingMachine.lua` | 25 | 2 |
| `ui/ServerScriptService/Fake Purchases/FakePurchase/Start.lua` | 25 | 2 |
| `ui/ReplicatedStorage/ReplicatedGui/Settings.lua` | 24 | 3 |
| `ui/ReplicatedStorage/ReplicatedGui/WitchingHourMachine.lua` | 23 | 2 |
| `ui/ServerScriptService/Modded/Resources/Guis/AdminSelection.lua` | 23 | 1 |
| `ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/Saving.lua` | 23 | 7 |
| `ui/ReplicatedStorage/ReplicatedGui/SingleStockMachine.lua` | 22 | 1 |
| `ui/ReplicatedStorage/ReplicatedGui/AdminPanel.lua` | 21 | 3 |
| `ui/ServerStorage/Developmental Assets/Modded/Resources/Guis/AdminSelection.lua` | 20 | 4 |
| `ui/ReplicatedStorage/ReplicatedGui/StockMachine.lua` | 19 | 1 |
| `ui/ReplicatedStorage/ReplicatedGui/Color.lua` | 17 | 0 |
| `ui/ReplicatedStorage/ReplicatedGui/FestiveLuckyBlock.lua` | 17 | 3 |
| `ui/ReplicatedStorage/ReplicatedGui/GiftPlayer.lua` | 15 | 6 |
| `ui/ServerScriptService/Fake Purchases/FakePurchase/Finish.lua` | 15 | 1 |
| `ui/ReplicatedStorage/ReplicatedGui/LeftCenter.lua` | 14 | 7 |
| `ui/ReplicatedStorage/Controllers/EventController/Events/North Pole/SpawnerUI.lua` | 13 | 2 |
| `ui/ReplicatedStorage/ReplicatedGui/LeftBottom.lua` | 10 | 1 |
| `ui/ReplicatedStorage/ReplicatedGui/VoiceChat.lua` | 10 | 1 |
