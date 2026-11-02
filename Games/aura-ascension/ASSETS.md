# Aura Ascension (UPD 3)

- Genre: RNG / aura rolling
- Source file: `AuraAscensionUPD3%20(1).rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 325 files, 4515 KB (4 duplicates skipped, 90 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 124 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 178 models, 0 part sets, 5 vfx sets | mirrors the source tree |
| `animations/` | 1 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 209 Animation ids |
| `audio/` | 7 | `Sounds.lua` lists 47 Sound ids |

## Model tags

character (126), vfx (80), map (24), hud (13), sign (7), nature (7), inventory (3), accessory (3), popup (2), loading (1), rebirth (1), decoration (1), road (1), building (1), interior (1), collectible (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/Workspace/Area1.rbxm` | 438 | 329 | 3 | 858x166x969 |  |
| `models/Workspace/Area2.rbxm` | 433 | 267 | 19 | 2901x1227x1940 |  |
| `models/Workspace/Training Areas/Divine Realm.rbxm` | 433 | 263 | 1 | 318x124x180 | map |
| `models/ReplicatedStorage/Assets/Poses/SixSeven.rbxm` | 389 | 7 | 0 | 4x5x2 | character |
| `models/Workspace/Rig.rbxm` | 238 | 16 | 15 | 4x5x1 | character |
| `models/Workspace/Rig~2.rbxm` | 238 | 16 | 15 | 4x5x1 | character |
| `models/Workspace/Rig~5.rbxm` | 238 | 16 | 15 | 4x5x1 | character |
| `models/ReplicatedStorage/Assets/Auras/16.rbxm` | 198 | 7 | 0 | 1x5x4 | character, vfx |
| `models/ReplicatedStorage/Assets/Auras/31.rbxm` | 157 | 13 | 0 | 14x15x14 | character, vfx |
| `models/ReplicatedStorage/Assets/Auras/Gojo.rbxm` | 152 | 10 | 0 | 10x7x11 | character, vfx |
| `models/Workspace/Training Areas/Dark Lava.rbxm` | 152 | 125 | 0 | 80x28x81 | map |
| `models/ServerStorage/Decompiled/LocalPlayer Character.rbxm` | 146 | 8 | 0 | 4x5x2 | accessory, character, vfx |
| `models/Workspace/Leaderboards/PlayTimeLB.rbxm` | 112 | 33 | 26 | 18x43x6 | character, sign |
| `models/ReplicatedStorage/Assets/Auras/20.rbxm` | 111 | 9 | 0 | 12x12x12 | character, vfx |
| `models/ReplicatedStorage/Assets/Auras/35.rbxm` | 110 | 11 | 0 | 8x8x8 | character, vfx |
| `models/Workspace/Training Areas/Lava Heaven.rbxm` | 108 | 82 | 0 | 394x176x362 | map |
| `models/Workspace/Leaderboards/AuraLB.rbxm` | 107 | 28 | 21 | 14x44x12 | character, sign, vfx |
| `models/Workspace/Leaderboards/RebirthsLB.rbxm` | 107 | 28 | 21 | 14x44x12 | character, sign |
| `models/Workspace/Leaderboards/KothLB.rbxm` | 106 | 27 | 20 | 28x39x27 | character, sign |
| `models/ReplicatedStorage/Assets/Auras/12.rbxm` | 104 | 9 | 0 | 1x5x4 | character, vfx |
| `models/Workspace/CommonAreaAssets.rbxm` | 100 | 77 | 0 | 121x4x269 | map |
| `models/Workspace/CommonAreaAssets~3.rbxm` | 100 | 77 | 0 | 264x4x179 | map |
| `models/Workspace/CommonAreaAssets~4.rbxm` | 98 | 75 | 0 | 318x4x113 | map |
| `models/Workspace/Training Areas/Fire Bath.rbxm` | 89 | 72 | 0 | 73x19x73 | map |
| `models/ReplicatedStorage/Assets/Auras/Boxing.rbxm` | 86 | 8 | 0 | 4x5x4 | character, vfx |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/InventoryHud/init.lua` | 1248 | 9 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/ScreenFrames/init.lua` | 380 | 50 |
| `ui/StarterGui/ScreenFrames/init.lua` | 379 | 46 |
| `ui/StarterGui/Plat.lua` | 137 | 15 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/ConfettiFX.lua` | 109 | 0 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/Hud.lua` | 100 | 17 |
| `ui/StarterGui/InventoryHud.lua` | 97 | 9 |
| `ui/StarterGui/Hud.lua` | 86 | 17 |
| `ui/StarterGui/NotificationGui.lua` | 29 | 4 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/NotificationGui.lua` | 25 | 4 |
| `ui/StarterGui/LoadingScreen.lua` | 22 | 5 |
| `ui/StarterGui/Tutorial.lua` | 7 | 2 |
| `ui/StarterGui/Extensions.lua` | 7 | 2 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/Tutorial.lua` | 7 | 2 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/Extensions.lua` | 7 | 2 |
| `ui/StarterPack/NextArea.lua` | 3 | 1 |
| `ui/ReplicatedStorage/Assets/RankTexts/SilverSurfer.lua` | 2 | 1 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/UIOverlay.lua` | 2 | 0 |
| `ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/InventoryTransitionGui.lua` | 2 | 0 |
| `ui/StarterGui/Ripple.lua` | 1 | 0 |
| `ui/TextChatService/BubbleChatConfiguration/ImageLabel.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/The Ascension.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/The Ultimate.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/The Ultimate~2.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Nightmare.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/True Genesis.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Abomination.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Deity.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Mastermind.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Prodigy.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Too Much Aura.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Sendevian.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Sigma.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Antagonist.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/The Honored One.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Menace.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Superior.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Deltaversal.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Chronomancer.lua` | 1 | 0 |
| `ui/ReplicatedStorage/Assets/RankTexts/Grim Reaper.lua` | 1 | 0 |
