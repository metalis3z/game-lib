# UNO Game Working

Source: `C:/Users/wnott/Downloads\UNO Game Working.rbxl`  
18152 instances, 123 classes, 28 scripts (22503 lines), 202 remotes, 750 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 2117 |  |
| SoundService | SoundService | 27 |  |
| TextChatService | TextChatService | 4 |  |
| StarterPlayer | StarterPlayer | 2 |  |
| StarterGui | StarterGui | 7693 | 0/1/10 |
| InsertService | InsertService | 1 |  |
| ReplicatedStorage | ReplicatedStorage | 8232 | 0/0/4 |
| ServerScriptService | ServerScriptService | 13 | 2/0/11 |
| ServerStorage | ServerStorage | 2 |  |
| Lighting | Lighting | 7 |  |

(44 empty services not listed)

## Key containers

**ServerScriptService** (2 children)

- Script `Server` (11) -> `scripts/ServerScriptService/Server.server.lua`
- Script `Collisions` -> `scripts/ServerScriptService/Collisions.server.lua`

**ServerStorage** (2 children)

- Folder `Codes`
- BoolValue `Shutdown`

**ReplicatedStorage** (17 children)

- Folder `Templates` (1602)
- Folder `PlayerData`
- Folder `Lobbies` (3)
- Folder `Remotes` (86)
- Folder `PermLobbies` (3194)
- Folder `Games`
- Folder `Decks` (2)
- Folder `Vals` (12)
- Folder `MiscAssets` (323)
- Folder `Cosmetics` (784)
- Folder `ViewportModels` (1435)
- Folder `Modules` (2)
- Folder `PlayerSessions`
- Folder `CaseRigs` (770)
- Folder `Unboxings`
- Folder `Trades`
- Folder `ShutdownInfo` (2)

**ReplicatedFirst** (0 children)


**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts`
- StarterCharacterScripts `StarterCharacterScripts`

**StarterGui** (3 children)

- ScreenGui `GameUI` (7649)
- ScreenGui `RealGame` (40)
- ScreenGui `bb` (1)

**StarterPack** (0 children)


**Workspace** (35 children)

- Part `HumCF`
- Folder `PermLobbies` (98)
- Part `CamP`
- Part `VMP`
- Folder `RigSnaps`
- Terrain `Terrain`
- Model `CrateSetup` (2)
- Model `DecorReference` (4)
- Model `SuperULobby` (1498)
- Model `Dummy` (148)
- Model `CoinsRarityModels` (40)
- Part `StarsPart` (1)
- Model `VIPShowcase` (29)
- Part `ShopHead` (2)
- Model `ItemShowcase` (126)
- Part `VIPInfo` (2)
- Model `ChairReference` (8)
- Part `VIPIBene` (2)
- Part `VIPHeader` (2)
- Part `VIPP` (2)
- Part `RankedHead` (2)
- Model `Crate2` (21)
- Folder `Arenas`
- Part `ArenaStart`
- Part `ShopP` (2)
- Model `Board` (7)
- Part `UnboxHead` (2)
- Part `UnboxList`
- Folder `WinnerModels`
- Folder `Global_Leaderboards` (30)
- Model `RotArrows` (11)
- Model `CM` (41)
- Model `ChairBoundry` (2)
- Part `Part`
- Camera `Camera`

## UI roots

- ScreenGui `GameUI` (7649 descendants)
- ScreenGui `RealGame` (40 descendants)
- ScreenGui `bb` (1 descendants)
- plus 26 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 5867 lines, module: `scripts/StarterGui/GameUI/Everything/Client/BindableManager.lua`
- 3544 lines, client: `scripts/StarterGui/GameUI/Everything/Client.client.lua`
- 2884 lines, module: `scripts/ServerScriptService/Server/GameHandler.lua`
- 1368 lines, server: `scripts/ServerScriptService/Server.server.lua`
- 1098 lines, module: `scripts/ServerScriptService/Server/InventoryHandler.lua`
- 895 lines, module: `scripts/ReplicatedStorage/Decks/Super.lua`
- 845 lines, module: `scripts/ReplicatedStorage/Modules/CosmeticIndex.lua`
- 672 lines, module: `scripts/ServerScriptService/Server/DataHandler.lua`
- 655 lines, module: `scripts/ReplicatedStorage/Decks/Classic.lua`
- 560 lines, module: `scripts/ReplicatedStorage/Modules/CrateIndex.lua`
- 492 lines, module: `scripts/ServerScriptService/Server/TradeHandler.lua`
- 482 lines, module: `scripts/StarterGui/GameUI/Everything/Client/CardManager.lua`
- 478 lines, module: `scripts/ServerScriptService/Server/LobbyHandler.lua`
- 360 lines, module: `scripts/StarterGui/GameUI/Everything/Client/ButtonManager.lua`
- 310 lines, module: `scripts/ServerScriptService/Server/Util.lua`
- 266 lines, module: `scripts/ServerScriptService/Server/CraftingHandler.lua`
- 230 lines, module: `scripts/StarterGui/GameUI/Everything/Client/LobbyManager.lua`
- 211 lines, module: `scripts/ServerScriptService/Server/CodeHandler.lua`
- 197 lines, module: `scripts/ServerScriptService/Server/LevelHandler.lua`
- 184 lines, module: `scripts/StarterGui/GameUI/Everything/Client/PlayerConManager.lua`

## Scan

- Flags: 0 HIGH, 0 MED (details in flags.txt)
- Monetization ids in code: 20
- Scripts with decompiler headers: 0; empty scripts: 0

## Most common classes

- MeshPart: 3226
- StringValue: 2613
- Folder: 1796
- Color3Value: 1679
- ImageLabel: 1609
- Model: 994
- Frame: 982
- NumberValue: 982
- TextLabel: 908
- Part: 596
- ObjectValue: 472
- Pose: 280
- TextButton: 260
- WedgePart: 258
- BoolValue: 171
- WeldConstraint: 125
- Vector3Value: 124
- BindableEvent: 116
- IntValue: 108
- Attachment: 100
- ViewportFrame: 89
- Motor6D: 80
- Keyframe: 60
- RemoteEvent: 58
- Sound: 49
