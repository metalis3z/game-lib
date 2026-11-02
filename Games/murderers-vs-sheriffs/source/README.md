# vv mmv summer upd 26 f2+ap + new upd

Source: `C:/Users/wnott/Downloads\vv mmv summer upd 26 f2+ap + new upd.rbxl`  
127809 instances, 182 classes, 1266 scripts (137480 lines), 350 remotes, 3924 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 9502 | 15/14/0 |
| SoundService | SoundService | 1 |  |
| ReplicatedFirst | ReplicatedFirst | 240 | 0/5/1 |
| TextChatService | TextChatService | 14 |  |
| StarterPlayer | StarterPlayer | 663 | 1/44/48 |
| StarterPack | StarterPack | 1 |  |
| StarterGui | StarterGui | 9316 | 0/63/18 |
| LocalizationService | LocalizationService | 1 |  |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 6 |  |
| ReplicatedStorage | ReplicatedStorage | 13289 | 0/86/119 |
| ServerScriptService | ServerScriptService | 599 | 26/11/223 |
| ServerStorage | ServerStorage | 94117 | 196/110/286 |

(38 empty services not listed)

## Key containers

**ServerScriptService** (10 children)

- Script `GameScript` (477) -> `scripts/ServerScriptService/GameScript.server.lua`
- Folder `Modules` (15)
- Script `AdminPanelServer` -> `scripts/ServerScriptService/AdminPanelServer.server.lua`
- ModuleScript `Cmdr` (74) -> `scripts/ServerScriptService/Cmdr.lua`
- Script `CmdrServer` (23) -> `scripts/ServerScriptService/CmdrServer.server.lua`
- Script `GlobalAnnouncementServer` -> `scripts/ServerScriptService/GlobalAnnouncementServer.server.lua`
- Script `FavoritePromptService` -> `scripts/ServerScriptService/FavoritePromptService.server.lua`
- Script `coilservice` -> `scripts/ServerScriptService/coilservice.server.lua`
- Script `toolpasses` -> `scripts/ServerScriptService/toolpasses.server.lua`
- Script `jetpackservice` -> `scripts/ServerScriptService/jetpackservice.server.lua`

**ServerStorage** (20 children)

- ModuleScript `Trove` -> `scripts/ServerStorage/Trove.lua`
- Folder `Sounds` (4)
- Folder `PerkAssets` (9)
- Folder `Gameplay` (372)
- Folder `PumpkinMeshes` (1)
- Folder `SnowmanMeshes` (2)
- Folder `Assets` (4)
- ParticleEmitter `ShootParticle`
- Folder `Database` (84123)
- Model `ThrowingKnife` (3)
- Folder `Resources` (8107)
- Folder `DisabledOldAdminSystem` (665)
- Folder `AdminPanelImportBackup` (199)
- Folder `ProfileStatsImportBackup` (394)
- Folder `CmdrInstallBackup` (1)
- Folder `CmdrImportBackup` (1)
- Folder `ImportBackups` (90)
- Folder `RoundState` (2)
- StringValue `ForcedMap`
- Folder `ToolTemplates` (120)

**ReplicatedStorage** (34 children)

- ModuleScript `Constants` -> `scripts/ReplicatedStorage/Constants.lua`
- ModuleScript `CodeImages` -> `scripts/ReplicatedStorage/CodeImages.lua`
- ModuleScript `RankIcons` -> `scripts/ReplicatedStorage/RankIcons.lua`
- ModuleScript `RankIconsEmpty` -> `scripts/ReplicatedStorage/RankIconsEmpty.lua`
- Folder `ClientServices` (408)
- Folder `ClientTweenEvents` (5)
- Folder `Types` (1)
- Folder `Insight` (3)
- Folder `Modules` (507)
- Folder `Remotes` (229)
- Folder `Resources` (155)
- Folder `SharedServices` (49)
- Folder `TrapSystem` (7)
- Folder `WeaponEvents` (1)
- Backpack `Trade` (17)
- BindableFunction `GetDataServer`
- BindableFunction `GetPlayerData_REMOTE`
- Model `Pets`
- RemoteFunction `GetSyncData`
- BindableFunction `GetSyncDataServer`
- RemoteEvent `ChatMessage`
- RemoteEvent `ItemGift`
- Folder `GUI` (11802)
- RemoteEvent `PlayerAdded`
- RemoteEvent `UpdateData`
- RemoteEvent `UpdateData2`
- RemoteEvent `UpdateData3`
- BindableEvent `UpdateDataClient`
- Folder `Database` (36)
- Folder `Coins` (33)
- RemoteEvent `JumpDelay`
- RemoteEvent `SendAnnouncement`
- RemoteEvent `AnnouncementEvent`
- Folder `Signals` (2)

