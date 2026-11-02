# Flood Escape 2

> 🧗 **Obby** · obby / survival (rising water maps) · source file `Flood Escape 2 🌊.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/01_EntryGui.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 14 ScreenGuis, 964 GUI objects → **29 screenshots** |
| Models (.rbxm) | 921 models, 0 model sets, 155 VFX sets |
| Lua builders (.lua) | 25 UI screens, 0 animation packs, 3 audio packs |
| Code | 262 scripts, 32,037 lines |
| Asset ids | 9 animations, 64 sounds |
| Safety scan | 2 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Ubuntu Regular`×120, `LegacyArial Regular`×100, `Roboto Regular`×17, `Ubuntu Bold`×10, `RobotoMono Regular`×2

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_MapTest__Settings.jpg"><img src="screenshots/thumbs/34_MapTest__Settings.jpg" width="100%"></a><br><sub><b>MapTest</b> › Window.Content.Pages.Settings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_NotifGui__Notification.jpg"><img src="screenshots/thumbs/14_NotifGui__Notification.jpg" width="100%"></a><br><sub><b>NotifGui</b> › Notification</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_GameGui__Loading.jpg"><img src="screenshots/thumbs/04_GameGui__Loading.jpg" width="100%"></a><br><sub><b>GameGui</b> › Loading</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_GameGui__Loading.jpg"><img src="screenshots/thumbs/18_GameGui__Loading.jpg" width="100%"></a><br><sub><b>GameGui</b> › Loading</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_EntryGui__Window1.jpg"><img src="screenshots/thumbs/03_EntryGui__Window1.jpg" width="100%"></a><br><sub><b>EntryGui</b> › EntryFrame.WindowDisplays.Window1</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_GameGui__Window.jpg"><img src="screenshots/thumbs/11_GameGui__Window.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.Window</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_GameGui__Window.jpg"><img src="screenshots/thumbs/25_GameGui__Window.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.Window</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_MapTest__MapList.jpg"><img src="screenshots/thumbs/32_MapTest__MapList.jpg" width="100%"></a><br><sub><b>MapTest</b> › Window.Content.Pages.MapList</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_MapTest__Servers.jpg"><img src="screenshots/thumbs/33_MapTest__Servers.jpg" width="100%"></a><br><sub><b>MapTest</b> › Window.Content.Pages.Servers</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_GameGui__HUD.jpg"><img src="screenshots/thumbs/13_GameGui__HUD.jpg" width="100%"></a><br><sub><b>GameGui</b> › HUD</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_GameGui__HUD.jpg"><img src="screenshots/thumbs/28_GameGui__HUD.jpg" width="100%"></a><br><sub><b>GameGui</b> › HUD</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_GameGui__OlderVoteBtn.jpg"><img src="screenshots/thumbs/08_GameGui__OlderVoteBtn.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.OlderVoteBtn</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_GameGui__OldVoteBtn.jpg"><img src="screenshots/thumbs/09_GameGui__OldVoteBtn.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.OldVoteBtn</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_GameGui__VoteBtn.jpg"><img src="screenshots/thumbs/10_GameGui__VoteBtn.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.VoteBtn</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_GameGui__OlderVoteBtn.jpg"><img src="screenshots/thumbs/22_GameGui__OlderVoteBtn.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.OlderVoteBtn</sub></td>
<td width="33%" valign="top"><a href="screenshots/23_GameGui__OldVoteBtn.jpg"><img src="screenshots/thumbs/23_GameGui__OldVoteBtn.jpg" width="100%"></a><br><sub><b>GameGui</b> › VoteMap.OldVoteBtn</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_EntryGui.jpg"><img src="screenshots/thumbs/01_EntryGui.jpg" width="100%"></a><br><sub><b>EntryGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_EntryGui__ExtraModes.jpg"><img src="screenshots/thumbs/02_EntryGui__ExtraModes.jpg" width="100%"></a><br><sub><b>EntryGui</b> › EntryFrame.ExtraModes</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_GameGui__Border.jpg"><img src="screenshots/thumbs/05_GameGui__Border.jpg" width="100%"></a><br><sub><b>GameGui</b> › Waiting.NewUI.Border</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_GameGui__Content.jpg"><img src="screenshots/thumbs/06_GameGui__Content.jpg" width="100%"></a><br><sub><b>GameGui</b> › Waiting.NewUI.Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_GameGui__Intensity.jpg"><img src="screenshots/thumbs/07_GameGui__Intensity.jpg" width="100%"></a><br><sub><b>GameGui</b> › Waiting.UI.Content.Buttons.Intensity</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_GameGui__LvlUp.jpg"><img src="screenshots/thumbs/12_GameGui__LvlUp.jpg" width="100%"></a><br><sub><b>GameGui</b> › LvlUp</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_LiftWaitVisual.jpg"><img src="screenshots/thumbs/15_LiftWaitVisual.jpg" width="100%"></a><br><sub><b>LiftWaitVisual</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_FormGui.jpg"><img src="screenshots/thumbs/16_FormGui.jpg" width="100%"></a><br><sub><b>FormGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/17_FormGui__FormFrame.jpg"><img src="screenshots/thumbs/17_FormGui__FormFrame.jpg" width="100%"></a><br><sub><b>FormGui</b> › FormFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_GameGui__Content.jpg"><img src="screenshots/thumbs/20_GameGui__Content.jpg" width="100%"></a><br><sub><b>GameGui</b> › Waiting.NewUI.Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_GameGui__Challenges.jpg"><img src="screenshots/thumbs/26_GameGui__Challenges.jpg" width="100%"></a><br><sub><b>GameGui</b> › Challenges</sub></td>
<td width="33%" valign="top"><a href="screenshots/27_GameGui__LvlUp.jpg"><img src="screenshots/thumbs/27_GameGui__LvlUp.jpg" width="100%"></a><br><sub><b>GameGui</b> › LvlUp</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_MapTest.jpg"><img src="screenshots/thumbs/31_MapTest.jpg" width="100%"></a><br><sub><b>MapTest</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lobby.rbxm"><img src="screenshots/thumbs/models/01_Lobby.jpg" width="100%"></a><br><sub><b>Lobby</b><br><code>models/Workspace/Lobby.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Skins/248/TugBoatCap%27nHat.rbxm"><img src="screenshots/thumbs/models/02_TugBoatCap_nHat.jpg" width="100%"></a><br><sub><b>TugBoatCap'nHat</b><br><code>models/ReplicatedStorage/Items/Skins/248/TugBoatCap'nHat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Skins/716/FlowerWreathAccessory.rbxm"><img src="screenshots/thumbs/models/03_FlowerWreathAccessory.jpg" width="100%"></a><br><sub><b>FlowerWreathAccessory</b><br><code>models/ReplicatedStorage/Items/Skins/716/FlowerWreathAccessory.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Tanks/539.rbxm"><img src="screenshots/thumbs/models/04_539.jpg" width="100%"></a><br><sub><b>539</b><br><code>models/ReplicatedStorage/Items/Tanks/539.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/2_BG_BeneathTheRuins.rbxm"><img src="screenshots/thumbs/models/05_2_BG_BeneathTheRuins.jpg" width="100%"></a><br><sub><b>2_BG_BeneathTheRuins</b><br><code>models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/2_BG_BeneathTheRuins.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/4FamiliarRuins.rbxm"><img src="screenshots/thumbs/models/06_4FamiliarRuins.jpg" width="100%"></a><br><sub><b>4FamiliarRuins</b><br><code>models/ServerStorage/Maps/4FamiliarRuins.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/DefaultTitle.rbxm"><img src="screenshots/thumbs/models/07_DefaultTitle.jpg" width="100%"></a><br><sub><b>DefaultTitle</b><br><code>models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/DefaultTitle.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Skins/78/CrystalCrown.rbxm"><img src="screenshots/thumbs/models/08_CrystalCrown.jpg" width="100%"></a><br><sub><b>CrystalCrown</b><br><code>models/ReplicatedStorage/Items/Skins/78/CrystalCrown.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/4_BG_DarkSciFacility.rbxm"><img src="screenshots/thumbs/models/09_4_BG_DarkSciFacility.jpg" width="100%"></a><br><sub><b>4_BG_DarkSciFacility</b><br><code>models/ReplicatedStorage/TitleScreenResources/TitleBackgrounds/4_BG_DarkSciFacility.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/SV_MAIN_GameScript/Exploading.rbxm"><img src="screenshots/thumbs/models/11_Exploading.jpg" width="100%"></a><br><sub><b>Exploading</b><br><code>models/ServerScriptService/SV_MAIN_GameScript/Exploading.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Skins/242/flower_power_shades.rbxm"><img src="screenshots/thumbs/models/12_flower_power_shades.jpg" width="100%"></a><br><sub><b>flower_power_shades</b><br><code>models/ReplicatedStorage/Items/Skins/242/flower_power_shades.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Skins/211/FlowerWitch.rbxm"><img src="screenshots/thumbs/models/14_FlowerWitch.jpg" width="100%"></a><br><sub><b>FlowerWitch</b><br><code>models/ReplicatedStorage/Items/Skins/211/FlowerWitch.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`FeedbackButtonScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FeedbackButton/FeedbackButtonScript.client.lua) <sub>27 lines</sub><br>[`DropdownScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript/Dropdown/DropdownScript.client.lua) <sub>140 lines</sub><br>[`TimelinePlayer`](source/scripts/ReplicatedStorage/SharedModules/TimelinePlayer.lua) <sub>599 lines</sub><br>[`FormScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript.client.lua) <sub>463 lines</sub> |
| UI controllers / window managers / menus | [`DropdownScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript/Dropdown/DropdownScript.client.lua) <sub>140 lines</sub><br>[`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`ProductWindows_Script`](source/scripts/ReplicatedStorage/GuiBackup/ProductWindows_Script.client.lua) <sub>43 lines</sub><br>[`CL_SocialScript`](source/scripts/ServerScriptService/SV_MAIN_GameScript/MenuGui/Social/CL_SocialScript.client.lua) <sub>53 lines</sub><br>[`FormScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript.client.lua) <sub>463 lines</sub> |
| Notifications, toasts, popups, prompts | [`TimelinePlayer`](source/scripts/ReplicatedStorage/SharedModules/TimelinePlayer.lua) <sub>599 lines</sub><br>[`TimelinePlayerClient`](source/scripts/ReplicatedStorage/SharedModules/TimelinePlayerClient.lua) <sub>288 lines</sub><br>[`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`FormScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript.client.lua) <sub>463 lines</sub> |
| Loading / intro screens | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`DropdownScript`](source/scripts/ReplicatedStorage/GuiBackup/FormGui/FormScript/Dropdown/DropdownScript.client.lua) <sub>140 lines</sub><br>[`CL_EntryScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_EntryScript.client.lua) <sub>396 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedFirst/LocalScript.client.lua) <sub>16 lines</sub> |
| Camera, cutscenes, screen shake | [`CL_TimelineWrapper`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_TimelineWrapper.client.lua) <sub>257 lines</sub><br>[`TimelinePlayer`](source/scripts/ReplicatedStorage/SharedModules/TimelinePlayer.lua) <sub>599 lines</sub><br>[`TimelinePlayerClient`](source/scripts/ReplicatedStorage/SharedModules/TimelinePlayerClient.lua) <sub>288 lines</sub><br>[`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`CL_EntryScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_EntryScript.client.lua) <sub>396 lines</sub> |
| VFX, particles, beams, hit effects | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ProductWindows_Script`](source/scripts/ReplicatedStorage/GuiBackup/ProductWindows_Script.client.lua) <sub>43 lines</sub><br>[`ProductWindows_Script`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_EntryScript/EntryGui/EntryFrame/WindowDisplays/Window3/ProductWindows_Script.client.lua) <sub>31 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`CL_CornerClip`](source/scripts/StarterPlayer/StarterCharacterScripts/CL_CornerClip.client.lua) <sub>113 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`CharSpecs`](source/scripts/StarterPlayer/StarterCharacterScripts/CharSpecs.client.lua) <sub>243 lines</sub> |
| Tycoon / plots / bases / building | [`CL_OptionsScript`](source/scripts/ServerScriptService/SV_MAIN_GameScript/MenuGui/Options/CL_OptionsScript.client.lua) <sub>250 lines</sub><br>[`CL_EntryScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_EntryScript.client.lua) <sub>396 lines</sub><br>[`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub><br>[`FE2Library`](source/scripts/ReplicatedStorage/SharedModules/FE2Library.lua) <sub>371 lines</sub> |
| Admin panels & commands | [`AdminModule`](source/scripts/ServerScriptService/SV_MAIN_GameScript/AdminModule.lua) <sub>134 lines</sub> |
| Sound & music | [`CL_MAIN_GameScript`](source/scripts/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript.client.lua) <sub>2614 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`AdminModule`](source/scripts/ServerScriptService/SV_MAIN_GameScript/AdminModule.lua) <sub>134 lines</sub> |

### In the curated script library

- [Smallest custom loading screen](../../Scripts/04-Loading-Screens/MinimalLoadingLabel__flood-escape-2.lua) — Smallest possible custom loading screen: a full-screen TextLabel created in code, default screen removed, destroyed once game.Loaded fires.
- [Companion follower](../../Scripts/12-NPC-AI/BuddyFollower__flood-escape-2.lua) — Buddy NPC that MoveTo's just behind its owner when further than 3.4 studs, teleports behind them past 21.5 studs, jumps when the owner jumps (remote) and cleans itself up when the owner dies or leaves.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/SV_MAIN_GameScript.server.lua`
- `scripts/Workspace/HD Admin/Core/MainModule.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
