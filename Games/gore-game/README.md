# Gore game (leak)

> 🥊 **Fighting** · combat / gore physics · source file `paid_gore_game_leaked.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 0 ScreenGuis, 0 GUI objects → **0 screenshots** |
| Models (.rbxm) | 87 models, 4 model sets, 0 VFX sets |
| Lua builders (.lua) | 0 UI screens, 97 animation packs, 7 audio packs |
| Code | 257 scripts, 52,539 lines |
| Asset ids | 719 animations, 71 sounds |
| Safety scan | 0 HIGH / 73 MED flags ([flags.txt](source/flags.txt)) |

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Peds/Ukraine%20Supporter__x6.rbxm"><img src="screenshots/thumbs/models/01_Ukraine_Supporter_x6.jpg" width="100%"></a><br><sub><b>Ukraine Supporter__x6</b><br><code>models/Workspace/Peds/Ukraine Supporter__x6.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPack/Sawned-Off.rbxm"><img src="screenshots/thumbs/models/02_Sawned-Off.jpg" width="100%"></a><br><sub><b>Sawned-Off</b><br><code>models/StarterPack/Sawned-Off.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPack/Tommy.rbxm"><img src="screenshots/thumbs/models/03_Tommy.jpg" width="100%"></a><br><sub><b>Tommy</b><br><code>models/StarterPack/Tommy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/Part.rbxm"><img src="screenshots/thumbs/models/04_Part.jpg" width="100%"></a><br><sub><b>Part</b><br><code>models/Workspace/Buildings/Part.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Gibs/Head/Right/Right.rbxm"><img src="screenshots/thumbs/models/05_Right.jpg" width="100%"></a><br><sub><b>Right</b><br><code>models/ReplicatedStorage/Assets/Gibs/Head/Right/Right.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Peds/Dummy__x73.rbxm"><img src="screenshots/thumbs/models/06_Dummy_x73.jpg" width="100%"></a><br><sub><b>Dummy__x73</b><br><code>models/Workspace/Peds/Dummy__x73.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPack/Deagle.rbxm"><img src="screenshots/thumbs/models/07_Deagle.jpg" width="100%"></a><br><sub><b>Deagle</b><br><code>models/StarterPack/Deagle.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/Float~5.rbxm"><img src="screenshots/thumbs/models/08_Float_5.jpg" width="100%"></a><br><sub><b>Float~5</b><br><code>models/Workspace/Buildings/Float~5.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Gibs/Head/TopLeft/TopLeft.rbxm"><img src="screenshots/thumbs/models/09_TopLeft.jpg" width="100%"></a><br><sub><b>TopLeft</b><br><code>models/ReplicatedStorage/Assets/Gibs/Head/TopLeft/TopLeft.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPack/Glock%2017.rbxm"><img src="screenshots/thumbs/models/11_Glock_17.jpg" width="100%"></a><br><sub><b>Glock 17</b><br><code>models/StarterPack/Glock 17.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Gibs/Head/Left/Left~2.rbxm"><img src="screenshots/thumbs/models/12_Left_2.jpg" width="100%"></a><br><sub><b>Left~2</b><br><code>models/ReplicatedStorage/Assets/Gibs/Head/Left/Left~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Gibs/Limbs/Top/Top~2.rbxm"><img src="screenshots/thumbs/models/14_Top_2.jpg" width="100%"></a><br><sub><b>Top~2</b><br><code>models/ReplicatedStorage/Assets/Gibs/Limbs/Top/Top~2.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`LocalScript`](source/scripts/StarterPlayer/StarterCharacterScripts/LocalScript.client.lua) <sub>1346 lines</sub> |
| Camera, cutscenes, screen shake | [`LocalScript`](source/scripts/StarterPlayer/StarterCharacterScripts/LocalScript.client.lua) <sub>1346 lines</sub> |
| VFX, particles, beams, hit effects | [`LocalScript`](source/scripts/StarterPlayer/StarterCharacterScripts/LocalScript.client.lua) <sub>1346 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Ragdoll`](source/scripts/ReplicatedStorage/Assets/Modules/Ragdoll.lua) <sub>395 lines</sub> |
| NPC / AI / monsters | [`SimplePath`](source/scripts/ReplicatedStorage/Assets/Modules/SimplePath.lua) <sub>350 lines</sub> |
| Tycoon / plots / bases / building | [`LocalScript`](source/scripts/StarterPlayer/StarterCharacterScripts/LocalScript.client.lua) <sub>1346 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Network`](source/scripts/ReplicatedStorage/Assets/Modules/Network.lua) <sub>1085 lines</sub> |

### In the curated script library

- [Euphoria-style active ragdoll](../../Scripts/13-Movement/EuphoriaRagdoll__gore-game.lua) — Active ragdoll: hidden animated rig + springs drive the ragdoll limbs (euphoria look).

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