**ReplicatedFirst** (4 children)

- RemoteEvent `LoadingUpdate`
- ModuleScript `ChinaPolicyService` (2) -> `scripts/ReplicatedFirst/ChinaPolicyService.lua`
- LocalScript `ImageLocalizer` -> `scripts/ReplicatedFirst/ImageLocalizer.client.lua`
- LocalScript `UISelector` (234) -> `scripts/ReplicatedFirst/UISelector.client.lua`

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (598)
- LocalScript `BoxController` -> `scripts/StarterPlayer/StarterPlayerScripts/BoxController.client.lua`
- LocalScript `ClientTween` -> `scripts/StarterPlayer/StarterPlayerScripts/ClientTween.client.lua`
- LocalScript `GameplayAnimations` (470) -> `scripts/StarterPlayer/StarterPlayerScripts/GameplayAnimations.client.lua`
- LocalScript `ControllerIcons` -> `scripts/StarterPlayer/StarterPlayerScripts/ControllerIcons.client.lua`
- LocalScript `GameModes` (2) -> `scripts/StarterPlayer/StarterPlayerScripts/GameModes.client.lua`
- LocalScript `InteractiveScript` -> `scripts/StarterPlayer/StarterPlayerScripts/InteractiveScript.client.lua`
- LocalScript `TrapScriptClient` (13) -> `scripts/StarterPlayer/StarterPlayerScripts/TrapScriptClient.client.lua`
- LocalScript `PerkSystem` -> `scripts/StarterPlayer/StarterPlayerScripts/PerkSystem.client.lua`
- LocalScript `Pets` (4) -> `scripts/StarterPlayer/StarterPlayerScripts/Pets.client.lua`
- LocalScript `PlayerScriptsLoader` -> `scripts/StarterPlayer/StarterPlayerScripts/PlayerScriptsLoader.client.lua`
- LocalScript `Preloader` -> `scripts/StarterPlayer/StarterPlayerScripts/Preloader.client.lua`
- LocalScript `ProfileLoader` -> `scripts/StarterPlayer/StarterPlayerScripts/ProfileLoader.client.lua`
- LocalScript `RbxCharacterSounds` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- LocalScript `TextChatServiceClient` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/TextChatServiceClient.client.lua`
- LocalScript `EmoteController` (4) -> `scripts/StarterPlayer/StarterPlayerScripts/EmoteController.client.lua`
- LocalScript `CoinVisualizer` -> `scripts/StarterPlayer/StarterPlayerScripts/CoinVisualizer.client.lua`
- LocalScript `PartSwim` (5) -> `scripts/StarterPlayer/StarterPlayerScripts/PartSwim.client.lua`
- LocalScript `FavoritePrompt` -> `scripts/StarterPlayer/StarterPlayerScripts/FavoritePrompt.client.lua`
- ModuleScript `PlayerModule` (39) -> `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule.lua`
- LocalScript `ToolHandleVisuals` -> `scripts/StarterPlayer/StarterPlayerScripts/ToolHandleVisuals.client.lua`
- LocalScript `Settings` -> `scripts/StarterPlayer/StarterPlayerScripts/Settings.client.lua`
- LocalScript `StatusEffectScript` (6) -> `scripts/StarterPlayer/StarterPlayerScripts/StatusEffectScript.client.lua`
- LocalScript `ClientEventManager` -> `scripts/StarterPlayer/StarterPlayerScripts/ClientEventManager.client.lua`
- LocalScript `Disable` -> `scripts/StarterPlayer/StarterPlayerScripts/Disable.client.lua`
- Folder `WeaponVisuals` (13)
- BindableFunction `MouseLock` (8)
- LocalScript `AnnouncementClient` -> `scripts/StarterPlayer/StarterPlayerScripts/AnnouncementClient.client.lua`
- LocalScript `AdminPanelAccessClient` -> `scripts/StarterPlayer/StarterPlayerScripts/AdminPanelAccessClient.client.lua`
- LocalScript `CMDR` -> `scripts/StarterPlayer/StarterPlayerScripts/CMDR.client.lua`
- LocalScript `AdminBoardPurchaseClient` -> `scripts/StarterPlayer/StarterPlayerScripts/AdminBoardPurchaseClient.client.lua`
- LocalScript `RagdollReplicationClient` -> `scripts/StarterPlayer/StarterPlayerScripts/RagdollReplicationClient.client.lua`
- LocalScript `LiveBoardClient` -> `scripts/StarterPlayer/StarterPlayerScripts/LiveBoardClient.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (63)
- Script `DisplayName` -> `scripts/StarterPlayer/StarterCharacterScripts/DisplayName.server.lua`
- LocalScript `Unfade` -> `scripts/StarterPlayer/StarterCharacterScripts/Unfade.client.lua`
- LocalScript `CharacterClient` -> `scripts/StarterPlayer/StarterCharacterScripts/CharacterClient.client.lua`
- LocalScript `Animate` (58) -> `scripts/StarterPlayer/StarterCharacterScripts/Animate.client.lua`
- LocalScript `Gifter` -> `scripts/StarterPlayer/StarterCharacterScripts/Gifter.client.lua`

