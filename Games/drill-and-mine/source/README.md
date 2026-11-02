# +1 Drill & Mine

Source: `C:/Users/wnott/Downloads\+1 Drill & Mine.rbxl`  
250434 instances, 168 classes, 204 scripts (61039 lines), 74 remotes, 1072 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 53796 | 0/4/0 |
| SoundService | SoundService | 35 |  |
| ReplicatedFirst | ReplicatedFirst | 85 | 0/5/0 |
| MaterialService | MaterialService | 7 |  |
| TextChatService | TextChatService | 8 |  |
| StarterPlayer | StarterPlayer | 88 | 0/31/23 |
| StarterGui | StarterGui | 3704 | 0/13/0 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 7 |  |
| ReplicatedStorage | ReplicatedStorage | 9206 | 1/0/62 |
| ServerScriptService | ServerScriptService | 64 | 15/0/37 |
| ServerStorage | ServerStorage | 183371 | 6/4/3 |

(42 empty services not listed)

## Key containers

**ServerScriptService** (16 children)

- Folder `Source` (40)
- Script `WelcomeBadge` -> `scripts/ServerScriptService/WelcomeBadge.server.lua`
- Script `PlayerCollisions` -> `scripts/ServerScriptService/PlayerCollisions.server.lua`
- Folder `ServerPackages` (8)
- Script `IslandBrainrotSpawner` -> `scripts/ServerScriptService/IslandBrainrotSpawner.server.lua`
- Script `IslandLuckyBlockSpawner` -> `scripts/ServerScriptService/IslandLuckyBlockSpawner.server.lua`
- Script `DevChatCommands` -> `scripts/ServerScriptService/DevChatCommands.server.lua`
- Script `DrillSystemServer` -> `scripts/ServerScriptService/DrillSystemServer.server.lua`
- Script `OverheadStatServer` -> `scripts/ServerScriptService/OverheadStatServer.server.lua`
- Script `StrengthClickServer` -> `scripts/ServerScriptService/StrengthClickServer.server.lua`
- Script `RarityItemSpawner` -> `scripts/ServerScriptService/RarityItemSpawner.server.lua`
- Script `DevProductPedestalServer` -> `scripts/ServerScriptService/DevProductPedestalServer.server.lua`
- Script `TutorialService` -> `scripts/ServerScriptService/TutorialService.server.lua`
- Script `ScientistEmoteServer` -> `scripts/ServerScriptService/ScientistEmoteServer.server.lua`
- Script `StrengthLadderServer` -> `scripts/ServerScriptService/StrengthLadderServer.server.lua`
- Script `FavoritePromptServer` -> `scripts/ServerScriptService/FavoritePromptServer.server.lua`

**ServerStorage** (11 children)

- Frame `Axe` (61)
- Model `RBX_ANIMSAVES` (155005)
- Model `TemplateR15` (154)
- Model `TemplateR15` (157)
- Folder `__LootRejects` (10595)
- Folder `__ScientistR6Backup` (280)
- Folder `__ScientistR15Backup` (635)
- Folder `__AnimAuthoringBackup` (16398)
- Folder `__LoadingScreenBackup` (67)
- Folder `__LightingBackup_PreKickDoorImport` (8)
- Folder `__DoorsBackup_GrassSwap`

**ReplicatedStorage** (20 children)

- Folder `Remotes` (84)
- Folder `Source` (65)
- MeshPart `LuckyBlock` (6)
- Folder `MutationVFX` (20)
- Folder `LuckyBlocks` (230)
- Part `Hit-02` (6)
- Folder `Mutations` (27)
- ModuleScript `UnusedAssetIds` -> `scripts/ReplicatedStorage/UnusedAssetIds.lua`
- RemoteEvent `StrengthClickRemote`
- Folder `Effects` (48)
- Folder `Gradients` (16)
- Folder `Brainrots`
- Folder `Axes`
- Folder `Trees`
- Folder `RarityItemsOriginals` (3116)
- Folder `LuckyBlockLoot` (194)
- Folder `RarityItems` (828)
- Folder `Drills` (4543)
- Part `TutorialArrow` (3)
- RemoteEvent `PlayerFavoritedGame`

