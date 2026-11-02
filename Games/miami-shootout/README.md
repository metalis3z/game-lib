# Miami Shootout

> 🔫 **Shooter** · open-world shooter / hood roleplay · source file `Miami Shootout NEWEST GAME (1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/24_BronxLoadscreen__Store.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 70 ScreenGuis, 2138 GUI objects → **49 screenshots** |
| Models (.rbxm) | 1057 models, 76 model sets, 6 VFX sets |
| Lua builders (.lua) | 63 UI screens, 32 animation packs, 78 audio packs |
| Code | 4008 scripts, 483,487 lines |
| Asset ids | 437 animations, 2773 sounds |
| Safety scan | 2 HIGH / 46 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GrenzeGotisch Regular`×372, `SourceSansPro Bold`×165, `Arial Bold`×157, `SourceSansPro Regular`×59, `Bangers Regular`×16

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_BronxLoadscreen__Store.jpg"><img src="screenshots/thumbs/24_BronxLoadscreen__Store.jpg" width="100%"></a><br><sub><b>BronxLoadscreen</b> › Store</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_eximity__Settings.jpg"><img src="screenshots/thumbs/03_eximity__Settings.jpg" width="100%"></a><br><sub><b>eximity</b> › ImageLabel.inner.Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_CellPhone__settings.jpg"><img src="screenshots/thumbs/32_CellPhone__settings.jpg" width="100%"></a><br><sub><b>CellPhone</b> › Frame.running.settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_Settings.jpg"><img src="screenshots/thumbs/35_Settings.jpg" width="100%"></a><br><sub><b>Settings</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_Notification_System.jpg"><img src="screenshots/thumbs/37_Notification_System.jpg" width="100%"></a><br><sub><b>Notification System</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_Dead.jpg"><img src="screenshots/thumbs/34_Dead.jpg" width="100%"></a><br><sub><b>Dead</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/77_AC6_Controls_Module__Window.jpg"><img src="screenshots/thumbs/77_AC6_Controls_Module__Window.jpg" width="100%"></a><br><sub><b>AC6_Controls_Module</b> › Window</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_HealthGui.jpg"><img src="screenshots/thumbs/38_HealthGui.jpg" width="100%"></a><br><sub><b>HealthGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/40_Stamina.jpg"><img src="screenshots/thumbs/40_Stamina.jpg" width="100%"></a><br><sub><b>Stamina</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/42_MoneyGui.jpg"><img src="screenshots/thumbs/42_MoneyGui.jpg" width="100%"></a><br><sub><b>MoneyGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/67_GiveCash__MoneyFrame.jpg"><img src="screenshots/thumbs/67_GiveCash__MoneyFrame.jpg" width="100%"></a><br><sub><b>GiveCash</b> › MoneyFrame</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Inventory__Background.jpg"><img src="screenshots/thumbs/27_Inventory__Background.jpg" width="100%"></a><br><sub><b>Inventory</b> › Background</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_eximity.jpg"><img src="screenshots/thumbs/01_eximity.jpg" width="100%"></a><br><sub><b>eximity</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_eximity__Executor.jpg"><img src="screenshots/thumbs/04_eximity__Executor.jpg" width="100%"></a><br><sub><b>eximity</b> › ImageLabel.inner.Executor</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_GunGui.jpg"><img src="screenshots/thumbs/05_GunGui.jpg" width="100%"></a><br><sub><b>GunGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_GunGUI.jpg"><img src="screenshots/thumbs/06_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_GunGUI__Scope.jpg"><img src="screenshots/thumbs/07_GunGUI__Scope.jpg" width="100%"></a><br><sub><b>GunGUI</b> › Scope</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_GunGUI__Scope_OLD_.jpg"><img src="screenshots/thumbs/08_GunGUI__Scope_OLD_.jpg" width="100%"></a><br><sub><b>GunGUI</b> › Scope(OLD)</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_GunGUI.jpg"><img src="screenshots/thumbs/10_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_GunGUI__Scope.jpg"><img src="screenshots/thumbs/12_GunGUI__Scope.jpg" width="100%"></a><br><sub><b>GunGUI</b> › Scope</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_DoorAction.jpg"><img src="screenshots/thumbs/13_DoorAction.jpg" width="100%"></a><br><sub><b>DoorAction</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_BronxLoadscreen.jpg"><img src="screenshots/thumbs/22_BronxLoadscreen.jpg" width="100%"></a><br><sub><b>BronxLoadscreen</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_BronxLoadscreen__Rules.jpg"><img src="screenshots/thumbs/23_BronxLoadscreen__Rules.jpg" width="100%"></a><br><sub><b>BronxLoadscreen</b> › Rules</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_MobilePunchGui.jpg"><img src="screenshots/thumbs/25_MobilePunchGui.jpg" width="100%"></a><br><sub><b>MobilePunchGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_KeyboardButtons.jpg"><img src="screenshots/thumbs/26_KeyboardButtons.jpg" width="100%"></a><br><sub><b>KeyboardButtons</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_CellPhone.jpg"><img src="screenshots/thumbs/28_CellPhone.jpg" width="100%"></a><br><sub><b>CellPhone</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_CellPhone__cam.jpg"><img src="screenshots/thumbs/29_CellPhone__cam.jpg" width="100%"></a><br><sub><b>CellPhone</b> › Frame.running.cam</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_CellPhone__phone.jpg"><img src="screenshots/thumbs/30_CellPhone__phone.jpg" width="100%"></a><br><sub><b>CellPhone</b> › Frame.running.phone</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_CellPhone__phoneCall.jpg"><img src="screenshots/thumbs/31_CellPhone__phoneCall.jpg" width="100%"></a><br><sub><b>CellPhone</b> › Frame.running.phoneCall</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_CellPhone__slidebread.jpg"><img src="screenshots/thumbs/33_CellPhone__slidebread.jpg" width="100%"></a><br><sub><b>CellPhone</b> › Frame.running.slidebread</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_Hunger.jpg"><img src="screenshots/thumbs/39_Hunger.jpg" width="100%"></a><br><sub><b>Hunger</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_Run.jpg"><img src="screenshots/thumbs/41_Run.jpg" width="100%"></a><br><sub><b>Run</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/43_ScreenGui__Frame.jpg"><img src="screenshots/thumbs/43_ScreenGui__Frame.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/44_ScreenGui__Frame.jpg"><img src="screenshots/thumbs/44_ScreenGui__Frame.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/45_SoftShutdown.jpg"><img src="screenshots/thumbs/45_SoftShutdown.jpg" width="100%"></a><br><sub><b>SoftShutdown</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/46_NYPDBC.jpg"><img src="screenshots/thumbs/46_NYPDBC.jpg" width="100%"></a><br><sub><b>NYPDBC</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_Spawner.jpg"><img src="screenshots/thumbs/59_Spawner.jpg" width="100%"></a><br><sub><b>Spawner</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/60_Out.jpg"><img src="screenshots/thumbs/60_Out.jpg" width="100%"></a><br><sub><b>Out</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_Aux.jpg"><img src="screenshots/thumbs/61_Aux.jpg" width="100%"></a><br><sub><b>Aux</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_Aux__List.jpg"><img src="screenshots/thumbs/62_Aux__List.jpg" width="100%"></a><br><sub><b>Aux</b> › AudioPlayerGui.List</sub></td>
<td width="33%" valign="top"><a href="screenshots/64_KeyboardButtons.jpg"><img src="screenshots/thumbs/64_KeyboardButtons.jpg" width="100%"></a><br><sub><b>KeyboardButtons</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_SirenControl.jpg"><img src="screenshots/thumbs/68_SirenControl.jpg" width="100%"></a><br><sub><b>SirenControl</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/69_GunGUI.jpg"><img src="screenshots/thumbs/69_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/72_GunGUI.jpg"><img src="screenshots/thumbs/72_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/78_CarGui.jpg"><img src="screenshots/thumbs/78_CarGui.jpg" width="100%"></a><br><sub><b>CarGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_EMSCar.jpg"><img src="screenshots/thumbs/79_EMSCar.jpg" width="100%"></a><br><sub><b>EMSCar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/80_Mask.jpg"><img src="screenshots/thumbs/80_Mask.jpg" width="100%"></a><br><sub><b>Mask</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/81_GunGUI.jpg"><img src="screenshots/thumbs/81_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/93_GunGUI.jpg"><img src="screenshots/thumbs/93_GunGUI.jpg" width="100%"></a><br><sub><b>GunGUI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Gamepass%20Guns/HallowARP.rbxm"><img src="screenshots/thumbs/models/01_HallowARP.jpg" width="100%"></a><br><sub><b>HallowARP</b><br><code>models/ServerStorage/Gamepass Guns/HallowARP.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Cars/Durango.rbxm"><img src="screenshots/thumbs/models/02_Durango.jpg" width="100%"></a><br><sub><b>Durango</b><br><code>models/ServerStorage/Cars/Durango.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/AK-47.rbxm"><img src="screenshots/thumbs/models/03_AK-47.jpg" width="100%"></a><br><sub><b>AK-47</b><br><code>models/ReplicatedStorage/Items/AK-47.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Cars/Police%20Explorer.rbxm"><img src="screenshots/thumbs/models/04_Police_Explorer.jpg" width="100%"></a><br><sub><b>Police Explorer</b><br><code>models/ServerStorage/Cars/Police Explorer.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/RugerP345.rbxm"><img src="screenshots/thumbs/models/05_RugerP345.jpg" width="100%"></a><br><sub><b>RugerP345</b><br><code>models/ReplicatedStorage/Items/RugerP345.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/DirtbikeGamepass/Honda%2085.rbxm"><img src="screenshots/thumbs/models/06_Honda_85.jpg" width="100%"></a><br><sub><b>Honda 85</b><br><code>models/ServerScriptService/DirtbikeGamepass/Honda 85.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Meshes_SM_Prop_ShopInterior_Chair_01.rbxm"><img src="screenshots/thumbs/models/07_Meshes_SM_Prop_ShopInterior_Chair_01.jpg" width="100%"></a><br><sub><b>Meshes_SM_Prop_ShopInterior_Chair_01</b><br><code>models/Workspace/Meshes_SM_Prop_ShopInterior_Chair_01.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Folder~2/Open%20Sign%20Decoration.rbxm"><img src="screenshots/thumbs/models/08_Open_Sign_Decoration.jpg" width="100%"></a><br><sub><b>Open Sign Decoration</b><br><code>models/Workspace/Folder~2/Open Sign Decoration.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Crate__x8.rbxm"><img src="screenshots/thumbs/models/09_Crate_x8.jpg" width="100%"></a><br><sub><b>Crate__x8</b><br><code>models/Workspace/Crate__x8.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Model~330/Plant_1__x6.rbxm"><img src="screenshots/thumbs/models/10_Plant_1_x6.jpg" width="100%"></a><br><sub><b>Plant_1__x6</b><br><code>models/Workspace/Model~330/Plant_1__x6.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Folder~2/Sign~3.rbxm"><img src="screenshots/thumbs/models/11_Sign_3.jpg" width="100%"></a><br><sub><b>Sign~3</b><br><code>models/Workspace/Folder~2/Sign~3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Gamepass%20Guns/GlockDrumSwitch.rbxm"><img src="screenshots/thumbs/models/12_GlockDrumSwitch.jpg" width="100%"></a><br><sub><b>GlockDrumSwitch</b><br><code>models/ServerStorage/Gamepass Guns/GlockDrumSwitch.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Cars/TrackHawk.rbxm"><img src="screenshots/thumbs/models/13_TrackHawk.jpg" width="100%"></a><br><sub><b>TrackHawk</b><br><code>models/ServerStorage/Cars/TrackHawk.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Chains/Belt.rbxm"><img src="screenshots/thumbs/models/14_Belt.jpg" width="100%"></a><br><sub><b>Belt</b><br><code>models/ReplicatedStorage/Chains/Belt.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`GunScript_Local`](source/scripts/Lighting/Taser/GunScript_Local.client.lua) <sub>799 lines</sub><br>[`Icon`](source/scripts/ReplicatedStorage/Icon.lua) <sub>2480 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/.357/GunScript_Local.client.lua) <sub>1040 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/Colt/GunScript_Local.client.lua) <sub>1036 lines</sub><br>[`GunScript_Local`](source/scripts/ServerStorage/.357/GunScript_Local.client.lua) <sub>1060 lines</sub> |
| UI controllers / window managers / menus | [`Icon`](source/scripts/ReplicatedStorage/Icon.lua) <sub>2480 lines</sub><br>[`Script`](source/scripts/Workspace/Door~4/Open/Script.server.lua) <sub>28 lines</sub><br>[`Script`](source/scripts/Workspace/fence_door/extGui/SurfaceGui/SCREEN/Script.server.lua) <sub>76 lines</sub><br>[`Script`](source/scripts/Workspace/fence_door/insideGui/SurfaceGui/SCREEN/Script.server.lua) <sub>33 lines</sub><br>[`Bank`](source/scripts/ServerScriptService/Bank%20Stuff/Bank.server.lua) <sub>291 lines</sub> |
| Notifications, toasts, popups, prompts | [`BankActions`](source/scripts/ServerScriptService/Bank%20Stuff/BankActions.server.lua) <sub>220 lines</sub><br>[`Carrying`](source/scripts/ServerScriptService/CarrySystem/Carrying.server.lua) <sub>209 lines</sub><br>[`DetainClient`](source/scripts/Lighting/Handcuffs/DetainClient.client.lua) <sub>258 lines</sub><br>[`service`](source/scripts/ReplicatedFirst/service.client.lua) <sub>272 lines</sub><br>[`Bank`](source/scripts/ServerScriptService/Bank%20Stuff/Bank.server.lua) <sub>291 lines</sub> |
| Loading / intro screens | [`Intro`](source/scripts/StarterPlayer/StarterCharacterScripts/Intro.client.lua) <sub>220 lines</sub> |
| Camera, cutscenes, screen shake | [`GunScript_Local`](source/scripts/Lighting/Taser/GunScript_Local.client.lua) <sub>799 lines</sub><br>[`camShakes`](source/scripts/StarterPlayer/StarterCharacterScripts/camShakes.client.lua) <sub>22 lines</sub><br>[`EasyFirstPerson`](source/scripts/StarterPlayer/StarterCharacterScripts/EasyFirstPerson.client.lua) <sub>509 lines</sub><br>[`Intro`](source/scripts/StarterPlayer/StarterCharacterScripts/Intro.client.lua) <sub>220 lines</sub><br>[`Camera12`](source/scripts/Lighting/.357/Camera12.client.lua) <sub>41 lines</sub> |
| VFX, particles, beams, hit effects | [`BulletVisualizerServerScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerServerScript.client.lua) <sub>522 lines</sub><br>[`BulletVisualizerClientScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript.client.lua) <sub>453 lines</sub><br>[`VisualizeBulletScript`](source/scripts/ServerScriptService/VisualizeBulletScript.server.lua) <sub>554 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/Taser/GunScript_Local.client.lua) <sub>799 lines</sub><br>[`Damage`](source/scripts/Lighting/Flash/Server/Damage.server.lua) <sub>199 lines</sub> |
| DataStore / player data | [`ProfileService`](source/scripts/ServerScriptService/ProfileCache/ProfileService.lua) <sub>2417 lines</sub><br>[`Save Money`](source/scripts/ServerScriptService/Save%20Money.server.lua) <sub>33 lines</sub><br>[`ProfileCache`](source/scripts/ServerScriptService/ProfileCache.lua) <sub>144 lines</sub><br>[`ArrestNEW`](source/scripts/ServerScriptService/ArrestNEW.server.lua) <sub>223 lines</sub><br>[`ArrestOLD`](source/scripts/ServerScriptService/ArrestOLD.server.lua) <sub>174 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`DirtbikeGamepass`](source/scripts/ServerScriptService/DirtbikeGamepass.server.lua) <sub>27 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Wheelie`](source/scripts/ServerScriptService/DirtbikeGamepass/Honda%2085/Tuner/Plugins/Wheelie.client.lua) <sub>83 lines</sub><br>[`Initialize`](source/scripts/ServerScriptService/DirtbikeGamepass/Honda%2085/Tuner/Initialize.server.lua) <sub>513 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/AmbulanceVan/A-Chassis%20Tune/Initialize.server.lua) <sub>735 lines</sub><br>[`Initialize`](source/scripts/ServerStorage/Cars/ATV/A-Chassis%20Tune/Initialize.server.lua) <sub>589 lines</sub><br>[`Simulated`](source/scripts/ServerStorage/Cars/ATV/A-Chassis%20Tune/Plugins/%5BSS6%5D%20Dynamic%20Friction/Simulated.client.lua) <sub>197 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Damage`](source/scripts/Lighting/Flash/Server/Damage.server.lua) <sub>199 lines</sub><br>[`VisualizeBulletScript`](source/scripts/ServerScriptService/VisualizeBulletScript.server.lua) <sub>554 lines</sub><br>[`DamageHandler`](source/scripts/Lighting/Tools/Pistol/DealDamage/DamageHandler.server.lua) <sub>10 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`StaminaBarScript`](source/scripts/StarterGui/Stamina/Background/HealthDisplay/StaminaBarScript.client.lua) <sub>46 lines</sub><br>[`Crouch script`](source/scripts/StarterGui/CrouchSystem/Crouch/Crouch%20script.client.lua) <sub>51 lines</sub><br>[`Crawl`](source/scripts/StarterGui/Crawl.client.lua) <sub>114 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/.357/GunScript_Local.client.lua) <sub>1040 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/Colt/GunScript_Local.client.lua) <sub>1036 lines</sub> |
| Tycoon / plots / bases / building | [`Drive`](source/scripts/ServerStorage/Cars/Redacted/Blazerr/A-Chassis%20Tune/A-Chassis%20Interface/Drive.client.lua) <sub>700 lines</sub><br>[`Drive`](source/scripts/ServerScriptService/DirtbikeGamepass/Honda%2085/Tuner/Interface/Drive.client.lua) <sub>960 lines</sub><br>[`Bank`](source/scripts/ServerScriptService/Bank%20Stuff/Bank.server.lua) <sub>291 lines</sub><br>[`Script`](source/scripts/Workspace/MafiaMember/ClickDetector/Script.server.lua) <sub>123 lines</sub> |
| Leaderboards & stats | [`Leaderstats`](source/scripts/ServerScriptService/Leaderstats.server.lua) <sub>17 lines</sub> |
| Sound & music | [`BulletVisualizerServerScript`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerServerScript.client.lua) <sub>522 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/Taser/GunScript_Local.client.lua) <sub>799 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/.357/GunScript_Local.client.lua) <sub>1040 lines</sub><br>[`GunScript_Local`](source/scripts/Lighting/Colt/GunScript_Local.client.lua) <sub>1036 lines</sub><br>[`AC6_Stock_Sound`](source/scripts/ServerScriptService/AC/AC6_Stock_Sound.client.lua) <sub>50 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`ProfileService`](source/scripts/ServerScriptService/ProfileCache/ProfileService.lua) <sub>2417 lines</sub><br>[`Signal`](source/scripts/ReplicatedStorage/Icon/Signal.lua) <sub>109 lines</sub><br>[`Icon`](source/scripts/ReplicatedStorage/Icon.lua) <sub>2480 lines</sub><br>[`Signal`](source/scripts/StarterPlayer/StarterPlayerScripts/BulletVisualizerClientScript/FastCast/Signal.lua) <sub>80 lines</sub> |

