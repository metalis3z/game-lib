# Bite By Night

> 👻 **Horror** · asymmetric horror (killer vs survivors) · source file `Bite By Night For Slbr Boosters !.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/04_UI__Owned.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 7 ScreenGuis, 2509 GUI objects → **35 screenshots** |
| Models (.rbxm) | 1150 models, 190 model sets, 32 VFX sets |
| Lua builders (.lua) | 15 UI screens, 78 animation packs, 207 audio packs |
| Code | 845 scripts, 102,542 lines |
| Asset ids | 808 animations, 877 sounds |
| Safety scan | 0 HIGH / 6 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Inconsolata Light`×122, `LegacyArial Regular`×76, `SourceSansPro SemiBold`×43, `Hind Siliguri SemiBold`×33, `Libre Baskerville Regular`×28

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_UI__Owned.jpg"><img src="screenshots/thumbs/04_UI__Owned.jpg" width="100%"></a><br><sub><b>UI</b> › ShopCards.SkinCards.Owned</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_UI__Shop.jpg"><img src="screenshots/thumbs/10_UI__Shop.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Shop</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_UI__Equipped.jpg"><img src="screenshots/thumbs/06_UI__Equipped.jpg" width="100%"></a><br><sub><b>UI</b> › InventoryCards.SkinCards.Button.Equipped</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_UI__Inventory.jpg"><img src="screenshots/thumbs/08_UI__Inventory.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Inventory</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_UI__DailyRewards.jpg"><img src="screenshots/thumbs/15_UI__DailyRewards.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.DailyRewards</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_UI__Tasks.jpg"><img src="screenshots/thumbs/16_UI__Tasks.jpg" width="100%"></a><br><sub><b>UI</b> › GameUIContainer.Tasks</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_UI__Buttons.jpg"><img src="screenshots/thumbs/07_UI__Buttons.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_UI__Settings.jpg"><img src="screenshots/thumbs/09_UI__Settings.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_UI__Spectate.jpg"><img src="screenshots/thumbs/11_UI__Spectate.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Spectate</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MainFrame__Notification.jpg"><img src="screenshots/thumbs/02_MainFrame__Notification.jpg" width="100%"></a><br><sub><b>MainFrame</b> › Notification</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_UI__Warning.jpg"><img src="screenshots/thumbs/14_UI__Warning.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Warning</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_UI__Loading.jpg"><img src="screenshots/thumbs/23_UI__Loading.jpg" width="100%"></a><br><sub><b>UI</b> › Loading</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_UI__GameStats.jpg"><img src="screenshots/thumbs/22_UI__GameStats.jpg" width="100%"></a><br><sub><b>UI</b> › GameStats</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainFrame.jpg"><img src="screenshots/thumbs/01_MainFrame.jpg" width="100%"></a><br><sub><b>MainFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_UI__Currency.jpg"><img src="screenshots/thumbs/12_UI__Currency.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Currency</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_Gen__Switch.jpg"><img src="screenshots/thumbs/28_Gen__Switch.jpg" width="100%"></a><br><sub><b>Gen</b> › MainFrame.Generator.Switch</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_Gen__Rope.jpg"><img src="screenshots/thumbs/29_Gen__Rope.jpg" width="100%"></a><br><sub><b>Gen</b> › MainFrame.Generator.Lever.Rope</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_Gen__MetalFrame.jpg"><img src="screenshots/thumbs/30_Gen__MetalFrame.jpg" width="100%"></a><br><sub><b>Gen</b> › MainFrame.Generator.Lever.MetalFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_Gen__MetalFrame2.jpg"><img src="screenshots/thumbs/31_Gen__MetalFrame2.jpg" width="100%"></a><br><sub><b>Gen</b> › MainFrame.Generator.Lever.MetalFrame2</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_bar.jpg"><img src="screenshots/thumbs/32_bar.jpg" width="100%"></a><br><sub><b>bar</b></sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_UI__Emote.jpg"><img src="screenshots/thumbs/26_UI__Emote.jpg" width="100%"></a><br><sub><b>UI</b> › MobileOverlay.Emote</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_UI__Timer.jpg"><img src="screenshots/thumbs/13_UI__Timer.jpg" width="100%"></a><br><sub><b>UI</b> › LobbyUIContainer.Timer</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_UI__Timer.jpg"><img src="screenshots/thumbs/21_UI__Timer.jpg" width="100%"></a><br><sub><b>UI</b> › GameUIContainer.Timer</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_UI.jpg"><img src="screenshots/thumbs/03_UI.jpg" width="100%"></a><br><sub><b>UI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_UI__Info.jpg"><img src="screenshots/thumbs/18_UI__Info.jpg" width="100%"></a><br><sub><b>UI</b> › GameUIContainer.Info</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_UI__Players.jpg"><img src="screenshots/thumbs/19_UI__Players.jpg" width="100%"></a><br><sub><b>UI</b> › GameUIContainer.Players</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_UI__LMS.jpg"><img src="screenshots/thumbs/20_UI__LMS.jpg" width="100%"></a><br><sub><b>UI</b> › GameUIContainer.LMS</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_UI__Holder.jpg"><img src="screenshots/thumbs/25_UI__Holder.jpg" width="100%"></a><br><sub><b>UI</b> › MobileOverlay.Holder</sub></td>
<td width="33%" valign="top"><a href="screenshots/27_Gen.jpg"><img src="screenshots/thumbs/27_Gen.jpg" width="100%"></a><br><sub><b>Gen</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_Selection.jpg"><img src="screenshots/thumbs/33_Selection.jpg" width="100%"></a><br><sub><b>Selection</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/34_EnnardVHS.jpg"><img src="screenshots/thumbs/34_EnnardVHS.jpg" width="100%"></a><br><sub><b>EnnardVHS</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/35_SnakeGUI.jpg"><img src="screenshots/thumbs/35_SnakeGUI.jpg" width="100%"></a><br><sub><b>SnakeGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_Dot.jpg"><img src="screenshots/thumbs/36_Dot.jpg" width="100%"></a><br><sub><b>Dot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/48_Template.jpg"><img src="screenshots/thumbs/48_Template.jpg" width="100%"></a><br><sub><b>Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/49_Template__USES.jpg"><img src="screenshots/thumbs/49_Template__USES.jpg" width="100%"></a><br><sub><b>Template</b> › USES</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Characters/Mimic/Normal/StarterCharacter.rbxm"><img src="screenshots/thumbs/models/01_StarterCharacter.jpg" width="100%"></a><br><sub><b>StarterCharacter</b><br><code>models/ReplicatedStorage/Characters/Mimic/Normal/StarterCharacter.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/CutscenesFolder/Intro/Springtrap-Toon/FolderModel/FIRE%20AXE%20BOX.rbxm"><img src="screenshots/thumbs/models/02_FIRE_AXE_BOX.jpg" width="100%"></a><br><sub><b>FIRE AXE BOX</b><br><code>models/ReplicatedStorage/Modules/CutscenesFolder/Intro/Springtrap-Toon/FolderModel/FIRE AXE BOX.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/Forest/Other/Supply%20Crates/Supply%20Crate__x19.rbxm"><img src="screenshots/thumbs/models/05_Supply_Crate_x19.jpg" width="100%"></a><br><sub><b>Supply Crate__x19</b><br><code>models/ServerStorage/Assets/Maps/Forest/Other/Supply Crates/Supply Crate__x19.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/MimicOutroMap/STRUCTURE/SKIRTBOARD/SkirtBoards%20Grouped.rbxm"><img src="screenshots/thumbs/models/06_SkirtBoards_Grouped.jpg" width="100%"></a><br><sub><b>SkirtBoards Grouped</b><br><code>models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/MimicOutroMap/STRUCTURE/SKIRTBOARD/SkirtBoards Grouped.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/MapSpringtrapIntro.rbxm"><img src="screenshots/thumbs/models/07_MapSpringtrapIntro.jpg" width="100%"></a><br><sub><b>MapSpringtrapIntro</b><br><code>models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/MapSpringtrapIntro.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/Warehouse/Other/Item%20Classification/Item%20Classification__x49.rbxm"><img src="screenshots/thumbs/models/08_Item_Classification_x49.jpg" width="100%"></a><br><sub><b>Item Classification__x49</b><br><code>models/ServerStorage/Assets/Maps/Warehouse/Other/Item Classification/Item Classification__x49.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/SpringtrapOutroMAP/DECORATION/Cardboard%20Boxes/CardBoard%20Boxes%20Grouped.rbxm"><img src="screenshots/thumbs/models/09_CardBoard_Boxes_Grouped.jpg" width="100%"></a><br><sub><b>CardBoard Boxes Grouped</b><br><code>models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/SpringtrapOutroMAP/DECORATION/Cardboard Boxes/CardBoard Boxes Grouped.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/Warehouse/Other/Meshes_BBN_%20WAREHOUSE%20MAP%20_Plane.010.rbxm"><img src="screenshots/thumbs/models/10_Meshes_BBN_WAREHOUSE_MAP_Plane_010.jpg" width="100%"></a><br><sub><b>Meshes_BBN_ WAREHOUSE MAP _Plane.010</b><br><code>models/ServerStorage/Assets/Maps/Warehouse/Other/Meshes_BBN_ WAREHOUSE MAP _Plane.010.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/Math/RightHand.rbxm"><img src="screenshots/thumbs/models/11_RightHand.jpg" width="100%"></a><br><sub><b>RightHand</b><br><code>models/ReplicatedStorage/Modules/Emotes/Math/RightHand.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/EnnardMap/SkirtBoard__x14.rbxm"><img src="screenshots/thumbs/models/12_SkirtBoard_x14.jpg" width="100%"></a><br><sub><b>SkirtBoard__x14</b><br><code>models/ReplicatedStorage/Modules/CutscenesFolder/CutsceneMaps/EnnardMap/SkirtBoard__x14.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Assets/Maps/Forest/Other/Tree%20Logs/Tree%20Log%20Long__x11.rbxm"><img src="screenshots/thumbs/models/13_Tree_Log_Long_x11.jpg" width="100%"></a><br><sub><b>Tree Log Long__x11</b><br><code>models/ServerStorage/Assets/Maps/Forest/Other/Tree Logs/Tree Log Long__x11.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/CutscenesFolder/Intro/Ennard-Spaghetti/FolderModel/Ennard2.rbxm"><img src="screenshots/thumbs/models/14_Ennard2.jpg" width="100%"></a><br><sub><b>Ennard2</b><br><code>models/ReplicatedStorage/Modules/CutscenesFolder/Intro/Ennard-Spaghetti/FolderModel/Ennard2.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Main`](source/scripts/StarterGui/UI/Main.client.lua) <sub>3273 lines</sub><br>[`Animations`](source/scripts/StarterGui/UI/UI/LobbyUIContainer/Shop/Holder/RobuxFrame/ScrollingFrame/2nd%20Emote%20Page/2nd%20Emote%20Page/Frame/Animations.client.lua) <sub>64 lines</sub><br>[`Animations`](source/scripts/StarterGui/UI/UI/LobbyUIContainer/Shop/Holder/RobuxFrame/ScrollingFrame/Scraps/2500/Button/Animations.client.lua) <sub>58 lines</sub><br>[`Animations`](source/scripts/StarterGui/UI/UI/LobbyUIContainer/Buttons/Holder/Animations.client.lua) <sub>171 lines</sub><br>[`Animations`](source/scripts/StarterGui/UI/UI/LobbyUIContainer/Inventory/Button/Animations.client.lua) <sub>132 lines</sub> |
| UI controllers / window managers / menus | [`Window`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Iris/widgets/Window.lua) <sub>897 lines</sub><br>[`Menu`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Iris/widgets/Menu.lua) <sub>611 lines</sub><br>[`demoWindow`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Iris/demoWindow.lua) <sub>1048 lines</sub><br>[`Combo`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Iris/widgets/Combo.lua) <sub>461 lines</sub><br>[`DebugUi`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Debug/DebugUi.lua) <sub>329 lines</sub> |
| Notifications, toasts, popups, prompts | [`SkinStealerThrow`](source/scripts/ServerStorage/Modules/Abilities/Ennard/SkinStealerThrow.lua) <sub>93 lines</sub><br>[`Utilities`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Utilities.lua) <sub>307 lines</sub><br>[`Window`](source/scripts/ReplicatedStorage/Modules/SmartBone/Dependencies/Iris/widgets/Window.lua) <sub>897 lines</sub><br>[`Beartrap`](source/scripts/ServerStorage/Modules/Abilities/Springtrap/Beartrap.lua) <sub>422 lines</sub><br>[`ProximityPromptScript`](source/scripts/StarterPlayer/StarterPlayerScripts/ProximityPromptScript.client.lua) <sub>612 lines</sub> |
| Loading / intro screens | [`On Respawn`](source/scripts/ReplicatedStorage/Characters/Survivor/Lobby/Normal/Elevator/On%20Respawn.client.lua) <sub>316 lines</sub><br>[`On Respawn`](source/scripts/ServerStorage/TemplateTest/madmaxxxhunter/Elevator/On%20Respawn.client.lua) <sub>279 lines</sub><br>[`Icon`](source/scripts/ReplicatedStorage/Modules/Icon.lua) <sub>1249 lines</sub><br>[`Theme`](source/scripts/Workspace/AssetReuploader/Plugin/UiLibrary/Theme.lua) <sub>267 lines</sub> |
| Camera, cutscenes, screen shake | [`CutsceneHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/CutsceneHandler.client.lua) <sub>76 lines</sub><br>[`Cutscenes`](source/scripts/ReplicatedStorage/Modules/Cutscenes.lua) <sub>269 lines</sub><br>[`CameraShakePresets`](source/scripts/ReplicatedStorage/Modules/CameraShaker/CameraShakePresets.lua) <sub>207 lines</sub><br>[`On Respawn`](source/scripts/ReplicatedStorage/Characters/Survivor/Lobby/Normal/Elevator/On%20Respawn.client.lua) <sub>316 lines</sub><br>[`Main`](source/scripts/StarterGui/UI/Main.client.lua) <sub>3273 lines</sub> |
| VFX, particles, beams, hit effects | [`EffectUtility`](source/scripts/ReplicatedStorage/Modules/EffectUtility.lua) <sub>148 lines</sub><br>[`DoorServer`](source/scripts/ServerStorage/Modules/Managers/DoorManager/DoorServer.server.lua) <sub>1296 lines</sub><br>[`VFXHandler`](source/scripts/ReplicatedStorage/Modules/VFXHandler.lua) <sub>178 lines</sub><br>[`Springtrap`](source/scripts/ReplicatedStorage/Modules/CutscenesFolder/Kills/Springtrap.lua) <sub>268 lines</sub><br>[`Main`](source/scripts/StarterGui/UI/Main.client.lua) <sub>3273 lines</sub> |
| DataStore / player data | [`PlayerData`](source/scripts/ServerStorage/Modules/General/PlayerData.lua) <sub>118 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Icon`](source/scripts/ReplicatedStorage/Modules/Icon.lua) <sub>1249 lines</sub><br>[`Main`](source/scripts/StarterGui/UI/Main.client.lua) <sub>3273 lines</sub><br>[`Types`](source/scripts/ReplicatedStorage/Modules/Icon/Types.lua) <sub>477 lines</sub><br>[`Animate2`](source/scripts/ReplicatedStorage/Characters/Survivor/Security%20Guard/Normal/Animate2.client.lua) <sub>598 lines</sub><br>[`Animate2`](source/scripts/ReplicatedStorage/Characters/Springtrap/Normal/Animate2.client.lua) <sub>542 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`HitboxManager`](source/scripts/ServerStorage/Modules/Managers/HitboxManager.lua) <sub>406 lines</sub><br>[`AxeThrow`](source/scripts/ServerStorage/Modules/Abilities/Springtrap/AxeThrow.lua) <sub>493 lines</sub><br>[`Swing`](source/scripts/ServerStorage/Modules/Abilities/Fighter/Swing.lua) <sub>94 lines</sub><br>[`Shared`](source/scripts/ServerStorage/Modules/Abilities/Ennard/Shared.lua) <sub>1244 lines</sub><br>[`Shared`](source/scripts/ServerStorage/Modules/Abilities/Mimic/Shared.lua) <sub>408 lines</sub> |
| NPC / AI / monsters | [`Shared`](source/scripts/ServerStorage/Modules/Abilities/Ennard/Shared.lua) <sub>1244 lines</sub><br>[`ChaseThemes-Killer`](source/scripts/ServerStorage/Modules/Managers/CharacterManager/Client/ChaseThemes-Killer.client.lua) <sub>98 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Movement`](source/scripts/ServerStorage/Modules/Managers/CharacterManager/Client/Movement.client.lua) <sub>155 lines</sub><br>[`StaminaManager`](source/scripts/ServerStorage/Modules/Managers/CharacterManager/StaminaManager.lua) <sub>230 lines</sub><br>[`Shared`](source/scripts/ServerStorage/Modules/Abilities/Ennard/Shared.lua) <sub>1244 lines</sub><br>[`Drink`](source/scripts/ServerStorage/Modules/Abilities/Customer/Drink.lua) <sub>66 lines</sub><br>[`Shared`](source/scripts/ServerStorage/Modules/Abilities/Mimic/Shared.lua) <sub>408 lines</sub> |
| Tycoon / plots / bases / building | [`Beartrap`](source/scripts/ServerStorage/Modules/Abilities/Springtrap/Beartrap.lua) <sub>422 lines</sub> |
| Admin panels & commands | [`ShopManager`](source/scripts/ServerStorage/Modules/Managers/ShopManager.lua) <sub>244 lines</sub><br>[`Admin`](source/scripts/ServerScriptService/Cmdr/BuiltInTypes/Admin.lua) <sub>83 lines</sub> |
| Sound & music | [`Main`](source/scripts/StarterGui/UI/Main.client.lua) <sub>3273 lines</sub><br>[`Client`](source/scripts/StarterPlayer/StarterPlayerScripts/Client.client.lua) <sub>338 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`ServerUtil`](source/scripts/ServerStorage/Modules/ServerUtil.lua) <sub>412 lines</sub><br>[`Utility`](source/scripts/ReplicatedStorage/Modules/Icon/Utility.lua) <sub>462 lines</sub><br>[`AbilityUtil`](source/scripts/ServerStorage/Modules/Abilities/AbilityUtil.lua) <sub>792 lines</sub><br>[`Util`](source/scripts/ServerScriptService/Cmdr/Shared/Util.lua) <sub>549 lines</sub><br>[`ArcadeManager`](source/scripts/ServerStorage/Modules/Managers/ArcadeManager.lua) <sub>150 lines</sub> |

