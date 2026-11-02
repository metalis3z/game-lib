# Brainrot Lab

> 🧠 **Brainrot** · brainrot simulator (lab / fusing) · source file `brainrotlabfullworkingspoof.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/07_GUI__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 5 ScreenGuis, 1225 GUI objects → **16 screenshots** |
| Models (.rbxm) | 194 models, 12 model sets, 5 VFX sets |
| Lua builders (.lua) | 24 UI screens, 200 animation packs, 67 audio packs |
| Code | 174 scripts, 40,669 lines |
| Asset ids | 130 animations, 86 sounds |
| Safety scan | 0 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Heavy`×237, `SourceSansPro Regular`×87, `FredokaOne Regular`×72, `GothamSSm ExtraBold`×26, `font asset 11702779517 Heavy`×13

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_GUI__Shop.jpg"><img src="screenshots/thumbs/07_GUI__Shop.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_UI__ShoppingMachine.jpg"><img src="screenshots/thumbs/15_UI__ShoppingMachine.jpg" width="100%"></a><br><sub><b>UI</b> › ShoppingMachine</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_GUI__Index.jpg"><img src="screenshots/thumbs/08_GUI__Index.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Index</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_GUI__Wheel.jpg"><img src="screenshots/thumbs/05_GUI__Wheel.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_GUI__Offline.jpg"><img src="screenshots/thumbs/06_GUI__Offline.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Offline</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_GUI__Upgrades.jpg"><img src="screenshots/thumbs/02_GUI__Upgrades.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Upgrades</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_GUI__Rebirth.jpg"><img src="screenshots/thumbs/04_GUI__Rebirth.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_UpgradeTemplate.jpg"><img src="screenshots/thumbs/16_UpgradeTemplate.jpg" width="100%"></a><br><sub><b>UpgradeTemplate</b></sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_Trade__TradeSele_o.jpg"><img src="screenshots/thumbs/13_Trade__TradeSele_o.jpg" width="100%"></a><br><sub><b>Trade</b> › TradeSeleção</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_UI_Trade_machine__Ui_TRadeMachine.jpg"><img src="screenshots/thumbs/14_UI_Trade_machine__Ui_TRadeMachine.jpg" width="100%"></a><br><sub><b>UI Trade machine</b> › Ui TRadeMachine</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_GUI__Admin.jpg"><img src="screenshots/thumbs/09_GUI__Admin.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Admin</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_GUI.jpg"><img src="screenshots/thumbs/01_GUI.jpg" width="100%"></a><br><sub><b>GUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_GUI__Weights.jpg"><img src="screenshots/thumbs/03_GUI__Weights.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Weights</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_GUI__Ingredients.jpg"><img src="screenshots/thumbs/10_GUI__Ingredients.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Ingredients</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_GUI__Effect.jpg"><img src="screenshots/thumbs/11_GUI__Effect.jpg" width="100%"></a><br><sub><b>GUI</b> › Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_WeightTemplate.jpg"><img src="screenshots/thumbs/17_WeightTemplate.jpg" width="100%"></a><br><sub><b>WeightTemplate</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Maquinas_Intera%C3%A7%C3%A3o/Characters/Miner.rbxm"><img src="screenshots/thumbs/models/01_Miner.jpg" width="100%"></a><br><sub><b>Miner</b><br><code>models/Workspace/Maquinas_Interação/Characters/Miner.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Bases%20Skins/Aquatic%202%20floors.rbxm"><img src="screenshots/thumbs/models/02_Aquatic_2_floors.jpg" width="100%"></a><br><sub><b>Aquatic 2 floors</b><br><code>models/ReplicatedStorage/Bases Skins/Aquatic 2 floors.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Templates/Plot.rbxm"><img src="screenshots/thumbs/models/03_Plot.jpg" width="100%"></a><br><sub><b>Plot</b><br><code>models/ReplicatedStorage/Templates/Plot.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Ingredients/Flower.rbxm"><img src="screenshots/thumbs/models/04_Flower.jpg" width="100%"></a><br><sub><b>Flower</b><br><code>models/ReplicatedStorage/Ingredients/Flower.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Maquinas_Intera%C3%A7%C3%A3o/Assets/TradeMachine.rbxm"><img src="screenshots/thumbs/models/05_TradeMachine.jpg" width="100%"></a><br><sub><b>TradeMachine</b><br><code>models/Workspace/Maquinas_Interação/Assets/TradeMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Templates/Bullet.rbxm"><img src="screenshots/thumbs/models/07_Bullet.jpg" width="100%"></a><br><sub><b>Bullet</b><br><code>models/ReplicatedStorage/Templates/Bullet.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/Money.rbxm"><img src="screenshots/thumbs/models/08_Money.jpg" width="100%"></a><br><sub><b>Money</b><br><code>models/Workspace/Leaderboards/Money.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Maquinas_Intera%C3%A7%C3%A3o/Characters/Missionary_psalms.rbxm"><img src="screenshots/thumbs/models/09_Missionary_psalms.jpg" width="100%"></a><br><sub><b>Missionary_psalms</b><br><code>models/Workspace/Maquinas_Interação/Characters/Missionary_psalms.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Bases%20Skins/Aquatic%201%20floors.rbxm"><img src="screenshots/thumbs/models/10_Aquatic_1_floors.jpg" width="100%"></a><br><sub><b>Aquatic 1 floors</b><br><code>models/ReplicatedStorage/Bases Skins/Aquatic 1 floors.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Plots/2.rbxm"><img src="screenshots/thumbs/models/11_2.jpg" width="100%"></a><br><sub><b>2</b><br><code>models/Workspace/Plots/2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Ingredients/Star.rbxm"><img src="screenshots/thumbs/models/12_Star.jpg" width="100%"></a><br><sub><b>Star</b><br><code>models/ReplicatedStorage/Ingredients/Star.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Maquinas_Intera%C3%A7%C3%A3o/Assets/maquinha%20Spaw.rbxm"><img src="screenshots/thumbs/models/13_maquinha_Spaw.jpg" width="100%"></a><br><sub><b>maquinha Spaw</b><br><code>models/Workspace/Maquinas_Interação/Assets/maquinha Spaw.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`UIEffects`](source/scripts/StarterPlayer/StarterCharacterScripts/UIEffects.client.lua) <sub>573 lines</sub><br>[`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua) <sub>2733 lines</sub><br>[`PopUpController`](source/scripts/StarterPlayer/StarterPlayerScripts/PopUpController.client.lua) <sub>149 lines</sub><br>[`WeightsUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/WeightsUIController.client.lua) <sub>231 lines</sub><br>[`SellController`](source/scripts/StarterPlayer/StarterPlayerScripts/SellController.client.lua) <sub>167 lines</sub> |
| UI controllers / window managers / menus | [`FrameManager`](source/scripts/ReplicatedStorage/Modules/FrameManager.lua) <sub>97 lines</sub><br>[`UIInitializer`](source/scripts/StarterPlayer/StarterPlayerScripts/UIInitializer.client.lua) <sub>184 lines</sub><br>[`OfflineUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/OfflineUIController.client.lua) <sub>103 lines</sub><br>[`HUDController`](source/scripts/StarterPlayer/StarterPlayerScripts/HUDController.client.lua) <sub>156 lines</sub><br>[`LimitedItemUIController`](source/scripts/StarterPlayer/StarterPlayerScripts/LimitedItemUIController.client.lua) <sub>165 lines</sub> |
| Notifications, toasts, popups, prompts | [`PopUpController`](source/scripts/StarterPlayer/StarterPlayerScripts/PopUpController.client.lua) <sub>149 lines</sub><br>[`NotificationManager`](source/scripts/ReplicatedStorage/Modules/NotificationManager.lua) <sub>113 lines</sub><br>[`PromptController`](source/scripts/StarterPlayer/StarterPlayerScripts/PromptController.client.lua) <sub>141 lines</sub><br>[`AnnouncementReceiver`](source/scripts/StarterPlayer/StarterPlayerScripts/AnnouncementReceiver.client.lua) <sub>1145 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>606 lines</sub> |
| Camera, cutscenes, screen shake | [`WindShake`](source/scripts/StarterPlayer/StarterPlayerScripts/WindController/WindShake.lua) <sub>316 lines</sub><br>[`CameraShaker`](source/scripts/ReplicatedStorage/Modules/CameraShaker.lua) <sub>209 lines</sub><br>[`CameraShakePresets`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShakePresets.lua) <sub>105 lines</sub><br>[`UIEffects`](source/scripts/StarterPlayer/StarterCharacterScripts/UIEffects.client.lua) <sub>573 lines</sub><br>[`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>989 lines</sub> |
| VFX, particles, beams, hit effects | [`UIEffects`](source/scripts/StarterPlayer/StarterCharacterScripts/UIEffects.client.lua) <sub>573 lines</sub><br>[`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>617 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>606 lines</sub><br>[`Acid`](source/scripts/ReplicatedStorage/Eventos/AcidStorm/AcidStorm/Acid.lua) <sub>641 lines</sub><br>[`Love`](source/scripts/ReplicatedStorage/Eventos/Love/Love/Love.lua) <sub>588 lines</sub> |
| DataStore / player data | [`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>617 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>258 lines</sub><br>[`ShopController`](source/scripts/StarterPlayer/StarterPlayerScripts/ShopController.client.lua) <sub>259 lines</sub><br>[`IngredientShopController`](source/scripts/StarterPlayer/StarterPlayerScripts/IngredientShopController.client.lua) <sub>130 lines</sub><br>[`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>617 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`MonetizationController`](source/scripts/ServerScriptService/Controllers/MonetizationController.lua) <sub>258 lines</sub><br>[`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>989 lines</sub><br>[`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>617 lines</sub><br>[`CollisionController`](source/scripts/ServerScriptService/CollisionController.server.lua) <sub>95 lines</sub><br>[`BrainrotConveyor`](source/scripts/ServerScriptService/Modules/BrainrotConveyor.lua) <sub>1138 lines</sub> |
| Trading systems | [`TradeServer`](source/scripts/ServerScriptService/Modules/TradeServer.lua) <sub>366 lines</sub><br>[`TradeClient`](source/scripts/StarterPlayer/StarterPlayerScripts/TradeClient.client.lua) <sub>669 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`KickController`](source/scripts/StarterPlayer/StarterPlayerScripts/KickController.client.lua) <sub>989 lines</sub><br>[`HitboxClass`](source/scripts/ReplicatedStorage/Modules/HitboxClass.lua) <sub>892 lines</sub><br>[`HitboxMoverScript`](source/scripts/ServerScriptService/HitboxMoverScript.server.lua) <sub>130 lines</sub><br>[`HitboxClassLocal`](source/scripts/ReplicatedStorage/Modules/HitboxClass/HitboxClassLocal.client.lua) <sub>66 lines</sub><br>[`Types`](source/scripts/ReplicatedStorage/Modules/HitboxClass/Types.lua) <sub>98 lines</sub> |
| Tycoon / plots / bases / building | [`BrainrotConveyor`](source/scripts/ServerScriptService/Modules/BrainrotConveyor.lua) <sub>1138 lines</sub><br>[`PlotController`](source/scripts/StarterPlayer/StarterPlayerScripts/PlotController.client.lua) <sub>179 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>606 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>484 lines</sub><br>[`UIEffects`](source/scripts/StarterPlayer/StarterCharacterScripts/UIEffects.client.lua) <sub>573 lines</sub> |
| Admin panels & commands | [`AdminHandler`](source/scripts/ServerScriptService/Modules/AdminHandler.lua) <sub>607 lines</sub><br>[`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua) <sub>2733 lines</sub> |
| Sound & music | [`MusicController`](source/scripts/StarterPlayer/StarterPlayerScripts/MusicController.client.lua) <sub>66 lines</sub> |
| Daily rewards, quests, codes, playtime | [`PlayerController`](source/scripts/ServerScriptService/Controllers/PlayerController.lua) <sub>617 lines</sub><br>[`MorphRewardHandler`](source/scripts/ServerScriptService/MorphRewardHandler.server.lua) <sub>39 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`NumberFormatter`](source/scripts/ReplicatedStorage/Modules/NumberFormatter.lua) <sub>34 lines</sub><br>[`SlotManager`](source/scripts/ServerScriptService/Modules/SlotManager.lua) <sub>606 lines</sub><br>[`PlotManager`](source/scripts/ServerScriptService/PlotManager.server.lua) <sub>484 lines</sub><br>[`ItemManager`](source/scripts/ServerScriptService/Modules/ItemManager.lua) <sub>651 lines</sub><br>[`BrainrotConveyor`](source/scripts/ServerScriptService/Modules/BrainrotConveyor.lua) <sub>1138 lines</sub> |

### In the curated script library

- [Panel server: one handler per remote](../../Scripts/16-Admin/AdminHandler-PanelRemotes__brainrot-lab.lua) — Admin panel backend with one function per remote (spawn items, start/end events locally or globally, announcements, private-server tools, youtuber tags), each starting with an isAdmin check, plus player resolving by id or name.
- [Floating reward pop-ups](../../Scripts/03-Notifications/RewardPopUp__brainrot-lab.lua) — "+$123" reward pop-ups at a random spot near screen centre: pop-size + fade in, float up + fade out, with sound; driven by server RemoteEvents.
- [Server-wide pity timers](../../Scripts/09-RNG-Gacha-Pets/PityTimerSpawns__brainrot-lab.lua) — Conveyor spawner where Legendary / Mythical / Secret never roll randomly; instead a countdown per rarity guarantees one when it hits zero, with a world sign showing the time left.
- [State-driven music crossfade](../../Scripts/17-Sound-Music/MusicCrossfadeByState__brainrot-lab.lua) — Two looping tracks (background and run music) that crossfade with TweenService whenever the player state changes (here: a morph model exists on the character).
- [Event sound sequence with screen flash](../../Scripts/17-Sound-Music/EventSoundSequence__brainrot-lab.lua) — Server-triggered event stingers: plays a sequence of named sounds one after another (waiting on Ended) and syncs a full-screen white flash to one of them, using a token so overlapping flashes cancel cleanly.
- [Tool trade server](../../Scripts/10-Trading/ToolTradeServer__brainrot-lab.lua) — Clean trade module for Tool items with InTrade lock, request timeout and final re-validation.
- [Tool trade client](../../Scripts/10-Trading/ToolTradeClient__brainrot-lab.lua) — Client for tool trades: request toasts with countdown, player list, viewport item previews.
- [Fixed-plot manager with floor upgrades](../../Scripts/14-Tycoon-Plots/PlotManager__brainrot-lab.lua) — Simple, readable plot system: 8 fixed plots, first free index goes to the joining player, extra floors are shown/hidden as the player buys base upgrades (price + rebirth requirement per level),...
- [Podium slots: place, collect, upgrade](../../Scripts/14-Tycoon-Plots/SlotManager__brainrot-lab.lua) — Podium/slot logic for a brainrot tycoon: place the held tool on an empty slot, swap or pick up from an occupied one, slots accumulate money over time, touch a collect pad to cash out, and level up...
- [Conveyor belt spawner with pity and delivery to base](../../Scripts/14-Tycoon-Plots/BrainrotConveyor__brainrot-lab.lua) — Server conveyor belt: spawns a weighted-random brainrot every few seconds at point A, lerps it to point B, players press E in range to buy it, then it walks to the buyer's base (stealable in...
- [Universal button FX + tag-driven effects](../../Scripts/01-UI-Animation/UniversalButtonFX_TagEffects__brainrot-lab.lua) — Auto-hooks every GuiButton with hover/press UIScale tweens + sounds, and drives CollectionService-tagged effects (sunburst spin, rotating/panning UIGradient, random shine sparkles, looping UIScale pulse).
- [Floating reward popups](../../Scripts/01-UI-Animation/PopUpController_RewardFloat__brainrot-lab.lua) — "+$amount" reward popups at a random spot near screen centre: size pop with Back-out, content fade-in, then float up and fade out.
- [FrameManager (one frame at a time)](../../Scripts/02-UI-Framework/FrameManager__brainrot-lab.lua) — Opens one frame at a time with a slide-up tween; buttons wired as Open/Close/Toggle.
- [UI initializer with name-based button binding](../../Scripts/02-UI-Framework/UIInitializer__brainrot-lab.lua) — Hides frames on boot, binds HUD buttons to frames by name, hover/press animations, opens menus from pads or by distance.
- [HUD stats controller](../../Scripts/02-UI-Framework/HUDController__brainrot-lab.lua) — Syncs HUD labels with leaderstats and wires product, random-item and invite buttons with button animations.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