### In the curated script library

- [FastCast bullet tracers](../../Scripts/11-Combat/FastCastBulletTracer__miami-shootout.lua) — Using FastCast for cosmetic bullets: fire, update the bullet on LengthChanged, handle hits.
- [Crouch toggle](../../Scripts/13-Movement/CrouchToggle__miami-shootout.lua) — Crouch: animation speed follows movement, slower walk, no jump.
- [buildRagdoll (Roblox R15 ragdoll)](../../Scripts/13-Movement/buildRagdoll__miami-shootout.lua) — Roblox's R15 ragdoll builder (entry point).
- [Ragdoll constraint presets](../../Scripts/13-Movement/buildRagdollConstraints__miami-shootout.lua) — Why each joint uses BallSocket vs Hinge and which limits (great comments).
- [Ragdoll collision filters](../../Scripts/13-Movement/buildRagdollCollisionFilters__miami-shootout.lua) — Which limb pairs need NoCollisionConstraints in a ragdoll.
- [Notification with timer bar](../../Scripts/03-Notifications/TimedNotification__miami-shootout.lua) — Notification with a filler wipe-in and a shrinking timer bar showing time left; templates per "Mode", callable from server via RemoteEvent.
- [Flashbang screen](../../Scripts/06-VFX/FlashbangScreen__miami-shootout.lua) — Flashbang: white frame in 0.15 s, hold, fade out 3 s, ear ringing.
- [Bullet impact & blood FX](../../Scripts/06-VFX/BulletImpactAndBloodFX__miami-shootout.lua) — Per-material bullet impacts oriented to the surface normal, tinted to the hit part, plus blood.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/DiscordEvent.server.lua`
- `scripts/Workspace/Terrain/Converter.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
