# Punching Simulator

> ⛏️ **Simulator** · training simulator · source file `Punching Simulator Fully scripted.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/32_RainbowEggs__Main.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | template with full source |
| Screens | 32 ScreenGuis, 1649 GUI objects → **46 screenshots** |
| Models (.rbxm) | 409 models, 16 model sets, 1 VFX sets |
| Lua builders (.lua) | 65 UI screens, 2 animation packs, 2 audio packs |
| Code | 518 scripts, 61,874 lines |
| Asset ids | 4 animations, 33 sounds |
| Safety scan | 1 HIGH / 5 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `FredokaOne Regular`×385, `font asset 12187370000 Bold`×201, `GothamSSm Heavy`×11, `FredokaOne Bold`×4, `font asset 12187370000 Heavy`×2

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_Pet.jpg"><img src="screenshots/thumbs/37_Pet.jpg" width="100%"></a><br><sub><b>Pet</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/43_InviteReward.jpg"><img src="screenshots/thumbs/43_InviteReward.jpg" width="100%"></a><br><sub><b>InviteReward</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_Quest.jpg"><img src="screenshots/thumbs/39_Quest.jpg" width="100%"></a><br><sub><b>Quest</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_Quest.jpg"><img src="screenshots/thumbs/41_Quest.jpg" width="100%"></a><br><sub><b>Quest</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/42_Quest.jpg"><img src="screenshots/thumbs/42_Quest.jpg" width="100%"></a><br><sub><b>Quest</b></sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_Trade__You.jpg"><img src="screenshots/thumbs/17_Trade__You.jpg" width="100%"></a><br><sub><b>Trade</b> › Main.You</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_Trade__Other.jpg"><img src="screenshots/thumbs/19_Trade__Other.jpg" width="100%"></a><br><sub><b>Trade</b> › Main.Other</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_Trade__Top.jpg"><img src="screenshots/thumbs/18_Trade__Top.jpg" width="100%"></a><br><sub><b>Trade</b> › Main.Top</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Main.jpg"><img src="screenshots/thumbs/01_Main.jpg" width="100%"></a><br><sub><b>Main</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/02_Wheel__Main.jpg"><img src="screenshots/thumbs/02_Wheel__Main.jpg" width="100%"></a><br><sub><b>Wheel</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/03_Daily__Main.jpg"><img src="screenshots/thumbs/03_Daily__Main.jpg" width="100%"></a><br><sub><b>Daily</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Free__Main.jpg"><img src="screenshots/thumbs/04_Free__Main.jpg" width="100%"></a><br><sub><b>Free</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_Pets__Main.jpg"><img src="screenshots/thumbs/05_Pets__Main.jpg" width="100%"></a><br><sub><b>Pets</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_Rebirth__Main.jpg"><img src="screenshots/thumbs/06_Rebirth__Main.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_Reward__Main.jpg"><img src="screenshots/thumbs/07_Reward__Main.jpg" width="100%"></a><br><sub><b>Reward</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_Store__Main.jpg"><img src="screenshots/thumbs/08_Store__Main.jpg" width="100%"></a><br><sub><b>Store</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_FreeHugeEvent__Main.jpg"><img src="screenshots/thumbs/09_FreeHugeEvent__Main.jpg" width="100%"></a><br><sub><b>FreeHugeEvent</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_Auras__Main.jpg"><img src="screenshots/thumbs/10_Auras__Main.jpg" width="100%"></a><br><sub><b>Auras</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_Pulse__Main.jpg"><img src="screenshots/thumbs/11_Pulse__Main.jpg" width="100%"></a><br><sub><b>Pulse</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_PetPack__Main.jpg"><img src="screenshots/thumbs/12_PetPack__Main.jpg" width="100%"></a><br><sub><b>PetPack</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_Confirm__Main.jpg"><img src="screenshots/thumbs/13_Confirm__Main.jpg" width="100%"></a><br><sub><b>Confirm</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_Settings__Main.jpg"><img src="screenshots/thumbs/14_Settings__Main.jpg" width="100%"></a><br><sub><b>Settings</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_InviteRewards__Main.jpg"><img src="screenshots/thumbs/15_InviteRewards__Main.jpg" width="100%"></a><br><sub><b>InviteRewards</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_Season__Main.jpg"><img src="screenshots/thumbs/16_Season__Main.jpg" width="100%"></a><br><sub><b>Season</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_TradeList__Main.jpg"><img src="screenshots/thumbs/20_TradeList__Main.jpg" width="100%"></a><br><sub><b>TradeList</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Clans__Members.jpg"><img src="screenshots/thumbs/22_Clans__Members.jpg" width="100%"></a><br><sub><b>Clans</b> › Main.Pages.ClanView.Content.Members</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_Clans__Creating.jpg"><img src="screenshots/thumbs/24_Clans__Creating.jpg" width="100%"></a><br><sub><b>Clans</b> › Main.Pages.MainView.Creating</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Clans__Joining.jpg"><img src="screenshots/thumbs/25_Clans__Joining.jpg" width="100%"></a><br><sub><b>Clans</b> › Main.Pages.MainView.Joining</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_Upgrades__Main.jpg"><img src="screenshots/thumbs/26_Upgrades__Main.jpg" width="100%"></a><br><sub><b>Upgrades</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Quests__Main.jpg"><img src="screenshots/thumbs/27_Quests__Main.jpg" width="100%"></a><br><sub><b>Quests</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_DarkMatterPack__Main.jpg"><img src="screenshots/thumbs/28_DarkMatterPack__Main.jpg" width="100%"></a><br><sub><b>DarkMatterPack</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/29_Tutorial__Main.jpg"><img src="screenshots/thumbs/29_Tutorial__Main.jpg" width="100%"></a><br><sub><b>Tutorial</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_HackerEvent__Main.jpg"><img src="screenshots/thumbs/30_HackerEvent__Main.jpg" width="100%"></a><br><sub><b>HackerEvent</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_Ranks__Main.jpg"><img src="screenshots/thumbs/31_Ranks__Main.jpg" width="100%"></a><br><sub><b>Ranks</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_RainbowEggs__Main.jpg"><img src="screenshots/thumbs/32_RainbowEggs__Main.jpg" width="100%"></a><br><sub><b>RainbowEggs</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_SpecialEvent__Main.jpg"><img src="screenshots/thumbs/33_SpecialEvent__Main.jpg" width="100%"></a><br><sub><b>SpecialEvent</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_DiscordVerification__Main.jpg"><img src="screenshots/thumbs/34_DiscordVerification__Main.jpg" width="100%"></a><br><sub><b>DiscordVerification</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_ToolbarButton.jpg"><img src="screenshots/thumbs/35_ToolbarButton.jpg" width="100%"></a><br><sub><b>ToolbarButton</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_ToolbarButton__AutoPunchBtn.jpg"><img src="screenshots/thumbs/36_ToolbarButton__AutoPunchBtn.jpg" width="100%"></a><br><sub><b>ToolbarButton</b> › AutoPunchBtn</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_Clans.jpg"><img src="screenshots/thumbs/21_Clans.jpg" width="100%"></a><br><sub><b>Clans</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/38_Cell.jpg"><img src="screenshots/thumbs/38_Cell.jpg" width="100%"></a><br><sub><b>Cell</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/40_Clan.jpg"><img src="screenshots/thumbs/40_Clan.jpg" width="100%"></a><br><sub><b>Clan</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/44_1.jpg"><img src="screenshots/thumbs/44_1.jpg" width="100%"></a><br><sub><b>1</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/45_2.jpg"><img src="screenshots/thumbs/45_2.jpg" width="100%"></a><br><sub><b>2</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/46_3.jpg"><img src="screenshots/thumbs/46_3.jpg" width="100%"></a><br><sub><b>3</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/47_4.jpg"><img src="screenshots/thumbs/47_4.jpg" width="100%"></a><br><sub><b>4</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Swords/Prismatic%20Star.rbxm"><img src="screenshots/thumbs/models/01_Prismatic_Star.jpg" width="100%"></a><br><sub><b>Prismatic Star</b><br><code>models/ServerStorage/Swords/Prismatic Star.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/gift%20for%20brennan/Dummy.rbxm"><img src="screenshots/thumbs/models/02_Dummy.jpg" width="100%"></a><br><sub><b>Dummy</b><br><code>models/Workspace/gift for brennan/Dummy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__MAP/Eggs/Void_Egg/PetPriceGroup.rbxm"><img src="screenshots/thumbs/models/03_PetPriceGroup.jpg" width="100%"></a><br><sub><b>PetPriceGroup</b><br><code>models/Workspace/__MAP/Eggs/Void_Egg/PetPriceGroup.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Meshes_egg_platform_Plane.007%20%281%29.rbxm"><img src="screenshots/thumbs/models/04_Meshes_egg_platform_Plane_007_1_.jpg" width="100%"></a><br><sub><b>Meshes_egg_platform_Plane.007 (1)</b><br><code>models/Workspace/Meshes_egg_platform_Plane.007 (1).rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/__MAP/Leaderboards/Gems.rbxm"><img src="screenshots/thumbs/models/05_Gems.jpg" width="100%"></a><br><sub><b>Gems</b><br><code>models/Workspace/__MAP/Leaderboards/Gems.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__MAP/TrainingAreas/6.rbxm"><img src="screenshots/thumbs/models/06_6.jpg" width="100%"></a><br><sub><b>6</b><br><code>models/Workspace/__MAP/TrainingAreas/6.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Other/Rebirth.rbxm"><img src="screenshots/thumbs/models/07_Rebirth.jpg" width="100%"></a><br><sub><b>Rebirth</b><br><code>models/ReplicatedStorage/Assets/Models/Other/Rebirth.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__MAP/Eggs/Void_Egg/Egg.rbxm"><img src="screenshots/thumbs/models/08_Egg.jpg" width="100%"></a><br><sub><b>Egg</b><br><code>models/Workspace/__MAP/Eggs/Void_Egg/Egg.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Main%20Portal%20Template.rbxm"><img src="screenshots/thumbs/models/09_Main_Portal_Template.jpg" width="100%"></a><br><sub><b>Main Portal Template</b><br><code>models/Workspace/Main Portal Template.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__MAP/Leaderboards/Strength.rbxm"><img src="screenshots/thumbs/models/10_Strength.jpg" width="100%"></a><br><sub><b>Strength</b><br><code>models/Workspace/__MAP/Leaderboards/Strength.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Tree.rbxm"><img src="screenshots/thumbs/models/11_Tree.jpg" width="100%"></a><br><sub><b>Tree</b><br><code>models/Workspace/Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Swords/Double%20Lightsaber.rbxm"><img src="screenshots/thumbs/models/12_Double_Lightsaber.jpg" width="100%"></a><br><sub><b>Double Lightsaber</b><br><code>models/ServerStorage/Swords/Double Lightsaber.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/gift%20for%20brennan/Dummy~2.rbxm"><img src="screenshots/thumbs/models/13_Dummy_2.jpg" width="100%"></a><br><sub><b>Dummy~2</b><br><code>models/Workspace/gift for brennan/Dummy~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Meshes_egg_platform_Plane.010%20%281%29.rbxm"><img src="screenshots/thumbs/models/14_Meshes_egg_platform_Plane_010_1_.jpg" width="100%"></a><br><sub><b>Meshes_egg_platform_Plane.010 (1)</b><br><code>models/Workspace/Meshes_egg_platform_Plane.010 (1).rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Cases`](source/scripts/ServerStorage/Cases.lua) <sub>313 lines</sub><br>[`Reward`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Reward.lua) <sub>177 lines</sub><br>[`Egg`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Controllers/Egg.lua) <sub>369 lines</sub> |
| UI controllers / window managers / menus | [`RainbowEggs`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/RainbowEggs.lua) <sub>134 lines</sub><br>[`Clans`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Clans.lua) <sub>799 lines</sub><br>[`DarkMatterPack`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/DarkMatterPack.lua) <sub>132 lines</sub><br>[`Character`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Controllers/Character.lua) <sub>357 lines</sub><br>[`UI`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI.lua) <sub>124 lines</sub> |
| Notifications, toasts, popups, prompts | [`Notifications`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Notifications.lua) <sub>108 lines</sub><br>[`Trade`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Trade.lua) <sub>453 lines</sub><br>[`client-main`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Scripts/client-main.client.lua) <sub>327 lines</sub><br>[`Clans`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Clans.lua) <sub>799 lines</sub><br>[`HUD`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/HUD.lua) <sub>187 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraShakePresets`](source/scripts/ReplicatedStorage/Common/Library/Physics/CameraShaker/CameraShakePresets.lua) <sub>105 lines</sub> |
| VFX, particles, beams, hit effects | [`AdPortalEffectsController`](source/scripts/Workspace/Main%20Portal%20Template/Decorative/AdPortalEffectsController.server.lua) <sub>62 lines</sub><br>[`Effects`](source/scripts/ReplicatedStorage/Common/Modules/Databases/Powers/Effects.lua) <sub>199 lines</sub><br>[`Character`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/Controllers/Character.lua) <sub>357 lines</sub><br>[`client-main`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Scripts/client-main.client.lua) <sub>327 lines</sub> |
| DataStore / player data | [`ProfileService`](source/scripts/ServerScriptService/Server/Library/ProfileService.lua) <sub>2410 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Purchases`](source/scripts/ServerScriptService/Server/Modules/Classes/Purchases.lua) <sub>270 lines</sub><br>[`Purchases`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Library/Classes/Purchases.lua) <sub>195 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Eggs`](source/scripts/ReplicatedStorage/Common/Modules/Databases/Eggs.lua) <sub>220 lines</sub><br>[`EggUtility`](source/scripts/ReplicatedStorage/Common/Modules/Utilities/EggUtility.lua) <sub>88 lines</sub><br>[`Store`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Store.lua) <sub>286 lines</sub><br>[`Player`](source/scripts/ServerScriptService/Server/Modules/Controllers/Player.lua) <sub>1889 lines</sub><br>[`LuckPasses`](source/scripts/ReplicatedStorage/Common/Modules/Databases/LuckPasses.lua) <sub>32 lines</sub> |
| Trading systems | [`Trade`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Trade.lua) <sub>453 lines</sub><br>[`Trade`](source/scripts/ServerScriptService/Server/Modules/Controllers/Trade.lua) <sub>256 lines</sub><br>[`TradeList`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/TradeList.lua) <sub>164 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`client-feature-double-jump`](source/scripts/StarterPlayer/StarterCharacterScripts/Scripts/Features/client-feature-double-jump.client.lua) <sub>51 lines</sub> |
| Tycoon / plots / bases / building | [`Clans`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Clans.lua) <sub>799 lines</sub><br>[`Quests`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Quests.lua) <sub>267 lines</sub><br>[`InviteRewards`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/InviteRewards.lua) <sub>165 lines</sub><br>[`Ranks`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Ranks.lua) <sub>151 lines</sub><br>[`FreeHugeEvent`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/FreeHugeEvent.lua) <sub>185 lines</sub> |
| Leaderboards & stats | [`Leaderboard`](source/scripts/ServerScriptService/Server/Modules/Controllers/Leaderboard.lua) <sub>155 lines</sub> |
| Admin panels & commands | [`givePet Command (no functionality yet)`](source/scripts/ServerScriptService/givePet%20Command%20%28no%20functionality%20yet%29.server.lua) <sub>54 lines</sub> |
| Sound & music | [`Audio`](source/scripts/ReplicatedStorage/Common/Library/Audio.lua) <sub>100 lines</sub> |
| Daily rewards, quests, codes, playtime | [`DailyCaseUtility`](source/scripts/ReplicatedStorage/Common/Modules/Utilities/DailyCaseUtility.lua) <sub>31 lines</sub><br>[`DailyGiftUtility`](source/scripts/ReplicatedStorage/Common/Modules/Utilities/DailyGiftUtility.lua) <sub>46 lines</sub><br>[`WheelRewardUtility`](source/scripts/ReplicatedStorage/Common/Modules/Utilities/WheelRewardUtility.lua) <sub>46 lines</sub><br>[`Daily`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Daily.lua) <sub>198 lines</sub><br>[`Quests`](source/scripts/StarterPlayer/StarterPlayerScripts/Client/Modules/UI/Quests.lua) <sub>267 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Promise`](source/scripts/ReplicatedStorage/Common/Library/Classes/Promise.lua) <sub>1978 lines</sub><br>[`Signal`](source/scripts/ReplicatedStorage/Common/Library/Classes/Signal.lua) <sub>330 lines</sub><br>[`Signal`](source/scripts/ReplicatedStorage/Common/Library/Classes/Timer/Signal.lua) <sub>383 lines</sub><br>[`TableTracker`](source/scripts/ReplicatedStorage/Common/Library/Classes/Tracker/TableTracker.lua) <sub>114 lines</sub><br>[`NumberUtility`](source/scripts/ReplicatedStorage/Common/Library/Utilities/NumberUtility.lua) <sub>222 lines</sub> |

