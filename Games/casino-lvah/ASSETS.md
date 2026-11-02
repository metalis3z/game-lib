# LvaH Casino

- Genre: casino (roulette, blackjack, poker, horse racing, wheels)
- Source file: `Public LvaH.rbxl`
- Provenance: template with full source
- Code + analysis: `source/` (scripts, ui.txt, flags.txt, ANALYSIS.md if present)
- Packs written: 281 files, 7696 KB (407 duplicates skipped, 287 scripts removed)

## What is here

| Folder | Packs | Notes |
|---|---:|---|
| `ui/` | 25 | `_StarterGui-all.lua` = builds every StarterGui screen at once |
| `map/` | 2 | `workspace.rbxm` (no terrain), `lighting.rbxm`, `Environment.lua` |
| `models/` | 148 models, 0 part sets, 0 vfx sets | mirrors the source tree |
| `animations/` | 466 | KeyframeSequences can be re-uploaded as your own animations; `AnimationIds.lua` lists 417 Animation ids |
| `audio/` | 14 | `Sounds.lua` lists 229 Sound ids |

## Model tags

map (64), decoration (32), character (18), nature (10), sign (10), interior (6), egg (3), hud (2), tool (2), building (2), inventory (1), vfx (1), backup (1)

## Biggest models

| File | Instances | Parts | Mesh | Size (studs) | Tags |
|---|---:|---:|---:|---|---|
| `models/Workspace/Games/Tables/TexasHoldem/TexasHoldem.rbxm` | 1606 | 286 | 69 | 20x50x20 | character |
| `models/Workspace/Games/Tables/TournamentHoldem/TournamentHoldem.rbxm` | 1605 | 286 | 69 | 18x50x22 | character |
| `models/Workspace/Games/Tables/TournamentHoldem/TournamentHoldem~2.rbxm` | 1605 | 286 | 69 | 18x50x22 | character |
| `models/Workspace/Games/Tables/TournamentHoldem/TournamentHoldem~3.rbxm` | 1605 | 286 | 69 | 18x50x22 | character |
| `models/Workspace/Games/Tables/TournamentHoldem/TournamentHoldem~4.rbxm` | 1605 | 286 | 69 | 18x50x22 | character |
| `models/Workspace/Games/Tables/Blackjack/Blackjack.rbxm` | 1335 | 177 | 112 | 22x41x14 | character |
| `models/Workspace/Games/Tables/ThreeCardPoker/ThreeCardPoker.rbxm` | 1093 | 140 | 64 | 22x42x14 | character |
| `models/Workspace/Games/Tables/Roulette/Roulette.rbxm` | 936 | 376 | 60 | 19x25x28 |  |
| `models/Workspace/Games/Tables/Roulette/Roulette~2.rbxm` | 936 | 376 | 60 | 28x25x19 |  |
| `models/Workspace/Games/Tables/Roulette/Roulette~3.rbxm` | 936 | 376 | 60 | 30x25x27 |  |
| `models/Workspace/Games/Tables/Roulette/Roulette~4.rbxm` | 936 | 376 | 60 | 28x25x19 |  |
| `models/Workspace/Games/Tables/Baccarat/Baccarat.rbxm` | 880 | 132 | 56 | 14x42x22 | character |
| `models/ServerStorage/RBX_ANIMSAVES.rbxm` | 618 | 0 | 0 |  |  |
| `models/Workspace/Games/Tables/Plinko/Plinko.rbxm` | 432 | 305 | 30 | 20x29x24 |  |
| `models/Workspace/Games/Tables/Plinko/Plinko~2.rbxm` | 432 | 305 | 30 | 24x29x20 |  |
| `models/Workspace/Games/Tables/Plinko/Plinko~3.rbxm` | 432 | 305 | 30 | 24x29x20 |  |
| `models/Workspace/Model/Triggers.rbxm` | 421 | 420 | 0 | 37x0x23 |  |
| `models/Workspace/Games/Tables/CashWheel/CashWheel.rbxm` | 379 | 202 | 30 | 26x39x26 |  |
| `models/Workspace/Games/Tables/CashWheel/CashWheel~2.rbxm` | 379 | 202 | 30 | 26x39x26 |  |
| `models/Workspace/Games/Tables/CashWheel/CashWheel~3.rbxm` | 379 | 202 | 30 | 26x39x26 |  |
| `models/Workspace/Games/Slots/GreenHot/GreenHot.rbxm` | 126 | 55 | 11 | 8x7x7 |  |
| `models/Workspace/Games/Slots/SevensAndCherries/SevensAndCherries.rbxm` | 109 | 48 | 9 | 4x7x8 |  |
| `models/Workspace/Games/Slots/OkamiSlots/OkamiSlots.rbxm` | 109 | 48 | 9 | 8x7x4 |  |
| `models/Workspace/Games/Slots/GoldenEgg/GoldenEgg.rbxm` | 109 | 48 | 9 | 4x7x8 | egg |
| `models/Workspace/Games/Slots/CatalogHaven/CatalogHaven.rbxm` | 109 | 48 | 9 | 4x7x8 |  |

## UI screens

| Pack | Objects | Images |
|---|---:|---:|
| `ui/StarterGui/Game/init.lua` | 1294 | 39 |
| `ui/ServerScriptService/Environment/GameManager/BlackjackCore/Blackjack.lua` | 78 | 1 |
| `ui/ServerScriptService/Environment/GameManager/TexasHoldemCore/TexasHoldem.lua` | 71 | 1 |
| `ui/ServerScriptService/Environment/GameManager/TournamentHoldemCore/TournamentHoldem.lua` | 71 | 1 |
| `ui/ServerScriptService/Environment/GameManager/PlinkoCore/Plinko.lua` | 62 | 1 |
| `ui/ServerScriptService/Environment/GameManager/ThreeCardPokerCore/ThreeCardPoker.lua` | 58 | 1 |
| `ui/ServerScriptService/Environment/GameManager/BaccaratCore/Baccarat.lua` | 49 | 1 |
| `ui/ServerScriptService/Environment/GameManager/RouletteCore/Roulette.lua` | 39 | 1 |
| `ui/ServerStorage/Modules/GameFunctions/Slots.lua` | 36 | 1 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/PlayersList.lua` | 26 | 3 |
| `ui/StarterGui/Disclaimers.lua` | 25 | 2 |
| `ui/ServerScriptService/Environment/GameManager/BigWheelCore/BigWheel.lua` | 20 | 0 |
| `ui/ServerScriptService/Environment/GameManager/HorseRacingCore/HorseRacing.lua` | 15 | 0 |
| `ui/ServerScriptService/Environment/GameManager/CashWheelCore/CashWheel.lua` | 12 | 1 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/IconPlayerFrame.lua` | 5 | 1 |
| `ui/ServerStorage/LongTermStorage/Backpack.lua` | 5 | 2 |
| `ui/StarterPlayer/StarterCharacterScripts/Overhead/Overhead.lua` | 4 | 0 |
| `ui/ServerStorage/Modules/GameFunctions/Overhead.lua` | 4 | 0 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/TopStats.lua` | 3 | 1 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/PlayerFrame.lua` | 3 | 0 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/SelectedButton.lua` | 3 | 1 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/PlrStats.lua` | 2 | 0 |
| `ui/ReplicatedStorage/PlayersListPlus/Assets/Tag.lua` | 1 | 0 |
