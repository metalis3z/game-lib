# Retro Studio

> 🧱 **Sandbox** · retro sandbox (2008-style UI, bevels) · source file `Retro-Studio.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/01_UI.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 2 ScreenGuis, 66 GUI objects → **2 screenshots** |
| Models (.rbxm) | 27 models, 0 model sets, 1 VFX sets |
| Lua builders (.lua) | 5 UI screens, 0 animation packs, 0 audio packs |
| Code | 125 scripts, 15,454 lines |
| Asset ids | 0 animations, 21 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `ComicNeueAngular Regular`×15, `Arial Bold`×2, `SourceSansPro Regular`×1, `SourceSansPro Bold`×1

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_UI__HelpWindow.jpg"><img src="screenshots/thumbs/02_UI__HelpWindow.jpg" width="100%"></a><br><sub><b>UI</b> › HelpWindow</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_UI.jpg"><img src="screenshots/thumbs/01_UI.jpg" width="100%"></a><br><sub><b>UI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/Plane.rbxm"><img src="screenshots/thumbs/models/01_Plane.jpg" width="100%"></a><br><sub><b>Plane</b><br><code>models/ServerStorage/StandardTools/Plane.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/PaintballGun.rbxm"><img src="screenshots/thumbs/models/02_PaintballGun.jpg" width="100%"></a><br><sub><b>PaintballGun</b><br><code>models/ServerStorage/StandardTools/PaintballGun.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/RocketLauncher.rbxm"><img src="screenshots/thumbs/models/03_RocketLauncher.jpg" width="100%"></a><br><sub><b>RocketLauncher</b><br><code>models/ServerStorage/StandardTools/RocketLauncher.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/Sword.rbxm"><img src="screenshots/thumbs/models/05_Sword.jpg" width="100%"></a><br><sub><b>Sword</b><br><code>models/ServerStorage/StandardTools/Sword.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/GravityHammer.rbxm"><img src="screenshots/thumbs/models/06_GravityHammer.jpg" width="100%"></a><br><sub><b>GravityHammer</b><br><code>models/ServerStorage/StandardTools/GravityHammer.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/Slingshot.rbxm"><img src="screenshots/thumbs/models/07_Slingshot.jpg" width="100%"></a><br><sub><b>Slingshot</b><br><code>models/ServerStorage/StandardTools/Slingshot.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/Trowel.rbxm"><img src="screenshots/thumbs/models/08_Trowel.jpg" width="100%"></a><br><sub><b>Trowel</b><br><code>models/ServerStorage/StandardTools/Trowel.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/Superball.rbxm"><img src="screenshots/thumbs/models/09_Superball.jpg" width="100%"></a><br><sub><b>Superball</b><br><code>models/ServerStorage/StandardTools/Superball.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/StandardTools/Timebomb.rbxm"><img src="screenshots/thumbs/models/10_Timebomb.jpg" width="100%"></a><br><sub><b>Timebomb</b><br><code>models/ServerStorage/StandardTools/Timebomb.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Dragger`](source/scripts/ServerScriptService/BuildTools/Dragger.client.lua) <sub>250 lines</sub> |
| UI controllers / window managers / menus | [`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/Camera/Main.lua) <sub>1042 lines</sub><br>[`Topbar`](source/scripts/ReplicatedFirst/JoinScript/UI/Topbar/Topbar.client.lua) <sub>191 lines</sub> |
| Notifications, toasts, popups, prompts | [`Chat`](source/scripts/ReplicatedFirst/JoinScript/UI/Chat/Chat.client.lua) <sub>188 lines</sub><br>[`Topbar`](source/scripts/ReplicatedFirst/JoinScript/UI/Topbar/Topbar.client.lua) <sub>191 lines</sub><br>[`JoinScript`](source/scripts/ReplicatedFirst/JoinScript.client.lua) <sub>260 lines</sub> |
| Loading / intro screens | [`JoinScript`](source/scripts/ReplicatedFirst/JoinScript.client.lua) <sub>260 lines</sub> |
| VFX, particles, beams, hit effects | [`Explosions`](source/scripts/ServerScriptService/Explosions.server.lua) <sub>186 lines</sub><br>[`Explosions`](source/scripts/StarterPlayer/StarterPlayerScripts/Explosions.client.lua) <sub>58 lines</sub><br>[`SwordScript`](source/scripts/ServerStorage/StandardTools/GravityHammer/SwordScript.server.lua) <sub>158 lines</sub><br>[`RocketScript`](source/scripts/ServerStorage/StandardTools/RocketLauncher/RocketScript.server.lua) <sub>92 lines</sub> |
| DataStore / player data | [`PlayerDataStore`](source/scripts/ServerStorage/PlayerDataStore.lua) <sub>831 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`SwordScript`](source/scripts/ServerStorage/StandardTools/Sword/SwordScript.server.lua) <sub>181 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`RetroClimbing`](source/scripts/StarterPlayer/StarterCharacterScripts/RetroClimbing.client.lua) <sub>239 lines</sub><br>[`Animator`](source/scripts/StarterPlayer/StarterPlayerScripts/Animator.client.lua) <sub>276 lines</sub><br>[`HumanoidSound`](source/scripts/StarterPlayer/StarterPlayerScripts/HumanoidSound.client.lua) <sub>142 lines</sub><br>[`GoofyMotion`](source/scripts/StarterPlayer/StarterCharacterScripts/GoofyMotion.client.lua) <sub>72 lines</sub> |
| Tycoon / plots / bases / building | [`BuildTools`](source/scripts/ServerScriptService/BuildTools.server.lua) <sub>243 lines</sub> |
| Leaderboards & stats | [`Leaderboard`](source/scripts/ServerScriptService/Leaderboard.server.lua) <sub>195 lines</sub> |

### In the curated script library

- [Classic explosion physics](../../Scripts/11-Combat/ClassicExplosionPhysics__retro-studio.lua) — How the original Roblox explosion worked, ported to Lua with the engine code in comments.
- [Classic sword (slash / lunge)](../../Scripts/11-Combat/ClassicSword__retro-studio.lua) — The classic Linked Sword: slash vs lunge damage, Touched hitbox, creator tag.
- [Stravant's PlayerDataStore (classic)](../../Scripts/07-Data-Saving/PlayerDataStore-Stravant__retro-studio.lua) — The classic community PlayerDataStore module (by Stravant): cached SaveData objects, passive saves, Flush, and atomic multi-key Update meant for dev product purchases.
- [Retro Bricks/Connectors join screen](../../Scripts/04-Loading-Screens/RetroJoinScreen__retro-studio.lua) — Old-Roblox-style join screen: 'Bricks / Connectors' counter from RequestQueueSize, camera orbiting the map's visible extents while loading, timeout + exit override.
- [Custom climbing](../../Scripts/13-Movement/CustomClimbing__retro-studio.lua) — Hand-made ladder/truss climbing (rung detection + velocity mover + debug rays).

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
