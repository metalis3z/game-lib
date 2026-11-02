# Brainrot Lab

- Genre: brainrot simulator (lab / fusing)
- Source file: `brainrotlabfullworkingspoof.rbxl`
- Provenance: template with full source
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 502 files, 6689 KB (6 duplicates skipped, 62 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 24 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 194 models, 0 part sets, 5 vfx sets | mirrors the source tree |
| `animations/` | 200 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 130 Animation ids |
| `audio/` | 67 | `Sounds.lua` lists 86 Sound ids |

## Model tags

tool (194), pet (121), building (93), character (80), accessory (35), vfx (10), hud (8), upgrade (3), trade (3), popup (2), index (1), leaderboard (1), map (1), nature (1), sign (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ReplicatedStorage/Templates/KickRig.rbxm` | 8838 | 16 | 14 | 4x5x1 | character |
| `models/ServerStorage/RBX_ANIMSAVES.rbxm` | 4924 | 0 | 0 |  |  |
| `models/ReplicatedStorage/Templates/SquatRig.rbxm` | 2497 | 16 | 14 | 4x5x1 | character |
| `models/ReplicatedStorage/Eventos/Lava.rbxm` | 2010 | 1204 | 289 | 2085x2176x1822 |  |
| `models/ReplicatedStorage/Bases Skins/Base (Strawberry).rbxm` | 796 | 555 | 0 | 70x104x104 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Meowl).rbxm` | 760 | 518 | 0 | 57x101x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Custom).rbxm` | 759 | 518 | 0 | 57x101x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Smurf).rbxm` | 736 | 498 | 0 | 68x98x102 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Lava).rbxm` | 731 | 494 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Diamond).rbxm` | 710 | 474 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Rainbow).rbxm` | 710 | 474 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (LCW).rbxm` | 710 | 474 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Galaxy).rbxm` | 710 | 474 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Default).rbxm` | 710 | 474 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Gold).rbxm` | 710 | 474 | 0 | 57x88x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Aquatic 2 floors.rbxm` | 659 | 477 | 121 | 57x65x93 | accessory, building |
| `models/ReplicatedStorage/Templates/Plot.rbxm` | 658 | 552 | 0 | 54x76x59 | building |
| `models/ReplicatedStorage/Bases Skins/Base (Cyberpunk).rbxm` | 649 | 575 | 9 | 57x88x95 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Base (Futuristic).rbxm` | 649 | 575 | 9 | 57x88x95 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Strawberry 2 floors.rbxm` | 617 | 437 | 0 | 70x79x104 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Meowl 2 floors.rbxm` | 581 | 400 | 0 | 57x78x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Custom 2 floors.rbxm` | 581 | 400 | 0 | 57x77x93 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Smurf 2 floors.rbxm` | 568 | 391 | 0 | 68x84x102 | accessory, building |
| `models/ReplicatedStorage/Bases Skins/Lava 2 floors.rbxm` | 552 | 376 | 0 | 57x66x93 | accessory, building |
| `models/ReplicatedStorage/Eventos/Love.rbxm` | 551 | 334 | 42 | 2085x2108x1822 |  |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/GUI/init.lua` | 949 | 40 |
| `ui/StarterGui/Trade.lua` | 99 | 5 |
| `ui/StarterGui/UI.lua` | 55 | 17 |
| `ui/StarterGui/UI Trade machine.lua` | 27 | 5 |
| `ui/ReplicatedStorage/Templates/Brainrot_UI.lua` | 25 | 16 |
| `ui/StarterGui/NotificaçãodeTrade.lua` | 20 | 3 |
| `ui/ReplicatedStorage/Templates/UpgradeTemplate.lua` | 18 | 4 |
| `ui/ReplicatedStorage/Templates/WeightTemplate.lua` | 12 | 3 |
| `ui/StarterGui/PlotUpgradeGUI.lua` | 7 | 2 |
| `ui/ReplicatedStorage/Templates/CustomPrompt.lua` | 6 | 1 |
| `ui/ReplicatedStorage/Templates/UpgradeGUI.lua` | 6 | 2 |
| `ui/ReplicatedStorage/Templates/InfoGUI.lua` | 6 | 0 |
| `ui/ReplicatedStorage/Templates/IndexTemplate.lua` | 5 | 1 |
| `ui/ReplicatedStorage/Templates/CollectGUI.lua` | 4 | 1 |
| `ui/ReplicatedStorage/Templates/LeaderboardEntry.lua` | 4 | 0 |
| `ui/ReplicatedStorage/Templates/PopUpPower.lua` | 3 | 1 |
| `ui/ReplicatedStorage/Templates/PopUp.lua` | 3 | 1 |
| `ui/ReplicatedStorage/Templates/PlayerMarker.lua` | 2 | 0 |
| `ui/ReplicatedStorage/Templates/Checkpoint.lua` | 2 | 0 |
| `ui/TextChatService/BubbleChatConfiguration/ImageLabel.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Templates/ZoneText.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Templates/NotificationTemplate.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Templates/ShineEffectTemplate.lua` | 1 | 1 |
