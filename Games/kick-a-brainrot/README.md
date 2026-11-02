# Kick A ... (template)

> 🧠 **Brainrot** · kick / launch simulator (fireworks, camera shake) · source file `Kick A Template For Slbr Booster do not leak or ban perm.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/08_GUI__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 1 ScreenGuis, 300 GUI objects → **11 screenshots** |
| Models (.rbxm) | 262 models, 13 model sets, 3 VFX sets |
| Lua builders (.lua) | 19 UI screens, 145 animation packs, 2 audio packs |
| Code | 121 scripts, 26,859 lines |
| Asset ids | 207 animations, 16 sounds |
| Safety scan | 0 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Heavy`×87, `SourceSansPro Regular`×28, `font asset 11702779517 Heavy`×15

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_GUI__Shop.jpg"><img src="screenshots/thumbs/08_GUI__Shop.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Shop</sub></td>
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
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_GUI__Upgrades.jpg"><img src="screenshots/thumbs/02_GUI__Upgrades.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Upgrades</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_GUI__Rebirth.jpg"><img src="screenshots/thumbs/04_GUI__Rebirth.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_UpgradeTemplate.jpg"><img src="screenshots/thumbs/10_UpgradeTemplate.jpg" width="100%"></a><br><sub><b>UpgradeTemplate</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_GUI.jpg"><img src="screenshots/thumbs/01_GUI.jpg" width="100%"></a><br><sub><b>GUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_GUI__Weights.jpg"><img src="screenshots/thumbs/03_GUI__Weights.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Weights</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_GUI__Effect.jpg"><img src="screenshots/thumbs/09_GUI__Effect.jpg" width="100%"></a><br><sub><b>GUI</b> › Effect</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_WeightTemplate.jpg"><img src="screenshots/thumbs/11_WeightTemplate.jpg" width="100%"></a><br><sub><b>WeightTemplate</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/BIG%20LUCKY%20BLOCK%20FILE/Models/Animals/AURA%20Lucky%20Block.rbxm"><img src="screenshots/thumbs/models/01_AURA_Lucky_Block.jpg" width="100%"></a><br><sub><b>AURA Lucky Block</b><br><code>models/Workspace/BIG LUCKY BLOCK FILE/Models/Animals/AURA Lucky Block.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Diamond/Yeti%20Fruit.rbxm"><img src="screenshots/thumbs/models/02_Yeti_Fruit.jpg" width="100%"></a><br><sub><b>Yeti Fruit</b><br><code>models/ReplicatedStorage/Items/Diamond/Yeti Fruit.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/LuckyBlocks/Food%20Lucky%20Block.rbxm"><img src="screenshots/thumbs/models/03_Food_Lucky_Block.jpg" width="100%"></a><br><sub><b>Food Lucky Block</b><br><code>models/ReplicatedStorage/LuckyBlocks/Food Lucky Block.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Trees/Tree3~6/TrunkBase.rbxm"><img src="screenshots/thumbs/models/04_TrunkBase.jpg" width="100%"></a><br><sub><b>TrunkBase</b><br><code>models/Workspace/Map/Trees/Tree3~6/TrunkBase.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Diamond/Kitsune.rbxm"><img src="screenshots/thumbs/models/05_Kitsune.jpg" width="100%"></a><br><sub><b>Kitsune</b><br><code>models/ReplicatedStorage/Items/Diamond/Kitsune.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Brushtool2_Plugin_Storage/7559537296_BrushtoolBrushObjects/%7BB0440F6C-5A88-42AE-8B4F-28006D6AE04D%7D/Tree.rbxm"><img src="screenshots/thumbs/models/06_Tree.jpg" width="100%"></a><br><sub><b>Tree</b><br><code>models/ServerStorage/Brushtool2_Plugin_Storage/7559537296_BrushtoolBrushObjects/{B0440F6C-5A88-42AE-8B4F-28006D6AE04D}/Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/RebirthsLeaderboard.rbxm"><img src="screenshots/thumbs/models/07_RebirthsLeaderboard.jpg" width="100%"></a><br><sub><b>RebirthsLeaderboard</b><br><code>models/Workspace/Leaderboards/RebirthsLeaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BIG%20LUCKY%20BLOCK%20FILE/Models/Animals/Strawberry%20Lucky%20Block.rbxm"><img src="screenshots/thumbs/models/08_Strawberry_Lucky_Block.jpg" width="100%"></a><br><sub><b>Strawberry Lucky Block</b><br><code>models/Workspace/BIG LUCKY BLOCK FILE/Models/Animals/Strawberry Lucky Block.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/BIG%20LUCKY%20BLOCK%20FILE/LuckyBoxes/SecretBlock.rbxm"><img src="screenshots/thumbs/models/09_SecretBlock.jpg" width="100%"></a><br><sub><b>SecretBlock</b><br><code>models/Workspace/BIG LUCKY BLOCK FILE/LuckyBoxes/SecretBlock.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Diamond/Goro.rbxm"><img src="screenshots/thumbs/models/10_Goro.jpg" width="100%"></a><br><sub><b>Goro</b><br><code>models/ReplicatedStorage/Items/Diamond/Goro.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/MoneyLeaderboard.rbxm"><img src="screenshots/thumbs/models/11_MoneyLeaderboard.jpg" width="100%"></a><br><sub><b>MoneyLeaderboard</b><br><code>models/Workspace/Leaderboards/MoneyLeaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BIG%20LUCKY%20BLOCK%20FILE/Models/Animals/Niz%20Lucky%20Block.rbxm"><img src="screenshots/thumbs/models/12_Niz_Lucky_Block.jpg" width="100%"></a><br><sub><b>Niz Lucky Block</b><br><code>models/Workspace/BIG LUCKY BLOCK FILE/Models/Animals/Niz Lucky Block.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/BIG%20LUCKY%20BLOCK%20FILE/LuckyBoxes/BabyBlock.rbxm"><img src="screenshots/thumbs/models/13_BabyBlock.jpg" width="100%"></a><br><sub><b>BabyBlock</b><br><code>models/Workspace/BIG LUCKY BLOCK FILE/LuckyBoxes/BabyBlock.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BIG%20LUCKY%20BLOCK%20FILE/Models/Animals/TRILLIONAIRE%20Lucky%20Block.rbxm"><img src="screenshots/thumbs/models/14_TRILLIONAIRE_Lucky_Block.jpg" width="100%"></a><br><sub><b>TRILLIONAIRE Lucky Block</b><br><code>models/Workspace/BIG LUCKY BLOCK FILE/Models/Animals/TRILLIONAIRE Lucky Block.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>982 lines</sub><br>[`ShopController`](source/scripts/StarterPlayer/StarterPlayerScripts/ShopController.client.lua) <sub>257 lines</sub><br>[`UIInitializer`](source/scripts/StarterPlayer/StarterPlayerScripts/UIInitializer.client.lua) <sub>151 lines</sub> |
| UI controllers / window managers / menus | [`UIInitializer`](source/scripts/StarterPlayer/StarterPlayerScripts/UIInitializer.client.lua) <sub>151 lines</sub><br>[`LimitedItemUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/LimitedItemUIController.client.lua) <sub>161 lines</sub><br>[`RebirthUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/RebirthUIController.client.lua) <sub>155 lines</sub><br>[`SpeedUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/SpeedUIController.client.lua) <sub>41 lines</sub><br>[`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>982 lines</sub> |
| Notifications, toasts, popups, prompts | [`PromptController`](source/scripts/StarterPlayer/StarterPlayerScripts/PromptController.client.lua) <sub>132 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>209 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>489 lines</sub><br>[`LimitedItemUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/LimitedItemUIController.client.lua) <sub>161 lines</sub><br>[`RebirthUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/RebirthUIController.client.lua) <sub>155 lines</sub> |
| Camera, cutscenes, screen shake | [`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>982 lines</sub> |
| VFX, particles, beams, hit effects | [`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>982 lines</sub><br>[`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>240 lines</sub><br>[`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>587 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>489 lines</sub> |
| DataStore / player data | [`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>587 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>240 lines</sub><br>[`ShopController`](source/scripts/StarterPlayer/StarterPlayerScripts/ShopController.client.lua) <sub>257 lines</sub><br>[`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>587 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>240 lines</sub><br>[`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>982 lines</sub><br>[`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>587 lines</sub><br>[`LuckyBlockConfigurations`](source/scripts/ReplicatedStorage/Modules/LuckyBlockConfigurations.lua) <sub>86 lines</sub><br>[`CollisionController`](source/scripts/ServerScriptService/CollisionController.server.lua) <sub>89 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>982 lines</sub> |
| Tycoon / plots / bases / building | [`PlotController`](source/scripts/StarterPlayer/StarterPlayerScripts/PlotController.client.lua) <sub>177 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>489 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>209 lines</sub><br>[`ShopController`](source/scripts/StarterPlayer/StarterPlayerScripts/ShopController.client.lua) <sub>257 lines</sub><br>[`LimitedItemUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/LimitedItemUIController.client.lua) <sub>161 lines</sub> |
| Leaderboards & stats | [`LeaderboardController`](source/scripts/ServerScriptService/Controllers/LeaderboardController.lua) <sub>184 lines</sub> |
| Daily rewards, quests, codes, playtime | [`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>587 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>489 lines</sub><br>[`SellManager`](source/scripts/ServerScriptService/Modules/SellManager.lua) <sub>137 lines</sub><br>[`RebirthSystem`](source/scripts/ServerScriptService/Modules/RebirthSystem.lua) <sub>147 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>209 lines</sub><br>[`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>240 lines</sub> |

### In the curated script library

- [Offline earnings (simple)](../../Scripts/18-Daily-Rewards-Quests/OfflineEarnings-Simple__kick-a-brainrot.lua) — Minimal offline earnings: time since last save (capped at 8h) x each placed item's income x mutation/level/rebirth/VIP multipliers, shown in a popup and paid on a Claim remote.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
