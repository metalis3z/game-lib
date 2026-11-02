# Drive For Brainrots

> 🧠 **Brainrot** · driving / brainrot collecting simulator · source file `Drive For Brainrots - With AP- SLBR BOOSTER.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/03_GUI__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 2 ScreenGuis, 594 GUI objects → **12 screenshots** |
| Models (.rbxm) | 180 models, 4 model sets, 2 VFX sets |
| Lua builders (.lua) | 18 UI screens, 0 animation packs, 5 audio packs |
| Code | 121 scripts, 22,986 lines |
| Asset ids | 56 animations, 35 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Heavy`×108, `GothamSSm ExtraBold`×76, `SourceSansPro Regular`×31, `GothamSSm Bold`×20, `font asset 11702779517 Heavy`×13

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_GUI__Shop.jpg"><img src="screenshots/thumbs/03_GUI__Shop.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Shop</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_GUI__Index.jpg"><img src="screenshots/thumbs/05_GUI__Index.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Index</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_GUI__Wheel.jpg"><img src="screenshots/thumbs/06_GUI__Wheel.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_GUI__Offline.jpg"><img src="screenshots/thumbs/07_GUI__Offline.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Offline</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_GUI__GiftrewardFrame.jpg"><img src="screenshots/thumbs/08_GUI__GiftrewardFrame.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.GiftrewardFrame</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_GUI__Upgrades.jpg"><img src="screenshots/thumbs/02_GUI__Upgrades.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Upgrades</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_GUI__Rebirth.jpg"><img src="screenshots/thumbs/04_GUI__Rebirth.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_UpgradeTemplate.jpg"><img src="screenshots/thumbs/11_UpgradeTemplate.jpg" width="100%"></a><br><sub><b>UpgradeTemplate</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_GUI__AdminPanelMain.jpg"><img src="screenshots/thumbs/09_GUI__AdminPanelMain.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.AdminPanelMain</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_GUI.jpg"><img src="screenshots/thumbs/01_GUI.jpg" width="100%"></a><br><sub><b>GUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_GUI__Effect.jpg"><img src="screenshots/thumbs/10_GUI__Effect.jpg" width="100%"></a><br><sub><b>GUI</b> › Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_VehicleGui.jpg"><img src="screenshots/thumbs/12_VehicleGui.jpg" width="100%"></a><br><sub><b>VehicleGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Templates/Car.rbxm"><img src="screenshots/thumbs/models/01_Car.jpg" width="100%"></a><br><sub><b>Car</b><br><code>models/ReplicatedStorage/Templates/Car.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Diamond/Tictac%20Sahur.rbxm"><img src="screenshots/thumbs/models/02_Tictac_Sahur.jpg" width="100%"></a><br><sub><b>Tictac Sahur</b><br><code>models/ReplicatedStorage/Items/Diamond/Tictac Sahur.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Templates/Bullet.rbxm"><img src="screenshots/thumbs/models/03_Bullet.jpg" width="100%"></a><br><sub><b>Bullet</b><br><code>models/ReplicatedStorage/Templates/Bullet.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/MoneyLeaderboard.rbxm"><img src="screenshots/thumbs/models/04_MoneyLeaderboard.jpg" width="100%"></a><br><sub><b>MoneyLeaderboard</b><br><code>models/Workspace/Leaderboards/MoneyLeaderboard.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Stand.rbxm"><img src="screenshots/thumbs/models/05_Stand.jpg" width="100%"></a><br><sub><b>Stand</b><br><code>models/Workspace/Stand.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Grass/Grass.rbxm"><img src="screenshots/thumbs/models/06_Grass.jpg" width="100%"></a><br><sub><b>Grass</b><br><code>models/Workspace/Map/Grass/Grass.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Upgrades.rbxm"><img src="screenshots/thumbs/models/07_Upgrades.jpg" width="100%"></a><br><sub><b>Upgrades</b><br><code>models/Workspace/Upgrades.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/RebirthsLeaderboard.rbxm"><img src="screenshots/thumbs/models/08_RebirthsLeaderboard.jpg" width="100%"></a><br><sub><b>RebirthsLeaderboard</b><br><code>models/Workspace/Leaderboards/RebirthsLeaderboard.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Stand~2.rbxm"><img src="screenshots/thumbs/models/09_Stand_2.jpg" width="100%"></a><br><sub><b>Stand~2</b><br><code>models/Workspace/Stand~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Rocks/Rock.rbxm"><img src="screenshots/thumbs/models/10_Rock.jpg" width="100%"></a><br><sub><b>Rock</b><br><code>models/Workspace/Map/Rocks/Rock.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Sell.rbxm"><img src="screenshots/thumbs/models/11_Sell.jpg" width="100%"></a><br><sub><b>Sell</b><br><code>models/Workspace/Sell.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Diamond/Strawberry%20Elephant.rbxm"><img src="screenshots/thumbs/models/12_Strawberry_Elephant.jpg" width="100%"></a><br><sub><b>Strawberry Elephant</b><br><code>models/ReplicatedStorage/Items/Diamond/Strawberry Elephant.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Robux.rbxm"><img src="screenshots/thumbs/models/13_Robux.jpg" width="100%"></a><br><sub><b>Robux</b><br><code>models/Workspace/Robux.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Stage5.rbxm"><img src="screenshots/thumbs/models/14_Stage5.jpg" width="100%"></a><br><sub><b>Stage5</b><br><code>models/Workspace/Map/Stage5.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| Notifications, toasts, popups, prompts | [`AdminHandler`](source/scripts/ServerScriptService/Handlers/AdminHandler.server.lua) <sub>483 lines</sub><br>[`AdminPanelClient`](source/scripts/StarterGui/GUI/Frames/AdminPanelMain/AdminPanelClient.client.lua) <sub>347 lines</sub><br>[`CarrySystem`](source/scripts/ServerScriptService/Modules/CarrySystem.lua) <sub>318 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/Handlers/PlotManager.lua) <sub>222 lines</sub><br>[`ItemManager`](source/scripts/ServerScriptService/Modules/ItemManager.lua) <sub>342 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`SpinHandler`](source/scripts/ServerScriptService/Handlers/SpinHandler.lua) <sub>131 lines</sub><br>[`DailySpinConfiguration`](source/scripts/ReplicatedStorage/Modules/DailySpinConfiguration.lua) <sub>54 lines</sub> |
| Tycoon / plots / bases / building | [`SlotManager`](source/scripts/ServerScriptService/Handlers/SlotManager.lua) <sub>333 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/Handlers/PlotManager.lua) <sub>222 lines</sub> |
| Admin panels & commands | [`AdminHandler`](source/scripts/ServerScriptService/Handlers/AdminHandler.server.lua) <sub>483 lines</sub><br>[`AdminPanelClient`](source/scripts/StarterGui/GUI/Frames/AdminPanelMain/AdminPanelClient.client.lua) <sub>347 lines</sub> |
| Daily rewards, quests, codes, playtime | [`GiftRewardHandler`](source/scripts/ServerScriptService/Handlers/GiftRewardHandler.server.lua) <sub>78 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`SlotManager`](source/scripts/ServerScriptService/Handlers/SlotManager.lua) <sub>333 lines</sub><br>[`ItemManager`](source/scripts/ServerScriptService/Modules/ItemManager.lua) <sub>342 lines</sub><br>[`UpgradesHandler`](source/scripts/ServerScriptService/Handlers/UpgradesHandler.lua) <sub>60 lines</sub><br>[`SpinHandler`](source/scripts/ServerScriptService/Handlers/SpinHandler.lua) <sub>131 lines</sub><br>[`SellHandler`](source/scripts/ServerScriptService/Handlers/SellHandler.lua) <sub>38 lines</sub> |

### In the curated script library

- [Head-stack carry system with collection zone](../../Scripts/14-Tycoon-Plots/CarrySystem__drive-for-brainrots.lua) — Carry stack: picked-up items are kept as data and shown as massless, non-colliding models welded in a stack above the player's head; walking into the CollectionZone (checked every 0.2s with a...

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
