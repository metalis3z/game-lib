# BIG Paintball! Classic

> 🔫 **Shooter** · arena FPS · source file `BIG Paintball! Classic 🔫-1.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/24_Menu__Streaks.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 32 ScreenGuis, 506 GUI objects → **28 screenshots** |
| Models (.rbxm) | 260 models, 10 model sets, 36 VFX sets |
| Lua builders (.lua) | 120 UI screens, 4 animation packs, 1 audio packs |
| Code | 502 scripts, 68,941 lines |
| Asset ids | 1 animations, 4 sounds |
| Safety scan | 1 HIGH / 8 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm Heavy`×106, `GothamSSm Bold`×39, `GothamSSm Medium`×12, `GothamSSm Regular`×7, `SourceSansPro Regular`×5

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_BuyCredits.jpg"><img src="screenshots/thumbs/15_BuyCredits.jpg" width="100%"></a><br><sub><b>BuyCredits</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_OldItem.jpg"><img src="screenshots/thumbs/03_OldItem.jpg" width="100%"></a><br><sub><b>OldItem</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_Item.jpg"><img src="screenshots/thumbs/04_Item.jpg" width="100%"></a><br><sub><b>Item</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_DailyReward.jpg"><img src="screenshots/thumbs/22_DailyReward.jpg" width="100%"></a><br><sub><b>DailyReward</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_Menu__Streaks.jpg"><img src="screenshots/thumbs/24_Menu__Streaks.jpg" width="100%"></a><br><sub><b>Menu</b> › Frame.Streaks</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_LeveledUp.jpg"><img src="screenshots/thumbs/18_LeveledUp.jpg" width="100%"></a><br><sub><b>LeveledUp</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_KOTHProgress.jpg"><img src="screenshots/thumbs/20_KOTHProgress.jpg" width="100%"></a><br><sub><b>KOTHProgress</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Menu.jpg"><img src="screenshots/thumbs/23_Menu.jpg" width="100%"></a><br><sub><b>Menu</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Menu__Crates.jpg"><img src="screenshots/thumbs/25_Menu__Crates.jpg" width="100%"></a><br><sub><b>Menu</b> › Frame.Crates</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_Message.jpg"><img src="screenshots/thumbs/06_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_IntroGui.jpg"><img src="screenshots/thumbs/01_IntroGui.jpg" width="100%"></a><br><sub><b>IntroGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_IntroGui__Notice.jpg"><img src="screenshots/thumbs/02_IntroGui__Notice.jpg" width="100%"></a><br><sub><b>IntroGui</b> › Frame.Notice</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_Leaderboard.jpg"><img src="screenshots/thumbs/07_Leaderboard.jpg" width="100%"></a><br><sub><b>Leaderboard</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_Top.jpg"><img src="screenshots/thumbs/10_Top.jpg" width="100%"></a><br><sub><b>Top</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_MatchResults.jpg"><img src="screenshots/thumbs/17_MatchResults.jpg" width="100%"></a><br><sub><b>MatchResults</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_Admin_Commands.jpg"><img src="screenshots/thumbs/08_Admin_Commands.jpg" width="100%"></a><br><sub><b>Admin Commands</b></sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_MapVote.jpg"><img src="screenshots/thumbs/11_MapVote.jpg" width="100%"></a><br><sub><b>MapVote</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_Pack.jpg"><img src="screenshots/thumbs/05_Pack.jpg" width="100%"></a><br><sub><b>Pack</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_Side.jpg"><img src="screenshots/thumbs/09_Side.jpg" width="100%"></a><br><sub><b>Side</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Processing.jpg"><img src="screenshots/thumbs/12_Processing.jpg" width="100%"></a><br><sub><b>Processing</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_Mobile.jpg"><img src="screenshots/thumbs/13_Mobile.jpg" width="100%"></a><br><sub><b>Mobile</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_SpawnGlow.jpg"><img src="screenshots/thumbs/14_SpawnGlow.jpg" width="100%"></a><br><sub><b>SpawnGlow</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_Killcam.jpg"><img src="screenshots/thumbs/16_Killcam.jpg" width="100%"></a><br><sub><b>Killcam</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_Scope.jpg"><img src="screenshots/thumbs/19_Scope.jpg" width="100%"></a><br><sub><b>Scope</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_CrateOpening.jpg"><img src="screenshots/thumbs/21_CrateOpening.jpg" width="100%"></a><br><sub><b>CrateOpening</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_CustomCrosshairs.jpg"><img src="screenshots/thumbs/26_CustomCrosshairs.jpg" width="100%"></a><br><sub><b>CustomCrosshairs</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Moderator_Util.jpg"><img src="screenshots/thumbs/27_Moderator_Util.jpg" width="100%"></a><br><sub><b>Moderator Util</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_Moderator_Util__Frame.jpg"><img src="screenshots/thumbs/28_Moderator_Util__Frame.jpg" width="100%"></a><br><sub><b>Moderator Util</b> › Frame</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Guns/82.rbxm"><img src="screenshots/thumbs/models/01_82.jpg" width="100%"></a><br><sub><b>82</b><br><code>models/ReplicatedStorage/Assets/Guns/82.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Kohl%27s%20Admin.rbxm"><img src="screenshots/thumbs/models/02_Kohl_s_Admin.jpg" width="100%"></a><br><sub><b>Kohl's Admin</b><br><code>models/ReplicatedStorage/Kohl's Admin.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/UnicornRainbow.rbxm"><img src="screenshots/thumbs/models/03_UnicornRainbow.jpg" width="100%"></a><br><sub><b>UnicornRainbow</b><br><code>models/ReplicatedStorage/Assets/UnicornRainbow.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/QuartzCrystals.rbxm"><img src="screenshots/thumbs/models/04_QuartzCrystals.jpg" width="100%"></a><br><sub><b>QuartzCrystals</b><br><code>models/ReplicatedStorage/Assets/QuartzCrystals.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/DarkMatterSentry.rbxm"><img src="screenshots/thumbs/models/05_DarkMatterSentry.jpg" width="100%"></a><br><sub><b>DarkMatterSentry</b><br><code>models/ReplicatedStorage/Assets/DarkMatterSentry.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Drone.rbxm"><img src="screenshots/thumbs/models/07_Drone.jpg" width="100%"></a><br><sub><b>Drone</b><br><code>models/ReplicatedStorage/Assets/Drone.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/ArmoredSentry.rbxm"><img src="screenshots/thumbs/models/08_ArmoredSentry.jpg" width="100%"></a><br><sub><b>ArmoredSentry</b><br><code>models/ReplicatedStorage/Assets/ArmoredSentry.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Sentry.rbxm"><img src="screenshots/thumbs/models/09_Sentry.jpg" width="100%"></a><br><sub><b>Sentry</b><br><code>models/ReplicatedStorage/Assets/Sentry.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/CarePackage.rbxm"><img src="screenshots/thumbs/models/10_CarePackage.jpg" width="100%"></a><br><sub><b>CarePackage</b><br><code>models/ReplicatedStorage/Assets/CarePackage.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/MiniSentry.rbxm"><img src="screenshots/thumbs/models/11_MiniSentry.jpg" width="100%"></a><br><sub><b>MiniSentry</b><br><code>models/ReplicatedStorage/Assets/MiniSentry.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/SentryPlacement.rbxm"><img src="screenshots/thumbs/models/12_SentryPlacement.jpg" width="100%"></a><br><sub><b>SentryPlacement</b><br><code>models/ReplicatedStorage/Assets/SentryPlacement.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Guns/62~2.rbxm"><img src="screenshots/thumbs/models/14_62_2.jpg" width="100%"></a><br><sub><b>62~2</b><br><code>models/ReplicatedStorage/Assets/Guns/62~2.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Intro`](source/scripts/ReplicatedFirst/Intro/Intro.client.lua) <sub>501 lines</sub><br>[`4 _ Interact`](source/scripts/ReplicatedStorage/Framework/Modules/Client/4%20_%20Interact.lua) <sub>350 lines</sub><br>[`Leveling`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Leveling.client.lua) <sub>133 lines</sub><br>[`Menu`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu.client.lua) <sub>3525 lines</sub><br>[`5 _ InfoOverlay`](source/scripts/ReplicatedStorage/Framework/Modules/Client/5%20_%20InfoOverlay.lua) <sub>251 lines</sub> |
| UI controllers / window managers / menus | [`2 _ GUI`](source/scripts/ReplicatedStorage/Framework/Modules/Client/2%20_%20GUI.lua) <sub>166 lines</sub><br>[`MenuPromotional`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/MenuPromotional.client.lua) <sub>177 lines</sub><br>[`Menu`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu.client.lua) <sub>3525 lines</sub><br>[`Main`](source/scripts/ServerStorage/Moderator%20Util/Main.client.lua) <sub>420 lines</sub><br>[`KOTH Interface`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/KOTH%20Interface.client.lua) <sub>91 lines</sub> |
| Notifications, toasts, popups, prompts | [`5 _ Message`](source/scripts/ReplicatedStorage/Framework/Modules/Client/5%20_%20Message.lua) <sub>244 lines</sub><br>[`Main`](source/scripts/ServerStorage/Moderator%20Util/Main.client.lua) <sub>420 lines</sub><br>[`Library`](source/scripts/ReplicatedStorage/Framework/Library.lua) <sub>254 lines</sub><br>[`Crate Opening`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Crate%20Opening.client.lua) <sub>166 lines</sub><br>[`MenuPromotional`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/MenuPromotional.client.lua) <sub>177 lines</sub> |
| Loading / intro screens | [`Intro`](source/scripts/ReplicatedFirst/Intro/Intro.client.lua) <sub>501 lines</sub><br>[`Library`](source/scripts/ReplicatedStorage/Framework/Library.lua) <sub>254 lines</sub> |
| Camera, cutscenes, screen shake | [`5 _ Shake`](source/scripts/ReplicatedStorage/Framework/Modules/Client/5%20_%20Shake.lua) <sub>166 lines</sub><br>[`Killcam`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Killcam.client.lua) <sub>219 lines</sub><br>[`Menu`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu.client.lua) <sub>3525 lines</sub><br>[`First Person Controller`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/Game/First%20Person%20Controller.client.lua) <sub>1212 lines</sub> |
| VFX, particles, beams, hit effects | [`6 _ Projectiles`](source/scripts/ReplicatedStorage/Framework/Modules/Client/6%20_%20Projectiles.lua) <sub>550 lines</sub><br>[`guns _ Anime Rifle`](source/scripts/ReplicatedStorage/Framework/Modules/1%20_%20Directory/Guns/guns%20_%20Anime%20Rifle.lua) <sub>119 lines</sub><br>[`guns _ Anime Sniper`](source/scripts/ReplicatedStorage/Framework/Modules/1%20_%20Directory/Guns/guns%20_%20Anime%20Sniper.lua) <sub>119 lines</sub><br>[`guns _ Inferno Rifle`](source/scripts/ReplicatedStorage/Framework/Modules/1%20_%20Directory/Guns/guns%20_%20Inferno%20Rifle.lua) <sub>125 lines</sub><br>[`guns _ Shattered Dual Pistols`](source/scripts/ReplicatedStorage/Framework/Modules/1%20_%20Directory/Guns/guns%20_%20Shattered%20Dual%20Pistols.lua) <sub>79 lines</sub> |
| DataStore / player data | [`MockDataStoreManager`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockDataStoreManager.lua) <sub>426 lines</sub><br>[`MockGlobalDataStore`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockGlobalDataStore.lua) <sub>449 lines</sub><br>[`MockOrderedDataStore`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockOrderedDataStore.lua) <sub>530 lines</sub><br>[`2 _ Datastore`](source/scripts/ReplicatedStorage/Framework/Modules/Server/2%20_%20Datastore.lua) <sub>245 lines</sub><br>[`MockDataStorePages`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockDataStorePages.lua) <sub>57 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`3 _ Gamepasses`](source/scripts/ReplicatedStorage/Framework/Modules/Server/3%20_%20Gamepasses.lua) <sub>259 lines</sub><br>[`3 _ Products`](source/scripts/ReplicatedStorage/Framework/Modules/Server/3%20_%20Products.lua) <sub>148 lines</sub><br>[`PromptPurchase`](source/scripts/ReplicatedStorage/Framework/Modules/2%20_%20Functions/PromptPurchase.lua) <sub>20 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Crate Opening`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Crate%20Opening.client.lua) <sub>166 lines</sub><br>[`6 _ Crates`](source/scripts/ReplicatedStorage/Framework/Modules/6%20_%20Crates.lua) <sub>107 lines</sub><br>[`Crates`](source/scripts/ReplicatedStorage/Framework/Modules/1%20_%20Directory/Crates/Crates.lua) <sub>25 lines</sub><br>[`Menu`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu.client.lua) <sub>3525 lines</sub><br>[`First Person Controller`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/Game/First%20Person%20Controller.client.lua) <sub>1212 lines</sub> |
| NPC / AI / monsters | [`Library`](source/scripts/ReplicatedStorage/Framework/Library.lua) <sub>254 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Movement`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/Game/Movement.client.lua) <sub>198 lines</sub><br>[`First Person Controller`](source/scripts/StarterPlayer/StarterPlayerScripts/Scripts/Game/First%20Person%20Controller.client.lua) <sub>1212 lines</sub> |
| Tycoon / plots / bases / building | [`FirebaseService`](source/scripts/ServerScriptService/FirebaseDS/FirebaseService.lua) <sub>250 lines</sub><br>[`OwnerTitleV5Script`](source/scripts/ServerScriptService/OwnerTitleV5Script.server.lua) <sub>116 lines</sub> |
| Leaderboards & stats | [`MockOrderedDataStore`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockOrderedDataStore.lua) <sub>530 lines</sub> |
| Admin panels & commands | [`TempCommands`](source/scripts/ServerScriptService/TempCommands.server.lua) <sub>94 lines</sub> |
| Sound & music | [`3 _ Audio`](source/scripts/ReplicatedStorage/Framework/Modules/3%20_%20Audio.lua) <sub>406 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`MockDataStoreUtils`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockDataStoreUtils.lua) <sub>282 lines</sub><br>[`MockGlobalDataStore`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockGlobalDataStore.lua) <sub>449 lines</sub><br>[`MockDataStoreService`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService.lua) <sub>177 lines</sub><br>[`2 _ Signal`](source/scripts/ReplicatedStorage/Framework/Modules/2%20_%20Signal.lua) <sub>210 lines</sub><br>[`MockDataStoreManager`](source/scripts/ReplicatedStorage/DataStoreService/MockDataStoreService/MockDataStoreManager.lua) <sub>426 lines</sub> |

