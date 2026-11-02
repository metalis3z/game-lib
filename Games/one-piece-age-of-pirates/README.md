# One Piece: The Age Of Pirates

> 🥊 **Fighting** · anime RPG · source file `One Piece - The Age Of Pirates.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/12_SwordGui.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 2 ScreenGuis, 10 GUI objects → **12 screenshots** |
| Models (.rbxm) | 116 models, 1 model sets, 0 VFX sets |
| Lua builders (.lua) | 11 UI screens, 0 animation packs, 2 audio packs |
| Code | 545 scripts, 25,770 lines |
| Asset ids | 0 animations, 24 sounds |
| Safety scan | 3 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_MainGui.jpg"><img src="screenshots/thumbs/03_MainGui.jpg" width="100%"></a><br><sub><b>MainGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_Stamina.jpg"><img src="screenshots/thumbs/04_Stamina.jpg" width="100%"></a><br><sub><b>Stamina</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_MoneyGiver.jpg"><img src="screenshots/thumbs/08_MoneyGiver.jpg" width="100%"></a><br><sub><b>MoneyGiver</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_NotEnoughMoney.jpg"><img src="screenshots/thumbs/09_NotEnoughMoney.jpg" width="100%"></a><br><sub><b>NotEnoughMoney</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_WeaponGui.jpg"><img src="screenshots/thumbs/01_WeaponGui.jpg" width="100%"></a><br><sub><b>WeaponGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_JailTime.jpg"><img src="screenshots/thumbs/02_JailTime.jpg" width="100%"></a><br><sub><b>JailTime</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_AlreadyMastered.jpg"><img src="screenshots/thumbs/05_AlreadyMastered.jpg" width="100%"></a><br><sub><b>AlreadyMastered</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_HakiGui.jpg"><img src="screenshots/thumbs/06_HakiGui.jpg" width="100%"></a><br><sub><b>HakiGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_HaoGui.jpg"><img src="screenshots/thumbs/07_HaoGui.jpg" width="100%"></a><br><sub><b>HaoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_RokushikiGui.jpg"><img src="screenshots/thumbs/10_RokushikiGui.jpg" width="100%"></a><br><sub><b>RokushikiGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_SavingLocation.jpg"><img src="screenshots/thumbs/11_SavingLocation.jpg" width="100%"></a><br><sub><b>SavingLocation</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_SwordGui.jpg"><img src="screenshots/thumbs/12_SwordGui.jpg" width="100%"></a><br><sub><b>SwordGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Lighting/LightSword.rbxm"><img src="screenshots/thumbs/models/01_LightSword.jpg" width="100%"></a><br><sub><b>LightSword</b><br><code>models/Lighting/LightSword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Boats1/Caravel.rbxm"><img src="screenshots/thumbs/models/02_Caravel.jpg" width="100%"></a><br><sub><b>Caravel</b><br><code>models/Lighting/Boats1/Caravel.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/FlameFruit.rbxm"><img src="screenshots/thumbs/models/03_FlameFruit.jpg" width="100%"></a><br><sub><b>FlameFruit</b><br><code>models/Lighting/FlameFruit.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Weapons/Cutlass.rbxm"><img src="screenshots/thumbs/models/05_Cutlass.jpg" width="100%"></a><br><sub><b>Cutlass</b><br><code>models/Lighting/Weapons/Cutlass.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Lighting/Boats1/Sloop.rbxm"><img src="screenshots/thumbs/models/06_Sloop.jpg" width="100%"></a><br><sub><b>Sloop</b><br><code>models/Lighting/Boats1/Sloop.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/LeopardFruit.rbxm"><img src="screenshots/thumbs/models/07_LeopardFruit.jpg" width="100%"></a><br><sub><b>LeopardFruit</b><br><code>models/Lighting/LeopardFruit.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/GasGas.rbxm"><img src="screenshots/thumbs/models/08_GasGas.jpg" width="100%"></a><br><sub><b>GasGas</b><br><code>models/Lighting/GasGas.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Weapons/Katana.rbxm"><img src="screenshots/thumbs/models/09_Katana.jpg" width="100%"></a><br><sub><b>Katana</b><br><code>models/Lighting/Weapons/Katana.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Lighting/Boats1/Dinghy.rbxm"><img src="screenshots/thumbs/models/10_Dinghy.jpg" width="100%"></a><br><sub><b>Dinghy</b><br><code>models/Lighting/Boats1/Dinghy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/ChillyFruit.rbxm"><img src="screenshots/thumbs/models/11_ChillyFruit.jpg" width="100%"></a><br><sub><b>ChillyFruit</b><br><code>models/Lighting/ChillyFruit.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/VenomVenom.rbxm"><img src="screenshots/thumbs/models/12_VenomVenom.jpg" width="100%"></a><br><sub><b>VenomVenom</b><br><code>models/Lighting/VenomVenom.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Weapons/Sabre.rbxm"><img src="screenshots/thumbs/models/13_Sabre.jpg" width="100%"></a><br><sub><b>Sabre</b><br><code>models/Lighting/Weapons/Sabre.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Lighting/BarrierFruit.rbxm"><img src="screenshots/thumbs/models/14_BarrierFruit.jpg" width="100%"></a><br><sub><b>BarrierFruit</b><br><code>models/Lighting/BarrierFruit.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| Combat, weapons, hitboxes, abilities | [`Firedamage`](source/scripts/Lighting/BubbleBubble/BubbleBlast/Firedamage.server.lua) <sub>41 lines</sub><br>[`Firedamage`](source/scripts/Lighting/BubbleBubble/BubbleWave/Firedamage.server.lua) <sub>41 lines</sub><br>[`Firedamage`](source/scripts/Lighting/CageCage/CageArm/Firedamage.server.lua) <sub>41 lines</sub><br>[`Firedamage`](source/scripts/Lighting/CageCage/CageTrap/Union/Firedamage.server.lua) <sub>41 lines</sub><br>[`Firedamage`](source/scripts/Lighting/ChillyChilly/IceAge/Firedamage.server.lua) <sub>43 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Run`](source/scripts/StarterPack/Run.client.lua) <sub>45 lines</sub> |
| Leaderboards & stats | [`Leaderboard`](source/scripts/Workspace/PlayerAddedStuff/Leaderboard.server.lua) <sub>23 lines</sub> |
| Sound & music | [`MusicScript`](source/scripts/StarterGui/MainGui/Music/MusicScript.client.lua) <sub>125 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/Kohl's Admin Commands V2.server.lua`
- `scripts/Workspace/Kohl's Admin Commands V2/LocalScriptBase.client.lua`
- `scripts/Workspace/Kohl's Admin Commands V2/ScriptBase.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
