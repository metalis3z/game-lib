# Street Life

> 🏙️ **Roleplay** · open-world roleplay / hood · source file `Street Life Fully Scripted.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/38_RStore__Frame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 46 ScreenGuis, 759 GUI objects → **62 screenshots** |
| Models (.rbxm) | 868 models, 38 model sets, 1 VFX sets |
| Lua builders (.lua) | 59 UI screens, 10 animation packs, 14 audio packs |
| Code | 3979 scripts, 774,378 lines |
| Asset ids | 197 animations, 7505 sounds |
| Safety scan | 0 HIGH / 16 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Oswald Bold`×335, `SourceSansPro Regular`×54, `font asset 12187370747 Bold`×35, `DenkOne Bold`×32, `Inconsolata Bold`×12

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_GunStore.jpg"><img src="screenshots/thumbs/15_GunStore.jpg" width="100%"></a><br><sub><b>GunStore</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_GunStore__Frame.jpg"><img src="screenshots/thumbs/16_GunStore__Frame.jpg" width="100%"></a><br><sub><b>GunStore</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_IDealerGui.jpg"><img src="screenshots/thumbs/17_IDealerGui.jpg" width="100%"></a><br><sub><b>IDealerGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_CarDealerGui.jpg"><img src="screenshots/thumbs/22_CarDealerGui.jpg" width="100%"></a><br><sub><b>CarDealerGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_CarDealerGui__Interact.jpg"><img src="screenshots/thumbs/23_CarDealerGui__Interact.jpg" width="100%"></a><br><sub><b>CarDealerGui</b> › Interact</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_RStore.jpg"><img src="screenshots/thumbs/37_RStore.jpg" width="100%"></a><br><sub><b>RStore</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_RStore__Frame.jpg"><img src="screenshots/thumbs/38_RStore__Frame.jpg" width="100%"></a><br><sub><b>RStore</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_Store.jpg"><img src="screenshots/thumbs/40_Store.jpg" width="100%"></a><br><sub><b>Store</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/47_HStore.jpg"><img src="screenshots/thumbs/47_HStore.jpg" width="100%"></a><br><sub><b>HStore</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/48_GStore.jpg"><img src="screenshots/thumbs/48_GStore.jpg" width="100%"></a><br><sub><b>GStore</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/49_ClothingStore.jpg"><img src="screenshots/thumbs/49_ClothingStore.jpg" width="100%"></a><br><sub><b>ClothingStore</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/50_TattooStore.jpg"><img src="screenshots/thumbs/50_TattooStore.jpg" width="100%"></a><br><sub><b>TattooStore</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/51_AccessoriesStore.jpg"><img src="screenshots/thumbs/51_AccessoriesStore.jpg" width="100%"></a><br><sub><b>AccessoriesStore</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/52_PUStore.jpg"><img src="screenshots/thumbs/52_PUStore.jpg" width="100%"></a><br><sub><b>PUStore</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_Settings__Question.jpg"><img src="screenshots/thumbs/25_Settings__Question.jpg" width="100%"></a><br><sub><b>Settings</b> › Question</sub></td>
<td width="33%" valign="top"><a href="screenshots/57_SugarQuestion.jpg"><img src="screenshots/thumbs/57_SugarQuestion.jpg" width="100%"></a><br><sub><b>SugarQuestion</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_LoadingScreen__CreditsFrame.jpg"><img src="screenshots/thumbs/12_LoadingScreen__CreditsFrame.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › CreditsFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_Settings.jpg"><img src="screenshots/thumbs/24_Settings.jpg" width="100%"></a><br><sub><b>Settings</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_PlayTime.jpg"><img src="screenshots/thumbs/33_PlayTime.jpg" width="100%"></a><br><sub><b>PlayTime</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/35_PlayTime__All.jpg"><img src="screenshots/thumbs/35_PlayTime__All.jpg" width="100%"></a><br><sub><b>PlayTime</b> › All</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_Notification.jpg"><img src="screenshots/thumbs/41_Notification.jpg" width="100%"></a><br><sub><b>Notification</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/43_Notification.jpg"><img src="screenshots/thumbs/43_Notification.jpg" width="100%"></a><br><sub><b>Notification</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_LoadingScreen.jpg"><img src="screenshots/thumbs/10_LoadingScreen.jpg" width="100%"></a><br><sub><b>LoadingScreen</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/11_LoadingScreen__HelpFrame.jpg"><img src="screenshots/thumbs/11_LoadingScreen__HelpFrame.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › HelpFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_LoadingScreen__FreeFrame.jpg"><img src="screenshots/thumbs/13_LoadingScreen__FreeFrame.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › FreeFrame</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_Stats.jpg"><img src="screenshots/thumbs/14_Stats.jpg" width="100%"></a><br><sub><b>Stats</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_GymStats.jpg"><img src="screenshots/thumbs/28_GymStats.jpg" width="100%"></a><br><sub><b>GymStats</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_Dead.jpg"><img src="screenshots/thumbs/30_Dead.jpg" width="100%"></a><br><sub><b>Dead</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_PhoneUI__Main.jpg"><img src="screenshots/thumbs/32_PhoneUI__Main.jpg" width="100%"></a><br><sub><b>PhoneUI</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_PlayTime__Main.jpg"><img src="screenshots/thumbs/34_PlayTime__Main.jpg" width="100%"></a><br><sub><b>PlayTime</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/56_Radio__Main.jpg"><img src="screenshots/thumbs/56_Radio__Main.jpg" width="100%"></a><br><sub><b>Radio</b> › Main</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Locker__Outfits.jpg"><img src="screenshots/thumbs/04_Locker__Outfits.jpg" width="100%"></a><br><sub><b>Locker</b> › Frame.Outfits</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_Locker__Outfits.jpg"><img src="screenshots/thumbs/06_Locker__Outfits.jpg" width="100%"></a><br><sub><b>Locker</b> › Frame.Outfits</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_Locker__Outfits.jpg"><img src="screenshots/thumbs/08_Locker__Outfits.jpg" width="100%"></a><br><sub><b>Locker</b> › Frame.Outfits</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Emotes.jpg"><img src="screenshots/thumbs/27_Emotes.jpg" width="100%"></a><br><sub><b>Emotes</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Locker.jpg"><img src="screenshots/thumbs/01_Locker.jpg" width="100%"></a><br><sub><b>Locker</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_Locker.jpg"><img src="screenshots/thumbs/05_Locker.jpg" width="100%"></a><br><sub><b>Locker</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_Locker.jpg"><img src="screenshots/thumbs/07_Locker.jpg" width="100%"></a><br><sub><b>Locker</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_Circle.jpg"><img src="screenshots/thumbs/09_Circle.jpg" width="100%"></a><br><sub><b>Circle</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_GarageUI.jpg"><img src="screenshots/thumbs/18_GarageUI.jpg" width="100%"></a><br><sub><b>GarageUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_GarageUI__PaintFrame.jpg"><img src="screenshots/thumbs/19_GarageUI__PaintFrame.jpg" width="100%"></a><br><sub><b>GarageUI</b> › Frame.PaintFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_GarageUI__UnderglowFrame.jpg"><img src="screenshots/thumbs/20_GarageUI__UnderglowFrame.jpg" width="100%"></a><br><sub><b>GarageUI</b> › Frame.UnderglowFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_GarageUI__TintFrame.jpg"><img src="screenshots/thumbs/21_GarageUI__TintFrame.jpg" width="100%"></a><br><sub><b>GarageUI</b> › Frame.TintFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_Harvested.jpg"><img src="screenshots/thumbs/26_Harvested.jpg" width="100%"></a><br><sub><b>Harvested</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_Gang__Frame.jpg"><img src="screenshots/thumbs/29_Gang__Frame.jpg" width="100%"></a><br><sub><b>Gang</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_ControllerGui.jpg"><img src="screenshots/thumbs/31_ControllerGui.jpg" width="100%"></a><br><sub><b>ControllerGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_BankRobbery__Frame.jpg"><img src="screenshots/thumbs/36_BankRobbery__Frame.jpg" width="100%"></a><br><sub><b>BankRobbery</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_FrostyUI.jpg"><img src="screenshots/thumbs/39_FrostyUI.jpg" width="100%"></a><br><sub><b>FrostyUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/42_arrestgui.jpg"><img src="screenshots/thumbs/42_arrestgui.jpg" width="100%"></a><br><sub><b>arrestgui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/44_BetterATM.jpg"><img src="screenshots/thumbs/44_BetterATM.jpg" width="100%"></a><br><sub><b>BetterATM</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/45_BetterATM__FrameWithdraw.jpg"><img src="screenshots/thumbs/45_BetterATM__FrameWithdraw.jpg" width="100%"></a><br><sub><b>BetterATM</b> › Frame.Interact.FrameWithdraw</sub></td>
<td width="33%" valign="top"><a href="screenshots/46_BetterATM__FrameDeposit.jpg"><img src="screenshots/thumbs/46_BetterATM__FrameDeposit.jpg" width="100%"></a><br><sub><b>BetterATM</b> › Frame.Interact.FrameDeposit</sub></td>
<td width="33%" valign="top"><a href="screenshots/53_Safe.jpg"><img src="screenshots/thumbs/53_Safe.jpg" width="100%"></a><br><sub><b>Safe</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/54_Zone.jpg"><img src="screenshots/thumbs/54_Zone.jpg" width="100%"></a><br><sub><b>Zone</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/55_SoftShutdown.jpg"><img src="screenshots/thumbs/55_SoftShutdown.jpg" width="100%"></a><br><sub><b>SoftShutdown</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/58_Spawner.jpg"><img src="screenshots/thumbs/58_Spawner.jpg" width="100%"></a><br><sub><b>Spawner</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_CarGui.jpg"><img src="screenshots/thumbs/59_CarGui.jpg" width="100%"></a><br><sub><b>CarGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/60_MobilePunchGui.jpg"><img src="screenshots/thumbs/60_MobilePunchGui.jpg" width="100%"></a><br><sub><b>MobilePunchGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_GunGUI.jpg"><img src="screenshots/thumbs/61_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_GunGUI__Scope_OLD_.jpg"><img src="screenshots/thumbs/62_GunGUI__Scope_OLD_.jpg" width="100%"></a><br><sub><b>GunGUI</b> › Scope(OLD)</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_GunGUI__Scope.jpg"><img src="screenshots/thumbs/63_GunGUI__Scope.jpg" width="100%"></a><br><sub><b>GunGUI</b> › Scope</sub></td>
<td width="33%" valign="top"><a href="screenshots/106_JailUI.jpg"><img src="screenshots/thumbs/106_JailUI.jpg" width="100%"></a><br><sub><b>JailUI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Main%20Building.rbxm"><img src="screenshots/thumbs/models/01_Main_Building.jpg" width="100%"></a><br><sub><b>Main Building</b><br><code>models/Workspace/Main Building.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Cars/Hellcat.rbxm"><img src="screenshots/thumbs/models/02_Hellcat.jpg" width="100%"></a><br><sub><b>Hellcat</b><br><code>models/ServerStorage/Cars/Hellcat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/600%20TommyGun.rbxm"><img src="screenshots/thumbs/models/03_600_TommyGun.jpg" width="100%"></a><br><sub><b>600 TommyGun</b><br><code>models/ServerStorage/600 TommyGun.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/8B%20AK-47.rbxm"><img src="screenshots/thumbs/models/04_8B_AK-47.jpg" width="100%"></a><br><sub><b>8B AK-47</b><br><code>models/ServerStorage/8B AK-47.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/SFM%20Tec-9.rbxm"><img src="screenshots/thumbs/models/05_SFM_Tec-9.jpg" width="100%"></a><br><sub><b>SFM Tec-9</b><br><code>models/ServerStorage/SFM Tec-9.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Chunks/Apt1Inside.rbxm"><img src="screenshots/thumbs/models/06_Apt1Inside.jpg" width="100%"></a><br><sub><b>Apt1Inside</b><br><code>models/Workspace/Chunks/Apt1Inside.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Large%20Filler%20Apt%20building.rbxm"><img src="screenshots/thumbs/models/07_Large_Filler_Apt_building.jpg" width="100%"></a><br><sub><b>Large Filler Apt building</b><br><code>models/Workspace/Large Filler Apt building.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/OutfitsOk/TNK%20Normal%20Vest.rbxm"><img src="screenshots/thumbs/models/08_TNK_Normal_Vest.jpg" width="100%"></a><br><sub><b>TNK Normal Vest</b><br><code>models/ReplicatedStorage/OutfitsOk/TNK Normal Vest.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Plants/Plant__x105.rbxm"><img src="screenshots/thumbs/models/09_Plant_x105.jpg" width="100%"></a><br><sub><b>Plant__x105</b><br><code>models/Workspace/Plants/Plant__x105.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Wood%20Craftes~2/Wood%20Crate.rbxm"><img src="screenshots/thumbs/models/10_Wood_Crate.jpg" width="100%"></a><br><sub><b>Wood Crate</b><br><code>models/Workspace/Wood Craftes~2/Wood Crate.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/HK%20road%20decoration.rbxm"><img src="screenshots/thumbs/models/11_HK_road_decoration.jpg" width="100%"></a><br><sub><b>HK road decoration</b><br><code>models/Workspace/Map/HK road decoration.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Capture%20Guide~2/Board.rbxm"><img src="screenshots/thumbs/models/12_Board.jpg" width="100%"></a><br><sub><b>Board</b><br><code>models/Workspace/Capture Guide~2/Board.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Map/Utility%20buildings/Gunstore.rbxm"><img src="screenshots/thumbs/models/14_Gunstore.jpg" width="100%"></a><br><sub><b>Gunstore</b><br><code>models/Workspace/Map/Utility buildings/Gunstore.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Intro`](source/scripts/ReplicatedFirst/Intro.client.lua) <sub>340 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/1911/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20AK-47/GunScript_Local.client.lua) <sub>1097 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Deagle/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Draco/GunScript_Local.client.lua) <sub>1096 lines</sub> |
| UI controllers / window managers / menus | [`Script`](source/scripts/Workspace/Chunks/1B%20Turf/Model/NormalDoor/Door/Script.server.lua) <sub>58 lines</sub><br>[`Script`](source/scripts/Workspace/Chunks/KTA%20Turf/Model/Door/Script.server.lua) <sub>56 lines</sub><br>[`ShiftGUI`](source/scripts/StarterGui/ShiftLockButton/ImageButton/ShiftGUI.client.lua) <sub>118 lines</sub><br>[`Controls_AC6`](source/scripts/ServerStorage/Cars/DirtBike/Tuner/Plugins/AC6_Controls_Module/Controls_AC6.client.lua) <sub>159 lines</sub><br>[`Drive`](source/scripts/ServerStorage/Cars/PDCar/A-Chassis%20Tune/A-Chassis%20Interface/Drive.client.lua) <sub>708 lines</sub> |
| Notifications, toasts, popups, prompts | [`Notification Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Notification%20Handler.client.lua) <sub>24 lines</sub><br>[`Hooks`](source/scripts/ServerScriptService/Car%20Handler/Hooks.server.lua) <sub>801 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/CLS/A-Chassis%20Tune/Initialize.server.lua) <sub>712 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/GLE53/A-Chassis%20Tune/Initialize.server.lua) <sub>713 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/M2/A-Chassis%20Tune/Initialize.server.lua) <sub>712 lines</sub> |
| Loading / intro screens | [`Intro`](source/scripts/ReplicatedFirst/Intro.client.lua) <sub>340 lines</sub><br>[`Handler`](source/scripts/StarterGui/Settings/Handler.client.lua) <sub>357 lines</sub> |
| Camera, cutscenes, screen shake | [`GunScript_Local`](source/scripts/ServerStorage/1911/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Deagle/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20HoneyBadger/GunScript_Local.client.lua) <sub>1097 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Shotgun/GunScript_Local.client.lua) <sub>1096 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/600%20FN%205.7/GunScript_Local.client.lua) <sub>1109 lines</sub> |
| VFX, particles, beams, hit effects | [`BulletVisualizerServerScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerServerScript.client.lua) <sub>622 lines</sub><br>[`BulletVisualizerClientScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript.client.lua) <sub>554 lines</sub><br>[`VisualizeBulletScript`](source/scripts/ServerScriptService/VisualizeBulletScript.server.lua) <sub>493 lines</sub><br>[`HitSystem`](source/scripts/ReplicatedStorage/Cars/CLS/DriveSeat/HitSystem.server.lua) <sub>94 lines</sub><br>[`HitSystem`](source/scripts/ReplicatedStorage/Cars/Trackhawk/DriveSeat/HitSystem.server.lua) <sub>93 lines</sub> |
| DataStore / player data | [`ProfileService`](source/scripts/ServerScriptService/ProfileCache/ProfileService.lua) <sub>2414 lines</sub><br>[`ProfileCache`](source/scripts/ServerScriptService/ProfileCache.lua) <sub>265 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`DevProduct`](source/scripts/ServerScriptService/DevProduct.server.lua) <sub>263 lines</sub><br>[`Handler`](source/scripts/StarterGui/RStore/Handler.client.lua) <sub>249 lines</sub><br>[`Handler`](source/scripts/StarterGui/Proximity/CarDealerGui/Handler.client.lua) <sub>230 lines</sub><br>[`Handler`](source/scripts/StarterGui/Proximity/GunStore/Handler.client.lua) <sub>240 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Wheelie`](source/scripts/ServerStorage/Cars/DirtBike/Tuner/Plugins/Wheelie.client.lua) <sub>136 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/CLS/A-Chassis%20Tune/Initialize.server.lua) <sub>712 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/DirtBike/Tuner/Initialize.server.lua) <sub>640 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/GLE53/A-Chassis%20Tune/Initialize.server.lua) <sub>713 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/Hellcat/A-Chassis%20Tune/Initialize.server.lua) <sub>718 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Zone`](source/scripts/ReplicatedStorage/Zone.lua) <sub>874 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Run`](source/scripts/StarterGui/Run.client.lua) <sub>226 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/1911/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20AK-47/GunScript_Local.client.lua) <sub>1097 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Deagle/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Draco/GunScript_Local.client.lua) <sub>1096 lines</sub> |
| Tycoon / plots / bases / building | [`Drive`](source/scripts/ServerStorage/Cars/DirtBike/Tuner/Interface/Drive.client.lua) <sub>1042 lines</sub> |
| Leaderboards & stats | [`Leaderstats`](source/scripts/ServerScriptService/Leaderstats.server.lua) <sub>242 lines</sub> |
| Sound & music | [`BulletVisualizerServerScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerServerScript.client.lua) <sub>622 lines</sub><br>[`Audios`](source/scripts/StarterPlayer/StarterPlayerScripts/Audios.client.lua) <sub>83 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/1911/GunScript_Local.client.lua) <sub>1107 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20AK-47/GunScript_Local.client.lua) <sub>1097 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/4M%20Deagle/GunScript_Local.client.lua) <sub>1107 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Signal`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript/FastCastRedux/Signal.lua) <sub>153 lines</sub><br>[`ActiveCast`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript/FastCastRedux/ActiveCast.lua) <sub>834 lines</sub><br>[`Zone`](source/scripts/ReplicatedStorage/Zone.lua) <sub>874 lines</sub><br>[`ProfileService`](source/scripts/ServerScriptService/ProfileCache/ProfileService.lua) <sub>2414 lines</sub> |

### In the curated script library

- [FastCast Redux (main module)](../../Scripts/11-Combat/FastCastRedux__street-life.lua) — FastCast Redux API (projectile raycasting library) as shipped inside a game.
- [Avatar intro camera sequence](../../Scripts/04-Loading-Screens/AvatarIntroSequence__street-life.lua) — ReplicatedFirst intro: loading screen + music fade-in, hides game GUIs/core UI, clones a player model wearing your avatar into an intro set, tweens the camera between shots, then restores everything after a timeout.
- [ZonePlus area music](../../Scripts/17-Sound-Music/ZoneAudio__street-life.lua) — Area music using ZonePlus: each part in workspace.AudioZones holds a Sound that fades in when the local player enters and fades out on exit; the gym and nightclub zones pick a new random track every loop.
- [Headshot screen effect](../../Scripts/06-VFX/HeadshotScreenFX__street-life.lua) — Hit-confirm screen punch: blur + color correction + small FOV dip.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
