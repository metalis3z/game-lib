# +1 Escape Kitty Keyboard

> 🧗 **Obby** · obby / escape (+1 speed) · source file `+1 escape kitty keyboard (1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/05_SpeedGameUI__ShopModal.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 18 ScreenGuis, 2574 GUI objects → **63 screenshots** |
| Models (.rbxm) | 231 models, 30 model sets, 0 VFX sets |
| Lua builders (.lua) | 55 UI screens, 0 animation packs, 7 audio packs |
| Code | 722 scripts, 70,921 lines |
| Asset ids | 39 animations, 174 sounds |
| Safety scan | 0 HIGH / 4 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Roboto Regular`×299, `Zekton Regular`×272, `GothamSSm Bold`×170, `Roboto Light`×118, `SourceSansPro Regular`×96

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_SpeedGameUI__ShopModal.jpg"><img src="screenshots/thumbs/05_SpeedGameUI__ShopModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › ShopModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/36_Store__Store.jpg"><img src="screenshots/thumbs/36_Store__Store.jpg" width="100%"></a><br><sub><b>Store</b> › Store</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_SpeedGameUI__ShopModal.jpg"><img src="screenshots/thumbs/67_SpeedGameUI__ShopModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › ShopModal</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/64_SpeedGameUI__FreeGiftModal.jpg"><img src="screenshots/thumbs/64_SpeedGameUI__FreeGiftModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › FreeGiftModal</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_SpeedGameUI__RebirthModal.jpg"><img src="screenshots/thumbs/02_SpeedGameUI__RebirthModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › RebirthModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_SpeedGameUI__RebirthModal.jpg"><img src="screenshots/thumbs/63_SpeedGameUI__RebirthModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › RebirthModal</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_HDAdminInterface__Template4.jpg"><img src="screenshots/thumbs/17_HDAdminInterface__Template4.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template4</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_HDAdminInterface__Template5.jpg"><img src="screenshots/thumbs/18_HDAdminInterface__Template5.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template5</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_HDAdminInterface__Template6.jpg"><img src="screenshots/thumbs/19_HDAdminInterface__Template6.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template6</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_HDAdminInterface__Template8.jpg"><img src="screenshots/thumbs/22_HDAdminInterface__Template8.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template8</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_HDAdminInterface__Template10.jpg"><img src="screenshots/thumbs/25_HDAdminInterface__Template10.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template10</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_HDAdminInterface__Template11.jpg"><img src="screenshots/thumbs/26_HDAdminInterface__Template11.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template11</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_HDAdminInterface__Template14.jpg"><img src="screenshots/thumbs/29_HDAdminInterface__Template14.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template14</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_HDAdminInterface__Template13.jpg"><img src="screenshots/thumbs/30_HDAdminInterface__Template13.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template13</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_HDAdminInterface__Template15.jpg"><img src="screenshots/thumbs/31_HDAdminInterface__Template15.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template15</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_HDAdminInterface__Template16.jpg"><img src="screenshots/thumbs/32_HDAdminInterface__Template16.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template16</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_HDAdminInterface__Template18.jpg"><img src="screenshots/thumbs/33_HDAdminInterface__Template18.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template18</sub></td>
<td width="33%" valign="top"><a href="screenshots/79_HDAdminInterface__Template5.jpg"><img src="screenshots/thumbs/79_HDAdminInterface__Template5.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/80_HDAdminInterface__Template6.jpg"><img src="screenshots/thumbs/80_HDAdminInterface__Template6.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template6</sub></td>
<td width="33%" valign="top"><a href="screenshots/86_HDAdminInterface__Template10.jpg"><img src="screenshots/thumbs/86_HDAdminInterface__Template10.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template10</sub></td>
<td width="33%" valign="top"><a href="screenshots/87_HDAdminInterface__Template11.jpg"><img src="screenshots/thumbs/87_HDAdminInterface__Template11.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template11</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/93_HDAdminInterface__Template16.jpg"><img src="screenshots/thumbs/93_HDAdminInterface__Template16.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template16</sub></td>
<td width="33%" valign="top"><a href="screenshots/94_HDAdminInterface__Template18.jpg"><img src="screenshots/thumbs/94_HDAdminInterface__Template18.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template18</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_CheatWarningGui__Frame.jpg"><img src="screenshots/thumbs/10_CheatWarningGui__Frame.jpg" width="100%"></a><br><sub><b>CheatWarningGui</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_MessageToPlayer.jpg"><img src="screenshots/thumbs/11_MessageToPlayer.jpg" width="100%"></a><br><sub><b>MessageToPlayer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_HDAdminInterface__Message.jpg"><img src="screenshots/thumbs/15_HDAdminInterface__Message.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › Templates.Message</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_HDAdminInterface__GlobalAnnouncement.jpg"><img src="screenshots/thumbs/16_HDAdminInterface__GlobalAnnouncement.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › Templates.GlobalAnnouncement</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_HDAdminInterface__Warnings.jpg"><img src="screenshots/thumbs/35_HDAdminInterface__Warnings.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MainFrame.Warnings</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_CheatWarningGui__Frame.jpg"><img src="screenshots/thumbs/71_CheatWarningGui__Frame.jpg" width="100%"></a><br><sub><b>CheatWarningGui</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/96_HDAdminInterface__Warnings.jpg"><img src="screenshots/thumbs/96_HDAdminInterface__Warnings.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MainFrame.Warnings</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/61_TopbarStandard.jpg"><img src="screenshots/thumbs/61_TopbarStandard.jpg" width="100%"></a><br><sub><b>TopbarStandard</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/21_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template7.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/24_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template9.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/28_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template12.FinalResult</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/82_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/82_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template7.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/85_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/85_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template9.FinalResult</sub></td>
<td width="33%" valign="top"><a href="screenshots/89_HDAdminInterface__FinalResult.jpg"><img src="screenshots/thumbs/89_HDAdminInterface__FinalResult.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template12.FinalResult</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_HDAdminInterface__Notices.jpg"><img src="screenshots/thumbs/13_HDAdminInterface__Notices.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › Notices</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_HDAdminInterface__CmdBar.jpg"><img src="screenshots/thumbs/14_HDAdminInterface__CmdBar.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › CmdBar</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_HDAdminInterface__Pages.jpg"><img src="screenshots/thumbs/34_HDAdminInterface__Pages.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MainFrame.Pages</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/74_AdminAbuseGui.jpg"><img src="screenshots/thumbs/74_AdminAbuseGui.jpg" width="100%"></a><br><sub><b>AdminAbuseGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/95_HDAdminInterface__Pages.jpg"><img src="screenshots/thumbs/95_HDAdminInterface__Pages.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MainFrame.Pages</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_SpeedGameUI__EventCurrencyModal.jpg"><img src="screenshots/thumbs/06_SpeedGameUI__EventCurrencyModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › EventCurrencyModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/20_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template7.MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/23_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/23_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template9.MainFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/27_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template12.MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/68_SpeedGameUI__EventCurrencyModal.jpg"><img src="screenshots/thumbs/68_SpeedGameUI__EventCurrencyModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › EventCurrencyModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/81_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/81_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template7.MainFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/84_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/84_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template9.MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/88_HDAdminInterface__MainFrame.jpg"><img src="screenshots/thumbs/88_HDAdminInterface__MainFrame.jpg" width="100%"></a><br><sub><b>HDAdminInterface</b> › MenuTemplates.Template12.MainFrame</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_SpeedGameUI.jpg"><img src="screenshots/thumbs/01_SpeedGameUI.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_SpeedGameUI__KeySoundModal.jpg"><img src="screenshots/thumbs/03_SpeedGameUI__KeySoundModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › KeySoundModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_SpeedGameUI__CheckpointModal.jpg"><img src="screenshots/thumbs/04_SpeedGameUI__CheckpointModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › CheckpointModal</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_SpeedGameUI__TikfinityModal.jpg"><img src="screenshots/thumbs/07_SpeedGameUI__TikfinityModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › TikfinityModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_SpeedGameUI__TrailsModal.jpg"><img src="screenshots/thumbs/08_SpeedGameUI__TrailsModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › TrailsModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_SpeedGameUI__InviteModal.jpg"><img src="screenshots/thumbs/09_SpeedGameUI__InviteModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › InviteModal</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_SocialVerifyGui.jpg"><img src="screenshots/thumbs/12_SocialVerifyGui.jpg" width="100%"></a><br><sub><b>SocialVerifyGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/37_SecretGuard.jpg"><img src="screenshots/thumbs/37_SecretGuard.jpg" width="100%"></a><br><sub><b>SecretGuard</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/62_SpeedGameUI.jpg"><img src="screenshots/thumbs/62_SpeedGameUI.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/65_SpeedGameUI__KeySoundModal.jpg"><img src="screenshots/thumbs/65_SpeedGameUI__KeySoundModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › KeySoundModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/66_SpeedGameUI__CheckpointModal.jpg"><img src="screenshots/thumbs/66_SpeedGameUI__CheckpointModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › CheckpointModal</sub></td>
<td width="33%" valign="top"><a href="screenshots/70_SpeedGameUI__TrailsModal.jpg"><img src="screenshots/thumbs/70_SpeedGameUI__TrailsModal.jpg" width="100%"></a><br><sub><b>SpeedGameUI</b> › TrailsModal</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/73_SocialVerifyGui.jpg"><img src="screenshots/thumbs/73_SocialVerifyGui.jpg" width="100%"></a><br><sub><b>SocialVerifyGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/NPC12.rbxm"><img src="screenshots/thumbs/models/01_NPC12.jpg" width="100%"></a><br><sub><b>NPC12</b><br><code>models/ReplicatedStorage/NPC12.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/keycap_K__x96.rbxm"><img src="screenshots/thumbs/models/02_keycap_K_x96.jpg" width="100%"></a><br><sub><b>keycap_K__x96</b><br><code>models/Workspace/keycap_K__x96.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ConcertShakira/copertura%20estiva.rbxm"><img src="screenshots/thumbs/models/03_copertura_estiva.jpg" width="100%"></a><br><sub><b>copertura estiva</b><br><code>models/ReplicatedStorage/ConcertShakira/copertura estiva.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Templates/GoldenEggs/GoldenEasterEgg.rbxm"><img src="screenshots/thumbs/models/04_GoldenEasterEgg.jpg" width="100%"></a><br><sub><b>GoldenEasterEgg</b><br><code>models/ReplicatedStorage/Templates/GoldenEggs/GoldenEasterEgg.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/WinsLeaderboard.rbxm"><img src="screenshots/thumbs/models/05_WinsLeaderboard.jpg" width="100%"></a><br><sub><b>WinsLeaderboard</b><br><code>models/Workspace/Leaderboards/WinsLeaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Treadmill/TreadmillAdmin.rbxm"><img src="screenshots/thumbs/models/06_TreadmillAdmin.jpg" width="100%"></a><br><sub><b>TreadmillAdmin</b><br><code>models/Workspace/Treadmill/TreadmillAdmin.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Structure/Stage0_HUB/Trophyx2.rbxm"><img src="screenshots/thumbs/models/08_Trophyx2.jpg" width="100%"></a><br><sub><b>Trophyx2</b><br><code>models/Workspace/Structure/Stage0_HUB/Trophyx2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ConcertShakira/Model__x23.rbxm"><img src="screenshots/thumbs/models/10_Model_x23.jpg" width="100%"></a><br><sub><b>Model__x23</b><br><code>models/ReplicatedStorage/ConcertShakira/Model__x23.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/keycap_E__x66.rbxm"><img src="screenshots/thumbs/models/11_keycap_E_x66.jpg" width="100%"></a><br><sub><b>keycap_E__x66</b><br><code>models/Workspace/keycap_E__x66.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Bridge1.rbxm"><img src="screenshots/thumbs/models/12_Bridge1.jpg" width="100%"></a><br><sub><b>Bridge1</b><br><code>models/Workspace/Bridge1.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Templates/Eggs/EasterEggChoco.rbxm"><img src="screenshots/thumbs/models/13_EasterEggChoco.jpg" width="100%"></a><br><sub><b>EasterEggChoco</b><br><code>models/ReplicatedStorage/Templates/Eggs/EasterEggChoco.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/SpeedLeaderboard.rbxm"><img src="screenshots/thumbs/models/14_SpeedLeaderboard.jpg" width="100%"></a><br><sub><b>SpeedLeaderboard</b><br><code>models/Workspace/Leaderboards/SpeedLeaderboard.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`AdminPanelClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanelClient.client.lua) <sub>861 lines</sub><br>[`NotificationSystem`](source/scripts/ReplicatedStorage/NotificationSystem.lua) <sub>551 lines</sub><br>[`EggRainClient`](source/scripts/ReplicatedStorage/EggRainClient.lua) <sub>1501 lines</sub><br>[`LokiiBossRoom`](source/scripts/ReplicatedStorage/AdminAbuse/Modules/LokiiBossRoom.lua) <sub>992 lines</sub><br>[`Notices`](source/scripts/ReplicatedStorage/HDAdminHDClient/Modules/Notices.lua) <sub>270 lines</sub> |
| UI controllers / window managers / menus | [`AdminPanelClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanelClient.client.lua) <sub>861 lines</sub><br>[`Leaderboardpanelclient`](source/scripts/StarterPlayer/StarterPlayerScripts/Leaderboardpanelclient.client.lua) <sub>437 lines</sub><br>[`GUIs`](source/scripts/ReplicatedStorage/HDAdminHDClient/Modules/GUIs.lua) <sub>655 lines</sub><br>[`Container`](source/scripts/ReplicatedStorage/HDAdminHDClient/Assets/Icon/Elements/Container.lua) <sub>210 lines</sub><br>[`AdminAbuseGui`](source/scripts/LocalPlayer/PlayerScripts/Client/AdminAbuseGui.lua) <sub>447 lines</sub> |
| Notifications, toasts, popups, prompts | [`NotificationSystem`](source/scripts/ReplicatedStorage/NotificationSystem.lua) <sub>551 lines</sub><br>[`AdminAnnounceClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminAnnounceClient.client.lua) <sub>145 lines</sub><br>[`Messages`](source/scripts/ReplicatedStorage/HDAdminHDClient/Modules/Messages.lua) <sub>169 lines</sub><br>[`MessageToPlayerScript`](source/scripts/StarterGui/MessageToPlayer/MessageToPlayerScript.client.lua) <sub>62 lines</sub><br>[`AdminPanelClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanelClient.client.lua) <sub>861 lines</sub> |
| Loading / intro screens | [`EggRainClient`](source/scripts/ReplicatedStorage/EggRainClient.lua) <sub>1501 lines</sub> |
| Camera, cutscenes, screen shake | [`AdminAbuseTransition`](source/scripts/LocalPlayer/PlayerScripts/Client/AdminAbuseTransition.lua) <sub>370 lines</sub><br>[`AdminAbuseTransition`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/AdminAbuseTransition.lua) <sub>372 lines</sub><br>[`LokiiBossRoom`](source/scripts/ReplicatedStorage/AdminAbuse/Modules/LokiiBossRoom.lua) <sub>992 lines</sub><br>[`AdminAbuseTransition`](source/scripts/Players/LocalPlayer/PlayerScripts/Client/AdminAbuseTransition.lua) <sub>372 lines</sub><br>[`EggRainClient`](source/scripts/ReplicatedStorage/EggRainClient.lua) <sub>1501 lines</sub> |
| VFX, particles, beams, hit effects | [`AdminPanelClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanelClient.client.lua) <sub>861 lines</sub><br>[`LokiiBossRoom`](source/scripts/ReplicatedStorage/AdminAbuse/Modules/LokiiBossRoom.lua) <sub>992 lines</sub> |
| DataStore / player data | [`DataHandler`](source/scripts/ServerScriptService/DataService/DataHandler.lua) <sub>218 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`TreadmillGamepassHandler`](source/scripts/ServerScriptService/TreadmillGamepassHandler.server.lua) <sub>185 lines</sub><br>[`GamepassHandler`](source/scripts/Workspace/GamepassHandler.server.lua) <sub>59 lines</sub><br>[`RemoteHandler`](source/scripts/ServerScriptService/Game/Core/RemoteHandler.server.lua) <sub>576 lines</sub><br>[`TrophyX2Handler`](source/scripts/ServerScriptService/Game/Core/TrophyX2Handler.server.lua) <sub>107 lines</sub><br>[`ProductHandler`](source/scripts/ServerScriptService/Game/Core/ProductHandler.server.lua) <sub>65 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`EggRainClient`](source/scripts/ReplicatedStorage/EggRainClient.lua) <sub>1501 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`KeySystem v6`](source/scripts/StarterPlayer/StarterPlayerScripts/Key/KeySystem%20v6.client.lua) <sub>148 lines</sub><br>[`KeySystem v7 by Sano`](source/scripts/StarterPlayer/StarterPlayerScripts/Key/KeySystem%20v7%20by%20Sano.client.lua) <sub>146 lines</sub><br>[`TreadmillSystem`](source/scripts/StarterPlayer/StarterPlayerScripts/v3/TreadmillSystem.client.lua) <sub>168 lines</sub><br>[`KeySystem v6`](source/scripts/LocalPlayer/PlayerScripts/Key/KeySystem%20v6.client.lua) <sub>148 lines</sub><br>[`KeySystem v7 by Sano`](source/scripts/LocalPlayer/PlayerScripts/Key/KeySystem%20v7%20by%20Sano.client.lua) <sub>146 lines</sub> |
| NPC / AI / monsters | [`LocalNPC12_AI`](source/scripts/StarterPlayer/StarterPlayerScripts/Pi%C3%A8ges/LocalNPC12_AI.client.lua) <sub>491 lines</sub><br>[`LocalNPC15_AI`](source/scripts/StarterPlayer/StarterPlayerScripts/Pi%C3%A8ges/LocalNPC15_AI.client.lua) <sub>737 lines</sub><br>[`LocalNPC12_AI`](source/scripts/LocalPlayer/PlayerScripts/Pi%C3%A8ges/LocalNPC12_AI.client.lua) <sub>491 lines</sub><br>[`LocalNPC15_AI`](source/scripts/LocalPlayer/PlayerScripts/Pi%C3%A8ges/LocalNPC15_AI.client.lua) <sub>737 lines</sub><br>[`LocalNPC10_AI`](source/scripts/StarterPlayer/StarterPlayerScripts/Pi%C3%A8ges/LocalNPC10_AI.client.lua) <sub>145 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`AdminAbuseConfig`](source/scripts/ReplicatedStorage/Shared/AdminAbuseConfig.lua) <sub>59 lines</sub><br>[`LocalNPC10_AI`](source/scripts/StarterPlayer/StarterPlayerScripts/Pi%C3%A8ges/LocalNPC10_AI.client.lua) <sub>145 lines</sub><br>[`Jump`](source/scripts/ReplicatedStorage/TikfinityModules/Jump.lua) <sub>39 lines</sub><br>[`LokiiBossRoom`](source/scripts/ReplicatedStorage/AdminAbuse/Modules/LokiiBossRoom.lua) <sub>992 lines</sub><br>[`NoBugJumpMobile`](source/scripts/StarterPlayer/StarterCharacterScripts/NoBugJumpMobile.client.lua) <sub>22 lines</sub> |
| Tycoon / plots / bases / building | [`TreadmillBuyPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/TreadmillBuyPanel.client.lua) <sub>258 lines</sub><br>[`UIHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/v3/UIHandler.client.lua) <sub>615 lines</sub><br>[`EggRainClient`](source/scripts/ReplicatedStorage/EggRainClient.lua) <sub>1501 lines</sub><br>[`UIHandler`](source/scripts/LocalPlayer/PlayerScripts/v3/UIHandler.client.lua) <sub>496 lines</sub> |
| Leaderboards & stats | [`LeaderstatsHandler`](source/scripts/ServerScriptService/Game/Core/LeaderstatsHandler.server.lua) <sub>80 lines</sub> |
| Admin panels & commands | [`AdminPanelServer`](source/scripts/ServerScriptService/AdminPanelServer.server.lua) <sub>430 lines</sub><br>[`AdminPanelClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanelClient.client.lua) <sub>861 lines</sub><br>[`CmdBar`](source/scripts/ReplicatedStorage/HDAdminHDClient/Modules/CmdBar.lua) <sub>525 lines</sub><br>[`PageCommands`](source/scripts/ReplicatedStorage/HDAdminHDClient/Modules/GUIs/PageCommands.lua) <sub>794 lines</sub><br>[`AdminPanel`](source/scripts/StarterGui/AdminPanel.client.lua) <sub>416 lines</sub> |
| Sound & music | [`KeycapSoundManager`](source/scripts/StarterPlayer/StarterPlayerScripts/KeycapSoundManager.client.lua) <sub>69 lines</sub><br>[`SoundManager`](source/scripts/ReplicatedStorage/SoundManager.lua) <sub>47 lines</sub><br>[`KeycapSoundScript`](source/scripts/ServerScriptService/KeycapSoundScript.server.lua) <sub>59 lines</sub><br>[`KeycapAnimation`](source/scripts/StarterPlayer/StarterPlayerScripts/KeycapAnimation.client.lua) <sub>145 lines</sub> |
| Daily rewards, quests, codes, playtime | [`SocialCodeClient`](source/scripts/StarterPlayer/StarterPlayerScripts/SocialCode/SocialCodeClient.client.lua) <sub>184 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Utility`](source/scripts/ReplicatedStorage/HDAdminHDClient/Assets/Icon/Utility.lua) <sub>590 lines</sub><br>[`PageCommands`](source/scripts/ReplicatedStorage/HDAdminHDClient/Modules/GUIs/PageCommands.lua) <sub>794 lines</sub><br>[`MainFramework`](source/scripts/ReplicatedStorage/HDAdminHDClient/SharedModules/MainFramework.lua) <sub>415 lines</sub><br>[`BundleUtility`](source/scripts/ReplicatedStorage/HDAdminHDClient/SharedModules/BundleUtility.lua) <sub>286 lines</sub><br>[`NextEventTimerSystem`](source/scripts/ReplicatedStorage/NextEventTimerSystem.lua) <sub>192 lines</sub> |

### In the curated script library

- [Panel server: kick/ban/freeze/troll](../../Scripts/16-Admin/AdminPanelServer-Moderation__escape-kitty-keyboard.lua) — Remote functions for an admin panel: player list, kick, DataStore ban/unban checked on join, freeze that survives respawn, fun actions (ragdoll, spin, invisible, spectate), per-admin cooldown.
- [Ordered stores fed from the save + backfill](../../Scripts/15-Leaderboards/DataHandler-OrderedStoreBackfill__escape-kitty-keyboard.lua) — Writes Wins/XP/Rebirths to ordered stores on every save (math.floor to avoid ValueNotNumeric), a faster ordered-store-only update, and a one-time backfill of known players' saved data.
- [Touch-triggered click sounds](../../Scripts/17-Sound-Music/KeycapTouchSound__escape-kitty-keyboard.lua) — Plays a click when any character part touches a keycap part, with a per-part debounce and random pitch so repeated clicks sound natural. Uses one shared Sound in SoundService.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
