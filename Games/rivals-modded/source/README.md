# SLBR - RIVALS MODDED - BOOSTER

Source: `C:/Users/wnott/Downloads\SLBR - RIVALS MODDED - BOOSTER.rbxl`  
107210 instances, 168 classes, 2154 scripts (247103 lines), 185 remotes, 8076 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace  | Workspace | 18379 | 0/0/1 |
| SoundService | SoundService | 7 |  |
| Players  | Players | 2 |  |
| ReplicatedFirst  | ReplicatedFirst | 44 | 0/4/1 |
| MaterialService | MaterialService | 248 |  |
| TextChatService | TextChatService | 74 |  |
| StarterPlayer | StarterPlayer | 38122 | 1/4/951 |
| StarterGui | StarterGui | 2 | 0/1/0 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 13 |  |
| ReplicatedStorage  | ReplicatedStorage | 3671 | 0/0/1124 |
| ServerScriptService | ServerScriptService | 31 | 1/0/26 |
| ServerStorage | ServerStorage | 46556 | 0/2/38 |

(39 empty services not listed)

## Key containers

**ServerScriptService** (3 children)

- Folder `Server` (24)
- Script `Main` -> `scripts/ServerScriptService/Main.server.lua`
- Folder `ServerPackages` (4)

**ServerStorage** (10 children)

- Folder `ObfuscatedOriginals` (4)
- Folder `Services` (4)
- Folder `AnimationOverrides` (4)
- Folder `DumpLeftovers` (330)
- Folder `Maps` (45980)
- ModuleScript `DamageNumbers_ToppleStyle_Backup` -> `scripts/ServerStorage/DamageNumbers_ToppleStyle_Backup.lua`
- LocalScript `AdminPanel_v1_Backup` -> `scripts/ServerStorage/AdminPanel_v1_Backup.client.lua`
- LocalScript `AdminPanel_v2_Backup` -> `scripts/ServerStorage/AdminPanel_v2_Backup.client.lua`
- ScreenGui `LoadingScreenGui_testrival_Backup` (49)
- Folder `SoundOverrides` (175)

**ReplicatedStorage ** (4 children)

- Folder `Remotes` (196)
- Folder `Modules` (3465)
- Folder `Assets` (6)
- ModuleScript `NovaUI` -> `scripts/ReplicatedStorage/NovaUI.lua`

**ReplicatedFirst ** (4 children)

- LocalScript `LocalScript3` -> `scripts/ReplicatedFirst/LocalScript3.client.lua`
- LocalScript `Root` (40) -> `scripts/ReplicatedFirst/Root.client.lua`
- LocalScript `Bootstrap` -> `scripts/ReplicatedFirst/Bootstrap.client.lua`
- LocalScript `ClientLogTap` -> `scripts/ReplicatedFirst/ClientLogTap.client.lua`

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (38019)
- ModuleScript `Client` -> `scripts/StarterPlayer/StarterPlayerScripts/Client.lua`
- Folder `UserInterface` (7523)
- Folder `Modules` (935)
- Folder `Controllers` (51)
- Folder `Assets` (29503)
- LocalScript `NovaUIShowcase` -> `scripts/StarterPlayer/StarterPlayerScripts/NovaUIShowcase.client.lua`
- LocalScript `AdminPanel` -> `scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (101)
- ModuleScript `Health` -> `scripts/StarterPlayer/StarterCharacterScripts/Health.lua`
- LocalScript `Animate` (99) -> `scripts/StarterPlayer/StarterCharacterScripts/Animate.client.lua`

**StarterGui** (1 children)

- ScreenGui `StudioGui` (1)

**StarterPack** (0 children)


**Workspace ** (13 children)

- Camera `Camera`
- Folder `Lobby` (7678)
- IntValue `ServerPing`
- Model `ViewModels` (1)
- Model `Model`
- Model `energy_bundle` (86)
- Folder `ShootingRangeEntities` (9490)
- Model `HurtEffect`
- Terrain `Terrain`
- Part `Panel`
- Part `Part`
- Part `Part` (1)
- Folder `BigMaps` (1110)

## UI roots

- ScreenGui `StudioGui` (1 descendants)
- ScreenGui `LoadingScreen` (38 descendants)
- ScreenGui `PaintballSplatGui` (1 descendants)
- ScreenGui `ESPGui` (4 descendants)
- ScreenGui `TeleportingGui` (11 descendants)
- ScreenGui `Shutdown` (4 descendants)
- ScreenGui `InsetGui` (24 descendants)
- ScreenGui `CustomFreecam` (2 descendants)
- ScreenGui `MainGui` (698 descendants)
- ScreenGui `FlashbangGui` (14 descendants)
- ScreenGui `Gui` (9 descendants)
- ScreenGui `LoadingScreenGui_testrival_Backup` (49 descendants)
- plus 885 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 11037 lines, module: `scripts/ServerStorage/ObfuscatedOriginals/ClientFighter.lua`
- 10880 lines, client: `scripts/ReplicatedFirst/LocalScript3.client.lua` [disabled]
- 9302 lines, module: `scripts/ReplicatedStorage/Modules/CosmeticLibrary.lua`
- 8880 lines, module: `scripts/ServerStorage/ObfuscatedOriginals/MiscellaneousController.lua`
- 8652 lines, module: `scripts/ServerStorage/ObfuscatedOriginals/ReplicatedController.lua`
- 7609 lines, module: `scripts/ReplicatedStorage/Modules/ItemLibrary.lua`
- 6391 lines, client: `scripts/ReplicatedFirst/Root.client.lua` [disabled]
- 6332 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Modules/CameraSecurity.lua`
- 4227 lines, module: `scripts/ServerStorage/ObfuscatedOriginals/ClientItem.lua`
- 2738 lines, module: `scripts/ReplicatedStorage/Modules/StatisticsLibrary.lua`
- 2243 lines, module: `scripts/ServerScriptService/ServerPackages/_Index/lm-loleris_profilestore@1.0.3/profilestore.lua`
- 2011 lines, module: `scripts/ReplicatedStorage/Modules/SettingsLibrary.lua`
- 1849 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua`
- 1834 lines, module: `scripts/ReplicatedStorage/Modules/MonetizationLibrary.lua`
- 1826 lines, module: `scripts/ReplicatedStorage/Modules/DuelLibrary.lua`
- 1714 lines, module: `scripts/ServerScriptService/Server/ItemService.lua`
- 1581 lines, module: `scripts/ReplicatedStorage/Modules/AnimationLibrary.lua`
- 1554 lines, client: `scripts/ServerStorage/AdminPanel_v2_Backup.client.lua` [disabled]
- 1503 lines, module: `scripts/ReplicatedStorage/Modules/Quaternion.lua`
- 1452 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/MechanicsController.lua`

## Scan

- Flags: 0 HIGH, 8 MED (details in flags.txt)
- Monetization ids in code: 37
- Scripts with decompiler headers: 2107; empty scripts: 0
- 2104 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Part: 25887
- MeshPart: 23269
- Model: 11579
- Texture: 9209
- Attachment: 7231
- ParticleEmitter: 3523
- Vector3Value: 3490
- Frame: 2514
- ImageLabel: 2382
- ModuleScript: 2141
- Decal: 1502
- Folder: 1293
- TextLabel: 1227
- UIGradient: 935
- Motor6D: 934
- NoCollisionConstraint: 870
- Beam: 697
- SurfaceGui: 671
- WrapTarget: 658
- UICorner: 577
- WeldConstraint: 513
- UIStroke: 496
- SurfaceAppearance: 490
- ImageButton: 446
- Weld: 432
