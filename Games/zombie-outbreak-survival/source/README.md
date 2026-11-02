# Zombie Outbreak Survival

Source: `C:/Users/wnott/Downloads\Zombie Outbreak Survival.rbxl`  
38838 instances, 148 classes, 154 scripts (19885 lines), 49 remotes, 914 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 4334 | 20/2/2 |
| MaterialService | MaterialService | 1 |  |
| TextChatService | TextChatService | 8 |  |
| StarterPlayer | StarterPlayer | 50 | 1/5/22 |
| StarterGui | StarterGui | 130 | 0/17/0 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 6 |  |
| ReplicatedStorage | ReplicatedStorage | 16197 | 36/15/23 |
| ServerScriptService | ServerScriptService | 21 | 8/1/0 |
| ServerStorage | ServerStorage | 18032 | 2/0/0 |
| Lighting | Lighting | 1 |  |
| Teams | Teams | 2 |  |

(43 empty services not listed)

## Key containers

**ServerScriptService** (8 children)

- Script `Game Round` -> `scripts/ServerScriptService/Game Round.server.lua`
- Script `MorrerToolsSystem` -> `scripts/ServerScriptService/MorrerToolsSystem.server.lua`
- Script `STATS` -> `scripts/ServerScriptService/STATS.server.lua`
- Script `DailyChestHandler` -> `scripts/ServerScriptService/DailyChestHandler.server.lua`
- Script `Day/Night Cycle` -> `scripts/ServerScriptService/Day_Night Cycle.server.lua`
- Script `OverheadScript` (5) -> `scripts/ServerScriptService/OverheadScript.server.lua`
- Script `Buy_tools` -> `scripts/ServerScriptService/Buy_tools.server.lua`
- Script `WelcomeGUI` (8) -> `scripts/ServerScriptService/WelcomeGUI.server.lua`

**ServerStorage** (3 children)

- Model `Billboard` (12)
- Model `MapTemplate` (13)
- Model `AbandonedCity` (18004)

**ReplicatedStorage** (10 children)

- Folder `Tools` (326)
- Folder `Values` (6)
- Folder `Remotes` (42)
- Folder `Maps` (15692)
- Folder `ZombiesRE`
- Folder `Code_Tools` (10)
- Model `Zombie` (86)
- Folder `Modules` (25)
- Folder `UserMaps`
- Folder `BuildModeData`

**ReplicatedFirst** (0 children)


**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (46)
- LocalScript `DeathEffect` (14) -> `scripts/StarterPlayer/StarterPlayerScripts/DeathEffect.client.lua`
- LocalScript `NotificationClient` -> `scripts/StarterPlayer/StarterPlayerScripts/NotificationClient.client.lua`
- LocalScript `SingleOpenGuiHandler` -> `scripts/StarterPlayer/StarterPlayerScripts/SingleOpenGuiHandler.client.lua`
- LocalScript `Satchel` (28) -> `scripts/StarterPlayer/StarterPlayerScripts/Satchel.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (2)
- Script `Health` -> `scripts/StarterPlayer/StarterCharacterScripts/Health.server.lua`
- LocalScript `DailyChestLocal` -> `scripts/StarterPlayer/StarterCharacterScripts/DailyChestLocal.client.lua`

**StarterGui** (6 children)

- ScreenGui `Tools_shop` (16)
- ScreenGui `Tutorial` (9)
- LocalScript `Disable` -> `scripts/StarterGui/Disable.client.lua`
- ScreenGui `MainGui` (85)
- ScreenGui `LevelUp` (6)
- ScreenGui `Codes` (8)

**StarterPack** (0 children)


**Workspace** (8 children)

- Terrain `Terrain`
- Camera `Camera`
- Model `MapVote` (49)
- Model `Chest` (8)
- Part `DailyChest` (6)
- Folder `Map`
- Folder `Accessory Storage`
- Folder `Lobby` (4263)

## UI roots

- ScreenGui `Tools_shop` (16 descendants) [disabled]
- ScreenGui `Tutorial` (9 descendants) [disabled]
- LocalScript `Disable` (0 descendants)
- ScreenGui `MainGui` (85 descendants)
- ScreenGui `LevelUp` (6 descendants)
- ScreenGui `Codes` (8 descendants) [disabled]
- ScreenGui `Welcome` (7 descendants)
- plus 32 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 2182 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua`
- 1092 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus.lua`
- 1057 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD.lua`
- 665 lines, server: `scripts/ServerScriptService/Game Round.server.lua`
- 469 lines, module: `scripts/ReplicatedStorage/Modules/MapVoteHandler.lua`
- 447 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus/Utility.lua`
- 447 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD/Utility.lua`
- 413 lines, server: `scripts/ServerScriptService/STATS.server.lua`
- 411 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus/Elements/Widget.lua`
- 411 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD/Elements/Widget.lua`
- 377 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus/Packages/Janitor.lua`
- 377 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD/Packages/Janitor.lua`
- 352 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus/Features/Themes.lua`
- 352 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD/Features/Themes.lua`
- 328 lines, server: `scripts/Workspace/Lobby/Stuff/Leaderboards/TimePlayedLeaderboard/TimePlayedClass.server.lua`
- 325 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus/Features/Overflow.lua`
- 325 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD/Features/Overflow.lua`
- 315 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus/Elements/Caption.lua`
- 315 lines, module: `scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD/Elements/Caption.lua`
- 250 lines, server: `scripts/ServerScriptService/Buy_tools.server.lua`

## Scan

- Flags: 0 HIGH, 2 MED (details in flags.txt)
- Monetization ids in code: 1
- Scripts with decompiler headers: 0; empty scripts: 0

## Most common classes

- Part: 16272
- ManualWeld: 3539
- Snap: 3349
- Weld: 3294
- Model: 2734
- MeshPart: 2342
- BlockMesh: 1635
- CylinderMesh: 1394
- UnionOperation: 1202
- SpecialMesh: 454
- Decal: 394
- WedgePart: 348
- Attachment: 197
- Vector3Value: 192
- PointLight: 127
- TextLabel: 110
- ParticleEmitter: 97
- Texture: 86
- StringValue: 75
- Folder: 72
- Script: 67
- Motor6D: 60
- RemoteEvent: 48
- ModuleScript: 47
- Sound: 46
