# Site Excalibur (Lunor)

> 🏙️ **Roleplay** · SCP facility roleplay (detain, solitary, gun shop) · source file `BY LUNOR - site_excalibur (1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/09_GunShop__Frame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 9 ScreenGuis, 118 GUI objects → **11 screenshots** |
| Models (.rbxm) | 818 models, 79 model sets, 7 VFX sets |
| Lua builders (.lua) | 20 UI screens, 11 animation packs, 42 audio packs |
| Code | 780 scripts, 51,504 lines |
| Asset ids | 136 animations, 655 sounds |
| Safety scan | 1 HIGH / 11 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `LegacyArial Regular`×22, `GothamSSm Medium`×19, `SourceSansPro Light`×9, `RobotoMono Regular`×9, `GothamSSm Regular`×4

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_GunShop__Frame.jpg"><img src="screenshots/thumbs/09_GunShop__Frame.jpg" width="100%"></a><br><sub><b>GunShop</b> › Frame</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_AnnouncementUI.jpg"><img src="screenshots/thumbs/11_AnnouncementUI.jpg" width="100%"></a><br><sub><b>AnnouncementUI</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_DeathGui.jpg"><img src="screenshots/thumbs/10_DeathGui.jpg" width="100%"></a><br><sub><b>DeathGui</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_HUD__ScopeFrame.jpg"><img src="screenshots/thumbs/04_HUD__ScopeFrame.jpg" width="100%"></a><br><sub><b>HUD</b> › ScopeFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_AnnouncementShowUI__Main.jpg"><img src="screenshots/thumbs/07_AnnouncementShowUI__Main.jpg" width="100%"></a><br><sub><b>AnnouncementShowUI</b> › Main</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_AdvanceToolGiver.jpg"><img src="screenshots/thumbs/01_AdvanceToolGiver.jpg" width="100%"></a><br><sub><b>AdvanceToolGiver</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_HelmGUI.jpg"><img src="screenshots/thumbs/02_HelmGUI.jpg" width="100%"></a><br><sub><b>HelmGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_Overlay.jpg"><img src="screenshots/thumbs/05_Overlay.jpg" width="100%"></a><br><sub><b>Overlay</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_SolitaryUI__Frame.jpg"><img src="screenshots/thumbs/06_SolitaryUI__Frame.jpg" width="100%"></a><br><sub><b>SolitaryUI</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_DetainUI__Frame.jpg"><img src="screenshots/thumbs/08_DetainUI__Frame.jpg" width="100%"></a><br><sub><b>DetainUI</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Interface.jpg"><img src="screenshots/thumbs/12_Interface.jpg" width="100%"></a><br><sub><b>Interface</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/GunShop.rbxm"><img src="screenshots/thumbs/models/01_GunShop.jpg" width="100%"></a><br><sub><b>GunShop</b><br><code>models/Workspace/GunShop.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/gun/GK5D__x6.rbxm"><img src="screenshots/thumbs/models/02_GK5D_x6.jpg" width="100%"></a><br><sub><b>GK5D__x6</b><br><code>models/Workspace/gun/GK5D__x6.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/radio%20tower.rbxm"><img src="screenshots/thumbs/models/03_radio_tower.jpg" width="100%"></a><br><sub><b>radio tower</b><br><code>models/Workspace/radio tower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Site/Entrance%20Zone/potted%20plant__x9.rbxm"><img src="screenshots/thumbs/models/04_potted_plant_x9.jpg" width="100%"></a><br><sub><b>potted plant__x9</b><br><code>models/Workspace/Site/Entrance Zone/potted plant__x9.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Site/Light%20Containment%20Zone/S2%20Hallway.rbxm"><img src="screenshots/thumbs/models/05_S2_Hallway.jpg" width="100%"></a><br><sub><b>S2 Hallway</b><br><code>models/Workspace/Site/Light Containment Zone/S2 Hallway.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/REMINGTON%20870.rbxm"><img src="screenshots/thumbs/models/06_REMINGTON_870.jpg" width="100%"></a><br><sub><b>REMINGTON 870</b><br><code>models/ServerStorage/REMINGTON 870.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Site/Props%20%26%20Other/potted%20plant.rbxm"><img src="screenshots/thumbs/models/07_potted_plant.jpg" width="100%"></a><br><sub><b>potted plant</b><br><code>models/Workspace/Site/Props & Other/potted plant.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Site/Entrance%20Zone/Crate.rbxm"><img src="screenshots/thumbs/models/08_Crate.jpg" width="100%"></a><br><sub><b>Crate</b><br><code>models/Workspace/Site/Entrance Zone/Crate.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Site/Entrance%20Zone/Sign.rbxm"><img src="screenshots/thumbs/models/09_Sign.jpg" width="100%"></a><br><sub><b>Sign</b><br><code>models/Workspace/Site/Entrance Zone/Sign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Bacon.rbxm"><img src="screenshots/thumbs/models/11_Bacon.jpg" width="100%"></a><br><sub><b>Bacon</b><br><code>models/Workspace/Bacon.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Site/Entrance%20Zone/Gun%20Rack/Gun%20Rack%20870.rbxm"><img src="screenshots/thumbs/models/12_Gun_Rack_870.jpg" width="100%"></a><br><sub><b>Gun Rack 870</b><br><code>models/Workspace/Site/Entrance Zone/Gun Rack/Gun Rack 870.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/radio%20tower~2.rbxm"><img src="screenshots/thumbs/models/13_radio_tower_2.jpg" width="100%"></a><br><sub><b>radio tower~2</b><br><code>models/Workspace/radio tower~2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Site/Light%20Containment%20Zone/S2%20Hallway~7.rbxm"><img src="screenshots/thumbs/models/14_S2_Hallway_7.jpg" width="100%"></a><br><sub><b>S2 Hallway~7</b><br><code>models/Workspace/Site/Light Containment Zone/S2 Hallway~7.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`ClientGunHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientGunHandler.client.lua) <sub>2818 lines</sub><br>[`Camera`](source/scripts/ServerStorage/GunFramework/SubModules/Camera.lua) <sub>204 lines</sub><br>[`ArmoredDoor`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientFramework/Classes/ObjectVisualiser/ArmoredDoor.lua) <sub>39 lines</sub><br>[`Combat`](source/scripts/ServerStorage/GunFramework/SubModules/Combat.lua) <sub>1087 lines</sub><br>[`tweenModule`](source/scripts/ReplicatedStorage/Modules/tweenModule.lua) <sub>134 lines</sub> |
| UI controllers / window managers / menus | [`DoorsMain`](source/scripts/StarterPlayer/StarterPlayerScripts/DoorsMain.client.lua) <sub>25 lines</sub><br>[`interactionClient`](source/scripts/StarterPlayer/StarterPlayerScripts/interactionClient.client.lua) <sub>193 lines</sub><br>[`ArmoredDoor`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientFramework/Classes/ObjectVisualiser/ArmoredDoor.lua) <sub>39 lines</sub><br>[`ArmoredFireGate`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientFramework/Classes/ObjectVisualiser/ArmoredFireGate.lua) <sub>32 lines</sub><br>[`CellDoor`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientFramework/Classes/ObjectVisualiser/CellDoor.lua) <sub>32 lines</sub> |
| Notifications, toasts, popups, prompts | [`ClientController`](source/scripts/ServerScriptService/RadioService/Assets/ClientController.client.lua) <sub>105 lines</sub><br>[`GuiController`](source/scripts/StarterPlayer/StarterPlayerScripts/GuiController.client.lua) <sub>81 lines</sub><br>[`LocalScript`](source/scripts/ServerScriptService/GiveUI/AnnouncementUI/Button/Main/ShoutSystem/ShoutButton/LocalScript.client.lua) <sub>19 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraClient`](source/scripts/StarterGui/ConsoleDisable/CameraMain/CameraClient.client.lua) <sub>803 lines</sub><br>[`Camera`](source/scripts/ServerStorage/GunFramework/SubModules/Camera.lua) <sub>204 lines</sub><br>[`ClientGunHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientGunHandler.client.lua) <sub>2818 lines</sub> |
| VFX, particles, beams, hit effects | [`Combat`](source/scripts/ServerStorage/GunFramework/SubModules/Combat.lua) <sub>1087 lines</sub><br>[`Control`](source/scripts/Workspace/Events/Control.server.lua) <sub>78 lines</sub><br>[`ClientGunHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientGunHandler.client.lua) <sub>2818 lines</sub><br>[`WeaponHandler~2`](source/scripts/ServerScriptService/Scripts/WeaponHandler~2.server.lua) <sub>107 lines</sub> |
| DataStore / player data | [`Datastore`](source/scripts/ServerScriptService/Scripts/Datastore.server.lua) <sub>21 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`ClientGunHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientGunHandler.client.lua) <sub>2818 lines</sub><br>[`Animate1`](source/scripts/ServerStorage/610s/SCP-610-1/Animate1.server.lua) <sub>543 lines</sub><br>[`CameraClient`](source/scripts/StarterGui/ConsoleDisable/CameraMain/CameraClient.client.lua) <sub>803 lines</sub><br>[`Character`](source/scripts/ServerStorage/GunFramework/SubModules/Character.lua) <sub>923 lines</sub><br>[`Combat`](source/scripts/ServerStorage/GunFramework/SubModules/Combat.lua) <sub>1087 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`WeaponHandler~2`](source/scripts/ServerScriptService/Scripts/WeaponHandler~2.server.lua) <sub>107 lines</sub><br>[`WeaponHandler`](source/scripts/ServerScriptService/NewWeapons/WeaponHandler.server.lua) <sub>76 lines</sub><br>[`WeaponHandler`](source/scripts/ServerScriptService/Scripts/WeaponHandler.server.lua) <sub>87 lines</sub><br>[`ClientGunHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientGunHandler.client.lua) <sub>2818 lines</sub><br>[`AttackScript`](source/scripts/Workspace/SCP000/AttackScript.server.lua) <sub>48 lines</sub> |
| NPC / AI / monsters | [`AI`](source/scripts/Workspace/SCPs/SCP025%20%28DISABLED%29/AI.server.lua) <sub>276 lines</sub><br>[`NPCHandler`](source/scripts/Workspace/SCPs/SCP-457/NPCHandler.server.lua) <sub>38 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Character`](source/scripts/ServerStorage/GunFramework/SubModules/Character.lua) <sub>923 lines</sub><br>[`ClientGunHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/ClientGunHandler.client.lua) <sub>2818 lines</sub><br>[`Animate1`](source/scripts/ServerStorage/610s/SCP-610-1/Animate1.server.lua) <sub>543 lines</sub><br>[`LocalMain`](source/scripts/Workspace/Zodiac/Body/Main_Model/DriveSeat/HelmGUI/LocalMain.client.lua) <sub>198 lines</sub><br>[`Combat`](source/scripts/ServerStorage/GunFramework/SubModules/Combat.lua) <sub>1087 lines</sub> |
| Tycoon / plots / bases / building | [`Settings`](source/scripts/Workspace/Adonis%20%20Admin%20%5BUSM%5D/Config/Settings.lua) <sub>460 lines</sub> |
| Admin panels & commands | [`Commands`](source/scripts/ServerScriptService/RadioService/Commands.lua) <sub>185 lines</sub><br>[`Settings`](source/scripts/Workspace/Adonis%20%20Admin%20%5BUSM%5D/Config/Settings.lua) <sub>460 lines</sub> |
| Sound & music | [`Audio`](source/scripts/ServerStorage/GunFramework/SubModules/Audio.lua) <sub>25 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`tweenModule`](source/scripts/ReplicatedStorage/Modules/tweenModule.lua) <sub>134 lines</sub><br>[`wearCloths`](source/scripts/ReplicatedStorage/InteractionKeys/lockerTag/wearCloths.lua) <sub>142 lines</sub><br>[`Signal`](source/scripts/ServerStorage/GunFramework/Classes/VisualizerClass/Signal.lua) <sub>49 lines</sub><br>[`Commands`](source/scripts/ServerScriptService/RadioService/Commands.lua) <sub>185 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/RadioService.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
