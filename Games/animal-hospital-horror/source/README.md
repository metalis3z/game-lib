# Animal modded

Source: `C:/Users/wnott/Downloads\Animal modded.rbxl`  
17688 instances, 164 classes, 373 scripts (61037 lines), 96 remotes, 1230 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 7125 | 8/0/0 |
| SoundService | SoundService | 227 |  |
| ReplicatedFirst | ReplicatedFirst | 19 | 0/2/0 |
| MaterialService | MaterialService | 88 |  |
| TextChatService | TextChatService | 21 |  |
| StarterPlayer | StarterPlayer | 532 | 1/15/50 |
| StarterGui | StarterGui | 1765 | 0/68/3 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 7 |  |
| ReplicatedStorage | ReplicatedStorage | 7795 | 10/50/128 |
| ServerScriptService | ServerScriptService | 40 | 13/0/24 |
| ServerStorage | ServerStorage | 6 |  |
| Teams | Teams | 1 |  |
| README | Script | 0 | 1/0/0 |

(39 empty services not listed)

## Key containers

**ServerScriptService** (37 children)

- ModuleScript `DataService` -> `scripts/ServerScriptService/DataService.lua`
- Script `ServerBootstrap` -> `scripts/ServerScriptService/ServerBootstrap.server.lua`
- ModuleScript `ProfileStore` -> `scripts/ServerScriptService/ProfileStore.lua`
- ModuleScript `CharacterService` -> `scripts/ServerScriptService/CharacterService.lua`
- ModuleScript `PatientService` -> `scripts/ServerScriptService/PatientService.lua`
- ModuleScript `SanityService` -> `scripts/ServerScriptService/SanityService.lua`
- ModuleScript `DoorService` -> `scripts/ServerScriptService/DoorService.lua`
- ModuleScript `DoorsService` -> `scripts/ServerScriptService/DoorsService.lua`
- ModuleScript `CheckInService` -> `scripts/ServerScriptService/CheckInService.lua`
- ModuleScript `MiscService` -> `scripts/ServerScriptService/MiscService.lua`
- ModuleScript `PatientCareService` -> `scripts/ServerScriptService/PatientCareService.lua`
- ModuleScript `ToolService` -> `scripts/ServerScriptService/ToolService.lua`
- ModuleScript `ClassService` -> `scripts/ServerScriptService/ClassService.lua`
- ModuleScript `ShiftService` -> `scripts/ServerScriptService/ShiftService.lua`
- ModuleScript `SupplyService` -> `scripts/ServerScriptService/SupplyService.lua`
- ModuleScript `MinigameService` -> `scripts/ServerScriptService/MinigameService.lua`
- ModuleScript `AnomalyService` -> `scripts/ServerScriptService/AnomalyService.lua`
- ModuleScript `RejectionService` -> `scripts/ServerScriptService/RejectionService.lua`
- ModuleScript `PhotoService` -> `scripts/ServerScriptService/PhotoService.lua`
- Script `ver` -> `scripts/ServerScriptService/ver.server.lua`
- ModuleScript `AnomalyEventService` -> `scripts/ServerScriptService/AnomalyEventService.lua`
- Script `__MCP_CommandListener` -> `scripts/ServerScriptService/__MCP_CommandListener.server.lua`
- Script `Restauracion` -> `scripts/ServerScriptService/Restauracion.server.lua`
- Script `EmergencyDoor` -> `scripts/ServerScriptService/EmergencyDoor.server.lua`
- Script `AmbulanceEvent` -> `scripts/ServerScriptService/AmbulanceEvent.server.lua`
- ModuleScript `AnomalyDirector` -> `scripts/ServerScriptService/AnomalyDirector.lua`
- Script `MorphService` -> `scripts/ServerScriptService/MorphService.server.lua`
- ModuleScript `GunService` -> `scripts/ServerScriptService/GunService.lua`
- ModuleScript `ConsumableService` -> `scripts/ServerScriptService/ConsumableService.lua`
- ModuleScript `EmergencyService` -> `scripts/ServerScriptService/EmergencyService.lua`
- Script `StaffDoor` -> `scripts/ServerScriptService/StaffDoor.server.lua`
- Script `MonetizationSpins` -> `scripts/ServerScriptService/MonetizationSpins.server.lua`
- Script `MonetizationBuys` -> `scripts/ServerScriptService/MonetizationBuys.server.lua`
- Script `AdminActionsServer` -> `scripts/ServerScriptService/AdminActionsServer.server.lua`
- ModuleScript `ToolService1` -> `scripts/ServerScriptService/ToolService1.lua`
- Script `NameTag` (3) -> `scripts/ServerScriptService/NameTag.server.lua`
- Script `favorite` -> `scripts/ServerScriptService/favorite.server.lua`

