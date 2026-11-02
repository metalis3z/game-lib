# Slime RNG

> 🎲 **RNG** · RNG / slime rolling · source file `Slime RNG (But with admin cmds!!) (2).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/01_HUD.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 1 ScreenGuis, 20 GUI objects → **1 screenshots** |
| Models (.rbxm) | 145 models, 0 model sets, 1 VFX sets |
| Lua builders (.lua) | 4 UI screens, 1 animation packs, 1 audio packs |
| Code | 538 scripts, 76,050 lines |
| Asset ids | 2 animations, 63 sounds |
| Safety scan | 1 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×5, `BuilderSans ExtraBold`×4, `Builder Sans ExtraBold`×1

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_HUD.jpg"><img src="screenshots/thumbs/01_HUD.jpg" width="100%"></a><br><sub><b>HUD</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Zones/2.rbxm"><img src="screenshots/thumbs/models/03_2.jpg" width="100%"></a><br><sub><b>2</b><br><code>models/Workspace/Zones/2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards.rbxm"><img src="screenshots/thumbs/models/04_Leaderboards.jpg" width="100%"></a><br><sub><b>Leaderboards</b><br><code>models/Workspace/Leaderboards.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Loot/coinPotion.rbxm"><img src="screenshots/thumbs/models/05_coinPotion.jpg" width="100%"></a><br><sub><b>coinPotion</b><br><code>models/ReplicatedStorage/Assets/Loot/coinPotion.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Loot/shinyDice.rbxm"><img src="screenshots/thumbs/models/06_shinyDice.jpg" width="100%"></a><br><sub><b>shinyDice</b><br><code>models/ReplicatedStorage/Assets/Loot/shinyDice.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Slimes/halo.rbxm"><img src="screenshots/thumbs/models/07_halo.jpg" width="100%"></a><br><sub><b>halo</b><br><code>models/ReplicatedStorage/Assets/Slimes/halo.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Slimes/ember.rbxm"><img src="screenshots/thumbs/models/09_ember.jpg" width="100%"></a><br><sub><b>ember</b><br><code>models/ReplicatedStorage/Assets/Slimes/ember.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Slimes/stormy.rbxm"><img src="screenshots/thumbs/models/11_stormy.jpg" width="100%"></a><br><sub><b>stormy</b><br><code>models/ReplicatedStorage/Assets/Slimes/stormy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Slimes/unicorn.rbxm"><img src="screenshots/thumbs/models/13_unicorn.jpg" width="100%"></a><br><sub><b>unicorn</b><br><code>models/ReplicatedStorage/Assets/Slimes/unicorn.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Loot/rollSpeedPotion.rbxm"><img src="screenshots/thumbs/models/14_rollSpeedPotion.jpg" width="100%"></a><br><sub><b>rollSpeedPotion</b><br><code>models/ReplicatedStorage/Assets/Loot/rollSpeedPotion.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`SlimeHoverInfo`](source/scripts/ReplicatedStorage/Source/Features/App/Components/SlimeHoverInfo.lua) <sub>469 lines</sub><br>[`ItemsInventoryPage`](source/scripts/ReplicatedStorage/Source/Features/Inventory/UI/Components/ItemsInventoryPage.lua) <sub>888 lines</sub><br>[`LeftSideBar`](source/scripts/ReplicatedStorage/Source/Features/Hud/Components/LeftSideBar.lua) <sub>203 lines</sub><br>[`UpgradeTilesContainer`](source/scripts/ReplicatedStorage/Source/Features/Upgrades/UI/Components/UpgradeTilesContainer.lua) <sub>257 lines</sub><br>[`CraftingMachineVisualsClient`](source/scripts/ReplicatedStorage/Source/Features/Crafting/Classes/CraftingMachineVisualsClient.lua) <sub>613 lines</sub> |
| UI controllers / window managers / menus | [`InventoryMenu`](source/scripts/ReplicatedStorage/Source/Features/Inventory/UI/InventoryMenu.lua) <sub>115 lines</sub><br>[`OfflineEarningsMenu`](source/scripts/ReplicatedStorage/Source/Features/OfflineEarnings/UI/OfflineEarningsMenu.lua) <sub>154 lines</sub><br>[`SubMenu`](source/scripts/ReplicatedStorage/Source/Features/App/Components/SubMenu.lua) <sub>181 lines</sub><br>[`Menu`](source/scripts/ReplicatedStorage/Source/Features/App/Components/Menu.lua) <sub>347 lines</sub><br>[`JackpotPurchaseSubMenu`](source/scripts/ReplicatedStorage/Source/Features/Monetization/UI/JackpotPurchaseSubMenu.lua) <sub>175 lines</sub> |
| Notifications, toasts, popups, prompts | [`AnnouncementMessages`](source/scripts/ReplicatedStorage/Source/Core/UI/Components/AnnouncementMessages.lua) <sub>148 lines</sub><br>[`Notifications`](source/scripts/ReplicatedStorage/Source/Features/Notifications/UI/Notifications.lua) <sub>134 lines</sub><br>[`TextNotifications`](source/scripts/ReplicatedStorage/Source/Features/Notifications/UI/TextNotifications.lua) <sub>153 lines</sub><br>[`ErrorMessages`](source/scripts/ReplicatedStorage/Source/Core/UI/Components/ErrorMessages.lua) <sub>114 lines</sub><br>[`NotificationBadge`](source/scripts/ReplicatedStorage/Source/Features/App/Components/NotificationBadge.lua) <sub>129 lines</sub> |
| Camera, cutscenes, screen shake | [`RareRollCutsceneVisuals`](source/scripts/ReplicatedStorage/Source/Features/Roll/RareRollCutsceneVisuals.lua) <sub>670 lines</sub><br>[`ZonePurchase`](source/scripts/ReplicatedStorage/Source/Features/Zones/Components/ZonePurchase.lua) <sub>581 lines</sub><br>[`RareRollCutscene`](source/scripts/ReplicatedStorage/Source/Features/Roll/UI/Components/RareRollCutscene.lua) <sub>447 lines</sub><br>[`ScreenShake`](source/scripts/ReplicatedStorage/Source/Core/UI/Components/ScreenShake.lua) <sub>69 lines</sub><br>[`RebirthRoot`](source/scripts/ReplicatedStorage/Source/Features/Rebirth/UI/RebirthRoot.lua) <sub>399 lines</sub> |
| VFX, particles, beams, hit effects | [`Explosion`](source/scripts/ReplicatedStorage/CustomPackages/Explosion.lua) <sub>354 lines</sub><br>[`VfxUtils`](source/scripts/ReplicatedStorage/Source/Core/Platform/VfxUtils.lua) <sub>93 lines</sub><br>[`ClientActorUtils`](source/scripts/ReplicatedStorage/Source/Features/Gameplay/Classes/ClientActorUtils.lua) <sub>304 lines</sub><br>[`RareRollCutsceneVisuals`](source/scripts/ReplicatedStorage/Source/Features/Roll/RareRollCutsceneVisuals.lua) <sub>670 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationService`](source/scripts/ServerScriptService/Services/MonetizationService.lua) <sub>334 lines</sub><br>[`MonetizationServiceClient`](source/scripts/ReplicatedStorage/Source/Features/Monetization/MonetizationServiceClient.lua) <sub>269 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`RollService`](source/scripts/ServerScriptService/Services/RollService.lua) <sub>385 lines</sub><br>[`AutoLuckService`](source/scripts/ServerScriptService/Services/AutoLuckService.lua) <sub>140 lines</sub><br>[`AutoCountdownLuckService`](source/scripts/ServerScriptService/Services/AutoCountdownLuckService.lua) <sub>86 lines</sub><br>[`RollServiceUtils`](source/scripts/ReplicatedStorage/Source/Features/Roll/RollServiceUtils.lua) <sub>338 lines</sub><br>[`JackpotUtils`](source/scripts/ReplicatedStorage/Source/Features/Roll/JackpotUtils.lua) <sub>575 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`SettingMenuPage`](source/scripts/ReplicatedStorage/Source/Features/Settings/UI/SettingMenuPage.lua) <sub>472 lines</sub><br>[`OptionSlider`](source/scripts/ReplicatedStorage/Source/Core/UI/Components/OptionSlider.lua) <sub>226 lines</sub> |
| Tycoon / plots / bases / building | [`IndexServiceUtils`](source/scripts/ReplicatedStorage/Source/Features/Index/IndexServiceUtils.lua) <sub>373 lines</sub><br>[`AdminMenu`](source/scripts/ReplicatedStorage/Source/Features/Admin/UI/AdminMenu.lua) <sub>700 lines</sub><br>[`SettingMenuPage`](source/scripts/ReplicatedStorage/Source/Features/Settings/UI/SettingMenuPage.lua) <sub>472 lines</sub><br>[`ShopCodes`](source/scripts/ReplicatedStorage/Source/Features/Monetization/UI/Frames/ShopCodes.lua) <sub>96 lines</sub> |
| Leaderboards & stats | [`LeaderboardServiceServer`](source/scripts/ServerScriptService/Services/LeaderboardServiceServer.lua) <sub>268 lines</sub> |
| Admin panels & commands | [`AdminServiceClient`](source/scripts/ReplicatedStorage/Source/Features/Admin/AdminServiceClient.lua) <sub>125 lines</sub><br>[`AdminLuckService`](source/scripts/ServerScriptService/Services/AdminLuckService.lua) <sub>115 lines</sub><br>[`AdminService`](source/scripts/ServerScriptService/Services/AdminService.lua) <sub>338 lines</sub><br>[`AdminLuckServiceClient`](source/scripts/ReplicatedStorage/Source/Features/Admin/AdminLuckServiceClient.lua) <sub>82 lines</sub><br>[`AdminMenu`](source/scripts/ReplicatedStorage/Source/Features/Admin/UI/AdminMenu.lua) <sub>700 lines</sub> |
| Sound & music | [`Sounds`](source/scripts/ReplicatedStorage/Source/Game/AssetIds/Sounds.lua) <sub>203 lines</sub><br>[`MusicPlayer`](source/scripts/ReplicatedStorage/Source/Core/Platform/MusicPlayer.lua) <sub>254 lines</sub> |
| Daily rewards, quests, codes, playtime | [`CodeService`](source/scripts/ServerScriptService/Services/CodeService.lua) <sub>151 lines</sub><br>[`OfflineEarningsService`](source/scripts/ServerScriptService/Services/OfflineEarningsService.lua) <sub>162 lines</sub><br>[`IndexRewardUtils`](source/scripts/ReplicatedStorage/Source/Features/Index/IndexRewardUtils.lua) <sub>325 lines</sub><br>[`IndexRewardsFrame`](source/scripts/ReplicatedStorage/Source/Features/Index/UI/Components/IndexRewardsFrame.lua) <sub>237 lines</sub><br>[`ShopCodes`](source/scripts/ReplicatedStorage/Source/Features/Monetization/UI/Frames/ShopCodes.lua) <sub>96 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`AdminService`](source/scripts/ServerScriptService/Services/AdminService.lua) <sub>338 lines</sub><br>[`LuckLadderServiceUtils`](source/scripts/ReplicatedStorage/Source/Features/LuckLadder/LuckLadderServiceUtils.lua) <sub>317 lines</sub><br>[`InventoryService`](source/scripts/ServerScriptService/Services/InventoryService.lua) <sub>442 lines</sub><br>[`MonetizationService`](source/scripts/ServerScriptService/Services/MonetizationService.lua) <sub>334 lines</sub><br>[`RollService`](source/scripts/ServerScriptService/Services/RollService.lua) <sub>385 lines</sub> |

### In the curated script library

- [RNG roll with zone pools, mutations and special rolls](../../Scripts/09-RNG-Gacha-Pets/ZonePoolRollMutations__slime-rng.lua) — Server roll: builds a pool from zone-unlocked slimes, boosts rare tiers with amplifiers, rolls independent mutations (huge/big/shiny/inverted), auto-equips, updates the index and counts down golden/diamond/void 'every N rolls' special rolls.
- [Random timed server luck events](../../Scripts/09-RNG-Gacha-Pets/RandomLuckEvents__slime-rng.lua) — Every 5-10 minutes picks a weighted luck multiplier (x2 common ... x50 rare) and turns on a 5 minute server luck event through the admin luck service.
- [Index / collection tracking + rewards](../../Scripts/09-RNG-Gacha-Pets/IndexCollectionTracking__slime-rng.lua) — Index service: migrates old saves into the index (retroactively unlocking owned slimes), tracks counts per category/mutation and hands out index milestone rewards.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Packages/_Index/csqrl_sift@0.0.11/sift/Array.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
