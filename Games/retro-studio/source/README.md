# Retro-Studio

Source: `C:/Users/wnott/Downloads\Retro-Studio.rbxl`  
396 instances, 95 classes, 125 scripts (15454 lines), 3 remotes, 21 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 3 |  |
| ReplicatedFirst | ReplicatedFirst | 94 | 0/12/3 |
| TextChatService | TextChatService | 4 |  |
| StarterPlayer | StarterPlayer | 54 | 9/21/3 |
| StarterPack | StarterPack | 66 | 22/0/1 |
| InsertService | InsertService | 1 |  |
| ReplicatedStorage | ReplicatedStorage | 10 | 0/0/8 |
| ServerScriptService | ServerScriptService | 23 | 19/1/0 |
| ServerStorage | ServerStorage | 85 | 23/1/2 |
| Lighting | Lighting | 2 |  |

(44 empty services not listed)

## Key containers

**ServerScriptService** (19 children)

- Script `Badges` -> `scripts/ServerScriptService/Badges.server.lua`
- Script `Bevels` -> `scripts/ServerScriptService/Bevels.server.lua`
- Script `Bootup` -> `scripts/ServerScriptService/Bootup.server.lua`
- Script `BuildTools` (1) -> `scripts/ServerScriptService/BuildTools.server.lua`
- Script `CaptureTheFlag` -> `scripts/ServerScriptService/CaptureTheFlag.server.lua`
- Script `Characters` -> `scripts/ServerScriptService/Characters.server.lua`
- Script `Chat` -> `scripts/ServerScriptService/Chat.server.lua`
- Script `Cylinders` (3) -> `scripts/ServerScriptService/Cylinders.server.lua`
- Script `Explosions` -> `scripts/ServerScriptService/Explosions.server.lua`
- Script `ForceFields` -> `scripts/ServerScriptService/ForceFields.server.lua`
- Script `ForceR6InStudio` -> `scripts/ServerScriptService/ForceR6InStudio.server.lua`
- Script `HatGranter` -> `scripts/ServerScriptService/HatGranter.server.lua`
- Script `Heads` -> `scripts/ServerScriptService/Heads.server.lua`
- Script `Leaderboard` -> `scripts/ServerScriptService/Leaderboard.server.lua`
- Script `LoadTools` -> `scripts/ServerScriptService/LoadTools.server.lua`
- Script `Parts` -> `scripts/ServerScriptService/Parts.server.lua`
- Script `Regeneration` -> `scripts/ServerScriptService/Regeneration.server.lua`
- Script `SessionTracker` -> `scripts/ServerScriptService/SessionTracker.server.lua`
- Script `Time` -> `scripts/ServerScriptService/Time.server.lua`

**ServerStorage** (7 children)

- Folder `CharacterAssets` (9)
- Folder `InputGateway` (3)
- Folder `StandardTools` (66)
- BoolValue `EnableBevels`
- StringValue `LoadTools`
- ModuleScript `PlayerDataStore` -> `scripts/ServerStorage/PlayerDataStore.lua`
- Frame `Frame`

**ReplicatedStorage** (5 children)

- Folder `ItemData` (4)
- ModuleScript `AssetUtil` -> `scripts/ReplicatedStorage/AssetUtil.lua`
- ModuleScript `BrickColors` -> `scripts/ReplicatedStorage/BrickColors.lua`
- ModuleScript `PlaceData` -> `scripts/ReplicatedStorage/PlaceData.lua`
- ModuleScript `SafeChat` (1) -> `scripts/ReplicatedStorage/SafeChat.lua`

**ReplicatedFirst** (1 children)

