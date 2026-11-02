# Animal Hospital (horror, modded)

> 👻 **Horror** · horror roleplay (patients, skinwalkers, sanity) · source file `Animal modded.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/18_GiftList__Frame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 35 ScreenGuis, 833 GUI objects → **24 screenshots** |
| Models (.rbxm) | 359 models, 15 model sets, 5 VFX sets |
| Lua builders (.lua) | 52 UI screens, 3 animation packs, 8 audio packs |
| Code | 373 scripts, 61,037 lines |
| Asset ids | 386 animations, 713 sounds |
| Safety scan | 1 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×74, `Noto Serif SC Bold`×63, `Noto Serif SC Regular`×35, `SourceSansPro Regular`×34, `SpecialElite Bold`×24

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_Shop__Frame.jpg"><img src="screenshots/thumbs/16_Shop__Frame.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_GiftList__Frame.jpg"><img src="screenshots/thumbs/18_GiftList__Frame.jpg" width="100%"></a><br><sub><b>GiftList</b> › Frame</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Dialogue__black.jpg"><img src="screenshots/thumbs/01_Dialogue__black.jpg" width="100%"></a><br><sub><b>Dialogue</b> › Frame.black</sub></td>
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

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_AdminPanel__AdminPanel.jpg"><img src="screenshots/thumbs/23_AdminPanel__AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › AdminPanel</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_CharacterSelection__Selection.jpg"><img src="screenshots/thumbs/12_CharacterSelection__Selection.jpg" width="100%"></a><br><sub><b>CharacterSelection</b> › Selection</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_CharacterSelection__AnomalySelection.jpg"><img src="screenshots/thumbs/13_CharacterSelection__AnomalySelection.jpg" width="100%"></a><br><sub><b>CharacterSelection</b> › AnomalySelection</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_CharacterSelection__PremadeSelection.jpg"><img src="screenshots/thumbs/14_CharacterSelection__PremadeSelection.jpg" width="100%"></a><br><sub><b>CharacterSelection</b> › PremadeSelection</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_CharacterCreation.jpg"><img src="screenshots/thumbs/15_CharacterCreation.jpg" width="100%"></a><br><sub><b>CharacterCreation</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/17_Skins.jpg"><img src="screenshots/thumbs/17_Skins.jpg" width="100%"></a><br><sub><b>Skins</b></sub></td>
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
<td width="33%" valign="top"><a href="screenshots/05_MOBILE_BUTTONS.jpg"><img src="screenshots/thumbs/05_MOBILE_BUTTONS.jpg" width="100%"></a><br><sub><b>MOBILE_BUTTONS</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_PlayerDied__Frame.jpg"><img src="screenshots/thumbs/06_PlayerDied__Frame.jpg" width="100%"></a><br><sub><b>PlayerDied</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_Strikes__Frame.jpg"><img src="screenshots/thumbs/11_Strikes__Frame.jpg" width="100%"></a><br><sub><b>Strikes</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_Classes__Frame.jpg"><img src="screenshots/thumbs/19_Classes__Frame.jpg" width="100%"></a><br><sub><b>Classes</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_Classes__Info.jpg"><img src="screenshots/thumbs/20_Classes__Info.jpg" width="100%"></a><br><sub><b>Classes</b> › Info</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Classes__Center.jpg"><img src="screenshots/thumbs/21_Classes__Center.jpg" width="100%"></a><br><sub><b>Classes</b> › Center</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_Actions.jpg"><img src="screenshots/thumbs/22_Actions.jpg" width="100%"></a><br><sub><b>Actions</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_RadioGui.jpg"><img src="screenshots/thumbs/24_RadioGui.jpg" width="100%"></a><br><sub><b>RadioGui</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/NPCs/Visitors/SkinDummy.rbxm"><img src="screenshots/thumbs/models/01_SkinDummy.jpg" width="100%"></a><br><sub><b>SkinDummy</b><br><code>models/ReplicatedStorage/NPCs/Visitors/SkinDummy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ShopItemModels/Gun.rbxm"><img src="screenshots/thumbs/models/02_Gun.jpg" width="100%"></a><br><sub><b>Gun</b><br><code>models/ReplicatedStorage/ShopItemModels/Gun.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RoomFire.rbxm"><img src="screenshots/thumbs/models/03_RoomFire.jpg" width="100%"></a><br><sub><b>RoomFire</b><br><code>models/ReplicatedStorage/Misc/RoomFire.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Model__x102.rbxm"><img src="screenshots/thumbs/models/04_Model_x102.jpg" width="100%"></a><br><sub><b>Model__x102</b><br><code>models/Workspace/Model__x102.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ShopItemModels/CheckInSign.rbxm"><img src="screenshots/thumbs/models/05_CheckInSign.jpg" width="100%"></a><br><sub><b>CheckInSign</b><br><code>models/ReplicatedStorage/ShopItemModels/CheckInSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Misc/ShopSign.rbxm"><img src="screenshots/thumbs/models/06_ShopSign.jpg" width="100%"></a><br><sub><b>ShopSign</b><br><code>models/Workspace/Misc/ShopSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RoomFires/Room1__x8.rbxm"><img src="screenshots/thumbs/models/07_Room1_x8.jpg" width="100%"></a><br><sub><b>Room1__x8</b><br><code>models/ReplicatedStorage/Misc/RoomFires/Room1__x8.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Rooms/Emergency/Room8/MainSign.rbxm"><img src="screenshots/thumbs/models/08_MainSign.jpg" width="100%"></a><br><sub><b>MainSign</b><br><code>models/Workspace/Rooms/Emergency/Room8/MainSign.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Potted%20Plant.rbxm"><img src="screenshots/thumbs/models/09_Potted_Plant.jpg" width="100%"></a><br><sub><b>Potted Plant</b><br><code>models/Workspace/Potted Plant.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RatthewKeyAndNote.rbxm"><img src="screenshots/thumbs/models/10_RatthewKeyAndNote.jpg" width="100%"></a><br><sub><b>RatthewKeyAndNote</b><br><code>models/ReplicatedStorage/Misc/RatthewKeyAndNote.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterCharacter.rbxm"><img src="screenshots/thumbs/models/11_StarterCharacter.jpg" width="100%"></a><br><sub><b>StarterCharacter</b><br><code>models/StarterPlayer/StarterCharacter.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Misc/RoomFires/Room1.rbxm"><img src="screenshots/thumbs/models/12_Room1.jpg" width="100%"></a><br><sub><b>Room1</b><br><code>models/ReplicatedStorage/Misc/RoomFires/Room1.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Chocolate%20bar.rbxm"><img src="screenshots/thumbs/models/13_Chocolate_bar.jpg" width="100%"></a><br><sub><b>Chocolate bar</b><br><code>models/Workspace/Chocolate bar.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Rooms/Emergency/Room7/Minigame/StandIV.rbxm"><img src="screenshots/thumbs/models/14_StandIV.jpg" width="100%"></a><br><sub><b>StandIV</b><br><code>models/Workspace/Rooms/Emergency/Room7/Minigame/StandIV.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Buttons`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/Buttons.lua) <sub>184 lines</sub><br>[`ProximityPromptScript`](source/scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua) <sub>653 lines</sub><br>[`SanityLocal`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/SanityLocal.lua) <sub>196 lines</sub><br>[`SpecialEffects`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/SpecialEffects.lua) <sub>99 lines</sub><br>[`Cutscenes`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/Cutscenes.lua) <sub>790 lines</sub> |
| UI controllers / window managers / menus | [`EmergencyDoor`](source/scripts/ServerScriptService/EmergencyDoor.server.lua) <sub>126 lines</sub><br>[`StaffDoor`](source/scripts/ServerScriptService/StaffDoor.server.lua) <sub>126 lines</sub><br>[`DoorService`](source/scripts/ServerScriptService/DoorService.lua) <sub>92 lines</sub><br>[`Container`](source/scripts/ReplicatedStorage/TopbarIcon/Elements/Container.lua) <sub>184 lines</sub><br>[`Menu`](source/scripts/ReplicatedStorage/TopbarIcon/Elements/Menu.lua) <sub>203 lines</sub> |
| Notifications, toasts, popups, prompts | [`ProximityPromptScript`](source/scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua) <sub>653 lines</sub><br>[`NotificationsLocal`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/NotificationsLocal.lua) <sub>84 lines</sub><br>[`CheckInService`](source/scripts/ServerScriptService/CheckInService.lua) <sub>590 lines</sub><br>[`EmergencyService`](source/scripts/ServerScriptService/EmergencyService.lua) <sub>285 lines</sub><br>[`DoorsService`](source/scripts/ServerScriptService/DoorsService.lua) <sub>157 lines</sub> |
| Loading / intro screens | [`ver`](source/scripts/ServerScriptService/ver.server.lua) <sub>2144 lines</sub> |
| Camera, cutscenes, screen shake | [`Cutscenes`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/Cutscenes.lua) <sub>790 lines</sub><br>[`ShadowCamera`](source/scripts/ReplicatedStorage/AnomalyEvents/Local/ShadowCamera.lua) <sub>187 lines</sub><br>[`CameraSystem`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/CameraSystem.lua) <sub>448 lines</sub><br>[`Viewport`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/Viewport.lua) <sub>232 lines</sub> |
| VFX, particles, beams, hit effects | [`VisualEffects`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/VisualEffects.lua) <sub>216 lines</sub><br>[`CheckInService`](source/scripts/ServerScriptService/CheckInService.lua) <sub>590 lines</sub><br>[`GunsLocal`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/GunsLocal.lua) <sub>48 lines</sub><br>[`MiscService`](source/scripts/ServerScriptService/MiscService.lua) <sub>176 lines</sub><br>[`LocalBeam`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/LocalBeam.lua) <sub>29 lines</sub> |
| DataStore / player data | [`ProfileStore`](source/scripts/ServerScriptService/ProfileStore.lua) <sub>2243 lines</sub><br>[`DataService`](source/scripts/ServerScriptService/DataService.lua) <sub>210 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationBuys`](source/scripts/ServerScriptService/MonetizationBuys.server.lua) <sub>179 lines</sub><br>[`GunService`](source/scripts/ServerScriptService/GunService.lua) <sub>210 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/AdminPanel/AdminPanel/Holder/ScrollingFrame/ModelsMorph/Frame/Brainrot/LocalScript.client.lua) <sub>404 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`RNG`](source/scripts/ReplicatedStorage/Util/RNG.lua) <sub>88 lines</sub><br>[`AnomalyDirector`](source/scripts/ServerScriptService/AnomalyDirector.lua) <sub>290 lines</sub><br>[`UpgradeShopWares`](source/scripts/ReplicatedStorage/Data/UpgradeShopWares.lua) <sub>569 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`MeleeTools`](source/scripts/ReplicatedStorage/Tools/MeleeTools.lua) <sub>187 lines</sub><br>[`GunService`](source/scripts/ServerScriptService/GunService.lua) <sub>210 lines</sub><br>[`SwordScript`](source/scripts/ReplicatedStorage/Items/ClassicSword/SwordScript.server.lua) <sub>229 lines</sub><br>[`GunsLocal`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/GunsLocal.lua) <sub>48 lines</sub> |
| NPC / AI / monsters | [`PatientService`](source/scripts/ServerScriptService/PatientService.lua) <sub>632 lines</sub><br>[`__MCP_CommandListener`](source/scripts/ServerScriptService/__MCP_CommandListener.server.lua) <sub>67 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`CheckInService`](source/scripts/ServerScriptService/CheckInService.lua) <sub>590 lines</sub> |
| Tycoon / plots / bases / building | [`LocalScript`](source/scripts/StarterGui/AdminPanel/AdminPanel/Holder/ScrollingFrame/ModelsMorph/Frame/Brainrot/LocalScript.client.lua) <sub>404 lines</sub><br>[`PatientCareService`](source/scripts/ServerScriptService/PatientCareService.lua) <sub>612 lines</sub><br>[`ver`](source/scripts/ServerScriptService/ver.server.lua) <sub>2144 lines</sub> |
| Admin panels & commands | [`AdminActionsServer`](source/scripts/ServerScriptService/AdminActionsServer.server.lua) <sub>109 lines</sub><br>[`MonetizationBuys`](source/scripts/ServerScriptService/MonetizationBuys.server.lua) <sub>179 lines</sub> |
| Sound & music | [`MusicService`](source/scripts/StarterPlayer/StarterPlayerScripts/Util/MusicService.lua) <sub>205 lines</sub><br>[`MusicPlayer`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/MusicPlayer.lua) <sub>96 lines</sub><br>[`SanityLocal`](source/scripts/StarterPlayer/StarterPlayerScripts/UI/SanityLocal.lua) <sub>196 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Utility`](source/scripts/ReplicatedStorage/TopbarIcon/Utility.lua) <sub>698 lines</sub><br>[`Signal`](source/scripts/ReplicatedStorage/Util/Signal.lua) <sub>50 lines</sub><br>[`Maid`](source/scripts/ReplicatedStorage/Util/Maid.lua) <sub>117 lines</sub><br>[`EmergencyService`](source/scripts/ServerScriptService/EmergencyService.lua) <sub>285 lines</sub><br>[`NetworkOld`](source/scripts/ReplicatedStorage/Util/NetworkOld.lua) <sub>793 lines</sub> |

### In the curated script library

- [Visitor / customer queue NPCs](../../Scripts/12-NPC-AI/PatientQueueNPCs__animal-hospital-horror.lua) — Service that spawns visitor NPCs (unique or generic), walks them through the front door to a counter with pathfinding + MoveTo timeouts, uses a collision group so they pass through doors, seats them in a waiting room (claim chair, sit pose), then leaves and despawns. Comments are in Spanish.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/NexusAdminLoader.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