### In the curated script library

- [Shared daily-gift rules (client + server)](../../Scripts/18-Daily-Rewards-Quests/DailyGiftUtility-Shared__punching-simulator.lua) — Tiny shared module: next gift id (1..7 loop), time left and canClaim from the saved {i, t} value, used by both the UI and the server check.
- [Products/passes as callback tables](../../Scripts/08-Monetization/Purchases-CallbackTable__punching-simulator.lua) — Per-player Purchases object: products and passes are database entries with a callback, pass ownership checked with Promises on join, PurchaseId cache in ProcessReceipt.
- [Double jump](../../Scripts/13-Movement/DoubleJump__punching-simulator.lua) — The standard Roblox double-jump recipe (JumpRequest + Freefall/Landed states).
- [Spring-animated notifications](../../Scripts/03-Notifications/SpringNotifications__punching-simulator.lua) — Framework notification service: respects a player "Notifications" setting, plays optional audio, spring-animates UIScale in/out (Spr), callable from server or client.
- [Promise-based sound player](../../Scripts/17-Sound-Music/AudioPlay__punching-simulator.lua) — Plays a named sound from an assets folder (clone, optional position part, pitch via PitchShiftSoundEffect), returns a Promise that resolves when it ends, and cleans up with a Trove. Server calls broadcast to clients; respects the SFX setting.
- [OOP trade class](../../Scripts/10-Trading/TradeClass__punching-simulator.lua) — Trade object with Trove cleanup, state tracker and attribute-replicated state; unreadies on data change.
- [OOP trade request](../../Scripts/10-Trading/TradeRequest__punching-simulator.lua) — Trade request object decided by the target via RemoteFunction, then creates the Trade.
- [Trade eligibility check](../../Scripts/10-Trading/TradeUtility__punching-simulator.lua) — canOccur gate: both loaded, target allows trades, neither already trading.
- [Gradient shine sweep](../../Scripts/01-UI-Animation/ShimmerSweep__punching-simulator.lua) — The classic shine sweep: tween a UIGradient Offset from (-1,0) to (1,0) every 2 s, then snap back.
- [Rainbow gradient sweep](../../Scripts/01-UI-Animation/RainbowGradientSweep__punching-simulator.lua) — Endless rainbow sweep across a label: Offset sweep while rotating through a 15-colour HSV palette, flipping Rotation 0/180 each pass.
- [spr spring animator library](../../Scripts/01-UI-Animation/SprSpringLibrary__punching-simulator.lua) — The open-source "spr" spring library (MIT, Fraktality): spr.Target(instance, dampingRatio, frequency, {props}) animates any property with a critically/under-damped spring.
- [Spin wheel + spring window](../../Scripts/01-UI-Animation/SpinWheel_SprWindow__punching-simulator.lua) — Reward wheel spin landing on a slot (5 full turns + slot offset, Quint out, 5 s) and window open/close driven by spr springs on Position, camera FOV and Blur.
- [UI router (module per screen)](../../Scripts/02-UI-Framework/UIRouter__punching-simulator.lua) — Loads every UI module, runs init/start, and opens/closes screens by name with one open at a time.
- [Number + timer formats, roman numerals](../../Scripts/19-Utility/NumberUtility-TimersRoman__punching-simulator.lua) — short() suffix formatter, decimal(), commas() via reverse+gsub, colon/short/long timer formats with auto unit choice, and roman numeral to/from (for tiers like 'Rebirth IV').
- [Table helpers (map/filter/deep get/set)](../../Scripts/19-Utility/TableUtility-Functional__punching-simulator.lua) — Functional table helpers: all, once, filter, max/min by mapper, entries, match, length, map, sort, and deep set/get by path, deep compare and deep copy.
- [Weighted random pick](../../Scripts/19-Utility/RandomUtility-Weighted__punching-simulator.lua) — chance(d) picks a key from a {key = weight} dictionary with a cumulative-weight roll.
- [Simple object pool](../../Scripts/19-Utility/Pool-Simple__punching-simulator.lua) — Minimal object pool: get() reuses a returned instance or clones the template, back() puts one back.
- [One remote, many named channels](../../Scripts/19-Utility/Network-Multiplexed__punching-simulator.lua) — Network module that sends every call through ONE RemoteEvent/RemoteFunction with a name, plus the same API for bindables; Fired/Invoked return a disconnect function.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/Workspace/Tree~10/Top/Script.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
