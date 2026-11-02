# Smash Egg For Animals

> ⛏️ **Simulator** · clicker / egg hatching simulator · source file `Slbr - Booster - Smash Egg For Animals.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/14_Removed_SeedShopGui__RowTemplate.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 19 ScreenGuis, 447 GUI objects → **61 screenshots** |
| Models (.rbxm) | 2876 models, 298 model sets, 2 VFX sets |
| Lua builders (.lua) | 140 UI screens, 19 animation packs, 6 audio packs |
| Code | 822 scripts, 338,147 lines |
| Asset ids | 234 animations, 17 sounds |
| Safety scan | 2 HIGH / 9 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Montserrat Heavy`×79, `RobotoMono Regular`×41, `SourceSansPro Regular`×31, `SourceSansPro Bold`×16, `ComicNeueAngular Regular`×11

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_icon_pour_trainer_shop.jpg"><img src="screenshots/thumbs/01_icon_pour_trainer_shop.jpg" width="100%"></a><br><sub><b>icon pour trainer shop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_ShopGui.jpg"><img src="screenshots/thumbs/08_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Removed_EggShopGui__RowTemplate.jpg"><img src="screenshots/thumbs/12_Removed_EggShopGui__RowTemplate.jpg" width="100%"></a><br><sub><b>Removed_EggShopGui</b> › RowTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_Removed_SeedShopGui__RowTemplate.jpg"><img src="screenshots/thumbs/14_Removed_SeedShopGui__RowTemplate.jpg" width="100%"></a><br><sub><b>Removed_SeedShopGui</b> › RowTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_DragonShopGui.jpg"><img src="screenshots/thumbs/18_DragonShopGui.jpg" width="100%"></a><br><sub><b>DragonShopGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_icon_amelioration_shop.jpg"><img src="screenshots/thumbs/23_icon_amelioration_shop.jpg" width="100%"></a><br><sub><b>icon amelioration shop</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_ShopGui.jpg"><img src="screenshots/thumbs/37_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/48_ShopGui.jpg"><img src="screenshots/thumbs/48_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/52_icon_pour_trainer_shop.jpg"><img src="screenshots/thumbs/52_icon_pour_trainer_shop.jpg" width="100%"></a><br><sub><b>icon pour trainer shop</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/54_VIP.jpg"><img src="screenshots/thumbs/54_VIP.jpg" width="100%"></a><br><sub><b>VIP</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_OfflineGui__Dim.jpg"><img src="screenshots/thumbs/04_OfflineGui__Dim.jpg" width="100%"></a><br><sub><b>OfflineGui</b> › Dim</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_RewardsUI.jpg"><img src="screenshots/thumbs/11_RewardsUI.jpg" width="100%"></a><br><sub><b>RewardsUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_OfflineGui__Dim.jpg"><img src="screenshots/thumbs/33_OfflineGui__Dim.jpg" width="100%"></a><br><sub><b>OfflineGui</b> › Dim</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/44_OfflineGui__Dim.jpg"><img src="screenshots/thumbs/44_OfflineGui__Dim.jpg" width="100%"></a><br><sub><b>OfflineGui</b> › Dim</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_UpgradesGui.jpg"><img src="screenshots/thumbs/21_UpgradesGui.jpg" width="100%"></a><br><sub><b>UpgradesGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_RebirthGui.jpg"><img src="screenshots/thumbs/27_RebirthGui.jpg" width="100%"></a><br><sub><b>RebirthGui</b></sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_TradeButton.jpg"><img src="screenshots/thumbs/26_TradeButton.jpg" width="100%"></a><br><sub><b>TradeButton</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_icon_leaderboard.jpg"><img src="screenshots/thumbs/10_icon_leaderboard.jpg" width="100%"></a><br><sub><b>icon leaderboard</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_icon_leaderboard.jpg"><img src="screenshots/thumbs/39_icon_leaderboard.jpg" width="100%"></a><br><sub><b>icon leaderboard</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_BasePanelGui.jpg"><img src="screenshots/thumbs/29_BasePanelGui.jpg" width="100%"></a><br><sub><b>BasePanelGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_BasePanelGui__Panel.jpg"><img src="screenshots/thumbs/30_BasePanelGui__Panel.jpg" width="100%"></a><br><sub><b>BasePanelGui</b> › Panel</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MoneyGui.jpg"><img src="screenshots/thumbs/02_MoneyGui.jpg" width="100%"></a><br><sub><b>MoneyGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_SettingsGui__Main.jpg"><img src="screenshots/thumbs/03_SettingsGui__Main.jpg" width="100%"></a><br><sub><b>SettingsGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_PetInventoryGui__Main.jpg"><img src="screenshots/thumbs/05_PetInventoryGui__Main.jpg" width="100%"></a><br><sub><b>PetInventoryGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_left_bottom.jpg"><img src="screenshots/thumbs/06_left_bottom.jpg" width="100%"></a><br><sub><b>left bottom</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_IndexGui__Main.jpg"><img src="screenshots/thumbs/07_IndexGui__Main.jpg" width="100%"></a><br><sub><b>IndexGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_ShopGui__Main.jpg"><img src="screenshots/thumbs/09_ShopGui__Main.jpg" width="100%"></a><br><sub><b>ShopGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_Removed_EggShopGui__Main.jpg"><img src="screenshots/thumbs/13_Removed_EggShopGui__Main.jpg" width="100%"></a><br><sub><b>Removed_EggShopGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_Removed_SeedShopGui__Main.jpg"><img src="screenshots/thumbs/15_Removed_SeedShopGui__Main.jpg" width="100%"></a><br><sub><b>Removed_SeedShopGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_CodeGui__Main.jpg"><img src="screenshots/thumbs/17_CodeGui__Main.jpg" width="100%"></a><br><sub><b>CodeGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_DragonShopGui__Main.jpg"><img src="screenshots/thumbs/19_DragonShopGui__Main.jpg" width="100%"></a><br><sub><b>DragonShopGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_UpgradesGui__Main.jpg"><img src="screenshots/thumbs/22_UpgradesGui__Main.jpg" width="100%"></a><br><sub><b>UpgradesGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_PetInventoryGui_BeforeRestyle__Main.jpg"><img src="screenshots/thumbs/24_PetInventoryGui_BeforeRestyle__Main.jpg" width="100%"></a><br><sub><b>PetInventoryGui_BeforeRestyle</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_RebirthGui__Main.jpg"><img src="screenshots/thumbs/28_RebirthGui__Main.jpg" width="100%"></a><br><sub><b>RebirthGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_MoneyGui.jpg"><img src="screenshots/thumbs/31_MoneyGui.jpg" width="100%"></a><br><sub><b>MoneyGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/32_SettingsGui__Main.jpg"><img src="screenshots/thumbs/32_SettingsGui__Main.jpg" width="100%"></a><br><sub><b>SettingsGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_PetInventoryGui__Main.jpg"><img src="screenshots/thumbs/34_PetInventoryGui__Main.jpg" width="100%"></a><br><sub><b>PetInventoryGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_left_bottom.jpg"><img src="screenshots/thumbs/35_left_bottom.jpg" width="100%"></a><br><sub><b>left bottom</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_IndexGui__Main.jpg"><img src="screenshots/thumbs/36_IndexGui__Main.jpg" width="100%"></a><br><sub><b>IndexGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_ShopGui__Main.jpg"><img src="screenshots/thumbs/38_ShopGui__Main.jpg" width="100%"></a><br><sub><b>ShopGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_CodeGui__Main.jpg"><img src="screenshots/thumbs/40_CodeGui__Main.jpg" width="100%"></a><br><sub><b>CodeGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_MoneyGui.jpg"><img src="screenshots/thumbs/42_MoneyGui.jpg" width="100%"></a><br><sub><b>MoneyGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/43_SettingsGui__Main.jpg"><img src="screenshots/thumbs/43_SettingsGui__Main.jpg" width="100%"></a><br><sub><b>SettingsGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/45_PetInventoryGui__Main.jpg"><img src="screenshots/thumbs/45_PetInventoryGui__Main.jpg" width="100%"></a><br><sub><b>PetInventoryGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/46_left_bottom.jpg"><img src="screenshots/thumbs/46_left_bottom.jpg" width="100%"></a><br><sub><b>left bottom</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/47_IndexGui__Main.jpg"><img src="screenshots/thumbs/47_IndexGui__Main.jpg" width="100%"></a><br><sub><b>IndexGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/49_ShopGui__Main.jpg"><img src="screenshots/thumbs/49_ShopGui__Main.jpg" width="100%"></a><br><sub><b>ShopGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/51_CodeGui__Main.jpg"><img src="screenshots/thumbs/51_CodeGui__Main.jpg" width="100%"></a><br><sub><b>CodeGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_SettingsGui__Main.jpg"><img src="screenshots/thumbs/57_SettingsGui__Main.jpg" width="100%"></a><br><sub><b>SettingsGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_PetInventoryGui__Main.jpg"><img src="screenshots/thumbs/58_PetInventoryGui__Main.jpg" width="100%"></a><br><sub><b>PetInventoryGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/59_IndexGui__Main.jpg"><img src="screenshots/thumbs/59_IndexGui__Main.jpg" width="100%"></a><br><sub><b>IndexGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/60_left_bottom.jpg"><img src="screenshots/thumbs/60_left_bottom.jpg" width="100%"></a><br><sub><b>left bottom</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_CodeGui__Main.jpg"><img src="screenshots/thumbs/61_CodeGui__Main.jpg" width="100%"></a><br><sub><b>CodeGui</b> › Main</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_FigmaImport_Reference.jpg"><img src="screenshots/thumbs/16_FigmaImport_Reference.jpg" width="100%"></a><br><sub><b>FigmaImport_Reference</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_BurnGui.jpg"><img src="screenshots/thumbs/20_BurnGui.jpg" width="100%"></a><br><sub><b>BurnGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_GuideButton.jpg"><img src="screenshots/thumbs/25_GuideButton.jpg" width="100%"></a><br><sub><b>GuideButton</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_SlowModeButton_BeforeRestyle.jpg"><img src="screenshots/thumbs/41_SlowModeButton_BeforeRestyle.jpg" width="100%"></a><br><sub><b>SlowModeButton_BeforeRestyle</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_RowTemplate.jpg"><img src="screenshots/thumbs/53_RowTemplate.jpg" width="100%"></a><br><sub><b>RowTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/55_FastHatch.jpg"><img src="screenshots/thumbs/55_FastHatch.jpg" width="100%"></a><br><sub><b>FastHatch</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_RowTemplate.jpg"><img src="screenshots/thumbs/62_RowTemplate.jpg" width="100%"></a><br><sub><b>RowTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/65_RowTemplate.jpg"><img src="screenshots/thumbs/65_RowTemplate.jpg" width="100%"></a><br><sub><b>RowTemplate</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/EggSystem/Pets/RockCandyDragon.rbxm"><img src="screenshots/thumbs/models/01_RockCandyDragon.jpg" width="100%"></a><br><sub><b>RockCandyDragon</b><br><code>models/ReplicatedStorage/EggSystem/Pets/RockCandyDragon.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/EggModels_BeforeSlim/RockCandyDragonEgg.rbxm"><img src="screenshots/thumbs/models/02_RockCandyDragonEgg.jpg" width="100%"></a><br><sub><b>RockCandyDragonEgg</b><br><code>models/ServerStorage/EggModels_BeforeSlim/RockCandyDragonEgg.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/EggModels_BeforeSlim/BatEgg.rbxm"><img src="screenshots/thumbs/models/03_BatEgg.jpg" width="100%"></a><br><sub><b>BatEgg</b><br><code>models/ServerStorage/EggModels_BeforeSlim/BatEgg.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Aura%20Pack%20Premium%20By%20luismakako777/Aura_WhiteWings.rbxm"><img src="screenshots/thumbs/models/04_Aura_WhiteWings.jpg" width="100%"></a><br><sub><b>Aura_WhiteWings</b><br><code>models/Workspace/Aura Pack Premium By luismakako777/Aura_WhiteWings.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Trade%20Machine.rbxm"><img src="screenshots/thumbs/models/05_Trade_Machine.jpg" width="100%"></a><br><sub><b>Trade Machine</b><br><code>models/Workspace/Trade Machine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Aura%20Pack%20Premium%20By%20luismakako777/Aura_SusanooArms.rbxm"><img src="screenshots/thumbs/models/06_Aura_SusanooArms.jpg" width="100%"></a><br><sub><b>Aura_SusanooArms</b><br><code>models/Workspace/Aura Pack Premium By luismakako777/Aura_SusanooArms.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/SkyEvents/Models/CandyCloud.rbxm"><img src="screenshots/thumbs/models/07_CandyCloud.jpg" width="100%"></a><br><sub><b>CandyCloud</b><br><code>models/ReplicatedStorage/SkyEvents/Models/CandyCloud.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Removed_HalloweenTheme/HalloweenTheme/Shops/UPGRADE%20shop%20decor.rbxm"><img src="screenshots/thumbs/models/08_UPGRADE_shop_decor.jpg" width="100%"></a><br><sub><b>UPGRADE shop decor</b><br><code>models/ServerStorage/Removed_HalloweenTheme/HalloweenTheme/Shops/UPGRADE shop decor.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/ZoneDecor/Lava/Volcano__x15.rbxm"><img src="screenshots/thumbs/models/09_Volcano_x15.jpg" width="100%"></a><br><sub><b>Volcano__x15</b><br><code>models/Workspace/ZoneDecor/Lava/Volcano__x15.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/TreadmillModels/Diamond.rbxm"><img src="screenshots/thumbs/models/10_Diamond.jpg" width="100%"></a><br><sub><b>Diamond</b><br><code>models/ServerStorage/TreadmillModels/Diamond.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Dragons/Crystal%20Dragon.rbxm"><img src="screenshots/thumbs/models/11_Crystal_Dragon.jpg" width="100%"></a><br><sub><b>Crystal Dragon</b><br><code>models/ReplicatedStorage/Dragons/Crystal Dragon.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/FightFilm/AlienSets/ShipRoom.rbxm"><img src="screenshots/thumbs/models/12_ShipRoom.jpg" width="100%"></a><br><sub><b>ShipRoom</b><br><code>models/ReplicatedStorage/FightFilm/AlienSets/ShipRoom.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Angels_BeforeGear/AngelCerberus.rbxm"><img src="screenshots/thumbs/models/13_AngelCerberus.jpg" width="100%"></a><br><sub><b>AngelCerberus</b><br><code>models/ServerStorage/Angels_BeforeGear/AngelCerberus.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/MoneyLeaderboard.rbxm"><img src="screenshots/thumbs/models/14_MoneyLeaderboard.jpg" width="100%"></a><br><sub><b>MoneyLeaderboard</b><br><code>models/Workspace/MoneyLeaderboard.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`TradeClient`](source/scripts/StarterPlayer/StarterPlayerScripts/TradeClient.client.lua) <sub>595 lines</sub><br>[`CreatorPanelClient`](source/scripts/ServerStorage/Backup_BeforePhantomZone/CreatorPanelClient.client.lua) <sub>778 lines</sub><br>[`HammerClient`](source/scripts/ServerStorage/Scripts_BeforeAdminEggHit/HammerClient.client.lua) <sub>663 lines</sub><br>[`HammerClient`](source/scripts/ServerStorage/Scripts_BeforeArenaV2/HammerClient.client.lua) <sub>663 lines</sub><br>[`HammerClient`](source/scripts/ServerStorage/Scripts_BeforeBossSmash/HammerClient.client.lua) <sub>687 lines</sub> |
| UI controllers / window managers / menus | [`FuseClient`](source/scripts/ServerStorage/Scripts_BeforeAdminCleanup/FuseClient.client.lua) <sub>441 lines</sub><br>[`FuseClient`](source/scripts/ServerStorage/Scripts_BeforeTradeMachine/FuseClient.client.lua) <sub>458 lines</sub><br>[`TradeClient`](source/scripts/StarterPlayer/StarterPlayerScripts/TradeClient.client.lua) <sub>595 lines</sub><br>[`FuseClient`](source/scripts/StarterPlayer/StarterPlayerScripts/FuseClient.client.lua) <sub>421 lines</sub><br>[`AdminCutsceneEventsTab`](source/scripts/ServerStorage/Obsidian_Backup/AdminCutsceneEventsTab.client.lua) <sub>159 lines</sub> |
| Notifications, toasts, popups, prompts | [`GlobalAnnounceClient`](source/scripts/ServerStorage/Scripts_BeforeAdminCleanup/GlobalAnnounceClient.client.lua) <sub>316 lines</sub><br>[`GlobalAnnounceClient`](source/scripts/ServerStorage/Scripts_BeforeMeshAnimals/GlobalAnnounceClient.client.lua) <sub>294 lines</sub><br>[`GlobalAnnounceClient`](source/scripts/ServerStorage/Backup_BeforeGalaxyZone/Scripts/GlobalAnnounceClient.client.lua) <sub>235 lines</sub><br>[`GlobalAnnounceClient`](source/scripts/ServerStorage/Backup_BeforePhantomZone/GlobalAnnounceClient.client.lua) <sub>236 lines</sub><br>[`GlobalAnnounceClient`](source/scripts/ServerStorage/Scripts_BeforeMobileUi/GlobalAnnounceClient.client.lua) <sub>220 lines</sub> |
| Loading / intro screens | [`LoadingScreen_BeforeSmashCover`](source/scripts/ServerStorage/LoadingScreen_BeforeSmashCover.client.lua) <sub>106 lines</sub><br>[`LoadingScreen`](source/scripts/ServerStorage/Removed_LoadingScreen/LoadingScreen.client.lua) <sub>107 lines</sub><br>[`IntroClient_BeforeFire`](source/scripts/ServerStorage/IntroClient_BeforeFire.client.lua) <sub>457 lines</sub><br>[`IntroClient`](source/scripts/ServerStorage/Scripts_BeforeGalacticUpdate/IntroClient.client.lua) <sub>545 lines</sub><br>[`IntroClient`](source/scripts/ServerStorage/Scripts_BeforeGlobalBus/IntroClient.client.lua) <sub>545 lines</sub> |
| Camera, cutscenes, screen shake | [`ReaperCutsceneClient_Old`](source/scripts/ServerStorage/ReaperCutsceneClient_Old.client.lua) <sub>1314 lines</sub><br>[`HackerCutsceneClient`](source/scripts/ServerStorage/Scripts_BeforeHackerWave2/HackerCutsceneClient.client.lua) <sub>684 lines</sub><br>[`HackerCutsceneClient`](source/scripts/StarterPlayer/StarterPlayerScripts/HackerCutsceneClient.client.lua) <sub>727 lines</sub><br>[`SafeCutsceneClient`](source/scripts/StarterPlayer/StarterPlayerScripts/SafeCutsceneClient.client.lua) <sub>473 lines</sub><br>[`CutsceneClient`](source/scripts/StarterPlayer/StarterPlayerScripts/CutsceneClient.client.lua) <sub>2266 lines</sub> |
| VFX, particles, beams, hit effects | [`DiscoFxClient`](source/scripts/ServerStorage/Removed_Events_2026_10_24/DiscoFxClient.client.lua) <sub>297 lines</sub><br>[`Fx`](source/scripts/ReplicatedStorage/FightFilm/Fx.lua) <sub>255 lines</sub><br>[`HammerClient`](source/scripts/ServerStorage/Scripts_BeforeBossSmash/HammerClient.client.lua) <sub>687 lines</sub><br>[`HammerClient`](source/scripts/ServerStorage/Scripts_BeforeEggHitFix/HammerClient.client.lua) <sub>688 lines</sub><br>[`HammerClient`](source/scripts/ServerStorage/Scripts_BeforeEventsShowcase/HammerClient.client.lua) <sub>688 lines</sub> |
| DataStore / player data | [`PetServer`](source/scripts/ServerScriptService/PetServer.server.lua) <sub>1663 lines</sub><br>[`PetServer`](source/scripts/ServerStorage/Backup_BeforePhantomZone/PetServer.server.lua) <sub>1663 lines</sub><br>[`PetServer`](source/scripts/ServerStorage/Scripts_BeforeCreatorPanelV2/PetServer.server.lua) <sub>1619 lines</sub><br>[`PetServer`](source/scripts/ServerStorage/Scripts_BeforeGlobalBus/PetServer.server.lua) <sub>1617 lines</sub><br>[`PetServer_BeforeTreadmill11`](source/scripts/ServerStorage/Scripts_BeforeGlobalBus/PetServer_BeforeTreadmill11.server.lua) <sub>1617 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`FeaturedShopServer`](source/scripts/ServerScriptService/FeaturedShopServer.server.lua) <sub>115 lines</sub><br>[`FeaturedShopServer`](source/scripts/ServerStorage/Scripts_BeforeAdminRework/FeaturedShopServer.server.lua) <sub>113 lines</sub><br>[`PassShopHandler`](source/scripts/ServerStorage/Scripts_BeforeEventsShowcase/PassShopHandler.client.lua) <sub>649 lines</sub><br>[`PassShopHandler`](source/scripts/StarterGui/ShopGui/PassShopHandler.client.lua) <sub>652 lines</sub><br>[`PassShopHandler`](source/scripts/ServerStorage/Scripts_BeforeGifts/PassShopHandler.client.lua) <sub>455 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`EggZoneServer`](source/scripts/ServerScriptService/EggZoneServer.server.lua) <sub>1474 lines</sub><br>[`EggZoneServer`](source/scripts/ServerStorage/Backup_BeforeGalaxyZone/Scripts/EggZoneServer.server.lua) <sub>1382 lines</sub><br>[`EggZoneServer`](source/scripts/ServerStorage/Backup_BeforePhantomZone/EggZoneServer.server.lua) <sub>1470 lines</sub><br>[`EggZoneServer`](source/scripts/ServerStorage/Scripts_BeforeDiscoFx/EggZoneServer.server.lua) <sub>1428 lines</sub><br>[`EggZoneServer`](source/scripts/ServerStorage/Scripts_BeforeEggHitFix/EggZoneServer.server.lua) <sub>1399 lines</sub> |
| Trading systems | [`TradeServer`](source/scripts/ServerScriptService/TradeServer.server.lua) <sub>295 lines</sub><br>[`TradeClient`](source/scripts/ServerStorage/Removed_RebirthTradeGuide/TradeClient.client.lua) <sub>328 lines</sub><br>[`TradeServer`](source/scripts/ServerStorage/Removed_RebirthTradeGuide/TradeServer.server.lua) <sub>441 lines</sub><br>[`TradeClient`](source/scripts/ServerStorage/Scripts_BeforeTradeUI2/TradeClient.client.lua) <sub>371 lines</sub><br>[`TradeServer`](source/scripts/ServerStorage/Scripts_BeforeTradeUI2/TradeServer.server.lua) <sub>290 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`CreatorPanelServer`](source/scripts/ServerScriptService/CreatorPanelServer.server.lua) <sub>729 lines</sub><br>[`CreatorPanelServer`](source/scripts/ServerStorage/Scripts_BeforeAntiCheatV2/CreatorPanelServer.server.lua) <sub>725 lines</sub><br>[`CreatorPanelServer`](source/scripts/ServerStorage/Scripts_BeforeCreatorPanelV2/CreatorPanelServer.server.lua) <sub>581 lines</sub><br>[`CreatorPanelServer`](source/scripts/ServerStorage/Scripts_BeforeTradeMachine/CreatorPanelServer.server.lua) <sub>724 lines</sub><br>[`CyberZoneServer`](source/scripts/ServerScriptService/CyberZoneServer.server.lua) <sub>442 lines</sub> |
| NPC / AI / monsters | [`ZoneBossServer`](source/scripts/ServerScriptService/ZoneBossServer.server.lua) <sub>523 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerStorage/Backup_BeforeGalaxyZone/Scripts/ZoneBossServer.server.lua) <sub>455 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerStorage/Backup_BeforePhantomZone/ZoneBossServer.server.lua) <sub>519 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerStorage/Scripts_BeforeBossDrop/ZoneBossServer.server.lua) <sub>457 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerStorage/Scripts_BeforeBossFaster/ZoneBossServer.server.lua) <sub>457 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`NoSlideClient`](source/scripts/ServerStorage/Scripts_BeforeSpeedPass/NoSlideClient.client.lua) <sub>66 lines</sub><br>[`NoSlideClient`](source/scripts/StarterPlayer/StarterPlayerScripts/NoSlideClient.client.lua) <sub>100 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerStorage/Scripts_BeforeBossSmooth/ZoneBossServer.server.lua) <sub>420 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerScriptService/ZoneBossServer.server.lua) <sub>523 lines</sub><br>[`ZoneBossServer`](source/scripts/ServerStorage/Backup_BeforeGalaxyZone/Scripts/ZoneBossServer.server.lua) <sub>455 lines</sub> |
| Tycoon / plots / bases / building | [`AdminPanelClient`](source/scripts/ServerStorage/Backup_BeforeGalaxyZone/Scripts/AdminPanelClient.client.lua) <sub>891 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Scripts_BeforeGalacticUpdate/AdminPanelClient.client.lua) <sub>897 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Scripts_BeforeKgCapNight/AdminPanelClient.client.lua) <sub>900 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Scripts_BeforeNoSteal/AdminPanelClient.client.lua) <sub>894 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Scripts_BeforeSkipFuseEgg/AdminPanelClient.client.lua) <sub>891 lines</sub> |
| Leaderboards & stats | [`LeaderboardServer`](source/scripts/ServerScriptService/LeaderboardServer.server.lua) <sub>88 lines</sub><br>[`SpeedLeaderboardServer`](source/scripts/ServerScriptService/SpeedLeaderboardServer.server.lua) <sub>68 lines</sub><br>[`LeaderboardServer`](source/scripts/ServerStorage/Scripts_BeforeCreatorPanelV2/LeaderboardServer.server.lua) <sub>88 lines</sub><br>[`SpeedLeaderboardServer`](source/scripts/ServerStorage/Scripts_BeforeCreatorPanelV2/SpeedLeaderboardServer.server.lua) <sub>68 lines</sub><br>[`LeaderboardServer`](source/scripts/ServerStorage/Scripts_BeforeDataReset/LeaderboardServer.server.lua) <sub>85 lines</sub> |
| Admin panels & commands | [`AdminServer`](source/scripts/ServerScriptService/AdminServer.server.lua) <sub>507 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Backup_BeforeGalaxyZone/Scripts/AdminPanelClient.client.lua) <sub>891 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Backup_BeforePhantom/AdminPanelClient.client.lua) <sub>1037 lines</sub><br>[`AdminPanelClient`](source/scripts/ServerStorage/Backup_BeforePhantomZone/AdminPanelClient.client.lua) <sub>1001 lines</sub><br>[`AdminServer`](source/scripts/ServerStorage/Backup_BeforePhantomZone/AdminServer.server.lua) <sub>453 lines</sub> |
| Sound & music | [`BackgroundMusicClient`](source/scripts/ServerStorage/Scripts_BeforeHammerOwnership/BackgroundMusicClient.client.lua) <sub>37 lines</sub><br>[`BackgroundMusicClient`](source/scripts/StarterPlayer/StarterPlayerScripts/BackgroundMusicClient.client.lua) <sub>42 lines</sub><br>[`SettingsHandler`](source/scripts/ServerStorage/Gui_Before3D/SettingsGui/SettingsHandler.client.lua) <sub>129 lines</sub><br>[`SettingsHandler`](source/scripts/ServerStorage/Scripts_BeforeGuiScale/SettingsHandler.client.lua) <sub>132 lines</sub><br>[`SettingsHandler`](source/scripts/StarterGui/SettingsGui/SettingsHandler.client.lua) <sub>131 lines</sub> |
| Daily rewards, quests, codes, playtime | [`CodeHandler`](source/scripts/ServerStorage/Gui_Before3Dv2/CodeGui/CodeHandler.client.lua) <sub>135 lines</sub><br>[`PetServer`](source/scripts/ServerScriptService/PetServer.server.lua) <sub>1663 lines</sub><br>[`PetServer`](source/scripts/ServerStorage/Backup_BeforePhantomZone/PetServer.server.lua) <sub>1663 lines</sub><br>[`PetServer`](source/scripts/ServerStorage/Scripts_BeforeCreatorPanelV2/PetServer.server.lua) <sub>1619 lines</sub><br>[`PetServer`](source/scripts/ServerStorage/Scripts_BeforeDataReset/PetServer.server.lua) <sub>1476 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Emit`](source/scripts/ReplicatedStorage/VFX/Emit.lua) <sub>934 lines</sub><br>[`EggConfig`](source/scripts/ServerStorage/Backup_BeforePhantom/EggConfig.lua) <sub>878 lines</sub><br>[`EggConfig_BeforeExclusiveX1000`](source/scripts/ServerStorage/EggConfig_BeforeExclusiveX1000.lua) <sub>802 lines</sub><br>[`EggConfig_BeforeMeshAnimals`](source/scripts/ServerStorage/EggConfig_BeforeMeshAnimals.lua) <sub>393 lines</sub><br>[`EggConfig_BeforeZoneSpeed100B`](source/scripts/ServerStorage/EggConfig_BeforeZoneSpeed100B.lua) <sub>560 lines</sub> |

### In the curated script library

- [CutsceneLock](../../Scripts/05-Camera-Cutscene/CutsceneLock__smash-egg-for-animals.lua) — One-cutscene-at-a-time lock + StreamingEnabled support (load what the camera sees).
- [Poster loading screen with camera dive](../../Scripts/04-Loading-Screens/PosterLoadingScreen__smash-egg-for-animals.lua) — Code-built ReplicatedFirst loading screen: game poster in a frame, timed progress bar with %, rotating tips, scrolling stud background, then a white flash while the camera dives from the sky to the player.
- [First-join cinematic with Skip](../../Scripts/04-Loading-Screens/ArrivalCinematicWithSkip__smash-egg-for-animals.lua) — First-time-player arrival cinematic: letterbox bars, titles, fades, a boss leaping through a forest, zone fly-over; square SKIP button; hold() helper that aborts every step once skipped; sets IntroState attribute so the tutorial waits.
- [Ground grip & air control](../../Scripts/13-Movement/GroundGripAirControl__smash-egg-for-animals.lua) — Tight ground control + momentum-preserving air control by writing AssemblyLinearVelocity.
- [Global announcements + rarity spawn banners](../../Scripts/03-Notifications/GlobalAnnounceClient__smash-egg-for-animals.lua) — Builds its own UI in code: admin announcements (avatar headshot + name + text) stacked at top of screen, rarity-gradient "egg spawned" announcements with a sliding gradient, plus a small redeem-code window.
- [Zone enter banner](../../Scripts/03-Notifications/ZoneEnterBanner__smash-egg-for-animals.lua) — Area title banner: when the player enters a tagged zone part, a CanvasGroup banner (zone name, gradient, recommended speed) slides in for 3s then fades.
- [Full-screen danger alert](../../Scripts/03-Notifications/DangerAlert__smash-egg-for-animals.lua) — Full-screen "RUN!" warning driven by a player attribute: red flash, pulsing gradient screen edges, heartbeat-scaled text; fades out when the attribute clears.
- [Zone guardian boss (steal-and-run chaser)](../../Scripts/12-NPC-AI/ZoneGuardianBoss__smash-egg-for-animals.lua) — Giant guardian per egg zone: wanders its zone, chases any player carrying an egg from it with a wind-up, target-leading (aims where the player will be), speed matched to the zone's recommended speed, safe-zone wall, leash/give-up rules, knock-back on hit and fast return home. Physics driven by LinearVelocity + AlignOrientation. Comments are in French.
- [Two-phase arena boss with minions](../../Scripts/12-NPC-AI/BossArenaPhases__smash-egg-for-animals.lua) — Server-authoritative boss fight: HP pool, timed ground-slam shockwave you must jump, teleports, and below 50% HP a phase 2 that spawns exploding dog minions that chase the nearest player on a fuse timer. Visuals are driven by attributes / a client FX remote. Comments are in French.
- [Idle NPC that looks at and waves to you](../../Scripts/12-NPC-AI/LookAtPlayerIdleNPC__smash-egg-for-animals.lua) — Client script for NPCs tagged 'LookAtNpc': breathing idle via Motor6D C0 offsets, head + waist turn toward the local player (clamped yaw/pitch, smoothed), one wave when you come close, re-greets after you leave. Comments are in French.
- [Egg spawn / size / pet rolls with luck event](../../Scripts/09-RNG-Gacha-Pets/EggZoneRolls__smash-egg-for-animals.lua) — Three roll helpers: luck() reads a server attribute, rollHeight() picks a size tier, pickKey() boosts every egg except the most common one during a luck event, and hatch() picks the pet and stacks event mutations.
- [Placed egg incubation + hatch](../../Scripts/09-RNG-Gacha-Pets/EggIncubateHatch__smash-egg-for-animals.lua) — Eggs placed in the player's base incubate until ReadyAt, can randomly grow heavier while waiting, then hatch on the server (inventory cap check, roll by % table, egg weight carried into the pet).
- [Cross-server luck event](../../Scripts/09-RNG-Gacha-Pets/GlobalLuckEvent__smash-egg-for-animals.lua) — Admin-started x4 luck event shared by all servers: end time saved in a DataStore (new servers pick it up), broadcast with MessagingService, per-server option, and a resync loop.
- [Minimal seasonal playlist](../../Scripts/17-Sound-Music/BackgroundPlaylist__smash-egg-for-animals.lua) — Minimal background playlist: one Sound in SoundService cycles through a list of IDs on Ended; picks a seasonal (Halloween) playlist from a Lighting attribute. Comments are in French.
- [Button hover/click sounds and bounce](../../Scripts/17-Sound-Music/UIButtonSoundsAndBounce__smash-egg-for-animals.lua) — Auto-adds hover/press scale bounce plus hover and click sounds to every GuiButton, with random pitch and SoundService:PlayLocalSound; also plays a window-opened sound when a large Main/Window/Panel frame becomes visible. Falls back to built-in sounds if an asset fails to load. Comments are in French.
- [3D boss roars with rolloff](../../Scripts/17-Sound-Music/BossRoar3D__smash-egg-for-animals.lua) — 3D positional roars for tagged bosses while they chase: per-boss sound config (id, volume, pitch), linear rolloff from 40 to 190 studs, random offsets so bosses do not roar in sync, fade-out before destroy, muted in safe zone and arenas. Comments are in French.
- [Music/SFX sliders with SoundGroup routing](../../Scripts/17-Sound-Music/VolumeSettingsSoundGroups__smash-egg-for-animals.lua) — Settings panel with Music and SFX volume sliders. Creates Music and SFX SoundGroups and auto-routes every Sound in the game into one of them (long looped sounds count as music), drag-to-set sliders in 5 percent steps for mouse and touch, saves on release, loads saved values from player attributes. Comments are in French.
- [Volume settings DataStore save](../../Scripts/17-Sound-Music/VolumeSettingsSave__smash-egg-for-animals.lua) — Server half of the volume settings: loads Music/SFX volume from its own DataStore into player attributes, validates values sent by the client remote, and writes once on leave or BindToClose. Comments are in French.
- [Trade machine server](../../Scripts/10-Trading/TradeMachineServer__smash-egg-for-animals.lua) — Same-server pet trade with READY->wait->CONFIRM, edit cooldowns, request expiry and action rate limit.
- [Trade bridge atomic swap](../../Scripts/10-Trading/TradeBridgeAtomicSwap__smash-egg-for-animals.lua) — Excerpt: data-owner BindableFunction that lists tradable pets and executes an all-or-nothing swap.
- [Code-built trade UI](../../Scripts/10-Trading/TradeMachineClient__smash-egg-for-animals.lua) — Complete trade window built in code: lobby, request cards with timers, offer grids, ready/confirm countdown.
- [Cross-server escrow trade](../../Scripts/10-Trading/CrossServerEscrowTrade__smash-egg-for-animals.lua) — Cross-server trade that escrows pets per server then delivers through a DataStore inbox with offer signatures.
- [Compact button FX with sounds](../../Scripts/01-UI-Animation/ButtonFX_UIScaleSounds__smash-egg-for-animals.lua) — Compact global button FX: UIScale grow on hover, squash on press, Back-eased return, pitch-randomised sounds, mobile tap fallback, and a sound when big windows open. Comments in French.
- [Auto pop-in for windows](../../Scripts/01-UI-Animation/WindowOpenFx_AutoPopIn__smash-egg-for-animals.lua) — Automatically pops every big window in from 80% scale (0.18 s Back out) when it becomes Visible, preserving any existing UIScale value. Comments in French.
- [Money count-up + gain popup](../../Scripts/01-UI-Animation/MoneyCounter_CountUpGainPopup__smash-egg-for-animals.lua) — Money counter with cubic ease-out count-up on RenderStepped, a "+$N" label that bursts out then rises and fades, batching of simultaneous gains, and a pop on spend. Comments in French.
- [Slowing roll + reveal](../../Scripts/01-UI-Animation/HatchReel_SlowingRoll__smash-egg-for-animals.lua) — Egg hatch reel that cycles silhouettes fast then slows (quadratic slot lengths), never repeats the result just before landing, then reveals with name tag pop, rays spin and highlight fade. Comments in French.
- [Zone entry banner](../../Scripts/01-UI-Animation/ZoneBanner_CanvasGroupFade__smash-egg-for-animals.lua) — Area-entry banner built in code: CanvasGroup fades in (GroupTransparency) while sliding down with Back-out, gradient title, auto-hides after 3 s. Comments in French.
- [Screen-edge danger pulse](../../Scripts/01-UI-Animation/RunAlert_ScreenEdgePulse__smash-egg-for-animals.lua) — Danger alert: big "RUN!" text slams in from 2.4x scale, full-screen red flash, four gradient screen edges and the text heartbeat-pulse via sin() on RenderStepped. Comments in French.
- [Gradient polish + sun rays](../../Scripts/01-UI-Animation/GradientPolish_SunRays__smash-egg-for-animals.lua) — Upgrades every 2-colour UIGradient into a 4-stop "glossy" gradient and spins sun-ray images behind chosen icons. Needs the game PetPortrait.rays helper. Comments in French.
- [Global window pop-in effect](../../Scripts/02-UI-Framework/WindowOpenFx__smash-egg-for-animals.lua) — Watches every Main/Window/Panel frame and pops it in from 80% scale when shown.
- [Fx controller (burst / attach / aura / mesh / projectile / light)](../../Scripts/06-VFX/FxController__smash-egg-for-animals.lua) — Most complete VFX controller: burst, attach-to-part, full-body aura, growing mesh shockwave, projectile, light flash.
- [Black hole portal](../../Scripts/06-VFX/BlackHolePortal__smash-egg-for-animals.lua) — Procedural layered portal (open / close / flare / suck) animated every frame.
- [Boss aura with distance culling](../../Scripts/06-VFX/BossAuraCulling__smash-egg-for-animals.lua) — Client aura manager: idle/run emitter rates, pulsing glow, flickering arcs, distance culling at 8 Hz.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerStorage/Angels_BeforeTextures/AnimalWiring_BeforeTextures.lua`
- `scripts/ServerStorage/Gui3DBuilderV2.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
