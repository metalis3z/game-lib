# The Rake (kill test)

> 👻 **Horror** · horror survival (monster) · source file `THE_RAKE_KILL_TEST_ORIGINAL (1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/76_Message.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 19 ScreenGuis, 70 GUI objects → **62 screenshots** |
| Models (.rbxm) | 149 models, 3 model sets, 1 VFX sets |
| Lua builders (.lua) | 20 UI screens, 118 animation packs, 6 audio packs |
| Code | 1835 scripts, 430,610 lines |
| Asset ids | 305 animations, 424 sounds |
| Safety scan | 50 HIGH / 125 MED flags ([flags.txt](source/flags.txt)) |

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/101_ShopGui.jpg"><img src="screenshots/thumbs/101_ShopGui.jpg" width="100%"></a><br><sub><b>ShopGui</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_TaskManager.jpg"><img src="screenshots/thumbs/07_TaskManager.jpg" width="100%"></a><br><sub><b>TaskManager</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_Dex_Explorer__SettingsPanel.jpg"><img src="screenshots/thumbs/46_Dex_Explorer__SettingsPanel.jpg" width="100%"></a><br><sub><b>Dex_Explorer</b> › SettingsPanel</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Message__Frame.jpg"><img src="screenshots/thumbs/01_Message__Frame.jpg" width="100%"></a><br><sub><b>Message</b> › BaseClip.Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/02_Hint__Frame.jpg"><img src="screenshots/thumbs/02_Hint__Frame.jpg" width="100%"></a><br><sub><b>Hint</b> › BaseClip.Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/03_YesNoPrompt__Frame.jpg"><img src="screenshots/thumbs/03_YesNoPrompt__Frame.jpg" width="100%"></a><br><sub><b>YesNoPrompt</b> › BaseClip.Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Message.jpg"><img src="screenshots/thumbs/04_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_Notify.jpg"><img src="screenshots/thumbs/05_Notify.jpg" width="100%"></a><br><sub><b>Notify</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_Hint.jpg"><img src="screenshots/thumbs/10_Hint.jpg" width="100%"></a><br><sub><b>Hint</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_Notify.jpg"><img src="screenshots/thumbs/14_Notify.jpg" width="100%"></a><br><sub><b>Notify</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_Message.jpg"><img src="screenshots/thumbs/15_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_Notify.jpg"><img src="screenshots/thumbs/18_Notify.jpg" width="100%"></a><br><sub><b>Notify</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Notify.jpg"><img src="screenshots/thumbs/20_Notify.jpg" width="100%"></a><br><sub><b>Notify</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Notif.jpg"><img src="screenshots/thumbs/21_Notif.jpg" width="100%"></a><br><sub><b>Notif</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Message.jpg"><img src="screenshots/thumbs/22_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_Message.jpg"><img src="screenshots/thumbs/28_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_Notify.jpg"><img src="screenshots/thumbs/29_Notify.jpg" width="100%"></a><br><sub><b>Notify</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_Notif.jpg"><img src="screenshots/thumbs/69_Notif.jpg" width="100%"></a><br><sub><b>Notif</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/76_Message.jpg"><img src="screenshots/thumbs/76_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/48_Dex_Explorer__IntroFrame.jpg"><img src="screenshots/thumbs/48_Dex_Explorer__IntroFrame.jpg" width="100%"></a><br><sub><b>Dex_Explorer</b> › IntroFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/96_Dex_Explorer__IntroFrame.jpg"><img src="screenshots/thumbs/96_Dex_Explorer__IntroFrame.jpg" width="100%"></a><br><sub><b>Dex_Explorer</b> › IntroFrame</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_Window.jpg"><img src="screenshots/thumbs/09_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/13_Window.jpg"><img src="screenshots/thumbs/13_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/17_Window.jpg"><img src="screenshots/thumbs/17_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_Window.jpg"><img src="screenshots/thumbs/19_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_Window.jpg"><img src="screenshots/thumbs/27_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/47_Dex_Explorer__RemoteDebugWindow.jpg"><img src="screenshots/thumbs/47_Dex_Explorer__RemoteDebugWindow.jpg" width="100%"></a><br><sub><b>Dex_Explorer</b> › RemoteDebugWindow</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_Window.jpg"><img src="screenshots/thumbs/57_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/67_Window.jpg"><img src="screenshots/thumbs/67_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/75_Window.jpg"><img src="screenshots/thumbs/75_Window.jpg" width="100%"></a><br><sub><b>Window</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_Console.jpg"><img src="screenshots/thumbs/11_Console.jpg" width="100%"></a><br><sub><b>Console</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Console.jpg"><img src="screenshots/thumbs/25_Console.jpg" width="100%"></a><br><sub><b>Console</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/45_Dex_Explorer__ExplorerPanel.jpg"><img src="screenshots/thumbs/45_Dex_Explorer__ExplorerPanel.jpg" width="100%"></a><br><sub><b>Dex_Explorer</b> › ExplorerPanel</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/102_UvBarUI.jpg"><img src="screenshots/thumbs/102_UvBarUI.jpg" width="100%"></a><br><sub><b>UvBarUI</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_PlayerList.jpg"><img src="screenshots/thumbs/06_PlayerList.jpg" width="100%"></a><br><sub><b>PlayerList</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_Output.jpg"><img src="screenshots/thumbs/08_Output.jpg" width="100%"></a><br><sub><b>Output</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Output.jpg"><img src="screenshots/thumbs/12_Output.jpg" width="100%"></a><br><sub><b>Output</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_Output.jpg"><img src="screenshots/thumbs/16_Output.jpg" width="100%"></a><br><sub><b>Output</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_Output.jpg"><img src="screenshots/thumbs/23_Output.jpg" width="100%"></a><br><sub><b>Output</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_PlayerList.jpg"><img src="screenshots/thumbs/24_PlayerList.jpg" width="100%"></a><br><sub><b>PlayerList</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_Output.jpg"><img src="screenshots/thumbs/26_Output.jpg" width="100%"></a><br><sub><b>Output</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/30_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/31_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/31_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/32_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/33_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/34_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/34_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/35_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/35_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/36_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/37_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/37_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/38_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/39_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/40_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/40_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/41_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/42_BTWeldToolGUI.jpg"><img src="screenshots/thumbs/42_BTWeldToolGUI.jpg" width="100%"></a><br><sub><b>BTWeldToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/43_PianoGui.jpg"><img src="screenshots/thumbs/43_PianoGui.jpg" width="100%"></a><br><sub><b>PianoGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/44_Dex_Explorer__PropertiesFrame.jpg"><img src="screenshots/thumbs/44_Dex_Explorer__PropertiesFrame.jpg" width="100%"></a><br><sub><b>Dex_Explorer</b> › PropertiesFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/54_PlayerList.jpg"><img src="screenshots/thumbs/54_PlayerList.jpg" width="100%"></a><br><sub><b>PlayerList</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/74_Output.jpg"><img src="screenshots/thumbs/74_Output.jpg" width="100%"></a><br><sub><b>Output</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/97_ScreenGui.jpg"><img src="screenshots/thumbs/97_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/98_ScreenGui__ScrollingFrame.jpg"><img src="screenshots/thumbs/98_ScreenGui__ScrollingFrame.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Frame.ScrollingFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/99_SecretGui__Frame.jpg"><img src="screenshots/thumbs/99_SecretGui__Frame.jpg" width="100%"></a><br><sub><b>SecretGui</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/100_mikegui__Frame.jpg"><img src="screenshots/thumbs/100_mikegui__Frame.jpg" width="100%"></a><br><sub><b>mikegui</b> › Frame</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Ban.rbxm"><img src="screenshots/thumbs/models/01_Ban.jpg" width="100%"></a><br><sub><b>Ban</b><br><code>models/ServerStorage/Ban.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Toxic%20Gun%202.rbxm"><img src="screenshots/thumbs/models/02_Toxic_Gun_2.jpg" width="100%"></a><br><sub><b>Toxic Gun 2</b><br><code>models/Lighting/Toxic Gun 2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/N0TFla%27s%20FROZEN%20ERADICATOR_R.rbxm"><img src="screenshots/thumbs/models/03_N0TFla_s_FROZEN_ERADICATOR_R.jpg" width="100%"></a><br><sub><b>N0TFla's FROZEN ERADICATOR_R</b><br><code>models/Lighting/N0TFla's FROZEN ERADICATOR_R.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Shop.rbxm"><img src="screenshots/thumbs/models/04_Shop.jpg" width="100%"></a><br><sub><b>Shop</b><br><code>models/Workspace/Shop.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/DARKSEED.rbxm"><img src="screenshots/thumbs/models/05_DARKSEED.jpg" width="100%"></a><br><sub><b>DARKSEED</b><br><code>models/ServerStorage/DARKSEED.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/CandyCane.rbxm"><img src="screenshots/thumbs/models/06_CandyCane.jpg" width="100%"></a><br><sub><b>CandyCane</b><br><code>models/Lighting/CandyCane.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/LoadPower/PowerStation.rbxm"><img src="screenshots/thumbs/models/07_PowerStation.jpg" width="100%"></a><br><sub><b>PowerStation</b><br><code>models/ServerScriptService/LoadPower/PowerStation.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Plane.rbxm"><img src="screenshots/thumbs/models/08_Plane.jpg" width="100%"></a><br><sub><b>Plane</b><br><code>models/Workspace/Plane.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/The_Rake.rbxm"><img src="screenshots/thumbs/models/09_The_Rake.jpg" width="100%"></a><br><sub><b>The_Rake</b><br><code>models/Workspace/The_Rake.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Lighting/Frost%20Blaster.rbxm"><img src="screenshots/thumbs/models/10_Frost_Blaster.jpg" width="100%"></a><br><sub><b>Frost Blaster</b><br><code>models/Lighting/Frost Blaster.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/ELEMENTAL%20ANOMALY.rbxm"><img src="screenshots/thumbs/models/11_ELEMENTAL_ANOMALY.jpg" width="100%"></a><br><sub><b>ELEMENTAL ANOMALY</b><br><code>models/ServerStorage/ELEMENTAL ANOMALY.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Base_Camp.rbxm"><img src="screenshots/thumbs/models/12_Base_Camp.jpg" width="100%"></a><br><sub><b>Base_Camp</b><br><code>models/ServerStorage/Base_Camp.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/BLIZZARIA_%20THE%20FROZEN.rbxm"><img src="screenshots/thumbs/models/13_BLIZZARIA_THE_FROZEN.jpg" width="100%"></a><br><sub><b>BLIZZARIA_ THE FROZEN</b><br><code>models/ServerStorage/BLIZZARIA_ THE FROZEN.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Rusty_Wheel_Chair.rbxm"><img src="screenshots/thumbs/models/14_Rusty_Wheel_Chair.jpg" width="100%"></a><br><sub><b>Rusty_Wheel_Chair</b><br><code>models/Workspace/Rusty_Wheel_Chair.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Aero/Window/Config/Code.lua) <sub>1696 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Default/Window/Config/Code.lua) <sub>1661 lines</sub><br>[`Code.OLD`](source/scripts/Workspace/MainModule~2/Client/UI/Windows%20XP/Window/Config/Code.OLD.lua) <sub>1605 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Aero/Console/Config/Code.lua) <sub>269 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Default/Console/Config/Code.lua) <sub>264 lines</sub> |
| UI controllers / window managers / menus | [`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Aero/Console/Config/Code.lua) <sub>269 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Default/Console/Config/Code.lua) <sub>264 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Rounded/Console/Config/Code.lua) <sub>211 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Unity/Console/Config/Code.lua) <sub>261 lines</sub><br>[`Code`](source/scripts/Workspace/MainModule~2/Client/UI/Windows%20XP/Console/Config/Code.lua) <sub>211 lines</sub> |
| Notifications, toasts, popups, prompts | [`PrivateMessage`](source/scripts/Workspace/MainModule~2/Client/UI/Default/PrivateMessage.lua) <sub>69 lines</sub><br>[`Notifications`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/UI/Notifications.lua) <sub>90 lines</sub><br>[`NotificationDialog`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/UI/Notifications/NotificationDialog.lua) <sub>91 lines</sub><br>[`Alert`](source/scripts/Workspace/MainModule~2/Client/UI/Default/Alert.lua) <sub>64 lines</sub><br>[`Functions`](source/scripts/Workspace/MainModule~2/Client/Core/Functions.lua) <sub>1667 lines</sub> |
| Loading / intro screens | [`ClientLoader`](source/scripts/Workspace/MainModule~2/Server/Dependencies/ClientLoader.client.lua) <sub>286 lines</sub><br>[`Client`](source/scripts/Workspace/MainModule~2/Client/Client.lua) <sub>643 lines</sub><br>[`Server`](source/scripts/Workspace/MainModule~2/Server/Server.lua) <sub>607 lines</sub><br>[`Inspect`](source/scripts/Workspace/MainModule~2/Client/UI/Default/Inspect.lua) <sub>453 lines</sub><br>[`Piano`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/Piano.client.lua) <sub>347 lines</sub> |
| Camera, cutscenes, screen shake | [`ScreenShake`](source/scripts/Workspace/rake%20anims/Configuration/UsedRakeThemeGui/AddGui/RakeThemeGui%20%28Keep%20it%20here%29/ScreenShake.client.lua) <sub>25 lines</sub><br>[`viewmodel`](source/scripts/StarterPlayer/StarterCharacterScripts/viewmodel.client.lua) <sub>507 lines</sub><br>[`ArcHandles`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/Libraries/ArcHandles.lua) <sub>508 lines</sub><br>[`LocalInputScript`](source/scripts/Lighting/Barret%2050/LocalInputScript.client.lua) <sub>97 lines</sub><br>[`LocalInputScript`](source/scripts/Lighting/RocketLauncher/LocalInputScript.client.lua) <sub>90 lines</sub> |
| VFX, particles, beams, hit effects | [`Main`](source/scripts/ServerStorage/FROST%20Sledgehammer/Main.server.lua) <sub>91 lines</sub><br>[`Main`](source/scripts/ServerStorage/Sledge%20Hammer/Main.server.lua) <sub>88 lines</sub><br>[`Main`](source/scripts/ServerScriptService/LoadItems/Items/ERADICATOR/Main.server.lua) <sub>101 lines</sub><br>[`Main`](source/scripts/Lighting/N0TFla%27s%20FROZEN%20ERADICATOR_R/Main.server.lua) <sub>98 lines</sub><br>[`Main`](source/scripts/ServerStorage/ERADICATOR%20%28ADMIN%29/Main.server.lua) <sub>100 lines</sub> |
| DataStore / player data | [`Core`](source/scripts/Workspace/MainModule~2/Server/Core/Core.lua) <sub>1316 lines</sub><br>[`Remote`](source/scripts/Workspace/MainModule~2/Server/Core/Remote.lua) <sub>1308 lines</sub><br>[`PurchaseHandler`](source/scripts/ServerScriptService/PurchaseHandler.server.lua) <sub>38 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`CokeGamepass`](source/scripts/ServerScriptService/CokeGamepass.server.lua) <sub>16 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Fun`](source/scripts/Workspace/MainModule~2/Server/Commands/Fun.lua) <sub>4204 lines</sub><br>[`R15Animate`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/R15Animate.server.lua) <sub>546 lines</sub><br>[`R6Animate`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/R6Animate.server.lua) <sub>493 lines</sub><br>[`AnimateSauce`](source/scripts/Workspace/The_Rake/AnimateSauce.server.lua) <sub>484 lines</sub><br>[`Moderators`](source/scripts/Workspace/MainModule~2/Server/Commands/Moderators.lua) <sub>6526 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Main`](source/scripts/ServerScriptService/LoadItems/Items/MetalBaseballBat/Main.server.lua) <sub>62 lines</sub><br>[`Damage`](source/scripts/ServerStorage/ProtoStunStick/ShockPart/Damage.server.lua) <sub>45 lines</sub><br>[`Damage`](source/scripts/StarterPack/StunStick/ShockPart/Damage.server.lua) <sub>49 lines</sub><br>[`Damage`](source/scripts/ServerScriptService/LoadItems/Items/RainbowStun/ShockPart/Damage.server.lua) <sub>42 lines</sub><br>[`Main`](source/scripts/ServerScriptService/LoadItems/Items/FryingPan/Main.server.lua) <sub>58 lines</sub> |
| NPC / AI / monsters | [`BotBrain`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/BotBrain.server.lua) <sub>256 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`RunScript`](source/scripts/StarterPlayer/StarterCharacterScripts/RunScript.client.lua) <sub>62 lines</sub><br>[`Slider`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/UI/ColorPicker/Slider.lua) <sub>110 lines</sub><br>[`AnimateSauce`](source/scripts/Workspace/The_Rake/AnimateSauce.server.lua) <sub>484 lines</sub><br>[`Main`](source/scripts/ServerScriptService/LoadItems/Items/ERADICATOR/Main.server.lua) <sub>101 lines</sub><br>[`Moderators`](source/scripts/Workspace/MainModule~2/Server/Commands/Moderators.lua) <sub>6526 lines</sub> |
| Tycoon / plots / bases / building | [`DefaultSettings`](source/scripts/Workspace/MainModule~2/Server/Dependencies/DefaultSettings.lua) <sub>525 lines</sub><br>[`Moderators`](source/scripts/Workspace/MainModule~2/Server/Commands/Moderators.lua) <sub>6526 lines</sub><br>[`Lighting`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/Tools/Lighting.lua) <sub>861 lines</sub><br>[`Mesh`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/Tools/Mesh.lua) <sub>843 lines</sub><br>[`Texture`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/Tools/Texture.lua) <sub>658 lines</sub> |
| Admin panels & commands | [`Admins`](source/scripts/Workspace/MainModule~2/Server/Commands/Admins.lua) <sub>1519 lines</sub><br>[`Admin`](source/scripts/Workspace/MainModule~2/Server/Core/Admin.lua) <sub>1027 lines</sub><br>[`DefaultSettings`](source/scripts/Workspace/MainModule~2/Server/Dependencies/DefaultSettings.lua) <sub>525 lines</sub><br>[`Commands`](source/scripts/Workspace/MainModule~2/Server/Core/Commands.lua) <sub>132 lines</sub><br>[`HeadAdmins`](source/scripts/Workspace/MainModule~2/Server/Commands/HeadAdmins.lua) <sub>405 lines</sub> |
| Sound & music | [`Music`](source/scripts/Workspace/MainModule~2/Client/UI/Default/Music.lua) <sub>642 lines</sub><br>[`Client`](source/scripts/ServerScriptService/LoadItems/Items/Cylinder/Client.client.lua) <sub>80 lines</sub><br>[`Admins`](source/scripts/Workspace/MainModule~2/Server/Commands/Admins.lua) <sub>1519 lines</sub><br>[`Restoring`](source/scripts/ServerScriptService/LoadPower/PowerStation/RestorePart/ProximityPrompt/Restoring.server.lua) <sub>86 lines</sub><br>[`Client`](source/scripts/ServerStorage/NerfGun/Client.client.lua) <sub>64 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Admins`](source/scripts/Workspace/MainModule~2/Server/Commands/Admins.lua) <sub>1519 lines</sub><br>[`Maid`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/Libraries/Maid.lua) <sub>99 lines</sub><br>[`Signal`](source/scripts/Workspace/MainModule~2/Server/Dependencies/Assets/F3X%20Deps/Libraries/Signal.lua) <sub>70 lines</sub><br>[`Fun`](source/scripts/Workspace/MainModule~2/Server/Commands/Fun.lua) <sub>4204 lines</sub><br>[`Moderators`](source/scripts/Workspace/MainModule~2/Server/Commands/Moderators.lua) <sub>6526 lines</sub> |

### In the curated script library

- [Realism mode (CloneTrooper1019)](../../Scripts/05-Camera-Cutscene/RealismBobAndBodyLook__the-rake.lua) — Old but famous: body follows camera pitch + walk bobble via CameraOffset (R6).
- [Death jumpscare camera](../../Scripts/05-Camera-Cutscene/DeathJumpscareCam__the-rake.lua) — Simplest death cam: Scriptable camera at a fixed part + FOV kick (120 -> 50).
- [Sprint with FOV tween](../../Scripts/13-Movement/SprintFovRun__the-rake.lua) — Sprint key + mobile button + FOV tween, wired to a server stamina value.
- [Configurable patrol / attack bot](../../Scripts/12-NPC-AI/PatrolSwarmBotBrain__the-rake.lua) — Admin-system bot brain driven by a props table (Target, Swarm, PatrolZone, PatrolDist, Damage, team friendliness) set through a BindableEvent; patrols random points, targets the nearest valid model, walks straight when it can see the goal and pathfinds otherwise, with a forward-ray jump check.
- [PlaybackLoudness bar visualizer](../../Scripts/17-Sound-Music/AudioVisualizerBars__the-rake.lua) — Bar-graph audio visualizer driven by Sound.PlaybackLoudness: keeps a rolling buffer of loudness samples, mirrors it from the center outwards, tweens bar heights and optionally colors bars from a ColorSequence. Note: Frame:Add() is an Adonis helper; replace it with Instance.new.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Lighting/.44 MAGNUM/Script.server.lua`
- `scripts/Lighting/ACID SPLITTER/Script.server.lua`
- `scripts/Lighting/AK-47/Script.server.lua`
- `scripts/Lighting/AUG/Script.server.lua`
- `scripts/Lighting/BLACK MATTER  SPLITTER/Script.server.lua`
- `scripts/Lighting/Barret 50/Script.server.lua`
- `scripts/Lighting/D. Eagle/Script.server.lua`
- `scripts/Lighting/Falkor/Script.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
