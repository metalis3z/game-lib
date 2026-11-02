# Click Keyboard Tower

> 🧗 **Obby** · clicker / tower obby · source file `CLICK KEYBOARD TOWER parkyeon-jin.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/02_MainUI__ShopFrame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 4 ScreenGuis, 978 GUI objects → **24 screenshots** |
| Models (.rbxm) | 174 models, 71 model sets, 8 VFX sets |
| Lua builders (.lua) | 6 UI screens, 0 animation packs, 3 audio packs |
| Code | 88 scripts, 2,346 lines |
| Asset ids | 0 animations, 2443 sounds |
| Safety scan | 1 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Roboto Regular`×149, `Zekton Regular`×136, `Roboto Light`×59, `SourceSansPro Regular`×47, `Nunito Regular`×38

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MainUI__ShopFrame.jpg"><img src="screenshots/thumbs/02_MainUI__ShopFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › ShopFrame</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_HDAdminInterface__Template4.jpg"><img src="screenshots/thumbs/07_HDAdminInterface__Template4.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template4</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_HDAdminInterface__Template5.jpg"><img src="screenshots/thumbs/08_HDAdminInterface__Template5.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template5</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_HDAdminInterface__Template6.jpg"><img src="screenshots/thumbs/09_HDAdminInterface__Template6.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template6</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_HDAdminInterface__Template8.jpg"><img src="screenshots/thumbs/12_HDAdminInterface__Template8.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template8</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_HDAdminInterface__Template10.jpg"><img src="screenshots/thumbs/15_HDAdminInterface__Template10.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template10</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_HDAdminInterface__Template11.jpg"><img src="screenshots/thumbs/16_HDAdminInterface__Template11.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template11</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_HDAdminInterface__Template14.jpg"><img src="screenshots/thumbs/19_HDAdminInterface__Template14.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template14</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_HDAdminInterface__Template13.jpg"><img src="screenshots/thumbs/20_HDAdminInterface__Template13.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template13</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_HDAdminInterface__Template16.jpg"><img src="screenshots/thumbs/22_HDAdminInterface__Template16.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template16</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_HDAdminInterface__Template18.jpg"><img src="screenshots/thumbs/23_HDAdminInterface__Template18.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template18</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_HDAdminInterface__Message.jpg"><img src="screenshots/thumbs/05_HDAdminInterface__Message.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › Templates.Message</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_HDAdminInterface__GlobalAnnouncement.jpg"><img src="screenshots/thumbs/06_HDAdminInterface__GlobalAnnouncement.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › Templates.GlobalAnnouncement</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_HDAdminInterface__Warnings.jpg"><img src="screenshots/thumbs/25_HDAdminInterface__Warnings.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MainFrame.Warnings</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/11_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template7.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/14_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template9.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/18_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template12.FinalResult</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_HDAdminInterface__Notices.jpg"><img src="screenshots/thumbs/03_HDAdminInterface__Notices.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › Notices</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_HDAdminInterface__CmdBar.jpg"><img src="screenshots/thumbs/04_HDAdminInterface__CmdBar.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › CmdBar</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_HDAdminInterface__Pages.jpg"><img src="screenshots/thumbs/24_HDAdminInterface__Pages.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MainFrame.Pages</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainUI.jpg"><img src="screenshots/thumbs/01_MainUI.jpg" width="100%"></a><br><sub><b>MainUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/10_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template7.MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/13_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template9.MainFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/17_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template12.MainFrame</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/.%20.%20.rbxm"><img src="screenshots/thumbs/models/01__.jpg" width="100%"></a><br><sub><b>. . </b><br><code>models/Workspace/. . .rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Model~77/ModelKey__x120.rbxm"><img src="screenshots/thumbs/models/02_ModelKey_x120.jpg" width="100%"></a><br><sub><b>ModelKey__x120</b><br><code>models/Workspace/Model~77/ModelKey__x120.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/ThreeDTextObject.rbxm"><img src="screenshots/thumbs/models/03_ThreeDTextObject.jpg" width="100%"></a><br><sub><b>ThreeDTextObject</b><br><code>models/Workspace/ThreeDTextObject.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Arrow%20Sign.rbxm"><img src="screenshots/thumbs/models/04_Arrow_Sign.jpg" width="100%"></a><br><sub><b>Arrow Sign</b><br><code>models/Workspace/Arrow Sign.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Boombox_Radio.rbxm"><img src="screenshots/thumbs/models/05_Boombox_Radio.jpg" width="100%"></a><br><sub><b>Boombox_Radio</b><br><code>models/Workspace/Boombox_Radio.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/ThreeDTextObject~2.rbxm"><img src="screenshots/thumbs/models/07_ThreeDTextObject_2.jpg" width="100%"></a><br><sub><b>ThreeDTextObject~2</b><br><code>models/Workspace/ThreeDTextObject~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/AdminBoard.rbxm"><img src="screenshots/thumbs/models/08_AdminBoard.jpg" width="100%"></a><br><sub><b>AdminBoard</b><br><code>models/Workspace/AdminBoard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/World%20Extras/Pole.rbxm"><img src="screenshots/thumbs/models/10_Pole.jpg" width="100%"></a><br><sub><b>Pole</b><br><code>models/Workspace/World Extras/Pole.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/World%20Extras/Part~92.rbxm"><img src="screenshots/thumbs/models/11_Part_92.jpg" width="100%"></a><br><sub><b>Part~92</b><br><code>models/Workspace/World Extras/Part~92.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Rainbow.rbxm"><img src="screenshots/thumbs/models/12_Rainbow.jpg" width="100%"></a><br><sub><b>Rainbow</b><br><code>models/Workspace/Rainbow.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Speed%20Coil%20Giver.rbxm"><img src="screenshots/thumbs/models/13_Speed_Coil_Giver.jpg" width="100%"></a><br><sub><b>Speed Coil Giver</b><br><code>models/Workspace/Speed Coil Giver.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BoomBox%20Giver.rbxm"><img src="screenshots/thumbs/models/14_BoomBox_Giver.jpg" width="100%"></a><br><sub><b>BoomBox Giver</b><br><code>models/Workspace/BoomBox Giver.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`LocalScript`](source/scripts/StarterGui/MainUI/ShopFrame/ShopToggle/LocalScript.client.lua) <sub>23 lines</sub> |
| UI controllers / window managers / menus | [`ShiftGUI`](source/scripts/StarterGui/ShiftLockButton%20%28Put%20in%20StarterGui%29/ImageButton/ShiftGUI.client.lua) <sub>72 lines</sub> |
| Sound & music | [`KeySoundHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/KeySoundHandler.client.lua) <sub>18 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`WSManager`](source/scripts/Workspace/AllKeys/CanCollide/Model/ModelKey/KeyMesh/Decal/WSManager.server.lua) <sub>1068 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/HD Admin/Core/MainModule.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
