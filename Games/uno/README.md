# UNO

> 🎉 **Party** · card game · source file `UNO Game Working.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/15_GameUI__SpecTemp.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 3 ScreenGuis, 3786 GUI objects → **22 screenshots** |
| Models (.rbxm) | 339 models, 6 model sets, 1 VFX sets |
| Lua builders (.lua) | 10 UI screens, 20 animation packs, 1 audio packs |
| Code | 28 scripts, 22,503 lines |
| Asset ids | 3 animations, 49 sounds |
| Safety scan | 0 HIGH / 0 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Bold`×469, `SourceSansPro SemiBold`×347, `SourceSansPro Regular`×273, `GothamSSm Medium`×18, `DenkOne Regular`×2

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_GameUI__RequestListTemp.jpg"><img src="screenshots/thumbs/17_GameUI__RequestListTemp.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.RequestListTemp</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_GameUI__RequestTemp.jpg"><img src="screenshots/thumbs/21_GameUI__RequestTemp.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.TradeRequests.RequestTemp</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_RealGame__RequestTemp.jpg"><img src="screenshots/thumbs/22_RealGame__RequestTemp.jpg" width="100%"></a><br><sub><b>RealGame</b> › TradeRequests.RequestTemp</sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_GameUI__TradeListTemp.jpg"><img src="screenshots/thumbs/18_GameUI__TradeListTemp.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.TradeListTemp</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_GameUI__TradingT.jpg"><img src="screenshots/thumbs/19_GameUI__TradingT.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.TradingT</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_GameUI__SettingsConstant.jpg"><img src="screenshots/thumbs/13_GameUI__SettingsConstant.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.SettingsConstant</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_GameUI__SettingsVariable.jpg"><img src="screenshots/thumbs/14_GameUI__SettingsVariable.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.SettingsVariable</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_GameUI__NotifTemplate.jpg"><img src="screenshots/thumbs/05_GameUI__NotifTemplate.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.NotifTemplate</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_GameUI__LoserTemplate.jpg"><img src="screenshots/thumbs/06_GameUI__LoserTemplate.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.LoserTemplate</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_GameUI.jpg"><img src="screenshots/thumbs/01_GameUI.jpg" width="100%"></a><br><sub><b>GameUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_GameUI__JoinB.jpg"><img src="screenshots/thumbs/02_GameUI__JoinB.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.ListTemp.JoinB</sub></td>
<td width="33%" valign="top"><a href="screenshots/03_GameUI__PlrBoxes.jpg"><img src="screenshots/thumbs/03_GameUI__PlrBoxes.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.ListTemp.PlrBoxes</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_GameUI__PlrTemplate.jpg"><img src="screenshots/thumbs/04_GameUI__PlrTemplate.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.PlrTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_GameUI__ColB.jpg"><img src="screenshots/thumbs/07_GameUI__ColB.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.ColB</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_GameUI__SwapTemp.jpg"><img src="screenshots/thumbs/08_GameUI__SwapTemp.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.SwapTemp</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_GameUI__NumTemp.jpg"><img src="screenshots/thumbs/09_GameUI__NumTemp.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.NumTemp</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_GameUI__InvB.jpg"><img src="screenshots/thumbs/10_GameUI__InvB.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.InvB</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_GameUI__DeckB.jpg"><img src="screenshots/thumbs/11_GameUI__DeckB.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.DeckB</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_GameUI__CardEdit.jpg"><img src="screenshots/thumbs/12_GameUI__CardEdit.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.CardEdit</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_GameUI__SpecTemp.jpg"><img src="screenshots/thumbs/15_GameUI__SpecTemp.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.SpecTemp</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_GameUI__PlrListHolder.jpg"><img src="screenshots/thumbs/16_GameUI__PlrListHolder.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.GuiTemplates.PlrListHolder</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_GameUI__CardInfo.jpg"><img src="screenshots/thumbs/20_GameUI__CardInfo.jpg" width="100%"></a><br><sub><b>GameUI</b> › Everything.CardInfo</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Cosmetics/Decorations/Candy.rbxm"><img src="screenshots/thumbs/models/01_Candy.jpg" width="100%"></a><br><sub><b>Candy</b><br><code>models/ReplicatedStorage/Cosmetics/Decorations/Candy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/CaseRigs/Decor%20Crate%20%231.rbxm"><img src="screenshots/thumbs/models/02_Decor_Crate_1.jpg" width="100%"></a><br><sub><b>Decor Crate #1</b><br><code>models/ReplicatedStorage/CaseRigs/Decor Crate #1.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Cosmetics/Decorations/Water%20Gun.rbxm"><img src="screenshots/thumbs/models/03_Water_Gun.jpg" width="100%"></a><br><sub><b>Water Gun</b><br><code>models/ReplicatedStorage/Cosmetics/Decorations/Water Gun.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Cosmetics/Decorations/Train.rbxm"><img src="screenshots/thumbs/models/04_Train.jpg" width="100%"></a><br><sub><b>Train</b><br><code>models/ReplicatedStorage/Cosmetics/Decorations/Train.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/ItemShowcase.rbxm"><img src="screenshots/thumbs/models/05_ItemShowcase.jpg" width="100%"></a><br><sub><b>ItemShowcase</b><br><code>models/Workspace/ItemShowcase.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/MiscAssets/JoinBoards/JoinBoard__x6.rbxm"><img src="screenshots/thumbs/models/06_JoinBoard_x6.jpg" width="100%"></a><br><sub><b>JoinBoard__x6</b><br><code>models/ReplicatedStorage/MiscAssets/JoinBoards/JoinBoard__x6.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ViewportModels/Keys.rbxm"><img src="screenshots/thumbs/models/07_Keys.jpg" width="100%"></a><br><sub><b>Keys</b><br><code>models/ReplicatedStorage/ViewportModels/Keys.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ViewportModels/Plant.rbxm"><img src="screenshots/thumbs/models/08_Plant.jpg" width="100%"></a><br><sub><b>Plant</b><br><code>models/ReplicatedStorage/ViewportModels/Plant.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/ViewportModels/Waiting%20Room.rbxm"><img src="screenshots/thumbs/models/09_Waiting_Room.jpg" width="100%"></a><br><sub><b>Waiting Room</b><br><code>models/ReplicatedStorage/ViewportModels/Waiting Room.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/DecorReference.rbxm"><img src="screenshots/thumbs/models/10_DecorReference.jpg" width="100%"></a><br><sub><b>DecorReference</b><br><code>models/Workspace/DecorReference.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/CoinsRarityModels.rbxm"><img src="screenshots/thumbs/models/12_CoinsRarityModels.jpg" width="100%"></a><br><sub><b>CoinsRarityModels</b><br><code>models/Workspace/CoinsRarityModels.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Cosmetics/Decorations/Gold%20Gun.rbxm"><img src="screenshots/thumbs/models/13_Gold_Gun.jpg" width="100%"></a><br><sub><b>Gold Gun</b><br><code>models/ReplicatedStorage/Cosmetics/Decorations/Gold Gun.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/MiscAssets/JoinBoards/JoinBoard.rbxm"><img src="screenshots/thumbs/models/14_JoinBoard.jpg" width="100%"></a><br><sub><b>JoinBoard</b><br><code>models/ReplicatedStorage/MiscAssets/JoinBoards/JoinBoard.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub><br>[`ButtonManager`](source/scripts/StarterGui/GameUI/Everything/Client/ButtonManager.lua) <sub>360 lines</sub><br>[`BindableManager`](source/scripts/StarterGui/GameUI/Everything/Client/BindableManager.lua) <sub>5867 lines</sub><br>[`PlayerConManager`](source/scripts/StarterGui/GameUI/Everything/Client/PlayerConManager.lua) <sub>184 lines</sub> |
| UI controllers / window managers / menus | [`Server`](source/scripts/ServerScriptService/Server.server.lua) <sub>1368 lines</sub><br>[`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub><br>[`BindableManager`](source/scripts/StarterGui/GameUI/Everything/Client/BindableManager.lua) <sub>5867 lines</sub><br>[`LobbyManager`](source/scripts/StarterGui/GameUI/Everything/Client/LobbyManager.lua) <sub>230 lines</sub><br>[`GameHandler`](source/scripts/ServerScriptService/Server/GameHandler.lua) <sub>2884 lines</sub> |
| Notifications, toasts, popups, prompts | [`NotificationManager`](source/scripts/StarterGui/GameUI/Everything/Client/NotificationManager.lua) <sub>48 lines</sub><br>[`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub><br>[`BindableManager`](source/scripts/StarterGui/GameUI/Everything/Client/BindableManager.lua) <sub>5867 lines</sub><br>[`Server`](source/scripts/ServerScriptService/Server.server.lua) <sub>1368 lines</sub><br>[`LobbyManager`](source/scripts/StarterGui/GameUI/Everything/Client/LobbyManager.lua) <sub>230 lines</sub> |
| Camera, cutscenes, screen shake | [`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub> |
| DataStore / player data | [`DataHandler`](source/scripts/ServerScriptService/Server/DataHandler.lua) <sub>672 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Server`](source/scripts/ServerScriptService/Server.server.lua) <sub>1368 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`CrateIndex`](source/scripts/ReplicatedStorage/Modules/CrateIndex.lua) <sub>560 lines</sub><br>[`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub><br>[`InventoryHandler`](source/scripts/ServerScriptService/Server/InventoryHandler.lua) <sub>1098 lines</sub><br>[`CraftingHandler`](source/scripts/ServerScriptService/Server/CraftingHandler.lua) <sub>266 lines</sub><br>[`LevelHandler`](source/scripts/ServerScriptService/Server/LevelHandler.lua) <sub>197 lines</sub> |
| Trading systems | [`TradeHandler`](source/scripts/ServerScriptService/Server/TradeHandler.lua) <sub>492 lines</sub><br>[`TradeListManager`](source/scripts/StarterGui/GameUI/Everything/Client/TradeListManager.lua) <sub>100 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Server`](source/scripts/ServerScriptService/Server.server.lua) <sub>1368 lines</sub><br>[`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub><br>[`BindableManager`](source/scripts/StarterGui/GameUI/Everything/Client/BindableManager.lua) <sub>5867 lines</sub> |
| Tycoon / plots / bases / building | [`BindableManager`](source/scripts/StarterGui/GameUI/Everything/Client/BindableManager.lua) <sub>5867 lines</sub><br>[`Client`](source/scripts/StarterGui/GameUI/Everything/Client.client.lua) <sub>3544 lines</sub> |
| Leaderboards & stats | [`GlobalLeaderboard`](source/scripts/ServerScriptService/Server/GlobalLeaderboard.lua) <sub>146 lines</sub> |
| Daily rewards, quests, codes, playtime | [`CodeHandler`](source/scripts/ServerScriptService/Server/CodeHandler.lua) <sub>211 lines</sub><br>[`DailyReward`](source/scripts/ServerScriptService/Server/DailyReward.lua) <sub>94 lines</sub><br>[`DataHandler`](source/scripts/ServerScriptService/Server/DataHandler.lua) <sub>672 lines</sub><br>[`Server`](source/scripts/ServerScriptService/Server.server.lua) <sub>1368 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Util`](source/scripts/ServerScriptService/Server/Util.lua) <sub>310 lines</sub> |