**ServerStorage** (1 children)

- Model `RBX_ANIMSAVES` (5)

**ReplicatedStorage** (22 children)

- ModuleScript `Lib` -> `scripts/ReplicatedStorage/Lib.lua`
- ModuleScript `Pathfinder` -> `scripts/ReplicatedStorage/Pathfinder.lua`
- ModuleScript `TopbarIcon` (23) -> `scripts/ReplicatedStorage/TopbarIcon.lua`
- ModuleScript `Purse` (33) -> `scripts/ReplicatedStorage/Purse.lua`
- Folder `Util` (79)
- Folder `Tools` (6)
- Folder `Data` (8)
- Folder `Misc` (1715)
- Folder `SoundsNPC` (30)
- Folder `Room`
- Folder `Animations` (35)
- Folder `AnomalyEvents` (18)
- Folder `Faces` (8)
- Folder `AreaDetectors` (65)
- Folder `ShopItemModels` (191)
- Folder `ShopUpgradeScripts` (3)
- Folder `ClassModels` (833)
- Folder `DefaultSoundEvents` (4)
- Folder `NPCs` (4655)
- Folder `GameData` (41)
- Folder `Events` (4)
- Folder `Items` (22)

**ReplicatedFirst** (2 children)

- LocalScript `LocalScript` -> `scripts/ReplicatedFirst/LocalScript.client.lua`
- LocalScript `Preloader` (17) -> `scripts/ReplicatedFirst/Preloader.client.lua`

**StarterPlayer** (3 children)

