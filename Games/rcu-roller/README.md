# RCU (roll / mounts)

> 🎲 **RNG** · RNG roller (Knit, auto roll, mounts) · source file `RCU.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/08_MainUI__YouDontHaveAny.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 2 ScreenGuis, 5063 GUI objects → **41 screenshots** |
| Models (.rbxm) | 601 models, 58 model sets, 5 VFX sets |
| Lua builders (.lua) | 82 UI screens, 1 animation packs, 1 audio packs |
| Code | 513 scripts, 95,662 lines |
| Asset ids | 6 animations, 49 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×1235, `SourceSansPro Regular`×434, `font asset 12187373592 Bold`×21, `font asset 12187370000 Bold`×6, `Builder Sans Bold`×1

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_MainUI__AncientShopFrame.jpg"><img src="screenshots/thumbs/22_MainUI__AncientShopFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.AncientShopFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_BoothOffer.jpg"><img src="screenshots/thumbs/33_BoothOffer.jpg" width="100%"></a><br><sub><b>BoothOffer</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MainUI__HoverPets.jpg"><img src="screenshots/thumbs/02_MainUI__HoverPets.jpg" width="100%"></a><br><sub><b>MainUI</b> › HUD.Hovers.HoverPets</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_MainUI__YouDontHaveAny.jpg"><img src="screenshots/thumbs/08_MainUI__YouDontHaveAny.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.InventoryFrame.YouDontHaveAny</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_MainUI__ItemConfirmFrame.jpg"><img src="screenshots/thumbs/09_MainUI__ItemConfirmFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.ItemConfirmFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_Pet.jpg"><img src="screenshots/thumbs/25_Pet.jpg" width="100%"></a><br><sub><b>Pet</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_Item.jpg"><img src="screenshots/thumbs/39_Item.jpg" width="100%"></a><br><sub><b>Item</b></sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_MainUI__IndexFrame.jpg"><img src="screenshots/thumbs/17_MainUI__IndexFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.IndexFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_IndexReward.jpg"><img src="screenshots/thumbs/30_IndexReward.jpg" width="100%"></a><br><sub><b>IndexReward</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_MainUI__AncientSpinWheelFrame.jpg"><img src="screenshots/thumbs/23_MainUI__AncientSpinWheelFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.AncientSpinWheelFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_DailyReward.jpg"><img src="screenshots/thumbs/37_DailyReward.jpg" width="100%"></a><br><sub><b>DailyReward</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_MainUI__HoverPrestigeInfo.jpg"><img src="screenshots/thumbs/05_MainUI__HoverPrestigeInfo.jpg" width="100%"></a><br><sub><b>MainUI</b> › HUD.Hovers.HoverPrestigeInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_MainUI__RebirthFrame.jpg"><img src="screenshots/thumbs/13_MainUI__RebirthFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.RebirthFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_MainUI__TradeRequestFrame.jpg"><img src="screenshots/thumbs/15_MainUI__TradeRequestFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.TradeRequestFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_MainUI__UpgradesFrame.jpg"><img src="screenshots/thumbs/19_MainUI__UpgradesFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.UpgradesFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_FarmUpgrade.jpg"><img src="screenshots/thumbs/35_FarmUpgrade.jpg" width="100%"></a><br><sub><b>FarmUpgrade</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/38_Achievement.jpg"><img src="screenshots/thumbs/38_Achievement.jpg" width="100%"></a><br><sub><b>Achievement</b></sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_MainUI__HoverTradeList.jpg"><img src="screenshots/thumbs/04_MainUI__HoverTradeList.jpg" width="100%"></a><br><sub><b>MainUI</b> › HUD.Hovers.HoverTradeList</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_MainUI__HoverTradeList.jpg"><img src="screenshots/thumbs/06_MainUI__HoverTradeList.jpg" width="100%"></a><br><sub><b>MainUI</b> › HUD.Hovers.HoverTradeList</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_MainUI__TradeListFrame.jpg"><img src="screenshots/thumbs/14_MainUI__TradeListFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.TradeListFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_MainUI__TradeFrame.jpg"><img src="screenshots/thumbs/16_MainUI__TradeFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.TradeFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/29_TradeListPlayer.jpg"><img src="screenshots/thumbs/29_TradeListPlayer.jpg" width="100%"></a><br><sub><b>TradeListPlayer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/40_TradingPlazaServer.jpg"><img src="screenshots/thumbs/40_TradingPlazaServer.jpg" width="100%"></a><br><sub><b>TradingPlazaServer</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_MainUI__EggDisplayFrame.jpg"><img src="screenshots/thumbs/10_MainUI__EggDisplayFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.EggDisplayFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_MainUI__TeleportFrame.jpg"><img src="screenshots/thumbs/18_MainUI__TeleportFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.TeleportFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_Title.jpg"><img src="screenshots/thumbs/34_Title.jpg" width="100%"></a><br><sub><b>Title</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_MainUI__ExclusiveEggConfirmFrame.jpg"><img src="screenshots/thumbs/11_MainUI__ExclusiveEggConfirmFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.ExclusiveEggConfirmFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_MainUI__MessagePopupFrame.jpg"><img src="screenshots/thumbs/12_MainUI__MessagePopupFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.MessagePopupFrame</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_ClanTop.jpg"><img src="screenshots/thumbs/28_ClanTop.jpg" width="100%"></a><br><sub><b>ClanTop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_Leaderboard.jpg"><img src="screenshots/thumbs/41_Leaderboard.jpg" width="100%"></a><br><sub><b>Leaderboard</b></sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_MainUI__GoldenMachineFrame.jpg"><img src="screenshots/thumbs/20_MainUI__GoldenMachineFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.GoldenMachineFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_MainUI__FarmingMachineFrame.jpg"><img src="screenshots/thumbs/21_MainUI__FarmingMachineFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.FarmingMachineFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_MainUI__AurasMachineFrame.jpg"><img src="screenshots/thumbs/24_MainUI__AurasMachineFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.AurasMachineFrame</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainUI.jpg"><img src="screenshots/thumbs/01_MainUI.jpg" width="100%"></a><br><sub><b>MainUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_MainUI__HoverExclusive.jpg"><img src="screenshots/thumbs/03_MainUI__HoverExclusive.jpg" width="100%"></a><br><sub><b>MainUI</b> › HUD.Hovers.HoverExclusive</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_MainUI__Bottom.jpg"><img src="screenshots/thumbs/07_MainUI__Bottom.jpg" width="100%"></a><br><sub><b>MainUI</b> › Menus.InventoryFrame.Bottom</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_ClanInvite.jpg"><img src="screenshots/thumbs/26_ClanInvite.jpg" width="100%"></a><br><sub><b>ClanInvite</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_Player.jpg"><img src="screenshots/thumbs/27_Player.jpg" width="100%"></a><br><sub><b>Player</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/31_Teleport.jpg"><img src="screenshots/thumbs/31_Teleport.jpg" width="100%"></a><br><sub><b>Teleport</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_Hatch.jpg"><img src="screenshots/thumbs/32_Hatch.jpg" width="100%"></a><br><sub><b>Hatch</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_SupporterPack.jpg"><img src="screenshots/thumbs/36_SupporterPack.jpg" width="100%"></a><br><sub><b>SupporterPack</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Desert/Models/_.rbxm"><img src="screenshots/thumbs/models/01__.jpg" width="100%"></a><br><sub><b>_</b><br><code>models/Workspace/Game/Maps/Desert/Models/_.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Spawn/MiniChests/MiniChest__x10.rbxm"><img src="screenshots/thumbs/models/02_MiniChest_x10.jpg" width="100%"></a><br><sub><b>MiniChest__x10</b><br><code>models/Workspace/Game/Maps/Spawn/MiniChests/MiniChest__x10.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Kingdom/ClanCastle/MainUpgrades/Candle%20Stands.rbxm"><img src="screenshots/thumbs/models/03_Candle_Stands.jpg" width="100%"></a><br><sub><b>Candle Stands</b><br><code>models/Workspace/Game/Maps/Kingdom/ClanCastle/MainUpgrades/Candle Stands.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Axes/RubyAxe.rbxm"><img src="screenshots/thumbs/models/04_RubyAxe.jpg" width="100%"></a><br><sub><b>RubyAxe</b><br><code>models/ReplicatedStorage/Assets/Axes/RubyAxe.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Pets/Cthulhu.rbxm"><img src="screenshots/thumbs/models/05_Cthulhu.jpg" width="100%"></a><br><sub><b>Cthulhu</b><br><code>models/ReplicatedStorage/Assets/Pets/Cthulhu.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Spawn/Leaderboards/EggsOpened.rbxm"><img src="screenshots/thumbs/models/06_EggsOpened.jpg" width="100%"></a><br><sub><b>EggsOpened</b><br><code>models/Workspace/Game/Maps/Spawn/Leaderboards/EggsOpened.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Farm/Machines/GoldenMachine.rbxm"><img src="screenshots/thumbs/models/07_GoldenMachine.jpg" width="100%"></a><br><sub><b>GoldenMachine</b><br><code>models/Workspace/Game/Maps/Farm/Machines/GoldenMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Booths/MagmaBooth.rbxm"><img src="screenshots/thumbs/models/08_MagmaBooth.jpg" width="100%"></a><br><sub><b>MagmaBooth</b><br><code>models/ReplicatedStorage/Assets/Booths/MagmaBooth.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Other/Hammer.rbxm"><img src="screenshots/thumbs/models/09_Hammer.jpg" width="100%"></a><br><sub><b>Hammer</b><br><code>models/ReplicatedStorage/Assets/Other/Hammer.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Spawn/Leaderboards/Rewards.rbxm"><img src="screenshots/thumbs/models/10_Rewards.jpg" width="100%"></a><br><sub><b>Rewards</b><br><code>models/Workspace/Game/Maps/Spawn/Leaderboards/Rewards.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Farm/Models/Meshes_stuff_Plane.rbxm"><img src="screenshots/thumbs/models/11_Meshes_stuff_Plane.jpg" width="100%"></a><br><sub><b>Meshes_stuff_Plane</b><br><code>models/Workspace/Game/Maps/Farm/Models/Meshes_stuff_Plane.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Desert/Trees/Tree13/Model.rbxm"><img src="screenshots/thumbs/models/12_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Game/Maps/Desert/Trees/Tree13/Model.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Other/Key.rbxm"><img src="screenshots/thumbs/models/13_Key.jpg" width="100%"></a><br><sub><b>Key</b><br><code>models/ReplicatedStorage/Assets/Other/Key.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Maps/Spawn/Machines/TradingPlaza/InfoTP.rbxm"><img src="screenshots/thumbs/models/14_InfoTP.jpg" width="100%"></a><br><sub><b>InfoTP</b><br><code>models/Workspace/Game/Maps/Spawn/Machines/TradingPlaza/InfoTP.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`UIController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/UIController.lua) <sub>937 lines</sub><br>[`HatchingController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/HatchingController.lua) <sub>642 lines</sub><br>[`Pet`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/UIController/UIs/Pet.lua) <sub>354 lines</sub><br>[`ShopFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/ShopFrame.lua) <sub>1302 lines</sub><br>[`ExclusiveEggController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/ExclusiveEggController.lua) <sub>530 lines</sub> |
| UI controllers / window managers / menus | [`UIController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/UIController.lua) <sub>937 lines</sub><br>[`Menu`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/widgets/Menu.lua) <sub>677 lines</sub><br>[`demoWindow`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/demoWindow.lua) <sub>1456 lines</sub><br>[`Window`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/widgets/Window.lua) <sub>915 lines</sub><br>[`UpgradesFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/UpgradesFrame.lua) <sub>146 lines</sub> |
| Notifications, toasts, popups, prompts | [`MessagePopupFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/MessagePopupFrame.lua) <sub>137 lines</sub><br>[`TradingPlazaController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/TradingPlazaController.lua) <sub>414 lines</sub><br>[`LightSwitch`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/World/LightSwitch.lua) <sub>171 lines</sub><br>[`EggController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/EggController.lua) <sub>744 lines</sub><br>[`RebirthFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/RebirthFrame.lua) <sub>422 lines</sub> |
| Camera, cutscenes, screen shake | [`Secret`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/HatchingController/Animations/Secret.lua) <sub>395 lines</sub><br>[`AuraController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/AuraController.lua) <sub>642 lines</sub><br>[`Eternal`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/HatchingController/Animations/Eternal.lua) <sub>162 lines</sub><br>[`ExclusiveEggController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/ExclusiveEggController.lua) <sub>530 lines</sub><br>[`MapController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/MapController.lua) <sub>194 lines</sub> |
| VFX, particles, beams, hit effects | [`AuraController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/AuraController.lua) <sub>642 lines</sub><br>[`Mythical`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/HatchingController/Animations/Mythical.lua) <sub>148 lines</sub><br>[`MiniChest`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/World/MiniChest.lua) <sub>193 lines</sub><br>[`PlayerController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/PlayerController.lua) <sub>188 lines</sub> |
| DataStore / player data | [`DataService`](source/scripts/ServerScriptService/Services/DataService.lua) <sub>507 lines</sub><br>[`ClanService`](source/scripts/ServerScriptService/Services/ClanService.lua) <sub>921 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ShopService`](source/scripts/ServerScriptService/Services/ShopService.lua) <sub>378 lines</sub><br>[`ShopFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/ShopFrame.lua) <sub>1302 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`EggService`](source/scripts/ServerScriptService/Services/EggService.lua) <sub>407 lines</sub><br>[`InventoryService`](source/scripts/ServerScriptService/Services/InventoryService.lua) <sub>361 lines</sub><br>[`EggController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/EggController.lua) <sub>744 lines</sub><br>[`RewardService`](source/scripts/ServerScriptService/Services/RewardService.lua) <sub>337 lines</sub><br>[`PetUtils`](source/scripts/ReplicatedStorage/Shared/Util/PetUtils.lua) <sub>133 lines</sub> |
| Trading systems | [`TradeService`](source/scripts/ServerScriptService/Services/TradeService.lua) <sub>518 lines</sub><br>[`TradingPlazaController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/TradingPlazaController.lua) <sub>414 lines</sub><br>[`TradeRequestFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/TradeRequestFrame.lua) <sub>134 lines</sub><br>[`TradeFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/TradeFrame.lua) <sub>950 lines</sub><br>[`TradeListFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/TradeListFrame.lua) <sub>235 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`demoWindow`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/demoWindow.lua) <sub>1456 lines</sub><br>[`Input`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/widgets/Input.lua) <sub>1741 lines</sub><br>[`IconOld`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/IconOld.lua) <sub>4686 lines</sub> |
| Tycoon / plots / bases / building | [`DataService`](source/scripts/ServerScriptService/Services/DataService.lua) <sub>507 lines</sub><br>[`BuildConfirmFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/BuildConfirmFrame.lua) <sub>314 lines</sub><br>[`PetController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/PetController.lua) <sub>492 lines</sub><br>[`config`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/config.lua) <sub>223 lines</sub><br>[`demoWindow`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Iris/demoWindow.lua) <sub>1456 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/Services/LeaderboardService.lua) <sub>125 lines</sub> |
| Sound & music | [`SoundController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/SoundController.lua) <sub>284 lines</sub><br>[`IconOld`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/IconOld.lua) <sub>4686 lines</sub> |
| Daily rewards, quests, codes, playtime | [`RewardService`](source/scripts/ServerScriptService/Services/RewardService.lua) <sub>337 lines</sub><br>[`RewardsFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/RewardsFrame.lua) <sub>515 lines</sub><br>[`DataService`](source/scripts/ServerScriptService/Services/DataService.lua) <sub>507 lines</sub><br>[`CodesService`](source/scripts/ServerScriptService/Services/CodesService.lua) <sub>52 lines</sub><br>[`FarmService`](source/scripts/ServerScriptService/Services/FarmService.lua) <sub>239 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`PetUtils`](source/scripts/ReplicatedStorage/Shared/Util/PetUtils.lua) <sub>133 lines</sub><br>[`MapWall`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/World/MapWall.lua) <sub>194 lines</sub><br>[`RebirthFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Components/UI/Frames/RebirthFrame.lua) <sub>422 lines</sub><br>[`EggController`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Controllers/EggController.lua) <sub>744 lines</sub><br>[`FormatTime`](source/scripts/ReplicatedStorage/Shared/Functions/FormatTime.lua) <sub>20 lines</sub> |

