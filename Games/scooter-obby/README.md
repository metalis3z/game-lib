# Scooter Obby

> 🧗 **Obby** · obby (scooter) · source file `ScooterObby%20(1).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/16_GameGUI__ShopFrame.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 15 ScreenGuis, 1696 GUI objects → **32 screenshots** |
| Models (.rbxm) | 297 models, 47 model sets, 0 VFX sets |
| Lua builders (.lua) | 30 UI screens, 0 animation packs, 2 audio packs |
| Code | 834 scripts, 25,343 lines |
| Asset ids | 1 animations, 126 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×292, `SourceSansPro Regular`×134, `GothamSSm Bold`×22, `LegacyArial Regular`×5, `GothamSSm Heavy`×4

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_GameGUI__ShopFrame.jpg"><img src="screenshots/thumbs/16_GameGUI__ShopFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.ShopFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_GameGUI__GigaBundleFrame.jpg"><img src="screenshots/thumbs/18_GameGUI__GigaBundleFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.GigaBundleFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_GameGUI__ShopFrame.jpg"><img src="screenshots/thumbs/33_GameGUI__ShopFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.ShopFrame</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_GameGUI__InventoryFrame.jpg"><img src="screenshots/thumbs/17_GameGUI__InventoryFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.InventoryFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_GameGUI__InventoryFrame.jpg"><img src="screenshots/thumbs/34_GameGUI__InventoryFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.InventoryFrame</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_DailyReward.jpg"><img src="screenshots/thumbs/01_DailyReward.jpg" width="100%"></a><br><sub><b>DailyReward</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_GameGUI__PlayTimeRewards.jpg"><img src="screenshots/thumbs/20_GameGUI__PlayTimeRewards.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.PlayTimeRewards</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_GameGUI__WheelSpin.jpg"><img src="screenshots/thumbs/21_GameGUI__WheelSpin.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.WheelSpin</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_GameGUI__RebirthConfirmation.jpg"><img src="screenshots/thumbs/30_GameGUI__RebirthConfirmation.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.RebirthConfirmation</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_GameGUI__SettingsGUI.jpg"><img src="screenshots/thumbs/13_GameGUI__SettingsGUI.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.SettingsGUI</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_GameGUI__SettingsFrame.jpg"><img src="screenshots/thumbs/14_GameGUI__SettingsFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.SettingsFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/29_GameGUI__SettingsGUI.jpg"><img src="screenshots/thumbs/29_GameGUI__SettingsGUI.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.SettingsGUI</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_GameGUI__SettingsFrame.jpg"><img src="screenshots/thumbs/31_GameGUI__SettingsFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.SettingsFrame</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_Confirmation.jpg"><img src="screenshots/thumbs/02_Confirmation.jpg" width="100%"></a><br><sub><b>Confirmation</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_Confirmation.jpg"><img src="screenshots/thumbs/24_Confirmation.jpg" width="100%"></a><br><sub><b>Confirmation</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Confirmation__Loading.jpg"><img src="screenshots/thumbs/03_Confirmation__Loading.jpg" width="100%"></a><br><sub><b>Confirmation</b> › BoxConfirmation.Main.Inside.Content.Loading</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_LoadingScreen__Frame.jpg"><img src="screenshots/thumbs/10_LoadingScreen__Frame.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Confirmation__Loading.jpg"><img src="screenshots/thumbs/25_Confirmation__Loading.jpg" width="100%"></a><br><sub><b>Confirmation</b> › BoxConfirmation.Main.Inside.Content.Loading</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Countdown.jpg"><img src="screenshots/thumbs/04_Countdown.jpg" width="100%"></a><br><sub><b>Countdown</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_Progession.jpg"><img src="screenshots/thumbs/05_Progession.jpg" width="100%"></a><br><sub><b>Progession</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_Version_.jpg"><img src="screenshots/thumbs/06_Version_.jpg" width="100%"></a><br><sub><b>Version </b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_Version___Frame.jpg"><img src="screenshots/thumbs/07_Version___Frame.jpg" width="100%"></a><br><sub><b>Version </b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_NewUGC.jpg"><img src="screenshots/thumbs/08_NewUGC.jpg" width="100%"></a><br><sub><b>NewUGC</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_NewScooter.jpg"><img src="screenshots/thumbs/09_NewScooter.jpg" width="100%"></a><br><sub><b>NewScooter</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/11_GameGUI.jpg"><img src="screenshots/thumbs/11_GameGUI.jpg" width="100%"></a><br><sub><b>GameGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_GameGUI__ResetGUI.jpg"><img src="screenshots/thumbs/12_GameGUI__ResetGUI.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.ResetGUI</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_GameGUI__SkipStageFrame.jpg"><img src="screenshots/thumbs/15_GameGUI__SkipStageFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.SkipStageFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_GameGUI__UGCFrame.jpg"><img src="screenshots/thumbs/19_GameGUI__UGCFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.UGCFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_GameGUI.jpg"><img src="screenshots/thumbs/27_GameGUI.jpg" width="100%"></a><br><sub><b>GameGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_GameGUI__ResetGUI.jpg"><img src="screenshots/thumbs/28_GameGUI__ResetGUI.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.ResetGUI</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_GameGUI__SkipStageFrame.jpg"><img src="screenshots/thumbs/32_GameGUI__SkipStageFrame.jpg" width="100%"></a><br><sub><b>GameGUI</b> › Frame.SkipStageFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_Exclusive.jpg"><img src="screenshots/thumbs/37_Exclusive.jpg" width="100%"></a><br><sub><b>Exclusive</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resource/SkinnedScooters/ZxchDevSkin.rbxm"><img src="screenshots/thumbs/models/01_ZxchDevSkin.jpg" width="100%"></a><br><sub><b>ZxchDevSkin</b><br><code>models/ReplicatedStorage/Resource/SkinnedScooters/ZxchDevSkin.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resource/SkinnedScooters/GrassGreenScooter.rbxm"><img src="screenshots/thumbs/models/02_GrassGreenScooter.jpg" width="100%"></a><br><sub><b>GrassGreenScooter</b><br><code>models/ReplicatedStorage/Resource/SkinnedScooters/GrassGreenScooter.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resource/SkinnedScooters/ForestScooter.rbxm"><img src="screenshots/thumbs/models/03_ForestScooter.jpg" width="100%"></a><br><sub><b>ForestScooter</b><br><code>models/ReplicatedStorage/Resource/SkinnedScooters/ForestScooter.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/StagesInRotation/Chunk21/Build.rbxm"><img src="screenshots/thumbs/models/04_Build.jpg" width="100%"></a><br><sub><b>Build</b><br><code>models/ServerStorage/StagesInRotation/Chunk21/Build.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/BoxParts/BoxAnim.rbxm"><img src="screenshots/thumbs/models/05_BoxAnim.jpg" width="100%"></a><br><sub><b>BoxAnim</b><br><code>models/ReplicatedStorage/BoxParts/BoxAnim.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Main%20Portal%20Template.rbxm"><img src="screenshots/thumbs/models/06_Main_Portal_Template.jpg" width="100%"></a><br><sub><b>Main Portal Template</b><br><code>models/Workspace/Lobby/Main Portal Template.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/TopRunLeaderboard.rbxm"><img src="screenshots/thumbs/models/07_TopRunLeaderboard.jpg" width="100%"></a><br><sub><b>TopRunLeaderboard</b><br><code>models/Workspace/Lobby/TopRunLeaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Resource/SkinnedScooters/ShockwaveScooter.rbxm"><img src="screenshots/thumbs/models/09_ShockwaveScooter.jpg" width="100%"></a><br><sub><b>ShockwaveScooter</b><br><code>models/ReplicatedStorage/Resource/SkinnedScooters/ShockwaveScooter.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/VerifiedRunLeaderboard.rbxm"><img src="screenshots/thumbs/models/11_VerifiedRunLeaderboard.jpg" width="100%"></a><br><sub><b>VerifiedRunLeaderboard</b><br><code>models/Workspace/Lobby/VerifiedRunLeaderboard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Skibidi%20Toilet%20Scooter.rbxm"><img src="screenshots/thumbs/models/13_Skibidi_Toilet_Scooter.jpg" width="100%"></a><br><sub><b>Skibidi Toilet Scooter</b><br><code>models/ServerStorage/Skibidi Toilet Scooter.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/TopWinsLeaderboard.rbxm"><img src="screenshots/thumbs/models/14_TopWinsLeaderboard.jpg" width="100%"></a><br><sub><b>TopWinsLeaderboard</b><br><code>models/Workspace/Lobby/TopWinsLeaderboard.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Tweens`](source/scripts/ServerStorage/Exclusive/Inside/Buy/Tweens.server.lua) <sub>34 lines</sub><br>[`Tweens`](source/scripts/StarterGui/GameGUI/Frame/Menu/Inventory/Back/Button/Tweens.server.lua) <sub>34 lines</sub><br>[`Tweens`](source/scripts/StarterGui/GameGUI/Frame/ShopFrame/Main/Inside/Content/LeftSide/Inside/Currency/Tweens.server.lua) <sub>40 lines</sub><br>[`Tweens`](source/scripts/StarterGui/GameGUI/Frame/ShopFrame/Main/Inside/Content/LeftSide/Inside/Gamepasses/Tweens.server.lua) <sub>40 lines</sub><br>[`Tweens`](source/scripts/StarterGui/GameGUI/GigaBundle/Back/Button/Tweens.server.lua) <sub>34 lines</sub> |
| UI controllers / window managers / menus | [`Handler`](source/scripts/ServerStorage/OldUi/GameGUI/Frame/Stat/Handler.client.lua) <sub>43 lines</sub><br>[`OpenScript`](source/scripts/StarterGui/GameGUI/Frame/Menu/Spin/Back/Button/OpenScript.server.lua) <sub>24 lines</sub> |
| Notifications, toasts, popups, prompts | [`CashNotificationHandler`](source/scripts/ServerStorage/OldUi/GameGUI/Frame/CashNotificationHandler.client.lua) <sub>69 lines</sub><br>[`Popups`](source/scripts/StarterPlayer/StarterCharacterScripts/Popups.client.lua) <sub>75 lines</sub><br>[`Wheel`](source/scripts/StarterGui/GameGUI/Frame/WheelSpin/Container/Wheel.client.lua) <sub>96 lines</sub><br>[`CurrencyPurchases`](source/scripts/ServerScriptService/CurrencyPurchases.server.lua) <sub>185 lines</sub><br>[`MapGeneration`](source/scripts/ServerScriptService/CoreScripts/MapGeneration.server.lua) <sub>136 lines</sub> |
| VFX, particles, beams, hit effects | [`Scooter`](source/scripts/ReplicatedStorage/Module/Scooter.lua) <sub>556 lines</sub><br>[`CheckpointHandler`](source/scripts/ReplicatedStorage/CollectionServiceScripts/CheckpointHandler.server.lua) <sub>221 lines</sub><br>[`CheckpointHandler`](source/scripts/ReplicatedStorage/Old/CheckpointHandler.server.lua) <sub>88 lines</sub><br>[`ConfettiBlockTracing`](source/scripts/ReplicatedStorage/SpecialFX/ConfettiBlockTracing.server.lua) <sub>21 lines</sub> |
| DataStore / player data | [`DataStore2`](source/scripts/ReplicatedStorage/ModuleScripts/DataStore2.lua) <sub>614 lines</sub><br>[`HighestStageSave`](source/scripts/ServerScriptService/HighestStageSave.server.lua) <sub>31 lines</sub><br>[`HighestStageSave`](source/scripts/ServerScriptService/Old/HighestStageSave.server.lua) <sub>30 lines</sub><br>[`StageSave`](source/scripts/ServerScriptService/Old/StageSave.server.lua) <sub>32 lines</sub><br>[`DataHandler`](source/scripts/ServerScriptService/DataHandler.server.lua) <sub>24 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`CurrencyPurchases`](source/scripts/ServerScriptService/CurrencyPurchases.server.lua) <sub>185 lines</sub><br>[`ProductHandler`](source/scripts/ServerScriptService/Skips/ProductHandler.server.lua) <sub>78 lines</sub><br>[`GamepassHandler (Coils)`](source/scripts/ServerScriptService/GamepassHandler%20%28Coils%29.server.lua) <sub>24 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`SpinScript`](source/scripts/ServerScriptService/SpinScript.server.lua) <sub>152 lines</sub><br>[`InventoryHandler`](source/scripts/ServerScriptService/InventoryHandler.lua) <sub>346 lines</sub><br>[`InventoryHandler`](source/scripts/ServerScriptService/Old/InventoryHandler.lua) <sub>203 lines</sub><br>[`CrateSystem`](source/scripts/ServerStorage/OldUi/GameGUI/Frame/ShopFrame/Main/Inside/Content/RightSide/Inside/CrateFrame/BuyCoins/Back/Button/CrateSystem.server.lua) <sub>149 lines</sub><br>[`CrateSystem`](source/scripts/StarterGui/GameGUI/Frame/ShopFrame/Main/Inside/Content/RightSide/Inside/CrateFrame/ClassicBox1/BuyCoins/Back/Button/CrateSystem.server.lua) <sub>266 lines</sub> |
| Daily rewards, quests, codes, playtime | [`ClaimReward`](source/scripts/ServerScriptService/ClaimReward.server.lua) <sub>224 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/GameGUI/Frame/PlayTimeRewards/Main/Inside/Content/Inside/Reward1/Inside/Claim/Back/Button/LocalScript.client.lua) <sub>59 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/GameGUI/Frame/PlayTimeRewards/Main/Inside/Content/Inside/Reward10/Inside/Claim/Back/Button/LocalScript.client.lua) <sub>59 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/GameGUI/Frame/PlayTimeRewards/Main/Inside/Content/Inside/Reward11/Inside/Claim/Back/Button/LocalScript.client.lua) <sub>59 lines</sub><br>[`LocalScript`](source/scripts/StarterGui/GameGUI/Frame/PlayTimeRewards/Main/Inside/Content/Inside/Reward12/Inside/Claim/Back/Button/LocalScript.client.lua) <sub>59 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Promise`](source/scripts/ReplicatedStorage/ModuleScripts/DataStore2/Promise.lua) <sub>1391 lines</sub><br>[`TableUtil`](source/scripts/ReplicatedStorage/ModuleScripts/DataStore2/TableUtil.lua) <sub>18 lines</sub> |

### In the curated script library

- [Floating cash and error text](../../Scripts/03-Notifications/CashAndErrorText__scooter-obby.lua) — Floating "+N coins!" / "+N skips!" text with random drift and rotation, plus red error text from client (BindableEvent) or server (RemoteEvent).

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