### In the curated script library

- [Kill cam / intro definitions](../../Scripts/05-Camera-Cutscene/CutsceneDefinitions__bite-by-night.lua) — Data-driven kill cams / intros / outros (rig + animation + FOV curve per cutscene).
- [Hitbox manager (box / radius / ray)](../../Scripts/11-Combat/HitboxManager__bite-by-night.lua) — Configurable hitbox with Box/Radius/Ray modes, 'continue until found' polling and debug drawing.
- [Ability kit definition](../../Scripts/11-Combat/AbilityKitFighter__bite-by-night.lua) — How an ability framework declares a kit: keybind, cooldown, uses, server callback.
- [Swing ability (uses parry charges)](../../Scripts/11-Combat/SwingAbility__bite-by-night.lua) — Charge-scaled attack: dash + polling hitbox + stun + stacking debuffs.
- [Parry ability](../../Scripts/11-Combat/ParryAbility__bite-by-night.lua) — Parry window as an attribute + punishment on a whiff.
- [Throwable weapon with retrieval](../../Scripts/11-Combat/AxeThrowAbility__bite-by-night.lua) — Full throwable: aim, projectile, stick in the world, ProximityPrompt to retrieve, timeout return.
- [Server stamina manager](../../Scripts/13-Movement/StaminaManager__bite-by-night.lua) — Best stamina reference: server-side, attribute-based, forward-only drain, regen delay, exhaustion.
- [Leap ability](../../Scripts/13-Movement/LeapAbility__bite-by-night.lua) — Leap / pounce ability as a movement move with a landing hit.
- [EffectUtility](../../Scripts/06-VFX/EffectUtility__bite-by-night.lua) — Attribute-driven emit helper + Beam transparency tween (keypoint by keypoint).

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