### In the curated script library

- [Codes stored in a DataStore (add without updating)](../../Scripts/18-Daily-Rewards-Quests/CodeHandler-DataStoreCodes__uno.lua) — Codes kept in a DataStore list with expiry timestamps and reward types, loaded into the server on start and refreshable, so new codes can be added without shutting servers down.
- [Session store + trade save-lock](../../Scripts/07-Data-Saving/DataHandler-SessionStore__uno.lua) — Separate SessionStore with a heartbeat-style timestamp (90s timeout), plus a SaveLocked flag used to freeze saves during trades so items cannot be duplicated.
- [Basic ordered store board](../../Scripts/15-Leaderboards/GlobalLeaderboard-Basic__uno.lua) — The beginner version: GetSortedAsync top 50 into a SurfaceGui scroller with GetNameFromUserIdAsync, and SetAsync helpers with retry.
- [Sliding notification list](../../Scripts/03-Notifications/SlideNotificationList__uno.lua) — Good/Neutral/Bad notifications with colored side bar and sound; new ones slide in at the top and push older ones down, then slide out left. NOTE: the original has "if true then return end" at the top (disabled in game).
- [Instance-based trade handler](../../Scripts/10-Trading/InstanceTradeHandler__uno.lua) — Trade state as a cloned Folder of Value objects, confirm then accept, save lock while swapping.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
