# Grow A Garden 2 -

Source: `C:/Users/wnott/Downloads\Grow A Garden 2 -.rbxl`  
137012 instances, 181 classes, 1122 scripts (245773 lines), 41 remotes, 1168 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 32949 | 1/5/4 |
| SoundService | SoundService | 182 |  |
| ReplicatedFirst | ReplicatedFirst | 20 | 0/2/1 |
| MaterialService | MaterialService | 32 | 0/0/1 |
| TextChatService | TextChatService | 21 |  |
| StarterPlayer | StarterPlayer | 36112 | 0/16/242 |
| StarterPack | StarterPack | 13 | 0/1/1 |
| StarterGui | StarterGui | 6318 | 0/81/0 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| ReplicatedStorage | ReplicatedStorage | 60632 | 9/21/625 |
| ServerScriptService | ServerScriptService | 123 | 28/0/83 |
| ServerStorage | ServerStorage | 530 |  |
| Lighting | Lighting | 14 |  |
| README | Script | 0 | 1/0/0 |

(43 empty services not listed)

## Key containers

**ServerScriptService** (31 children)

- Folder `ServerPackages` (89)
- Folder `UserGenerated` (3)
- Script `_DebugPlot` -> `scripts/ServerScriptService/_DebugPlot.server.lua`
- Script `TutorialService` -> `scripts/ServerScriptService/TutorialService.server.lua`
- Script `Script` -> `scripts/ServerScriptService/Script.server.lua`
- Script `SeedPackService` -> `scripts/ServerScriptService/SeedPackService.server.lua`
- Script `ServerBootstrap` -> `scripts/ServerScriptService/ServerBootstrap.server.lua`
- Script `TimeCycleServer` -> `scripts/ServerScriptService/TimeCycleServer.server.lua`
- Script `WeatherService` -> `scripts/ServerScriptService/WeatherService.server.lua`
- Script `WildPetService` -> `scripts/ServerScriptService/WildPetService.server.lua`
- Script `_DiagServer` -> `scripts/ServerScriptService/_DiagServer.server.lua`
- Script `__MCP_CommandListener` -> `scripts/ServerScriptService/__MCP_CommandListener.server.lua`
- ModuleScript `GameServerAPI` -> `scripts/ServerScriptService/GameServerAPI.lua`
- Script `SocialPopupService` -> `scripts/ServerScriptService/SocialPopupService.server.lua`
- Script `RainbowSeedService` -> `scripts/ServerScriptService/RainbowSeedService.server.lua`
- Script `PlantService` -> `scripts/ServerScriptService/PlantService.server.lua`
- Script `PetEquipService` -> `scripts/ServerScriptService/PetEquipService.server.lua`
- Script `PetBehaviorService` -> `scripts/ServerScriptService/PetBehaviorService.server.lua`
- Script `OpSprinklerService` -> `scripts/ServerScriptService/OpSprinklerService.server.lua`
- Script `OpSeedSizeService` -> `scripts/ServerScriptService/OpSeedSizeService.server.lua`
- Script `OpSeedAdminCommand` -> `scripts/ServerScriptService/OpSeedAdminCommand.server.lua`
- Script `MailboxService` -> `scripts/ServerScriptService/MailboxService.server.lua`
- Script `HugePetsService` -> `scripts/ServerScriptService/HugePetsService.server.lua`
- Script `GearUsageService` -> `scripts/ServerScriptService/GearUsageService.server.lua`
- Script `GearService` -> `scripts/ServerScriptService/GearService.server.lua`
- Script `GameServer` -> `scripts/ServerScriptService/GameServer.server.lua`
- Script `CmdrPetCommands` -> `scripts/ServerScriptService/CmdrPetCommands.server.lua`
- Script `DevProductService` -> `scripts/ServerScriptService/DevProductService.server.lua`
- Script `ExclusiveShopService` -> `scripts/ServerScriptService/ExclusiveShopService.server.lua`
- Script `AdminCommandBridge` -> `scripts/ServerScriptService/AdminCommandBridge.server.lua`
- Script `CrateShopService` -> `scripts/ServerScriptService/CrateShopService.server.lua`

