# Tower Of Hell

> 🧗 **Obby** · obby (procedural tower) · source file `SLBR - Booster - Tower Of Hell.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/02_ShopGui__Frame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 5 ScreenGuis, 256 GUI objects → **9 screenshots** |
| Models (.rbxm) | 11 models, 1 model sets, 0 VFX sets |
| Lua builders (.lua) | 10 UI screens, 0 animation packs, 1 audio packs |
| Code | 67 scripts, 2,397 lines |
| Asset ids | 1 animations, 14 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Zekton Regular`×49, `SourceSansPro Regular`×34, `LegacyArial Regular`×26

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_ShopGui.jpg"><img src="screenshots/thumbs/01_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_ShopGui__Frame.jpg"><img src="screenshots/thumbs/02_ShopGui__Frame.jpg" width="100%"></a><br><sub><b>ShopGui</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_ShopGui.jpg"><img src="screenshots/thumbs/04_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_items__theme.jpg"><img src="screenshots/thumbs/06_items__theme.jpg" width="100%"></a><br><sub><b>items</b> › settings.theme</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_items__killparthue.jpg"><img src="screenshots/thumbs/07_items__killparthue.jpg" width="100%"></a><br><sub><b>items</b> › settings.killparthue</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_items__boxes.jpg"><img src="screenshots/thumbs/08_items__boxes.jpg" width="100%"></a><br><sub><b>items</b> › effects.boxes</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_items__effects.jpg"><img src="screenshots/thumbs/09_items__effects.jpg" width="100%"></a><br><sub><b>items</b> › effects.effects</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_items__Credits.jpg"><img src="screenshots/thumbs/05_items__Credits.jpg" width="100%"></a><br><sub><b>items</b> › Credits</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_StatChanger.jpg"><img src="screenshots/thumbs/03_StatChanger.jpg" width="100%"></a><br><sub><b>StatChanger</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Gears/GravityCoil.rbxm"><img src="screenshots/thumbs/models/01_GravityCoil.jpg" width="100%"></a><br><sub><b>GravityCoil</b><br><code>models/ServerStorage/Gears/GravityCoil.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Storage/End.rbxm"><img src="screenshots/thumbs/models/02_End.jpg" width="100%"></a><br><sub><b>End</b><br><code>models/Workspace/Storage/End.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Gears/Hook.rbxm"><img src="screenshots/thumbs/models/03_Hook.jpg" width="100%"></a><br><sub><b>Hook</b><br><code>models/ServerStorage/Gears/Hook.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Stages/Stage3__x11.rbxm"><img src="screenshots/thumbs/models/04_Stage3_x11.jpg" width="100%"></a><br><sub><b>Stage3__x11</b><br><code>models/ServerStorage/Stages/Stage3__x11.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Gears/FusionCoil.rbxm"><img src="screenshots/thumbs/models/05_FusionCoil.jpg" width="100%"></a><br><sub><b>FusionCoil</b><br><code>models/ServerStorage/Gears/FusionCoil.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Storage/Lobby.rbxm"><img src="screenshots/thumbs/models/06_Lobby.jpg" width="100%"></a><br><sub><b>Lobby</b><br><code>models/Workspace/Storage/Lobby.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Gears/JumpCoil.rbxm"><img src="screenshots/thumbs/models/07_JumpCoil.jpg" width="100%"></a><br><sub><b>JumpCoil</b><br><code>models/ServerStorage/Gears/JumpCoil.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Template.rbxm"><img src="screenshots/thumbs/models/08_Template.jpg" width="100%"></a><br><sub><b>Template</b><br><code>models/ServerStorage/Template.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Gears/SpeedCoil.rbxm"><img src="screenshots/thumbs/models/09_SpeedCoil.jpg" width="100%"></a><br><sub><b>SpeedCoil</b><br><code>models/ServerStorage/Gears/SpeedCoil.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Stages/Stage3.rbxm"><img src="screenshots/thumbs/models/10_Stage3.jpg" width="100%"></a><br><sub><b>Stage3</b><br><code>models/ServerStorage/Stages/Stage3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Gears/Trowel.rbxm"><img src="screenshots/thumbs/models/11_Trowel.jpg" width="100%"></a><br><sub><b>Trowel</b><br><code>models/ServerStorage/Gears/Trowel.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI controllers / window managers / menus | [`LocalScript`](source/scripts/ServerStorage/UsedGuis/ShopGui/Frame/LocalScript.client.lua) <sub>139 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/ShopGui/Frame/LocalScript.client.lua) <sub>138 lines</sub><br>[`LocalScript`](source/scripts/ServerStorage/UsedGuis/ShopGui/Frame/ScrollingFrame/mutators/HighSpeed/LocalScript.client.lua) <sub>41 lines</sub> |
| Notifications, toasts, popups, prompts | [`LocalScript`](source/scripts/ServerStorage/UsedGuis/ShopGui/Frame/LocalScript.client.lua) <sub>139 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/ShopGui/Frame/LocalScript.client.lua) <sub>138 lines</sub><br>[`LocalScript`](source/scripts/ServerStorage/UsedGuis/ShopGui/Frame/ScrollingFrame/mutators/HighSpeed/LocalScript.client.lua) <sub>41 lines</sub> |
| Loading / intro screens | [`LocalScript`](source/scripts/ServerStorage/Gears/Hook/LocalScript.client.lua) <sub>169 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Script`](source/scripts/ServerStorage/Gears/Hook/Script.server.lua) <sub>382 lines</sub> |
| Leaderboards & stats | [`Leaderboard`](source/scripts/ServerScriptService/Leaderboard.server.lua) <sub>24 lines</sub> |

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
