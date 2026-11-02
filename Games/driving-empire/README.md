# Driving Empire

> 🚗 **Driving** · open-world driving · source file `Driving_Empire%20(1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/12_MainHUD__PromptPurchase.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (structure only, no code) |
| Screens | 7 ScreenGuis, 1347 GUI objects → **20 screenshots** |
| Models (.rbxm) | 976 models, 136 model sets, 0 VFX sets |
| Lua builders (.lua) | 9 UI screens, 4 animation packs, 6 audio packs |
| Code | 321 scripts, 0 lines |
| Asset ids | 561 animations, 495 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Bold`×146, `SourceSansPro Regular`×111, `SourceSansPro SemiBold`×75, `GothamSSm Regular`×55, `SourceSansPro Bold`×41

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Customization__PurchasePrompt.jpg"><img src="screenshots/thumbs/03_Customization__PurchasePrompt.jpg" width="100%"></a><br><sub><b>Customization</b> › PurchasePrompt</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_MainHUD__StarterCars.jpg"><img src="screenshots/thumbs/06_MainHUD__StarterCars.jpg" width="100%"></a><br><sub><b>MainHUD</b> › StarterCars</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_MainHUD__AreYouSure.jpg"><img src="screenshots/thumbs/09_MainHUD__AreYouSure.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Dealership.AreYouSure</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_MainHUD__Selector.jpg"><img src="screenshots/thumbs/10_MainHUD__Selector.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Dealership.Selector</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_MainHUD__PromptPurchase.jpg"><img src="screenshots/thumbs/12_MainHUD__PromptPurchase.jpg" width="100%"></a><br><sub><b>MainHUD</b> › PromptPurchase</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_Loading__Menu.jpg"><img src="screenshots/thumbs/02_Loading__Menu.jpg" width="100%"></a><br><sub><b>Loading</b> › Menu</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_MainHUD__Settings.jpg"><img src="screenshots/thumbs/13_MainHUD__Settings.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Settings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_MainHUD__SellPrompt.jpg"><img src="screenshots/thumbs/07_MainHUD__SellPrompt.jpg" width="100%"></a><br><sub><b>MainHUD</b> › SellPrompt</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Loading.jpg"><img src="screenshots/thumbs/01_Loading.jpg" width="100%"></a><br><sub><b>Loading</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_MainHUD__RaceEnd.jpg"><img src="screenshots/thumbs/11_MainHUD__RaceEnd.jpg" width="100%"></a><br><sub><b>MainHUD</b> › RaceEnd</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_MainHUD.jpg"><img src="screenshots/thumbs/04_MainHUD.jpg" width="100%"></a><br><sub><b>MainHUD</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_MainHUD__Vehicles.jpg"><img src="screenshots/thumbs/05_MainHUD__Vehicles.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Vehicles</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_MainHUD__VehicleRemoved.jpg"><img src="screenshots/thumbs/08_MainHUD__VehicleRemoved.jpg" width="100%"></a><br><sub><b>MainHUD</b> › VehicleRemoved</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_MainHUD__Teleport.jpg"><img src="screenshots/thumbs/14_MainHUD__Teleport.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Teleport</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_MainHUD__Radio.jpg"><img src="screenshots/thumbs/15_MainHUD__Radio.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Radio</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_MainHUD__Changelog.jpg"><img src="screenshots/thumbs/16_MainHUD__Changelog.jpg" width="100%"></a><br><sub><b>MainHUD</b> › Changelog</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_PhotoMode.jpg"><img src="screenshots/thumbs/17_PhotoMode.jpg" width="100%"></a><br><sub><b>PhotoMode</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_Special__PayoffBounty.jpg"><img src="screenshots/thumbs/18_Special__PayoffBounty.jpg" width="100%"></a><br><sub><b>Special</b> › PayoffBounty</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_Special__BailPromt.jpg"><img src="screenshots/thumbs/19_Special__BailPromt.jpg" width="100%"></a><br><sub><b>Special</b> › BailPromt</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Watermark.jpg"><img src="screenshots/thumbs/20_Watermark.jpg" width="100%"></a><br><sub><b>Watermark</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Vehicles/BDRoblox6392.rbxm"><img src="screenshots/thumbs/models/01_BDRoblox6392.jpg" width="100%"></a><br><sub><b>BDRoblox6392</b><br><code>models/Workspace/Vehicles/BDRoblox6392.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Vehicles/Kirilltoy3.rbxm"><img src="screenshots/thumbs/models/02_Kirilltoy3.jpg" width="100%"></a><br><sub><b>Kirilltoy3</b><br><code>models/Workspace/Vehicles/Kirilltoy3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Houses/_House_.rbxm"><img src="screenshots/thumbs/models/03__House_.jpg" width="100%"></a><br><sub><b>_House_</b><br><code>models/Workspace/Houses/_House_.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/TrafficLights/System.rbxm"><img src="screenshots/thumbs/models/04_System.jpg" width="100%"></a><br><sub><b>System</b><br><code>models/Workspace/Game/TrafficLights/System.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Map/Landscaping/Militia%20Rock%206.rbxm"><img src="screenshots/thumbs/models/05_Militia_Rock_6.jpg" width="100%"></a><br><sub><b>Militia Rock 6</b><br><code>models/Workspace/Map/Landscaping/Militia Rock 6.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/drive%20thru%20accessories.rbxm"><img src="screenshots/thumbs/models/06_drive_thru_accessories.jpg" width="100%"></a><br><sub><b>drive thru accessories</b><br><code>models/Workspace/drive thru accessories.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Core~13/FL.rbxm"><img src="screenshots/thumbs/models/07_FL.jpg" width="100%"></a><br><sub><b>FL</b><br><code>models/ReplicatedStorage/Core~13/FL.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Game/Leaderboards/miles.rbxm"><img src="screenshots/thumbs/models/08_miles.jpg" width="100%"></a><br><sub><b>miles</b><br><code>models/Workspace/Game/Leaderboards/miles.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Cells/Cell5/PrisonCell/Items.rbxm"><img src="screenshots/thumbs/models/09_Items.jpg" width="100%"></a><br><sub><b>Items</b><br><code>models/Workspace/Cells/Cell5/PrisonCell/Items.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Bush.rbxm"><img src="screenshots/thumbs/models/10_Bush.jpg" width="100%"></a><br><sub><b>Bush</b><br><code>models/Workspace/Bush.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Vehicles/Ikwilniethoi.rbxm"><img src="screenshots/thumbs/models/11_Ikwilniethoi.jpg" width="100%"></a><br><sub><b>Ikwilniethoi</b><br><code>models/Workspace/Vehicles/Ikwilniethoi.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Vehicles/Klimous_24.rbxm"><img src="screenshots/thumbs/models/12_Klimous_24.jpg" width="100%"></a><br><sub><b>Klimous_24</b><br><code>models/Workspace/Vehicles/Klimous_24.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Houses/_House_~3.rbxm"><img src="screenshots/thumbs/models/13__House_3.jpg" width="100%"></a><br><sub><b>_House_~3</b><br><code>models/Workspace/Houses/_House_~3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Homes/79.rbxm"><img src="screenshots/thumbs/models/14_79.jpg" width="100%"></a><br><sub><b>79</b><br><code>models/Workspace/Map/Homes/79.rbxm</code></sub></td>
</tr>
</table>

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
