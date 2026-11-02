# Pet RNG

> 🎲 **RNG** · RNG / pet rolling · source file `Pet_RNG_Uncopylocked (2).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/05_GUI__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 4 ScreenGuis, 430 GUI objects → **10 screenshots** |
| Models (.rbxm) | 491 models, 60 model sets, 0 VFX sets |
| Lua builders (.lua) | 9 UI screens, 0 animation packs, 1 audio packs |
| Code | 199 scripts, 23,133 lines |
| Asset ids | 29 animations, 7 sounds |
| Safety scan | 4 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×183

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_GUI__Shop.jpg"><img src="screenshots/thumbs/05_GUI__Shop.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Shop</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_GUI__Inventory.jpg"><img src="screenshots/thumbs/04_GUI__Inventory.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Inventory</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_GUI__SpinFrame.jpg"><img src="screenshots/thumbs/10_GUI__SpinFrame.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.SpinFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_GUI__Codes.jpg"><img src="screenshots/thumbs/11_GUI__Codes.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Codes</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_GUI__Settings.jpg"><img src="screenshots/thumbs/12_GUI__Settings.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Settings</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Loading.jpg"><img src="screenshots/thumbs/01_Loading.jpg" width="100%"></a><br><sub><b>Loading</b></sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_GUI__Craft.jpg"><img src="screenshots/thumbs/06_GUI__Craft.jpg" width="100%"></a><br><sub><b>GUI</b> › Frames.Craft</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_GUI.jpg"><img src="screenshots/thumbs/02_GUI.jpg" width="100%"></a><br><sub><b>GUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_GUI__RollFrame.jpg"><img src="screenshots/thumbs/03_GUI__RollFrame.jpg" width="100%"></a><br><sub><b>GUI</b> › RollFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_GUI__RaceNoti.jpg"><img src="screenshots/thumbs/13_GUI__RaceNoti.jpg" width="100%"></a><br><sub><b>GUI</b> › Race UI.RaceNoti</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Pets/Cloud%20King.rbxm"><img src="screenshots/thumbs/models/01_Cloud_King.jpg" width="100%"></a><br><sub><b>Cloud King</b><br><code>models/ReplicatedStorage/Pets/Cloud King.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Boards.rbxm"><img src="screenshots/thumbs/models/02_Boards.jpg" width="100%"></a><br><sub><b>Boards</b><br><code>models/Workspace/Boards.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Main%20Map/Interactions/Epic%20Chest.rbxm"><img src="screenshots/thumbs/models/03_Epic_Chest.jpg" width="100%"></a><br><sub><b>Epic Chest</b><br><code>models/Workspace/Main Map/Interactions/Epic Chest.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Cave%20Map/Crystal%20Pack__x23.rbxm"><img src="screenshots/thumbs/models/04_Crystal_Pack_x23.jpg" width="100%"></a><br><sub><b>Crystal Pack__x23</b><br><code>models/Workspace/Cave Map/Crystal Pack__x23.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/ChristmasLights.rbxm"><img src="screenshots/thumbs/models/06_ChristmasLights.jpg" width="100%"></a><br><sub><b>ChristmasLights</b><br><code>models/Workspace/ChristmasLights.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Meshes_portallbs123_Plane.005.rbxm"><img src="screenshots/thumbs/models/07_Meshes_portallbs123_Plane_005.jpg" width="100%"></a><br><sub><b>Meshes_portallbs123_Plane.005</b><br><code>models/Workspace/Meshes_portallbs123_Plane.005.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/CavePortal.rbxm"><img src="screenshots/thumbs/models/08_CavePortal.jpg" width="100%"></a><br><sub><b>CavePortal</b><br><code>models/Workspace/CavePortal.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Pets/Watermelon%20Demon.rbxm"><img src="screenshots/thumbs/models/10_Watermelon_Demon.jpg" width="100%"></a><br><sub><b>Watermelon Demon</b><br><code>models/ReplicatedStorage/Pets/Watermelon Demon.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Boards~2.rbxm"><img src="screenshots/thumbs/models/11_Boards_2.jpg" width="100%"></a><br><sub><b>Boards~2</b><br><code>models/Workspace/Boards~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Main%20Map/Trees/Model.rbxm"><img src="screenshots/thumbs/models/12_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Main Map/Trees/Model.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Meshes_portallbs123_Plane.005~2.rbxm"><img src="screenshots/thumbs/models/14_Meshes_portallbs123_Plane_005_2.jpg" width="100%"></a><br><sub><b>Meshes_portallbs123_Plane.005~2</b><br><code>models/Workspace/Meshes_portallbs123_Plane.005~2.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`ButtonAnimations`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/ButtonAnimations.client.lua) <sub>102 lines</sub><br>[`UiModule`](source/scripts/ReplicatedStorage/Engine/Modules/UiModule.lua) <sub>101 lines</sub><br>[`Transition`](source/scripts/ReplicatedStorage/Engine/Modules/Transition.lua) <sub>36 lines</sub><br>[`RollHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/RollHandler.client.lua) <sub>275 lines</sub><br>[`NotificationModule`](source/scripts/ReplicatedStorage/Engine/Modules/NotificationModule.lua) <sub>45 lines</sub> |
| UI controllers / window managers / menus | [`SoftShutdownUI`](source/scripts/ServerScriptService/QuentySoftShutdown/src/Client/SoftShutdownUI.lua) <sub>247 lines</sub><br>[`RollHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/RollHandler.client.lua) <sub>275 lines</sub><br>[`ToggleUI`](source/scripts/ReplicatedStorage/Engine/Modules/ToggleUI.lua) <sub>30 lines</sub><br>[`ButtonAnimations`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/ButtonAnimations.client.lua) <sub>102 lines</sub> |
| Notifications, toasts, popups, prompts | [`NotificationModule`](source/scripts/ReplicatedStorage/Engine/Modules/NotificationModule.lua) <sub>45 lines</sub><br>[`Luck`](source/scripts/ReplicatedStorage/Engine/Modules/Luck.lua) <sub>365 lines</sub><br>[`Gift`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/Gift.client.lua) <sub>126 lines</sub><br>[`CraftSystem`](source/scripts/ReplicatedStorage/Engine/Modules/CraftSystem.lua) <sub>363 lines</sub><br>[`TeleportHandler`](source/scripts/ServerScriptService/Engine/Scripts/TeleportHandler.server.lua) <sub>106 lines</sub> |
| Loading / intro screens | [`LoadingClient`](source/scripts/ReplicatedFirst/LoadingClient.client.lua) <sub>60 lines</sub> |
| DataStore / player data | [`DataManager`](source/scripts/ServerScriptService/Engine/Scripts/Data/DataManager.lua) <sub>61 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Shop`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/Shop.client.lua) <sub>43 lines</sub><br>[`RollHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/RollHandler.client.lua) <sub>275 lines</sub><br>[`Gift`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/Gift.client.lua) <sub>126 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`RollHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/RollHandler.client.lua) <sub>275 lines</sub><br>[`RollHandler`](source/scripts/ServerScriptService/Engine/Scripts/RollHandler.server.lua) <sub>75 lines</sub><br>[`Roll`](source/scripts/ReplicatedStorage/Engine/Modules/Roll.lua) <sub>24 lines</sub><br>[`Pets`](source/scripts/ReplicatedStorage/DataModules/Pets.lua) <sub>60 lines</sub><br>[`PetSystem`](source/scripts/ReplicatedStorage/Engine/Modules/PetSystem.lua) <sub>169 lines</sub> |
| Leaderboards & stats | [`Leaderstats`](source/scripts/ServerScriptService/Engine/Scripts/Data/DataManager/Leaderstats.lua) <sub>20 lines</sub> |
| Daily rewards, quests, codes, playtime | [`Codes`](source/scripts/StarterPlayer/StarterPlayerScripts/Engine/UI/Codes.client.lua) <sub>61 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`AbbreviateModule`](source/scripts/ReplicatedStorage/Engine/Modules/AbbreviateModule.lua) <sub>68 lines</sub><br>[`PetSystem`](source/scripts/ReplicatedStorage/Engine/Modules/PetSystem.lua) <sub>169 lines</sub><br>[`Abbreviate2`](source/scripts/ReplicatedStorage/Engine/Modules/Abbreviate2.lua) <sub>95 lines</sub><br>[`Handler`](source/scripts/ServerScriptService/Engine/Scripts/LeaderboardHandler/Handler.lua) <sub>47 lines</sub> |

