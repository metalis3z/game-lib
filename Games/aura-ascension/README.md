# Aura Ascension (UPD 3)

> 🎲 **RNG** · RNG / aura rolling · source file `AuraAscensionUPD3%20(1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/41_ScreenFrames__Contents.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 9 ScreenGuis, 761 GUI objects → **43 screenshots** |
| Models (.rbxm) | 178 models, 5 model sets, 5 VFX sets |
| Lua builders (.lua) | 124 UI screens, 1 animation packs, 7 audio packs |
| Code | 241 scripts, 55,618 lines |
| Asset ids | 209 animations, 47 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×202, `GothamSSm Heavy`×20, `FredokaOne Bold`×14, `SourceSansPro Regular`×7, `GothamSSm ExtraBold`×6

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_ScreenFrames__Contents.jpg"><img src="screenshots/thumbs/11_ScreenFrames__Contents.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › ShopFrame.Contents</sub></td>
<td width="33%" valign="top"><a href="screenshots/41_ScreenFrames__Contents.jpg"><img src="screenshots/thumbs/41_ScreenFrames__Contents.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › ShopFrame.Contents</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_InventoryHud.jpg"><img src="screenshots/thumbs/29_InventoryHud.jpg" width="100%"></a><br><sub><b>InventoryHud</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/31_InventoryHud__ContentsPoses.jpg"><img src="screenshots/thumbs/31_InventoryHud__ContentsPoses.jpg" width="100%"></a><br><sub><b>InventoryHud</b> › Holder.ContentsPoses</sub></td>
<td width="33%" valign="top"><a href="screenshots/62_InventoryHud.jpg"><img src="screenshots/thumbs/62_InventoryHud.jpg" width="100%"></a><br><sub><b>InventoryHud</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/64_InventoryHud__ContentsPoses.jpg"><img src="screenshots/thumbs/64_InventoryHud__ContentsPoses.jpg" width="100%"></a><br><sub><b>InventoryHud</b> › Holder.ContentsPoses</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_ScreenFrames__BG.jpg"><img src="screenshots/thumbs/05_ScreenFrames__BG.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › TitlesFrame.BG</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_ScreenFrames__Container.jpg"><img src="screenshots/thumbs/06_ScreenFrames__Container.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › TitlesFrame.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_ScreenFrames__Content.jpg"><img src="screenshots/thumbs/12_ScreenFrames__Content.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › SettingsFrame.Content</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_InventoryHud__ContainerTitles.jpg"><img src="screenshots/thumbs/30_InventoryHud__ContainerTitles.jpg" width="100%"></a><br><sub><b>InventoryHud</b> › Holder.ContainerTitles</sub></td>
<td width="33%" valign="top"><a href="screenshots/36_ScreenFrames__Container.jpg"><img src="screenshots/thumbs/36_ScreenFrames__Container.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › TitlesFrame.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_ScreenFrames__Content.jpg"><img src="screenshots/thumbs/42_ScreenFrames__Content.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › SettingsFrame.Content</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/63_InventoryHud__ContainerTitles.jpg"><img src="screenshots/thumbs/63_InventoryHud__ContainerTitles.jpg" width="100%"></a><br><sub><b>InventoryHud</b> › Holder.ContainerTitles</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Hud__AreaNotification.jpg"><img src="screenshots/thumbs/27_Hud__AreaNotification.jpg" width="100%"></a><br><sub><b>Hud</b> › AreaNotification</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_LoadingScreen.jpg"><img src="screenshots/thumbs/01_LoadingScreen.jpg" width="100%"></a><br><sub><b>LoadingScreen</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_LoadingScreen__Update.jpg"><img src="screenshots/thumbs/02_LoadingScreen__Update.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › Update</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_Hud__TopBar.jpg"><img src="screenshots/thumbs/28_Hud__TopBar.jpg" width="100%"></a><br><sub><b>Hud</b> › TopBar</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_Hud__TopBar.jpg"><img src="screenshots/thumbs/58_Hud__TopBar.jpg" width="100%"></a><br><sub><b>Hud</b> › TopBar</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_ScreenFrames__BG.jpg"><img src="screenshots/thumbs/07_ScreenFrames__BG.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › PosesVenderFrame.BG</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_ScreenFrames__Contents.jpg"><img src="screenshots/thumbs/08_ScreenFrames__Contents.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › PosesVenderFrame.Contents</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_ScreenFrames__Preview.jpg"><img src="screenshots/thumbs/09_ScreenFrames__Preview.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › PosesVenderFrame.Preview</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_ScreenFrames__Preview.jpg"><img src="screenshots/thumbs/39_ScreenFrames__Preview.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › PosesVenderFrame.Preview</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_ScreenFrames__MainBG.jpg"><img src="screenshots/thumbs/03_ScreenFrames__MainBG.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › GroupRewards.MainBG</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_ScreenFrames__MainHolder.jpg"><img src="screenshots/thumbs/04_ScreenFrames__MainHolder.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › GroupRewards.MainHolder</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_ScreenFrames__MainBG.jpg"><img src="screenshots/thumbs/10_ScreenFrames__MainBG.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › ShopFrame.MainBG</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_Plat__MainBG.jpg"><img src="screenshots/thumbs/16_Plat__MainBG.jpg" width="100%"></a><br><sub><b>Plat</b> › YellowPack.MainBG</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_Plat__LeftContainer.jpg"><img src="screenshots/thumbs/17_Plat__LeftContainer.jpg" width="100%"></a><br><sub><b>Plat</b> › YellowPack.LeftContainer</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_Plat__RightContainer.jpg"><img src="screenshots/thumbs/18_Plat__RightContainer.jpg" width="100%"></a><br><sub><b>Plat</b> › YellowPack.RightContainer</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_Plat__MainBG.jpg"><img src="screenshots/thumbs/19_Plat__MainBG.jpg" width="100%"></a><br><sub><b>Plat</b> › PurplePack.MainBG</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_Plat__LeftContainer.jpg"><img src="screenshots/thumbs/20_Plat__LeftContainer.jpg" width="100%"></a><br><sub><b>Plat</b> › PurplePack.LeftContainer</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Plat__MainBG.jpg"><img src="screenshots/thumbs/22_Plat__MainBG.jpg" width="100%"></a><br><sub><b>Plat</b> › BluePack.MainBG</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Plat__LeftContainer.jpg"><img src="screenshots/thumbs/23_Plat__LeftContainer.jpg" width="100%"></a><br><sub><b>Plat</b> › BluePack.LeftContainer</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Hud.jpg"><img src="screenshots/thumbs/25_Hud.jpg" width="100%"></a><br><sub><b>Hud</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_Hud__TickTemplate.jpg"><img src="screenshots/thumbs/26_Hud__TickTemplate.jpg" width="100%"></a><br><sub><b>Hud</b> › TickTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_ScreenFrames__MainHolder.jpg"><img src="screenshots/thumbs/34_ScreenFrames__MainHolder.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › GroupRewards.MainHolder</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_Hud.jpg"><img src="screenshots/thumbs/55_Hud.jpg" width="100%"></a><br><sub><b>Hud</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/59_Hud__TickTemplate.jpg"><img src="screenshots/thumbs/59_Hud__TickTemplate.jpg" width="100%"></a><br><sub><b>Hud</b> › TickTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/60_Hud__TickTemplate.jpg"><img src="screenshots/thumbs/60_Hud__TickTemplate.jpg" width="100%"></a><br><sub><b>Hud</b> › TickTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_Hud__TickTemplate.jpg"><img src="screenshots/thumbs/61_Hud__TickTemplate.jpg" width="100%"></a><br><sub><b>Hud</b> › TickTemplate</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_ScreenFrames__Background.jpg"><img src="screenshots/thumbs/13_ScreenFrames__Background.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › SettingsFrame.Background</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_ScreenFrames__Background.jpg"><img src="screenshots/thumbs/15_ScreenFrames__Background.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › ProfileFrame.Background</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_ScreenFrames__Content.jpg"><img src="screenshots/thumbs/14_ScreenFrames__Content.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › ProfileFrame.Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/44_ScreenFrames__Content.jpg"><img src="screenshots/thumbs/44_ScreenFrames__Content.jpg" width="100%"></a><br><sub><b>ScreenFrames</b> › ProfileFrame.Content</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Decompiled/LocalPlayer%20Character.rbxm"><img src="screenshots/thumbs/models/01_LocalPlayer_Character.jpg" width="100%"></a><br><sub><b>LocalPlayer Character</b><br><code>models/ServerStorage/Decompiled/LocalPlayer Character.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Chest.rbxm"><img src="screenshots/thumbs/models/02_Chest.jpg" width="100%"></a><br><sub><b>Chest</b><br><code>models/Workspace/Map/Chest.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Auras/26.rbxm"><img src="screenshots/thumbs/models/03_26.jpg" width="100%"></a><br><sub><b>26</b><br><code>models/ReplicatedStorage/Assets/Auras/26.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Training%20Areas/Frozen%20Artifact.rbxm"><img src="screenshots/thumbs/models/04_Frozen_Artifact.jpg" width="100%"></a><br><sub><b>Frozen Artifact</b><br><code>models/Workspace/Training Areas/Frozen Artifact.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/SuffixBoard.rbxm"><img src="screenshots/thumbs/models/05_SuffixBoard.jpg" width="100%"></a><br><sub><b>SuffixBoard</b><br><code>models/Workspace/Leaderboards/SuffixBoard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/PoseProps/SilverSurfer/Cube.rbxm"><img src="screenshots/thumbs/models/06_Cube.jpg" width="100%"></a><br><sub><b>Cube</b><br><code>models/ReplicatedStorage/Assets/PoseProps/SilverSurfer/Cube.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Tree.rbxm"><img src="screenshots/thumbs/models/07_Tree.jpg" width="100%"></a><br><sub><b>Tree</b><br><code>models/Workspace/Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Inventory/InventoryRoom.rbxm"><img src="screenshots/thumbs/models/08_InventoryRoom.jpg" width="100%"></a><br><sub><b>InventoryRoom</b><br><code>models/Workspace/Inventory/InventoryRoom.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/AuraLB.rbxm"><img src="screenshots/thumbs/models/09_AuraLB.jpg" width="100%"></a><br><sub><b>AuraLB</b><br><code>models/Workspace/Leaderboards/AuraLB.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Divine%20Realm.rbxm"><img src="screenshots/thumbs/models/11_Divine_Realm.jpg" width="100%"></a><br><sub><b>Divine Realm</b><br><code>models/Workspace/Divine Realm.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Leaderboards/PlayTimeLB.rbxm"><img src="screenshots/thumbs/models/13_PlayTimeLB.jpg" width="100%"></a><br><sub><b>PlayTimeLB</b><br><code>models/Workspace/Leaderboards/PlayTimeLB.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/RebirthPad.rbxm"><img src="screenshots/thumbs/models/14_RebirthPad.jpg" width="100%"></a><br><sub><b>RebirthPad</b><br><code>models/Workspace/RebirthPad.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Hud Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Hud%20Handler.client.lua) <sub>1469 lines</sub><br>[`UIManager`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UIManager.lua) <sub>888 lines</sub><br>[`HudController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/HudController.lua) <sub>882 lines</sub><br>[`Monetization`](source/scripts/StarterPlayer/StarterPlayerScripts/Monetization.client.lua) <sub>263 lines</sub><br>[`Monetization`](source/scripts/ReplicatedStorage/Monetization.lua) <sub>637 lines</sub> |
| UI controllers / window managers / menus | [`InventoryRoomController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/InventoryRoomController.lua) <sub>551 lines</sub><br>[`InventoryHudController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/InventoryHudController.lua) <sub>286 lines</sub><br>[`UIManager`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UIManager.lua) <sub>888 lines</sub><br>[`HudController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/HudController.lua) <sub>882 lines</sub><br>[`InventoryTitlesPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/Handlers/InventoryTitlesPanel.lua) <sub>520 lines</sub> |
| Notifications, toasts, popups, prompts | [`Notifications`](source/scripts/ReplicatedStorage/Frameworks/Notifications.lua) <sub>478 lines</sub><br>[`TrainingAreasService`](source/scripts/ServerScriptService/GameServer/Services/TrainingAreasService.lua) <sub>601 lines</sub><br>[`CursedZoneService`](source/scripts/ServerScriptService/GameServer/Services/CursedZoneService.lua) <sub>282 lines</sub><br>[`ChestController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/ChestController.lua) <sub>599 lines</sub><br>[`Monetization`](source/scripts/ReplicatedStorage/Monetization.lua) <sub>637 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/StarterGui/LoadingScreen/Loading.client.lua) <sub>147 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraEffectsController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CameraEffectsController.lua) <sub>143 lines</sub><br>[`InventoryRoomController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/InventoryRoomController.lua) <sub>551 lines</sub><br>[`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>811 lines</sub><br>[`TrainingAreasController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/TrainingAreasController.lua) <sub>538 lines</sub><br>[`Hud Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Hud%20Handler.client.lua) <sub>1469 lines</sub> |
| VFX, particles, beams, hit effects | [`AuraCore`](source/scripts/ReplicatedStorage/Modules/AuraCore.lua) <sub>790 lines</sub><br>[`VFX Scaler`](source/scripts/StarterPlayer/StarterPlayerScripts/VFX%20Scaler.client.lua) <sub>576 lines</sub><br>[`RankFXController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/RankFXController.lua) <sub>138 lines</sub><br>[`Hud Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Hud%20Handler.client.lua) <sub>1469 lines</sub><br>[`Chest Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Chest%20Handler.client.lua) <sub>697 lines</sub> |
| DataStore / player data | [`DataService`](source/scripts/ServerScriptService/GameServer/Data/DataService.lua) <sub>330 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ReceiptService`](source/scripts/ServerScriptService/GameServer/Services/ReceiptService.lua) <sub>112 lines</sub><br>[`Monetization`](source/scripts/ReplicatedStorage/Monetization.lua) <sub>637 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>811 lines</sub><br>[`TrainingAreasController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/TrainingAreasController.lua) <sub>538 lines</sub><br>[`AuraPopupController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AuraPopupController.lua) <sub>175 lines</sub><br>[`CameraEffectsController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CameraEffectsController.lua) <sub>143 lines</sub><br>[`Notifications`](source/scripts/ReplicatedStorage/Frameworks/Notifications.lua) <sub>478 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`ChestService`](source/scripts/ServerScriptService/GameServer/Services/ChestService.lua) <sub>158 lines</sub><br>[`TrainingAreasService`](source/scripts/ServerScriptService/GameServer/Services/TrainingAreasService.lua) <sub>601 lines</sub><br>[`Chest Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Chest%20Handler.client.lua) <sub>697 lines</sub><br>[`ChestController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/ChestController.lua) <sub>599 lines</sub><br>[`CursedZoneService`](source/scripts/ServerScriptService/GameServer/Services/CursedZoneService.lua) <sub>282 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`FlyModule`](source/scripts/StarterPlayer/StarterPlayerScripts/FlyModule.lua) <sub>172 lines</sub> |
| Tycoon / plots / bases / building | [`Chest Handler`](source/scripts/StarterPlayer/StarterPlayerScripts/Chest%20Handler.client.lua) <sub>697 lines</sub><br>[`ChestController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/ChestController.lua) <sub>599 lines</sub><br>[`LeaderboardService`](source/scripts/ServerScriptService/GameServer/Services/LeaderboardService.lua) <sub>1172 lines</sub><br>[`ShopFrame`](source/scripts/StarterPlayer/StarterPlayerScripts/Handlers/ShopFrame.lua) <sub>591 lines</sub><br>[`InventoryPosePanel`](source/scripts/StarterPlayer/StarterPlayerScripts/Handlers/InventoryPosePanel.lua) <sub>846 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/GameServer/Services/LeaderboardService.lua) <sub>1172 lines</sub> |
| Admin panels & commands | [`AdminService`](source/scripts/ServerScriptService/GameServer/Services/AdminService.lua) <sub>148 lines</sub><br>[`AdminConfig`](source/scripts/ServerScriptService/GameServer/Config/AdminConfig.lua) <sub>15 lines</sub> |
| Sound & music | [`SmartAudio`](source/scripts/ReplicatedStorage/Frameworks/SmartAudio.lua) <sub>97 lines</sub><br>[`SoundMuteUtil`](source/scripts/ReplicatedStorage/Modules/SoundMuteUtil.lua) <sub>69 lines</sub><br>[`RankFXController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/RankFXController.lua) <sub>138 lines</sub> |
| Daily rewards, quests, codes, playtime | [`LegacyBridgeService`](source/scripts/ServerScriptService/GameServer/Services/LegacyBridgeService.lua) <sub>240 lines</sub><br>[`ChestService`](source/scripts/ServerScriptService/GameServer/Services/ChestService.lua) <sub>158 lines</sub><br>[`TrainingAreasService`](source/scripts/ServerScriptService/GameServer/Services/TrainingAreasService.lua) <sub>601 lines</sub><br>[`PlayerService`](source/scripts/ServerScriptService/GameServer/Services/PlayerService.lua) <sub>588 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`LeaderboardService`](source/scripts/ServerScriptService/GameServer/Services/LeaderboardService.lua) <sub>1172 lines</sub><br>[`AdminService`](source/scripts/ServerScriptService/GameServer/Services/AdminService.lua) <sub>148 lines</sub><br>[`CharacterReplicaService`](source/scripts/ServerScriptService/GameServer/Services/CharacterReplicaService.lua) <sub>313 lines</sub><br>[`PlayerService`](source/scripts/ServerScriptService/GameServer/Services/PlayerService.lua) <sub>588 lines</sub><br>[`TableUtil`](source/scripts/ServerScriptService/GameServer/Core/TableUtil.lua) <sub>58 lines</sub> |

