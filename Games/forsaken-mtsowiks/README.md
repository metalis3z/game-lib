# Forsaken (mtsowiks remake)

> 👻 **Horror** · asymmetric horror (killer vs survivors) · source file `my best forsaken made by mtsowiks the goat xD!.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/22_EventUI.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 26 ScreenGuis, 491 GUI objects → **23 screenshots** |
| Models (.rbxm) | 2191 models, 52 model sets, 35 VFX sets |
| Lua builders (.lua) | 315 UI screens, 529 animation packs, 16 audio packs |
| Code | 2007 scripts, 157,311 lines |
| Asset ids | 444 animations, 556 sounds |
| Safety scan | 2 HIGH / 16 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `AccanthisADFStd Bold`×30, `AccanthisADFStd Regular`×28, `SourceSansPro Regular`×23, `Arial Regular`×14, `SourceSansPro Bold`×11

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_ShopScreen.jpg"><img src="screenshots/thumbs/10_ShopScreen.jpg" width="100%"></a><br><sub><b>ShopScreen</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_InventoryScreen.jpg"><img src="screenshots/thumbs/09_InventoryScreen.jpg" width="100%"></a><br><sub><b>InventoryScreen</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_Achievement.jpg"><img src="screenshots/thumbs/05_Achievement.jpg" width="100%"></a><br><sub><b>Achievement</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_EmoteMenuHolder.jpg"><img src="screenshots/thumbs/07_EmoteMenuHolder.jpg" width="100%"></a><br><sub><b>EmoteMenuHolder</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_DialogMain.jpg"><img src="screenshots/thumbs/02_DialogMain.jpg" width="100%"></a><br><sub><b>DialogMain</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_LoadingGui.jpg"><img src="screenshots/thumbs/01_LoadingGui.jpg" width="100%"></a><br><sub><b>LoadingGui</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_PlayerStats.jpg"><img src="screenshots/thumbs/16_PlayerStats.jpg" width="100%"></a><br><sub><b>PlayerStats</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_EndScreen.jpg"><img src="screenshots/thumbs/14_EndScreen.jpg" width="100%"></a><br><sub><b>EndScreen</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Bottombar.jpg"><img src="screenshots/thumbs/03_Bottombar.jpg" width="100%"></a><br><sub><b>Bottombar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_Sidebar.jpg"><img src="screenshots/thumbs/04_Sidebar.jpg" width="100%"></a><br><sub><b>Sidebar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_Sidebarbackupbackup__Full.jpg"><img src="screenshots/thumbs/19_Sidebarbackupbackup__Full.jpg" width="100%"></a><br><sub><b>Sidebarbackupbackup</b> › Full</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Sidebar.jpg"><img src="screenshots/thumbs/20_Sidebar.jpg" width="100%"></a><br><sub><b>Sidebar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Sidebar__Full.jpg"><img src="screenshots/thumbs/21_Sidebar__Full.jpg" width="100%"></a><br><sub><b>Sidebar</b> › Full</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_EmoteMenuHolder__ExtraEmotes.jpg"><img src="screenshots/thumbs/08_EmoteMenuHolder__ExtraEmotes.jpg" width="100%"></a><br><sub><b>EmoteMenuHolder</b> › ExtraEmotes</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_RoundTimer.jpg"><img src="screenshots/thumbs/11_RoundTimer.jpg" width="100%"></a><br><sub><b>RoundTimer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_RoundTimerOLd.jpg"><img src="screenshots/thumbs/12_RoundTimerOLd.jpg" width="100%"></a><br><sub><b>RoundTimerOLd</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/13_RoundTimer.jpg"><img src="screenshots/thumbs/13_RoundTimer.jpg" width="100%"></a><br><sub><b>RoundTimer</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_BackgroundUI.jpg"><img src="screenshots/thumbs/17_BackgroundUI.jpg" width="100%"></a><br><sub><b>BackgroundUI</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_PranksterComet.jpg"><img src="screenshots/thumbs/06_PranksterComet.jpg" width="100%"></a><br><sub><b>PranksterComet</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_PlayerInfo.jpg"><img src="screenshots/thumbs/15_PlayerInfo.jpg" width="100%"></a><br><sub><b>PlayerInfo</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/22_EventUI.jpg"><img src="screenshots/thumbs/22_EventUI.jpg" width="100%"></a><br><sub><b>EventUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_c00lgui__Frame.jpg"><img src="screenshots/thumbs/23_c00lgui__Frame.jpg" width="100%"></a><br><sub><b>c00lgui</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_TestingGUI.jpg"><img src="screenshots/thumbs/31_TestingGUI.jpg" width="100%"></a><br><sub><b>TestingGUI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/Toon1x1x1x1/Config/Swords.rbxm"><img src="screenshots/thumbs/models/01_Swords.jpg" width="100%"></a><br><sub><b>Swords</b><br><code>models/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/Toon1x1x1x1/Config/Swords.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Items/GravityGun/Item.rbxm"><img src="screenshots/thumbs/models/02_Item.jpg" width="100%"></a><br><sub><b>Item</b><br><code>models/ReplicatedStorage/Assets/Items/GravityGun/Item.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Model__x69.rbxm"><img src="screenshots/thumbs/models/03_Model_x69.jpg" width="100%"></a><br><sub><b>Model__x69</b><br><code>models/Workspace/Map/Lobby/Interior/Model__x69.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/WallLanterns/WallLantern__x120.rbxm"><img src="screenshots/thumbs/models/04_WallLantern_x120.jpg" width="100%"></a><br><sub><b>WallLantern__x120</b><br><code>models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/WallLanterns/WallLantern__x120.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/OuterBuilding.rbxm"><img src="screenshots/thumbs/models/05_OuterBuilding.jpg" width="100%"></a><br><sub><b>OuterBuilding</b><br><code>models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/OuterBuilding.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Emotes/Rodrick/Camcorder.rbxm"><img src="screenshots/thumbs/models/06_Camcorder.jpg" width="100%"></a><br><sub><b>Camcorder</b><br><code>models/ReplicatedStorage/Assets/Emotes/Rodrick/Camcorder.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Environment/Board.rbxm"><img src="screenshots/thumbs/models/07_Board.jpg" width="100%"></a><br><sub><b>Board</b><br><code>models/Workspace/Map/Lobby/Environment/Board.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Televisor.rbxm"><img src="screenshots/thumbs/models/08_Televisor.jpg" width="100%"></a><br><sub><b>Televisor</b><br><code>models/Workspace/Map/Lobby/Interior/Televisor.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/Chandelier.rbxm"><img src="screenshots/thumbs/models/09_Chandelier.jpg" width="100%"></a><br><sub><b>Chandelier</b><br><code>models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/Chandelier.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Host%20Stand.rbxm"><img src="screenshots/thumbs/models/10_Host_Stand.jpg" width="100%"></a><br><sub><b>Host Stand</b><br><code>models/Workspace/Map/Lobby/Interior/Host Stand.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Emotes/Sukuna/LeftHandle.rbxm"><img src="screenshots/thumbs/models/12_LeftHandle.jpg" width="100%"></a><br><sub><b>LeftHandle</b><br><code>models/ReplicatedStorage/Assets/Emotes/Sukuna/LeftHandle.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Environment/Folder/Sign.rbxm"><img src="screenshots/thumbs/models/13_Sign.jpg" width="100%"></a><br><sub><b>Sign</b><br><code>models/Workspace/Map/Lobby/Environment/Folder/Sign.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Table%20Mid%20Century.rbxm"><img src="screenshots/thumbs/models/14_Table_Mid_Century.jpg" width="100%"></a><br><sub><b>Table Mid Century</b><br><code>models/Workspace/Map/Lobby/Interior/Table Mid Century.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`EventShopClient`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/UI/EventShopClient.lua) <sub>725 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1864 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>2099 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`DebugUi`](source/scripts/ReplicatedStorage/Modules/Misc/SmartBone/Dependencies/Debug/DebugUi.lua) <sub>511 lines</sub> |
| UI controllers / window managers / menus | [`Menu`](source/scripts/ReplicatedStorage/Modules/Misc/SmartBone/Dependencies/Iris/widgets/Menu.lua) <sub>558 lines</sub><br>[`Window`](source/scripts/ReplicatedStorage/Modules/Misc/SmartBone/Dependencies/Iris/widgets/Window.lua) <sub>751 lines</sub><br>[`demoWindow`](source/scripts/ReplicatedStorage/Modules/Misc/SmartBone/Dependencies/Iris/demoWindow.lua) <sub>1881 lines</sub><br>[`DebugUi`](source/scripts/ReplicatedStorage/Modules/Misc/SmartBone/Dependencies/Debug/DebugUi.lua) <sub>511 lines</sub><br>[`Combo`](source/scripts/ReplicatedStorage/Modules/Misc/SmartBone/Dependencies/Iris/widgets/Combo.lua) <sub>436 lines</sub> |
| Notifications, toasts, popups, prompts | [`NotificationDisplay`](source/scripts/ReplicatedStorage/Systems/Player/Miscellaneous/NotificationDisplay.lua) <sub>112 lines</sub><br>[`Server`](source/scripts/ReplicatedStorage/Modules/CommonObjectives/SetupGenerators/Generator/Scripts/Server.server.lua) <sub>145 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`EventShopClient`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/UI/EventShopClient.lua) <sub>725 lines</sub><br>[`Client`](source/scripts/ServerStorage/Assets/Maps/BloodfellManor/Map/GeneratorPositions/Generator/Scripts/Client.server.lua) <sub>433 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/ReplicatedFirst/Loading.client.lua) <sub>159 lines</sub><br>[`2025_MASQUERADE_Client`](source/scripts/ReplicatedStorage/Events/2025_MASQUERADE_Client.lua) <sub>160 lines</sub><br>[`Chamber`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/POIs/Chamber.lua) <sub>240 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>2099 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Chance/KingOfPranksChance/Behavior.lua) <sub>45 lines</sub> |
| Camera, cutscenes, screen shake | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Slasher/Behavior.lua) <sub>777 lines</sub><br>[`NewBehavior`](source/scripts/ReplicatedStorage/Assets/Killers/Slasher/NewBehavior.lua) <sub>749 lines</sub><br>[`OldBehavior`](source/scripts/ReplicatedStorage/Assets/Killers/Slasher/OldBehavior.lua) <sub>679 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/Noli/%21AsgoreNoli/Behavior.lua) <sub>521 lines</sub> |
| VFX, particles, beams, hit effects | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/Noli/AdminNoli/Behavior.lua) <sub>274 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Dusekkar/Behavior.lua) <sub>578 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Guest1337/%23DamienGuest/Behavior.lua) <sub>117 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/Slasher/WhitePumpkinSlasher/Behavior.lua) <sub>199 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Config`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Chance/LuckRollChance/Config.lua) <sub>67 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>2099 lines</sub><br>[`Dialog`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/UI/EventShopClient/Dialog.lua) <sub>72 lines</sub><br>[`Eggrolled`](source/scripts/ReplicatedStorage/Assets/Emotes/Eggrolled.lua) <sub>16 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/JohnDoe/Behavior.lua) <sub>811 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1864 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Nosferatu/Behavior.lua) <sub>2205 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Guest1337/%23KJGuest/Behavior.lua) <sub>240 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Veeronica/Behavior.lua) <sub>1866 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`FakeNoli`](source/scripts/ReplicatedStorage/Modules/StatusEffects/KillerExclusive/Hallucination/HallucinationClass/FakeNoli.lua) <sub>576 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Nosferatu/Behavior.lua) <sub>2205 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Veeronica/Behavior.lua) <sub>1866 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1864 lines</sub> |
| Tycoon / plots / bases / building | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Builderman/Behavior.lua) <sub>747 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Nosferatu/Behavior.lua) <sub>2205 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1864 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>2099 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Veeronica/Behavior.lua) <sub>1866 lines</sub> |
| Sound & music | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/%21SukunaKiller/Behavior.lua) <sub>464 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/JohnDoe/Behavior.lua) <sub>811 lines</sub><br>[`OldBehavior`](source/scripts/ReplicatedStorage/Assets/Killers/Slasher/OldBehavior.lua) <sub>679 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/%23BoomerFormula1x1x1x1/Behavior.lua) <sub>695 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/%21c00lerkiddEno%20%28Fixed%20by%20BloxerTrue%29/Behavior.lua) <sub>308 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/1x1x1x1/Behavior.lua) <sub>1360 lines</sub><br>[`PlayerManager`](source/scripts/ServerScriptService/Server/Systems/Core/PlayerManager.lua) <sub>153 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1864 lines</sub><br>[`Config`](source/scripts/ReplicatedStorage/Assets/Survivors/Veeronica/Config.lua) <sub>296 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Assets/Skins/Killers/c00lkidd/#LoreAccurateC00l/Config/c00lgui/Frame/Frame/HighlightAll/LocalScript.server.lua`
- `scripts/ReplicatedStorage/Systems/Player/UI/Menus/Inventory/Tabs/Emotes.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
