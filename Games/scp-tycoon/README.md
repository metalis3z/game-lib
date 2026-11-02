# SCP Tycoon

> 🏭 **Tycoon** · tycoon (SCP containment) · source file `SCP_Tycoon.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/05_InterfaceGUI__WeaponShopFrame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 4 ScreenGuis, 312 GUI objects → **9 screenshots** |
| Models (.rbxm) | 133 models, 0 model sets, 0 VFX sets |
| Lua builders (.lua) | 10 UI screens, 0 animation packs, 3 audio packs |
| Code | 202 scripts, 24,639 lines |
| Asset ids | 4 animations, 456 sounds |
| Safety scan | 2 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Regular`×70, `FredokaOne Regular`×19, `Fondamento Regular`×12, `Fondamento Bold`×8, `Arial Bold`×8

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_InterfaceGUI__BuyCashFrame.jpg"><img src="screenshots/thumbs/03_InterfaceGUI__BuyCashFrame.jpg" width="100%"></a><br><sub><b>InterfaceGUI</b> › BuyCashFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_InterfaceGUI__WeaponShopFrame.jpg"><img src="screenshots/thumbs/05_InterfaceGUI__WeaponShopFrame.jpg" width="100%"></a><br><sub><b>InterfaceGUI</b> › WeaponShopFrame</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_InterfaceGUI__ClaimTycoonFrame.jpg"><img src="screenshots/thumbs/02_InterfaceGUI__ClaimTycoonFrame.jpg" width="100%"></a><br><sub><b>InterfaceGUI</b> › ClaimTycoonFrame</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_StatusUI__InteractionMenu.jpg"><img src="screenshots/thumbs/08_StatusUI__InteractionMenu.jpg" width="100%"></a><br><sub><b>StatusUI</b> › InteractionMenu</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_LoadingGUI__Frame.jpg"><img src="screenshots/thumbs/06_LoadingGUI__Frame.jpg" width="100%"></a><br><sub><b>LoadingGUI</b> › Frame</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_GPShud.jpg"><img src="screenshots/thumbs/07_GPShud.jpg" width="100%"></a><br><sub><b>GPShud</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_InterfaceGUI.jpg"><img src="screenshots/thumbs/01_InterfaceGUI.jpg" width="100%"></a><br><sub><b>InterfaceGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_InterfaceGUI__GuideFrame.jpg"><img src="screenshots/thumbs/04_InterfaceGUI__GuideFrame.jpg" width="100%"></a><br><sub><b>InterfaceGUI</b> › GuideFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_StatusUI__Sistema.jpg"><img src="screenshots/thumbs/09_StatusUI__Sistema.jpg" width="100%"></a><br><sub><b>StatusUI</b> › Sistema</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/Appartment%20w_abandonned%20car.rbxm"><img src="screenshots/thumbs/models/01_Appartment_w_abandonned_car.jpg" width="100%"></a><br><sub><b>Appartment w_abandonned car</b><br><code>models/Workspace/Buildings/Appartment w_abandonned car.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/EnemyContainer/Enemy_HMG.rbxm"><img src="screenshots/thumbs/models/02_Enemy_HMG.jpg" width="100%"></a><br><sub><b>Enemy_HMG</b><br><code>models/ReplicatedStorage/EnemyContainer/Enemy_HMG.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ACS_Engine/GunModels/Client/HK416%20Mod.rbxm"><img src="screenshots/thumbs/models/03_HK416_Mod.jpg" width="100%"></a><br><sub><b>HK416 Mod</b><br><code>models/ReplicatedStorage/ACS_Engine/GunModels/Client/HK416 Mod.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/1.rbxm"><img src="screenshots/thumbs/models/04_1.jpg" width="100%"></a><br><sub><b>1</b><br><code>models/Workspace/Buildings/1.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Trees/Tree.rbxm"><img src="screenshots/thumbs/models/05_Tree.jpg" width="100%"></a><br><sub><b>Tree</b><br><code>models/Workspace/Trees/Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ACS_Engine/FX/BreachCharge.rbxm"><img src="screenshots/thumbs/models/06_BreachCharge.jpg" width="100%"></a><br><sub><b>BreachCharge</b><br><code>models/ReplicatedStorage/ACS_Engine/FX/BreachCharge.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Texture%20Pack.rbxm"><img src="screenshots/thumbs/models/07_Texture_Pack.jpg" width="100%"></a><br><sub><b>Texture Pack</b><br><code>models/ReplicatedStorage/Texture Pack.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/EnemyContainer/Enemy_Gunner.rbxm"><img src="screenshots/thumbs/models/08_Enemy_Gunner.jpg" width="100%"></a><br><sub><b>Enemy_Gunner</b><br><code>models/ReplicatedStorage/EnemyContainer/Enemy_Gunner.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ACS_Engine/GunModels/Client/G17.rbxm"><img src="screenshots/thumbs/models/09_G17.jpg" width="100%"></a><br><sub><b>G17</b><br><code>models/ReplicatedStorage/ACS_Engine/GunModels/Client/G17.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/1957%20CHEVROLET%20BEL%20AIR.rbxm"><img src="screenshots/thumbs/models/10_1957_CHEVROLET_BEL_AIR.jpg" width="100%"></a><br><sub><b>1957 CHEVROLET BEL AIR</b><br><code>models/Workspace/Buildings/1957 CHEVROLET BEL AIR.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Trees/Tree~2.rbxm"><img src="screenshots/thumbs/models/11_Tree_2.jpg" width="100%"></a><br><sub><b>Tree~2</b><br><code>models/Workspace/Trees/Tree~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/EnemyContainer/Enemy_Sniper.rbxm"><img src="screenshots/thumbs/models/12_Enemy_Sniper.jpg" width="100%"></a><br><sub><b>Enemy_Sniper</b><br><code>models/ReplicatedStorage/EnemyContainer/Enemy_Sniper.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/GunGiver.rbxm"><img src="screenshots/thumbs/models/13_GunGiver.jpg" width="100%"></a><br><sub><b>GunGiver</b><br><code>models/Workspace/Buildings/GunGiver.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Buildings/Model.rbxm"><img src="screenshots/thumbs/models/14_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Buildings/Model.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub><br>[`MedSys_FX`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/MedSys_FX.client.lua) <sub>201 lines</sub><br>[`Animations`](source/scripts/ReplicatedStorage/Weapons/AK74M/ACS_Modulo/Variaveis/Animations.lua) <sub>210 lines</sub><br>[`Animations`](source/scripts/ReplicatedStorage/Weapons/AUG%20A3/ACS_Modulo/Variaveis/Animations.lua) <sub>206 lines</sub><br>[`Animations`](source/scripts/ReplicatedStorage/Weapons/Binoculars/ACS_Modulo/Variaveis/Animations.lua) <sub>98 lines</sub> |
| UI controllers / window managers / menus | [`ACS_Server`](source/scripts/ServerScriptService/ACS_Server.server.lua) <sub>1466 lines</sub><br>[`MainNVG`](source/scripts/ServerScriptService/MainServerNVG%20%28Put%20in%20server%20script%20sevice%29/MainNVG.client.lua) <sub>249 lines</sub><br>[`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub> |
| Notifications, toasts, popups, prompts | [`GameEventsHandler`](source/scripts/ServerScriptService/GameEventsHandler.server.lua) <sub>109 lines</sub><br>[`ACS_Server`](source/scripts/ServerScriptService/ACS_Server.server.lua) <sub>1466 lines</sub> |
| Loading / intro screens | [`LoadHandler`](source/scripts/StarterGui/LoadingGUI/Frame/LoadHandler.client.lua) <sub>37 lines</sub> |
| Camera, cutscenes, screen shake | [`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub> |
| VFX, particles, beams, hit effects | [`ACS_Server`](source/scripts/ServerScriptService/ACS_Server.server.lua) <sub>1466 lines</sub><br>[`Hitmarker`](source/scripts/ReplicatedStorage/ACS_Engine/Modulos/Hitmarker.lua) <sub>882 lines</sub><br>[`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_CQC/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_Gunner/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_HMG/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_Sniper/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_Unarmed/AI.server.lua) <sub>507 lines</sub> |
| NPC / AI / monsters | [`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_CQC/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_Gunner/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_HMG/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_Sniper/AI.server.lua) <sub>606 lines</sub><br>[`AI`](source/scripts/ReplicatedStorage/EnemyContainer/Enemy_Unarmed/AI.server.lua) <sub>507 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Stances`](source/scripts/ReplicatedStorage/ACS_Engine/HUD/StatusUI/Stances.client.lua) <sub>623 lines</sub><br>[`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub><br>[`Config`](source/scripts/ReplicatedStorage/ACS_Engine/ServerConfigs/Config.lua) <sub>72 lines</sub> |
| Tycoon / plots / bases / building | [`ACS_Client`](source/scripts/StarterPlayer/StarterCharacterScripts/Saude/ACS_Client.client.lua) <sub>3167 lines</sub><br>[`EventsHandler`](source/scripts/ServerScriptService/EventsHandler.server.lua) <sub>40 lines</sub> |
| Sound & music | [`Hitmarker`](source/scripts/ReplicatedStorage/ACS_Engine/Modulos/Hitmarker.lua) <sub>882 lines</sub><br>[`ACS_Server`](source/scripts/ServerScriptService/ACS_Server.server.lua) <sub>1466 lines</sub> |

### In the curated script library

- [Studio splash + fake progress](../../Scripts/04-Loading-Screens/StudioSplashFakeProgress__scp-tycoon.lua) — Studio splash ('X Presents' then game title) using TweenPosition, followed by a cosmetic 'Loading Assets (n/482)' counter and bar, then the whole frame slides away.
- [Soldier AI with perception meter](../../Scripts/12-NPC-AI/PerceptionGunnerAI__scp-tycoon.lua) — ACS-gun enemy soldier: patrol / chase / memory modes, a perception value that fills while the player is visible before it starts shooting, memory that decays when sight is lost, walk speeds per state, spread, and armour-aware damage. (Same script is reused for CQC/HMG/Sniper with different settings.)
- [Hand-made tycoon (claim, buy pads, droppers, collector, laser)](../../Scripts/14-Tycoon-Plots/TycoonKit__scp-tycoon.lua) — A small hand-made tycoon: claim via RemoteEvent, buy pads that reveal a dropper/upgrade and enable it, droppers that clone a Drop on a cooldown, an upgrader that doubles each drop once, a...

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/Boards/AssetLoader.server.lua`
- `scripts/Workspace/Boards/R15Loader/Loader.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
