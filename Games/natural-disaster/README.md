# Natural Disaster Survival (Sowiks)

> 🎉 **Party** · survival (random disasters) · source file `[ CATALOG ] Natural Disaster Made By Sowiks Fully Scripted !.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/02_MainGui__IntroPage.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 7 ScreenGuis, 94 GUI objects → **70 screenshots** |
| Models (.rbxm) | 113 models, 0 model sets, 1 VFX sets |
| Lua builders (.lua) | 14 UI screens, 6 animation packs, 1 audio packs |
| Code | 982 scripts, 186,540 lines |
| Asset ids | 104 animations, 165 sounds |
| Safety scan | 3 HIGH / 31 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `ComicNeueAngular Bold`×33, `Arial Bold`×16, `SourceSansPro Regular`×15, `SourceSansPro Bold`×9

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_HDAdminGUIs__Template4.jpg"><img src="screenshots/thumbs/13_HDAdminGUIs__Template4.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template4</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_HDAdminGUIs__Template5.jpg"><img src="screenshots/thumbs/14_HDAdminGUIs__Template5.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template5</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_HDAdminGUIs__Template6.jpg"><img src="screenshots/thumbs/15_HDAdminGUIs__Template6.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template6</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_HDAdminGUIs__Template8.jpg"><img src="screenshots/thumbs/18_HDAdminGUIs__Template8.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template8</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_HDAdminGUIs__Template10.jpg"><img src="screenshots/thumbs/21_HDAdminGUIs__Template10.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template10</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_HDAdminGUIs__Template11.jpg"><img src="screenshots/thumbs/22_HDAdminGUIs__Template11.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template11</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_HDAdminGUIs__Warnings.jpg"><img src="screenshots/thumbs/10_HDAdminGUIs__Warnings.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MainFrame.Warnings</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_HDAdminGUIs__Message.jpg"><img src="screenshots/thumbs/25_HDAdminGUIs__Message.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › Templates.Message</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_HDAdminGUIs__GlobalAnnouncement.jpg"><img src="screenshots/thumbs/26_HDAdminGUIs__GlobalAnnouncement.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › Templates.GlobalAnnouncement</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_ExportDialog.jpg"><img src="screenshots/thumbs/27_ExportDialog.jpg" width="100%"></a><br><sub><b>ExportDialog</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MainGui__IntroPage.jpg"><img src="screenshots/thumbs/02_MainGui__IntroPage.jpg" width="100%"></a><br><sub><b>MainGui</b> › IntroPage</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_MainGui__MultiDisasterSplash.jpg"><img src="screenshots/thumbs/05_MainGui__MultiDisasterSplash.jpg" width="100%"></a><br><sub><b>MainGui</b> › MultiDisasterSplash</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_HDAdminGUIs__FinalResult.jpg"><img src="screenshots/thumbs/17_HDAdminGUIs__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template7.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_HDAdminGUIs__FinalResult.jpg"><img src="screenshots/thumbs/20_HDAdminGUIs__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template9.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_HDAdminGUIs__FinalResult.jpg"><img src="screenshots/thumbs/24_HDAdminGUIs__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template12.FinalResult</sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_MainGui__WeatherMachinePage.jpg"><img src="screenshots/thumbs/04_MainGui__WeatherMachinePage.jpg" width="100%"></a><br><sub><b>MainGui</b> › WeatherMachinePage</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_HDAdminGUIs__Pages.jpg"><img src="screenshots/thumbs/09_HDAdminGUIs__Pages.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MainFrame.Pages</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_HDAdminGUIs__CmdBar.jpg"><img src="screenshots/thumbs/12_HDAdminGUIs__CmdBar.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › CmdBar</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainGui__SurviversPage.jpg"><img src="screenshots/thumbs/01_MainGui__SurviversPage.jpg" width="100%"></a><br><sub><b>MainGui</b> › SurviversPage</sub></td>
<td width="33%" valign="top"><a href="screenshots/03_MainGui__NextMapPage.jpg"><img src="screenshots/thumbs/03_MainGui__NextMapPage.jpg" width="100%"></a><br><sub><b>MainGui</b> › NextMapPage</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_HDAdminGUIs__MainFrame.jpg"><img src="screenshots/thumbs/16_HDAdminGUIs__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template7.MainFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_HDAdminGUIs__MainFrame.jpg"><img src="screenshots/thumbs/19_HDAdminGUIs__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template9.MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/23_HDAdminGUIs__MainFrame.jpg"><img src="screenshots/thumbs/23_HDAdminGUIs__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template12.MainFrame</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_EmoteGui_R15___ScrollingFrame.jpg"><img src="screenshots/thumbs/07_EmoteGui_R15___ScrollingFrame.jpg" width="100%"></a><br><sub><b>EmoteGui(R15)</b> › ScrollingFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_EmoteGui_R6___ScrollingFrame2.jpg"><img src="screenshots/thumbs/08_EmoteGui_R6___ScrollingFrame2.jpg" width="100%"></a><br><sub><b>EmoteGui(R6)</b> › ScrollingFrame2</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_MainGui__MapVotePage.jpg"><img src="screenshots/thumbs/06_MainGui__MapVotePage.jpg" width="100%"></a><br><sub><b>MainGui</b> › MapVotePage</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/28_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/29_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_BTGroupsGUI.jpg"><img src="screenshots/thumbs/30_BTGroupsGUI.jpg" width="100%"></a><br><sub><b>BTGroupsGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/31_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/32_Dock.jpg"><img src="screenshots/thumbs/32_Dock.jpg" width="100%"></a><br><sub><b>Dock</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_Dock__HelpInfo.jpg"><img src="screenshots/thumbs/33_Dock__HelpInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › HelpInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_Dock__PaintInfo.jpg"><img src="screenshots/thumbs/34_Dock__PaintInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.PaintInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_Dock__SurfaceInfo.jpg"><img src="screenshots/thumbs/35_Dock__SurfaceInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.SurfaceInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/36_Dock__MaterialInfo.jpg"><img src="screenshots/thumbs/36_Dock__MaterialInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.MaterialInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_Dock__AnchorInfo.jpg"><img src="screenshots/thumbs/37_Dock__AnchorInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.AnchorInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/38_Dock__NewPartInfo.jpg"><img src="screenshots/thumbs/38_Dock__NewPartInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.NewPartInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/39_Dock__MeshInfo.jpg"><img src="screenshots/thumbs/39_Dock__MeshInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.MeshInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_Dock__TextureInfo.jpg"><img src="screenshots/thumbs/40_Dock__TextureInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.TextureInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/41_Dock__LightingInfo.jpg"><img src="screenshots/thumbs/41_Dock__LightingInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.LightingInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_Dock__DecorateInfo.jpg"><img src="screenshots/thumbs/42_Dock__DecorateInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.DecorateInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/43_Dock__WeldInfo.jpg"><img src="screenshots/thumbs/43_Dock__WeldInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.WeldInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/44_Dock__CollisionInfo.jpg"><img src="screenshots/thumbs/44_Dock__CollisionInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.CollisionInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/45_Dock__MoveInfo.jpg"><img src="screenshots/thumbs/45_Dock__MoveInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.MoveInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_Dock__RotateInfo.jpg"><img src="screenshots/thumbs/46_Dock__RotateInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.RotateInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_Dock__ResizeInfo.jpg"><img src="screenshots/thumbs/47_Dock__ResizeInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.ResizeInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/48_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/49_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/49_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/50_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/50_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/51_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/51_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/52_BTNewPartToolGUI.jpg"><img src="screenshots/thumbs/52_BTNewPartToolGUI.jpg" width="100%"></a><br><sub><b>BTNewPartToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/53_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/54_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/54_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/55_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/55_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/56_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/56_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/57_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/57_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/58_BTHSVColorPicker.jpg"><img src="screenshots/thumbs/58_BTHSVColorPicker.jpg" width="100%"></a><br><sub><b>BTHSVColorPicker</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/59_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/59_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/60_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/60_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/61_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/61_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/62_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/62_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/63_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/63_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/64_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/64_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/65_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/65_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/66_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/66_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/67_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/67_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/68_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/69_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/70_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/70_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/71_BTWeldToolGUI.jpg"><img src="screenshots/thumbs/71_BTWeldToolGUI.jpg" width="100%"></a><br><sub><b>BTWeldToolGUI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/CustomFeatures/Server/Morphs/Ben.rbxm"><img src="screenshots/thumbs/models/01_Ben.jpg" width="100%"></a><br><sub><b>Ben</b><br><code>models/ServerScriptService/HD Admin Classic/CustomFeatures/Server/Morphs/Ben.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/Settings/Loader/MainModule/Server/Tools/Sword.rbxm"><img src="screenshots/thumbs/models/03_Sword.jpg" width="100%"></a><br><sub><b>Sword</b><br><code>models/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Tools/Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/Settings/Loader/MainModule/Server/Assets/BuildingTools/Building%20Tools.rbxm"><img src="screenshots/thumbs/models/04_Building_Tools.jpg" width="100%"></a><br><sub><b>Building Tools</b><br><code>models/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Assets/BuildingTools/Building Tools.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Structures/Happy%20Home.rbxm"><img src="screenshots/thumbs/models/05_Happy_Home.jpg" width="100%"></a><br><sub><b>Happy Home</b><br><code>models/ServerStorage/Structures/Happy Home.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/BillboardTop10.rbxm"><img src="screenshots/thumbs/models/06_BillboardTop10.jpg" width="100%"></a><br><sub><b>BillboardTop10</b><br><code>models/Workspace/BillboardTop10.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Cloud.rbxm"><img src="screenshots/thumbs/models/07_Cloud.jpg" width="100%"></a><br><sub><b>Cloud</b><br><code>models/ServerStorage/Cloud.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/WeatherMachine.rbxm"><img src="screenshots/thumbs/models/08_WeatherMachine.jpg" width="100%"></a><br><sub><b>WeatherMachine</b><br><code>models/Workspace/WeatherMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/Settings/Loader/MainModule/Server/Morphs/BaconMother.rbxm"><img src="screenshots/thumbs/models/09_BaconMother.jpg" width="100%"></a><br><sub><b>BaconMother</b><br><code>models/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Morphs/BaconMother.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/StarterPack/Cookie.rbxm"><img src="screenshots/thumbs/models/10_Cookie.jpg" width="100%"></a><br><sub><b>Cookie</b><br><code>models/StarterPack/Cookie.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Structures/Sky%20Tower.rbxm"><img src="screenshots/thumbs/models/11_Sky_Tower.jpg" width="100%"></a><br><sub><b>Sky Tower</b><br><code>models/ServerStorage/Structures/Sky Tower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/BillboardBalloon.rbxm"><img src="screenshots/thumbs/models/12_BillboardBalloon.jpg" width="100%"></a><br><sub><b>BillboardBalloon</b><br><code>models/Workspace/BillboardBalloon.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Island.rbxm"><img src="screenshots/thumbs/models/13_Island.jpg" width="100%"></a><br><sub><b>Island</b><br><code>models/Workspace/Island.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/Settings/Loader/MainModule/Server/Morphs/BaconSmith.rbxm"><img src="screenshots/thumbs/models/14_BaconSmith.jpg" width="100%"></a><br><sub><b>BaconSmith</b><br><code>models/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Morphs/BaconSmith.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Button`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Components/CatalogItem/InteractionFrame/Button.lua) <sub>207 lines</sub><br>[`ShopsButton`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/FeaturedController/BuildHomepage/ShopsButton.lua) <sub>147 lines</sub><br>[`ActionButton`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Components/ActionButton.lua) <sub>237 lines</sub><br>[`IconButton`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Components/IconButton.lua) <sub>233 lines</sub><br>[`Button`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Components/ContentFrame/Button.lua) <sub>226 lines</sub> |
| UI controllers / window managers / menus | [`CatalogClient`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient.lua) <sub>457 lines</sub><br>[`Satchel`](source/scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua) <sub>2182 lines</sub><br>[`CategoryController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/CategoryController.lua) <sub>861 lines</sub><br>[`OutfitFeedController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/OutfitFeedController.lua) <sub>1440 lines</sub><br>[`PopfeedClient`](source/scripts/ServerScriptService/BloxbizSDK/PopfeedClient.lua) <sub>1495 lines</sub> |
| Notifications, toasts, popups, prompts | [`NotificationBox`](source/scripts/ServerScriptService/BloxbizSDK/Styngr/StarterPlayer/StarterPlayerScripts/Components/NotificationBox.lua) <sub>128 lines</sub><br>[`PopupNotification`](source/scripts/ServerScriptService/BloxbizSDK/PopfeedClient/Gui/Components/PopupNotification.lua) <sub>68 lines</sub><br>[`Notification`](source/scripts/ServerScriptService/BloxbizSDK/PopfeedClient/Gui/Components/Notification.lua) <sub>301 lines</sub><br>[`BuyOutfitController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/BuyOutfitController.lua) <sub>300 lines</sub><br>[`OutfitsController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/OutfitsController.lua) <sub>557 lines</sub> |
| Loading / intro screens | [`GIF`](source/scripts/ServerScriptService/BloxbizSDK/GIF.lua) <sub>350 lines</sub><br>[`AvatarPreviewController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/AvatarPreviewController.lua) <sub>1222 lines</sub><br>[`FeaturedController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/FeaturedController.lua) <sub>95 lines</sub><br>[`LoadingState`](source/scripts/ServerScriptService/BloxbizSDK/PopfeedClient/Gui/Components/LoadingState.lua) <sub>121 lines</sub><br>[`BillboardClient`](source/scripts/ServerScriptService/BloxbizSDK/BillboardClient.lua) <sub>806 lines</sub> |
| Camera, cutscenes, screen shake | [`SetCamera`](source/scripts/ServerScriptService/BloxbizSDK/Ad3DClient/CharacterAd/SetCamera.lua) <sub>192 lines</sub><br>[`VideoPlayer`](source/scripts/ServerScriptService/BloxbizSDK/BillboardClient/VideoPlayer.lua) <sub>404 lines</sub><br>[`CameraView`](source/scripts/ServerScriptService/BloxbizSDK/PopfeedClient/Gui/Windows/CameraView.lua) <sub>496 lines</sub> |
| VFX, particles, beams, hit effects | [`EffectBuilder`](source/scripts/StarterGui/SpectateUI/Bar/Title/EffectBuilder.server.lua) <sub>158 lines</sub><br>[`MainScript`](source/scripts/ServerScriptService/MainScript.server.lua) <sub>2157 lines</sub> |
| DataStore / player data | [`DataManager`](source/scripts/ServerScriptService/BloxbizSDK/CatalogServer/DataManager.lua) <sub>166 lines</sub><br>[`AnalyticsDataStoreQueue`](source/scripts/ServerScriptService/BloxbizSDK/AnalyticsDataStoreQueue.lua) <sub>240 lines</sub><br>[`OutfitFeed`](source/scripts/ServerScriptService/BloxbizSDK/CatalogServer/OutfitFeed.lua) <sub>809 lines</sub><br>[`leaderstats`](source/scripts/ServerScriptService/leaderstats.server.lua) <sub>41 lines</sub><br>[`PlayerAnalyticsHistory`](source/scripts/ServerScriptService/BloxbizSDK/AnalyticsDataStoreQueue/PlayerAnalyticsHistory.lua) <sub>112 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MarketplaceServiceWrapper`](source/scripts/ServerScriptService/BloxbizSDK/MarketplaceServiceWrapper.lua) <sub>320 lines</sub><br>[`TrackMonetization`](source/scripts/ServerScriptService/BloxbizSDK/TrackMonetization.lua) <sub>483 lines</sub><br>[`Purchase`](source/scripts/ServerScriptService/BloxbizSDK/Styngr/StarterPlayer/StarterPlayerScripts/Components/Purchase.lua) <sub>128 lines</sub><br>[`ShopFeed`](source/scripts/ServerScriptService/BloxbizSDK/CatalogServer/ShopFeed.lua) <sub>557 lines</sub><br>[`PurchaseService`](source/scripts/ServerScriptService/BloxbizSDK/Styngr/ServerScriptService/Modules/PurchaseService.lua) <sub>348 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`FilterUtils`](source/scripts/ServerScriptService/BloxbizSDK/AdFilter/FilterUtils.lua) <sub>230 lines</sub><br>[`Satchel`](source/scripts/StarterPlayer/StarterPlayerScripts/Satchel/Satchel.lua) <sub>2182 lines</sub><br>[`MainScript`](source/scripts/ServerScriptService/MainScript.server.lua) <sub>2157 lines</sub><br>[`DataIndex`](source/scripts/ServerScriptService/BloxbizSDK/Utils/RBLXSerialize/Binary/DataIndex.lua) <sub>1116 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`MainScript`](source/scripts/ServerScriptService/MainScript.server.lua) <sub>2157 lines</sub><br>[`Raycast`](source/scripts/ServerScriptService/BloxbizSDK/BillboardClient/Raycast.lua) <sub>79 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Slider`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Classes/Slider.lua) <sub>368 lines</sub><br>[`LocalGuiScript`](source/scripts/StarterGui/MainGui/LocalGuiScript.client.lua) <sub>420 lines</sub> |
| Tycoon / plots / bases / building | [`RadioService`](source/scripts/ServerScriptService/BloxbizSDK/Styngr/ServerScriptService/Modules/RadioService.lua) <sub>564 lines</sub><br>[`Slider`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Classes/Slider.lua) <sub>368 lines</sub><br>[`DataIndex`](source/scripts/ServerScriptService/BloxbizSDK/Utils/RBLXSerialize/Binary/DataIndex.lua) <sub>1116 lines</sub><br>[`OutfitFeedController`](source/scripts/ServerScriptService/BloxbizSDK/CatalogClient/Controllers/OutfitFeedController.lua) <sub>1440 lines</sub><br>[`PostView`](source/scripts/ServerScriptService/BloxbizSDK/PopfeedClient/Gui/Components/PostView.lua) <sub>825 lines</sub> |
| Leaderboards & stats | [`leaderstats`](source/scripts/ServerScriptService/leaderstats.server.lua) <sub>41 lines</sub> |
| Admin panels & commands | [`Settings`](source/scripts/ServerScriptService/HD%20Admin%20Classic/Settings.lua) <sub>212 lines</sub> |
| Sound & music | [`AudioService`](source/scripts/ServerScriptService/BloxbizSDK/Styngr/StarterPlayer/StarterPlayerScripts/AudioService.lua) <sub>281 lines</sub><br>[`DataIndex`](source/scripts/ServerScriptService/BloxbizSDK/Utils/RBLXSerialize/Binary/DataIndex.lua) <sub>1116 lines</sub> |
| Daily rewards, quests, codes, playtime | [`BillboardClient`](source/scripts/ServerScriptService/BloxbizSDK/BillboardClient.lua) <sub>806 lines</sub><br>[`BillboardServer`](source/scripts/ServerScriptService/BloxbizSDK/BillboardServer.lua) <sub>551 lines</sub><br>[`AdFilter`](source/scripts/ServerScriptService/BloxbizSDK/AdFilter.lua) <sub>464 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`ChatUtil`](source/scripts/ServerScriptService/LegacyChatLoader/Shared/ChatUtil.lua) <sub>195 lines</sub><br>[`Utils`](source/scripts/ServerScriptService/BloxbizSDK/Utils.lua) <sub>513 lines</sub><br>[`OutfitFeed`](source/scripts/ServerScriptService/BloxbizSDK/CatalogServer/OutfitFeed.lua) <sub>809 lines</sub><br>[`Promise`](source/scripts/ServerScriptService/BloxbizSDK/Utils/Promise.lua) <sub>2069 lines</sub><br>[`BillboardServer`](source/scripts/ServerScriptService/BloxbizSDK/BillboardServer.lua) <sub>551 lines</sub> |

### In the curated script library

- [Simplest saved playtime stat](../../Scripts/15-Leaderboards/leaderstats-Playtime__natural-disaster.lua) — Tutorial-style leaderstats Time counter that saves on leave and BindToClose.
- [Fusion loading spinner](../../Scripts/04-Loading-Screens/LoadingSpinnerComponent__natural-disaster.lua) — Fusion UI component: an inline loading spinner shown while a state IsLoading is true (rotates on RenderStepped only while visible). Good for panels that fetch data.
- [Lightning fade](../../Scripts/06-VFX/LightningFade__natural-disaster.lua) — Tiny classic: fade a bolt model out frame by frame.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Assets/BuildingTools/Building Tools/AutomaticUpdating/MainModule/Building Tools/AutoUpdate/AutomaticUpdating.server.lua`
- `scripts/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Assets/BuildingTools/Building Tools/AutomaticUpdating/MainModule/Building Tools/Libraries/Cryo/List.lua`
- `scripts/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Assets/BuildingTools/Building Tools/AutomaticUpdating/MainModule/Building Tools/Libraries/Cryo/List/reverse.spec.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
