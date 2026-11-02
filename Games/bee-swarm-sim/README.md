# Bee Swarm Simulator (remake)

> ⛏️ **Simulator** · collecting simulator · source file `Bee20Sim(1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/09_UI__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 5 ScreenGuis, 622 GUI objects → **23 screenshots** |
| Models (.rbxm) | 739 models, 23 model sets, 3 VFX sets |
| Lua builders (.lua) | 47 UI screens, 18 animation packs, 4 audio packs |
| Code | 269 scripts, 29,930 lines |
| Asset ids | 37 animations, 17 sounds |
| Safety scan | 2 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×280, `SourceSansPro Regular`×18, `ComicNeueAngular Regular`×12, `ComicNeueAngular Bold`×11, `Poppins Bold`×3

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_UI__Shop.jpg"><img src="screenshots/thumbs/09_UI__Shop.jpg" width="100%"></a><br><sub><b>UI</b> › Tabs.Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_UI__Shop.jpg"><img src="screenshots/thumbs/11_UI__Shop.jpg" width="100%"></a><br><sub><b>UI</b> › Shop</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_UI__Inventory.jpg"><img src="screenshots/thumbs/05_UI__Inventory.jpg" width="100%"></a><br><sub><b>UI</b> › Tabs.Inventory</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_UI__Index.jpg"><img src="screenshots/thumbs/07_UI__Index.jpg" width="100%"></a><br><sub><b>UI</b> › Tabs.Index</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_Create_Codes.jpg"><img src="screenshots/thumbs/21_Create_Codes.jpg" width="100%"></a><br><sub><b>Create Codes</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Codes_Management.jpg"><img src="screenshots/thumbs/22_Codes_Management.jpg" width="100%"></a><br><sub><b>Codes Management</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_Codes_Management__CodeExample.jpg"><img src="screenshots/thumbs/24_Codes_Management__CodeExample.jpg" width="100%"></a><br><sub><b>Codes Management</b> › CodeExample</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_questgui.jpg"><img src="screenshots/thumbs/01_questgui.jpg" width="100%"></a><br><sub><b>questgui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_UI__Quests.jpg"><img src="screenshots/thumbs/06_UI__Quests.jpg" width="100%"></a><br><sub><b>UI</b> › Tabs.Quests</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_UI__TreatQuest.jpg"><img src="screenshots/thumbs/13_UI__TreatQuest.jpg" width="100%"></a><br><sub><b>UI</b> › TreatQuest</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_UI__Settings.jpg"><img src="screenshots/thumbs/08_UI__Settings.jpg" width="100%"></a><br><sub><b>UI</b> › Tabs.Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_Developer_Menu.jpg"><img src="screenshots/thumbs/18_Developer_Menu.jpg" width="100%"></a><br><sub><b>Developer Menu</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_Developer_Menu__FunctionExample.jpg"><img src="screenshots/thumbs/19_Developer_Menu__FunctionExample.jpg" width="100%"></a><br><sub><b>Developer Menu</b> › FunctionExample</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Developer_Menu__NoAccessFunctionExample.jpg"><img src="screenshots/thumbs/20_Developer_Menu__NoAccessFunctionExample.jpg" width="100%"></a><br><sub><b>Developer Menu</b> › NoAccessFunctionExample</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_BeePopup2.jpg"><img src="screenshots/thumbs/03_BeePopup2.jpg" width="100%"></a><br><sub><b>BeePopup2</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_UI__Dialogue.jpg"><img src="screenshots/thumbs/14_UI__Dialogue.jpg" width="100%"></a><br><sub><b>UI</b> › Dialogue</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_UI__Loading.jpg"><img src="screenshots/thumbs/16_UI__Loading.jpg" width="100%"></a><br><sub><b>UI</b> › Loading</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_DELETE_ME.jpg"><img src="screenshots/thumbs/02_DELETE_ME.jpg" width="100%"></a><br><sub><b>DELETE ME</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_UI.jpg"><img src="screenshots/thumbs/04_UI.jpg" width="100%"></a><br><sub><b>UI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_UI__Badges.jpg"><img src="screenshots/thumbs/10_UI__Badges.jpg" width="100%"></a><br><sub><b>UI</b> › Tabs.Badges</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_UI__BeeInfo.jpg"><img src="screenshots/thumbs/12_UI__BeeInfo.jpg" width="100%"></a><br><sub><b>UI</b> › BeeInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_UI__Tutor.jpg"><img src="screenshots/thumbs/15_UI__Tutor.jpg" width="100%"></a><br><sub><b>UI</b> › Tutor</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_UI__Cooking.jpg"><img src="screenshots/thumbs/17_UI__Cooking.jpg" width="100%"></a><br><sub><b>UI</b> › Cooking</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Bees/Barbel/Gifted.rbxm"><img src="screenshots/thumbs/models/01_Gifted.jpg" width="100%"></a><br><sub><b>Gifted</b><br><code>models/ReplicatedStorage/Bees/Barbel/Gifted.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/FieldDecorations/BlueFlowersField.rbxm"><img src="screenshots/thumbs/models/02_BlueFlowersField.jpg" width="100%"></a><br><sub><b>BlueFlowersField</b><br><code>models/Workspace/FieldDecorations/BlueFlowersField.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Caramel.rbxm"><img src="screenshots/thumbs/models/03_Caramel.jpg" width="100%"></a><br><sub><b>Caramel</b><br><code>models/Workspace/Caramel.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Assets/Bags/Tall%20Grass%20Bag.rbxm"><img src="screenshots/thumbs/models/04_Tall_Grass_Bag.jpg" width="100%"></a><br><sub><b>Tall Grass Bag</b><br><code>models/ServerScriptService/Assets/Bags/Tall Grass Bag.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/greenhouse.rbxm"><img src="screenshots/thumbs/models/05_greenhouse.jpg" width="100%"></a><br><sub><b>greenhouse</b><br><code>models/Workspace/greenhouse.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/UseItem/Gem.rbxm"><img src="screenshots/thumbs/models/06_Gem.jpg" width="100%"></a><br><sub><b>Gem</b><br><code>models/ServerScriptService/Server/UseItem/Gem.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Assets/Tools/Axe.rbxm"><img src="screenshots/thumbs/models/07_Axe.jpg" width="100%"></a><br><sub><b>Axe</b><br><code>models/ServerScriptService/Assets/Tools/Axe.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/AntSimIsShit%3Dtrue/Egg%20Shop.rbxm"><img src="screenshots/thumbs/models/08_Egg_Shop.jpg" width="100%"></a><br><sub><b>Egg Shop</b><br><code>models/Workspace/AntSimIsShit=true/Egg Shop.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Grass%5BMAP%5D/Plane.003.rbxm"><img src="screenshots/thumbs/models/09_Plane_003.jpg" width="100%"></a><br><sub><b>Plane.003</b><br><code>models/Workspace/Grass[MAP]/Plane.003.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Shops/WorkerShop/PHItems/TwistingGrass.rbxm"><img src="screenshots/thumbs/models/10_TwistingGrass.jpg" width="100%"></a><br><sub><b>TwistingGrass</b><br><code>models/Workspace/Map/Shops/WorkerShop/PHItems/TwistingGrass.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BlenderModels/No%20model/Bag%20Flower.rbxm"><img src="screenshots/thumbs/models/11_Bag_Flower.jpg" width="100%"></a><br><sub><b>Bag Flower</b><br><code>models/Workspace/BlenderModels/No model/Bag Flower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Shops/WorkerShop/PHItems/Shovel.rbxm"><img src="screenshots/thumbs/models/12_Shovel.jpg" width="100%"></a><br><sub><b>Shovel</b><br><code>models/Workspace/Map/Shops/WorkerShop/PHItems/Shovel.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/RedHQPro/PHItems/Model.rbxm"><img src="screenshots/thumbs/models/13_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/ServerStorage/RedHQPro/PHItems/Model.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BlenderModels/No%20model/LeaderBoardBig.rbxm"><img src="screenshots/thumbs/models/14_LeaderBoardBig.jpg" width="100%"></a><br><sub><b>LeaderBoardBig</b><br><code>models/Workspace/BlenderModels/No model/LeaderBoardBig.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub><br>[`Shops`](source/scripts/ReplicatedStorage/Modules/UI/Shops.lua) <sub>609 lines</sub><br>[`Hover`](source/scripts/ReplicatedStorage/StarterGui/UI/Client/Boost/Hover.client.lua) <sub>125 lines</sub><br>[`MainScript`](source/scripts/ServerStorage/Developer/Tab/Developer%20Menu/MainScript.client.lua) <sub>91 lines</sub><br>[`Quests`](source/scripts/ReplicatedStorage/Modules/UI/Quests.lua) <sub>199 lines</sub> |
| UI controllers / window managers / menus | [`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub><br>[`Shops`](source/scripts/ReplicatedStorage/Modules/UI/Shops.lua) <sub>609 lines</sub><br>[`MainScript`](source/scripts/ServerStorage/Developer/Tab/Dev/Create%20Codes/MainScript.client.lua) <sub>166 lines</sub> |
| Notifications, toasts, popups, prompts | [`NEWAlerts`](source/scripts/ReplicatedStorage/Modules/NEWAlerts.lua) <sub>91 lines</sub><br>[`Alerts`](source/scripts/ReplicatedStorage/Modules/Alerts.lua) <sub>112 lines</sub><br>[`ClientUtilities`](source/scripts/ReplicatedStorage/ClientUtilities.lua) <sub>42 lines</sub><br>[`HivesManager`](source/scripts/ReplicatedStorage/Modules/HivesManager.lua) <sub>263 lines</sub><br>[`HivesManager`](source/scripts/ServerScriptService/Modules/HivesManager.lua) <sub>381 lines</sub> |
| Camera, cutscenes, screen shake | [`Utils`](source/scripts/ReplicatedStorage/Modules/Utils.lua) <sub>492 lines</sub><br>[`Quests2`](source/scripts/ReplicatedStorage/Modules/UI/Quests2.lua) <sub>337 lines</sub> |
| VFX, particles, beams, hit effects | [`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub> |
| DataStore / player data | [`DataStore2`](source/scripts/ServerScriptService/DataStore2.lua) <sub>581 lines</sub><br>[`CodeData`](source/scripts/ServerScriptService/CodeData.lua) <sub>61 lines</sub><br>[`Data`](source/scripts/ServerScriptService/Server/Data.lua) <sub>356 lines</sub><br>[`TesterData`](source/scripts/ServerStorage/TesterData.lua) <sub>304 lines</sub><br>[`Script`](source/scripts/Workspace/AntSimIsShit%3Dtrue/Honey/Base/SurfaceGui/Script.server.lua) <sub>113 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Donations`](source/scripts/ServerScriptService/Server/Donations.lua) <sub>37 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Hives`](source/scripts/ServerScriptService/Server/Hives.lua) <sub>227 lines</sub><br>[`Eggs`](source/scripts/ReplicatedStorage/Modules/Eggs.lua) <sub>78 lines</sub><br>[`FlowerRegisterTEST`](source/scripts/ServerStorage/FlowerRegisterTEST.lua) <sub>436 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub><br>[`Utilities`](source/scripts/ReplicatedStorage/Utilities.lua) <sub>95 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Zone`](source/scripts/ReplicatedStorage/Zone.lua) <sub>876 lines</sub><br>[`ZoneController`](source/scripts/ReplicatedStorage/Zone/ZoneController.lua) <sub>534 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub> |
| Tycoon / plots / bases / building | [`Equipment`](source/scripts/ServerScriptService/Server/Equipment.lua) <sub>298 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub> |
| Admin panels & commands | [`Equipment`](source/scripts/ServerScriptService/Server/Equipment.lua) <sub>298 lines</sub> |
| Sound & music | [`Sounds`](source/scripts/ServerStorage/Sounds.client.lua) <sub>13 lines</sub> |
| Daily rewards, quests, codes, playtime | [`Quests`](source/scripts/ServerScriptService/Server/Quests.lua) <sub>146 lines</sub><br>[`Quests`](source/scripts/ReplicatedStorage/Modules/UI/Quests.lua) <sub>199 lines</sub><br>[`Quests2`](source/scripts/ReplicatedStorage/Modules/UI/Quests2.lua) <sub>337 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/StarterGui/UI/Client.client.lua) <sub>1789 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Utils`](source/scripts/ReplicatedStorage/Modules/Utils.lua) <sub>492 lines</sub><br>[`Utilities`](source/scripts/ReplicatedStorage/Utilities.lua) <sub>95 lines</sub><br>[`Promise`](source/scripts/ServerScriptService/DataStore2/Promise.lua) <sub>672 lines</sub><br>[`Signal`](source/scripts/ReplicatedStorage/Zone/Signal.lua) <sub>178 lines</sub><br>[`Quests`](source/scripts/ReplicatedStorage/Modules/UI/Quests.lua) <sub>199 lines</sub> |

### In the curated script library

- [Clone HUD after game loaded](../../Scripts/04-Loading-Screens/CloneGuiAfterLoad__bee-swarm-sim.lua) — Waits for game.Loaded then clones every ScreenGui from ReplicatedStorage.StarterGui into PlayerGui, so the main UI only appears after loading.
- [Stacking item alerts](../../Scripts/03-Notifications/StackingItemAlerts__bee-swarm-sim.lua) — Item alert feed that merges repeated "+N Item" alerts into one running total instead of spamming new rows, with optional chat system message.
- [Elastic alert feed](../../Scripts/03-Notifications/ElasticAlertFeed__bee-swarm-sim.lua) — Classic bottom-up alert feed: max N rows, elastic slide-in, older alerts pushed up, slow fade out and cleanup.
- [Merging alert stack](../../Scripts/01-UI-Animation/AlertStack_MergingToasts__bee-swarm-sim.lua) — Stacked alerts that grow from 0 size with Back-out, merge repeated item alerts by summing amounts, and shrink away after a lifetime.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/Server/Events.lua`
- `scripts/ServerScriptService/Webhook Testing.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
