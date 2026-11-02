# Dandy's World

> 👻 **Horror** · horror survival (toons, floors, machines) · source file `Dandy-s-World_.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/02_LoadingGui__LoadingScreen.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 8 ScreenGuis, 271 GUI objects → **9 screenshots** |
| Models (.rbxm) | 147 models, 0 model sets, 13 VFX sets |
| Lua builders (.lua) | 32 UI screens, 1 animation packs, 45 audio packs |
| Code | 1388 scripts, 286,222 lines |
| Asset ids | 176 animations, 328 sounds |
| Safety scan | 0 HIGH / 5 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×56, `GothamSSm Bold`×10, `FredokaOne Bold`×7, `LegacyArial Regular`×4, `FredokaOne Heavy`×3

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_Notif.jpg"><img src="screenshots/thumbs/08_Notif.jpg" width="100%"></a><br><sub><b>Notif</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_LoadingGui__LoadingScreen.jpg"><img src="screenshots/thumbs/02_LoadingGui__LoadingScreen.jpg" width="100%"></a><br><sub><b>LoadingGui</b> › LoadingScreen</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_DeathGui__DeathScreen.jpg"><img src="screenshots/thumbs/01_DeathGui__DeathScreen.jpg" width="100%"></a><br><sub><b>DeathGui</b> › DeathScreen</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_DevFrame__CommandFrame.jpg"><img src="screenshots/thumbs/07_DevFrame__CommandFrame.jpg" width="100%"></a><br><sub><b>DevFrame</b> › CommandFrame</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_ClientUI__Bottom.jpg"><img src="screenshots/thumbs/09_ClientUI__Bottom.jpg" width="100%"></a><br><sub><b>ClientUI</b> › Bottom</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_SpectatorGui.jpg"><img src="screenshots/thumbs/03_SpectatorGui.jpg" width="100%"></a><br><sub><b>SpectatorGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_TwistedSquirmEscapeUI.jpg"><img src="screenshots/thumbs/04_TwistedSquirmEscapeUI.jpg" width="100%"></a><br><sub><b>TwistedSquirmEscapeUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_KnightmareAntiCheatClient__KMDebugFrame.jpg"><img src="screenshots/thumbs/05_KnightmareAntiCheatClient__KMDebugFrame.jpg" width="100%"></a><br><sub><b>KnightmareAntiCheatClient</b> › KMDebugFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_DevFrame.jpg"><img src="screenshots/thumbs/06_DevFrame.jpg" width="100%"></a><br><sub><b>DevFrame</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Elevators/Elevator.rbxm"><img src="screenshots/thumbs/models/01_Elevator.jpg" width="100%"></a><br><sub><b>Elevator</b><br><code>models/Workspace/Elevators/Elevator.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/SkillCheckCandy.rbxm"><img src="screenshots/thumbs/models/02_SkillCheckCandy.jpg" width="100%"></a><br><sub><b>SkillCheckCandy</b><br><code>models/ReplicatedStorage/Items/SkillCheckCandy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Skins/Goob/SpecialSpaghetti/Base.rbxm"><img src="screenshots/thumbs/models/03_Base.jpg" width="100%"></a><br><sub><b>Base</b><br><code>models/ReplicatedStorage/Skins/Goob/SpecialSpaghetti/Base.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/DandyEasterEggs.rbxm"><img src="screenshots/thumbs/models/04_DandyEasterEggs.jpg" width="100%"></a><br><sub><b>DandyEasterEggs</b><br><code>models/ReplicatedStorage/Items/DandyEasterEggs.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Parts/FlowerField.rbxm"><img src="screenshots/thumbs/models/05_FlowerField.jpg" width="100%"></a><br><sub><b>FlowerField</b><br><code>models/ReplicatedStorage/Parts/FlowerField.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/PopBottle.rbxm"><img src="screenshots/thumbs/models/06_PopBottle.jpg" width="100%"></a><br><sub><b>PopBottle</b><br><code>models/ReplicatedStorage/Items/PopBottle.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Parts/RenderModules/GlistenPortal/GlistenMirror.rbxm"><img src="screenshots/thumbs/models/07_GlistenMirror.jpg" width="100%"></a><br><sub><b>GlistenMirror</b><br><code>models/ReplicatedStorage/Parts/RenderModules/GlistenPortal/GlistenMirror.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Parts/ArcadeGames/SwimmyBarnaby/LargeDecor/MoonTerrain2.rbxm"><img src="screenshots/thumbs/models/08_MoonTerrain2.jpg" width="100%"></a><br><sub><b>MoonTerrain2</b><br><code>models/ReplicatedStorage/Parts/ArcadeGames/SwimmyBarnaby/LargeDecor/MoonTerrain2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Parts/GoobGrab.rbxm"><img src="screenshots/thumbs/models/09_GoobGrab.jpg" width="100%"></a><br><sub><b>GoobGrab</b><br><code>models/ReplicatedStorage/Parts/GoobGrab.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/SpeedCandy.rbxm"><img src="screenshots/thumbs/models/11_SpeedCandy.jpg" width="100%"></a><br><sub><b>SpeedCandy</b><br><code>models/ReplicatedStorage/Items/SpeedCandy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Instructions.rbxm"><img src="screenshots/thumbs/models/13_Instructions.jpg" width="100%"></a><br><sub><b>Instructions</b><br><code>models/ReplicatedStorage/Items/Instructions.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Parts/RenderModules/GlistenPortal/GlistenPoof.rbxm"><img src="screenshots/thumbs/models/14_GlistenPoof.jpg" width="100%"></a><br><sub><b>GlistenPoof</b><br><code>models/ReplicatedStorage/Parts/RenderModules/GlistenPortal/GlistenPoof.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| Camera, cutscenes, screen shake | [`TransformationCameraLock`](source/scripts/StarterPlayer/StarterPlayerScripts/Character/TransformationCameraLock.client.lua) <sub>68 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Dandy`](source/scripts/ReplicatedStorage/SharedData/TowerData/Dandy.lua) <sub>52 lines</sub><br>[`Dyle`](source/scripts/ReplicatedStorage/SharedData/TowerData/Dyle.lua) <sub>52 lines</sub> |
| Sound & music | [`SoundMute`](source/scripts/ReplicatedStorage/Scripts/SoundMute.client.lua) <sub>28 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`timeFormat`](source/scripts/ReplicatedStorage/SharedUtils/timeFormat.lua) <sub>57 lines</sub><br>[`timerBar`](source/scripts/Players/%5BPlayer%5D%20prorivalsmdrlol/PlayerGui/TwistedSquirmEscapeUI/Stylesheets/timerBar.lua) <sub>57 lines</sub><br>[`SoundUtils`](source/scripts/ReplicatedStorage/Modules/Audio/SoundUtils.lua) <sub>55 lines</sub> |

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
