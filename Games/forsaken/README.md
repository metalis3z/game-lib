# Forsaken (uncopylocked)

> 👻 **Horror** · asymmetric horror (killer vs survivors) · source file `Forsaken Uncopylocked.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/13_ShopScreen.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 22 ScreenGuis, 886 GUI objects → **27 screenshots** |
| Models (.rbxm) | 1833 models, 55 model sets, 33 VFX sets |
| Lua builders (.lua) | 270 UI screens, 215 animation packs, 22 audio packs |
| Code | 1507 scripts, 127,868 lines |
| Asset ids | 888 animations, 593 sounds |
| Safety scan | 2 HIGH / 16 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `AccanthisADFStd Bold`×30, `AccanthisADFStd Regular`×27, `SourceSansPro Regular`×23, `SourceSansPro Bold`×11, `Arial Regular`×9

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_ShopScreen.jpg"><img src="screenshots/thumbs/13_ShopScreen.jpg" width="100%"></a><br><sub><b>ShopScreen</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_InventoryScreen.jpg"><img src="screenshots/thumbs/12_InventoryScreen.jpg" width="100%"></a><br><sub><b>InventoryScreen</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_Achievement.jpg"><img src="screenshots/thumbs/08_Achievement.jpg" width="100%"></a><br><sub><b>Achievement</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_EmoteMenuHolder.jpg"><img src="screenshots/thumbs/10_EmoteMenuHolder.jpg" width="100%"></a><br><sub><b>EmoteMenuHolder</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_DialogMain.jpg"><img src="screenshots/thumbs/05_DialogMain.jpg" width="100%"></a><br><sub><b>DialogMain</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_LoadingGui.jpg"><img src="screenshots/thumbs/01_LoadingGui.jpg" width="100%"></a><br><sub><b>LoadingGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/23_Intro2011X.jpg"><img src="screenshots/thumbs/23_Intro2011X.jpg" width="100%"></a><br><sub><b>Intro2011X</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/34_Intro2011X.jpg"><img src="screenshots/thumbs/34_Intro2011X.jpg" width="100%"></a><br><sub><b>Intro2011X</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_PlayerStats.jpg"><img src="screenshots/thumbs/02_PlayerStats.jpg" width="100%"></a><br><sub><b>PlayerStats</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_EndScreen.jpg"><img src="screenshots/thumbs/17_EndScreen.jpg" width="100%"></a><br><sub><b>EndScreen</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_Bottombar.jpg"><img src="screenshots/thumbs/06_Bottombar.jpg" width="100%"></a><br><sub><b>Bottombar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_Sidebar.jpg"><img src="screenshots/thumbs/07_Sidebar.jpg" width="100%"></a><br><sub><b>Sidebar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_Sidebar.jpg"><img src="screenshots/thumbs/27_Sidebar.jpg" width="100%"></a><br><sub><b>Sidebar</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_Sidebar__Full.jpg"><img src="screenshots/thumbs/28_Sidebar__Full.jpg" width="100%"></a><br><sub><b>Sidebar</b> › Full</sub></td>
<td width="33%" valign="top"><a href="screenshots/29_Sidebarbackupbackup__Full.jpg"><img src="screenshots/thumbs/29_Sidebarbackupbackup__Full.jpg" width="100%"></a><br><sub><b>Sidebarbackupbackup</b> › Full</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_Sidebar__Full.jpg"><img src="screenshots/thumbs/31_Sidebar__Full.jpg" width="100%"></a><br><sub><b>Sidebar</b> › Full</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_Sidebarbackupbackup__Full.jpg"><img src="screenshots/thumbs/32_Sidebarbackupbackup__Full.jpg" width="100%"></a><br><sub><b>Sidebarbackupbackup</b> › Full</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_EmoteMenuHolder__ExtraEmotes.jpg"><img src="screenshots/thumbs/11_EmoteMenuHolder__ExtraEmotes.jpg" width="100%"></a><br><sub><b>EmoteMenuHolder</b> › ExtraEmotes</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_BackgroundUI.jpg"><img src="screenshots/thumbs/03_BackgroundUI.jpg" width="100%"></a><br><sub><b>BackgroundUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_RoundTimer.jpg"><img src="screenshots/thumbs/14_RoundTimer.jpg" width="100%"></a><br><sub><b>RoundTimer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_RoundTimerOLd.jpg"><img src="screenshots/thumbs/15_RoundTimerOLd.jpg" width="100%"></a><br><sub><b>RoundTimerOLd</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_RoundTimer.jpg"><img src="screenshots/thumbs/16_RoundTimer.jpg" width="100%"></a><br><sub><b>RoundTimer</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_PranksterComet.jpg"><img src="screenshots/thumbs/09_PranksterComet.jpg" width="100%"></a><br><sub><b>PranksterComet</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_PlayerInfo.jpg"><img src="screenshots/thumbs/18_PlayerInfo.jpg" width="100%"></a><br><sub><b>PlayerInfo</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_c00lgui__Frame.jpg"><img src="screenshots/thumbs/26_c00lgui__Frame.jpg" width="100%"></a><br><sub><b>c00lgui</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_EventUI.jpg"><img src="screenshots/thumbs/33_EventUI.jpg" width="100%"></a><br><sub><b>EventUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/45_TestingGUI.jpg"><img src="screenshots/thumbs/45_TestingGUI.jpg" width="100%"></a><br><sub><b>TestingGUI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/Toon1x1x1x1/Config/Swords.rbxm"><img src="screenshots/thumbs/models/01_Swords.jpg" width="100%"></a><br><sub><b>Swords</b><br><code>models/ReplicatedStorage/Assets/Skins/Killers/1x1x1x1/Toon1x1x1x1/Config/Swords.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Items/GravityGun/Item.rbxm"><img src="screenshots/thumbs/models/02_Item.jpg" width="100%"></a><br><sub><b>Item</b><br><code>models/ReplicatedStorage/Assets/Items/GravityGun/Item.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Rigs/Survivors/Elliot/BumbleBeeElliot.rbxm"><img src="screenshots/thumbs/models/03_BumbleBeeElliot.jpg" width="100%"></a><br><sub><b>BumbleBeeElliot</b><br><code>models/ServerStorage/Assets/Rigs/Survivors/Elliot/BumbleBeeElliot.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Model__x66.rbxm"><img src="screenshots/thumbs/models/04_Model_x66.jpg" width="100%"></a><br><sub><b>Model__x66</b><br><code>models/Workspace/Map/Lobby/Interior/Model__x66.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/WallLanterns/WallLantern__x120.rbxm"><img src="screenshots/thumbs/models/05_WallLantern_x120.jpg" width="100%"></a><br><sub><b>WallLantern__x120</b><br><code>models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/WallLanterns/WallLantern__x120.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/OuterBuilding.rbxm"><img src="screenshots/thumbs/models/06_OuterBuilding.jpg" width="100%"></a><br><sub><b>OuterBuilding</b><br><code>models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/OuterBuilding.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Christmas%20Addons/Hat.rbxm"><img src="screenshots/thumbs/models/07_Hat.jpg" width="100%"></a><br><sub><b>Hat</b><br><code>models/Workspace/Map/Lobby/Christmas Addons/Hat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Christmas%20Addons/Environment/Meshes_Candy%20Cane.rbxm"><img src="screenshots/thumbs/models/08_Meshes_Candy_Cane.jpg" width="100%"></a><br><sub><b>Meshes_Candy Cane</b><br><code>models/Workspace/Map/Lobby/Christmas Addons/Environment/Meshes_Candy Cane.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Environment/Board.rbxm"><img src="screenshots/thumbs/models/09_Board.jpg" width="100%"></a><br><sub><b>Board</b><br><code>models/Workspace/Map/Lobby/Environment/Board.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Emotes/Sukuna/RightHandle.rbxm"><img src="screenshots/thumbs/models/10_RightHandle.jpg" width="100%"></a><br><sub><b>RightHandle</b><br><code>models/ReplicatedStorage/Assets/Emotes/Sukuna/RightHandle.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Televisor.rbxm"><img src="screenshots/thumbs/models/11_Televisor.jpg" width="100%"></a><br><sub><b>Televisor</b><br><code>models/Workspace/Map/Lobby/Interior/Televisor.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/Chandelier.rbxm"><img src="screenshots/thumbs/models/12_Chandelier.jpg" width="100%"></a><br><sub><b>Chandelier</b><br><code>models/ServerStorage/Assets/Maps/BloodfellManor/Map/Map/Chandelier.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Map/Lobby/Interior/Host%20Stand.rbxm"><img src="screenshots/thumbs/models/13_Host_Stand.jpg" width="100%"></a><br><sub><b>Host Stand</b><br><code>models/Workspace/Map/Lobby/Interior/Host Stand.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`Inventory`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Inventory.lua) <sub>720 lines</sub><br>[`Shop`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Shop.lua) <sub>825 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1902 lines</sub><br>[`EventShopClient`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/UI/EventShopClient.lua) <sub>666 lines</sub> |
| UI controllers / window managers / menus | [`ServerAbilities`](source/scripts/ReplicatedStorage/Assets/Survivors/JaneDoe/Behavior/ServerAbilities.lua) <sub>507 lines</sub><br>[`EventShopClient`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/UI/EventShopClient.lua) <sub>666 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/AnnoyingBox/Behavior.lua) <sub>554 lines</sub><br>[`Container`](source/scripts/ReplicatedStorage/Modules/Icon/Elements/Container.lua) <sub>133 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/2x2/Behavior.lua) <sub>237 lines</sub> |
| Notifications, toasts, popups, prompts | [`Notifications`](source/scripts/ReplicatedStorage/Modules/Notifications.lua) <sub>173 lines</sub><br>[`Server`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior/FakeGenerator/Scripts/Server.server.lua) <sub>175 lines</sub><br>[`CustomProximityPrompts`](source/scripts/ReplicatedStorage/Systems/Player/UI/Misc/CustomProximityPrompts.lua) <sub>548 lines</sub><br>[`Server`](source/scripts/ReplicatedStorage/Modules/CommonObjectives/SetupGenerators/Generator/Scripts/Server.server.lua) <sub>145 lines</sub><br>[`DialogHandler`](source/scripts/ReplicatedStorage/Systems/Player/UI/DialogHandler.lua) <sub>515 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/ReplicatedFirst/Loading.client.lua) <sub>220 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/Slasher/VanitySlasher/Behavior.lua) <sub>146 lines</sub><br>[`Util`](source/scripts/ReplicatedStorage/Modules/Util.lua) <sub>1976 lines</sub><br>[`Chamber`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/POIs/Chamber.lua) <sub>210 lines</sub> |
| Camera, cutscenes, screen shake | [`ShakeyCamWhenLow`](source/scripts/ReplicatedStorage/Systems/Character/QualityOfLife/ShakeyCamWhenLow.lua) <sub>58 lines</sub><br>[`RoundNetwork`](source/scripts/ReplicatedStorage/Systems/Player/Networks/RoundNetwork.lua) <sub>464 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`DynamicCamera`](source/scripts/ReplicatedStorage/Systems/Character/QualityOfLife/DynamicCamera.lua) <sub>46 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Slasher/Behavior.lua) <sub>719 lines</sub> |
| VFX, particles, beams, hit effects | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`Effects`](source/scripts/ReplicatedStorage/Assets/Items/GravityGun/Item/Effects.server.lua) <sub>415 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Dusekkar/Behavior.lua) <sub>571 lines</sub><br>[`ServerAbilities`](source/scripts/ReplicatedStorage/Assets/Survivors/JaneDoe/Behavior/ServerAbilities.lua) <sub>507 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Guest1337/%23KJGuest/Behavior.lua) <sub>239 lines</sub> |
| DataStore / player data | [`PlayerData`](source/scripts/ServerScriptService/Server/Systems/Data/PlayerData.lua) <sub>155 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ProductHandler`](source/scripts/ServerScriptService/Server/Systems/Shopping/ProductHandler.lua) <sub>70 lines</sub><br>[`Robux`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Tabs/Robux.lua) <sub>253 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`Effects`](source/scripts/ReplicatedStorage/Assets/Items/GravityGun/Item/Effects.server.lua) <sub>415 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Skins/Survivors/Chance/SniperChance/Behavior.lua) <sub>396 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Chance/Behavior.lua) <sub>464 lines</sub><br>[`Dialog`](source/scripts/ReplicatedStorage/Assets/EventStorage/2025_MASQUERADE/UI/EventShopClient/Dialog.lua) <sub>71 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`ServerAbilities`](source/scripts/ReplicatedStorage/Assets/Survivors/JaneDoe/Behavior/ServerAbilities.lua) <sub>507 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Civilian/Behavior.lua) <sub>440 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/AnnoyingBox/Behavior.lua) <sub>554 lines</sub><br>[`Hitboxes`](source/scripts/ReplicatedStorage/Modules/Hitboxes.lua) <sub>345 lines</sub> |
| NPC / AI / monsters | [`SimplePath`](source/scripts/ReplicatedStorage/Modules/SimplePath.lua) <sub>413 lines</sub><br>[`ChaseThemesKiller`](source/scripts/ReplicatedStorage/Systems/Character/Game/ChaseThemesKiller.lua) <sub>105 lines</sub><br>[`KillerScreenFXOnSurvivorKill`](source/scripts/ReplicatedStorage/Systems/Character/QualityOfLife/KillerScreenFXOnSurvivorKill.lua) <sub>118 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/AnnoyingBox/Behavior.lua) <sub>554 lines</sub><br>[`FakeNoli`](source/scripts/ReplicatedStorage/Modules/StatusEffects/KillerExclusive/Hallucination/HallucinationClass/FakeNoli.lua) <sub>568 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Nosferatu/Behavior.lua) <sub>2205 lines</sub><br>[`Sprinting`](source/scripts/ReplicatedStorage/Systems/Character/Game/Sprinting.lua) <sub>215 lines</sub> |
| Tycoon / plots / bases / building | [`LocalScript`](source/scripts/ReplicatedStorage/Assets/Skins/Killers/c00lkidd/%23LoreAccurateC00l/Config/c00lgui/Frame/Frame/Decals/LocalScript.server.lua) <sub>37 lines</sub><br>[`Robux`](source/scripts/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Tabs/Robux.lua) <sub>253 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Builderman/Behavior.lua) <sub>713 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Nosferatu/Behavior.lua) <sub>2205 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Noli/Behavior.lua) <sub>1902 lines</sub> |
| Leaderboards & stats | [`LeaderStats`](source/scripts/ServerScriptService/Server/Systems/Data/LeaderStats.lua) <sub>28 lines</sub> |
| Admin panels & commands | [`CommandManager`](source/scripts/ServerScriptService/Server/Systems/Core/CommandManager.lua) <sub>71 lines</sub><br>[`PranksterCommands`](source/scripts/ServerScriptService/Server/Modules/PranksterCommands.lua) <sub>49 lines</sub> |
| Sound & music | [`Sounds`](source/scripts/ReplicatedStorage/Modules/Sounds.lua) <sub>274 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Civilian/Behavior.lua) <sub>440 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Survivors/Jim/Behavior.lua) <sub>284 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/%21Herobrine/Behavior.lua) <sub>412 lines</sub><br>[`Behavior`](source/scripts/ServerStorage/Assets/Unused/Killers/%23Herobrine/Behavior.lua) <sub>393 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/Doombringer/Behavior.lua) <sub>780 lines</sub><br>[`Behavior`](source/scripts/ReplicatedStorage/Assets/Killers/%23SonicExe/Behavior.lua) <sub>432 lines</sub><br>[`Utility`](source/scripts/ReplicatedStorage/Modules/Icon/Utility.lua) <sub>572 lines</sub><br>[`CommandManager`](source/scripts/ServerScriptService/Server/Systems/Core/CommandManager.lua) <sub>71 lines</sub><br>[`AchievementUtil`](source/scripts/ReplicatedStorage/Modules/AchievementUtil.lua) <sub>372 lines</sub> |

### In the curated script library

- [Commands as ModuleScripts with required ranks](../../Scripts/16-Admin/CommandManager-RankedModules__forsaken.lua) — Each command is a ModuleScript (title, parameters, RequiredRank, AllowedInVIP, Executed); the server sends only the commands your rank allows and re-checks the rank on execute; private-server owners get VIP-safe commands.
- [Leaderstats mirrored from data values](../../Scripts/15-Leaderboards/LeaderStats-Mirror__forsaken.lua) — Clones a leaderstats template and mirrors Money/KillerChance from the player's data folder with GetPropertyChangedSignal.

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
