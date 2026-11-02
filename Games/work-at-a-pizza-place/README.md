# Work at a Pizza Place

> 🏙️ **Roleplay** · roleplay / job simulator · source file `Work_at_a_pizza_place.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/10_MainGui__CustomizePet.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 2 ScreenGuis, 1242 GUI objects → **29 screenshots** |
| Models (.rbxm) | 539 models, 30 model sets, 3 VFX sets |
| Lua builders (.lua) | 7 UI screens, 1 animation packs, 5 audio packs |
| Code | 438 scripts, 56,367 lines |
| Asset ids | 69 animations, 91 sounds |
| Safety scan | 3 HIGH / 9 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `LegacyArial Regular`×248, `SourceSansPro Regular`×217, `SourceSansPro Bold`×63, `Arial Bold`×56, `ComicNeueAngular Regular`×5

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_MainGui__Inventory.jpg"><img src="screenshots/thumbs/03_MainGui__Inventory.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Inventory</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_MainGui__PetPanel.jpg"><img src="screenshots/thumbs/09_MainGui__PetPanel.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Pet.PetPanel</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_MainGui__CustomizePet.jpg"><img src="screenshots/thumbs/10_MainGui__CustomizePet.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Pet.CustomizePet</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_MainGui__PetHats.jpg"><img src="screenshots/thumbs/11_MainGui__PetHats.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Pet.PetHats</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MainGui__Catalog.jpg"><img src="screenshots/thumbs/02_MainGui__Catalog.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Catalog</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_MainGui__Upgrade.jpg"><img src="screenshots/thumbs/08_MainGui__Upgrade.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Upgrade</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_MainGui__Manage.jpg"><img src="screenshots/thumbs/04_MainGui__Manage.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Manage</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_MainGui__GamepadMainMenu.jpg"><img src="screenshots/thumbs/05_MainGui__GamepadMainMenu.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.GamepadMainMenu</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_MainGui__Settings.jpg"><img src="screenshots/thumbs/06_MainGui__Settings.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Settings</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_MainGui__Ratings.jpg"><img src="screenshots/thumbs/07_MainGui__Ratings.jpg" width="100%"></a><br><sub><b>MainGui</b> › Menu.Ratings</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_MainGui__FoodMenu.jpg"><img src="screenshots/thumbs/14_MainGui__FoodMenu.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.FoodMenu</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_ChooseJob__Play.jpg"><img src="screenshots/thumbs/26_ChooseJob__Play.jpg" width="100%"></a><br><sub><b>ChooseJob</b> › Play</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_MainGui__Ban.jpg"><img src="screenshots/thumbs/12_MainGui__Ban.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.Ban</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_MainGui__DialogBox.jpg"><img src="screenshots/thumbs/13_MainGui__DialogBox.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.DialogBox</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_MainGui__GetId.jpg"><img src="screenshots/thumbs/15_MainGui__GetId.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.GetId</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_MainGui__GetName.jpg"><img src="screenshots/thumbs/16_MainGui__GetName.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.GetName</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_MainGui__GetRating.jpg"><img src="screenshots/thumbs/17_MainGui__GetRating.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.GetRating</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_MainGui__GetShortString.jpg"><img src="screenshots/thumbs/18_MainGui__GetShortString.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.GetShortString</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_MainGui__GetString.jpg"><img src="screenshots/thumbs/19_MainGui__GetString.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.GetString</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_MainGui__Paycheck.jpg"><img src="screenshots/thumbs/20_MainGui__Paycheck.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.Paycheck</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_MainGui__PixelPaint.jpg"><img src="screenshots/thumbs/21_MainGui__PixelPaint.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.PixelPaint</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_MainGui__KickList.jpg"><img src="screenshots/thumbs/23_MainGui__KickList.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.KickList</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_MainGui__Tutorial.jpg"><img src="screenshots/thumbs/24_MainGui__Tutorial.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.TutorialContainer.Tutorial</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_MainGui__ResponsePanel.jpg"><img src="screenshots/thumbs/22_MainGui__ResponsePanel.jpg" width="100%"></a><br><sub><b>MainGui</b> › Prompts.CustomerDialog.ResponsePanel</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainGui.jpg"><img src="screenshots/thumbs/01_MainGui.jpg" width="100%"></a><br><sub><b>MainGui</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_ChooseJob__ChooseJob.jpg"><img src="screenshots/thumbs/25_ChooseJob__ChooseJob.jpg" width="100%"></a><br><sub><b>ChooseJob</b> › ChooseJob</sub></td>
<td width="33%" valign="top"><a href="screenshots/27_SprayGui.jpg"><img src="screenshots/thumbs/27_SprayGui.jpg" width="100%"></a><br><sub><b>SprayGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_PlatformerGui.jpg"><img src="screenshots/thumbs/28_PlatformerGui.jpg" width="100%"></a><br><sub><b>PlatformerGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_PlatformerGui__ScorePage.jpg"><img src="screenshots/thumbs/29_PlatformerGui__ScorePage.jpg" width="100%"></a><br><sub><b>PlatformerGui</b> › GameFrame.ScorePage</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Oakley.rbxm"><img src="screenshots/thumbs/models/01_Oakley.jpg" width="100%"></a><br><sub><b>Oakley</b><br><code>models/Workspace/Oakley.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/PetObjects/Ball.rbxm"><img src="screenshots/thumbs/models/02_Ball.jpg" width="100%"></a><br><sub><b>Ball</b><br><code>models/ServerStorage/PetObjects/Ball.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/DeliveryBike.rbxm"><img src="screenshots/thumbs/models/03_DeliveryBike.jpg" width="100%"></a><br><sub><b>DeliveryBike</b><br><code>models/ServerStorage/DeliveryBike.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Candy/Hershey.rbxm"><img src="screenshots/thumbs/models/04_Hershey.jpg" width="100%"></a><br><sub><b>Hershey</b><br><code>models/ServerStorage/Candy/Hershey.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/MainModule/Decoration/Outdoors%20Tree.rbxm"><img src="screenshots/thumbs/models/05_Outdoors_Tree.jpg" width="100%"></a><br><sub><b>Outdoors Tree</b><br><code>models/ServerScriptService/MainModule/Decoration/Outdoors Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Cloud.rbxm"><img src="screenshots/thumbs/models/06_Cloud.jpg" width="100%"></a><br><sub><b>Cloud</b><br><code>models/Workspace/Cloud.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/GuestOutfits/Girl/LongHairHeadBand.rbxm"><img src="screenshots/thumbs/models/07_LongHairHeadBand.jpg" width="100%"></a><br><sub><b>LongHairHeadBand</b><br><code>models/ServerStorage/GuestOutfits/Girl/LongHairHeadBand.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/NewHouse.rbxm"><img src="screenshots/thumbs/models/09_NewHouse.jpg" width="100%"></a><br><sub><b>NewHouse</b><br><code>models/ServerStorage/NewHouse.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Ceatar%20Trees/Model.rbxm"><img src="screenshots/thumbs/models/10_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/ServerStorage/Ceatar Trees/Model.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/MainModule/Entertainment/Workout%20Treadmill.rbxm"><img src="screenshots/thumbs/models/11_Workout_Treadmill.jpg" width="100%"></a><br><sub><b>Workout Treadmill</b><br><code>models/ServerScriptService/MainModule/Entertainment/Workout Treadmill.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Sign~2.rbxm"><img src="screenshots/thumbs/models/12_Sign_2.jpg" width="100%"></a><br><sub><b>Sign~2</b><br><code>models/Workspace/Sign~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Seating/Chair__x22.rbxm"><img src="screenshots/thumbs/models/14_Chair_x22.jpg" width="100%"></a><br><sub><b>Chair__x22</b><br><code>models/Workspace/Seating/Chair__x22.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI controllers / window managers / menus | [`DropdownMenu`](source/scripts/StarterGui/GuiManager/DropdownMenu.lua) <sub>144 lines</sub><br>[`Door`](source/scripts/ServerScriptService/Door.lua) <sub>261 lines</sub><br>[`GuiManager`](source/scripts/StarterGui/GuiManager.lua) <sub>229 lines</sub><br>[`ChatWindow`](source/scripts/StarterGui/MainGui/Menu/ChatWindow/ChatWindow.client.lua) <sub>529 lines</sub><br>[`Window`](source/scripts/StarterGui/GuiManager/Window.lua) <sub>488 lines</sub> |
| Notifications, toasts, popups, prompts | [`PurchaseService`](source/scripts/ServerScriptService/PurchaseService.server.lua) <sub>577 lines</sub><br>[`Glider_LocalMain`](source/scripts/ServerStorage/HangGlider/Glider_LocalMain.client.lua) <sub>296 lines</sub><br>[`ChatWindow`](source/scripts/StarterGui/MainGui/Menu/ChatWindow/ChatWindow.client.lua) <sub>529 lines</sub><br>[`PetPanel`](source/scripts/StarterGui/MainGui/Menu/Pet/PetPanel/PetPanel.client.lua) <sub>880 lines</sub><br>[`Dialog`](source/scripts/StarterGui/MainGui/Prompts/DialogBox/Dialog.client.lua) <sub>154 lines</sub> |
| Loading / intro screens | [`ReplicatedFirst`](source/scripts/ReplicatedStorage/ReplicatedFirst.client.lua) <sub>135 lines</sub><br>[`SoundFX`](source/scripts/ReplicatedStorage/SoundFX.lua) <sub>114 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraUtil`](source/scripts/ReplicatedStorage/Utilities/CameraUtil.lua) <sub>138 lines</sub><br>[`VehicleCamera`](source/scripts/StarterPlayer/StarterPlayerScripts/VehicleCamera.client.lua) <sub>272 lines</sub><br>[`Upgrade`](source/scripts/StarterGui/MainGui/Menu/Upgrade/Upgrade.client.lua) <sub>378 lines</sub><br>[`LocalMain`](source/scripts/StarterPlayer/StarterPlayerScripts/LocalMain.client.lua) <sub>182 lines</sub> |
| DataStore / player data | [`Players`](source/scripts/ServerScriptService/Players.lua) <sub>442 lines</sub><br>[`PetController`](source/scripts/ServerScriptService/PetController.server.lua) <sub>534 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`PurchaseService`](source/scripts/ServerScriptService/PurchaseService.server.lua) <sub>577 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`PetController`](source/scripts/ServerScriptService/PetController.server.lua) <sub>534 lines</sub><br>[`PetHats`](source/scripts/StarterGui/MainGui/Menu/Pet/PetHats/PetHats.client.lua) <sub>206 lines</sub><br>[`PurchaseService`](source/scripts/ServerScriptService/PurchaseService.server.lua) <sub>577 lines</sub><br>[`Script`](source/scripts/Workspace/Carpet/RainbowMagicCarpet/Script.server.lua) <sub>368 lines</sub><br>[`Enums`](source/scripts/ReplicatedStorage/Enums.lua) <sub>383 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Slider`](source/scripts/StarterGui/GuiManager/Slider.lua) <sub>252 lines</sub><br>[`Climbing`](source/scripts/Workspace/Sign~6/Truss/Climbing.server.lua) <sub>27 lines</sub><br>[`CustomAnimation`](source/scripts/StarterPlayer/StarterCharacterScripts/CustomAnimation.client.lua) <sub>466 lines</sub><br>[`GuiManager`](source/scripts/StarterGui/GuiManager.lua) <sub>229 lines</sub><br>[`LocalSound`](source/scripts/StarterPlayer/StarterCharacterScripts/Sound/LocalSound.client.lua) <sub>357 lines</sub> |
| Tycoon / plots / bases / building | [`House`](source/scripts/ServerScriptService/Houses/House.lua) <sub>835 lines</sub><br>[`FurnitureDragger`](source/scripts/StarterPlayer/StarterPlayerScripts/FurnitureDragger.client.lua) <sub>676 lines</sub><br>[`MainModule`](source/scripts/ServerScriptService/MainModule.lua) <sub>758 lines</sub><br>[`Furniture`](source/scripts/ServerScriptService/Houses/House/Furniture.lua) <sub>382 lines</sub> |
| Sound & music | [`LocalSound`](source/scripts/StarterPlayer/StarterCharacterScripts/Sound/LocalSound.client.lua) <sub>357 lines</sub><br>[`Music`](source/scripts/StarterPlayer/StarterPlayerScripts/Music.client.lua) <sub>285 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Utility`](source/scripts/ReplicatedStorage/Utilities/Utility.lua) <sub>663 lines</sub><br>[`Customer`](source/scripts/ServerScriptService/Customers/Customer.lua) <sub>915 lines</sub> |