- LocalScript `JoinScript` (93) -> `scripts/ReplicatedFirst/JoinScript.client.lua`

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (36)
- LocalScript `Animator` -> `scripts/StarterPlayer/StarterPlayerScripts/Animator.client.lua`
- LocalScript `Camera` (3) -> `scripts/StarterPlayer/StarterPlayerScripts/Camera.client.lua`
- LocalScript `CharacterBevels` -> `scripts/StarterPlayer/StarterPlayerScripts/CharacterBevels.client.lua`
- LocalScript `Explosions` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/Explosions.client.lua`
- LocalScript `ForceFields` -> `scripts/StarterPlayer/StarterPlayerScripts/ForceFields.client.lua`
- LocalScript `FpsCap` -> `scripts/StarterPlayer/StarterPlayerScripts/FpsCap.client.lua`
- LocalScript `GamepadPatch` -> `scripts/StarterPlayer/StarterPlayerScripts/GamepadPatch.client.lua`
- LocalScript `HumanoidLabels` (4) -> `scripts/StarterPlayer/StarterPlayerScripts/HumanoidLabels.client.lua`
- LocalScript `HumanoidSound` -> `scripts/StarterPlayer/StarterPlayerScripts/HumanoidSound.client.lua`
- LocalScript `LensFlare` -> `scripts/StarterPlayer/StarterPlayerScripts/LensFlare.client.lua`
- LocalScript `Moon` (3) -> `scripts/StarterPlayer/StarterPlayerScripts/Moon.client.lua`
- LocalScript `Music` -> `scripts/StarterPlayer/StarterPlayerScripts/Music.client.lua`
- LocalScript `Sky` (5) -> `scripts/StarterPlayer/StarterPlayerScripts/Sky.client.lua`
- LocalScript `SunRays` (4) -> `scripts/StarterPlayer/StarterPlayerScripts/SunRays.client.lua`
- LocalScript `ToolSoundGlitch` -> `scripts/StarterPlayer/StarterPlayerScripts/ToolSoundGlitch.client.lua`
- BindableEvent `PassCameraEvent`
- StarterCharacterScripts `StarterCharacterScripts` (16)
- Script `Animate` -> `scripts/StarterPlayer/StarterCharacterScripts/Animate.server.lua`
- Script `Bounciness` -> `scripts/StarterPlayer/StarterCharacterScripts/Bounciness.server.lua`
- Script `DropHats` (3) -> `scripts/StarterPlayer/StarterCharacterScripts/DropHats.server.lua`
- Script `GoofyBalance` -> `scripts/StarterPlayer/StarterCharacterScripts/GoofyBalance.server.lua`
- Script `InputGateway` -> `scripts/StarterPlayer/StarterCharacterScripts/InputGateway.server.lua`
- Script `TeamColors` -> `scripts/StarterPlayer/StarterCharacterScripts/TeamColors.server.lua`
- Script `ToolSoundGlitch` -> `scripts/StarterPlayer/StarterCharacterScripts/ToolSoundGlitch.server.lua`
- Script `ToolStuckPatch` -> `scripts/StarterPlayer/StarterCharacterScripts/ToolStuckPatch.server.lua`
- LocalScript `EdgeWalking` -> `scripts/StarterPlayer/StarterCharacterScripts/EdgeWalking.client.lua`
- LocalScript `FloorDrag` -> `scripts/StarterPlayer/StarterCharacterScripts/FloorDrag.client.lua`
- LocalScript `GoofyMotion` -> `scripts/StarterPlayer/StarterCharacterScripts/GoofyMotion.client.lua`
- LocalScript `JumpLimiter` -> `scripts/StarterPlayer/StarterCharacterScripts/JumpLimiter.client.lua`
- LocalScript `RetroClimbing` -> `scripts/StarterPlayer/StarterCharacterScripts/RetroClimbing.client.lua`

**StarterGui** (0 children)


**StarterPack** (12 children)

- Tool `Trowel` (5)
- Tool `Timebomb` (4)
- Tool `Sword` (3)
- Tool `Superball` (4)
- Tool `Slingshot` (5)
- Tool `RocketLauncher` (7)
- Tool `Reset` (2)
- Tool `Plane` (9)
- Tool `PaintballGun` (5)
- Tool `Multirocket` (5)
- Tool `JetBoots` (1)
- Tool `GravityHammer` (4)

**Workspace** (3 children)

- Camera `Camera`
- Part `Part`
- Terrain `Terrain`

## UI roots

- ScreenGui `UI` (92 descendants)
- plus 5 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 1042 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Camera/Main.lua`
- 831 lines, module: `scripts/ServerStorage/PlayerDataStore.lua`
- 666 lines, client: `scripts/ReplicatedFirst/JoinScript/UI/PlayerList/PlayerList.client.lua`
- 609 lines, module: `scripts/ReplicatedStorage/ItemData/Hat.lua`
- 480 lines, server: `scripts/ServerScriptService/Bevels.server.lua`
- 338 lines, server: `scripts/ServerScriptService/CaptureTheFlag.server.lua`
- 311 lines, server: `scripts/StarterPack/Plane/PlaneTool.server.lua`
- 311 lines, server: `scripts/ServerStorage/StandardTools/Plane/PlaneTool.server.lua`
- 310 lines, client: `scripts/ReplicatedFirst/JoinScript/UI/Backpack/Backpack.client.lua`
- 309 lines, client: `scripts/ReplicatedFirst/JoinScript/UI/Mouse/ClickToMove.client.lua`
- 282 lines, server: `scripts/ServerScriptService/Parts.server.lua`
- 276 lines, client: `scripts/StarterPlayer/StarterPlayerScripts/Animator.client.lua`
- 260 lines, client: `scripts/ReplicatedFirst/JoinScript.client.lua`
- 250 lines, client: `scripts/ServerScriptService/BuildTools/Dragger.client.lua` [disabled]
- 243 lines, server: `scripts/ServerScriptService/BuildTools.server.lua`
- 239 lines, client: `scripts/StarterPlayer/StarterCharacterScripts/RetroClimbing.client.lua`
- 229 lines, server: `scripts/ServerScriptService/Characters.server.lua`
- 224 lines, server: `scripts/ServerScriptService/Badges.server.lua`
- 198 lines, client: `scripts/ReplicatedFirst/JoinScript/UI/SafeChat/SafeChat.client.lua`
- 195 lines, module: `scripts/ReplicatedStorage/ItemData/Face.lua`

## Scan

- Flags: 0 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 0
- Scripts with decompiler headers: 0; empty scripts: 0

## Most common classes

- Script: 73
- Frame: 36
- LocalScript: 35
- Tool: 24
- Part: 22
- Sound: 21
- ModuleScript: 17
- TextLabel: 16
- SpecialMesh: 14
- Folder: 10
- ImageLabel: 8
- StringValue: 7
- UIListLayout: 6
- ImageButton: 6
- UIAspectRatioConstraint: 5
- CharacterMesh: 5
- Instance: 4
- BillboardGui: 3
- ScreenGui: 2
- TextButton: 2
- UIScale: 2
- SurfaceGui: 2
- Attachment: 2
- RemoteEvent: 2
- ObjectValue: 2
