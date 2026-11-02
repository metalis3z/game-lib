# Forsaken

Source: `C:/Users/wnott/Downloads\Forsaken.rbxl`  
81721 instances, 180 classes, 954 scripts (72882 lines), 17 remotes, 3341 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 7151 | 0/2/19 |
| SoundService | SoundService | 3 |  |
| ReplicatedFirst | ReplicatedFirst | 7 | 0/1/0 |
| MaterialService | MaterialService | 1 |  |
| TextChatService | TextChatService | 35 |  |
| StarterPlayer | StarterPlayer | 8 | 0/2/0 |
| StarterGui | StarterGui | 2 |  |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 6 |  |
| ReplicatedStorage | ReplicatedStorage | 15560 | 4/5/874 |
| ServerScriptService | ServerScriptService | 7 | 3/0/1 |
| ServerStorage | ServerStorage | 58885 | 2/5/36 |
| Lighting | Lighting | 2 |  |

(40 empty services not listed)

## Key containers

**ServerScriptService** (3 children)

- Folder `Game` (3)
- Folder `Core` (1)
- Script `Script` -> `scripts/ServerScriptService/Script.server.lua`

**ServerStorage** (3 children)

- Folder `ServerSystems` (426)
- Folder `Assets` (58455)
- Folder `Modules` (1)

**ReplicatedStorage** (10 children)

- ModuleScript `Initializer` -> `scripts/ReplicatedStorage/Initializer.lua`
- Folder `Songs`
- Folder `Assets` (14164)
- Folder `Modules` (390)
- Folder `Systems` (989)
- Folder `Scripts` (2)
- StringValue `RoundTimer`
- Folder `VersionInfo` (2)
- ObjectValue `TopbarPlusReference`
- Folder `CurrentReplicatedLighting` (3)

**ReplicatedFirst** (1 children)

- LocalScript `Loading` (6) -> `scripts/ReplicatedFirst/Loading.client.lua`

**StarterPlayer** (2 children)

- StarterCharacterScripts `StarterCharacterScripts` (4)
- Folder `FOVMultipliers`
- Folder `ResistanceMultipliers`
- Folder `SpeedCapMultipliers`
- Folder `SpeedMultipliers`
- StarterPlayerScripts `StarterPlayerScripts` (2)
- LocalScript `RbxCharacterSounds` -> `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- LocalScript `PlayerScriptsLoader` -> `scripts/StarterPlayer/StarterPlayerScripts/PlayerScriptsLoader.client.lua`

**StarterGui** (2 children)

- ScreenGui `TemporaryUI`
- ScreenGui `MainUI`

**StarterPack** (0 children)


**Workspace** (5 children)

- Folder `Map` (7143)
- Folder `Players` (3)
- Folder `Misc`
- Terrain `Terrain`
- Camera `Camera`

## UI roots

- ScreenGui `TemporaryUI` (0 descendants)
- ScreenGui `MainUI` (0 descendants)
- ScreenGui `LoadingGui` (5 descendants)
- ScreenGui `IntroScreen` (2 descendants)
- ScreenGui `JumpscareUI` (1 descendants)
- ScreenGui `Intro2011X` (3 descendants)
- ScreenGui `BackgroundUI` (8 descendants)
- ScreenGui `PuzzleUI` (7 descendants)
- ScreenGui `RoundTimer` (6 descendants)
- ScreenGui `RoundTimerOLd` (6 descendants)
- ScreenGui `RoundTimer` (5 descendants)
- ScreenGui `EndScreen` (39 descendants)
- ScreenGui `BackgroundUI` (8 descendants)
- plus 105 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 1284 lines, module: `scripts/ReplicatedStorage/Modules/Util.lua`
- 1020 lines, module: `scripts/ReplicatedStorage/Assets/Survivors/TwoTimeButOp/Behavior.lua`
- 1002 lines, module: `scripts/ReplicatedStorage/Modules/Icon.lua`
- 977 lines, module: `scripts/ReplicatedStorage/Assets/Survivors/TwoTime/Behavior.lua`
- 816 lines, module: `scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua`
- 804 lines, module: `scripts/ReplicatedStorage/Modules/RichText.lua`
- 748 lines, module: `scripts/ReplicatedStorage/Systems/Player/UI/Menus/Shop.lua`
- 716 lines, module: `scripts/ReplicatedStorage/Assets/Survivors/OldTwoTIme/Behavior.lua`
- 684 lines, module: `scripts/ReplicatedStorage/Assets/Survivors/Builderman/Behavior.lua`
- 666 lines, module: `scripts/ReplicatedStorage/Modules/Misc/FlowGameManager/FlowGame.lua`
- 665 lines, module: `scripts/ReplicatedStorage/Systems/Player/UI/Menus/Inventory.lua`
- 665 lines, client: `scripts/ServerStorage/Assets/Maps/BrandonWorks/Map/NPCS _ Good People/_/Animate.client.lua`
- 665 lines, client: `scripts/ServerStorage/Assets/Maps/BrandonWorks/Map/NPCS _ Good People/_~3/Animate.client.lua`
- 665 lines, client: `scripts/ServerStorage/Assets/Maps/BrandonWorks/Map/NPCS _ Good People/_~4/Animate.client.lua`
- 665 lines, client: `scripts/ServerStorage/Assets/Maps/BrandonWorks/Map/NPCS _ Good People/_~5/Animate.client.lua`
- 651 lines, module: `scripts/ReplicatedStorage/Modules/Actors.lua`
- 644 lines, module: `scripts/ReplicatedStorage/Assets/Skins/Killers/c00lkidd/MafiasoC00l/Behavior.lua`
- 627 lines, module: `scripts/ReplicatedStorage/Systems/Player/Networks/ActorNetwork.lua`
- 621 lines, module: `scripts/ReplicatedStorage/Assets/Killers/__KillerNoli/Behavior.lua`
- 617 lines, module: `scripts/ReplicatedStorage/Assets/Survivors/Taph/Behavior.lua`

## Scan

- Flags: 2 HIGH, 14 MED (details in flags.txt)
- Monetization ids in code: 14
- Scripts with decompiler headers: 917; empty scripts: 0
- 916 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Part: 33318
- Weld: 6721
- Attachment: 4758
- MeshPart: 4061
- Model: 3303
- SpecialMesh: 2847
- Snap: 2389
- Decal: 2248
- Motor6D: 2243
- WeldConstraint: 2104
- Folder: 2069
- Texture: 2024
- Pose: 2020
- ParticleEmitter: 1827
- UnionOperation: 935
- ModuleScript: 930
- Sound: 741
- CFrameValue: 572
- Beam: 503
- PointLight: 381
- StringValue: 328
- BodyPartDescription: 324
- TextLabel: 301
- ImageLabel: 282
- Vector3Value: 276