### In the curated script library

- [Admin service with whitelist, rate limit, audit](../../Scripts/16-Admin/AdminService-AuditRateLimit__aura-ascension.lua) — Admin check by UserIds or group rank (from a config module), per-admin rate limit, an AllowedCommands whitelist, structured payloads, and an audit log of who ran what.
- [Lease session lock in UpdateAsync](../../Scripts/07-Data-Saving/DataService-LeaseLock__aura-ascension.lua) — Full data service: session lease stored inside the save and taken/checked in one UpdateAsync, dirty flags, retries, save slots, parallel shutdown flush with deadline.
- [Grouped profile template with _Meta](../../Scripts/07-Data-Saving/ProfileTemplate__aura-ascension.lua) — Data template grouped by purpose (Stats, Progression, Inventory, Monetization, Cooldowns, Admin audit trail) with a _Meta block holding version and session lease.
- [Sanitise, publish-on-change, merge (excerpt)](../../Scripts/15-Leaderboards/LeaderboardService-SanitizeMerge__aura-ascension.lua) — Clamps values (NaN/inf/negative/too big) before writing, publishes only changed values on an interval, formats durations and big numbers, and merges cached global entries with live players before sorting.
- [Abbreviated leaderstats (excerpt)](../../Scripts/15-Leaderboards/Leaderstats-Abbreviated__aura-ascension.lua) — Creates leaderstats with StringValue columns and fills them with FormatNumber text (1.2M) from the profile.
- [Receipt service with product maps](../../Scripts/08-Monetization/ReceiptService__aura-ascension.lua) — Small receipt service: waits for the profile, asks each owner service (boosts, rebirth packs, poses, packs) to grant by product id, returns NotProcessedYet when a grant fails, exposes an entitlements query.
- [Minimal table helpers](../../Scripts/19-Utility/TableUtil-Small__aura-ascension.lua) — DeepCopy (keys too), ShallowCopy, ArrayToSet, SetToArray (sorted) and SanitizeKey.
- [Remotes grouped per service](../../Scripts/19-Utility/RemoteBinder-PerService__aura-ascension.lua) — Creates RF/RE folders per service on demand (Knit-style layout) and binds functions / fires events by service + name.
- [Per-player per-key cooldown limiter](../../Scripts/19-Utility/RateLimiter-PerKey__aura-ascension.lua) — Allow(player, key, cooldown) returns false (and the time left) until the cooldown for that key has passed; Forget(player) on leave.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
