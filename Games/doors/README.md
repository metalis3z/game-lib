# Doors (fully scripted)

> 👻 **Horror** · horror / room escape · source file `Doors Fully Scripted Game (1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/20_MainUI__ItemShop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 6 ScreenGuis, 1628 GUI objects → **21 screenshots** |
| Models (.rbxm) | 336 models, 8 model sets, 2 VFX sets |
| Lua builders (.lua) | 11 UI screens, 58 animation packs, 59 audio packs |
| Code | 1207 scripts, 106,926 lines |
| Asset ids | 2131 animations, 5758 sounds |
| Safety scan | 0 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `LegacyArial Regular`×268, `Oswald Regular`×242, `GothamSSm Regular`×25, `Oswald Medium`×14, `GothamSSm Heavy`×10

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_MainUI__ItemShop.jpg"><img src="screenshots/thumbs/20_MainUI__ItemShop.jpg" width="100%"></a><br><sub><b>MainUI</b> › ItemShop</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_MainUI__Settings.jpg"><img src="screenshots/thumbs/24_MainUI__Settings.jpg" width="100%"></a><br><sub><b>MainUI</b> › Settings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_MainUI__PromptFrame.jpg"><img src="screenshots/thumbs/14_MainUI__PromptFrame.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.PromptFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_MainUI__PromptFrameRift.jpg"><img src="screenshots/thumbs/18_MainUI__PromptFrameRift.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.PromptFrameRift</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_MainUI__PromptFrameYellow.jpg"><img src="screenshots/thumbs/19_MainUI__PromptFrameYellow.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.PromptFrameYellow</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_MainUI__ConsoleHints.jpg"><img src="screenshots/thumbs/22_MainUI__ConsoleHints.jpg" width="100%"></a><br><sub><b>MainUI</b> › ConsoleHints</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_PermUI__Stats.jpg"><img src="screenshots/thumbs/25_PermUI__Stats.jpg" width="100%"></a><br><sub><b>PermUI</b> › Stats</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_MainUI__Death.jpg"><img src="screenshots/thumbs/03_MainUI__Death.jpg" width="100%"></a><br><sub><b>MainUI</b> › Death</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_MainUI__DeathPanel.jpg"><img src="screenshots/thumbs/21_MainUI__DeathPanel.jpg" width="100%"></a><br><sub><b>MainUI</b> › DeathPanel</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_MainUI__PanelAccess.jpg"><img src="screenshots/thumbs/05_MainUI__PanelAccess.jpg" width="100%"></a><br><sub><b>MainUI</b> › PanelAccess</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainUI.jpg"><img src="screenshots/thumbs/01_MainUI.jpg" width="100%"></a><br><sub><b>MainUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_MainUI__EnterFloor.jpg"><img src="screenshots/thumbs/02_MainUI__EnterFloor.jpg" width="100%"></a><br><sub><b>MainUI</b> › EnterFloor</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_MainUI__LeaveFull.jpg"><img src="screenshots/thumbs/04_MainUI__LeaveFull.jpg" width="100%"></a><br><sub><b>MainUI</b> › LeaveFull</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_MainUI__Spaces.jpg"><img src="screenshots/thumbs/06_MainUI__Spaces.jpg" width="100%"></a><br><sub><b>MainUI</b> › Unused.SlotOccupied.Spaces</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_MainUI__Attachments.jpg"><img src="screenshots/thumbs/07_MainUI__Attachments.jpg" width="100%"></a><br><sub><b>MainUI</b> › Unused.SlotOccupied.Attachments</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_MainUI__Spaces.jpg"><img src="screenshots/thumbs/08_MainUI__Spaces.jpg" width="100%"></a><br><sub><b>MainUI</b> › Unused.Slot.Spaces</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_MainUI__SubliminalText.jpg"><img src="screenshots/thumbs/09_MainUI__SubliminalText.jpg" width="100%"></a><br><sub><b>MainUI</b> › SubliminalText</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_MainUI__Heart.jpg"><img src="screenshots/thumbs/10_MainUI__Heart.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.Heartbeat.Heart</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_MainUI__TapIconMobile.jpg"><img src="screenshots/thumbs/11_MainUI__TapIconMobile.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.Heartbeat.TapIconMobile</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_MainUI__SwapOld.jpg"><img src="screenshots/thumbs/16_MainUI__SwapOld.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.FlashSpecify.SwapOld</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_MainUI__Destination.jpg"><img src="screenshots/thumbs/17_MainUI__Destination.jpg" width="100%"></a><br><sub><b>MainUI</b> › MainFrame.Destination</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/DifficultyRooms/3/Hotel_CloseRoom/Hotel_CloseRoom2.rbxm"><img src="screenshots/thumbs/models/01_Hotel_CloseRoom2.jpg" width="100%"></a><br><sub><b>Hotel_CloseRoom2</b><br><code>models/ServerScriptService/Server/DifficultyRooms/3/Hotel_CloseRoom/Hotel_CloseRoom2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/DifficultyRooms/5/Hotel_BrokenRightWay/Hotel_BrokenRightWay1.rbxm"><img src="screenshots/thumbs/models/02_Hotel_BrokenRightWay1.jpg" width="100%"></a><br><sub><b>Hotel_BrokenRightWay1</b><br><code>models/ServerScriptService/Server/DifficultyRooms/5/Hotel_BrokenRightWay/Hotel_BrokenRightWay1.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Assets/Cleared_Items/Hotel_Downstairs4_Cleared.rbxm"><img src="screenshots/thumbs/models/03_Hotel_Downstairs4_Cleared.jpg" width="100%"></a><br><sub><b>Hotel_Downstairs4_Cleared</b><br><code>models/ServerScriptService/Server/Assets/Cleared_Items/Hotel_Downstairs4_Cleared.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Model~2.rbxm"><img src="screenshots/thumbs/models/04_Model_2.jpg" width="100%"></a><br><sub><b>Model~2</b><br><code>models/ServerStorage/Model~2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ClientBricks/ServerStorage/Lighter.rbxm"><img src="screenshots/thumbs/models/05_Lighter.jpg" width="100%"></a><br><sub><b>Lighter</b><br><code>models/ReplicatedStorage/ClientBricks/ServerStorage/Lighter.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Assets/Closets/ClosetChest.rbxm"><img src="screenshots/thumbs/models/06_ClosetChest.jpg" width="100%"></a><br><sub><b>ClosetChest</b><br><code>models/ServerScriptService/Server/Assets/Closets/ClosetChest.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Assets/DoorKey.rbxm"><img src="screenshots/thumbs/models/07_DoorKey.jpg" width="100%"></a><br><sub><b>DoorKey</b><br><code>models/ServerScriptService/Server/Assets/DoorKey.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Assets/Debris/Potted_Plant.rbxm"><img src="screenshots/thumbs/models/08_Potted_Plant.jpg" width="100%"></a><br><sub><b>Potted_Plant</b><br><code>models/ServerScriptService/Server/Assets/Debris/Potted_Plant.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/PicturePuzzle_Assets/Oval/Prop.rbxm"><img src="screenshots/thumbs/models/09_Prop.jpg" width="100%"></a><br><sub><b>Prop</b><br><code>models/ServerStorage/PicturePuzzle_Assets/Oval/Prop.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/DifficultyRooms/2/Hotel_Windelta/Hotel_Windelta5.rbxm"><img src="screenshots/thumbs/models/10_Hotel_Windelta5.jpg" width="100%"></a><br><sub><b>Hotel_Windelta5</b><br><code>models/ServerScriptService/Server/DifficultyRooms/2/Hotel_Windelta/Hotel_Windelta5.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ClientBricks/ServerStorage/SkeletonKey.rbxm"><img src="screenshots/thumbs/models/11_SkeletonKey.jpg" width="100%"></a><br><sub><b>SkeletonKey</b><br><code>models/ReplicatedStorage/ClientBricks/ServerStorage/SkeletonKey.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Special/Hotel_Courtyard.rbxm"><img src="screenshots/thumbs/models/12_Hotel_Courtyard.jpg" width="100%"></a><br><sub><b>Hotel_Courtyard</b><br><code>models/ServerScriptService/Server/Special/Hotel_Courtyard.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Assets/Hunt_DoorKey.rbxm"><img src="screenshots/thumbs/models/13_Hunt_DoorKey.jpg" width="100%"></a><br><sub><b>Hunt_DoorKey</b><br><code>models/ServerScriptService/Server/Assets/Hunt_DoorKey.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Server/Assets/Debris/Potted_Plant~2.rbxm"><img src="screenshots/thumbs/models/14_Potted_Plant_2.jpg" width="100%"></a><br><sub><b>Potted_Plant~2</b><br><code>models/ServerScriptService/Server/Assets/Debris/Potted_Plant~2.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`old health`](source/scripts/StarterGui/MainUI/Initiator/old%20health.client.lua) <sub>940 lines</sub><br>[`ToolAndViewmodelGun`](source/scripts/StarterGui/MainUI/Unused/ToolAndViewmodelGun.client.lua) <sub>725 lines</sub><br>[`Shade`](source/scripts/ReplicatedStorage/ClientModules/EntityModules/Shade.lua) <sub>438 lines</sub><br>[`Main_Game`](source/scripts/StarterGui/MainUI/Initiator/Main_Game.lua) <sub>352 lines</sub><br>[`Movement`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/Movement.client.lua) <sub>373 lines</sub> |
| UI controllers / window managers / menus | [`Furnitures`](source/scripts/ServerScriptService/Game/Directory/Furnitures.lua) <sub>553 lines</sub><br>[`Rolltop_Desk`](source/scripts/ServerScriptService/Game/Controls/Rolltop_Desk.lua) <sub>80 lines</sub><br>[`AdminPanelOld`](source/scripts/StarterGui/MainUI/Initiator/AdminPanelOld.client.lua) <sub>581 lines</sub><br>[`AdminPanel`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/AdminPanel.client.lua) <sub>833 lines</sub><br>[`Drawers`](source/scripts/ServerScriptService/Game/Directory/Drawers.lua) <sub>710 lines</sub> |
| Notifications, toasts, popups, prompts | [`PromptService`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/PromptService.client.lua) <sub>766 lines</sub><br>[`PromptServiceHint`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/PromptServiceHint.client.lua) <sub>284 lines</sub><br>[`Drawers`](source/scripts/ServerScriptService/Game/Directory/Drawers.lua) <sub>710 lines</sub><br>[`Furnitures`](source/scripts/ServerScriptService/Game/Directory/Furnitures.lua) <sub>553 lines</sub><br>[`Hunt_Drawers`](source/scripts/ServerScriptService/Game/Directory/Hunt_Drawers.lua) <sub>339 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/StarterPlayer/StarterPlayerScripts/Loading.client.lua) <sub>21 lines</sub><br>[`UIStuff`](source/scripts/StarterGui/MainUI/Initiator/Main_Lobby/UIStuff.client.lua) <sub>692 lines</sub> |
| Camera, cutscenes, screen shake | [`__WindShake`](source/scripts/StarterGui/MainUI/Modules/__WindShake.lua) <sub>324 lines</sub><br>[`Camera`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/Camera.client.lua) <sub>192 lines</sub><br>[`CameraShaker`](source/scripts/ReplicatedStorage/CameraShaker.lua) <sub>169 lines</sub><br>[`CameraShakeInstance`](source/scripts/ReplicatedStorage/CameraShaker/CameraShakeInstance.lua) <sub>128 lines</sub><br>[`MinigameHandler`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/MinigameHandler.client.lua) <sub>347 lines</sub> |
| VFX, particles, beams, hit effects | [`Drawers`](source/scripts/ServerScriptService/Game/Directory/Drawers.lua) <sub>710 lines</sub><br>[`ToolHandlerServer`](source/scripts/ServerStorage/Lighter/ToolHandlerServer.server.lua) <sub>240 lines</sub><br>[`Hunt_Drawers`](source/scripts/ServerScriptService/Game/Directory/Hunt_Drawers.lua) <sub>339 lines</sub><br>[`ToolHandlerServer`](source/scripts/ReplicatedStorage/ClientBricks/ServerStorage/Lighter/ToolHandlerServer.server.lua) <sub>239 lines</sub><br>[`Furnitures`](source/scripts/ServerScriptService/Game/Directory/Furnitures.lua) <sub>553 lines</sub> |
| DataStore / player data | [`ProfileService`](source/scripts/ServerScriptService/ServerScriptModules/ProfileService.lua) <sub>2417 lines</sub><br>[`_GlobalSaving`](source/scripts/ServerScriptService/Game/_GlobalSaving.server.lua) <sub>203 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Generation`](source/scripts/ServerScriptService/Server/Assets/DebrisOLD/Generation.server.lua) <sub>605 lines</sub><br>[`Generation`](source/scripts/ServerScriptService/Server/Special/SeekRooms/RandomHallway/Hotel_Standart/Door/Hidden/Generation.server.lua) <sub>376 lines</sub><br>[`Generation`](source/scripts/ServerScriptService/Server/Special/SeekRooms/RunningRooms/CoolGroom/Door/Hidden/Generation.server.lua) <sub>378 lines</sub><br>[`Generation`](source/scripts/ServerScriptService/Server/Special/SeekRooms/RunningRooms/LeftWayRoom/Door/Hidden/Generation.server.lua) <sub>381 lines</sub><br>[`Generation`](source/scripts/ServerScriptService/Server/Special/SeekRooms/RunningRooms/LeftWayRoom2/Door/Hidden/Generation.server.lua) <sub>381 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`CHandler`](source/scripts/ReplicatedStorage/ClientBricks/ServerStorage/Crucifix/CHandler.server.lua) <sub>1047 lines</sub><br>[`CHandler`](source/scripts/ServerStorage/Crucifix/CHandler.server.lua) <sub>1055 lines</sub><br>[`CHandler`](source/scripts/ServerStorage/CuriousCrucifix/CHandler.server.lua) <sub>1101 lines</sub><br>[`Movement`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/Movement.client.lua) <sub>373 lines</sub><br>[`GameDetails`](source/scripts/ServerScriptService/Game/Directory/GameDetails.lua) <sub>289 lines</sub> |
| NPC / AI / monsters | [`AssetControl`](source/scripts/ServerScriptService/Server/Special/Hotel_FigureLibrary/FigureSetup/FigureMovement/AssetControl.server.lua) <sub>350 lines</sub><br>[`MovingUpdated`](source/scripts/Workspace/LoadGame/Rush/MovingUpdated.server.lua) <sub>258 lines</sub><br>[`EntryRoomNodes`](source/scripts/ServerScriptService/Game/Directory/EntryRoomNodes.lua) <sub>104 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Movement`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/Movement.client.lua) <sub>373 lines</sub><br>[`Footsteps`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/Footsteps.client.lua) <sub>61 lines</sub><br>[`Drawers`](source/scripts/ServerScriptService/Game/Directory/Drawers.lua) <sub>710 lines</sub><br>[`ToolAndViewmodelGun`](source/scripts/StarterGui/MainUI/Unused/ToolAndViewmodelGun.client.lua) <sub>725 lines</sub><br>[`AssetControl`](source/scripts/ServerScriptService/Server/Special/Hotel_FigureLibrary/FigureSetup/FigureMovement/AssetControl.server.lua) <sub>350 lines</sub> |
| Admin panels & commands | [`AdminPanelOld`](source/scripts/StarterGui/MainUI/Initiator/AdminPanelOld.client.lua) <sub>581 lines</sub><br>[`AdminPanel`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/AdminPanel.client.lua) <sub>833 lines</sub><br>[`_AdminPanel`](source/scripts/ServerScriptService/Game/_AdminPanel.server.lua) <sub>243 lines</sub> |
| Sound & music | [`AssetControl`](source/scripts/ServerScriptService/Server/Assets/Entities/SeekMoving/AssetControl.server.lua) <sub>197 lines</sub><br>[`MainSound`](source/scripts/ServerScriptService/Game/Directory/MainSound.lua) <sub>29 lines</sub><br>[`HideMonster`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/RemoteListener/Modules/HideMonster.lua) <sub>248 lines</sub><br>[`Haste`](source/scripts/StarterGui/MainUI/Initiator/Main_Game/RemoteListener/Modules/Haste.lua) <sub>139 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Hunt_RoomGeneration`](source/scripts/ServerScriptService/Game/Directory/Hunt_RoomGeneration.lua) <sub>419 lines</sub><br>[`RoomGeneration`](source/scripts/ServerScriptService/Game/Directory/RoomGeneration.lua) <sub>1765 lines</sub><br>[`ProfileService`](source/scripts/ServerScriptService/ServerScriptModules/ProfileService.lua) <sub>2417 lines</sub><br>[`MadworkMaid`](source/scripts/ReplicatedStorage/MadworkMaid.lua) <sub>150 lines</sub><br>[`MadworkScriptSignal`](source/scripts/ReplicatedStorage/MadworkScriptSignal.lua) <sub>234 lines</sub> |

### In the curated script library

- [Blind 'Figure' hunter (hears movement)](../../Scripts/12-NPC-AI/FigureHearingHunter__doors.lua) — DOORS-style Figure: patrols a Nodes folder, but while 'blind' only targets players moving faster than a speed threshold (hearing); uses direct movement when it has line of sight and pathfinding otherwise; grab-and-kill on touch; crucifix check.
- [Rush entity room sweep](../../Scripts/12-NPC-AI/RushRoomRunner__doors.lua) — DOORS-style Rush: flickers lights, spawns a few rooms behind the players, then lerps the entity through each room's RoomStart->RoomEnd pathfinding waypoints at a fixed speed and awards a survival badge; supports crucifix cancel.
- [Room path-node generator](../../Scripts/12-NPC-AI/RoomPathNodes__doors.lua) — Computes a path from a room's RoomStart to RoomEnd once and stores the waypoints as numbered invisible parts (PathNodes) so entities can follow them later.
- [Analytic spring class](../../Scripts/01-UI-Animation/SpringClass_Quenty__doors.lua) — Classic analytic spring class (Quenty style): set .Target, read .Position each frame; works with numbers or Vector3. Good base for springy UI scale/offset.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
