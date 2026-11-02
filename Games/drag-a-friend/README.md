# Drag A Friend

> 🎉 **Party** · party / physics (tether a friend) · source file `Drag A Friend-1.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/29_GamepassUI__Frame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 5 ScreenGuis, 56 GUI objects → **18 screenshots** |
| Models (.rbxm) | 17 models, 0 model sets, 0 VFX sets |
| Lua builders (.lua) | 7 UI screens, 4 animation packs, 1 audio packs |
| Code | 603 scripts, 117,426 lines |
| Asset ids | 2 animations, 3 sounds |
| Safety scan | 9 HIGH / 21 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Regular`×8, `PressStart2P Regular`×5, `Rubik Bold`×5, `FredokaOne Regular`×2, `Rubik SemiBold`×2

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_GamepassUI.jpg"><img src="screenshots/thumbs/28_GamepassUI.jpg" width="100%"></a><br><sub><b>GamepassUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_GamepassUI__Frame.jpg"><img src="screenshots/thumbs/29_GamepassUI__Frame.jpg" width="100%"></a><br><sub><b>GamepassUI</b> › Frame</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_Playerlist__Information.jpg"><img src="screenshots/thumbs/31_Playerlist__Information.jpg" width="100%"></a><br><sub><b>Playerlist</b> › MainFrame.Information</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/01_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/02_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/03_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/04_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/05_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/06_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/07_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/08_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/09_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/10_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/11_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/11_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/12_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_BTWeldToolGUI.jpg"><img src="screenshots/thumbs/13_BTWeldToolGUI.jpg" width="100%"></a><br><sub><b>BTWeldToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_ScreenGui.jpg"><img src="screenshots/thumbs/27_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_Playerlist.jpg"><img src="screenshots/thumbs/30_Playerlist.jpg" width="100%"></a><br><sub><b>Playerlist</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Boards.rbxm"><img src="screenshots/thumbs/models/01_Boards.jpg" width="100%"></a><br><sub><b>Boards</b><br><code>models/Workspace/Boards.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Settings/Rescue/Dual%20Chain%20Necklace.rbxm"><img src="screenshots/thumbs/models/02_Dual_Chain_Necklace.jpg" width="100%"></a><br><sub><b>Dual Chain Necklace</b><br><code>models/Workspace/Settings/Rescue/Dual Chain Necklace.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Flower.rbxm"><img src="screenshots/thumbs/models/03_Flower.jpg" width="100%"></a><br><sub><b>Flower</b><br><code>models/Workspace/Flower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Duck.rbxm"><img src="screenshots/thumbs/models/04_Duck.jpg" width="100%"></a><br><sub><b>Duck</b><br><code>models/Workspace/Duck.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/R6%20%5BDummy%5D.rbxm"><img src="screenshots/thumbs/models/05_R6_Dummy_.jpg" width="100%"></a><br><sub><b>R6 [Dummy]</b><br><code>models/Workspace/R6 [Dummy].rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Settings/Rescue/PossesdP9.rbxm"><img src="screenshots/thumbs/models/06_PossesdP9.jpg" width="100%"></a><br><sub><b>PossesdP9</b><br><code>models/Workspace/Settings/Rescue/PossesdP9.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Flower~2.rbxm"><img src="screenshots/thumbs/models/07_Flower_2.jpg" width="100%"></a><br><sub><b>Flower~2</b><br><code>models/Workspace/Flower~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Model.rbxm"><img src="screenshots/thumbs/models/08_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Model.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Dummy.rbxm"><img src="screenshots/thumbs/models/09_Dummy.jpg" width="100%"></a><br><sub><b>Dummy</b><br><code>models/Workspace/Dummy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Settings/Rescue/Purple%20Heart%20NecklaceAccessory.rbxm"><img src="screenshots/thumbs/models/10_Purple_Heart_NecklaceAccessory.jpg" width="100%"></a><br><sub><b>Purple Heart NecklaceAccessory</b><br><code>models/Workspace/Settings/Rescue/Purple Heart NecklaceAccessory.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/SpawnLocation.rbxm"><img src="screenshots/thumbs/models/11_SpawnLocation.jpg" width="100%"></a><br><sub><b>SpawnLocation</b><br><code>models/Workspace/SpawnLocation.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Settings/Rescue/Maelstrom%20Spellbinder.rbxm"><img src="screenshots/thumbs/models/12_Maelstrom_Spellbinder.jpg" width="100%"></a><br><sub><b>Maelstrom Spellbinder</b><br><code>models/Workspace/Settings/Rescue/Maelstrom Spellbinder.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Settings/Rescue/PurpleCape.rbxm"><img src="screenshots/thumbs/models/13_PurpleCape.jpg" width="100%"></a><br><sub><b>PurpleCape</b><br><code>models/Workspace/Settings/Rescue/PurpleCape.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Settings/Rescue/SpaceHorns.rbxm"><img src="screenshots/thumbs/models/14_SpaceHorns.jpg" width="100%"></a><br><sub><b>SpaceHorns</b><br><code>models/Workspace/Settings/Rescue/SpaceHorns.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Manager`](source/scripts/StarterGui/GamepassUI/Manager.client.lua) <sub>88 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`NumberFormatter`](source/scripts/ReplicatedStorage/NumberFormatter.lua) <sub>38 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/Boards/AssetLoader.server.lua`
- `scripts/Workspace/Boards/R15Loader/Loader.server.lua`
- `scripts/Workspace/Kohl's Admin/Legacy_Loader/MainModuleKAI.lua`
- `scripts/Workspace/Kohl's Admin/Legacy_Loader/MainModuleKAI/D/Tools/Building Tools/AutoUpdate/AutomaticUpdating.server.lua`
- `scripts/Workspace/Kohl's Admin/Legacy_Loader/MainModuleKAI/D/Tools/Building Tools/Libraries/Cryo/List.lua`
- `scripts/Workspace/Kohl's Admin/Legacy_Loader/MainModuleKAI/D/Tools/Building Tools/Libraries/Cryo/List/reverse.spec.lua`
- `scripts/Workspace/Kohl's Admin/MainModule/DefaultTools/Building Tools/AutoUpdate/AutomaticUpdating.server.lua`
- `scripts/Workspace/Kohl's Admin/MainModule/DefaultTools/Building Tools/Libraries/Cryo/List.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
