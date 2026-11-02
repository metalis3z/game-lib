# ScooterObby%20(1)

Source: `C:/Users/wnott/Downloads\ScooterObby%20(1).rbxl`  
64504 instances, 136 classes, 834 scripts (25343 lines), 45 remotes, 375 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 20674 | 4/106/0 |
| TextChatService | TextChatService | 7 |  |
| StarterPlayer | StarterPlayer | 11 | 0/8/1 |
| StarterGui | StarterGui | 3995 | 0/217/0 |
| InsertService | InsertService | 1 |  |
| ServerScriptService | ServerScriptService | 47 | 27/0/8 |
| ServerStorage | ServerStorage | 36871 | 4/437/0 |
| ReplicatedStorage | ReplicatedStorage | 2834 | 0/5/15 |
| Lighting | Lighting | 8 |  |
| Teams | Teams | 2 | 0/2/0 |

(44 empty services not listed)

## Key containers

**ServerScriptService** (30 children)

- Script `Server` (1) -> `scripts/ServerScriptService/Server.server.lua`
- ModuleScript `UGCHandler` -> `scripts/ServerScriptService/UGCHandler.lua`
- Folder `Old` (7)
- Script `CurrencyPurchases` -> `scripts/ServerScriptService/CurrencyPurchases.server.lua`
- Script `Reset` -> `scripts/ServerScriptService/Reset.server.lua`
- Script `DataHandler` -> `scripts/ServerScriptService/DataHandler.server.lua`
- Script `ColorShift` -> `scripts/ServerScriptService/ColorShift.server.lua`
- Script `GamepassHandler (Coils)` -> `scripts/ServerScriptService/GamepassHandler (Coils).server.lua`
- Folder `Skips` (1)
- Script `VIPHandler` -> `scripts/ServerScriptService/VIPHandler.server.lua`
- Script `RequestHandler` -> `scripts/ServerScriptService/RequestHandler.server.lua`
- Script `WelcomeBadge` -> `scripts/ServerScriptService/WelcomeBadge.server.lua`
- Script `LBScriptTimer` -> `scripts/ServerScriptService/LBScriptTimer.server.lua`
- Script `SoftShutdown2` -> `scripts/ServerScriptService/SoftShutdown2.server.lua`
- Script `ThrusterScooterAwarder` -> `scripts/ServerScriptService/ThrusterScooterAwarder.server.lua`
- Script `Coins + Inv Save` (2) -> `scripts/ServerScriptService/Coins + Inv Save.server.lua`
- Script `SpinScript` (1) -> `scripts/ServerScriptService/SpinScript.server.lua`
- Script `StageUpdater` (1) -> `scripts/ServerScriptService/StageUpdater.server.lua`
- ModuleScript `SkipHandler` -> `scripts/ServerScriptService/SkipHandler.lua`
- Script `GigaBundleRewarder` -> `scripts/ServerScriptService/GigaBundleRewarder.server.lua`
- ModuleScript `InventoryHandler` -> `scripts/ServerScriptService/InventoryHandler.lua`
- Script `StageSave` -> `scripts/ServerScriptService/StageSave.server.lua`
- Script `HighestStageSave` -> `scripts/ServerScriptService/HighestStageSave.server.lua`
- Folder `CoreScripts` (1)
- ModuleScript `RebirthHandler` -> `scripts/ServerScriptService/RebirthHandler.lua`
- Script `Nuke` (1) -> `scripts/ServerScriptService/Nuke.server.lua`
- Script `WaitPrompt` (1) -> `scripts/ServerScriptService/WaitPrompt.server.lua`
- ModuleScript `WinsHandler` -> `scripts/ServerScriptService/WinsHandler.lua`
- Folder `Sanity` (1)
- Script `ClaimReward` -> `scripts/ServerScriptService/ClaimReward.server.lua`

**ServerStorage** (21 children)

- Folder `TagList` (1)
- BoolValue `SaveInStudio`
- Tool `GravCoil` (4)
- Folder `CSProtocols`
- Folder `PluginCurves`
- Folder `UIPresets`
- Folder `OldUi` (2356)
- Tool `SpeedCoil` (4)
- Model `Skibidi Toilet Scooter` (102)
- Model `DailyRewardPhysical` (27)
- Folder `StagesInRotation` (10434)
- Folder `OutOfRotation` (904)
- IntValue `CurrentMultiplier`
- Folder `PlayersDone`
- Folder `EndTile` (203)
- Folder `World2` (22361)
- Model `Worlds` (37)
- Model `NeonScooterCrate`
- Frame `Exclusive` (47)
- Model `PossibleScooters?` (336)
- Model `OldSpin` (34)

**ReplicatedStorage** (23 children)