- StarterPlayerScripts `StarterPlayerScripts` (134)
- LocalScript `Client` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/Client.client.lua`
- ModuleScript `LocalDataHandler` -> `scripts/StarterPlayer/StarterPlayerScripts/LocalDataHandler.lua`
- LocalScript `ProximityPromptScript` (72) -> `scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua`
- Folder `Util` (19)
- Folder `UI` (30)
- LocalScript `ThirdPersonToggle` -> `scripts/StarterPlayer/StarterPlayerScripts/ThirdPersonToggle.client.lua`
- LocalScript `AmbulanceSpin` -> `scripts/StarterPlayer/StarterPlayerScripts/AmbulanceSpin.client.lua`
- LocalScript `SkullSpin` -> `scripts/StarterPlayer/StarterPlayerScripts/SkullSpin.client.lua`
- LocalScript `InfiniteGradient` -> `scripts/StarterPlayer/StarterPlayerScripts/InfiniteGradient.client.lua`
- LocalScript `LocalScript` -> `scripts/StarterPlayer/StarterPlayerScripts/LocalScript.client.lua`
- ModuleScript `FeedbackController` -> `scripts/StarterPlayer/StarterPlayerScripts/FeedbackController.lua`
- LocalScript `FeedbackControllerLoader ` -> `scripts/StarterPlayer/StarterPlayerScripts/FeedbackControllerLoader.client.lua`
- StarterCharacterScripts `StarterCharacterScripts` (97)
- LocalScript `Sound` (68) -> `scripts/StarterPlayer/StarterCharacterScripts/Sound.client.lua`
- LocalScript `MusicZoneLocal` -> `scripts/StarterPlayer/StarterCharacterScripts/MusicZoneLocal.client.lua`
- LocalScript `Animate` (14) -> `scripts/StarterPlayer/StarterCharacterScripts/Animate.client.lua`
- LocalScript `CheckFloor` -> `scripts/StarterPlayer/StarterCharacterScripts/CheckFloor.client.lua`
- LocalScript `RunNotif` -> `scripts/StarterPlayer/StarterCharacterScripts/RunNotif.client.lua`
- Script `RevivePP` (1) -> `scripts/StarterPlayer/StarterCharacterScripts/RevivePP.server.lua`
- LocalScript `CameraFixer` -> `scripts/StarterPlayer/StarterCharacterScripts/CameraFixer.client.lua`
- Attachment `src` (6)
- Model `StarterCharacter` (298)
- BodyColors `Body Colors`
- Humanoid `Humanoid` (14)
- Model `CharacterModel` (69)
- Part `HumanoidRootPart` (6)
- MeshPart `Head` (18)
- MeshPart `RightUpperLeg` (10)
- MeshPart `RightLowerLeg` (8)
- MeshPart `RightFoot` (8)
- MeshPart `LeftUpperLeg` (12)
- MeshPart `LeftLowerLeg` (8)
- MeshPart `LeftFoot` (8)
- MeshPart `UpperTorso` (36)
- MeshPart `LowerTorso` (26)
- MeshPart `LeftUpperArm` (12)
- MeshPart `LeftLowerArm` (8)
- MeshPart `LeftHand` (8)
- MeshPart `RightUpperArm` (12)
- MeshPart `RightLowerArm` (8)
- MeshPart `RightHand` (8)

**StarterGui** (36 children)

- ScreenGui `Coins` (5)
- ScreenGui `Dialogue` (30)
- ScreenGui `Objective` (10)
- ScreenGui `TouchCursor` (3)
- ScreenGui `Vignette` (3)
- ScreenGui `Notifications` (16)
- ScreenGui `Announcement` (4)
- ScreenGui `static` (3)
- ScreenGui `CameraSystem` (24)
- ScreenGui `HeartbeatMinigameUI` (14)
- ScreenGui `Minigame` (52)
- ScreenGui `Sanity` (38)
- SurfaceGui `PhotoUI` (8)
- ScreenGui `MOBILE_BUTTONS` (10)
- ScreenGui `ConfettiCannon` (5)
- ScreenGui `DontLookUp` (4)
- ScreenGui `EmergencyCounter` (25)
- ScreenGui `Shift` (25)
- ScreenGui `PlayerDied` (26)
- ScreenGui `RoundStatsDetailed` (136)
- ScreenGui `Strikes` (36)
- ScreenGui `InventoryFull` (3)
- ScreenGui `Pointer` (3)
- ScreenGui `BoostDuration` (4)
- SurfaceGui `PhotoUI2` (8)
- ScreenGui `Run` (4)
- ScreenGui `blackscreen` (1)
- ScreenGui `Menu` (5)
- ScreenGui `CharacterSelection` (107)
- ScreenGui `CharacterCreation` (11)
- ScreenGui `Shop` (232)
- ScreenGui `Skins` (60)
- ScreenGui `GiftList` (38)
- ScreenGui `Classes` (192)
- ScreenGui `Actions` (20)
- ScreenGui `AdminPanel` (564)

**StarterPack** (0 children)


**Workspace** (189 children)

- Camera `Camera` (2)
- Model `Model` (36)
- Model `Model` (14)
- Model `Model` (6)
- Model `coffee cup` (2)
- Folder `Lights` (56)
- Model `Model` (3)
- Model `Room` (9)
- Model `Model` (3)
- Model `Model` (5)
- Model `Model` (9)
- Model `coffee cup` (2)
- Model `Model` (4)
- Model `Model` (4)
- Model `Model` (2)
- Model `Model` (4)
- Model `Model` (18)
- Model `Model` (4)
- Model `Model` (4)
- Model `Model` (3)
- Model `White` (3)
- Model `Model` (72)
- Model `MainDoor` (25)
- Model `Trash` (7)
- Model `White` (3)
- Model `Model` (4)
- Model `Model` (12)
- Model `JumpscareMask` (6)
- Model `Model` (2)
- Folder `Rooms` (2883)
- Folder `Misc` (903)
- Model `White` (3)
- Model `Model` (12)
- Model `Model` (2)
- Model `Model` (5)
- Model `Model` (2)
- Sound `music`
- Model `Chair` (2)
- Model `Model`
- Model `Model` (2)
- Model `Model` (7)
- Model `Model` (6)
- Model `Computer` (6)
- Model `Model` (4)
- Model `Model` (13)
- Model `ThreeDTextObject` (1)
- Model `Model` (14)
- Model `Model` (4)
- Model `Model` (72)
- Model `Model` (2)
- Model `File Cabinet` (40)
- Model `Model` (4)
- Model `Model` (5)
- Model `Model` (5)
- Model `Model` (5)
- Model `Model` (5)
- Model `Model` (12)
- Model `Model` (44)
- Model `Model` (6)
- Model `Model` (4)
- ... 129 more

## UI roots

- ScreenGui `Coins` (5 descendants)
- ScreenGui `Dialogue` (30 descendants)
- ScreenGui `Objective` (10 descendants)
- ScreenGui `TouchCursor` (3 descendants) [disabled]
- ScreenGui `Vignette` (3 descendants)
- ScreenGui `Notifications` (16 descendants)
- ScreenGui `Announcement` (4 descendants)
- ScreenGui `static` (3 descendants)
- ScreenGui `CameraSystem` (24 descendants)
- ScreenGui `HeartbeatMinigameUI` (14 descendants)
- ScreenGui `Minigame` (52 descendants)
- ScreenGui `Sanity` (38 descendants)
- ScreenGui `MOBILE_BUTTONS` (10 descendants) [disabled]
- ScreenGui `ConfettiCannon` (5 descendants)
- ScreenGui `DontLookUp` (4 descendants)
- ScreenGui `EmergencyCounter` (25 descendants)
- ScreenGui `Shift` (25 descendants)
- ScreenGui `PlayerDied` (26 descendants)
- ScreenGui `RoundStatsDetailed` (136 descendants)
- ScreenGui `Strikes` (36 descendants)
- ScreenGui `InventoryFull` (3 descendants)
- ScreenGui `Pointer` (3 descendants)
- ScreenGui `BoostDuration` (4 descendants)
- ScreenGui `Run` (4 descendants)
- ScreenGui `blackscreen` (1 descendants)
- ScreenGui `Menu` (5 descendants)
- ScreenGui `CharacterSelection` (107 descendants)
- ScreenGui `CharacterCreation` (11 descendants) [disabled]
- ScreenGui `Shop` (232 descendants)
- ScreenGui `Skins` (60 descendants) [disabled]
- ScreenGui `GiftList` (38 descendants)
- ScreenGui `Classes` (192 descendants)
- ScreenGui `Actions` (20 descendants) [disabled]
- ScreenGui `AdminPanel` (564 descendants)
- ScreenGui `RadioGui` (6 descendants)
- plus 282 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 2512 lines, module: `scripts/ReplicatedStorage/Purse/Packages/_Index/ryanlua_topbarplus@1.0.1/topbarplus.lua`
- 2386 lines, module: `scripts/ReplicatedStorage/Purse/Packages/purse.lua`
- 2243 lines, module: `scripts/ServerScriptService/ProfileStore.lua`
- 2143 lines, server: `scripts/ServerScriptService/ver.server.lua`
- 1304 lines, module: `scripts/ReplicatedStorage/Data/Dialogue.lua`
- 1080 lines, module: `scripts/ReplicatedStorage/TopbarIcon.lua`
- 793 lines, module: `scripts/ReplicatedStorage/Util/NetworkOld.lua`
- 790 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/UI/Cutscenes.lua`
- 723 lines, module: `scripts/ReplicatedStorage/Purse/Packages/_Index/ryanlua_topbarplus@1.0.1/topbarplus/Utility.lua`
- 698 lines, module: `scripts/ReplicatedStorage/TopbarIcon/Utility.lua`
- 687 lines, client: `scripts/StarterPlayer/StarterCharacterScripts/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Officer Duckman/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Doctor/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Ratthew/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Ron from Accounting/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Ratthew2/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Intern/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Clown/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Secretary/Animate.client.lua`
- 654 lines, client: `scripts/ReplicatedStorage/NPCs/UniqueVisitors1/Head Nurse/Animate.client.lua`

## Scan

- Flags: 1 HIGH, 1 MED (details in flags.txt)
- Monetization ids in code: 25
- Scripts with decompiler headers: 44; empty scripts: 2
- 44 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Part: 4441
- Bone: 1788
- MeshPart: 1156
- WeldConstraint: 1010
- Model: 930
- Motor6D: 756
- Sound: 714
- TextLabel: 482
- UIStroke: 459
- Attachment: 430
- Animation: 386
- ImageLabel: 381
- Frame: 278
- SpecialMesh: 273
- Decal: 254
- ModuleScript: 205
- StringValue: 195
- CFrameValue: 189
- Folder: 187
- UIAspectRatioConstraint: 178
- Weld: 175
- BillboardGui: 169
- UIGradient: 162
- CylinderMesh: 156
- ProximityPrompt: 155
