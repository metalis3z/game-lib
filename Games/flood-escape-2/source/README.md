# Flood Escape 2 🌊

Source: `C:/Users/wnott/Downloads\Flood Escape 2 🌊.rbxl`  
60074 instances, 170 classes, 262 scripts (32037 lines), 184 remotes, 2284 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 2426 | 14/0/6 |
| SoundService | SoundService | 7 |  |
| Players | Players | 1 |  |
| ReplicatedFirst | ReplicatedFirst | 1 | 0/1/0 |
| TextChatService | TextChatService | 4 |  |
| StarterPlayer | StarterPlayer | 313 | 1/15/35 |
| StarterGui | StarterGui | 594 | 0/9/0 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 10 |  |
| ReplicatedStorage | ReplicatedStorage | 12364 | 52/22/8 |
| ServerScriptService | ServerScriptService | 1799 | 13/5/3 |
| ServerStorage | ServerStorage | 42496 | 70/7/1 |

(38 empty services not listed)

## Key containers

**ServerScriptService** (4 children)

- Script `SV_MAIN_GameScript` (1792) -> `scripts/ServerScriptService/SV_MAIN_GameScript.server.lua`
- ModuleScript `MapScript` -> `scripts/ServerScriptService/MapScript.lua`
- Folder `Misc` (3)
- Script `ADDEDCUSTOM` -> `scripts/ServerScriptService/ADDEDCUSTOM.server.lua`

**ServerStorage** (7 children)

- Folder `TimelineHolder`
- Folder `Maps` (40587)
- Folder `Bindables` (35)
- Folder `DevTools` (6)
- Folder `UnusedMaps`
- Folder `ADDEDCUSTOM` (1861)
- Configuration `AssetManager`

**ReplicatedStorage** (9 children)

- Folder `Remote` (82)
- Folder `Animations` (16)
- Folder `SharedModules` (8)
- Configuration `Config` (1)
- Folder `Items` (8815)
- Folder `TitleScreenResources` (2688)
- Folder `Flags` (4)
- Folder `GuiBackup` (741)
- Folder `MoonVFXAssets`

**ReplicatedFirst** (1 children)

- LocalScript `LocalScript` -> `scripts/ReplicatedFirst/LocalScript.client.lua`

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (294)
- LocalScript `CL_TimelineWrapper` -> `scripts/StarterPlayer/StarterPlayerScripts/CL_TimelineWrapper.client.lua`
- LocalScript `CL_MAIN_GameScript` (34) -> `scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua`
- Folder `Misc` (14)
- LocalScript `CL_NotifHandler` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/CL_NotifHandler.client.lua`
- ModuleScript `PlayerModule` (35) -> `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule.lua`
- LocalScript `CL_EntryScript` (182) -> `scripts/StarterPlayer/StarterPlayerScripts/CL_EntryScript.client.lua`
- Folder `BGM_Folder`
- LocalScript `CL_GhostPlayers` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/CL_GhostPlayers.client.lua`
- Folder `SFX_Folder` (17)
- Folder `MoonVFX`
- StarterCharacterScripts `StarterCharacterScripts` (17)
- LocalScript `CharSpecs` (3) -> `scripts/StarterPlayer/StarterCharacterScripts/CharSpecs.client.lua`
- Script `NoLayeredClothing` -> `scripts/StarterPlayer/StarterCharacterScripts/NoLayeredClothing.server.lua`
- LocalScript `CL_RescueVisual` -> `scripts/StarterPlayer/StarterCharacterScripts/CL_RescueVisual.client.lua`
- LocalScript `Animate` (7) -> `scripts/StarterPlayer/StarterCharacterScripts/Animate.client.lua`
- LocalScript `CL_AntiWallhop` (1) -> `scripts/StarterPlayer/StarterCharacterScripts/CL_AntiWallhop.client.lua`
- LocalScript `CL_CornerClip` -> `scripts/StarterPlayer/StarterCharacterScripts/CL_CornerClip.client.lua`

**StarterGui** (9 children)