**ReplicatedFirst** (2 children)

- LocalScript `RemoveLoadingScreen` -> `scripts/ReplicatedFirst/RemoveLoadingScreen.client.lua`
- LocalScript `SoftShutdownClient` (83) -> `scripts/ReplicatedFirst/SoftShutdownClient.client.lua`

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (86)
- LocalScript `RbxCharacterSounds` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- LocalScript `ClickEffect` -> `scripts/StarterPlayer/StarterPlayerScripts/ClickEffect.client.lua`
- LocalScript `MainClient` -> `scripts/StarterPlayer/StarterPlayerScripts/MainClient.client.lua`
- LocalScript `ProximityPromptScript` (26) -> `scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua`
- LocalScript `IslandBrainrotClient` -> `scripts/StarterPlayer/StarterPlayerScripts/IslandBrainrotClient.client.lua`
- LocalScript `DisableResetButton` -> `scripts/StarterPlayer/StarterPlayerScripts/DisableResetButton.client.lua`
- LocalScript `UiStrokeScaler` -> `scripts/StarterPlayer/StarterPlayerScripts/UiStrokeScaler.client.lua`
- LocalScript `UIClickSound` -> `scripts/StarterPlayer/StarterPlayerScripts/UIClickSound.client.lua`
- LocalScript `LuckyBlockBillboardClient` -> `scripts/StarterPlayer/StarterPlayerScripts/LuckyBlockBillboardClient.client.lua`
- LocalScript `AdminConsoleClient` -> `scripts/StarterPlayer/StarterPlayerScripts/AdminConsoleClient.client.lua`
- LocalScript `BillboardVisibility` -> `scripts/StarterPlayer/StarterPlayerScripts/BillboardVisibility.client.lua`
- LocalScript `DrillClient` -> `scripts/StarterPlayer/StarterPlayerScripts/DrillClient.client.lua`
- LocalScript `StrengthClickClient` -> `scripts/StarterPlayer/StarterPlayerScripts/StrengthClickClient.client.lua`
- LocalScript `SurfaceModeController` -> `scripts/StarterPlayer/StarterPlayerScripts/SurfaceModeController.client.lua`
- LocalScript `RarityLootClient` -> `scripts/StarterPlayer/StarterPlayerScripts/RarityLootClient.client.lua`
- LocalScript `TrainingPadClient` -> `scripts/StarterPlayer/StarterPlayerScripts/TrainingPadClient.client.lua`
- LocalScript `VipTagFlowClient` -> `scripts/StarterPlayer/StarterPlayerScripts/VipTagFlowClient.client.lua`
- LocalScript `SkipPadClient` -> `scripts/StarterPlayer/StarterPlayerScripts/SkipPadClient.client.lua`
- LocalScript `TrailShopRainbowClient` -> `scripts/StarterPlayer/StarterPlayerScripts/TrailShopRainbowClient.client.lua`
- LocalScript `SpawnBoardClient` -> `scripts/StarterPlayer/StarterPlayerScripts/SpawnBoardClient.client.lua`
- LocalScript `DevProductDisplayClient` -> `scripts/StarterPlayer/StarterPlayerScripts/DevProductDisplayClient.client.lua`
- LocalScript `RainbowTrailClient` -> `scripts/StarterPlayer/StarterPlayerScripts/RainbowTrailClient.client.lua`
- LocalScript `GrabZoomClient` -> `scripts/StarterPlayer/StarterPlayerScripts/GrabZoomClient.client.lua`
- LocalScript `TutorialController` -> `scripts/StarterPlayer/StarterPlayerScripts/TutorialController.client.lua`
- LocalScript `FxDistanceCuller` -> `scripts/StarterPlayer/StarterPlayerScripts/FxDistanceCuller.client.lua`
- LocalScript `PerfProbe` -> `scripts/StarterPlayer/StarterPlayerScripts/PerfProbe.client.lua`
- LocalScript `BillboardStrokeScaler` -> `scripts/StarterPlayer/StarterPlayerScripts/BillboardStrokeScaler.client.lua`
- LocalScript `PedestalOfferTimerClient` -> `scripts/StarterPlayer/StarterPlayerScripts/PedestalOfferTimerClient.client.lua`
- LocalScript `ShopSunburstSpinClient` -> `scripts/StarterPlayer/StarterPlayerScripts/ShopSunburstSpinClient.client.lua`
- LocalScript `StudsTileFixClient` -> `scripts/StarterPlayer/StarterPlayerScripts/StudsTileFixClient.client.lua`
- LocalScript `Satchel` (28) -> `scripts/StarterPlayer/StarterPlayerScripts/Satchel.client.lua`
- StarterCharacterScripts `StarterCharacterScripts`