**StarterGui** (16 children)

- ScreenGui `CameraFade` (2)
- ScreenGui `CustomGames` (92)
- BillboardGui `InteractGUI` (52)
- ScreenGui `Scoreboard` (378)
- ScreenGui `Scoreboard_Phone` (418)
- ScreenGui `SpawnFade` (4)
- ScreenGui `TouchInteractButtons` (28)
- ScreenGui `TradeGUI` (717)
- ScreenGui `TradeGUI_Phone` (1134)
- ScreenGui `ProcessPending` (6)
- ScreenGui `CrossPlatform` (6174)
- ScreenGui `InputContext` (105)
- ScreenGui `GameTopbar` (64)
- ScreenGui `GameplayControlsUI` (80)
- Folder `Scripts`
- ScreenGui `BackpackUI` (46)

**StarterPack** (1 children)

- Folder `Toys`

**Workspace** (13 children)

- Script `LoadLobby` -> `scripts/Workspace/LoadLobby.server.lua`
- Script `ServerVersion` (1) -> `scripts/Workspace/ServerVersion.server.lua`
- Folder `GameSettings`
- Folder `PetContainer`
- Folder `WeaponDisplays`
- Terrain `Terrain`
- Part `RoundTimerPart` (6)
- Camera `Camera`
- Model `Lobby` (9368)
- Script `ADMIN GAMEPASS PANEL TUTORIAL` -> `scripts/Workspace/ADMIN GAMEPASS PANEL TUTORIAL.server.lua`
- Script `TUTORIAL READ ME` -> `scripts/Workspace/TUTORIAL READ ME.server.lua`
- Script `SpoofTutorial` -> `scripts/Workspace/SpoofTutorial.server.lua`
- Model `LiveBoard` (114)

## UI roots

