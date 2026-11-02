# Animal Hospital (modded)

> 🏙️ **Roleplay** · roleplay / tycoon · source file `VIP - ANIMAL HOSPITALMODDED.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/19_GiftList__Frame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 43 ScreenGuis, 1051 GUI objects → **94 screenshots** |
| Models (.rbxm) | 447 models, 16 model sets, 5 VFX sets |
| Lua builders (.lua) | 68 UI screens, 7 animation packs, 9 audio packs |
| Code | 916 scripts, 158,024 lines |
| Asset ids | 452 animations, 825 sounds |
| Safety scan | 3 HIGH / 17 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×85, `Noto Serif SC Bold`×78, `SourceSansPro Regular`×46, `Noto Serif SC Regular`×35, `FredokaOne Regular`×26

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_Shop__Frame.jpg"><img src="screenshots/thumbs/17_Shop__Frame.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_GiftList__Frame.jpg"><img src="screenshots/thumbs/19_GiftList__Frame.jpg" width="100%"></a><br><sub><b>GiftList</b> › Frame</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_Menu.jpg"><img src="screenshots/thumbs/12_Menu.jpg" width="100%"></a><br><sub><b>Menu</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_HDAdminGUIs__Template4.jpg"><img src="screenshots/thumbs/36_HDAdminGUIs__Template4.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template4</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_HDAdminGUIs__Template5.jpg"><img src="screenshots/thumbs/37_HDAdminGUIs__Template5.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_HDAdminGUIs__Template6.jpg"><img src="screenshots/thumbs/38_HDAdminGUIs__Template6.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template6</sub></td>
<td width="33%" valign="top"><a href="screenshots/41_HDAdminGUIs__Template8.jpg"><img src="screenshots/thumbs/41_HDAdminGUIs__Template8.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template8</sub></td>
<td width="33%" valign="top"><a href="screenshots/44_HDAdminGUIs__Template10.jpg"><img src="screenshots/thumbs/44_HDAdminGUIs__Template10.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template10</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/45_HDAdminGUIs__Template11.jpg"><img src="screenshots/thumbs/45_HDAdminGUIs__Template11.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template11</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Dialogue__black.jpg"><img src="screenshots/thumbs/01_Dialogue__black.jpg" width="100%"></a><br><sub><b>Dialogue</b> › Frame.black</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_HDAdminGUIs__Warnings.jpg"><img src="screenshots/thumbs/33_HDAdminGUIs__Warnings.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MainFrame.Warnings</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_HDAdminGUIs__Message.jpg"><img src="screenshots/thumbs/48_HDAdminGUIs__Message.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › Templates.Message</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/49_HDAdminGUIs__GlobalAnnouncement.jpg"><img src="screenshots/thumbs/49_HDAdminGUIs__GlobalAnnouncement.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › Templates.GlobalAnnouncement</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_ExportDialog.jpg"><img src="screenshots/thumbs/63_ExportDialog.jpg" width="100%"></a><br><sub><b>ExportDialog</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_RoundStatsDetailed__paper.jpg"><img src="screenshots/thumbs/07_RoundStatsDetailed__paper.jpg" width="100%"></a><br><sub><b>RoundStatsDetailed</b> › Frame.paper</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_RoundStatsDetailed__Info.jpg"><img src="screenshots/thumbs/09_RoundStatsDetailed__Info.jpg" width="100%"></a><br><sub><b>RoundStatsDetailed</b> › Frame.Info</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_RoundStatsDetailed__Photo.jpg"><img src="screenshots/thumbs/10_RoundStatsDetailed__Photo.jpg" width="100%"></a><br><sub><b>RoundStatsDetailed</b> › Photo</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_HDAdminGUIs__FinalResult.jpg"><img src="screenshots/thumbs/40_HDAdminGUIs__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template7.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/43_HDAdminGUIs__FinalResult.jpg"><img src="screenshots/thumbs/43_HDAdminGUIs__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template9.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_HDAdminGUIs__FinalResult.jpg"><img src="screenshots/thumbs/47_HDAdminGUIs__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template12.FinalResult</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_AdminPanel__AdminPanel.jpg"><img src="screenshots/thumbs/24_AdminPanel__AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › AdminPanel</sub></td>
<td width="33%" valign="top"><a href="screenshots/29_ExtraPanel.jpg"><img src="screenshots/thumbs/29_ExtraPanel.jpg" width="100%"></a><br><sub><b>ExtraPanel</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_ExtraPanel__Select.jpg"><img src="screenshots/thumbs/30_ExtraPanel__Select.jpg" width="100%"></a><br><sub><b>ExtraPanel</b> › Main.Header.Select</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_HDAdminGUIs__Pages.jpg"><img src="screenshots/thumbs/32_HDAdminGUIs__Pages.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MainFrame.Pages</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_HDAdminGUIs__Notices.jpg"><img src="screenshots/thumbs/34_HDAdminGUIs__Notices.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › Notices</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_HDAdminGUIs__CmdBar.jpg"><img src="screenshots/thumbs/35_HDAdminGUIs__CmdBar.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › CmdBar</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_MainUI__PollVoting.jpg"><img src="screenshots/thumbs/28_MainUI__PollVoting.jpg" width="100%"></a><br><sub><b>MainUI</b> › PollVoting</sub></td>
<td width="33%" valign="top"><a href="screenshots/39_HDAdminGUIs__MainFrame.jpg"><img src="screenshots/thumbs/39_HDAdminGUIs__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template7.MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_HDAdminGUIs__MainFrame.jpg"><img src="screenshots/thumbs/42_HDAdminGUIs__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template9.MainFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_HDAdminGUIs__MainFrame.jpg"><img src="screenshots/thumbs/46_HDAdminGUIs__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminGUIs</b> › MenuTemplates.Template12.MainFrame</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_CharacterSelection__Selection.jpg"><img src="screenshots/thumbs/13_CharacterSelection__Selection.jpg" width="100%"></a><br><sub><b>CharacterSelection</b> › Selection</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_CharacterSelection__AnomalySelection.jpg"><img src="screenshots/thumbs/14_CharacterSelection__AnomalySelection.jpg" width="100%"></a><br><sub><b>CharacterSelection</b> › AnomalySelection</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_CharacterSelection__PremadeSelection.jpg"><img src="screenshots/thumbs/15_CharacterSelection__PremadeSelection.jpg" width="100%"></a><br><sub><b>CharacterSelection</b> › PremadeSelection</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_CharacterCreation.jpg"><img src="screenshots/thumbs/16_CharacterCreation.jpg" width="100%"></a><br><sub><b>CharacterCreation</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_Skins.jpg"><img src="screenshots/thumbs/18_Skins.jpg" width="100%"></a><br><sub><b>Skins</b></sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_RoundStatsDetailed__background.jpg"><img src="screenshots/thumbs/08_RoundStatsDetailed__background.jpg" width="100%"></a><br><sub><b>RoundStatsDetailed</b> › Frame.background</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_CameraSystem__Container.jpg"><img src="screenshots/thumbs/02_CameraSystem__Container.jpg" width="100%"></a><br><sub><b>CameraSystem</b> › Controls.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/03_HeartbeatMinigameUI__Frame.jpg"><img src="screenshots/thumbs/03_HeartbeatMinigameUI__Frame.jpg" width="100%"></a><br><sub><b>HeartbeatMinigameUI</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_Sanity.jpg"><img src="screenshots/thumbs/04_Sanity.jpg" width="100%"></a><br><sub><b>Sanity</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_Shift.jpg"><img src="screenshots/thumbs/05_Shift.jpg" width="100%"></a><br><sub><b>Shift</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_PlayerDied__Frame.jpg"><img src="screenshots/thumbs/06_PlayerDied__Frame.jpg" width="100%"></a><br><sub><b>PlayerDied</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_Strikes__Frame.jpg"><img src="screenshots/thumbs/11_Strikes__Frame.jpg" width="100%"></a><br><sub><b>Strikes</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Classes__Frame.jpg"><img src="screenshots/thumbs/20_Classes__Frame.jpg" width="100%"></a><br><sub><b>Classes</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Classes__Info.jpg"><img src="screenshots/thumbs/21_Classes__Info.jpg" width="100%"></a><br><sub><b>Classes</b> › Info</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Classes__Center.jpg"><img src="screenshots/thumbs/22_Classes__Center.jpg" width="100%"></a><br><sub><b>Classes</b> › Center</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Actions.jpg"><img src="screenshots/thumbs/23_Actions.jpg" width="100%"></a><br><sub><b>Actions</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_MOBILE_BUTTONS.jpg"><img src="screenshots/thumbs/25_MOBILE_BUTTONS.jpg" width="100%"></a><br><sub><b>MOBILE_BUTTONS</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_P2W.jpg"><img src="screenshots/thumbs/26_P2W.jpg" width="100%"></a><br><sub><b>P2W</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Troll.jpg"><img src="screenshots/thumbs/27_Troll.jpg" width="100%"></a><br><sub><b>Troll</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/31_RadioGui.jpg"><img src="screenshots/thumbs/31_RadioGui.jpg" width="100%"></a><br><sub><b>RadioGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/50_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/50_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/51_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/51_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/52_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/52_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/53_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/54_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/54_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/55_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/55_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/56_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/56_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/57_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/58_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/58_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/59_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/59_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/60_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/60_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/61_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/62_BTWeldToolGUI.jpg"><img src="screenshots/thumbs/62_BTWeldToolGUI.jpg" width="100%"></a><br><sub><b>BTWeldToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/64_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/64_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/65_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/65_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/66_BTGroupsGUI.jpg"><img src="screenshots/thumbs/66_BTGroupsGUI.jpg" width="100%"></a><br><sub><b>BTGroupsGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/67_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/67_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_Dock.jpg"><img src="screenshots/thumbs/68_Dock.jpg" width="100%"></a><br><sub><b>Dock</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_Dock__HelpInfo.jpg"><img src="screenshots/thumbs/69_Dock__HelpInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › HelpInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/70_Dock__PaintInfo.jpg"><img src="screenshots/thumbs/70_Dock__PaintInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.PaintInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_Dock__SurfaceInfo.jpg"><img src="screenshots/thumbs/71_Dock__SurfaceInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.SurfaceInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/72_Dock__MaterialInfo.jpg"><img src="screenshots/thumbs/72_Dock__MaterialInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.MaterialInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/73_Dock__AnchorInfo.jpg"><img src="screenshots/thumbs/73_Dock__AnchorInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.AnchorInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/74_Dock__NewPartInfo.jpg"><img src="screenshots/thumbs/74_Dock__NewPartInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.NewPartInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/75_Dock__MeshInfo.jpg"><img src="screenshots/thumbs/75_Dock__MeshInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.MeshInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/76_Dock__TextureInfo.jpg"><img src="screenshots/thumbs/76_Dock__TextureInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.TextureInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/77_Dock__LightingInfo.jpg"><img src="screenshots/thumbs/77_Dock__LightingInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.LightingInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/78_Dock__DecorateInfo.jpg"><img src="screenshots/thumbs/78_Dock__DecorateInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.DecorateInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_Dock__WeldInfo.jpg"><img src="screenshots/thumbs/79_Dock__WeldInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.WeldInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/80_Dock__CollisionInfo.jpg"><img src="screenshots/thumbs/80_Dock__CollisionInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.CollisionInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/81_Dock__MoveInfo.jpg"><img src="screenshots/thumbs/81_Dock__MoveInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.MoveInfo</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/82_Dock__RotateInfo.jpg"><img src="screenshots/thumbs/82_Dock__RotateInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.RotateInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/83_Dock__ResizeInfo.jpg"><img src="screenshots/thumbs/83_Dock__ResizeInfo.jpg" width="100%"></a><br><sub><b>Dock</b> › ToolInformation.ResizeInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/84_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/84_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/85_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/85_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/86_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/86_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/87_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/87_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/88_BTNewPartToolGUI.jpg"><img src="screenshots/thumbs/88_BTNewPartToolGUI.jpg" width="100%"></a><br><sub><b>BTNewPartToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/89_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/89_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/90_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/90_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/91_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/91_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/92_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/92_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/93_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/93_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/94_BTHSVColorPicker.jpg"><img src="screenshots/thumbs/94_BTHSVColorPicker.jpg" width="100%"></a><br><sub><b>BTHSVColorPicker</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/CustomFeatures/Server/Morphs/Ben.rbxm"><img src="screenshots/thumbs/models/01_Ben.jpg" width="100%"></a><br><sub><b>Ben</b><br><code>models/ServerScriptService/HD Admin Classic/CustomFeatures/Server/Morphs/Ben.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ShopItemModels/Gun.rbxm"><img src="screenshots/thumbs/models/02_Gun.jpg" width="100%"></a><br><sub><b>Gun</b><br><code>models/ReplicatedStorage/ShopItemModels/Gun.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RoomFire.rbxm"><img src="screenshots/thumbs/models/04_RoomFire.jpg" width="100%"></a><br><sub><b>RoomFire</b><br><code>models/ReplicatedStorage/Misc/RoomFire.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Model__x102.rbxm"><img src="screenshots/thumbs/models/05_Model_x102.jpg" width="100%"></a><br><sub><b>Model__x102</b><br><code>models/Workspace/Model__x102.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ShopItemModels/CheckInSign.rbxm"><img src="screenshots/thumbs/models/06_CheckInSign.jpg" width="100%"></a><br><sub><b>CheckInSign</b><br><code>models/ReplicatedStorage/ShopItemModels/CheckInSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Misc/ShopSign.rbxm"><img src="screenshots/thumbs/models/07_ShopSign.jpg" width="100%"></a><br><sub><b>ShopSign</b><br><code>models/Workspace/Misc/ShopSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RoomFires/Room1__x8.rbxm"><img src="screenshots/thumbs/models/08_Room1_x8.jpg" width="100%"></a><br><sub><b>Room1__x8</b><br><code>models/ReplicatedStorage/Misc/RoomFires/Room1__x8.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Rooms/Emergency/Room8/MainSign.rbxm"><img src="screenshots/thumbs/models/09_MainSign.jpg" width="100%"></a><br><sub><b>MainSign</b><br><code>models/Workspace/Rooms/Emergency/Room8/MainSign.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Potted%20Plant.rbxm"><img src="screenshots/thumbs/models/10_Potted_Plant.jpg" width="100%"></a><br><sub><b>Potted Plant</b><br><code>models/Workspace/Potted Plant.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RatthewKeyAndNote.rbxm"><img src="screenshots/thumbs/models/11_RatthewKeyAndNote.jpg" width="100%"></a><br><sub><b>RatthewKeyAndNote</b><br><code>models/ReplicatedStorage/Misc/RatthewKeyAndNote.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/HD%20Admin%20Classic/Settings/Loader/MainModule/Server/Morphs/BaconMother.rbxm"><img src="screenshots/thumbs/models/12_BaconMother.jpg" width="100%"></a><br><sub><b>BaconMother</b><br><code>models/ServerScriptService/HD Admin Classic/Settings/Loader/MainModule/Server/Morphs/BaconMother.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RoomFires/Room1.rbxm"><img src="screenshots/thumbs/models/13_Room1.jpg" width="100%"></a><br><sub><b>Room1</b><br><code>models/ReplicatedStorage/Misc/RoomFires/Room1.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Chocolate%20bar.rbxm"><img src="screenshots/thumbs/models/14_Chocolate_bar.jpg" width="100%"></a><br><sub><b>Chocolate bar</b><br><code>models/Workspace/Chocolate bar.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`UITweening`](source/scripts/ReplicatedStorage/Modules/UITweening.lua) <sub>218 lines</sub><br>[`Buttons`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/Buttons.lua) <sub>248 lines</sub><br>[`ExtraPanelClient`](source/scripts/StarterGui/ExtraPanel/ExtraPanelClient.client.lua) <sub>202 lines</sub><br>[`Global`](source/scripts/StarterPlayer/StarterPlayerScripts/Global.client.lua) <sub>576 lines</sub><br>[`TrollOpenClient`](source/scripts/StarterGui/TrollButton/Troll/TrollOpenClient.client.lua) <sub>76 lines</sub> |
| UI controllers / window managers / menus | [`Window`](source/scripts/ServerScriptService/Cmdr/Cmdr/CmdrClient/CmdrInterface/Window.lua) <sub>337 lines</sub><br>[`EmergencyDoor`](source/scripts/ServerScriptService/EmergencyDoor.server.lua) <sub>126 lines</sub><br>[`StaffDoor`](source/scripts/ServerScriptService/StaffDoor.server.lua) <sub>126 lines</sub><br>[`DoorService`](source/scripts/ServerScriptService/DoorService.lua) <sub>92 lines</sub><br>[`MiscService`](source/scripts/ServerScriptService/MiscService.lua) <sub>176 lines</sub> |
| Notifications, toasts, popups, prompts | [`AdminPanelPromptOpen`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanelPromptOpen.client.lua) <sub>37 lines</sub><br>[`TrollActionServer`](source/scripts/ServerScriptService/TrollActionServer.server.lua) <sub>411 lines</sub><br>[`CheckInService`](source/scripts/ServerScriptService/CheckInService.lua) <sub>598 lines</sub><br>[`EmergencyService`](source/scripts/ServerScriptService/EmergencyService.lua) <sub>285 lines</sub><br>[`DoorsService`](source/scripts/ServerScriptService/DoorsService.lua) <sub>182 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraShaker`](source/scripts/ReplicatedStorage/Modules/CameraShaker.lua) <sub>15 lines</sub><br>[`CameraShaker`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShaker.lua) <sub>208 lines</sub><br>[`CameraShakeInstance`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShaker/CameraShakeInstance.lua) <sub>168 lines</sub><br>[`CameraShakePresets`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShaker/CameraShakePresets.lua) <sub>98 lines</sub><br>[`Global`](source/scripts/StarterPlayer/StarterPlayerScripts/Global.client.lua) <sub>576 lines</sub> |
| VFX, particles, beams, hit effects | [`CheckInService`](source/scripts/ServerScriptService/CheckInService.lua) <sub>598 lines</sub><br>[`MiscService`](source/scripts/ServerScriptService/MiscService.lua) <sub>176 lines</sub> |
| DataStore / player data | [`DataService`](source/scripts/ServerScriptService/DataService.lua) <sub>210 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationBuys`](source/scripts/ServerScriptService/MonetizationBuys.server.lua) <sub>221 lines</sub><br>[`CashShopBuyWiring`](source/scripts/StarterGui/Shop/Frame/inv/inv/Cash/CashShopBuyWiring.client.lua) <sub>85 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`AnomalyDirector`](source/scripts/ServerScriptService/AnomalyDirector.lua) <sub>414 lines</sub><br>[`TrollActionServer`](source/scripts/ServerScriptService/TrollActionServer.server.lua) <sub>411 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`GunService`](source/scripts/ServerScriptService/GunService.lua) <sub>327 lines</sub><br>[`SwordScript`](source/scripts/ReplicatedStorage/Items/ClassicSword/SwordScript.server.lua) <sub>229 lines</sub> |
| NPC / AI / monsters | [`PatientService`](source/scripts/ServerScriptService/PatientService.lua) <sub>932 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Global`](source/scripts/StarterPlayer/StarterPlayerScripts/Global.client.lua) <sub>576 lines</sub><br>[`CheckInService`](source/scripts/ServerScriptService/CheckInService.lua) <sub>598 lines</sub><br>[`PatientService`](source/scripts/ServerScriptService/PatientService.lua) <sub>932 lines</sub> |
| Tycoon / plots / bases / building | [`PatientCareService`](source/scripts/ServerScriptService/PatientCareService.lua) <sub>641 lines</sub> |
| Admin panels & commands | [`AdminBanKick`](source/scripts/ServerScriptService/AdminBanKick.server.lua) <sub>91 lines</sub><br>[`AdminGiftCommand`](source/scripts/ServerScriptService/AdminGiftCommand.server.lua) <sub>249 lines</sub><br>[`AdminPanelExtrasServer`](source/scripts/ServerScriptService/AdminPanelExtrasServer.server.lua) <sub>100 lines</sub><br>[`Commands`](source/scripts/ServerScriptService/HD%20Admin%20Classic/CustomFeatures/Server/Modules/Commands.lua) <sub>75 lines</sub><br>[`Settings`](source/scripts/ServerScriptService/HD%20Admin%20Classic/Settings.lua) <sub>212 lines</sub> |
| Sound & music | [`SanityLocal`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/SanityLocal.lua) <sub>198 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Util`](source/scripts/ServerScriptService/Cmdr/Cmdr/Shared/Util.lua) <sub>549 lines</sub><br>[`Window`](source/scripts/ServerScriptService/Cmdr/Cmdr/CmdrClient/CmdrInterface/Window.lua) <sub>337 lines</sub><br>[`EmergencyService`](source/scripts/ServerScriptService/EmergencyService.lua) <sub>285 lines</sub><br>[`ToolService`](source/scripts/ServerScriptService/ToolService.lua) <sub>328 lines</sub><br>[`ToolService1`](source/scripts/ServerScriptService/ToolService1.lua) <sub>300 lines</sub> |

### In the curated script library

- [Core SendNotification with button](../../Scripts/03-Notifications/JoinGroupCoreNotification__animal-hospital-modded.lua) — Uses the built-in StarterGui:SetCore("SendNotification") with a Join button + BindableFunction callback to prompt group join every few minutes if not a member.
- [Button + window toggle tweening](../../Scripts/01-UI-Animation/UITweening_ButtonAndWindowToggle__animal-hospital-modded.lua) — Button hover/press size tweens (original size stored as an attribute), keyboard-key press feedback, and a window toggle that grows from 5% with Back-out plus a camera FOV punch.

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
