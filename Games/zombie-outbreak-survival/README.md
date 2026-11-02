# Zombie Outbreak Survival

> 🔫 **Shooter** · wave survival shooter · source file `Zombie Outbreak Survival.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/02_Tools_shop__Template.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 5 ScreenGuis, 66 GUI objects → **9 screenshots** |
| Models (.rbxm) | 63 models, 3 model sets, 0 VFX sets |
| Lua builders (.lua) | 9 UI screens, 0 animation packs, 1 audio packs |
| Code | 154 scripts, 19,885 lines |
| Asset ids | 19 animations, 45 sounds |
| Safety scan | 0 HIGH / 2 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×9, `FredokaOne ExtraBold`×8, `SourceSansPro Regular`×3, `GothamSSm Bold`×3, `GothamSSm ExtraBold`×3

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Tools_shop.jpg"><img src="screenshots/thumbs/01_Tools_shop.jpg" width="100%"></a><br><sub><b>Tools_shop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_Tools_shop__Template.jpg"><img src="screenshots/thumbs/02_Tools_shop__Template.jpg" width="100%"></a><br><sub><b>Tools_shop</b> › Frame.List.Template</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_Codes.jpg"><img src="screenshots/thumbs/08_Codes.jpg" width="100%"></a><br><sub><b>Codes</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_LevelUp__LevelUpFrame.jpg"><img src="screenshots/thumbs/07_LevelUp__LevelUpFrame.jpg" width="100%"></a><br><sub><b>LevelUp</b> › LevelUpFrame</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_MainGui__Winners.jpg"><img src="screenshots/thumbs/06_MainGui__Winners.jpg" width="100%"></a><br><sub><b>MainGui</b> › GameFrame.Winners</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_MainGui.jpg"><img src="screenshots/thumbs/04_MainGui.jpg" width="100%"></a><br><sub><b>MainGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_MainGui__MainFrame.jpg"><img src="screenshots/thumbs/05_MainGui__MainFrame.jpg" width="100%"></a><br><sub><b>MainGui</b> › GameFrame.MainFrame</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Tutorial.jpg"><img src="screenshots/thumbs/03_Tutorial.jpg" width="100%"></a><br><sub><b>Tutorial</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_Welcome.jpg"><img src="screenshots/thumbs/09_Welcome.jpg" width="100%"></a><br><sub><b>Welcome</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Stuff/Leaderboards/TimePlayedLeaderboard.rbxm"><img src="screenshots/thumbs/models/01_TimePlayedLeaderboard.jpg" width="100%"></a><br><sub><b>TimePlayedLeaderboard</b><br><code>models/Workspace/Lobby/Stuff/Leaderboards/TimePlayedLeaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Tools/Classic%20Sword.rbxm"><img src="screenshots/thumbs/models/02_Classic_Sword.jpg" width="100%"></a><br><sub><b>Classic Sword</b><br><code>models/ReplicatedStorage/Tools/Classic Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Chest/Chest.rbxm"><img src="screenshots/thumbs/models/03_Chest.jpg" width="100%"></a><br><sub><b>Chest</b><br><code>models/Workspace/Chest/Chest.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Stuff/Model.rbxm"><img src="screenshots/thumbs/models/04_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Lobby/Stuff/Model.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Tools/Flamethrower.rbxm"><img src="screenshots/thumbs/models/05_Flamethrower.jpg" width="100%"></a><br><sub><b>Flamethrower</b><br><code>models/ReplicatedStorage/Tools/Flamethrower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Stuff/Leaderboards/Model__x9.rbxm"><img src="screenshots/thumbs/models/06_Model_x9.jpg" width="100%"></a><br><sub><b>Model__x9</b><br><code>models/Workspace/Lobby/Stuff/Leaderboards/Model__x9.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Maps/Junkyard.rbxm"><img src="screenshots/thumbs/models/07_Junkyard.jpg" width="100%"></a><br><sub><b>Junkyard</b><br><code>models/ReplicatedStorage/Maps/Junkyard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Tools/Bow.rbxm"><img src="screenshots/thumbs/models/08_Bow.jpg" width="100%"></a><br><sub><b>Bow</b><br><code>models/ReplicatedStorage/Tools/Bow.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/MainMap/Model~3/Model~2.rbxm"><img src="screenshots/thumbs/models/09_Model_2.jpg" width="100%"></a><br><sub><b>Model~2</b><br><code>models/Workspace/Lobby/MainMap/Model~3/Model~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Zombie.rbxm"><img src="screenshots/thumbs/models/10_Zombie.jpg" width="100%"></a><br><sub><b>Zombie</b><br><code>models/ReplicatedStorage/Zombie.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Chest/Crown.rbxm"><img src="screenshots/thumbs/models/11_Crown.jpg" width="100%"></a><br><sub><b>Crown</b><br><code>models/Workspace/Chest/Crown.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Tools/Minigun.rbxm"><img src="screenshots/thumbs/models/12_Minigun.jpg" width="100%"></a><br><sub><b>Minigun</b><br><code>models/ReplicatedStorage/Tools/Minigun.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Stuff/Leaderboards/leaderbooard.rbxm"><img src="screenshots/thumbs/models/13_leaderbooard.jpg" width="100%"></a><br><sub><b>leaderbooard</b><br><code>models/Workspace/Lobby/Stuff/Leaderboards/leaderbooard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Stuff/Stage.rbxm"><img src="screenshots/thumbs/models/14_Stage.jpg" width="100%"></a><br><sub><b>Stage</b><br><code>models/Workspace/Lobby/Stuff/Stage.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI controllers / window managers / menus | [`SingleOpenGuiHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/SingleOpenGuiHandler.client.lua) <sub>49 lines</sub><br>[`GameUi`](source/scripts/StarterGui/MainGui/GameFrame/GameUi.client.lua) <sub>84 lines</sub><br>[`TopbarPlusForeverHD`](source/scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD.lua) <sub>1057 lines</sub> |
| Notifications, toasts, popups, prompts | [`ShopScript`](source/scripts/StarterGui/Tools_shop/ShopScript.client.lua) <sub>109 lines</sub> |
| VFX, particles, beams, hit effects | [`Rocket`](source/scripts/ReplicatedStorage/Tools/RocketLauncher/Server/Rocket.server.lua) <sub>146 lines</sub><br>[`Server`](source/scripts/ReplicatedStorage/Tools/Minigun/Server.server.lua) <sub>182 lines</sub><br>[`Server`](source/scripts/ReplicatedStorage/Code_Tools/Meteor/Server.server.lua) <sub>96 lines</sub> |
| DataStore / player data | [`STATS`](source/scripts/ServerScriptService/STATS.server.lua) <sub>414 lines</sub><br>[`Buy_tools`](source/scripts/ServerScriptService/Buy_tools.server.lua) <sub>251 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ShopScript`](source/scripts/StarterGui/Tools_shop/ShopScript.client.lua) <sub>109 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`MapVoteHandler`](source/scripts/ReplicatedStorage/Modules/MapVoteHandler.lua) <sub>470 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`BowServer`](source/scripts/ReplicatedStorage/Tools/Bow/BowServer.server.lua) <sub>70 lines</sub><br>[`SwordScript`](source/scripts/ReplicatedStorage/Tools/Classic%20Sword/SwordScript.server.lua) <sub>225 lines</sub> |
| NPC / AI / monsters | [`ZombieAi`](source/scripts/ReplicatedStorage/Zombie/ZombieAi.server.lua) <sub>232 lines</sub> |
| Leaderboards & stats | [`Main`](source/scripts/Workspace/Lobby/Stuff/Leaderboards/leaderbooard/GlobalHealthLeaderboard/SurfaceGui/Main.server.lua) <sub>121 lines</sub><br>[`Main`](source/scripts/Workspace/Lobby/Stuff/Leaderboards/leaderbooard~3/GlobalHealthLeaderboard/SurfaceGui/Main.server.lua) <sub>121 lines</sub><br>[`Main`](source/scripts/Workspace/Lobby/Stuff/Leaderboards/leaderbooard~4/GlobalHealthLeaderboard/SurfaceGui/Main.server.lua) <sub>121 lines</sub> |
| Daily rewards, quests, codes, playtime | [`DailyChestHandler`](source/scripts/ServerScriptService/DailyChestHandler.server.lua) <sub>75 lines</sub><br>[`MainCodes`](source/scripts/StarterGui/Codes/MainCodes.client.lua) <sub>108 lines</sub><br>[`DailyChestLocal`](source/scripts/StarterPlayer/StarterCharacterScripts/DailyChestLocal.client.lua) <sub>84 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`TopbarPlusForeverHD`](source/scripts/ReplicatedStorage/Modules/TopbarPlusForeverHD.lua) <sub>1057 lines</sub> |

### In the curated script library

- [Simple daily chest (beginner)](../../Scripts/18-Daily-Rewards-Quests/DailyChestHandler-Simple__zombie-outbreak-survival.lua) — Standalone daily chest: its own DataStore with LastClaim/Streak, 24h cooldown, 48h streak expiry, 7-day reward table sent to the client for display, claim debounce.
- [Zombie chase / wander AI](../../Scripts/12-NPC-AI/ZombieChaserWander__zombie-outbreak-survival.lua) — Classic per-zombie Script: finds the nearest player on the 'Alive' team, pathfinds toward them, wanders randomly when no one is near, and deals touch damage with a per-victim cooldown.
- [Wave-based zombie round loop](../../Scripts/12-NPC-AI/ZombieWaveRound__zombie-outbreak-survival.lua) — Wave spawner: zombies per wave = base * wave * multiplier, a timed spawn loop over tagged Spawner parts, and a round loop that advances the wave when all zombies die, ends in victory on the last wave or defeat when no players are alive.
- [Alive-enemy registry](../../Scripts/12-NPC-AI/ZombieManager__zombie-outbreak-survival.lua) — Small module that registers / unregisters spawned zombies, prunes destroyed ones and pushes the 'enemies left' count to clients.
- [Single open ScreenGui handler](../../Scripts/02-UI-Framework/SingleOpenGuiHandler__zombie-outbreak-survival.lua) — Disables the other listed ScreenGuis whenever one becomes enabled.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