- ScreenGui `CameraFade` (2 descendants)
- ScreenGui `CustomGames` (92 descendants) [disabled]
- ScreenGui `Scoreboard` (378 descendants)
- ScreenGui `Scoreboard_Phone` (418 descendants)
- ScreenGui `SpawnFade` (4 descendants)
- ScreenGui `TouchInteractButtons` (28 descendants)
- ScreenGui `TradeGUI` (717 descendants) [disabled]
- ScreenGui `TradeGUI_Phone` (1134 descendants) [disabled]
- ScreenGui `ProcessPending` (6 descendants)
- ScreenGui `CrossPlatform` (6174 descendants)
- ScreenGui `InputContext` (105 descendants)
- ScreenGui `GameTopbar` (64 descendants)
- ScreenGui `GameplayControlsUI` (80 descendants)
- Folder `Scripts` (0 descendants)
- ScreenGui `BackpackUI` (46 descendants)
- ScreenGui `Loading` (11 descendants)
- ScreenGui `GamemodePhone` (26 descendants)
- ScreenGui `GamemodeBonus` (37 descendants)
- ScreenGui `Join_Old` (12 descendants)
- ScreenGui `JoinPhone` (12 descendants)
- ScreenGui `DeviceSelect` (20 descendants)
- ScreenGui `Gamemode` (37 descendants)
- ScreenGui `Join` (34 descendants)
- ScreenGui `Loading_Clean` (13 descendants)
- ScreenGui `DeathFade` (1 descendants)
- ScreenGui `VictorySlideConcept` (113 descendants) [disabled]
- ScreenGui `Victory` (351 descendants)
- ScreenGui `TrapGUI` (5 descendants) [disabled]
- ScreenGui `StatusEffectGui` (5 descendants)
- ScreenGui `MysteryBoxOpen` (93 descendants)
- ScreenGui `Unboxing` (88 descendants)
- ScreenGui `Hatching` (10 descendants)
- ScreenGui `MainNew` (66 descendants)
- ScreenGui `MainPC` (4450 descendants)
- ScreenGui `MainMobile` (6175 descendants)
- ScreenGui `MainXbox` (1107 descendants)
- ScreenGui `SprayGui` (5 descendants)
- ScreenGui `SpawnFade` (4 descendants)
- plus 258 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 9994 lines, module: `scripts/ReplicatedStorage/Database/Sync/Item.lua`
- 9994 lines, module: `scripts/ServerStorage/Database/SyncBackup_DO_NOT_DELETE/Item.lua`
- 3595 lines, module: `scripts/ServerScriptService/GameScript/DataModule.lua`
- 3010 lines, module: `scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/DataModule.lua`
- 3010 lines, module: `scripts/ServerStorage/ProfileStatsImportBackup/ProfileStatsFromCoolGame/DataModule.lua`
- 3010 lines, module: `scripts/ServerStorage/ImportBackups/CodeBoardRewardTransferPack/DataModule.lua`
- 1749 lines, module: `scripts/ServerScriptService/GameScript/GameModes/Classic/RagdollService.lua`
- 1419 lines, module: `scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/@quenty/attributeutils/node_modules/@quenty/rx/Shared/Rx.lua`
- 1301 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/ClickToMoveController.lua`
- 1112 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PartSwim/SwimController/Maid/Promise.lua`
- 1107 lines, module: `scripts/ReplicatedStorage/Database/Sync/Effects.lua`
- 1107 lines, module: `scripts/ServerStorage/Database/SyncBackup_DO_NOT_DELETE/Effects.lua`
- 1092 lines, module: `scripts/ServerScriptService/GameScript/GameModes/Classic.lua`
- 1060 lines, client: `scripts/ReplicatedStorage/GUI/MainXbox/Menu/Shop_Data_Xbox.client.lua`
- 1044 lines, module: `scripts/ReplicatedStorage/Database/Sync/Materials.lua`
- 1044 lines, module: `scripts/ServerStorage/Database/SyncBackup_DO_NOT_DELETE/Materials.lua`
- 960 lines, module: `scripts/ReplicatedStorage/Modules/InventoryModule.lua`
- 907 lines, module: `scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/@quenty/blend/Shared/Blend/Blend.lua`
- 869 lines, module: `scripts/ReplicatedStorage/Modules/ShopModule.lua`
- 845 lines, module: `scripts/ReplicatedStorage/Database/Sync/SalvageRewards.lua`

## Scan

- Flags: 0 HIGH, 9 MED (details in flags.txt)
- Monetization ids in code: 37
- Scripts with decompiler headers: 407; empty scripts: 9
- 345 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Part: 53536
- MeshPart: 15943
- Model: 8152
- Frame: 7650
- TextLabel: 5822
- ImageLabel: 4642
- WedgePart: 3369
- SpecialMesh: 2405
- Attachment: 2258
- Vector3Value: 1710
- CylinderMesh: 1689
- UnionOperation: 1671
- TextButton: 1399
- ManualWeld: 1261
- Tool: 1139
- UIListLayout: 910
- ParticleEmitter: 878
- UIStroke: 849
- Weld: 717
- BlockMesh: 711
- ModuleScript: 695
- UIPadding: 682
- UICorner: 594
- UIAspectRatioConstraint: 573
- UIGradient: 467