- Folder `Module` (1)
- Folder `Resource` (2611)
- Folder `Shared` (1)
- Folder `CollectionServiceScripts` (1)
- Folder `RemoteEvents` (24)
- VectorForce `WindForce`
- Folder `ModuleScripts` (13)
- Folder `Sounds` (6)
- Folder `BoxParts` (29)
- Folder `InventoryAssets` (23)
- Folder `RemoteFunctions` (5)
- Folder `Playlist` (3)
- Folder `SpecialFX` (9)
- Folder `ClientVariables` (2)
- NumberValue `SpeedTimer`
- RemoteEvent `ApplyTime`
- BoolValue `Loaded`
- Folder `Old` (1)
- StringValue `TimeLeft`
- Folder `TopBarAssets` (82)
- IntValue `CurrentMultiplier`
- StringValue `StagesLoaded`
- NumberValue `RawTimeLeft`

**ReplicatedFirst** (0 children)


**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (5)
- LocalScript `VIPNames` -> `scripts/StarterPlayer/StarterPlayerScripts/VIPNames.client.lua`
- LocalScript `SpeedAnnouncement` -> `scripts/StarterPlayer/StarterPlayerScripts/SpeedAnnouncement.client.lua`
- LocalScript `GetPolicyInfo` -> `scripts/StarterPlayer/StarterPlayerScripts/GetPolicyInfo.client.lua`
- LocalScript `StrokeScalerScript` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/StrokeScalerScript.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (4)
- LocalScript `ScooterScript` -> `scripts/StarterPlayer/StarterCharacterScripts/ScooterScript.client.lua`
- LocalScript `CameraScript` -> `scripts/StarterPlayer/StarterCharacterScripts/CameraScript.client.lua`
- LocalScript `Popups` -> `scripts/StarterPlayer/StarterCharacterScripts/Popups.client.lua`
- LocalScript `Run` -> `scripts/StarterPlayer/StarterCharacterScripts/Run.client.lua`

**StarterGui** (16 children)

- LocalScript `DisableResetButton` -> `scripts/StarterGui/DisableResetButton.client.lua`
- ScreenGui `AnimeZoom` (13)
- ScreenGui `Color` (1)
- ScreenGui `DailyReward` (3)
- ScreenGui `Confirmation` (68)
- ScreenGui `OpenSpin` (16)
- ScreenGui `Compass` (3)
- ScreenGui `Countdown` (17)
- ScreenGui `Display` (201)
- ScreenGui `Progession` (31)
- ScreenGui `Version ` (7)
- ScreenGui `SpeedrunTimerGUI` (5)
- ScreenGui `NewUGC` (14)
- ScreenGui `NewScooter` (14)
- ScreenGui `LoadingScreen` (10)
- ScreenGui `GameGUI` (3576)

**StarterPack** (0 children)


**Workspace** (90 children)

- Camera `Camera`
- Folder `Chunk87` (287)
- Folder `Chunk86` (784)
- Folder `Chunk85` (992)
- Model `Scooter` (17)
- Texture `Texture`
- Terrain `Terrain`
- Texture `Texture` (1)
- Folder `Chunk67` (262)
- Folder `Chunk77` (408)
- Model `Model`
- Part `Timer_Pause` (1)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Folder `ScootersModels`
- Texture `Texture` (1)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Folder `Spawn`
- Folder `Chunk71` (268)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Texture `Texture` (1)
- Folder `Obby` (1)
- Folder `Checkpoints`
- Folder `Chunk84` (343)
- Folder `Chunk70` (382)
- Folder `Chunk64` (304)
- Folder `Lobby` (303)
- Folder `Chunk66` (284)
- Folder `Boxes`
- Texture `Texture`
- Folder `Chunk68` (186)
- Folder `Stages`
- Folder `Chunk76` (293)
- Texture `Texture`
- Model `Checkpoint` (12)
- Texture `Texture`
- Texture `Texture`
- Folder `Chunk78` (369)
- Texture `Texture`
- Folder `Ignore`
- Model `Model` (1489)
- Folder `Chunk57` (283)
- Folder `Chunk65` (392)
- Folder `Chunk60` (309)
- Weld `AccessoryWeld`
- Decal `Decal`
- Folder `CurrentMap`
- Folder `Chunk51` (245)
- Folder `Chunk83` (473)
- Folder `Chunk73` (479)
- Folder `Chunk82` (369)
- Model `build`
- Folder `Chunk79` (404)
- Model `Model`
- Model `StreetLamp`
- ... 30 more

## UI roots

