# Survive LAVA for Brainrot

> 🧠 **Brainrot** · survival / brainrot collecting · source file `1;1 Survive LAVA for Brainrot.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/11_HUD__MainShop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 6 ScreenGuis, 5206 GUI objects → **21 screenshots** |
| Models (.rbxm) | 944 models, 32 model sets, 4 VFX sets |
| Lua builders (.lua) | 19 UI screens, 0 animation packs, 2 audio packs |
| Code | 332 scripts, 34,769 lines |
| Asset ids | 1066 animations, 37 sounds |
| Safety scan | 0 HIGH / 2 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×2569, `SourceSansPro Bold`×91, `GothamSSm Bold`×43, `BuilderSans Medium`×26, `LegacyArial Regular`×23

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_HUD__OldMainShop.jpg"><img src="screenshots/thumbs/03_HUD__OldMainShop.jpg" width="100%"></a><br><sub><b>HUD</b> › OldMainShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_HUD__MainShop.jpg"><img src="screenshots/thumbs/11_HUD__MainShop.jpg" width="100%"></a><br><sub><b>HUD</b> › MainShop</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_BackpackGui.jpg"><img src="screenshots/thumbs/18_BackpackGui.jpg" width="100%"></a><br><sub><b>BackpackGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_BackpackGui__Inventory.jpg"><img src="screenshots/thumbs/19_BackpackGui__Inventory.jpg" width="100%"></a><br><sub><b>BackpackGui</b> › Backpack.Inventory</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_HUD__Index.jpg"><img src="screenshots/thumbs/04_HUD__Index.jpg" width="100%"></a><br><sub><b>HUD</b> › Index</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_HUD__Gift.jpg"><img src="screenshots/thumbs/07_HUD__Gift.jpg" width="100%"></a><br><sub><b>HUD</b> › Gift</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_HUD__Rebirth.jpg"><img src="screenshots/thumbs/02_HUD__Rebirth.jpg" width="100%"></a><br><sub><b>HUD</b> › Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_HUD__Upgrades.jpg"><img src="screenshots/thumbs/05_HUD__Upgrades.jpg" width="100%"></a><br><sub><b>HUD</b> › Upgrades</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_HUD__CarryUpgrades.jpg"><img src="screenshots/thumbs/06_HUD__CarryUpgrades.jpg" width="100%"></a><br><sub><b>HUD</b> › CarryUpgrades</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_HUD__FakeRebirth.jpg"><img src="screenshots/thumbs/09_HUD__FakeRebirth.jpg" width="100%"></a><br><sub><b>HUD</b> › FakeRebirth</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_BackpackGui__GamepadHintsFrame.jpg"><img src="screenshots/thumbs/20_BackpackGui__GamepadHintsFrame.jpg" width="100%"></a><br><sub><b>BackpackGui</b> › Backpack.GamepadHintsFrame</sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_HUD__FuseMachine.jpg"><img src="screenshots/thumbs/15_HUD__FuseMachine.jpg" width="100%"></a><br><sub><b>HUD</b> › FuseMachine</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_HUD__Admin.jpg"><img src="screenshots/thumbs/14_HUD__Admin.jpg" width="100%"></a><br><sub><b>HUD</b> › Admin</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_Cmdr__Autocomplete.jpg"><img src="screenshots/thumbs/17_Cmdr__Autocomplete.jpg" width="100%"></a><br><sub><b>Cmdr</b> › Autocomplete</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_HUD.jpg"><img src="screenshots/thumbs/01_HUD.jpg" width="100%"></a><br><sub><b>HUD</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_HUD__Revive.jpg"><img src="screenshots/thumbs/08_HUD__Revive.jpg" width="100%"></a><br><sub><b>HUD</b> › Revive</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_HUD__LuckyBlock.jpg"><img src="screenshots/thumbs/10_HUD__LuckyBlock.jpg" width="100%"></a><br><sub><b>HUD</b> › LuckyBlock</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_HUD__PollCreate.jpg"><img src="screenshots/thumbs/12_HUD__PollCreate.jpg" width="100%"></a><br><sub><b>HUD</b> › PollCreate</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_HUD__Poll.jpg"><img src="screenshots/thumbs/13_HUD__Poll.jpg" width="100%"></a><br><sub><b>HUD</b> › Poll</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_HUD__BaseSkins.jpg"><img src="screenshots/thumbs/16_HUD__BaseSkins.jpg" width="100%"></a><br><sub><b>HUD</b> › BaseSkins</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_RotatingToolUIOLD.jpg"><img src="screenshots/thumbs/21_RotatingToolUIOLD.jpg" width="100%"></a><br><sub><b>RotatingToolUIOLD</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Model~3.rbxm"><img src="screenshots/thumbs/models/01_Model_3.jpg" width="100%"></a><br><sub><b>Model~3</b><br><code>models/ReplicatedStorage/Model~3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Brainrots/Bloodmoon/ElefanteLavante.rbxm"><img src="screenshots/thumbs/models/02_ElefanteLavante.jpg" width="100%"></a><br><sub><b>ElefanteLavante</b><br><code>models/ReplicatedStorage/Brainrots/Bloodmoon/ElefanteLavante.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPack/Bat.rbxm"><img src="screenshots/thumbs/models/03_Bat.jpg" width="100%"></a><br><sub><b>Bat</b><br><code>models/StarterPack/Bat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/LowGravityHelmet.rbxm"><img src="screenshots/thumbs/models/04_LowGravityHelmet.jpg" width="100%"></a><br><sub><b>LowGravityHelmet</b><br><code>models/ReplicatedStorage/Assets/LowGravityHelmet.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Star.rbxm"><img src="screenshots/thumbs/models/05_Star.jpg" width="100%"></a><br><sub><b>Star</b><br><code>models/ReplicatedStorage/Assets/Star.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Folder/Luckyblock~3.rbxm"><img src="screenshots/thumbs/models/06_Luckyblock_3.jpg" width="100%"></a><br><sub><b>Luckyblock~3</b><br><code>models/ReplicatedStorage/Folder/Luckyblock~3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/GameFolder/Structures/Common/Rock__x26.rbxm"><img src="screenshots/thumbs/models/07_Rock_x26.jpg" width="100%"></a><br><sub><b>Rock__x26</b><br><code>models/Workspace/GameFolder/Structures/Common/Rock__x26.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/LuckyBlockModels/Moon%20Secret%20Lucky%20Block.rbxm"><img src="screenshots/thumbs/models/08_Moon_Secret_Lucky_Block.jpg" width="100%"></a><br><sub><b>Moon Secret Lucky Block</b><br><code>models/ReplicatedStorage/Assets/LuckyBlockModels/Moon Secret Lucky Block.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/MoonMap/Leaderboard.rbxm"><img src="screenshots/thumbs/models/09_Leaderboard.jpg" width="100%"></a><br><sub><b>Leaderboard</b><br><code>models/ReplicatedStorage/Assets/MoonMap/Leaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/CommonMap/Pine%20Tree__x10.rbxm"><img src="screenshots/thumbs/models/10_Pine_Tree_x10.jpg" width="100%"></a><br><sub><b>Pine Tree__x10</b><br><code>models/Workspace/CommonMap/Pine Tree__x10.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Prop%20Ladder.rbxm"><img src="screenshots/thumbs/models/11_Prop_Ladder.jpg" width="100%"></a><br><sub><b>Prop Ladder</b><br><code>models/ReplicatedStorage/Prop Ladder.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/BaseSkins/Cheese.rbxm"><img src="screenshots/thumbs/models/12_Cheese.jpg" width="100%"></a><br><sub><b>Cheese</b><br><code>models/ReplicatedStorage/Assets/BaseSkins/Cheese.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/The%20Moon%20%28PBR%29.rbxm"><img src="screenshots/thumbs/models/13_The_Moon_PBR_.jpg" width="100%"></a><br><sub><b>The Moon (PBR)</b><br><code>models/Workspace/The Moon (PBR).rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Folder/Luckyblock.rbxm"><img src="screenshots/thumbs/models/14_Luckyblock.jpg" width="100%"></a><br><sub><b>Luckyblock</b><br><code>models/ReplicatedStorage/Folder/Luckyblock.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`NewAdminPanelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/NewAdminPanelController.lua) <sub>655 lines</sub><br>[`UIController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/UIController.lua) <sub>1550 lines</sub><br>[`Satchel`](source/scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua) <sub>1864 lines</sub><br>[`Spring`](source/scripts/ReplicatedStorage/Modules/Spring.lua) <sub>611 lines</sub><br>[`SecretTexts`](source/scripts/StarterPlayer/StarterPlayerScripts/SecretTexts.client.lua) <sub>88 lines</sub> |
| UI controllers / window managers / menus | [`UIController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/UIController.lua) <sub>1550 lines</sub><br>[`Window`](source/scripts/ReplicatedStorage/CmdrClient/CmdrInterface/Window.lua) <sub>279 lines</sub><br>[`NewAdminPanelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/NewAdminPanelController.lua) <sub>655 lines</sub><br>[`Satchel`](source/scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua) <sub>1864 lines</sub><br>[`Container`](source/scripts/ReplicatedStorage/Icon/Elements/Container.lua) <sub>212 lines</sub> |
| Notifications, toasts, popups, prompts | [`ItemManager`](source/scripts/ServerScriptService/Modules/ItemManager.lua) <sub>412 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>179 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>404 lines</sub><br>[`CarrySystem`](source/scripts/ServerScriptService/Modules/CarrySystem.lua) <sub>241 lines</sub><br>[`TsunamiManager`](source/scripts/ServerScriptService/Modules/TsunamiManager.lua) <sub>201 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraShaker`](source/scripts/ReplicatedStorage/Modules/CameraShaker.lua) <sub>127 lines</sub><br>[`CameraShakeInstance`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShakeInstance.lua) <sub>128 lines</sub><br>[`CameraShakeController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CameraShakeController.lua) <sub>36 lines</sub><br>[`CameraShakePresets`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShakePresets.lua) <sub>66 lines</sub> |
| VFX, particles, beams, hit effects | [`MutationHitEffectController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/MutationHitEffectController.lua) <sub>111 lines</sub><br>[`FuseMachineController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/FuseMachineController.lua) <sub>712 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>101 lines</sub><br>[`UIController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/UIController.lua) <sub>1550 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`LuckyBlocksRegistry`](source/scripts/ReplicatedStorage/Registries/LuckyBlocksRegistry.lua) <sub>302 lines</sub><br>[`RarityRegistry`](source/scripts/ReplicatedStorage/Registries/RarityRegistry.lua) <sub>64 lines</sub><br>[`NewAdminPanelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/NewAdminPanelController.lua) <sub>655 lines</sub><br>[`UIController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/UIController.lua) <sub>1550 lines</sub><br>[`AdminPanelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminPanelController.lua) <sub>657 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Satchel`](source/scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua) <sub>1864 lines</sub> |
| Tycoon / plots / bases / building | [`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>404 lines</sub><br>[`PlotsController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/PlotsController.lua) <sub>442 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>179 lines</sub><br>[`TutorialController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/TutorialController.lua) <sub>249 lines</sub><br>[`BaseSkinController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/BaseSkinController.lua) <sub>206 lines</sub> |
| Leaderboards & stats | [`LeaderboardController`](source/scripts/ServerScriptService/Controllers/LeaderboardController.lua) <sub>228 lines</sub> |
| Admin panels & commands | [`AdminPanelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminPanelController.lua) <sub>657 lines</sub><br>[`NewAdminPanelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/NewAdminPanelController.lua) <sub>655 lines</sub><br>[`CMDRController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CMDRController.lua) <sub>37 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`ItemManager`](source/scripts/ServerScriptService/Modules/ItemManager.lua) <sub>412 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>404 lines</sub><br>[`LeaderboardController`](source/scripts/ServerScriptService/Controllers/LeaderboardController.lua) <sub>228 lines</sub><br>[`SellManager`](source/scripts/ServerScriptService/Modules/SellManager.lua) <sub>137 lines</sub><br>[`Utility`](source/scripts/ReplicatedStorage/Icon/Utility.lua) <sub>592 lines</sub> |

### In the curated script library

- [Config-routed receipt (beginner friendly)](../../Scripts/08-Monetization/MonetizationController-ConfigRouted__survive-lava-for-brainrot.lua) — Readable receipt controller: product name from a config module, then reward tables for speed, items, carry upgrades and cash, with lazy-required systems and a client notification.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