- ScreenGui `GameGui` (519)
- LocalScript `ProductWindows_Script` -> `scripts/StarterGui/ProductWindows_Script.client.lua`
- ScreenGui `NotifGui` (51)
- ScreenGui `LiftWaitVisual` (7)
- ScreenGui `PerformanceStats` (3)
- ScreenGui `Locator` (4)
- LocalScript `SocialGuiDash` -> `scripts/StarterGui/SocialGuiDash.client.lua`
- ScreenGui `Vignette` (1)
- Folder `MapUI_Folder`

**StarterPack** (0 children)


**Workspace** (10 children)

- Terrain `Terrain`
- Model `Multiplayer` (1)
- Model `Lobby` (2405)
- Part `Destroyer` (1)
- Model `Buddies`
- Camera `Camera`
- Folder `UseThisToGetAnims(Delete if u want)`
- Script `README` -> `scripts/Workspace/README.server.lua`
- Folder `HD Admin` (9)
- Folder `AssetManager`

## UI roots

- ScreenGui `GameGui` (519 descendants)
- LocalScript `ProductWindows_Script` (0 descendants)
- ScreenGui `NotifGui` (51 descendants)
- ScreenGui `LiftWaitVisual` (7 descendants) [disabled]
- ScreenGui `PerformanceStats` (3 descendants) [disabled]
- ScreenGui `Locator` (4 descendants)
- LocalScript `SocialGuiDash` (0 descendants)
- ScreenGui `Vignette` (1 descendants) [disabled]
- Folder `MapUI_Folder` (0 descendants)
- ScreenGui `EntryGui` (174 descendants)
- ScreenGui `FormGui` (109 descendants)
- ScreenGui `GameGui` (557 descendants)
- ScreenGui `LiftWaitVisual` (7 descendants) [disabled]
- ScreenGui `Locator` (4 descendants)
- ScreenGui `NotifGui` (51 descendants)
- ScreenGui `PerformanceStats` (3 descendants) [disabled]
- ScreenGui `Vignette` (1 descendants) [disabled]
- ScreenGui `MenuGui` (1190 descendants)
- ScreenGui `MapUI` (2 descendants)
- ScreenGui `MapUI` (2 descendants)
- plus 315 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 2699 lines, server: `scripts/ServerScriptService/SV_MAIN_GameScript.server.lua`
- 2614 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua` [disabled]
- 2052 lines, module: `scripts/ReplicatedStorage/SharedModules/ChinaPolicyService.lua`
- 1168 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/ClickToMoveController.lua`
- 840 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/CameraModule/BaseCamera.lua`
- 675 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule.lua`
- 646 lines, module: `scripts/ReplicatedStorage/SharedModules/QS.lua`
- 642 lines, client: `scripts/StarterPlayer/StarterCharacterScripts/Animate.client.lua`
- 599 lines, module: `scripts/ReplicatedStorage/SharedModules/TimelinePlayer.lua`
- 587 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DynamicThumbstick.lua`
- 577 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/CameraModule.lua`
- 563 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/CameraModule/CameraInput.lua`
- 553 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/CameraModule/Invisicam.lua`
- 531 lines, server: `scripts/ServerScriptService/SV_MAIN_GameScript/Animate.server.lua` [disabled]
- 513 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/CameraModule/VRVehicleCamera.lua`
- 485 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/ClickToMoveDisplay.lua`
- 462 lines, client: `scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript.client.lua`
- 458 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/VRNavigation.lua`
- 425 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/PlayerModule/CameraModule/VRBaseCamera.lua`
- 396 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/CL_EntryScript.client.lua`

## Scan

- Flags: 2 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 10
- Scripts with decompiler headers: 25; empty scripts: 21
- 5 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Part: 21514
- Texture: 6117
- WedgePart: 4867
- Weld: 3657
- MeshPart: 2564
- Model: 2103
- Attachment: 1871
- TextLabel: 1526
- Folder: 1215
- ParticleEmitter: 1139
- Frame: 1097
- UnionOperation: 938
- SpecialMesh: 897
- UIGradient: 813
- UICorner: 692
- ObjectValue: 617
- Snap: 613
- Beam: 580
- SelectionBox: 574
- Decal: 557
- ImageLabel: 516
- CylinderMesh: 493
- Accessory: 418
- SurfaceLight: 388
- Vector3Value: 357