**StarterGui** (8 children)

- ImageLabel `ImageLabel`
- ScreenGui `GUI` (3599)
- BillboardGui `PodiumBillboard` (32)
- BillboardGui `StorageBillboard` (5)
- BillboardGui `CashPodium` (12)
- SurfaceGui `UpgradeUI` (23)
- SurfaceGui `UpgradeBase` (25)
- LocalScript `PromptFavorite` -> `scripts/StarterGui/PromptFavorite.client.lua`

**StarterPack** (0 children)


**Workspace** (125 children)

- Camera `Camera`
- Terrain `Terrain`
- Folder `Assets` (28255)
- Folder `Lbs` (895)
- ParticleEmitter `confettiemitter`
- Model `Tree` (18)
- Folder `DestroyPart Zone1` (516)
- Model `THUMB` (1208)
- Folder `SpawnBoard` (32)
- Folder `DestroyPart Zone30` (513)
- Folder `DestroyPart Zone2` (516)
- Folder `DestroyPart Zone3` (516)
- Folder `DestroyPart Zone4` (516)
- Folder `DestroyPart Zone5` (516)
- Folder `DestroyPart Zone6` (516)
- Folder `DestroyPart Zone7` (516)
- Folder `DestroyPart Zone8` (516)
- Folder `DestroyPart Zone9` (516)
- Folder `DestroyPart Zone10` (516)
- Folder `DestroyPart Zone11` (516)
- Folder `DestroyPart Zone12` (516)
- Folder `DestroyPart Zone13` (516)
- Folder `DestroyPart Zone14` (516)
- Folder `DestroyPart Zone15` (516)
- Folder `DestroyPart Zone16` (516)
- Folder `DestroyPart Zone17` (516)
- Folder `DestroyPart Zone18` (516)
- Folder `DestroyPart Zone19` (516)
- Folder `DestroyPart Zone20` (516)
- Folder `DestroyPart Zone21` (516)
- Folder `DestroyPart Zone22` (516)
- Folder `DestroyPart Zone23` (516)
- Folder `DestroyPart Zone24` (516)
- Folder `DestroyPart Zone25` (516)
- Folder `DestroyPart Zone26` (516)
- Folder `DestroyPart Zone27` (516)
- Folder `DestroyPart Zone28` (516)
- Folder `DestroyPart Zone29` (516)
- UnionOperation `Union`
- Model `Tree` (18)
- Model `Tree` (18)
- Model `Tree` (18)
- Model `Tree` (18)
- UnionOperation `Union`
- UnionOperation `Union`
- UnionOperation `Union`
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- Model `Grass` (3)
- ... 65 more

## UI roots

