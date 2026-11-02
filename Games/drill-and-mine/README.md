# +1 Drill & Mine

> ⛏️ **Simulator** · incremental simulator (+1 speed, mining, drills) · source file `+1 Drill & Mine.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/26_Tabs__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 4 ScreenGuis, 2177 GUI objects → **41 screenshots** |
| Models (.rbxm) | 636 models, 129 model sets, 2 VFX sets |
| Lua builders (.lua) | 35 UI screens, 145 animation packs, 1 audio packs |
| Code | 204 scripts, 61,039 lines |
| Asset ids | 86 animations, 38 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Heavy`×551, `GothamSSm ExtraBold`×494, `LegacyArial Regular`×106, `FredokaOne Regular`×10, `SourceSansPro Bold`×6

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_GUI__BuyTransition.jpg"><img src="screenshots/thumbs/05_GUI__BuyTransition.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.BuyTransition</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_GUI__TrailShop.jpg"><img src="screenshots/thumbs/06_GUI__TrailShop.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.TrailShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_GUI__Shop.jpg"><img src="screenshots/thumbs/11_GUI__Shop.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.Shop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_GUI__UpgradeShop.jpg"><img src="screenshots/thumbs/13_GUI__UpgradeShop.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.UpgradeShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_GUI__ItemShop.jpg"><img src="screenshots/thumbs/16_GUI__ItemShop.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.ItemShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_Tabs__SpeedShop.jpg"><img src="screenshots/thumbs/24_Tabs__SpeedShop.jpg" width="100%"></a><br><sub><b>Tabs</b> › SpeedShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_Tabs__CarryShop.jpg"><img src="screenshots/thumbs/25_Tabs__CarryShop.jpg" width="100%"></a><br><sub><b>Tabs</b> › CarryShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_Tabs__Shop.jpg"><img src="screenshots/thumbs/26_Tabs__Shop.jpg" width="100%"></a><br><sub><b>Tabs</b> › Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_Tabs__ProductSpin.jpg"><img src="screenshots/thumbs/32_Tabs__ProductSpin.jpg" width="100%"></a><br><sub><b>Tabs</b> › Spin.ProductSpin</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_GearShop.jpg"><img src="screenshots/thumbs/37_GearShop.jpg" width="100%"></a><br><sub><b>GearShop</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_GUI__InventoryFrame.jpg"><img src="screenshots/thumbs/14_GUI__InventoryFrame.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.InventoryFrame</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_GUI__Index.jpg"><img src="screenshots/thumbs/08_GUI__Index.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.Index</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_Tabs__Index.jpg"><img src="screenshots/thumbs/28_Tabs__Index.jpg" width="100%"></a><br><sub><b>Tabs</b> › Index</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_GUI__DailyGifts.jpg"><img src="screenshots/thumbs/07_GUI__DailyGifts.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.DailyGifts</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_GUI__OfflineReward.jpg"><img src="screenshots/thumbs/09_GUI__OfflineReward.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.OfflineReward</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_GUI__FreeGiftFrame.jpg"><img src="screenshots/thumbs/17_GUI__FreeGiftFrame.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.FreeGiftFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_Tabs__Gifts.jpg"><img src="screenshots/thumbs/30_Tabs__Gifts.jpg" width="100%"></a><br><sub><b>Tabs</b> › Gifts</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_Tabs__Spin.jpg"><img src="screenshots/thumbs/31_Tabs__Spin.jpg" width="100%"></a><br><sub><b>Tabs</b> › Spin.Spin</sub></td>
<td width="33%" valign="top"><a href="screenshots/36_GiftRequest.jpg"><img src="screenshots/thumbs/36_GiftRequest.jpg" width="100%"></a><br><sub><b>GiftRequest</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_GUI__Rebirth.jpg"><img src="screenshots/thumbs/10_GUI__Rebirth.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_TradeRequest.jpg"><img src="screenshots/thumbs/22_TradeRequest.jpg" width="100%"></a><br><sub><b>TradeRequest</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_Tabs__Rebirth.jpg"><img src="screenshots/thumbs/27_Tabs__Rebirth.jpg" width="100%"></a><br><sub><b>Tabs</b> › Rebirth</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_TutorialMessage.jpg"><img src="screenshots/thumbs/21_TutorialMessage.jpg" width="100%"></a><br><sub><b>TutorialMessage</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/35_Notification.jpg"><img src="screenshots/thumbs/35_Notification.jpg" width="100%"></a><br><sub><b>Notification</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_LoadingScreen.jpg"><img src="screenshots/thumbs/41_LoadingScreen.jpg" width="100%"></a><br><sub><b>LoadingScreen</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_GUI__TopButtons.jpg"><img src="screenshots/thumbs/18_GUI__TopButtons.jpg" width="100%"></a><br><sub><b>GUI</b> › HUD.TopButtons</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_GUI__PickUpButtons.jpg"><img src="screenshots/thumbs/19_GUI__PickUpButtons.jpg" width="100%"></a><br><sub><b>GUI</b> › HUD.PickUpButtons</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_BottomRight.jpg"><img src="screenshots/thumbs/40_BottomRight.jpg" width="100%"></a><br><sub><b>BottomRight</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Removal.jpg"><img src="screenshots/thumbs/01_Removal.jpg" width="100%"></a><br><sub><b>Removal</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_Addition.jpg"><img src="screenshots/thumbs/02_Addition.jpg" width="100%"></a><br><sub><b>Addition</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_ShutdownUI.jpg"><img src="screenshots/thumbs/03_ShutdownUI.jpg" width="100%"></a><br><sub><b>ShutdownUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_GUI.jpg"><img src="screenshots/thumbs/04_GUI.jpg" width="100%"></a><br><sub><b>GUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_GUI__SellFrame.jpg"><img src="screenshots/thumbs/12_GUI__SellFrame.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.SellFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_GUI__LostBrainrotsScreen.jpg"><img src="screenshots/thumbs/15_GUI__LostBrainrotsScreen.jpg" width="100%"></a><br><sub><b>GUI</b> › Folder.LostBrainrotsScreen</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Axe.jpg"><img src="screenshots/thumbs/20_Axe.jpg" width="100%"></a><br><sub><b>Axe</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_TeleportButtons.jpg"><img src="screenshots/thumbs/23_TeleportButtons.jpg" width="100%"></a><br><sub><b>TeleportButtons</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_Tabs__Carrying.jpg"><img src="screenshots/thumbs/29_Tabs__Carrying.jpg" width="100%"></a><br><sub><b>Tabs</b> › Carrying</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_Tabs__Sell.jpg"><img src="screenshots/thumbs/33_Tabs__Sell.jpg" width="100%"></a><br><sub><b>Tabs</b> › Sell</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_ScreenGui.jpg"><img src="screenshots/thumbs/34_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/38_Error.jpg"><img src="screenshots/thumbs/38_Error.jpg" width="100%"></a><br><sub><b>Error</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_DropGui.jpg"><img src="screenshots/thumbs/39_DropGui.jpg" width="100%"></a><br><sub><b>DropGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Assets/Map/TrailShop.rbxm"><img src="screenshots/thumbs/models/01_TrailShop.jpg" width="100%"></a><br><sub><b>TrailShop</b><br><code>models/Workspace/Assets/Map/TrailShop.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Drills/Drill12%20-%20Candy.rbxm"><img src="screenshots/thumbs/models/02_Drill12_-_Candy.jpg" width="100%"></a><br><sub><b>Drill12 - Candy</b><br><code>models/ReplicatedStorage/Drills/Drill12 - Candy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Assets/Map/portal%20tortal.rbxm"><img src="screenshots/thumbs/models/03_portal_tortal.jpg" width="100%"></a><br><sub><b>portal tortal</b><br><code>models/Workspace/Assets/Map/portal tortal.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/RarityItems/Divine/Periastron%20Sword.rbxm"><img src="screenshots/thumbs/models/04_Periastron_Sword.jpg" width="100%"></a><br><sub><b>Periastron Sword</b><br><code>models/ReplicatedStorage/RarityItems/Divine/Periastron Sword.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/Dragon%20Egg.rbxm"><img src="screenshots/thumbs/models/05_Dragon_Egg.jpg" width="100%"></a><br><sub><b>Dragon Egg</b><br><code>models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/Dragon Egg.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/RarityItems/Epic/Golden%20Hat.rbxm"><img src="screenshots/thumbs/models/06_Golden_Hat.jpg" width="100%"></a><br><sub><b>Golden Hat</b><br><code>models/ReplicatedStorage/RarityItems/Epic/Golden Hat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/Sapphire%20Crystal.rbxm"><img src="screenshots/thumbs/models/07_Sapphire_Crystal.jpg" width="100%"></a><br><sub><b>Sapphire Crystal</b><br><code>models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/Sapphire Crystal.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/THUMB.rbxm"><img src="screenshots/thumbs/models/08_THUMB.jpg" width="100%"></a><br><sub><b>THUMB</b><br><code>models/Workspace/THUMB.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lbs/TopCash/Stands/1st.rbxm"><img src="screenshots/thumbs/models/09_1st.jpg" width="100%"></a><br><sub><b>1st</b><br><code>models/Workspace/Lbs/TopCash/Stands/1st.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Assets/Map/GRASS%20Add~4/Part__x53.rbxm"><img src="screenshots/thumbs/models/10_Part_x53.jpg" width="100%"></a><br><sub><b>Part__x53</b><br><code>models/Workspace/Assets/Map/GRASS Add~4/Part__x53.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/SpawnBoard/BoardPart.rbxm"><img src="screenshots/thumbs/models/11_BoardPart.jpg" width="100%"></a><br><sub><b>BoardPart</b><br><code>models/Workspace/SpawnBoard/BoardPart.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Assets/Map/SellShop.rbxm"><img src="screenshots/thumbs/models/12_SellShop.jpg" width="100%"></a><br><sub><b>SellShop</b><br><code>models/Workspace/Assets/Map/SellShop.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/void%20ball.rbxm"><img src="screenshots/thumbs/models/13_void_ball.jpg" width="100%"></a><br><sub><b>void ball</b><br><code>models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/void ball.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/Magic%20Sword.rbxm"><img src="screenshots/thumbs/models/14_Magic_Sword.jpg" width="100%"></a><br><sub><b>Magic Sword</b><br><code>models/ReplicatedStorage/RarityItemsOriginals/RarityShowcase/Magic Sword.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`AnimatedText`](source/scripts/ReplicatedStorage/Source/Modules/AnimatedText.lua) <sub>1316 lines</sub><br>[`HoverController`](source/scripts/ReplicatedStorage/Source/Controllers/HoverController.lua) <sub>285 lines</sub><br>[`RarityLootClient`](source/scripts/StarterPlayer/StarterPlayerScripts/RarityLootClient.client.lua) <sub>1053 lines</sub><br>[`IslandBrainrotClient`](source/scripts/StarterPlayer/StarterPlayerScripts/IslandBrainrotClient.client.lua) <sub>2680 lines</sub><br>[`DailyRewardController`](source/scripts/ReplicatedStorage/Source/Controllers/DailyRewardController.lua) <sub>827 lines</sub> |
| UI controllers / window managers / menus | [`LootBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LootBlockController.lua) <sub>830 lines</sub><br>[`DailyRewardController`](source/scripts/ReplicatedStorage/Source/Controllers/DailyRewardController.lua) <sub>827 lines</sub><br>[`LuckyBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LuckyBlockController.lua) <sub>1153 lines</sub><br>[`FrameAnimator`](source/scripts/ReplicatedStorage/Source/Modules/FrameAnimator.lua) <sub>801 lines</sub><br>[`Satchel`](source/scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua) <sub>2178 lines</sub> |
| Notifications, toasts, popups, prompts | [`NotificationsController`](source/scripts/ReplicatedStorage/Source/Controllers/NotificationsController.lua) <sub>250 lines</sub><br>[`ProximityPromptScript`](source/scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua) <sub>664 lines</sub><br>[`LootBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LootBlockController.lua) <sub>830 lines</sub><br>[`DailyRewardController`](source/scripts/ReplicatedStorage/Source/Controllers/DailyRewardController.lua) <sub>827 lines</sub><br>[`BuyTransitionController`](source/scripts/ReplicatedStorage/Source/Controllers/BuyTransitionController.lua) <sub>377 lines</sub> |
| Loading / intro screens | [`LoadingScreenController`](source/scripts/ReplicatedStorage/Source/Controllers/LoadingScreenController.lua) <sub>40 lines</sub><br>[`BrainrotController`](source/scripts/ReplicatedStorage/Source/Controllers/BrainrotController.lua) <sub>1016 lines</sub><br>[`PodiumController`](source/scripts/ReplicatedStorage/Source/Controllers/PodiumController.lua) <sub>2762 lines</sub><br>[`DrillClient`](source/scripts/StarterPlayer/StarterPlayerScripts/DrillClient.client.lua) <sub>1048 lines</sub><br>[`IslandBrainrotClient`](source/scripts/StarterPlayer/StarterPlayerScripts/IslandBrainrotClient.client.lua) <sub>2680 lines</sub> |
| Camera, cutscenes, screen shake | [`LootBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LootBlockController.lua) <sub>830 lines</sub><br>[`LuckyBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LuckyBlockController.lua) <sub>1153 lines</sub><br>[`DrillClient`](source/scripts/StarterPlayer/StarterPlayerScripts/DrillClient.client.lua) <sub>1048 lines</sub><br>[`PadUnboxing`](source/scripts/ReplicatedStorage/Source/Modules/PadUnboxing.lua) <sub>649 lines</sub><br>[`ItemShopController`](source/scripts/ReplicatedStorage/Source/Controllers/ItemShopController.lua) <sub>641 lines</sub> |
| VFX, particles, beams, hit effects | [`PodiumController`](source/scripts/ReplicatedStorage/Source/Controllers/PodiumController.lua) <sub>2762 lines</sub><br>[`PadUnboxing`](source/scripts/ReplicatedStorage/Source/Modules/PadUnboxing.lua) <sub>649 lines</sub><br>[`DrillClient`](source/scripts/StarterPlayer/StarterPlayerScripts/DrillClient.client.lua) <sub>1048 lines</sub><br>[`FireworkModule`](source/scripts/ReplicatedStorage/Source/Modules/FireworkModule.lua) <sub>98 lines</sub><br>[`ConfettiFX`](source/scripts/ReplicatedStorage/Source/Modules/ConfettiFX.lua) <sub>276 lines</sub> |
| DataStore / player data | [`PlayerDataService`](source/scripts/ServerScriptService/Source/Services/PlayerDataService.lua) <sub>280 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`PurchaseService`](source/scripts/ServerScriptService/Source/Services/PurchaseService.lua) <sub>404 lines</sub><br>[`GamepassService`](source/scripts/ServerScriptService/Source/Services/GamepassService.lua) <sub>116 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`LootBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LootBlockController.lua) <sub>830 lines</sub><br>[`LuckyBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LuckyBlockController.lua) <sub>1153 lines</sub><br>[`LuckyBlockService`](source/scripts/ServerScriptService/Source/Services/LuckyBlockService.lua) <sub>499 lines</sub><br>[`EquipVisualController`](source/scripts/ReplicatedStorage/Source/Controllers/EquipVisualController.lua) <sub>726 lines</sub><br>[`RarityItemSpawner`](source/scripts/ServerScriptService/RarityItemSpawner.server.lua) <sub>878 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`WaveSystem`](source/scripts/ServerStorage/__LootRejects/LBL_Temp_GemCrystalOreShard/ungroup%20in%20ServerScriptService/WaveSystem.server.lua) <sub>174 lines</sub><br>[`LuckyBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LuckyBlockController.lua) <sub>1153 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`HUDSlideController`](source/scripts/ReplicatedStorage/Source/Controllers/HUDSlideController.lua) <sub>225 lines</sub><br>[`TreeAreaController`](source/scripts/ReplicatedStorage/Source/Controllers/TreeAreaController.lua) <sub>1068 lines</sub><br>[`SurfaceModeController`](source/scripts/StarterPlayer/StarterPlayerScripts/SurfaceModeController.client.lua) <sub>213 lines</sub><br>[`SettingsController`](source/scripts/ReplicatedStorage/Source/Controllers/SettingsController.lua) <sub>327 lines</sub> |
| Tycoon / plots / bases / building | [`BaseUpgradeController`](source/scripts/ReplicatedStorage/Source/Controllers/BaseUpgradeController.lua) <sub>430 lines</sub><br>[`PodiumController`](source/scripts/ReplicatedStorage/Source/Controllers/PodiumController.lua) <sub>2762 lines</sub><br>[`SellController`](source/scripts/ReplicatedStorage/Source/Controllers/SellController.lua) <sub>635 lines</sub><br>[`BaseUpgradeService`](source/scripts/ServerScriptService/Source/Services/BaseUpgradeService.lua) <sub>452 lines</sub><br>[`DailyRewardController`](source/scripts/ReplicatedStorage/Source/Controllers/DailyRewardController.lua) <sub>827 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/Source/Services/LeaderboardService.lua) <sub>400 lines</sub><br>[`LevelBarController`](source/scripts/StarterGui/GUI/HUD/LevelBarController.client.lua) <sub>146 lines</sub> |
| Admin panels & commands | [`AdminCommandsService`](source/scripts/ServerScriptService/Source/Services/AdminCommandsService.lua) <sub>491 lines</sub><br>[`AdminConsoleClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminConsoleClient.client.lua) <sub>221 lines</sub> |
| Sound & music | [`MusicController`](source/scripts/ReplicatedStorage/Source/Controllers/MusicController.lua) <sub>76 lines</sub><br>[`UIClickSound`](source/scripts/StarterPlayer/StarterPlayerScripts/UIClickSound.client.lua) <sub>62 lines</sub><br>[`MusicService`](source/scripts/ServerScriptService/Source/Services/MusicService.lua) <sub>20 lines</sub><br>[`StrengthClickClient`](source/scripts/StarterPlayer/StarterPlayerScripts/StrengthClickClient.client.lua) <sub>255 lines</sub><br>[`DrillClient`](source/scripts/StarterPlayer/StarterPlayerScripts/DrillClient.client.lua) <sub>1048 lines</sub> |
| Daily rewards, quests, codes, playtime | [`DailyRewardService`](source/scripts/ServerScriptService/Source/Services/DailyRewardService.lua) <sub>220 lines</sub><br>[`DailyRewardController`](source/scripts/ReplicatedStorage/Source/Controllers/DailyRewardController.lua) <sub>827 lines</sub><br>[`OfflineRewardController`](source/scripts/ReplicatedStorage/Source/Controllers/OfflineRewardController.lua) <sub>218 lines</sub><br>[`IndexRewardService`](source/scripts/ServerScriptService/Source/Services/IndexRewardService.lua) <sub>113 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`LootBlockController`](source/scripts/ReplicatedStorage/Source/Controllers/LootBlockController.lua) <sub>830 lines</sub><br>[`ItemShopController`](source/scripts/ReplicatedStorage/Source/Controllers/ItemShopController.lua) <sub>641 lines</sub><br>[`SellController`](source/scripts/ReplicatedStorage/Source/Controllers/SellController.lua) <sub>635 lines</sub><br>[`TrailShopController`](source/scripts/ReplicatedStorage/Source/Controllers/TrailShopController.lua) <sub>415 lines</sub><br>[`BrainrotController`](source/scripts/ReplicatedStorage/Source/Controllers/BrainrotController.lua) <sub>1016 lines</sub> |

### In the curated script library

- [Text console with owner-only wipes](../../Scripts/16-Admin/AdminCommandsService-Console__drill-and-mine.lua) — F2 text console backend: tokenizer, partial-name player lookup, give-anything commands that reuse the real grant paths, aliases, help text, owner-only data wipe, cross-server shutdown via MessagingService.
- [F2 console UI (client)](../../Scripts/16-Admin/AdminConsoleClient-F2Console__drill-and-mine.lua) — Client side of the console: asks the server if you are an admin, builds a small F2 text box UI, sends the raw line with RunCommand and prints the reply.
- [7-day calendar with streak reset](../../Scripts/18-Daily-Rewards-Quests/DailyRewardService-Streak__drill-and-mine.lua) — 7-day login calendar: state resolved lazily on read (claimable / countdown / streak broken after 2 days), config-driven reward types, payload for the UI, and a paid 'skip all days' product.
- [Offline earnings (capped, rate-based)](../../Scripts/18-Daily-Rewards-Quests/OfflineEarnings-Podiums__drill-and-mine.lua) — Offline cash = income per second x offline seconds (capped at 12h) x boosts x a 1/6 offline rate, a gamepass multiplier and auto-collect, a 'measured earning pace' fallback, a claim-all popup endpoint, and LastLogin bookkeeping on join/leave.
- [ProfileService service with migration sweep](../../Scripts/07-Data-Saving/PlayerDataService-ProfileService__drill-and-mine.lua) — ProfileService load/release, leaderstats mirror, migration sweep that drops items no longer in config, debounced ScheduleSave, and an admin data wipe (WipeProfileAsync).
- [Boards + #1 podium + rank tags](../../Scripts/15-Leaderboards/LeaderboardService-PodiumAndTags__drill-and-mine.lua) — Config list of boards (store, value getter, formatter), SurfaceGui rows with headshots, a #1 podium dummy wearing the top player's avatar (rig scale kept), per-board rank attributes and a '[#3 Cash]' chat tag, playtime counter.
- [Loading finished gate controller](../../Scripts/04-Loading-Screens/LoadingGateController__drill-and-mine.lua) — Tiny controller exposing LoadingFinished (BindableEvent) and IsLoadingComplete() so other systems can wait for the loading screen; here it just removes the old screen and marks complete.
- [Soft shutdown teleport screen](../../Scripts/04-Loading-Screens/SoftShutdownTeleportScreen__drill-and-mine.lua) — Soft-shutdown client: reads teleport data, shows an arriving/leaving screen, and uses TeleportService:SetTeleportGui so a custom loading screen shows during the teleport between servers.
- [Gamepass ownership as attributes](../../Scripts/08-Monetization/GamepassService-Attributes__drill-and-mine.lua) — Checks each configured pass on join, mirrors ownership to OwnsGamepass_<key> player attributes, updates on purchase, and registers pass-based boost percents with a boost aggregator.
- [Prompt with context + announcements](../../Scripts/08-Monetization/PurchaseService-PromptContext__drill-and-mine.lua) — Server-side prompt that remembers a pending purchase and context string, routes the grant by context, checks the client context against the configured product id, logs Robux spent and posts a rich-text 'X bought Y' message with verified/premium glyphs.
- [Starter pack with playtime countdown](../../Scripts/08-Monetization/StoreService-StarterPackTimer__drill-and-mine.lua) — One-time packs with reward lists, a starter pack that expires after N seconds of playtime (ticks only while online), pack status query for the UI, and cash packs scaled to the player's income.
- [Premium membership perk](../../Scripts/08-Monetization/RobloxPlusService-Premium__drill-and-mine.lua) — Gives Roblox Premium members a cash boost: checks MembershipType, listens to PlayerMembershipChanged and PromptPremiumPurchaseFinished, lets the client open PromptPremiumPurchase.
- [Boost aggregator (pass/premium/rebirth sources)](../../Scripts/08-Monetization/CashBoostService-Sources__drill-and-mine.lua) — Registry of named boost sources (gamepass, premium, index, rebirths...) summed into one multiplier, with a per-source breakdown pushed to the client HUD.
- [Toast controller with duplicate merge](../../Scripts/03-Notifications/ToastController__drill-and-mine.lua) — Colored toast notifications (Red/Green templates) that merge duplicates into "(xN)", pulse on repeat, pop in/out with UIScale, and preload their sounds.
- [HUD badge pulse](../../Scripts/03-Notifications/NotifyBadgePulse__drill-and-mine.lua) — Attention badge on a HUD button: every few seconds two red rings ripple out while the badge pops and wiggles like a bell.
- [Lucky block opening with luck tier-up](../../Scripts/09-RNG-Gacha-Pets/LuckyBlockService__drill-and-mine.lua) — Lucky block open flow: luck gives a chance per step to climb a rarity tier (capped at +2), skips invalid ids, falls back along the rarity ladder, and holds rewards as 'pending' until the reveal animation confirms (auto-applies on timeout or leave).
- [Client music loop with watchdog](../../Scripts/17-Sound-Music/MusicWatchdog__drill-and-mine.lua) — Client-driven background music with a watchdog: picks the song from SoundService.Music, forces Looped, and restarts it on Ended/Stopped/Paused or if a 2-second check finds it silent. Explains why music should be driven on the client.
- [Global UI click sound](../../Scripts/17-Sound-Music/UIClickSound__drill-and-mine.lua) — Global UI click sound: hooks every GuiButton in PlayerGui (now and later, via DescendantAdded) plus every ProximityPrompt trigger, preloads the sound, and plays a short-lived clone.
- [Volume sliders with debounced save](../../Scripts/17-Sound-Music/SettingsVolumeSliders__drill-and-mine.lua) — Settings controller with Music and Sounds volume sliders (tweened fill bar and knob). Applies volume to every Sound in SoundService.Music and SoundService.Sounds, including ones added later, and debounces saves to the server (0.3 s task.delay cancelled on each new change).
- [Minimal plot assigner](../../Scripts/14-Tycoon-Plots/PlotService__drill-and-mine.lua) — The smallest clean plot assigner in the set (~100 lines): sorts plots by number, gives the first one with OwnerUserId == 0, teleports the player there on every spawn, and runs registered reset...
- [Base floor upgrades from templates](../../Scripts/14-Tycoon-Plots/BaseUpgradeService__drill-and-mine.lua) — Buy-the-next-floor base upgrades: keeps floor/podium templates out of the world, clones the unlocked ones into the player's plot per level, charges a per-level cost, throttles requests with a 1s...
- [Grouped hover controller](../../Scripts/01-UI-Animation/HoverController_GroupedUIScale__drill-and-mine.lua) — Button hover/press/bounce via a per-button UIScale with tween cancelling, hover groups (several buttons react as one), icon tilt, pooled hover sound and a throttled 30 Hz sunburst/gradient spinner.
- [Per-character animated text](../../Scripts/01-UI-Animation/AnimatedText_PerCharBezier__drill-and-mine.lua) — Per-character text animation: only changed characters drop/scale in with CSS cubic-bezier easing, CanvasGroup layers per glyph, value-increase pop via UIScale (AnimatedText.Pop). Advanced.
- [Window open/close manager with blur + FOV](../../Scripts/01-UI-Animation/FrameAnimator_WindowOpenBlurFov__drill-and-mine.lua) — Window manager: Back-eased open / Quad-in close, blur + camera FOV tween, HUD groups slide off-screen while a window is open, cached fade tweens, open-by-button or by standing on a part.
- [Pop-in toast notifications](../../Scripts/01-UI-Animation/NotificationsController_PopToast__drill-and-mine.lua) — Toast notifications that pop in on a UIScale (0 -> 1, Quart out) while fading every descendant, merge duplicates into "(xN)" with an overshoot pulse, and pop out with Back-in.
- [Badge ripple + wiggle](../../Scripts/01-UI-Animation/NotifyBadgePulse_RippleWiggle__drill-and-mine.lua) — Notification badge attention loop: two expanding UIStroke rings that fade out, a small UIScale pop, and a bell-style rotation wiggle every 2.6 s.
- [UIScale breathing pulse](../../Scripts/01-UI-Animation/UIScaleBreathingPulse__drill-and-mine.lua) — Minimal infinite "breathing" pulse: UIScale tween 1 -> 1.10, Sine InOut, repeat -1, reverses. Comment explains why UIScale beats Size tweening.
- [Rainbow ripple rings](../../Scripts/01-UI-Animation/RebirthRingsFX_RainbowRings__drill-and-mine.lua) — Train of expanding rainbow UIStroke rings on a BillboardGui around the player (rotating UIGradient per ring, fade as they grow).
- [Progress bar fill + pop-hold](../../Scripts/01-UI-Animation/LevelBarFill_PopHold__drill-and-mine.lua) — XP progress-bar fill tween (skips tiny changes), level text, and a "pop and hold" UIScale on stat gain that rests inflated while gains keep coming; coalesces refreshes per frame.
- [Click sparkle burst](../../Scripts/01-UI-Animation/ClickSparkleBurst__drill-and-mine.lua) — Pure 2D click/tap feedback: spawns radial dots and streak frames at the cursor that fly outward, shrink and fade.
- [HUD edge slide in/out](../../Scripts/01-UI-Animation/HUDSlideController_EdgeSlide__drill-and-mine.lua) — Slides HUD groups off the top/left/bottom edges (Quart in/out, scale-only offscreen targets) and back in based on player location.
- [2D confetti celebration](../../Scripts/01-UI-Animation/ConfettiFX_ScreenConfetti__drill-and-mine.lua) — Screen-space confetti burst built fully in code (image templates flung and fading) plus an optional world firework emitter burst.
- [Idle icon rock](../../Scripts/01-UI-Animation/IconRockWiggle__drill-and-mine.lua) — Endless Sine InOut rotation rock (+10 / -20 degrees) for an idle shop icon.
- [Cash count-up lerp](../../Scripts/01-UI-Animation/CashCountUpLerp__drill-and-mine.lua) — Count-up currency display: exponential lerp of the displayed value toward the real value each frame (only rewriting Text when it changes) plus a Size pulse on change.
- [FrameAnimator (blur, FOV, HUD slide)](../../Scripts/02-UI-Framework/FrameAnimator__drill-and-mine.lua) — Full frame manager with size/fade tweens, blur, FOV zoom, HUD sliding off-screen and button/part triggers.
- [HUD slide off-screen by area](../../Scripts/02-UI-Framework/HUDSlideController__drill-and-mine.lua) — Slides HUD edge groups off-screen when the player leaves home, using a manual Heartbeat lerp.
- [UIStroke screen scaler](../../Scripts/02-UI-Framework/UiStrokeScaler__drill-and-mine.lua) — Scales every UIStroke thickness by screen width relative to 1920 px.
- [Commas, clock time, abbreviation](../../Scripts/19-Utility/FormatUtils-CommasTimeAbbrev__drill-and-mine.lua) — Three helpers: FormatNumber adds thousands commas, FormatTime gives mm:ss or h:mm:ss, Abbreviate gives 1.5M style text with a long suffix list.
- [UserId -> name cache](../../Scripts/19-Utility/NameCache__drill-and-mine.lua) — Tiny function that caches GetNameFromUserIdAsync results so boards and UIs do not call the web API repeatedly.
- [Firework burst](../../Scripts/06-VFX/FireworkBurst__drill-and-mine.lua) — Ring of firework bursts with staged emits and safe sound cleanup.
- [Confetti FX](../../Scripts/06-VFX/ConfettiFX__drill-and-mine.lua) — Self-contained UI confetti + world burst for rewards / celebrations.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
