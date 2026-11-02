# SCP_Tycoon

Source: `C:/Users/wnott/Downloads\SCP_Tycoon.rbxl`  
8977 instances, 118 classes, 202 scripts (24639 lines), 60 remotes, 988 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 2803 | 43/1/2 |
| SoundService | SoundService | 38 |  |
| StarterPlayer | StarterPlayer | 57 | 1/5/0 |
| StarterPack | StarterPack | 16 | 0/0/3 |
| StarterGui | StarterGui | 141 | 0/25/0 |
| InsertService | InsertService | 1 |  |
| ServerScriptService | ServerScriptService | 14 | 5/1/0 |
| ServerStorage | ServerStorage | 31 |  |
| ReplicatedStorage | ReplicatedStorage | 5828 | 9/17/90 |
| Lighting | Lighting | 1 |  |

(37 empty services not listed)

## Key containers

**ServerScriptService** (5 children)

- Script `PlayerAddedHandler` -> `scripts/ServerScriptService/PlayerAddedHandler.server.lua`
- Script `EventsHandler` -> `scripts/ServerScriptService/EventsHandler.server.lua`
- Script `ACS_Server` -> `scripts/ServerScriptService/ACS_Server.server.lua`
- Script `MainServerNVG (Put in server script sevice)` (9) -> `scripts/ServerScriptService/MainServerNVG (Put in server script sevice).server.lua`
- Script `GameEventsHandler` -> `scripts/ServerScriptService/GameEventsHandler.server.lua`

**ServerStorage** (1 children)

- Folder `Brushtool2_Plugin_Storage` (30)

**ReplicatedStorage** (7 children)

- Folder `Events` (5)
- Model `Texture Pack` (2917)
- Folder `Weapons` (503)
- Folder `ACS_Engine` (1942)
- Folder `EnemyContainer` (447)
- Folder `GameEventData` (2)
- Folder `GunShopWeaponData` (5)

**ReplicatedFirst** (0 children)


**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (2)
- LocalScript `ChatHandler` -> `scripts/StarterPlayer/StarterPlayerScripts/ChatHandler.client.lua`
- LocalScript `RbxCharacterSounds` -> `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (53)
- LocalScript `BeamCreator` -> `scripts/StarterPlayer/StarterCharacterScripts/BeamCreator.client.lua`
- Folder `Saude` (51)

**StarterGui** (3 children)

- ScreenGui `InterfaceGUI` (128)
- ScreenGui `LoadingGUI` (9)
- Folder `Sounds` (1)

**StarterPack** (1 children)

- Tool `Desert Eagle` (15)

**Workspace** (15 children)

- Camera `Camera`
- Part `Baseplate`
- Terrain `Terrain`
- Folder `Tycoons` (279)
- SpawnLocation `SpawnLocation` (2)
- LocalScript `RainHandler` (104) -> `scripts/Workspace/RainHandler.client.lua`
- Model `Trees` (68)
- Sound `Music`
- Folder `Buildings` (1948)
- Folder `ACS_WorkSpace` (140)
- Part `Giver` (2)
- Model `Boards` (180)
- Model `Bars` (12)
- Script `Initializer` (1) -> `scripts/Workspace/Initializer.server.lua`
- Folder `Event Maps` (52)

## UI roots

- ScreenGui `InterfaceGUI` (128 descendants)
- ScreenGui `LoadingGUI` (9 descendants) [disabled]
- Folder `Sounds` (1 descendants)
- ScreenGui `GPShud` (16 descendants)
- ScreenGui `StatusUI` (224 descendants)
- plus 30 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 3167 lines, client: `scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua`
- 1465 lines, server: `scripts/ServerScriptService/ACS_Server.server.lua`
- 882 lines, module: `scripts/ReplicatedStorage/ACS_Engine/Modulos/Hitmarker.lua`
- 651 lines, client: `scripts/ReplicatedStorage/ACS_Engine/HUD/StatusUI/Main.client.lua`
- 622 lines, client: `scripts/ReplicatedStorage/ACS_Engine/HUD/StatusUI/Stances.client.lua`
- 606 lines, server: `scripts/ReplicatedStorage/EnemyContainer/Enemy_CQC/AI.server.lua`
- 606 lines, server: `scripts/ReplicatedStorage/EnemyContainer/Enemy_Gunner/AI.server.lua`
- 606 lines, server: `scripts/ReplicatedStorage/EnemyContainer/Enemy_HMG/AI.server.lua`
- 606 lines, server: `scripts/ReplicatedStorage/EnemyContainer/Enemy_Sniper/AI.server.lua`
- 507 lines, server: `scripts/ReplicatedStorage/EnemyContainer/Enemy_Unarmed/AI.server.lua`
- 344 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- 280 lines, server: `scripts/Workspace/Boards/R15Loader/PlayAnimation/List.server.lua` [disabled]
- 263 lines, module: `scripts/ReplicatedStorage/Weapons/M40A5/ACS_Modulo/Variaveis/Animations.lua`
- 248 lines, client: `scripts/ServerScriptService/MainServerNVG (Put in server script sevice)/MainNVG.client.lua`
- 224 lines, module: `scripts/ReplicatedStorage/Weapons/The Little Friend/ACS_Modulo/Variaveis/Animations.lua`
- 209 lines, module: `scripts/ReplicatedStorage/Weapons/AK74M/ACS_Modulo/Variaveis/Animations.lua`
- 209 lines, module: `scripts/ReplicatedStorage/Weapons/AKM/ACS_Modulo/Variaveis/Animations.lua`
- 209 lines, module: `scripts/ReplicatedStorage/Weapons/AKS74U/ACS_Modulo/Variaveis/Animations.lua`
- 209 lines, module: `scripts/ReplicatedStorage/Weapons/RPK/ACS_Modulo/Variaveis/Animations.lua`
- 208 lines, module: `scripts/ReplicatedStorage/Weapons/L85A2/ACS_Modulo/Variaveis/Animations.lua`

## Scan

- Flags: 2 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 4
- Scripts with decompiler headers: 0; empty scripts: 0

## Most common classes

- Texture: 2515
- Part: 2010
- UnionOperation: 740
- Sound: 457
- ManualWeld: 366
- ParticleEmitter: 273
- Attachment: 216
- Model: 188
- BoolValue: 160
- Folder: 148
- Decal: 136
- MeshPart: 132
- DoubleConstrainedValue: 130
- Frame: 125
- TextLabel: 111
- ImageLabel: 110
- NumberValue: 96
- ModuleScript: 95
- TextButton: 83
- Vector3Value: 73
- StringValue: 64
- RemoteEvent: 60
- SpotLight: 60
- Script: 58
- SpecialMesh: 56
