# RCU

Source: `C:/Users/wnott/Downloads\RCU.rbxl`  
54245 instances, 138 classes, 513 scripts (95662 lines), 20 remotes, 2130 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 37444 | 0/0/1 |
| SoundService | SoundService | 54 |  |
| TextChatService | TextChatService | 328 | 1/1/0 |
| StarterPlayer | StarterPlayer | 222 | 0/4/200 |
| StarterGui | StarterGui | 9687 | 2/19/3 |
| InsertService | InsertService | 1 |  |
| AvatarSettings | AvatarSettings | 7 |  |
| Lighting | Lighting | 4 |  |
| ReplicatedStorage | ReplicatedStorage | 6406 | 0/0/243 |
| ServerScriptService | ServerScriptService | 41 | 3/0/36 |

(41 empty services not listed)

## Key containers

**ServerScriptService** (5 children)

- Folder `Services` (35)
- Folder `Modules` (1)
- Script `ServerBootstrap` -> `scripts/ServerScriptService/ServerBootstrap.server.lua`
- Script `__MCP_StopListener` -> `scripts/ServerScriptService/__MCP_StopListener.server.lua`
- Script `__MCP_StopListener` -> `scripts/ServerScriptService/__MCP_StopListener~2.server.lua`

**ServerStorage** (0 children)


**ReplicatedStorage** (3 children)

- Folder `Packages` (135)
- Folder `Shared` (172)
- Folder `Assets` (6096)

**ReplicatedFirst** (0 children)


**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (220)
- LocalScript `UIScaleRuntime` -> `scripts/StarterPlayer/StarterPlayerScripts/UIScaleRuntime.client.lua`
- LocalScript `RbxCharacterSounds` (1) -> `scripts/StarterPlayer/StarterPlayerScripts/RbxCharacterSounds.client.lua`
- LocalScript `PlayerScriptsLoader` -> `scripts/StarterPlayer/StarterPlayerScripts/PlayerScriptsLoader.client.lua`
- Folder `Client` (215)
- StarterCharacterScripts `StarterCharacterScripts`

**StarterGui** (2 children)

- ScreenGui `MainUI` (9678)
- ScreenGui `Overlays` (7)

**StarterPack** (0 children)


**Workspace** (7 children)

- Camera `Camera`
- Folder `Game` (37435)
- Folder `Debris` (1)
- Folder `Coffin`
- Terrain `Terrain` (1)
- Folder `TerrainGraph`
- Model `TrianglePluginDebris`

## UI roots

- ScreenGui `MainUI` (9678 descendants)
- ScreenGui `Overlays` (7 descendants)
- plus 115 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 4913 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/ClansFrame.lua`
- 4685 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/IconOld.lua`
- 2320 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/IconOld/IconController.lua`
- 2138 lines, module: `scripts/ReplicatedStorage/Packages/_Index/evaera_promise@4.0.0/promise/init.spec.lua`
- 1916 lines, module: `scripts/ReplicatedStorage/Shared/List/Shop/SupporterPack.lua`
- 1817 lines, module: `scripts/ReplicatedStorage/Packages/Zone.lua`
- 1741 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/widgets/Input.lua`
- 1737 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Icon/Elements/Widget.lua`
- 1456 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/demoWindow.lua`
- 1302 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/ShopFrame.lua`
- 1235 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/InventoryFrame.lua`
- 1128 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Icon.lua`
- 1006 lines, module: `scripts/ReplicatedStorage/Shared/List/Countries.lua`
- 983 lines, module: `scripts/ReplicatedStorage/Packages/_Index/sleitnick_option@1.0.5/option/init.spec.lua`
- 950 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/TradeFrame.lua`
- 937 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/UIController.lua`
- 920 lines, module: `scripts/ServerScriptService/Services/ClanService.lua`
- 915 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/widgets/Window.lua`
- 859 lines, module: `scripts/ReplicatedStorage/Packages/Zone/ZoneController.lua`
- 775 lines, module: `scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/widgets.lua`

## Scan

- Flags: 0 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 32
- Scripts with decompiler headers: 419; empty scripts: 0
- 413 scripts saved by an exploit saveinstance
- Decompiled code comes from a copy of a live game: server-only code was never sent to the client, so anything here that looks like server code was rebuilt or added by whoever packaged the file

## Most common classes

- UIStroke: 8067
- UIGradient: 8067
- Frame: 7227
- TextLabel: 6127
- MeshPart: 5807
- ImageLabel: 4837
- UICorner: 3788
- Model: 2449
- UIListLayout: 1465
- Part: 1085
- ParticleEmitter: 748
- WeldConstraint: 658
- TextButton: 511
- Folder: 484
- ModuleScript: 483
- Texture: 418
- Attachment: 391
- Weld: 289
- Decal: 150
- UITextSizeConstraint: 141
- UIAspectRatioConstraint: 96
- UIGridLayout: 84
- Vector3Value: 74
- BillboardGui: 69
- ProximityPrompt: 69