### In the curated script library

- [Chests, playtime and achievement claims](../../Scripts/18-Daily-Rewards-Quests/RewardService-ChestsPlaytimeAchievements__rcu-roller.lua) — Timed chests with cooldowns and weighted loot, one-time mini chests, playtime milestones checked against session time, tiered achievements (category+tier keys), ticket shop and a weighted wheel.
- [Knit DataService with big template](../../Scripts/07-Data-Saving/DataService-Knit-Replica__rcu-roller.lua) — Knit service with a very large commented default template, deep reconcile, path-based Set/Increment through a Replica, 5-minute autosave, and a 1-second boost countdown.
- [Config-driven Knit board service](../../Scripts/15-Leaderboards/LeaderboardService-Knit__rcu-roller.lua) — Knit service that, for each board in a shared config, uploads online players, reads the top 100, attaches cached user infos (display name, verified badge) and fires one signal to clients.
- [Server egg hatching (Knit)](../../Scripts/09-RNG-Gacha-Pets/EggHatchService__rcu-roller.lua) — Full server-authoritative egg opening: rate limit, amount clamp, currency check, luck via weight^(1/luck), Golden/Toxic tier roll, stacking duplicates, index tracking, quest hooks, global luck events.
- [Pet equip / lock / delete service](../../Scripts/09-RNG-Gacha-Pets/PetEquipService__rcu-roller.lua) — Server pet inventory actions: equip with slot cap from upgrades + gamepasses, unequip, delete (blocked if locked), lock toggle, nickname length cap.
- [Pet formation offsets (rows / arcs)](../../Scripts/09-RNG-Gacha-Pets/PetRowFormation__rcu-roller.lua) — Pure function that lays equipped pets out in up to 3 arcs behind the player (small pets front, big pets middle, huge pets back) and returns a CFrame offset per pet.
- [Luck multiplier stacking](../../Scripts/09-RNG-Gacha-Pets/LuckStack__rcu-roller.lua) — One function that adds every luck source together: server flag, global event, upgrades, gamepasses, potions, fruits, events and the equipped aura. Same code runs on client (for display) and server (for the roll).
- [Luck that moves % from common to rare](../../Scripts/09-RNG-Gacha-Pets/LuckChanceShift__rcu-roller.lua) — getNewChances: multiplies the chance of 'luck-affected' pets and subtracts the same total from the common pets so the egg still sums to 100%. Also pet descriptor / rarity helpers.
- [Aura dice roll + aura levels](../../Scripts/09-RNG-Gacha-Pets/AuraRoll__rcu-roller.lua) — Bundle of AuraService (consume a dice item, roll an aura on the server) and AuraUtils (luck redistribution with clamping, aura XP level/progress).
- [Knit trade service](../../Scripts/10-Trading/KnitTradeService__rcu-roller.lua) — Knit trade of stackable items plus currency tokens with separate ready and confirm stages.
- [Trading plaza booths](../../Scripts/10-Trading/TradingPlazaBooths__rcu-roller.lua) — Booth marketplace with escrowed listings and token purchases (has known bugs, see README).
- [Truncating suffix formatter](../../Scripts/19-Utility/Suffixes-Truncating__rcu-roller.lua) — One-function abbreviator that FLOORS to N decimals instead of rounding, so 1999 shows 1.99K and never more money than the player has.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