- LocalScript `DisableResetButton` (0 descendants)
- ScreenGui `AnimeZoom` (13 descendants)
- ScreenGui `Color` (1 descendants)
- ScreenGui `DailyReward` (3 descendants) [disabled]
- ScreenGui `Confirmation` (68 descendants) [disabled]
- ScreenGui `OpenSpin` (16 descendants)
- ScreenGui `Compass` (3 descendants)
- ScreenGui `Countdown` (17 descendants)
- ScreenGui `Display` (201 descendants)
- ScreenGui `Progession` (31 descendants)
- ScreenGui `Version ` (7 descendants) [disabled]
- ScreenGui `SpeedrunTimerGUI` (5 descendants)
- ScreenGui `NewUGC` (14 descendants) [disabled]
- ScreenGui `NewScooter` (14 descendants) [disabled]
- ScreenGui `LoadingScreen` (10 descendants)
- ScreenGui `GameGUI` (3576 descendants)
- ScreenGui `Version ` (7 descendants) [disabled]
- ScreenGui `Color` (1 descendants) [disabled]
- ScreenGui `Confirmation` (67 descendants) [disabled]
- ScreenGui `DailyReward` (3 descendants) [disabled]
- ScreenGui `GameGUI` (2225 descendants) [disabled]
- ScreenGui `LoadingScreen` (10 descendants) [disabled]
- ScreenGui `NewScooter` (14 descendants) [disabled]
- ScreenGui `Side Gamepasses` (0 descendants) [disabled]
- ScreenGui `SpeedrunTimerGUI` (5 descendants) [disabled]
- ScreenGui `AnimeZoom` (13 descendants) [disabled]
- plus 11883 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 1390 lines, module: `scripts/ReplicatedStorage/ModuleScripts/DataStore2/Promise.lua`
- 613 lines, module: `scripts/ReplicatedStorage/ModuleScripts/DataStore2.lua`
- 556 lines, module: `scripts/ReplicatedStorage/Module/Scooter.lua`
- 431 lines, server: `scripts/ServerScriptService/Server.server.lua`
- 345 lines, module: `scripts/ServerScriptService/InventoryHandler.lua`
- 266 lines, client: `scripts/StarterGui/GameGUI/Frame/ShopFrame/Main/Inside/Content/RightSide/Inside/CrateFrame/ClassicBox1/BuyCoins/Back/Button/CrateSystem.server.lua`
- 224 lines, server: `scripts/ServerScriptService/ClaimReward.server.lua`
- 221 lines, client: `scripts/ReplicatedStorage/CollectionServiceScripts/CheckpointHandler.server.lua`
- 202 lines, module: `scripts/ServerScriptService/Old/InventoryHandler.lua`
- 189 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/StrokeScalerScript/UIStrokeAdjuster.lua`
- 185 lines, server: `scripts/ServerScriptService/CurrencyPurchases.server.lua`
- 174 lines, module: `scripts/ReplicatedStorage/ModuleScripts/Numerics.lua`
- 151 lines, server: `scripts/ServerScriptService/SpinScript.server.lua`
- 149 lines, client: `scripts/StarterGui/GameGUI/Frame/ShopFrame/Main/Inside/Content/RightSide/Inside/CrateFrame/SuperBox1/BuyCoins/Back/Button/CrateSystem.server.lua` [disabled]
- 149 lines, client: `scripts/StarterGui/GameGUI/Frame/ShopFrame/Main/Inside/Content/RightSide/Inside/CrateFrame/SuperBox2/BuyCoins/Back/Button/CrateSystem.server.lua` [disabled]
- 149 lines, client: `scripts/ServerStorage/OldUi/GameGUI/Frame/ShopFrame/Main/Inside/Content/RightSide/Inside/CrateFrame/BuyCoins/Back/Button/CrateSystem.server.lua` [disabled]
- 136 lines, server: `scripts/ServerScriptService/CoreScripts/MapGeneration.server.lua`
- 123 lines, server: `scripts/ServerScriptService/RequestHandler.server.lua`
- 117 lines, client: `scripts/StarterGui/SpeedrunTimerGUI/MainScript.client.lua`
- 117 lines, client: `scripts/ServerStorage/OldUi/SpeedrunTimerGUI/MainScript.client.lua`

## Scan

- Flags: 0 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 31
- Scripts with decompiler headers: 5; empty scripts: 2
- 5 scripts decompiled
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Frame: 20879
- Weld: 12421
- SurfaceGui: 11880
- Part: 4195
- Texture: 2219
- ParticleEmitter: 1505
- MeshPart: 1314
- UICorner: 1044
- UIStroke: 872
- Motor6D: 835
- Model: 833
- ManualWeld: 769
- Script: 688
- TextLabel: 548
- ImageLabel: 536
- UIGradient: 496
- UIAspectRatioConstraint: 479
- Attachment: 406
- Decal: 399
- StringValue: 289
- TextButton: 238
- Folder: 205
- Vector3Value: 199
- Color3Value: 163
- BoolValue: 150