**ServerStorage** (2 children)

- Model `RBX_ANIMSAVES` (3)
- Model `Plot` (525)

**ReplicatedStorage** (30 children)

- ModuleScript `UGApp` -> `scripts/ReplicatedStorage/UGApp.lua`
- ModuleScript `UserGenerated` (132) -> `scripts/ReplicatedStorage/UserGenerated.lua`
- ModuleScript `CmdrClient` (187) -> `scripts/ReplicatedStorage/CmdrClient.lua`
- Folder `Assets` (58389)
- Folder `PlantGenerationModules` (1136)
- Folder `ClientModules` (90)
- Folder `ProximityPromptTemplates` (26)
- Folder `SharedModules` (455)
- Folder `SharedData` (7)
- Folder `StockValues` (90)
- Folder `ServerValues` (5)
- ObjectValue `TopbarPlusReference`
- Folder `Design` (54)
- Folder `ReplicaShared` (4)
- NumberValue `SIMULATION_SPEED_MULTIPLIER`
- Folder `Remotes` (2)
- Folder `Modules` (1)
- Folder `RemoteEvents` (12)
- ObjectValue `ZonePlusReference` (1)
- BoolValue `Night`
- Folder `WeatherValues` (9)
- Folder `GardenZoneData`
- Folder `ClaudeDepReport` (2)
- RemoteEvent `CmdrGivePet`
- BindableEvent `Notify`
- RemoteEvent `SocialPopupRemote`
- RemoteEvent `USocialEvent`
- BindableEvent `SocialEvent`
- RemoteEvent `FlyRemote`
- RemoteEvent `RainbowShovelDelete`

**ReplicatedFirst** (3 children)