- ImageLabel `ImageLabel` (0 descendants)
- ScreenGui `GUI` (3599 descendants)
- LocalScript `PromptFavorite` (0 descendants)
- ScreenGui `Removal` (21 descendants)
- ScreenGui `Addition` (21 descendants)
- ScreenGui `ShutdownUI` (37 descendants)
- ScreenGui `TutorialMessage` (6 descendants) [disabled]
- ScreenGui `TradeRequest` (29 descendants) [disabled]
- ScreenGui `TeleportButtons` (29 descendants) [disabled]
- ScreenGui `Tabs` (1302 descendants)
- ScreenGui `SuccessMessage` (4 descendants) [disabled]
- ScreenGui `ScreenGui` (182 descendants)
- ScreenGui `RobuxPrompts` (0 descendants) [disabled]
- ScreenGui `Notification` (5 descendants) [disabled]
- ScreenGui `Menus` (0 descendants) [disabled]
- ScreenGui `Loading` (4 descendants) [disabled]
- ScreenGui `GlobalNotifications` (2 descendants)
- ScreenGui `GiftRequest` (29 descendants) [disabled]
- ScreenGui `GearShop` (668 descendants) [disabled]
- ScreenGui `Error` (5 descendants) [disabled]
- ScreenGui `DropGui` (11 descendants) [disabled]
- ScreenGui `CurrentArea` (4 descendants) [disabled]
- ScreenGui `CentreNotification` (3 descendants) [disabled]
- ScreenGui `CentreError` (4 descendants) [disabled]
- ScreenGui `BottomRight` (5 descendants)
- ScreenGui `BottomLeft` (0 descendants)
- plus 746 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 2762 lines, module: `scripts/ReplicatedStorage/Source/Controllers/PodiumController.lua`
- 2679 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/IslandBrainrotClient.client.lua`
- 2507 lines, module: `scripts/ServerScriptService/ServerPackages/_Index/firebird702_profileservice@1.1.0/profileservice.lua`
- 2178 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua`
- 1970 lines, module: `scripts/ServerScriptService/Source/Services/PodiumService.lua`
- 1577 lines, module: `scripts/ReplicatedStorage/Source/Configs/GameConfig.lua`
- 1315 lines, module: `scripts/ReplicatedStorage/Source/Modules/AnimatedText.lua`
- 1153 lines, module: `scripts/ReplicatedStorage/Source/Controllers/LuckyBlockController.lua`
- 1098 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel/Packages/_Index/legitatx_topbarplus@3.0.5/topbarplus.lua`
- 1073 lines, server: `scripts/ServerScriptService/DrillSystemServer.server.lua`
- 1067 lines, module: `scripts/ReplicatedStorage/Source/Controllers/TreeAreaController.lua`
- 1052 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/RarityLootClient.client.lua`
- 1047 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/DrillClient.client.lua`
- 1015 lines, module: `scripts/ReplicatedStorage/Source/Controllers/BrainrotController.lua`
- 877 lines, server: `scripts/ServerScriptService/RarityItemSpawner.server.lua`
- 830 lines, module: `scripts/ReplicatedStorage/Source/Controllers/LootBlockController.lua`
- 826 lines, module: `scripts/ReplicatedStorage/Source/Controllers/DailyRewardController.lua`
- 803 lines, client: `scripts/Workspace/Lbs/TopRebirth/Humanoids/1/Animate.client.lua`
- 803 lines, client: `scripts/Workspace/Lbs/TopCash/Humanoids/1/Animate.client.lua`
- 801 lines, module: `scripts/ReplicatedStorage/Source/Modules/FrameAnimator.lua`

## Scan

- Flags: 0 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 99
- Scripts with decompiler headers: 0; empty scripts: 0
- Parser skipped 1 property columns: Terrain.VoxelGridAssetContentMap (type 0x23): unknown property type 0x23

## Most common classes

- Pose: 152601
- Texture: 38985
- Part: 10060
- IntValue: 9418
- Keyframe: 7741
- Weld: 4516
- UIStroke: 3659
- TextLabel: 2454
- Attachment: 1653
- ImageLabel: 1602
- UIGradient: 1468
- UIAspectRatioConstraint: 1366
- Model: 1255
- Frame: 1193
- BoolValue: 1127
- ParticleEmitter: 1056
- CFrameValue: 740
- Vector3Value: 704
- MeshPart: 694
- Folder: 672
- UICorner: 581
- SurfaceGui: 523
- UIPadding: 521
- PointLight: 469
- UIListLayout: 428
