# Bee Swarm Simulator (remake)

- Genre: collecting simulator
- Source file: `Bee20Sim(1).rbxl`
- Provenance: template with full source
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 838 files, 23757 KB (11 duplicates skipped, 126 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 47 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 739 models, 6 part sets, 3 vfx sets | mirrors the source tree |
| `animations/` | 18 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 37 Animation ids |
| `audio/` | 4 | `Sounds.lua` lists 17 Sound ids |

## Model tags

map (125), pet (85), building (81), tool (68), backup (67), character (59), nature (59), accessory (51), decoration (49), vfx (11), vehicle (10), weapon (5), hud (4), egg (3), ability (2), sign (2), quest (1), popup (1), collectible (1), portal (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ServerStorage/RBX_ANIMSAVES.rbxm` | 670 | 0 | 0 |  |  |
| `models/Workspace/MasterBearDecor.rbxm` | 353 | 143 | 94 | 772x204x897 | decoration |
| `models/Workspace/greenhouse.rbxm` | 324 | 73 | 63 | 99x58x115 |  |
| `models/Workspace/TestStuffRemoveLater/Rig.rbxm` | 238 | 16 | 15 | 4x5x1 | backup, character |
| `models/Workspace/CraftingTable.rbxm` | 195 | 40 | 39 | 32x23x25 |  |
| `models/Workspace/RedHQ.rbxm` | 170 | 137 | 46 | 254x120x180 |  |
| `models/Workspace/FieldDecorations/BlueFlowersField.rbxm` | 169 | 168 | 168 | 124x47x107 | decoration, nature |
| `models/Workspace/BlueHQ.rbxm` | 160 | 131 | 30 | 86x161x113 |  |
| `models/Workspace/Cooking Spot/Model.rbxm` | 139 | 44 | 42 | 23x24x40 |  |
| `models/Workspace/FieldDecorations/RedFlowersField.rbxm` | 101 | 100 | 100 | 68x62x129 | decoration, nature |
| `models/Workspace/AntSimIsShit=true/Dummy.rbxm` | 87 | 16 | 14 | 1x5x4 | character |
| `models/ReplicatedStorage/Assets/Mobs/Ladybug2.rbxm` | 78 | 50 | 0 | 12x8x15 | character |
| `models/Workspace/Caramel.rbxm` | 76 | 49 | 47 | 108x84x97 | character |
| `models/Workspace/SummerEvent.rbxm` | 74 | 61 | 61 | 104x47x78 |  |
| `models/Workspace/BlenderModels/No model/Grill.rbxm` | 64 | 59 | 59 | 62x54x107 |  |
| `models/Workspace/FieldDecorations/WatermelonField.rbxm` | 61 | 60 | 60 | 145x46x119 | decoration |
| `models/ServerScriptService/Assets/Sowers/Classic.rbxm` | 57 | 21 | 0 | 7x7x7 |  |
| `models/Workspace/FieldDecorations/TomatoField.rbxm` | 49 | 48 | 48 | 96x36x107 | decoration |
| `models/ServerStorage/Assets/MTopShop.rbxm` | 47 | 9 | 0 | 48x5x62 | building |
| `models/ReplicatedStorage/Bees/Corn/Gifted.rbxm` | 45 | 11 | 9 | 3x2x2 | character, pet |
| `models/ReplicatedStorage/Bees/Corn/Model.rbxm` | 45 | 11 | 9 | 3x2x2 | character, pet |
| `models/Workspace/Mechanic.rbxm` | 44 | 19 | 17 | 25x30x27 | character |
| `models/Workspace/Bears/Bear~2.rbxm` | 40 | 15 | 14 | 22x26x21 | character |
| `models/ReplicatedStorage/Bees/Barbel/Gifted.rbxm` | 39 | 5 | 4 | 2x1x3 | character, pet, vfx |
| `models/ReplicatedStorage/Bees/Barbel/Model.rbxm` | 39 | 5 | 4 | 2x1x3 | character, pet, vfx |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ReplicatedStorage/StarterGui/UI/init.lua` | 456 | 48 |
| `ui/ServerStorage/Developer/Tab/Dev/Codes Management.lua` | 46 | 4 |
| `ui/ServerStorage/Developer/Tab/Dev/Create Codes.lua` | 45 | 2 |
| `ui/ServerStorage/Developer/Tab/Developer Menu.lua` | 20 | 1 |
| `ui/StarterGui/questgui.lua` | 18 | 1 |
| `ui/ServerScriptService/Modules/HivesManager/BeePopUp.lua` | 14 | 2 |
| `ui/ReplicatedStorage/Modules/HivesManager/BeePopUp.lua` | 12 | 2 |
| `ui/StarterGui/DELETE ME.lua` | 8 | 1 |
| `ui/ReplicatedStorage/Modules/HivesManager/BeePopup2.lua` | 8 | 0 |
| `ui/ServerScriptService/Modules/HivesManager/BeePopup2.lua` | 8 | 0 |
| `ui/ReplicatedStorage/Modules/UI/Quests2/Quest.lua` | 6 | 1 |
| `ui/ReplicatedStorage/Assets/CodeExample.lua` | 6 | 0 |
| `ui/ReplicatedStorage/Assets/BoostExample.lua` | 5 | 1 |
| `ui/ReplicatedStorage/Assets/ItemExample.lua` | 5 | 1 |
| `ui/ReplicatedStorage/Modules/UI/Shops2/Item.lua` | 4 | 2 |
| `ui/ReplicatedStorage/Assets/StatExample.lua` | 4 | 2 |
| `ui/ReplicatedStorage/Assets/PlayerExample.lua` | 4 | 1 |
| `ui/ReplicatedStorage/Assets/FieldExample.lua` | 4 | 1 |
| `ui/ReplicatedStorage/Modules/UI/Quests2/Template.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Modules/UI/Quests2/Task.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Modules/UI/Quests2/Quest2.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Modules/UI/Quests2/Quest22.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Modules/NEWAlerts/Template.lua` | 3 | 1 |
| `ui/ReplicatedStorage/Assets/OptionExample.lua` | 3 | 1 |
| `ui/ServerScriptService/Server/Sprouts/HpUI.lua` | 3 | 0 |
| `ui/ServerStorage/UIGridLayout/Template.lua` | 3 | 2 |
| `ui/ServerStorage/Equipped.lua` | 3 | 1 |
| `ui/ServerStorage/Have.lua` | 3 | 1 |
| `ui/StarterGui/TEST.lua` | 2 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/AllVisual/ui.lua` | 2 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/AllVisual/Icon.lua` | 2 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/AllVisual/TL.lua` | 2 | 0 |
| `ui/ReplicatedStorage/Modules/Alerts/Template.lua` | 2 | 0 |
| `ui/ReplicatedStorage/Modules/UI/Shops2/CItemTemplate.lua` | 2 | 1 |
| `ui/ReplicatedStorage/Assets/Right.lua` | 2 | 0 |
| `ui/ReplicatedStorage/Assets/Left.lua` | 2 | 0 |
| `ui/ServerStorage/Developer/Button/Developer Menu.lua` | 2 | 2 |
| `ui/StarterGui/ScreenGui.lua` | 1 | 0 |
| `ui/TextChatService/BubbleChatConfiguration/ImageLabel.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/SproutExample.lua` | 1 | 0 |