- LocalScript `LoadingScreenController` -> `scripts/ReplicatedFirst/LoadingScreenController.client.lua`
- ModuleScript `UserGenerated` (2) -> `scripts/ReplicatedFirst/UserGenerated.lua`
- Part `LoadingScreenMenu` (15)

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (36104)
- LocalScript `ControllerStarter` -> `scripts/StarterPlayer/StarterPlayerScripts/ControllerStarter.client.lua`
- LocalScript `Weld` -> `scripts/StarterPlayer/StarterPlayerScripts/Weld.client.lua`
- LocalScript `HideCollectProximityPrompts` -> `scripts/StarterPlayer/StarterPlayerScripts/HideCollectProximityPrompts.client.lua`
- ModuleScript `TEMPLATE_CONTROLLER` -> `scripts/StarterPlayer/StarterPlayerScripts/TEMPLATE_CONTROLLER.lua`
- LocalScript `InfiniteGradient` -> `scripts/StarterPlayer/StarterPlayerScripts/InfiniteGradient.client.lua`
- LocalScript `DisableResetButton` -> `scripts/StarterPlayer/StarterPlayerScripts/DisableResetButton.client.lua`
- LocalScript `LimitedShop` (9) -> `scripts/StarterPlayer/StarterPlayerScripts/LimitedShop.client.lua`
- LocalScript `Msuhroom` -> `scripts/StarterPlayer/StarterPlayerScripts/Msuhroom.client.lua`
- LocalScript `DisableGamepadPlayerList` -> `scripts/StarterPlayer/StarterPlayerScripts/DisableGamepadPlayerList.client.lua`
- LocalScript `ChatMessages` -> `scripts/StarterPlayer/StarterPlayerScripts/ChatMessages.client.lua`
- Folder `Controllers` (36081)
- LocalScript `_DiagClient` -> `scripts/StarterPlayer/StarterPlayerScripts/_DiagClient.client.lua`
- LocalScript `SocialPopupClient` -> `scripts/StarterPlayer/StarterPlayerScripts/SocialPopupClient.client.lua`
- LocalScript `FlyController` -> `scripts/StarterPlayer/StarterPlayerScripts/FlyController.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (6)
- LocalScript `Billboard_UI` (4) -> `scripts/StarterPlayer/StarterCharacterScripts/Billboard_UI.client.lua`
- LocalScript `GalaxyTexture` -> `scripts/StarterPlayer/StarterCharacterScripts/GalaxyTexture.client.lua`

**StarterGui** (68 children)

- ScreenGui `RobuxShop` (1161)
- LocalScript `ConsoleIconMapper` -> `scripts/StarterGui/ConsoleIconMapper.client.lua`
- ScreenGui `Message` (56)
- ScreenGui `GuildWeekComplete` (54)
- ScreenGui `GuildShop` (133)
- Folder `WIP`
- ScreenGui `TopNotification` (2)
- ScreenGui `RadialScreenFlash` (7)
- ScreenGui `SignToolChangeTextMenu` (9)
- ScreenGui `Odds` (61)
- ScreenGui `TeleportButtons` (77)
- ScreenGui `RollFrame` (17)
- ScreenGui `PropsFrame` (95)
- ScreenGui `OfflineAnimation` (6)
- ScreenGui `WeatherUI` (95)
- ScreenGui `GardenLevel` (13)
- ScreenGui `TrowelUI` (31)
- ScreenGui `HoldToCollect` (4)
- ScreenGui `HUD` (48)
- ScreenGui `GrowingList` (88)
- ScreenGui `TopNotification` (2)
- ScreenGui `CrateShop` (238)
- ScreenGui `GearShop` (239)
- ScreenGui `Watermark` (4)
- ScreenGui `CustomiseFenceTheme` (288)
- ScreenGui `PlayerSelector` (62)
- ScreenGui `FX_UI`
- ScreenGui `PreRobuxPrompt` (52)
- ScreenGui `PremiumSeedShop` (135)
- ScreenGui `BuildMobile` (4)
- ScreenGui `RainbowEffect` (1)
- Folder `Rainbow Shovel` (23)
- ScreenGui `MushroomUI` (18)
- ScreenGui `HoverUI`
- ScreenGui `Gifting` (50)
- ScreenGui `FlashEffect`
- ScreenGui `VersionHistory` (2)
- ScreenGui `RollFrame_New` (38)
- ScreenGui `CinematicBars` (241)
- ScreenGui `RakeUI` (16)
- ScreenGui `ButtonMash` (20)
- ScreenGui `SeedShop` (422)
- ScreenGui `LoadingGui` (8)
- ScreenGui `Stats`
- ScreenGui `SignChangeTextMenu` (9)
- ScreenGui `TutorialUI` (4)
- ScreenGui `PlayerGardenMarket` (331)
- ScreenGui `Tooltip` (24)
- ScreenGui `MailboxUI` (354)
- ScreenGui `Settings` (104)
- ScreenGui `Guild`
- ScreenGui `ColorPickerGuild` (69)
- ScreenGui `ViewGuildPage` (196)
- ScreenGui `CreateGuild` (117)
- ScreenGui `ViewGuildLeaderboard` (94)
- ScreenGui `LeaveGuild` (47)
- ScreenGui `EditGuild` (126)
- ScreenGui `ViewGuildProgress` (212)
- ScreenGui `PetList` (86)
- ScreenGui `EquipPet` (45)
- ... 8 more

**StarterPack** (3 children)

- ModuleScript `Bloodmoon` -> `scripts/StarterPack/Bloodmoon.lua`
- Tool `Shovel`
- Tool `Shovel Rainbow` (10)

**Workspace** (22 children)

- Camera `Camera` (2)
- Folder `Gnomes`
- Folder `PottedPlantVisuals`
- Folder `Birds`
- Folder `_Gardens`
- Folder `Handles`
- Folder `Teleports` (4)
- Folder `Gardens` (3728)
- Folder `Map` (212)
- Folder `NPCS` (421)
- Folder `HolderFolders` (1)
- Part `Part` (3)
- Folder `Fences`
- Model `Baseplate` (10)
- Folder `Temporary`
- Folder `DroppedItems`
- Folder `PlayerPetReferences`
- Terrain `Terrain` (6)
- Folder `GearScenes` (28540)
- Folder `LeaderBoard`
- Folder `Jail`
- Folder `ShovelRainbow`

## UI roots

- ScreenGui `RobuxShop` (1161 descendants) [disabled]
- LocalScript `ConsoleIconMapper` (0 descendants)
- ScreenGui `Message` (56 descendants) [disabled]
- ScreenGui `GuildWeekComplete` (54 descendants) [disabled]
- ScreenGui `GuildShop` (133 descendants) [disabled]
- Folder `WIP` (0 descendants)
- ScreenGui `TopNotification` (2 descendants)
- ScreenGui `RadialScreenFlash` (7 descendants)
- ScreenGui `SignToolChangeTextMenu` (9 descendants) [disabled]
- ScreenGui `Odds` (61 descendants) [disabled]
- ScreenGui `TeleportButtons` (77 descendants)
- ScreenGui `RollFrame` (17 descendants) [disabled]
- ScreenGui `PropsFrame` (95 descendants) [disabled]
- ScreenGui `OfflineAnimation` (6 descendants)
- ScreenGui `WeatherUI` (95 descendants)
- ScreenGui `GardenLevel` (13 descendants) [disabled]
- ScreenGui `TrowelUI` (31 descendants)
- ScreenGui `HoldToCollect` (4 descendants)
- ScreenGui `HUD` (48 descendants)
- ScreenGui `GrowingList` (88 descendants)
- ScreenGui `TopNotification` (2 descendants)
- ScreenGui `CrateShop` (238 descendants) [disabled]
- ScreenGui `GearShop` (239 descendants) [disabled]
- ScreenGui `Watermark` (4 descendants) [disabled]
- ScreenGui `CustomiseFenceTheme` (288 descendants) [disabled]
- ScreenGui `PlayerSelector` (62 descendants) [disabled]
- ScreenGui `FX_UI` (0 descendants)
- ScreenGui `PreRobuxPrompt` (52 descendants) [disabled]
- ScreenGui `PremiumSeedShop` (135 descendants) [disabled]
- ScreenGui `BuildMobile` (4 descendants)
- ScreenGui `RainbowEffect` (1 descendants)
- Folder `Rainbow Shovel` (23 descendants)
- ScreenGui `MushroomUI` (18 descendants)
- ScreenGui `HoverUI` (0 descendants)
- ScreenGui `Gifting` (50 descendants) [disabled]
- ScreenGui `FlashEffect` (0 descendants)
- ScreenGui `VersionHistory` (2 descendants) [disabled]
- ScreenGui `RollFrame_New` (38 descendants) [disabled]
- ScreenGui `CinematicBars` (241 descendants)
- ScreenGui `RakeUI` (16 descendants)
- ScreenGui `ButtonMash` (20 descendants) [disabled]
- ScreenGui `SeedShop` (422 descendants) [disabled]
- ScreenGui `LoadingGui` (8 descendants)
- ScreenGui `Stats` (0 descendants)
- ScreenGui `SignChangeTextMenu` (9 descendants) [disabled]
- ScreenGui `TutorialUI` (4 descendants)
- ScreenGui `PlayerGardenMarket` (331 descendants) [disabled]
- ScreenGui `Tooltip` (24 descendants)
- ScreenGui `MailboxUI` (354 descendants) [disabled]
- ScreenGui `Settings` (104 descendants) [disabled]
- ScreenGui `Guild` (0 descendants)
- ScreenGui `ColorPickerGuild` (69 descendants) [disabled]
- ScreenGui `ViewGuildPage` (196 descendants) [disabled]
- ScreenGui `CreateGuild` (117 descendants) [disabled]
- ScreenGui `ViewGuildLeaderboard` (94 descendants) [disabled]
- ScreenGui `LeaveGuild` (47 descendants) [disabled]
- ScreenGui `EditGuild` (126 descendants) [disabled]
- ScreenGui `ViewGuildProgress` (212 descendants) [disabled]
- ScreenGui `PetList` (86 descendants) [disabled]
- ScreenGui `EquipPet` (45 descendants) [disabled]
- ScreenGui `GearCinematicBars` (241 descendants)
- ScreenGui `PetInfo` (68 descendants) [disabled]
- ScreenGui `GuildInvite` (64 descendants) [disabled]
- ScreenGui `HoldToSteal` (1 descendants) [disabled]
- ScreenGui `Cmdr` (21 descendants)
- Folder `AdminPanelfree` (0 descendants)
- Folder `Banhammer` (58 descendants)
- ScreenGui `AdminPanel` (159 descendants) [disabled]
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `FadeIn` (1 descendants)
- ScreenGui `Vignette` (2 descendants)
- ScreenGui `FadeIn` (5 descendants)
- ScreenGui `FadeIn` (5 descendants)
- ScreenGui `FadeIn` (5 descendants)
- plus 489 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 4351 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/InventoryController/Main.lua`
- 3546 lines, module: `scripts/ReplicatedStorage/ClaudeDepReport/Page01.lua`
- 3199 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/InventoryController/Main/Utility.lua`
- 3111 lines, module: `scripts/ReplicatedStorage/SharedModules/Packet/Types.lua`
- 2977 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/ViewGuildController.lua`
- 2573 lines, module: `scripts/ReplicatedStorage/UserGenerated/IO/LibDeflate.lua`
- 2505 lines, module: `scripts/ReplicatedStorage/ClientModules/topbarplus.lua`
- 2358 lines, module: `scripts/ReplicatedStorage/ClientModules/Iris/demoWindow.lua`
- 2310 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/MailboxController.lua`
- 2258 lines, module: `scripts/ReplicatedStorage/Assets/Cutscenes/GAGTrailer/FoV.lua`
- 2258 lines, module: `scripts/ReplicatedStorage/Assets/Cutscenes/GAGTrailerNoWalls/FoV.lua`
- 2244 lines, module: `scripts/ServerScriptService/ServerPackages/_Index/lm-loleris_profilestore@1.0.3/profilestore.lua`
- 2155 lines, client: `scripts/StarterGui/PropsFrame/Controller2.client.lua`
- 1906 lines, module: `scripts/ReplicatedStorage/SharedModules/Zone.lua`
- 1877 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/EditGuildController.lua`
- 1877 lines, module: `scripts/ReplicatedStorage/UserGenerated/Lang/Asserts.lua`
- 1870 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/PetVisualController.lua`
- 1866 lines, server: `scripts/ServerScriptService/PlantService.server.lua`
- 1800 lines, server: `scripts/ServerScriptService/Script.server.lua`
- 1678 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Controllers/StealController.lua`

## Scan

- Flags: 0 HIGH, 4 MED (details in flags.txt)
- Monetization ids in code: 35
- Scripts with decompiler headers: 20; empty scripts: 0
- 19 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Pose: 59896
- Part: 32558
- Keyframe: 10483
- Model: 5708
- IntValue: 4330
- MeshPart: 2925
- UIStroke: 1682
- ImageLabel: 1520
- Attachment: 1483
- TextLabel: 1426
- WeldConstraint: 1217
- Motor6D: 1064
- ParticleEmitter: 969
- ModuleScript: 957
- Folder: 938
- Frame: 877
- UIGradient: 860
- ProximityPrompt: 729
- Decal: 581
- SpecialMesh: 581
- UIAspectRatioConstraint: 569
- StringValue: 443
- BillboardGui: 390
- UnionOperation: 364
- TextButton: 289
