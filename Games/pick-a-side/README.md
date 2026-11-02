# Pick a Side

> 🎉 **Party** · party / team minigames · source file `Pick20Side.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/02_Gui__Money.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 34 ScreenGuis, 581 GUI objects → **21 screenshots** |
| Models (.rbxm) | 155 models, 0 model sets, 1 VFX sets |
| Lua builders (.lua) | 7 UI screens, 5 animation packs, 2 audio packs |
| Code | 440 scripts, 23,548 lines |
| Asset ids | 217 animations, 230 sounds |
| Safety scan | 1 HIGH / 3 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Arial Bold`×148, `SourceSansPro Regular`×74, `GothamSSm Heavy`×47, `GothamSSm Bold`×39, `Arial Regular`×26

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_Gui__Orig.jpg"><img src="screenshots/thumbs/13_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Quests.Windows.Orig</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_AmmoDisplay.jpg"><img src="screenshots/thumbs/22_AmmoDisplay.jpg" width="100%"></a><br><sub><b>AmmoDisplay</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Gui__Confirm.jpg"><img src="screenshots/thumbs/04_Gui__Confirm.jpg" width="100%"></a><br><sub><b>Gui</b> › Weapons.Windows.Confirm</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_Popups__Preview.jpg"><img src="screenshots/thumbs/17_Popups__Preview.jpg" width="100%"></a><br><sub><b>Popups</b> › Rolling.Preview</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_Topbar.jpg"><img src="screenshots/thumbs/16_Topbar.jpg" width="100%"></a><br><sub><b>Topbar</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Gui__Orig.jpg"><img src="screenshots/thumbs/03_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Weapons.Windows.Orig</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_Gui__Custom1.jpg"><img src="screenshots/thumbs/05_Gui__Custom1.jpg" width="100%"></a><br><sub><b>Gui</b> › Custom.Windows.Custom1</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_Gui__Custom2.jpg"><img src="screenshots/thumbs/07_Gui__Custom2.jpg" width="100%"></a><br><sub><b>Gui</b> › Custom.Windows.Custom2</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_Gui__Orig.jpg"><img src="screenshots/thumbs/08_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Friends.Windows.Orig</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_Gui__Orig.jpg"><img src="screenshots/thumbs/09_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Radio.Windows.Orig</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_Gui__Orig.jpg"><img src="screenshots/thumbs/10_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Report.Windows.Orig</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_Gui__Msg.jpg"><img src="screenshots/thumbs/11_Gui__Msg.jpg" width="100%"></a><br><sub><b>Gui</b> › Report.Windows.Msg</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Gui__Orig.jpg"><img src="screenshots/thumbs/12_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Like.Windows.Orig</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_Gui__Orig.jpg"><img src="screenshots/thumbs/14_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Revives.Windows.Orig</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_Gui__Orig.jpg"><img src="screenshots/thumbs/15_Gui__Orig.jpg" width="100%"></a><br><sub><b>Gui</b> › Auras.Windows.Orig</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_Gui__Money.jpg"><img src="screenshots/thumbs/02_Gui__Money.jpg" width="100%"></a><br><sub><b>Gui</b> › Weapons.Windows.Money</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_Gui__Money.jpg"><img src="screenshots/thumbs/06_Gui__Money.jpg" width="100%"></a><br><sub><b>Gui</b> › Custom.Windows.Money</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_ScopeGui__MainFrame.jpg"><img src="screenshots/thumbs/18_ScopeGui__MainFrame.jpg" width="100%"></a><br><sub><b>ScopeGui</b> › MainFrame</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Gui.jpg"><img src="screenshots/thumbs/01_Gui.jpg" width="100%"></a><br><sub><b>Gui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_HelpGui.jpg"><img src="screenshots/thumbs/19_HelpGui.jpg" width="100%"></a><br><sub><b>HelpGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_SoSGui.jpg"><img src="screenshots/thumbs/20_SoSGui.jpg" width="100%"></a><br><sub><b>SoSGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Weapons/221173389.rbxm"><img src="screenshots/thumbs/models/01_221173389.jpg" width="100%"></a><br><sub><b>221173389</b><br><code>models/ReplicatedStorage/Weapons/221173389.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Auras/Heavenbound.rbxm"><img src="screenshots/thumbs/models/02_Heavenbound.jpg" width="100%"></a><br><sub><b>Heavenbound</b><br><code>models/ReplicatedStorage/Auras/Heavenbound.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Dummies/Dummy.rbxm"><img src="screenshots/thumbs/models/03_Dummy.jpg" width="100%"></a><br><sub><b>Dummy</b><br><code>models/Lighting/Dummies/Dummy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboard/Kills.rbxm"><img src="screenshots/thumbs/models/04_Kills.jpg" width="100%"></a><br><sub><b>Kills</b><br><code>models/Workspace/Leaderboard/Kills.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Portals/Portal.rbxm"><img src="screenshots/thumbs/models/05_Portal.jpg" width="100%"></a><br><sub><b>Portal</b><br><code>models/Workspace/Portals/Portal.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Plant%201.rbxm"><img src="screenshots/thumbs/models/06_Plant_1.jpg" width="100%"></a><br><sub><b>Plant 1</b><br><code>models/Workspace/Lobby/Plant 1.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Pedastal.rbxm"><img src="screenshots/thumbs/models/07_Pedastal.jpg" width="100%"></a><br><sub><b>Pedastal</b><br><code>models/Workspace/Pedastal.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Auras/Evil.rbxm"><img src="screenshots/thumbs/models/08_Evil.jpg" width="100%"></a><br><sub><b>Evil</b><br><code>models/ReplicatedStorage/Auras/Evil.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Lighting/Dummies/Dummy~2.rbxm"><img src="screenshots/thumbs/models/09_Dummy_2.jpg" width="100%"></a><br><sub><b>Dummy~2</b><br><code>models/Lighting/Dummies/Dummy~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboard/Level.rbxm"><img src="screenshots/thumbs/models/10_Level.jpg" width="100%"></a><br><sub><b>Level</b><br><code>models/Workspace/Leaderboard/Level.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Portals/Portal~2.rbxm"><img src="screenshots/thumbs/models/11_Portal_2.jpg" width="100%"></a><br><sub><b>Portal~2</b><br><code>models/Workspace/Portals/Portal~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Plant%201~2.rbxm"><img src="screenshots/thumbs/models/12_Plant_1_2.jpg" width="100%"></a><br><sub><b>Plant 1~2</b><br><code>models/Workspace/Lobby/Plant 1~2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Scoreboard.rbxm"><img src="screenshots/thumbs/models/13_Scoreboard.jpg" width="100%"></a><br><sub><b>Scoreboard</b><br><code>models/Workspace/Scoreboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Auras/Eldritch.rbxm"><img src="screenshots/thumbs/models/14_Eldritch.jpg" width="100%"></a><br><sub><b>Eldritch</b><br><code>models/ReplicatedStorage/Auras/Eldritch.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Rolling`](source/scripts/StarterGui/Popups/Rolling/Rolling.client.lua) <sub>195 lines</sub> |
| Notifications, toasts, popups, prompts | [`L_Messages`](source/scripts/StarterGui/Gui/Messages/L_Messages.client.lua) <sub>100 lines</sub><br>[`Rolling`](source/scripts/StarterGui/Popups/Rolling/Rolling.client.lua) <sub>195 lines</sub><br>[`Auras`](source/scripts/StarterGui/Gui/Auras/Windows/Orig/Auras.client.lua) <sub>173 lines</sub><br>[`M_Chat`](source/scripts/StarterGui/Gui/Chat/M_Chat.client.lua) <sub>80 lines</sub><br>[`Like`](source/scripts/StarterGui/Gui/Like/Like.client.lua) <sub>44 lines</sub> |
| Loading / intro screens | [`LocalScript`](source/scripts/ReplicatedStorage/Weapons/283756680/LocalScript.client.lua) <sub>581 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Weapons/287425246/LocalScript.client.lua) <sub>277 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Weapons/295460073/LocalScript.client.lua) <sub>281 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Weapons/304720496/LocalScript.client.lua) <sub>234 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraShaker`](source/scripts/ReplicatedStorage/Modules/CameraShaker.lua) <sub>178 lines</sub><br>[`CameraShakeInstance`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShakeInstance.lua) <sub>174 lines</sub><br>[`CameraShakePresets`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShakePresets.lua) <sub>85 lines</sub><br>[`L_Camera`](source/scripts/StarterPlayer/StarterPlayerScripts/L_Camera.client.lua) <sub>23 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Weapons/283756680/LocalScript.client.lua) <sub>581 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Rolling`](source/scripts/StarterGui/Popups/Rolling/Rolling.client.lua) <sub>195 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Weapons/283756680/LocalScript.client.lua) <sub>581 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Sword`](source/scripts/ReplicatedStorage/Weapons/68603324/Sword.lua) <sub>362 lines</sub><br>[`Sword`](source/scripts/ReplicatedStorage/Weapons/77443704/Sword.lua) <sub>213 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`LocalKatanaScript`](source/scripts/ReplicatedStorage/Weapons/46846024/LocalKatanaScript.client.lua) <sub>222 lines</sub> |
| Daily rewards, quests, codes, playtime | [`Quests`](source/scripts/StarterGui/Gui/Quests/Windows/Orig/Quests.client.lua) <sub>135 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`GoodSignal`](source/scripts/ReplicatedStorage/Modules/GoodSignal.lua) <sub>143 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Weapons/304720496/Script/ZombieScript.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