### In the curated script library

- [Orbit pan camera](../../Scripts/05-Camera-Cutscene/OrbitPanCamera__work-at-a-pizza-place.lua) — Orbiting showcase camera with simple wall collision (repeated raycasts ignoring see-through parts).
- [Minimal spinning-icon loader](../../Scripts/04-Loading-Screens/SpinningPizzaLoader__work-at-a-pizza-place.lua) — Minimal ReplicatedFirst loader: parents a prepared LoadingScreen, spins pizza icons on RenderStepped, waits for game:IsLoaded(); commented-out code shows a RequestQueueSize-driven reveal and an asset-id dump helper.
- [Classic PurchaseHistory DataStore](../../Scripts/08-Monetization/ProcessReceipt-PurchaseHistory__work-at-a-pizza-place.lua) — The classic pattern: a PurchaseHistory DataStore keyed 'userId:purchaseId' checked before granting, a handler table keyed by product id, pcall'd handlers, and the purchase recorded after success.
- [Server-or-client dialog service](../../Scripts/03-Notifications/DialogService__work-at-a-pizza-place.lua) — Shared Dialog module usable from server or client: GetChoice yields for the player's yes/no answer (per-player queue, 60s timeout), ShowMessage / ShowMessageAll for one-button messages.
- [Dialog box client (PC + gamepad)](../../Scripts/03-Notifications/DialogBoxClient__work-at-a-pizza-place.lua) — Client side of the pizza-place dialog: queues dialogs, fills title/message/button texts, swaps to A/B gamepad buttons on console, sends the choice back.
- [Clickable-bubble NPC conversation (client)](../../Scripts/12-NPC-AI/CustomerNPCDialog__work-at-a-pizza-place.lua) — Speech bubbles over NPC heads that start a server-driven conversation; server sends choices, client shows up to 5 response buttons, ends the chat if the player walks more than 30 studs away or another player is already talking to that NPC; gamepad support.
- [Location and time-of-day music](../../Scripts/17-Sound-Music/ZoneLocationMusic__work-at-a-pizza-place.lua) — Location-aware music: chooses a track by season/holiday/time of day, switches to house music players or shop songs when the player enters a zone, fades out and in between tracks and resumes the outdoor song where it left off. Volume comes from a settings slider.
- [Client/server SoundFX with zone broadcast](../../Scripts/17-Sound-Music/SoundFX__work-at-a-pizza-place.lua) — Shared client/server sound helper: on the client plays a named sound from a folder; on the server either tells one client to play it or plays it on an object; PlaySoundInsideZone sends a sound only to players standing inside a zone box.
- [House furniture placement in local space](../../Scripts/14-Tycoon-Plots/FurniturePlacement__work-at-a-pizza-place.lua) — Server side of placing furniture in a player house: enforces a per-upgrade furniture cap, removes one from inventory, and stores the CFrame relative to the house's Marker part (ToObjectSpace) so...
- [GuiManager widget framework](../../Scripts/02-UI-Framework/GuiManager__work-at-a-pizza-place.lua) — Registers windows and widgets (tabs, sliders, toggles, dropdowns, lists, radial menu) and closes all windows.
- [Gamepad-aware Window class](../../Scripts/02-UI-Framework/Window__work-at-a-pizza-place.lua) — Tweened show/hide, blur, cancel/B to close, per-window gamepad actions and selection focus.
- [TabGroup class](../../Scripts/02-UI-Framework/TabGroup__work-at-a-pizza-place.lua) — Keeps one tab pressed, fires TabChanged, cycles tabs with L1/R1.
- [Tab button class](../../Scripts/02-UI-Framework/Tab__work-at-a-pizza-place.lua) — Single tab button used by TabGroup with pressed/unpressed styles.
- [Dropdown menu widget](../../Scripts/02-UI-Framework/DropdownMenu__work-at-a-pizza-place.lua) — Expandable option list that fires opened/selected events.
- [Gamepad radial menu](../../Scripts/02-UI-Framework/RadialMenu__work-at-a-pizza-place.lua) — Picks one of six wedges from the thumbstick angle.
- [Slider widget](../../Scripts/02-UI-Framework/Slider__work-at-a-pizza-place.lua) — Draggable 0-1 slider for mouse, touch and gamepad.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/GoogleAnalytics.lua`
- `scripts/ServerScriptService/Main.server.lua`
- `scripts/Workspace/HD Admin/Settings/Loader.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