### In the curated script library

- [Minimal ProfileService setup](../../Scripts/07-Data-Saving/DataManager-ProfileService-Minimal__pet-rng.lua) — The shortest correct ProfileService setup: LoadProfileAsync, AddUserId, Reconcile, ListenToRelease kick, release on leave, handle players already in game.
- [Preload progress bar with Skip](../../Scripts/04-Loading-Screens/PreloadProgressWithSkip__pet-rng.lua) — Clones a prepared Loading ScreenGui, preloads every descendant of game one by one, updates a % label and tweened bar, offers a Skip button, plays a sound when finished.
- [Minimal weighted roll](../../Scripts/09-RNG-Gacha-Pets/WeightedRoll__pet-rng.lua) — Smallest possible weighted pick: sum the weights, draw math.random()*total, walk the list until the running sum passes the draw.
- [Pet weight table (1-in-N odds)](../../Scripts/09-RNG-Gacha-Pets/PetRarityTable__pet-rng.lua) — Pet data table where each pet has a raw weight; the game shows odds as 1/(total/weight). Shows how RNG games go from 1/2 to 1/10,000,000+ by dividing tiny weights.
- [Roll reveal UI + auto-roll (client)](../../Scripts/09-RNG-Gacha-Pets/RollAnimationAutoRoll__pet-rng.lua) — Client roll button: flashes 4 fake results then the real one in a viewport, auto-roll gamepass toggle, luck applied by multiplying rare weights. WARNING: the roll happens on the client and the server trusts the pet name.
- [Rare-roll global announcement + badges](../../Scripts/09-RNG-Gacha-Pets/RollServerAnnounceBadges__pet-rng.lua) — Server side of the roll: converts weight to '1/N', awards badges at 1/100, 1/1000 ... and broadcasts very rare rolls to every server through MessagingService.
- [Pet follow with AlignPosition](../../Scripts/09-RNG-Gacha-Pets/PetFollowAlignPosition__pet-rng.lua) — Equips a pet model that follows the player using Attachment + AlignPosition/AlignOrientation, with a bobbing tween that changes speed while the player walks.
- [Simple hover/press module](../../Scripts/01-UI-Animation/ButtonHoverPressSize__pet-rng.lua) — Simple Size-based hover (1.1x) / press (0.8x) module with hover+click sounds, random icon tilt on hover, and keyboard-key press animation.
- [Screen transition + typewriter title](../../Scripts/01-UI-Animation/TransitionTypewriterFade__pet-rng.lua) — Teleport transition: fades a full-screen frame in, tweens MaxVisibleGraphemes for a typewriter title, moves the character, then fades everything out.
- [RNG roll reveal](../../Scripts/01-UI-Animation/RollHandler_RNGReveal__pet-rng.lua) — RNG roll display: flashes 4 random results with a tiny shake, then the real one with rarity colour, "1/N" chance and an expanding ring; auto-roll loop.
- [Hide/show HUD groups](../../Scripts/02-UI-Framework/HudHideShow__pet-rng.lua) — Slides the left, right and bottom HUD groups off-screen and back.
- [Side buttons toggle frames](../../Scripts/02-UI-Framework/SideButtonsAndFrames__pet-rng.lua) — Side buttons slide on hover and toggle the same-named frame; close buttons wired on every frame.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/Boards/AssetLoader.server.lua`
- `scripts/Workspace/Boards/R15Loader/Loader.server.lua`
- `scripts/Workspace/Boards~2/AssetLoader.server.lua`
- `scripts/Workspace/Boards~2/R15Loader/Loader.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
