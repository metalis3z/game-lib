# Forsaken (alt copy)

> 👻 **Horror** · asymmetric horror (killer vs survivors) · source file `Forsaken.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/14_ShopScreen.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 12 ScreenGuis, 132 GUI objects → **18 screenshots** |
| Models (.rbxm) | 611 models, 17 model sets, 9 VFX sets |
| Lua builders (.lua) | 187 UI screens, 1 animation packs, 16 audio packs |
| Code | 954 scripts, 72,882 lines |
| Asset ids | 74 animations, 740 sounds |
| Safety scan | 2 HIGH / 14 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `AccanthisADFStd Regular`×18, `Guru Light`×7, `AccanthisADFStd Bold`×4, `Creepster Regular`×4, `LegacyArial Regular`×4

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_ShopScreen.jpg"><img src="screenshots/thumbs/14_ShopScreen.jpg" width="100%"></a><br><sub><b>ShopScreen</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_InventoryScreen.jpg"><img src="screenshots/thumbs/15_InventoryScreen.jpg" width="100%"></a><br><sub><b>InventoryScreen</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_Achievement.jpg"><img src="screenshots/thumbs/17_Achievement.jpg" width="100%"></a><br><sub><b>Achievement</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_EmoteMenuHolder.jpg"><img src="screenshots/thumbs/16_EmoteMenuHolder.jpg" width="100%"></a><br><sub><b>EmoteMenuHolder</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_DialogMain.jpg"><img src="screenshots/thumbs/13_DialogMain.jpg" width="100%"></a><br><sub><b>DialogMain</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_LoadingGui.jpg"><img src="screenshots/thumbs/01_LoadingGui.jpg" width="100%"></a><br><sub><b>LoadingGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_Intro2011X.jpg"><img src="screenshots/thumbs/02_Intro2011X.jpg" width="100%"></a><br><sub><b>Intro2011X</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_PlayerStats.jpg"><img src="screenshots/thumbs/09_PlayerStats.jpg" width="100%"></a><br><sub><b>PlayerStats</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_EndScreen.jpg"><img src="screenshots/thumbs/21_EndScreen.jpg" width="100%"></a><br><sub><b>EndScreen</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Sidebar.jpg"><img src="screenshots/thumbs/03_Sidebar.jpg" width="100%"></a><br><sub><b>Sidebar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_Sidebar__Full.jpg"><img src="screenshots/thumbs/04_Sidebar__Full.jpg" width="100%"></a><br><sub><b>Sidebar</b> › Full</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_Sidebarbackupbackup__Full.jpg"><img src="screenshots/thumbs/05_Sidebarbackupbackup__Full.jpg" width="100%"></a><br><sub><b>Sidebarbackupbackup</b> › Full</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_Sidebar.jpg"><img src="screenshots/thumbs/12_Sidebar.jpg" width="100%"></a><br><sub><b>Sidebar</b></sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_BackgroundUI.jpg"><img src="screenshots/thumbs/10_BackgroundUI.jpg" width="100%"></a><br><sub><b>BackgroundUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_RoundTimer.jpg"><img src="screenshots/thumbs/18_RoundTimer.jpg" width="100%"></a><br><sub><b>RoundTimer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_RoundTimerOLd.jpg"><img src="screenshots/thumbs/19_RoundTimerOLd.jpg" width="100%"></a><br><sub><b>RoundTimerOLd</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_RoundTimer.jpg"><img src="screenshots/thumbs/20_RoundTimer.jpg" width="100%"></a><br><sub><b>RoundTimer</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_PlayerInfo.jpg"><img src="screenshots/thumbs/22_PlayerInfo.jpg" width="100%"></a><br><sub><b>PlayerInfo</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/Red1x1x1x1/Config/Swords.rbxm"><img src="screenshots/thumbs/models/01_Swords.jpg" width="100%"></a><br><sub><b>Swords</b><br><code>models/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/Red1x1x1x1/Config/Swords.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Items/GravityGun/Item.rbxm"><img src="screenshots/thumbs/models/02_Item.jpg" width="100%"></a><br><sub><b>Item</b><br><code>models/ReplicatedStorage/Assets/Items/GravityGun/Item.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Televisor.rbxm"><img src="screenshots/thumbs/models/03_Televisor.jpg" width="100%"></a><br><sub><b>Televisor</b><br><code>models/Workspace/Map/Lobby/Interior/Televisor.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Chest.rbxm"><img src="screenshots/thumbs/models/04_Chest.jpg" width="100%"></a><br><sub><b>Chest</b><br><code>models/Workspace/Map/Lobby/Interior/Chest.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Emotes/_MissTheQuiet/EmoteHatAsset.rbxm"><img src="screenshots/thumbs/models/05_EmoteHatAsset.jpg" width="100%"></a><br><sub><b>EmoteHatAsset</b><br><code>models/ReplicatedStorage/Assets/Emotes/_MissTheQuiet/EmoteHatAsset.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/HorrorHotel/Map/IDK.rbxm"><img src="screenshots/thumbs/models/06_IDK.jpg" width="100%"></a><br><sub><b>IDK</b><br><code>models/ServerStorage/Assets/Maps/HorrorHotel/Map/IDK.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Structures/Jungle%20Gyms/Rock%20Formation~2.rbxm"><img src="screenshots/thumbs/models/07_Rock_Formation_2.jpg" width="100%"></a><br><sub><b>Rock Formation~2</b><br><code>models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Structures/Jungle Gyms/Rock Formation~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Map/Tree.rbxm"><img src="screenshots/thumbs/models/08_Tree.jpg" width="100%"></a><br><sub><b>Tree</b><br><code>models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Map/Tree.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Emotes/_MissTheQuiet/Hand/RightHandle.rbxm"><img src="screenshots/thumbs/models/09_RightHandle.jpg" width="100%"></a><br><sub><b>RightHandle</b><br><code>models/ReplicatedStorage/Assets/Emotes/_MissTheQuiet/Hand/RightHandle.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Model__x20.rbxm"><img src="screenshots/thumbs/models/10_Model_x20.jpg" width="100%"></a><br><sub><b>Model__x20</b><br><code>models/Workspace/Map/Lobby/Interior/Model__x20.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/HorrorHotel/Map/Slender.rbxm"><img src="screenshots/thumbs/models/12_Slender.jpg" width="100%"></a><br><sub><b>Slender</b><br><code>models/ServerStorage/Assets/Maps/HorrorHotel/Map/Slender.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Host%20Stand.rbxm"><img src="screenshots/thumbs/models/13_Host_Stand.jpg" width="100%"></a><br><sub><b>Host Stand</b><br><code>models/Workspace/Map/Lobby/Interior/Host Stand.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Map/Flower%20Bed.rbxm"><img src="screenshots/thumbs/models/14_Flower_Bed.jpg" width="100%"></a><br><sub><b>Flower Bed</b><br><code>models/ServerStorage/Assets/Maps/UltimateAssassinGrounds/Map/Map/Flower Bed.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Inventory`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Inventory.lua) <sub>665 lines</sub><br>[`Shop`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Shop.lua) <sub>748 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>1284 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Dusekkar/_GhosdeeriIfTheyLockedIn/Behavior.lua) <sub>538 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Dusekkar/Behavior.lua) <sub>539 lines</sub> |
| UI controllers / window managers / menus | [`Container`](source/scripts/ReplicatedStorage/Modules/Icon/Elements/Container.lua) <sub>135 lines</sub><br>[`Menu`](source/scripts/ReplicatedStorage/Modules/Icon/Elements/Menu.lua) <sub>211 lines</sub><br>[`Overflow`](source/scripts/ReplicatedStorage/Modules/Icon/Features/Overflow.lua) <sub>254 lines</sub><br>[`RadialMenu`](source/scripts/ReplicatedStorage/Systems/Character/Game/Emotes/RadialMenu.lua) <sub>198 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>816 lines</sub> |
| Notifications, toasts, popups, prompts | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>816 lines</sub><br>[`DialogHandler`](source/scripts/ReplicatedStorage/Systems/Player/UI/DialogHandler.lua) <sub>515 lines</sub><br>[`DisplayProductPurchase`](source/scripts/ReplicatedStorage/Systems/Player/Miscellaneous/DisplayProductPurchase.lua) <sub>95 lines</sub><br>[`Items`](source/scripts/ReplicatedStorage/Modules/Items.lua) <sub>249 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/ReplicatedFirst/Loading.client.lua) <sub>104 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>1284 lines</sub> |
| Camera, cutscenes, screen shake | [`ShakeyCamWhenLow`](source/scripts/ReplicatedStorage/Systems/Character/QualityOfLife/ShakeyCamWhenLow.lua) <sub>57 lines</sub><br>[`RoundNetwork`](source/scripts/ReplicatedStorage/Systems/Player/Networks/RoundNetwork.lua) <sub>352 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Chance/_CassidyChance/Behavior.lua) <sub>398 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Chance/Behavior.lua) <sub>396 lines</sub><br>[`Actors`](source/scripts/ReplicatedStorage/Modules/Actors.lua) <sub>651 lines</sub> |
| VFX, particles, beams, hit effects | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Dusekkar/_GhosdeeriIfTheyLockedIn/Behavior.lua) <sub>538 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Dusekkar/Behavior.lua) <sub>539 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/TwoTime/Behavior.lua) <sub>977 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/TwoTimeButOp/Behavior.lua) <sub>1020 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Guest1337/SorcererGuest/Behavior.lua) <sub>91 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Robux`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Tabs/Robux.lua) <sub>91 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Chance/_CassidyChance/Behavior.lua) <sub>398 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Chance/Behavior.lua) <sub>396 lines</sub><br>[`Eggrolled`](source/scripts/ReplicatedStorage/Assets/Emotes/Eggrolled.lua) <sub>14 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Hitboxes`](source/scripts/ReplicatedStorage/Modules/Hitboxes.lua) <sub>267 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/OldTwoTIme/Behavior.lua) <sub>716 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Taph/Behavior.lua) <sub>617 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Jason/Behavior.lua) <sub>580 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/TwoTime/Behavior.lua) <sub>977 lines</sub> |
| NPC / AI / monsters | [`ChaseThemesKiller`](source/scripts/ReplicatedStorage/Systems/Character/Game/ChaseThemesKiller.lua) <sub>93 lines</sub><br>[`KillerScreenFXOnSurvivorKill`](source/scripts/ReplicatedStorage/Systems/Character/QualityOfLife/KillerScreenFXOnSurvivorKill.lua) <sub>96 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Sprinting`](source/scripts/ReplicatedStorage/Systems/Character/Game/Sprinting.lua) <sub>211 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/__KillerNoli/Behavior.lua) <sub>621 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/__KillerNoliRework/Behavior.lua) <sub>602 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Taph/Behavior.lua) <sub>617 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>1284 lines</sub> |
| Tycoon / plots / bases / building | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Builderman/Behavior.lua) <sub>684 lines</sub> |
| Sound & music | [`Sounds`](source/scripts/ReplicatedStorage/Modules/Sounds.lua) <sub>275 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>816 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Jason/Behavior.lua) <sub>580 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/JohnDoe/Behavior.lua) <sub>578 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/JohnDoe/SK/Behavior.lua) <sub>464 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`AdminManager`](source/scripts/ServerStorage/ServerSystems/AdminManager.lua) <sub>92 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Systems/Player/UI/Menus/Inventory/Tabs/Emotes.lua`
- `scripts/ServerScriptService/Core/Join_Leave.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
