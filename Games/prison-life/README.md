# Prison Life

> 🏙️ **Roleplay** · roleplay (cops vs prisoners) · source file `prisonlife.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/08_Home__diaryOfNamapo.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 15 ScreenGuis, 242 GUI objects → **34 screenshots** |
| Models (.rbxm) | 445 models, 23 model sets, 0 VFX sets |
| Lua builders (.lua) | 16 UI screens, 5 animation packs, 3 audio packs |
| Code | 1345 scripts, 47,873 lines |
| Asset ids | 58 animations, 193 sounds |
| Safety scan | 3 HIGH / 17 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Regular`×59, `SourceSansPro Bold`×44, `Arial Bold`×14, `Arial Regular`×8

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_WatchGui__Settings.jpg"><img src="screenshots/thumbs/21_WatchGui__Settings.jpg" width="100%"></a><br><sub><b>WatchGui</b> › Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_AmmoDisplay.jpg"><img src="screenshots/thumbs/37_AmmoDisplay.jpg" width="100%"></a><br><sub><b>AmmoDisplay</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_promptGui__Frame.jpg"><img src="screenshots/thumbs/11_promptGui__Frame.jpg" width="100%"></a><br><sub><b>promptGui</b> › Frame</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Home__intro.jpg"><img src="screenshots/thumbs/04_Home__intro.jpg" width="100%"></a><br><sub><b>Home</b> › intro</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_WatchGui__Stats.jpg"><img src="screenshots/thumbs/23_WatchGui__Stats.jpg" width="100%"></a><br><sub><b>WatchGui</b> › Stats</sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_Home__CraftingFrame.jpg"><img src="screenshots/thumbs/05_Home__CraftingFrame.jpg" width="100%"></a><br><sub><b>Home</b> › hud.CraftingFrame</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_TadashyPanel__Frame.jpg"><img src="screenshots/thumbs/19_TadashyPanel__Frame.jpg" width="100%"></a><br><sub><b>TadashyPanel</b> › Frame</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_Home__AddedGui.jpg"><img src="screenshots/thumbs/07_Home__AddedGui.jpg" width="100%"></a><br><sub><b>Home</b> › hud.AddedGui</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_Home__diaryOfNamapo.jpg"><img src="screenshots/thumbs/08_Home__diaryOfNamapo.jpg" width="100%"></a><br><sub><b>Home</b> › hud.diaryOfNamapo</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_USM_Exchange__Mainframe.jpg"><img src="screenshots/thumbs/09_USM_Exchange__Mainframe.jpg" width="100%"></a><br><sub><b>USM Exchange</b> › Mainframe</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_Home__votekickFrame.jpg"><img src="screenshots/thumbs/06_Home__votekickFrame.jpg" width="100%"></a><br><sub><b>Home</b> › hud.votekickFrame</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_ScreenGui.jpg"><img src="screenshots/thumbs/01_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_Screen.jpg"><img src="screenshots/thumbs/02_Screen.jpg" width="100%"></a><br><sub><b>Screen</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_TestGui__Frame.jpg"><img src="screenshots/thumbs/03_TestGui__Frame.jpg" width="100%"></a><br><sub><b>TestGui</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_camGui.jpg"><img src="screenshots/thumbs/10_camGui.jpg" width="100%"></a><br><sub><b>camGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Screen.jpg"><img src="screenshots/thumbs/12_Screen.jpg" width="100%"></a><br><sub><b>Screen</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_WatchGui__Spawner.jpg"><img src="screenshots/thumbs/20_WatchGui__Spawner.jpg" width="100%"></a><br><sub><b>WatchGui</b> › Spawner</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_WatchGui__AntiKill.jpg"><img src="screenshots/thumbs/22_WatchGui__AntiKill.jpg" width="100%"></a><br><sub><b>WatchGui</b> › AntiKill</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_WatchGui__Warn.jpg"><img src="screenshots/thumbs/24_WatchGui__Warn.jpg" width="100%"></a><br><sub><b>WatchGui</b> › Warn</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_WarnGui.jpg"><img src="screenshots/thumbs/25_WarnGui.jpg" width="100%"></a><br><sub><b>WarnGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_UpdateUI.jpg"><img src="screenshots/thumbs/26_UpdateUI.jpg" width="100%"></a><br><sub><b>UpdateUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_AmmoGui.jpg"><img src="screenshots/thumbs/27_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_AmmoGui.jpg"><img src="screenshots/thumbs/28_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_AmmoGui.jpg"><img src="screenshots/thumbs/29_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_AmmoGui.jpg"><img src="screenshots/thumbs/30_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/31_AmmoGui.jpg"><img src="screenshots/thumbs/31_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_AmmoGui.jpg"><img src="screenshots/thumbs/32_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_AmmoGui.jpg"><img src="screenshots/thumbs/33_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/34_AmmoGui.jpg"><img src="screenshots/thumbs/34_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/35_AmmoGui.jpg"><img src="screenshots/thumbs/35_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_AmmoGui.jpg"><img src="screenshots/thumbs/36_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_AmmoGui.jpg"><img src="screenshots/thumbs/39_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_ArrestGui.jpg"><img src="screenshots/thumbs/40_ArrestGui.jpg" width="100%"></a><br><sub><b>ArrestGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_AmmoGui.jpg"><img src="screenshots/thumbs/41_AmmoGui.jpg" width="100%"></a><br><sub><b>AmmoGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/builderman.rbxm"><img src="screenshots/thumbs/models/01_builderman.jpg" width="100%"></a><br><sub><b>builderman</b><br><code>models/ServerStorage/builderman.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Baller%20Gun.rbxm"><img src="screenshots/thumbs/models/02_Baller_Gun.jpg" width="100%"></a><br><sub><b>Baller Gun</b><br><code>models/ServerStorage/Baller Gun.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Prison_ITEMS/buttons/Car%20Spawner.rbxm"><img src="screenshots/thumbs/models/03_Car_Spawner.jpg" width="100%"></a><br><sub><b>Car Spawner</b><br><code>models/Workspace/Prison_ITEMS/buttons/Car Spawner.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Prison_ITEMS/hats/Police%20hat.rbxm"><img src="screenshots/thumbs/models/04_Police_hat.jpg" width="100%"></a><br><sub><b>Police hat</b><br><code>models/Workspace/Prison_ITEMS/hats/Police hat.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Prison_Cellblock.rbxm"><img src="screenshots/thumbs/models/05_Prison_Cellblock.jpg" width="100%"></a><br><sub><b>Prison_Cellblock</b><br><code>models/Workspace/Prison_Cellblock.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Key%20Card.rbxm"><img src="screenshots/thumbs/models/06_Key_Card.jpg" width="100%"></a><br><sub><b>Key Card</b><br><code>models/ServerStorage/Key Card.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/City_buildings/Storefront.rbxm"><img src="screenshots/thumbs/models/07_Storefront.jpg" width="100%"></a><br><sub><b>Storefront</b><br><code>models/Workspace/City_buildings/Storefront.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Trees/tree_med.rbxm"><img src="screenshots/thumbs/models/08_tree_med.jpg" width="100%"></a><br><sub><b>tree_med</b><br><code>models/Workspace/Trees/tree_med.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/NukeConfig/explosion/Ring.rbxm"><img src="screenshots/thumbs/models/09_Ring.jpg" width="100%"></a><br><sub><b>Ring</b><br><code>models/ReplicatedStorage/NukeConfig/explosion/Ring.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/sign~5.rbxm"><img src="screenshots/thumbs/models/10_sign_5.jpg" width="100%"></a><br><sub><b>sign~5</b><br><code>models/Workspace/sign~5.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Hats/CoastGuard/DressBlues/Enlisted.rbxm"><img src="screenshots/thumbs/models/11_Enlisted.jpg" width="100%"></a><br><sub><b>Enlisted</b><br><code>models/ReplicatedStorage/Hats/CoastGuard/DressBlues/Enlisted.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/admin%20gun%202.rbxm"><img src="screenshots/thumbs/models/12_admin_gun_2.jpg" width="100%"></a><br><sub><b>admin gun 2</b><br><code>models/ServerStorage/admin gun 2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Prison_ITEMS/buttons/Car%20Spawner~2.rbxm"><img src="screenshots/thumbs/models/13_Car_Spawner_2.jpg" width="100%"></a><br><sub><b>Car Spawner~2</b><br><code>models/Workspace/Prison_ITEMS/buttons/Car Spawner~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Prison_ITEMS/hats/Ski%20mask.rbxm"><img src="screenshots/thumbs/models/14_Ski_mask.jpg" width="100%"></a><br><sub><b>Ski mask</b><br><code>models/Workspace/Prison_ITEMS/hats/Ski mask.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`EmojiChatClientController`](source/scripts/StarterPlayer/StarterPlayerScripts/EmojiChatClientController.client.lua) <sub>418 lines</sub><br>[`Tween`](source/scripts/ServerScriptService/ForPlayers/TypingBubble/TypingBubble/TypingBubble/Tween.server.lua) <sub>10 lines</sub> |
| UI controllers / window managers / menus | [`Open_Close`](source/scripts/ServerScriptService/PipBoySystem/WatchGui/Open_Close.client.lua) <sub>97 lines</sub><br>[`UniformScript`](source/scripts/ReplicatedStorage/ExchangeServerScript/UniformGui/Frame/UniformScript.client.lua) <sub>60 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/Home/hud/Topbar/Pulldownmenu/LocalScript.client.lua) <sub>13 lines</sub><br>[`LocalScript`](source/scripts/ServerStorage/ADMIN%20FUG/LocalScript.client.lua) <sub>427 lines</sub> |
| Notifications, toasts, popups, prompts | [`PipBoySystem`](source/scripts/ServerScriptService/PipBoySystem.server.lua) <sub>314 lines</sub><br>[`GuiScript`](source/scripts/StarterGui/Home/hud/Topbar/GuiScript.client.lua) <sub>26 lines</sub><br>[`TadashyScript`](source/scripts/ServerScriptService/Tadashy/TadashyScript.server.lua) <sub>79 lines</sub> |
| Loading / intro screens | [`systemintro`](source/scripts/ServerScriptService/systemintro.server.lua) <sub>105 lines</sub> |
| Camera, cutscenes, screen shake | [`cameraintro`](source/scripts/ServerStorage/cameraintro.client.lua) <sub>10 lines</sub><br>[`cameraintro`](source/scripts/StarterGui/Home/intro/cameraintro.client.lua) <sub>24 lines</sub><br>[`Recoil`](source/scripts/ServerStorage/ADMIN%20FUG/Script/Recoil.client.lua) <sub>18 lines</sub> |
| VFX, particles, beams, hit effects | [`Script`](source/scripts/ServerStorage/ADMIN%20FUG/Script.server.lua) <sub>202 lines</sub><br>[`Rocket`](source/scripts/ServerStorage/RocketLauncher/Server/Rocket.server.lua) <sub>155 lines</sub> |
| DataStore / player data | [`TadashyAntiCheat`](source/scripts/ServerScriptService/Tadashy/TadashyAntiCheat.server.lua) <sub>268 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`LocalScript`](source/scripts/ServerStorage/ADMIN%20FUG/LocalScript.client.lua) <sub>427 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`GunServer`](source/scripts/ServerScriptService/GunServer.server.lua) <sub>281 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`TadashyAntiCheat`](source/scripts/ServerScriptService/Tadashy/TadashyAntiCheat.server.lua) <sub>268 lines</sub><br>[`TadashyScript`](source/scripts/ServerScriptService/Tadashy/TadashyScript.server.lua) <sub>79 lines</sub><br>[`SprintScript`](source/scripts/ServerScriptService/SprintScriptImporter/SprintScript.client.lua) <sub>29 lines</sub><br>[`arrest`](source/scripts/ServerScriptService/arrest.server.lua) <sub>73 lines</sub><br>[`Teleport`](source/scripts/Teams/Guards/Handcuffs/Handle/Teleport.server.lua) <sub>55 lines</sub> |
| Tycoon / plots / bases / building | [`Play`](source/scripts/ServerScriptService/Nuke/Play.server.lua) <sub>289 lines</sub><br>[`EmojiChatClientController`](source/scripts/StarterPlayer/StarterPlayerScripts/EmojiChatClientController.client.lua) <sub>418 lines</sub> |

### In the curated script library

- [Intro team select (server)](../../Scripts/04-Loading-Screens/IntroTeamSelectServer__prison-life.lua) — Server side of a menu intro: flags new players as 'in intro', tells the client to use the intro camera, then on team pick enforces team caps, respawns the player and switches the camera back.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerStorage/builderman/Script.server.lua`
- `scripts/Workspace/HD Admin/About/Settings/Loader.server.lua`
- `scripts/Workspace/Script.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
