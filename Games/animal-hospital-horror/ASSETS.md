# Animal Hospital (horror, modded)

- Genre: horror roleplay (patients, skinwalkers, sanity)
- Source file: `Animal modded.rbxl`
- Provenance: copy of a live game (saveinstance / decompiled client code)
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 454 files, 4860 KB (5 duplicates skipped, 279 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 52 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 359 models, 6 part sets, 5 vfx sets | mirrors the source tree |
| `animations/` | 3 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 386 Animation ids |
| `audio/` | 8 | `Sounds.lua` lists 713 Sound ids |

## Model tags

character (104), interior (102), building (42), tool (32), sign (17), map (8), vfx (7), popup (4), weapon (4), accessory (4), hud (3), nature (2), inventory (1), shop (1), reward (1), keyboard (1), backup (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/ReplicatedStorage/Misc/Ambulance.rbxm` | 651 | 166 | 1 | 9x9x25 |  |
| `models/StarterPlayer/StarterCharacter.rbxm` | 299 | 31 | 28 | 2x6x4 | character |
| `models/Workspace/Rooms/Emergency/Room7/Model.rbxm` | 194 | 126 | 0 | 7x6x11 | interior |
| `models/ReplicatedStorage/Misc/PhotoDummy.rbxm` | 133 | 5 | 3 | 4x6x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Doctor.rbxm` | 125 | 26 | 20 | 4x7x4 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Barney.rbxm` | 122 | 19 | 14 | 4x6x3 | character |
| `models/ReplicatedStorage/NPCs/Anomalies1/BassieMonster.rbxm` | 121 | 14 | 11 | 13x16x5 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Ron from Accounting.rbxm` | 121 | 26 | 20 | 4x7x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Secretary.rbxm` | 117 | 25 | 19 | 4x7x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Agent R.rbxm` | 117 | 23 | 21 | 4x8x4 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Supervisor.rbxm` | 112 | 19 | 14 | 4x7x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Psycho.rbxm` | 112 | 20 | 15 | 4x8x2 | character |
| `models/Workspace/Misc/Nurse.rbxm` | 112 | 18 | 13 | 3x6x4 | character |
| `models/ReplicatedStorage/NPCs/Anomalies1/Ghost.rbxm` | 110 | 22 | 19 | 4x7x3 | character |
| `models/ReplicatedStorage/NPCs/Anomalies1/Shadow.rbxm` | 110 | 19 | 12 | 5x7x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Ratthew2.rbxm` | 110 | 24 | 21 | 3x5x3 | character |
| `models/ReplicatedStorage/ClassModels/Surgeon.rbxm` | 110 | 26 | 20 | 4x7x4 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Security.rbxm` | 109 | 18 | 15 | 4x6x2 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Ratthew.rbxm` | 107 | 23 | 21 | 3x5x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Head Nurse.rbxm` | 106 | 18 | 14 | 4x7x2 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Nurse.rbxm` | 106 | 18 | 13 | 4x6x3 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Paramedic.rbxm` | 106 | 17 | 12 | 4x7x2 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors1/Psychologist.rbxm` | 106 | 18 | 13 | 4x6x2 | character |
| `models/ReplicatedStorage/NPCs/UniqueVisitors/Doctor.rbxm` | 106 | 26 | 20 | 4x7x4 | character |
| `models/ReplicatedStorage/ClassModels/Doctor.rbxm` | 106 | 26 | 20 | 4x7x4 | character |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/AdminPanel.lua` | 237 | 21 |
| `ui/StarterGui/Classes.lua` | 72 | 2 |
| `ui/StarterGui/Shop.lua` | 70 | 14 |
| `ui/StarterGui/RoundStatsDetailed.lua` | 66 | 16 |
| `ui/StarterGui/CharacterSelection.lua` | 36 | 3 |
| `ui/StarterGui/Skins.lua` | 25 | 2 |
| `ui/StarterGui/Dialogue.lua` | 19 | 6 |
| `ui/StarterGui/Strikes.lua` | 19 | 5 |
| `ui/StarterGui/Minigame.lua` | 17 | 4 |
| `ui/StarterPlayer/StarterPlayerScripts/ProximityPromptScript/RobloxDefault.lua` | 16 | 0 |
| `ui/StarterPlayer/StarterPlayerScripts/ProximityPromptScript/Default.lua` | 16 | 1 |
| `ui/StarterPlayer/StarterPlayerScripts/ProximityPromptScript/DefaultHighlighted.lua` | 16 | 1 |
| `ui/StarterGui/Sanity.lua` | 15 | 5 |
| `ui/StarterGui/CameraSystem.lua` | 14 | 2 |
| `ui/StarterGui/PlayerDied.lua` | 14 | 0 |
| `ui/StarterGui/GiftList.lua` | 14 | 0 |
| `ui/StarterGui/Notifications.lua` | 9 | 1 |
| `ui/StarterGui/EmergencyCounter.lua` | 9 | 0 |
| `ui/StarterGui/Shift.lua` | 9 | 3 |
| `ui/StarterGui/HeartbeatMinigameUI.lua` | 7 | 2 |
| `ui/StarterGui/PhotoUI.lua` | 6 | 3 |
| `ui/StarterGui/PhotoUI2.lua` | 6 | 3 |
| `ui/StarterGui/Actions.lua` | 6 | 0 |
| `ui/StarterGui/Objective.lua` | 5 | 0 |
| `ui/ReplicatedStorage/Misc/Error.lua` | 5 | 0 |
| `ui/StarterGui/Vignette.lua` | 4 | 1 |
| `ui/StarterGui/Announcement.lua` | 4 | 1 |
| `ui/StarterGui/MOBILE_BUTTONS.lua` | 4 | 0 |
| `ui/StarterGui/ConfettiCannon.lua` | 4 | 2 |
| `ui/StarterGui/CharacterCreation.lua` | 4 | 0 |
| `ui/StarterGui/TouchCursor.lua` | 3 | 1 |
| `ui/StarterGui/DontLookUp.lua` | 3 | 0 |
| `ui/StarterGui/InventoryFull.lua` | 3 | 0 |
| `ui/StarterGui/Pointer.lua` | 3 | 1 |
| `ui/StarterGui/BoostDuration.lua` | 3 | 1 |
| `ui/StarterGui/Run.lua` | 3 | 0 |
| `ui/StarterGui/Menu.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Misc/Interrupted.lua` | 3 | 0 |
| `ui/ReplicatedStorage/Misc/NoFaceBillboard.lua` | 3 | 1 |
| `ui/ServerScriptService/NameTag/NameTag.lua` | 3 | 0 |