### In the curated script library

- [Shake via Humanoid.CameraOffset](../../Scripts/05-Camera-Cutscene/HumanoidOffsetShake__big-paintball.lua) — Shake without touching Camera.CFrame (uses Humanoid.CameraOffset) + controller vibration.
- [BIG Games DataStore wrapper](../../Scripts/07-Data-Saving/DatastoreWrapper__big-paintball.lua) — BIG Games framework wrapper: Get/Set/Update with retries, refuses nil writes, caches DataStore objects by name/scope.
- [Save loop with PlayingSession flag](../../Scripts/07-Data-Saving/Saving-PlayingSessionFlag__big-paintball.lua) — BIG Games saving: a PlayingSession flag in the save acts as a simple session lock (retry until the old server cleared it), new-stat backfill, staggered save loop, change-diff replication.
- [Intro with preload cap, ban check and Skip](../../Scripts/04-Loading-Screens/IntroPreloadAndSkip__big-paintball.lua) — Well-commented intro: removes default screen, hides core UI, preloads logo + intro sound with a 2 s cap, logo pop-in tween, loading dots, save confirmation, ban/warning notice, skip support, then restores game GUIs.
- [BIG Games ProcessReceipt](../../Scripts/08-Monetization/Products-ProcessReceipt__big-paintball.lua) — BIG Games framework receipt: looks the product up in a directory with a Callback, retries finding the player for a few seconds, pcall's the callback, fires analytics/client events, logs failures loudly.
- [Yielding message / yes-no dialog](../../Scripts/03-Notifications/MessageDialog__big-paintball.lua) — BIG Games framework dialog: one call shows an OK message, a Yes/No question, or a 2-option choice and yields until the player answers (with gamepad support).
- [All-in-one Audio module (SFX + crossfade music)](../../Scripts/17-Sound-Music/Audio__big-paintball.lua) — One module for all audio: Play() one-shot SFX on a part or at a world position (random pick from an ID list), PlayMusic() with automatic crossfade, StopMusic(), a mute toggle that caches volumes, and a garbage collector that cleans finished sounds. Server calls are forwarded to all clients.
- [GUI indexer + mouse unlock](../../Scripts/02-UI-Framework/GuiIndexer__big-paintball.lua) — Indexes every ScreenGui child by name and provides a Modal button to free the mouse in first person.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Kohl's Admin/Legacy_Loader.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
