# Public LvaH

Source: `C:/Users/wnott/Downloads\Public LvaH.rbxl`  
68247 instances, 133 classes, 597 scripts (158975 lines), 326 remotes, 494 asset ids

## Top level

| Service / root | Class | Descendants | Scripts (server/client/module) |
|---|---|---:|---|
| Workspace | Workspace | 62916 | 6/0/0 |
| SoundService | SoundService | 4 |  |
| ReplicatedFirst | ReplicatedFirst | 1 | 0/1/0 |
| MaterialService | MaterialService | 1 |  |
| TextChatService | TextChatService | 3 |  |
| StarterPlayer | StarterPlayer | 19 | 3/3/4 |
| StarterPack | StarterPack | 28 | 0/2/0 |
| StarterGui | StarterGui | 2334 | 0/80/0 |
| InsertService | InsertService | 1 |  |
| ReplicatedStorage | ReplicatedStorage | 128 | 0/0/16 |
| ServerScriptService | ServerScriptService | 1502 | 32/41/392 |
| ServerStorage | ServerStorage | 1252 | 3/4/10 |
| Lighting | Lighting | 4 |  |

(41 empty services not listed)

## Key containers

**ServerScriptService** (4 children)

- Folder `Commands` (140)
- Folder `Environment` (1004)
- Folder `Player` (88)
- Folder `BetterChat V3` (266)

**ServerStorage** (5 children)

- Folder `Modules` (96)
- Folder `LongTermStorage` (249)
- Folder `GameSounds` (230)
- Model `RBX_ANIMSAVES` (617)
- Folder `GameAssets` (55)

**ReplicatedStorage** (3 children)

- Folder `Modules` (7)
- Folder `Remotes` (8)
- ModuleScript `PlayersListPlus` (110) -> `scripts/ReplicatedStorage/PlayersListPlus.lua`

**ReplicatedFirst** (1 children)

- LocalScript `PlayersListPlus` -> `scripts/ReplicatedFirst/PlayersListPlus.client.lua`

**StarterPlayer** (2 children)

- StarterPlayerScripts `StarterPlayerScripts` (6)
- LocalScript `CommandLocalHandler` -> `scripts/StarterPlayer/StarterPlayerScripts/CommandLocalHandler.client.lua`
- Folder `Epic UI Pack` (4)
- StarterCharacterScripts `StarterCharacterScripts` (11)
- LocalScript `CameraFix` -> `scripts/StarterPlayer/StarterCharacterScripts/CameraFix.client.lua`
- Script `AwardBadge` (2) -> `scripts/StarterPlayer/StarterCharacterScripts/AwardBadge.server.lua`
- LocalScript `Sprint` -> `scripts/StarterPlayer/StarterCharacterScripts/Sprint.client.lua`
- Script `Overhead` (4) -> `scripts/StarterPlayer/StarterCharacterScripts/Overhead.server.lua`
- Script `Collisions` -> `scripts/StarterPlayer/StarterCharacterScripts/Collisions.server.lua`

**StarterGui** (2 children)

- ScreenGui `Game` (2301)
- ScreenGui `Disclaimers` (31)

**StarterPack** (2 children)

- Tool `GuidePamplet` (13)
- Tool `PayoutPamplet` (13)

**Workspace** (7 children)

- Terrain `Terrain`
- Folder `Map` (3422)
- Folder `Games` (58538)
- Model `DirtTrack` (73)
- Model `Rings` (75)
- Model `Model` (801)
- Camera `Camera`

## UI roots

- ScreenGui `Game` (2301 descendants)
- ScreenGui `Disclaimers` (31 descendants)
- ScreenGui `PlayersList` (55 descendants)
- ScreenGui `Roulette` (74 descendants)
- ScreenGui `HorseRacing` (16 descendants)
- ScreenGui `Blackjack` (164 descendants)
- ScreenGui `ThreeCardPoker` (110 descendants)
- ScreenGui `BigWheel` (21 descendants)
- ScreenGui `Baccarat` (84 descendants)
- ScreenGui `TexasHoldem` (157 descendants)
- ScreenGui `TournamentHoldem` (157 descendants)
- ScreenGui `CashWheel` (13 descendants)
- ScreenGui `Plinko` (132 descendants)
- ScreenGui `Slots` (72 descendants)
- ScreenGui `Backpack` (5 descendants) [disabled]
- plus 2836 BillboardGui/SurfaceGui in the world (see ui.txt)

## Largest scripts

- 26994 lines, module: `scripts/ServerScriptService/Environment/GameManager/TexasHoldemCore/Lookup.lua`
- 26994 lines, module: `scripts/ServerScriptService/Environment/GameManager/TournamentHoldemCore/Lookup.lua`
- 3885 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/oldsrc/client/modules/core/elements/chatGui.lua`
- 3885 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/src/client/modules/core/elements/chatGui.lua`
- 3411 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/oldsrc/client/modules/core/constructors/util/zlib.lua`
- 3411 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/src/client/modules/core/constructors/util/zlib.lua`
- 2565 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/oldsrc/core/services/profile.lua`
- 2565 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/src/core/services/profile.lua`
- 2417 lines, module: `scripts/ServerStorage/Modules/ProfileService.lua`
- 2320 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/oldsrc/client/modules/core/lists/emojiList.lua`
- 2320 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/src/client/modules/core/lists/emojiList.lua`
- 2048 lines, module: `scripts/ServerStorage/Modules/RankGun/include/Promise.lua`
- 1163 lines, server: `scripts/ServerScriptService/Environment/GameManager/BlackjackCore.server.lua` [disabled]
- 1093 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/oldsrc/client/modules/core/topbarPlus/TopbarPlus/Icon.lua`
- 1093 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/src/client/modules/core/topbarPlus/TopbarPlus/Icon.lua`
- 1033 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/oldsrc/client/modules/core/lists/localizationTable.lua`
- 1033 lines, module: `scripts/ServerScriptService/BetterChat V3/Config/Loader/src/client/modules/core/lists/localizationTable.lua`
- 937 lines, server: `scripts/ServerScriptService/Environment/GameManager/ThreeCardPokerCore.server.lua` [disabled]
- 879 lines, module: `scripts/ReplicatedStorage/PlayersListPlus.lua`
- 786 lines, server: `scripts/ServerScriptService/Environment/GameManager/TexasHoldemCore.server.lua` [disabled]

## Scan

- Flags: 2 HIGH, 3 MED (details in flags.txt)
- Monetization ids in code: 2
- Scripts with decompiler headers: 0; empty scripts: 0

## Most common classes

- Pose: 17036
- Part: 10566
- MeshPart: 4412
- CFrameValue: 3366
- Model: 3025
- TextLabel: 2962
- Attachment: 2662
- Keyframe: 2615
- Vector3Value: 2211
- SurfaceGui: 2071
- Folder: 2041
- UnionOperation: 1825
- Frame: 840
- BillboardGui: 765
- WeldConstraint: 735
- ImageLabel: 728
- TextButton: 693
- Motor6D: 660
- CylinderMesh: 568
- NumberPose: 544
- HingeConstraint: 527
- StringValue: 496
- WrapTarget: 495
- KeyframeSequence: 465
- AnimationRigData: 460
