# PLS DONATE (fully scripted)

> 💬 **Social** · social / donation booths · source file `Please Donate Fully Scripted.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/10_ScreenGui__GameShop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 4 ScreenGuis, 409 GUI objects → **27 screenshots** |
| Models (.rbxm) | 285 models, 29 model sets, 15 VFX sets |
| Lua builders (.lua) | 49 UI screens, 10 animation packs, 2 audio packs |
| Code | 452 scripts, 53,843 lines |
| Asset ids | 29 animations, 287 sounds |
| Safety scan | 2 HIGH / 77 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Heavy`×75, `GothamSSm Bold`×40, `LegacyArial Regular`×23, `SourceSansPro Regular`×9, `GothamSSm Medium`×9

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_ScreenGui__GameShop.jpg"><img src="screenshots/thumbs/10_ScreenGui__GameShop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › GameShop</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_ScreenGui__ItemsInbox.jpg"><img src="screenshots/thumbs/14_ScreenGui__ItemsInbox.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › ItemsInbox</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_ItemTemplate.jpg"><img src="screenshots/thumbs/28_ItemTemplate.jpg" width="100%"></a><br><sub><b>ItemTemplate</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_ScreenGui__GiftInbox.jpg"><img src="screenshots/thumbs/03_ScreenGui__GiftInbox.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › GiftInbox</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_ScreenGui__EditWheel.jpg"><img src="screenshots/thumbs/04_ScreenGui__EditWheel.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › EditWheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_ScreenGui__Gift.jpg"><img src="screenshots/thumbs/06_ScreenGui__Gift.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Gift</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_ScreenGui__Streaks.jpg"><img src="screenshots/thumbs/08_ScreenGui__Streaks.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Streaks</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_ScreenGui__GiftAlert.jpg"><img src="screenshots/thumbs/17_ScreenGui__GiftAlert.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › GiftAlert</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_ScreenGui__RedeemCode.jpg"><img src="screenshots/thumbs/18_ScreenGui__RedeemCode.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › RedeemCode</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_ScreenGui__Settings.jpg"><img src="screenshots/thumbs/11_ScreenGui__Settings.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_ScreenGui__BoothSettings.jpg"><img src="screenshots/thumbs/16_ScreenGui__BoothSettings.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › BoothSettings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_ScreenGui__PopupAlert.jpg"><img src="screenshots/thumbs/07_ScreenGui__PopupAlert.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › PopupAlert</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_TeleportLoadingScreen.jpg"><img src="screenshots/thumbs/27_TeleportLoadingScreen.jpg" width="100%"></a><br><sub><b>TeleportLoadingScreen</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_ScreenGui__PanelPicker.jpg"><img src="screenshots/thumbs/05_ScreenGui__PanelPicker.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › PanelPicker</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_ScreenGui.jpg"><img src="screenshots/thumbs/01_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_ScreenGui__EditBooth.jpg"><img src="screenshots/thumbs/02_ScreenGui__EditBooth.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › EditBooth</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_ScreenGui__Tutorial.jpg"><img src="screenshots/thumbs/09_ScreenGui__Tutorial.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Tutorial</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_ScreenGui__EditSign.jpg"><img src="screenshots/thumbs/12_ScreenGui__EditSign.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › EditSign</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_ScreenGui__BoothStatistics.jpg"><img src="screenshots/thumbs/13_ScreenGui__BoothStatistics.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › BoothStatistics</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_ScreenGui__ChangeMusic.jpg"><img src="screenshots/thumbs/15_ScreenGui__ChangeMusic.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › ChangeMusic</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_10k.jpg"><img src="screenshots/thumbs/19_10k.jpg" width="100%"></a><br><sub><b>10k</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_1k.jpg"><img src="screenshots/thumbs/20_1k.jpg" width="100%"></a><br><sub><b>1k</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_100.jpg"><img src="screenshots/thumbs/21_100.jpg" width="100%"></a><br><sub><b>100</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_NormalDonation.jpg"><img src="screenshots/thumbs/22_NormalDonation.jpg" width="100%"></a><br><sub><b>NormalDonation</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_Template.jpg"><img src="screenshots/thumbs/23_Template.jpg" width="100%"></a><br><sub><b>Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_lol.jpg"><img src="screenshots/thumbs/25_lol.jpg" width="100%"></a><br><sub><b>lol</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_New.jpg"><img src="screenshots/thumbs/26_New.jpg" width="100%"></a><br><sub><b>New</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/starclonebooth.rbxm"><img src="screenshots/thumbs/models/01_starclonebooth.jpg" width="100%"></a><br><sub><b>starclonebooth</b><br><code>models/ServerStorage/BoothModels/starclonebooth.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/RacingCarBooth.rbxm"><img src="screenshots/thumbs/models/02_RacingCarBooth.jpg" width="100%"></a><br><sub><b>RacingCarBooth</b><br><code>models/ServerStorage/BoothModels/RacingCarBooth.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/HalloweenCandyBooth.rbxm"><img src="screenshots/thumbs/models/03_HalloweenCandyBooth.jpg" width="100%"></a><br><sub><b>HalloweenCandyBooth</b><br><code>models/ServerStorage/BoothModels/HalloweenCandyBooth.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/CatalogAvatarCreatorBooth.rbxm"><img src="screenshots/thumbs/models/04_CatalogAvatarCreatorBooth.jpg" width="100%"></a><br><sub><b>CatalogAvatarCreatorBooth</b><br><code>models/ServerStorage/BoothModels/CatalogAvatarCreatorBooth.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/NukePlatform.rbxm"><img src="screenshots/thumbs/models/05_NukePlatform.jpg" width="100%"></a><br><sub><b>NukePlatform</b><br><code>models/Workspace/NukePlatform.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/FlowerBooth.rbxm"><img src="screenshots/thumbs/models/06_FlowerBooth.jpg" width="100%"></a><br><sub><b>FlowerBooth</b><br><code>models/ServerStorage/BoothModels/FlowerBooth.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Club/Decoration/Plant/Plant__x22.rbxm"><img src="screenshots/thumbs/models/07_Plant_x22.jpg" width="100%"></a><br><sub><b>Plant__x22</b><br><code>models/Workspace/Club/Decoration/Plant/Plant__x22.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Tools/BoosterHammer.rbxm"><img src="screenshots/thumbs/models/08_BoosterHammer.jpg" width="100%"></a><br><sub><b>BoosterHammer</b><br><code>models/ServerStorage/Tools/BoosterHammer.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/PetSimXBooth.rbxm"><img src="screenshots/thumbs/models/09_PetSimXBooth.jpg" width="100%"></a><br><sub><b>PetSimXBooth</b><br><code>models/ServerStorage/BoothModels/PetSimXBooth.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/OfflineMap/Tree__x13.rbxm"><img src="screenshots/thumbs/models/10_Tree_x13.jpg" width="100%"></a><br><sub><b>Tree__x13</b><br><code>models/ReplicatedStorage/OfflineMap/Tree__x13.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Tools/DonateSign.rbxm"><img src="screenshots/thumbs/models/11_DonateSign.jpg" width="100%"></a><br><sub><b>DonateSign</b><br><code>models/ServerStorage/Tools/DonateSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/ForwardPortal.rbxm"><img src="screenshots/thumbs/models/12_ForwardPortal.jpg" width="100%"></a><br><sub><b>ForwardPortal</b><br><code>models/Workspace/ForwardPortal.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Map/Billboards/Billboard.rbxm"><img src="screenshots/thumbs/models/13_Billboard.jpg" width="100%"></a><br><sub><b>Billboard</b><br><code>models/Workspace/Map/Billboards/Billboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/BoothModels/haz3mnsbooth.rbxm"><img src="screenshots/thumbs/models/14_haz3mnsbooth.jpg" width="100%"></a><br><sub><b>haz3mnsbooth</b><br><code>models/ServerStorage/BoothModels/haz3mnsbooth.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Client`](source/scripts/StarterPlayer/StarterPlayerScripts/Client.client.lua) <sub>89 lines</sub><br>[`main`](source/scripts/StarterGui/ScreenGui/main.client.lua) <sub>480 lines</sub><br>[`Animation`](source/scripts/ReplicatedStorage/Templates/UnclaimedTemplateNew/Animation.client.lua) <sub>45 lines</sub><br>[`Animation`](source/scripts/ServerStorage/ExampleGifts/New/Animation.client.lua) <sub>45 lines</sub><br>[`nuke`](source/scripts/StarterGui/ScreenGui/nuke.client.lua) <sub>304 lines</sub> |
| UI controllers / window managers / menus | [`main`](source/scripts/StarterGui/ScreenGui/main.client.lua) <sub>480 lines</sub><br>[`Guis`](source/scripts/ReplicatedStorage/Modules/Guis.lua) <sub>93 lines</sub> |
| Notifications, toasts, popups, prompts | [`ProximityPromptScript`](source/scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua) <sub>499 lines</sub><br>[`Guis`](source/scripts/ReplicatedStorage/Modules/Guis.lua) <sub>93 lines</sub><br>[`Purchases`](source/scripts/ServerScriptService/Donation/Purchases.server.lua) <sub>226 lines</sub><br>[`main`](source/scripts/StarterGui/ScreenGui/main.client.lua) <sub>480 lines</sub><br>[`Client`](source/scripts/StarterPlayer/StarterPlayerScripts/Client.client.lua) <sub>89 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraShaker`](source/scripts/StarterGui/ScreenGui/nuke/CameraShaker.lua) <sub>208 lines</sub><br>[`CameraShakeInstance`](source/scripts/StarterGui/ScreenGui/nuke/CameraShaker/CameraShakeInstance.lua) <sub>168 lines</sub><br>[`CameraShakePresets`](source/scripts/StarterGui/ScreenGui/nuke/CameraShaker/CameraShakePresets.lua) <sub>105 lines</sub><br>[`main`](source/scripts/StarterGui/ScreenGui/main.client.lua) <sub>480 lines</sub><br>[`nuke`](source/scripts/StarterGui/ScreenGui/nuke.client.lua) <sub>304 lines</sub> |
| VFX, particles, beams, hit effects | [`smiteasf`](source/scripts/StarterGui/ScreenGui/smiteasf.client.lua) <sub>627 lines</sub><br>[`Effects`](source/scripts/ServerScriptService/Donation/Effects.server.lua) <sub>104 lines</sub><br>[`nuke`](source/scripts/StarterGui/ScreenGui/nuke.client.lua) <sub>304 lines</sub><br>[`MainToolFunction`](source/scripts/ServerStorage/Tools/BoosterHammer/MainToolFunction.server.lua) <sub>185 lines</sub><br>[`MainToolFunction`](source/scripts/ServerStorage/Tools/BugHammer/MainToolFunction.server.lua) <sub>162 lines</sub> |
| DataStore / player data | [`PlayerEvents`](source/scripts/ServerScriptService/Players/PlayerEvents.server.lua) <sub>67 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Purchases`](source/scripts/ServerScriptService/Donation/Purchases.server.lua) <sub>226 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`SpeedScriptRunner`](source/scripts/StarterPlayer/StarterPlayerScripts/SpeedScriptRunner.client.lua) <sub>59 lines</sub> |
| Tycoon / plots / bases / building | [`BoothEvents`](source/scripts/ServerScriptService/Booths/BoothEvents.server.lua) <sub>254 lines</sub><br>[`Purchases`](source/scripts/ServerScriptService/Donation/Purchases.server.lua) <sub>226 lines</sub> |
| Admin panels & commands | [`Commands`](source/scripts/Workspace/HD%20Admin~2/CustomFeatures/Server/Modules/Commands.lua) <sub>72 lines</sub><br>[`Settings`](source/scripts/Workspace/HD%20Admin~2/Settings.lua) <sub>226 lines</sub> |
| Sound & music | [`smiteasf`](source/scripts/StarterGui/ScreenGui/smiteasf.client.lua) <sub>627 lines</sub> |
| Daily rewards, quests, codes, playtime | [`Codes`](source/scripts/ServerScriptService/Players/Codes.server.lua) <sub>52 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Abbreviate`](source/scripts/ReplicatedStorage/Modules/Abbreviate.lua) <sub>106 lines</sub><br>[`createSignal`](source/scripts/ReplicatedStorage/Common/Roact/createSignal.lua) <sub>69 lines</sub><br>[`createSignal.spec`](source/scripts/ReplicatedStorage/Common/Roact/createSignal.spec.lua) <sub>155 lines</sub><br>[`RobloxRenderer`](source/scripts/ReplicatedStorage/Common/Roact/RobloxRenderer.lua) <sub>283 lines</sub> |

### In the curated script library

- [GUI helpers (open frame + FOV)](../../Scripts/02-UI-Framework/GuiHelpers__please-donate.lua) — Open a frame with slide and FOV tween while closing others, loading overlay, text popups, alert.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/HD Admin/Settings/Loader.server.lua`
- `scripts/Workspace/HD Admin~2/Settings/Loader.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
