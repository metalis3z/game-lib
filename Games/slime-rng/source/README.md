# Slime RNG (But with admin cmds!!) (2)

Source: `C:/Users/wnott/Downloads\Slime RNG (But with admin cmds!!) (2).rbxl`  
6097 instances, 116 classes, 538 scripts (76050 lines), 69 remotes, 485 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 1273 |  |
| SoundService | SoundService | 59 |  |
| TextChatService | TextChatService | 22 |  |
| StarterPlayer | StarterPlayer | 6 | 0/3/1 |
| StarterGui | StarterGui | 20 |  |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 5 |  |
| ReplicatedStorage | ReplicatedStorage | 4623 | 0/0/510 |
| ServerScriptService | ServerScriptService | 29 | 1/0/23 |

(42 empty services not listed)

## Key containers

**ServerScriptService** (3 children)

- Script `handlerzib` -> `scripts/ServerScriptService/handlerzib.server.lua`
- Folder `Services` (20)
- Folder `Features` (6)

**ServerStorage** (0 children)


**ReplicatedStorage** (6 children)

- ObjectValue `TopbarPlusReference`
- Folder `CustomPackages` (9)
- Folder `Packages` (345)
- Folder `Source` (370)
- Folder `Assets` (3893)
- RemoteEvent `GetInitData`

**ReplicatedFirst** (0 children)


**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (4)
- LocalScript `RbxCharacterSounds` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- LocalScript `DataServiceInit` -> `scripts/StarterPlayer/StarterPlayerScripts/DataServiceInit.client.lua`
- LocalScript `GameClient` -> `scripts/StarterPlayer/StarterPlayerScripts/GameClient.client.lua`
- StarterCharacterScripts `StarterCharacterScripts`

**StarterGui** (1 children)

- ScreenGui `HUD` (19)

**StarterPack** (0 children)


**Workspace** (7 children)

- Camera `Camera` (2)
- Folder `Zones` (1192)
- Terrain `Terrain`
- Model `Leaderboards` (64)
- Folder `Loot`
- Folder `MultiplayerView` (6)
- Folder `Gameplay498` (2)

## UI roots

- ScreenGui `HUD` (19 descendants)
- plus 3 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 4592 lines, module: `scripts/ReplicatedStorage/Source/Features/Upgrades/UpgradeTree.lua`
- 1946 lines, module: `scripts/ReplicatedStorage/Packages/_Index/lm-loleris_profilestore@1.0.3/profilestore.lua`
- 1904 lines, module: `scripts/ReplicatedStorage/Packages/_Index/evaera_promise@4.0.0/promise/init.spec.lua`
- 1647 lines, module: `scripts/ReplicatedStorage/Packages/_Index/evaera_promise@4.0.0/promise.lua`
- 1332 lines, module: `scripts/ReplicatedStorage/Packages/_Index/1foreverhd_topbarplus@3.4.0/topbarplus.lua`
- 1049 lines, module: `scripts/ReplicatedStorage/Source/Features/Index/IndexRewards.lua`
- 929 lines, module: `scripts/ReplicatedStorage/Source/Game/Items/Slimes.lua`
- 887 lines, module: `scripts/ReplicatedStorage/Source/Features/Inventory/UI/Components/ItemsInventoryPage.lua`
- 769 lines, module: `scripts/ReplicatedStorage/Packages/_Index/1foreverhd_topbarplus@3.4.0/topbarplus/Utility.lua`
- 765 lines, module: `scripts/ReplicatedStorage/Source/Features/Tutorial/UI/TutorialRoot.lua`
- 720 lines, module: `scripts/ReplicatedStorage/CustomPackages/Explosion/FastCastRedux/ActiveCast.lua`
- 699 lines, module: `scripts/ReplicatedStorage/Source/Features/Admin/UI/AdminMenu.lua`
- 669 lines, module: `scripts/ReplicatedStorage/Source/Features/Roll/RareRollCutsceneVisuals.lua`
- 647 lines, module: `scripts/ReplicatedStorage/Source/Features/Roll/UI/RollScreen.lua`
- 612 lines, module: `scripts/ReplicatedStorage/Source/Features/Crafting/Classes/CraftingMachineVisualsClient.lua`
- 610 lines, module: `scripts/ServerScriptService/Services/GameplayService.lua`
- 600 lines, module: `scripts/ReplicatedStorage/Packages/_Index/howmanysmall_janitor@1.18.3/janitor/__tests__/Janitor.test.lua`
- 586 lines, module: `scripts/ReplicatedStorage/Source/Features/Crafting/CraftingServiceUtils.lua`
- 581 lines, module: `scripts/ReplicatedStorage/Source/Features/Zones/Components/ZonePurchase.lua`
- 574 lines, module: `scripts/ReplicatedStorage/Source/Features/Roll/JackpotUtils.lua`

## Scan

- Flags: 1 HIGH, 1 MED (details in flags.txt)
- Monetization ids in code: 1
- Scripts with decompiler headers: 498; empty scripts: 0
- 498 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- Bone: 2024
- Model: 829
- MeshPart: 798
- ModuleScript: 534
- Motor6D: 460
- Part: 287
- Decal: 273
- Folder: 205
- AnimationController: 92
- Animator: 92
- SurfaceAppearance: 73
- Sound: 63
- ParticleEmitter: 42
- RemoteEvent: 35
- Attachment: 34
- RemoteFunction: 34
- WeldConstraint: 24
- SpecialMesh: 19
- Texture: 17
- TextLabel: 10
- PointLight: 9
- TextChatCommand: 9
- UIStroke: 8
- Beam: 7
- Frame: 6
