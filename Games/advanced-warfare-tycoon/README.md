# Advanced Warfare Tycoon

> 🏭 **Tycoon** · tycoon (military) · source file `Advanced Warfare Tycoon.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/23_ShopGui__vpi.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 4 ScreenGuis, 61 GUI objects → **10 screenshots** |
| Models (.rbxm) | 46 models, 2 model sets, 0 VFX sets |
| Lua builders (.lua) | 6 UI screens, 0 animation packs, 2 audio packs |
| Code | 1581 scripts, 61,704 lines |
| Asset ids | 20 animations, 100 sounds |
| Safety scan | 5 HIGH / 4 MED flags ([flags.txt](source/flags.txt)) |

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_ShopGui.jpg"><img src="screenshots/thumbs/22_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_ShopGui__vpi.jpg"><img src="screenshots/thumbs/23_ShopGui__vpi.jpg" width="100%"></a><br><sub><b>ShopGui</b> › vpi</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_MusicTipGui.jpg"><img src="screenshots/thumbs/24_MusicTipGui.jpg" width="100%"></a><br><sub><b>MusicTipGui</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_WeaponHud.jpg"><img src="screenshots/thumbs/25_WeaponHud.jpg" width="100%"></a><br><sub><b>WeaponHud</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Frame.jpg"><img src="screenshots/thumbs/01_Frame.jpg" width="100%"></a><br><sub><b>Frame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_RegenGui.jpg"><img src="screenshots/thumbs/02_RegenGui.jpg" width="100%"></a><br><sub><b>RegenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_ScreenGui.jpg"><img src="screenshots/thumbs/19_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_ScreenGui.jpg"><img src="screenshots/thumbs/20_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_MusicGui__MusicPlayer.jpg"><img src="screenshots/thumbs/21_MusicGui__MusicPlayer.jpg" width="100%"></a><br><sub><b>MusicGui</b> › MusicPlayer</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_FuelGui.jpg"><img src="screenshots/thumbs/31_FuelGui.jpg" width="100%"></a><br><sub><b>FuelGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Model~2/Hat%20Remover.rbxm"><img src="screenshots/thumbs/models/01_Hat_Remover.jpg" width="100%"></a><br><sub><b>Hat Remover</b><br><code>models/Workspace/Model~2/Hat Remover.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/JetPack.rbxm"><img src="screenshots/thumbs/models/02_JetPack.jpg" width="100%"></a><br><sub><b>JetPack</b><br><code>models/Lighting/JetPack.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPack/Sword.rbxm"><img src="screenshots/thumbs/models/03_Sword.jpg" width="100%"></a><br><sub><b>Sword</b><br><code>models/StarterPack/Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Bow.rbxm"><img src="screenshots/thumbs/models/04_Bow.jpg" width="100%"></a><br><sub><b>Bow</b><br><code>models/Lighting/Bow.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Model/VIP.rbxm"><img src="screenshots/thumbs/models/05_VIP.jpg" width="100%"></a><br><sub><b>VIP</b><br><code>models/Workspace/Model/VIP.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/AK47.rbxm"><img src="screenshots/thumbs/models/06_AK47.jpg" width="100%"></a><br><sub><b>AK47</b><br><code>models/Lighting/AK47.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/red.rbxm"><img src="screenshots/thumbs/models/07_red.jpg" width="100%"></a><br><sub><b>red</b><br><code>models/Workspace/red.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/AUG.rbxm"><img src="screenshots/thumbs/models/08_AUG.jpg" width="100%"></a><br><sub><b>AUG</b><br><code>models/Lighting/AUG.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Model~2/Model.rbxm"><img src="screenshots/thumbs/models/09_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Model~2/Model.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/blue.rbxm"><img src="screenshots/thumbs/models/10_blue.jpg" width="100%"></a><br><sub><b>blue</b><br><code>models/Workspace/blue.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/G-AK47.rbxm"><img src="screenshots/thumbs/models/11_G-AK47.jpg" width="100%"></a><br><sub><b>G-AK47</b><br><code>models/Lighting/G-AK47.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/teal.rbxm"><img src="screenshots/thumbs/models/12_teal.jpg" width="100%"></a><br><sub><b>teal</b><br><code>models/Workspace/teal.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Lighting/M1Grand.rbxm"><img src="screenshots/thumbs/models/13_M1Grand.jpg" width="100%"></a><br><sub><b>M1Grand</b><br><code>models/Lighting/M1Grand.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/teal~2.rbxm"><img src="screenshots/thumbs/models/14_teal_2.jpg" width="100%"></a><br><sub><b>teal~2</b><br><code>models/Workspace/teal~2.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI controllers / window managers / menus | [`Local Gui`](source/scripts/Lighting/GRocket/Local%20Gui.client.lua) <sub>481 lines</sub> |
| Camera, cutscenes, screen shake | [`ScreenSpace`](source/scripts/Lighting/VIP%20Rocket/ScreenSpace.lua) <sub>192 lines</sub> |
| VFX, particles, beams, hit effects | [`Rocket`](source/scripts/Lighting/VIP%20Rocket/Script/Rocket.server.lua) <sub>142 lines</sub><br>[`Rocket`](source/scripts/Lighting/HeatRocket/Launcher/Rocket.server.lua) <sub>108 lines</sub><br>[`Script`](source/scripts/Lighting/Airstrike/LocalScript/Script.server.lua) <sub>124 lines</sub><br>[`Main`](source/scripts/Workspace/blue/Bright%20blue/Purchases/Fighter/Plane/MainParts/Seat/Plane/Main.client.lua) <sub>1434 lines</sub> |
| DataStore / player data | [`Music`](source/scripts/ServerScriptService/Music.server.lua) <sub>38 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`DevProductHandler`](source/scripts/ServerScriptService/DevProductHandler.server.lua) <sub>120 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`SwordScript`](source/scripts/Lighting/Venomshank/SwordScript.server.lua) <sub>183 lines</sub><br>[`SwordScript`](source/scripts/StarterPack/Sword/SwordScript.server.lua) <sub>173 lines</sub><br>[`Local Gui`](source/scripts/Lighting/GRocket/Local%20Gui.client.lua) <sub>481 lines</sub> |
| Tycoon / plots / bases / building | [`PurchaseHandler`](source/scripts/Workspace/blue/Bright%20blue/PurchaseHandler.server.lua) <sub>159 lines</sub><br>[`PurchaseHandler`](source/scripts/Workspace/violet/Bright%20violet/PurchaseHandler.server.lua) <sub>160 lines</sub> |
| Leaderboards & stats | [`LinkedLeaderboard`](source/scripts/Workspace/violet/LinkedLeaderboard.server.lua) <sub>192 lines</sub> |
| Sound & music | [`Music`](source/scripts/ServerScriptService/Music.server.lua) <sub>38 lines</sub> |

### In the curated script library

- [Classic tycoon kit purchase handler](../../Scripts/14-Tycoon-Plots/PurchaseHandler__advanced-warfare-tycoon.lua) — Classic berezaa tycoon kit purchase handler: collector part turns 'Cash' drops into stored cash, a giver pad pays it out to the owner, and every button clones its purchase into the tycoon when bought
- [Classic tycoon kit parts (regen, gate, dropper, upgrader, conveyor)](../../Scripts/14-Tycoon-Plots/TycoonKitParts__advanced-warfare-tycoon.lua) — The remaining pieces of the classic tycoon kit: CoreScript (backs up each tycoon and regenerates it when the owner leaves), the claim gate, a dropper (spawns a Part with a Cash IntValue every few...

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/Kohl's Admin Commands V2.server.lua`
- `scripts/ServerScriptService/Kohl's Admin Commands V2/LocalScriptBase.client.lua`
- `scripts/ServerScriptService/Kohl's Admin Commands V2/ScriptBase.server.lua`
- `scripts/ServerScriptService/Scripth's Admin.server.lua`
- `scripts/ServerScriptService/Scripth's Admin/SB.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
