# Murderers vs Sheriffs (summer update)

> 🔫 **Shooter** · duels (murderers vs sheriffs, trading, crafting) · source file `vv mmv summer upd 26 f2+ap + new upd.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/72_CrossPlatform__Container.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 35 ScreenGuis, 18006 GUI objects → **91 screenshots** |
| Models (.rbxm) | 1426 models, 4 model sets, 216 VFX sets |
| Lua builders (.lua) | 89 UI screens, 1 animation packs, 9 audio packs |
| Code | 1266 scripts, 137,480 lines |
| Asset ids | 187 animations, 210 sounds |
| Safety scan | 0 HIGH / 9 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Bold`×3973, `SourceSansPro Regular`×2000, `Builder Sans Bold`×118, `GothamSSm Medium`×109, `FredokaOne Regular`×36

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_TradeGUI_Phone__Container.jpg"><img src="screenshots/thumbs/37_TradeGUI_Phone__Container.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Trade.YourOffer.Container.NewItem1.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_TradeGUI_Phone__Tags.jpg"><img src="screenshots/thumbs/40_TradeGUI_Phone__Tags.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Trade.YourOffer.Container.NewItem3.Tags</sub></td>
<td width="33%" valign="top"><a href="screenshots/45_TradeGUI_Phone__Container.jpg"><img src="screenshots/thumbs/45_TradeGUI_Phone__Container.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Trade.TheirOffer.Container.NewItem1.Container</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/70_CrossPlatform__Small.jpg"><img src="screenshots/thumbs/70_CrossPlatform__Small.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Shop.Small</sub></td>
<td width="33%" valign="top"><a href="screenshots/72_CrossPlatform__Container.jpg"><img src="screenshots/thumbs/72_CrossPlatform__Container.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Shop.Medium.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/73_CrossPlatform__Large.jpg"><img src="screenshots/thumbs/73_CrossPlatform__Large.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Shop.Large</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/106_NewOffer.jpg"><img src="screenshots/thumbs/106_NewOffer.jpg" width="100%"></a><br><sub><b>NewOffer</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_TradeGUI__Pets.jpg"><img src="screenshots/thumbs/29_TradeGUI__Pets.jpg" width="100%"></a><br><sub><b>TradeGUI</b> › Container.Items.Main.Pets</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_TradeGUI__Weapons.jpg"><img src="screenshots/thumbs/30_TradeGUI__Weapons.jpg" width="100%"></a><br><sub><b>TradeGUI</b> › Container.Items._mO.Weapons</sub></td>
<td width="33%" valign="top"><a href="screenshots/52_TradeGUI_Phone__Items.jpg"><img src="screenshots/thumbs/52_TradeGUI_Phone__Items.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Items</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/61_CrossPlatform__Medium.jpg"><img src="screenshots/thumbs/61_CrossPlatform__Medium.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › NewItem.Medium</sub></td>
<td width="33%" valign="top"><a href="screenshots/65_CrossPlatform__Inventory.jpg"><img src="screenshots/thumbs/65_CrossPlatform__Inventory.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Emotes._.Inventory</sub></td>
<td width="33%" valign="top"><a href="screenshots/68_CrossPlatform__ItemPackFrame.jpg"><img src="screenshots/thumbs/68_CrossPlatform__ItemPackFrame.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › ItemPackFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/81_BackpackUI.jpg"><img src="screenshots/thumbs/81_BackpackUI.jpg" width="100%"></a><br><sub><b>BackpackUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/82_ItemFrame.jpg"><img src="screenshots/thumbs/82_ItemFrame.jpg" width="100%"></a><br><sub><b>ItemFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/83_ItemFrame__FX.jpg"><img src="screenshots/thumbs/83_ItemFrame__FX.jpg" width="100%"></a><br><sub><b>ItemFrame</b> › Tags.FX</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/84_ItemFrame3.jpg"><img src="screenshots/thumbs/84_ItemFrame3.jpg" width="100%"></a><br><sub><b>ItemFrame3</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/85_ItemFrame3__FX.jpg"><img src="screenshots/thumbs/85_ItemFrame3__FX.jpg" width="100%"></a><br><sub><b>ItemFrame3</b> › Tags.FX</sub></td>
<td width="33%" valign="top"><a href="screenshots/86_EquipContainer.jpg"><img src="screenshots/thumbs/86_EquipContainer.jpg" width="100%"></a><br><sub><b>EquipContainer</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/87_EquipContainer__FX.jpg"><img src="screenshots/thumbs/87_EquipContainer__FX.jpg" width="100%"></a><br><sub><b>EquipContainer</b> › ItemFrame.Tags.FX</sub></td>
<td width="33%" valign="top"><a href="screenshots/88_NewItem.jpg"><img src="screenshots/thumbs/88_NewItem.jpg" width="100%"></a><br><sub><b>NewItem</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/97_NewItem.jpg"><img src="screenshots/thumbs/97_NewItem.jpg" width="100%"></a><br><sub><b>NewItem</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/101_NewItem.jpg"><img src="screenshots/thumbs/101_NewItem.jpg" width="100%"></a><br><sub><b>NewItem</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/102_NewItem.jpg"><img src="screenshots/thumbs/102_NewItem.jpg" width="100%"></a><br><sub><b>NewItem</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/103_ShowcaseItem.jpg"><img src="screenshots/thumbs/103_ShowcaseItem.jpg" width="100%"></a><br><sub><b>ShowcaseItem</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/104_TrophyItem.jpg"><img src="screenshots/thumbs/104_TrophyItem.jpg" width="100%"></a><br><sub><b>TrophyItem</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/105_TrophyItem__Tags.jpg"><img src="screenshots/thumbs/105_TrophyItem__Tags.jpg" width="100%"></a><br><sub><b>TrophyItem</b> › Tags</sub></td>
<td width="33%" valign="top"><a href="screenshots/107_NewItem.jpg"><img src="screenshots/thumbs/107_NewItem.jpg" width="100%"></a><br><sub><b>NewItem</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/109_NewItem.jpg"><img src="screenshots/thumbs/109_NewItem.jpg" width="100%"></a><br><sub><b>NewItem</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/110_NewHotItem.jpg"><img src="screenshots/thumbs/110_NewHotItem.jpg" width="100%"></a><br><sub><b>NewHotItem</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/74_CrossPlatform__RewardFrame.jpg"><img src="screenshots/thumbs/74_CrossPlatform__RewardFrame.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Summer2024.RewardFrame</sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_TradeGUI.jpg"><img src="screenshots/thumbs/28_TradeGUI.jpg" width="100%"></a><br><sub><b>TradeGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/32_TradeGUI_Phone.jpg"><img src="screenshots/thumbs/32_TradeGUI_Phone.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_TradeGUI_Phone__Frame.jpg"><img src="screenshots/thumbs/33_TradeGUI_Phone__Frame.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Inactive.Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_TradeGUI_Phone__Weapons.jpg"><img src="screenshots/thumbs/34_TradeGUI_Phone__Weapons.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Inactive.TradeMainOld.Weapons</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_CrossPlatform__ServerSettings.jpg"><img src="screenshots/thumbs/59_CrossPlatform__ServerSettings.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › ServerSettings</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_CrossPlatform__Title.jpg"><img src="screenshots/thumbs/71_CrossPlatform__Title.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Shop.Medium.Title</sub></td>
<td width="33%" valign="top"><a href="screenshots/78_GameplayControlsUI.jpg"><img src="screenshots/thumbs/78_GameplayControlsUI.jpg" width="100%"></a><br><sub><b>GameplayControlsUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_GameplayControlsUI__TabletOld.jpg"><img src="screenshots/thumbs/79_GameplayControlsUI__TabletOld.jpg" width="100%"></a><br><sub><b>GameplayControlsUI</b> › _.TabletOld</sub></td>
<td width="33%" valign="top"><a href="screenshots/80_GameplayControlsUI__TabletRobloxControls.jpg"><img src="screenshots/thumbs/80_GameplayControlsUI__TabletRobloxControls.jpg" width="100%"></a><br><sub><b>GameplayControlsUI</b> › _.TabletRobloxControls</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/92_CraftFrame__Material1.jpg"><img src="screenshots/thumbs/92_CraftFrame__Material1.jpg" width="100%"></a><br><sub><b>CraftFrame</b> › MultipleContainer.Material1</sub></td>
<td width="33%" valign="top"><a href="screenshots/93_CraftFrame__Material2.jpg"><img src="screenshots/thumbs/93_CraftFrame__Material2.jpg" width="100%"></a><br><sub><b>CraftFrame</b> › MultipleContainer.Material2</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_Loading.jpg"><img src="screenshots/thumbs/01_Loading.jpg" width="100%"></a><br><sub><b>Loading</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Loading_Clean.jpg"><img src="screenshots/thumbs/12_Loading_Clean.jpg" width="100%"></a><br><sub><b>Loading_Clean</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Scoreboard__Classic.jpg"><img src="screenshots/thumbs/20_Scoreboard__Classic.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › Classic</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Scoreboard__ScaryMode.jpg"><img src="screenshots/thumbs/21_Scoreboard__ScaryMode.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › ScaryMode</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Scoreboard__Assassin.jpg"><img src="screenshots/thumbs/22_Scoreboard__Assassin.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › Assassin</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Scoreboard__BonusModes.jpg"><img src="screenshots/thumbs/23_Scoreboard__BonusModes.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › BonusModes</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_Scoreboard_Phone__ScaryMode.jpg"><img src="screenshots/thumbs/24_Scoreboard_Phone__ScaryMode.jpg" width="100%"></a><br><sub><b>Scoreboard_Phone</b> › ScaryMode</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_Scoreboard_Phone__Classic.jpg"><img src="screenshots/thumbs/25_Scoreboard_Phone__Classic.jpg" width="100%"></a><br><sub><b>Scoreboard_Phone</b> › Classic</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_Scoreboard_Phone__Assassin.jpg"><img src="screenshots/thumbs/26_Scoreboard_Phone__Assassin.jpg" width="100%"></a><br><sub><b>Scoreboard_Phone</b> › Assassin</sub></td>
<td width="33%" valign="top"><a href="screenshots/27_Scoreboard_Phone__BonusModes.jpg"><img src="screenshots/thumbs/27_Scoreboard_Phone__BonusModes.jpg" width="100%"></a><br><sub><b>Scoreboard_Phone</b> › BonusModes</sub></td>
<td width="33%" valign="top"><a href="screenshots/77_GameTopbar.jpg"><img src="screenshots/thumbs/77_GameTopbar.jpg" width="100%"></a><br><sub><b>GameTopbar</b></sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_VictorySlideConcept.jpg"><img src="screenshots/thumbs/13_VictorySlideConcept.jpg" width="100%"></a><br><sub><b>VictorySlideConcept</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_Victory.jpg"><img src="screenshots/thumbs/14_Victory.jpg" width="100%"></a><br><sub><b>Victory</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_CrossPlatform__FriendsOnline.jpg"><img src="screenshots/thumbs/53_CrossPlatform__FriendsOnline.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › FriendsOnline</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/66_CrossPlatform__EmoteWindow.jpg"><img src="screenshots/thumbs/66_CrossPlatform__EmoteWindow.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Emotes.EmoteWindow</sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/91_CraftFrame.jpg"><img src="screenshots/thumbs/91_CraftFrame.jpg" width="100%"></a><br><sub><b>CraftFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/96_CraftFrame__SingleContainer.jpg"><img src="screenshots/thumbs/96_CraftFrame__SingleContainer.jpg" width="100%"></a><br><sub><b>CraftFrame</b> › SingleContainer</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/60_CrossPlatform__Console.jpg"><img src="screenshots/thumbs/60_CrossPlatform__Console.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › RoleSelection.Console</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/69_CrossPlatform__OwnedCurrencyFrame.jpg"><img src="screenshots/thumbs/69_CrossPlatform__OwnedCurrencyFrame.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Shop.OwnedCurrencyFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/89_Main.jpg"><img src="screenshots/thumbs/89_Main.jpg" width="100%"></a><br><sub><b>Main</b></sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_CrossPlatform__Avater_Emotes.jpg"><img src="screenshots/thumbs/62_CrossPlatform__Avater_Emotes.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Emotes.EmoteContainer.Avater Emotes</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_CrossPlatform__Default_Emotes.jpg"><img src="screenshots/thumbs/63_CrossPlatform__Default_Emotes.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Emotes.EmoteContainer.Default Emotes</sub></td>
<td width="33%" valign="top"><a href="screenshots/64_CrossPlatform__EmotePages.jpg"><img src="screenshots/thumbs/64_CrossPlatform__EmotePages.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Emotes._.EmotePages</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_CrossPlatform__Container.jpg"><img src="screenshots/thumbs/57_CrossPlatform__Container.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Duels.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_CrossPlatform__DuelRound.jpg"><img src="screenshots/thumbs/58_CrossPlatform__DuelRound.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Duels.DuelRound</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_GamemodePhone.jpg"><img src="screenshots/thumbs/02_GamemodePhone.jpg" width="100%"></a><br><sub><b>GamemodePhone</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_GamemodeBonus.jpg"><img src="screenshots/thumbs/03_GamemodeBonus.jpg" width="100%"></a><br><sub><b>GamemodeBonus</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_Join_Old.jpg"><img src="screenshots/thumbs/04_Join_Old.jpg" width="100%"></a><br><sub><b>Join_Old</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_Join_Old__Retry.jpg"><img src="screenshots/thumbs/05_Join_Old__Retry.jpg" width="100%"></a><br><sub><b>Join_Old</b> › Retry</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_JoinPhone.jpg"><img src="screenshots/thumbs/06_JoinPhone.jpg" width="100%"></a><br><sub><b>JoinPhone</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_JoinPhone__Retry.jpg"><img src="screenshots/thumbs/07_JoinPhone__Retry.jpg" width="100%"></a><br><sub><b>JoinPhone</b> › Retry</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_DeviceSelect.jpg"><img src="screenshots/thumbs/08_DeviceSelect.jpg" width="100%"></a><br><sub><b>DeviceSelect</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_Gamemode.jpg"><img src="screenshots/thumbs/09_Gamemode.jpg" width="100%"></a><br><sub><b>Gamemode</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_Join.jpg"><img src="screenshots/thumbs/10_Join.jpg" width="100%"></a><br><sub><b>Join</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_TrapGUI.jpg"><img src="screenshots/thumbs/15_TrapGUI.jpg" width="100%"></a><br><sub><b>TrapGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_StatusEffectGui.jpg"><img src="screenshots/thumbs/16_StatusEffectGui.jpg" width="100%"></a><br><sub><b>StatusEffectGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/17_CustomGames.jpg"><img src="screenshots/thumbs/17_CustomGames.jpg" width="100%"></a><br><sub><b>CustomGames</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_CustomGames__Mode1v1.jpg"><img src="screenshots/thumbs/18_CustomGames__Mode1v1.jpg" width="100%"></a><br><sub><b>CustomGames</b> › Mode1v1</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_CustomGames__Mode1v1-Auto.jpg"><img src="screenshots/thumbs/19_CustomGames__Mode1v1-Auto.jpg" width="100%"></a><br><sub><b>CustomGames</b> › Mode1v1-Auto</sub></td>
<td width="33%" valign="top"><a href="screenshots/54_CrossPlatform__ModeOverlay.jpg"><img src="screenshots/thumbs/54_CrossPlatform__ModeOverlay.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › GameModes.ModeOverlay</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/55_CrossPlatform__Overlay.jpg"><img src="screenshots/thumbs/55_CrossPlatform__Overlay.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › GameModes.Overlay</sub></td>
<td width="33%" valign="top"><a href="screenshots/56_CrossPlatform__Container.jpg"><img src="screenshots/thumbs/56_CrossPlatform__Container.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › GameModes.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_CrossPlatform__Summer2026.jpg"><img src="screenshots/thumbs/67_CrossPlatform__Summer2026.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Summer2026</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/75_CrossPlatform__Rare.jpg"><img src="screenshots/thumbs/75_CrossPlatform__Rare.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Summer2024.Rare</sub></td>
<td width="33%" valign="top"><a href="screenshots/76_CrossPlatform__Container.jpg"><img src="screenshots/thumbs/76_CrossPlatform__Container.jpg" width="100%"></a><br><sub><b>CrossPlatform</b> › Summer2024.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/90_MysteryBoxOpen.jpg"><img src="screenshots/thumbs/90_MysteryBoxOpen.jpg" width="100%"></a><br><sub><b>MysteryBoxOpen</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/98_Unboxing.jpg"><img src="screenshots/thumbs/98_Unboxing.jpg" width="100%"></a><br><sub><b>Unboxing</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/100_Hatching__Cracked.jpg"><img src="screenshots/thumbs/100_Hatching__Cracked.jpg" width="100%"></a><br><sub><b>Hatching</b> › Cracked</sub></td>
<td width="33%" valign="top"><a href="screenshots/108_NewBoxContents.jpg"><img src="screenshots/thumbs/108_NewBoxContents.jpg" width="100%"></a><br><sub><b>NewBoxContents</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Maps/ResearchFacility/Parts.rbxm"><img src="screenshots/thumbs/models/01_Parts.jpg" width="100%"></a><br><sub><b>Parts</b><br><code>models/ServerStorage/Database/Maps/ResearchFacility/Parts.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Item/EggAxe.rbxm"><img src="screenshots/thumbs/models/02_EggAxe.jpg" width="100%"></a><br><sub><b>EggAxe</b><br><code>models/ServerStorage/Database/Item/EggAxe.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Toys/CandyBucket2025.rbxm"><img src="screenshots/thumbs/models/03_CandyBucket2025.jpg" width="100%"></a><br><sub><b>CandyBucket2025</b><br><code>models/ServerStorage/Database/Toys/CandyBucket2025.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Item/TreeKnife2023.rbxm"><img src="screenshots/thumbs/models/04_TreeKnife2023.jpg" width="100%"></a><br><sub><b>TreeKnife2023</b><br><code>models/ServerStorage/Database/Item/TreeKnife2023.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Maps/Hospital3/Decoration_Regular/Trees/Tree__x8.rbxm"><img src="screenshots/thumbs/models/05_Tree_x8.jpg" width="100%"></a><br><sub><b>Tree__x8</b><br><code>models/ServerStorage/Database/Maps/Hospital3/Decoration_Regular/Trees/Tree__x8.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Pets/BatFire.rbxm"><img src="screenshots/thumbs/models/06_BatFire.jpg" width="100%"></a><br><sub><b>BatFire</b><br><code>models/ServerStorage/Database/Pets/BatFire.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Maps/Hotel2/Base.rbxm"><img src="screenshots/thumbs/models/07_Base.jpg" width="100%"></a><br><sub><b>Base</b><br><code>models/ServerStorage/Database/Maps/Hotel2/Base.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Toys/MagicBook2024.rbxm"><img src="screenshots/thumbs/models/08_MagicBook2024.jpg" width="100%"></a><br><sub><b>MagicBook2024</b><br><code>models/ServerStorage/Database/Toys/MagicBook2024.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Toys/EggToy2023.rbxm"><img src="screenshots/thumbs/models/09_EggToy2023.jpg" width="100%"></a><br><sub><b>EggToy2023</b><br><code>models/ServerStorage/Database/Toys/EggToy2023.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Gameplay/Hair/BlackCharmerHair.rbxm"><img src="screenshots/thumbs/models/10_BlackCharmerHair.jpg" width="100%"></a><br><sub><b>BlackCharmerHair</b><br><code>models/ServerStorage/Gameplay/Hair/BlackCharmerHair.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Maps/ResearchFacility/Interactive/MainTeleporters.rbxm"><img src="screenshots/thumbs/models/11_MainTeleporters.jpg" width="100%"></a><br><sub><b>MainTeleporters</b><br><code>models/ServerStorage/Database/Maps/ResearchFacility/Interactive/MainTeleporters.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/LiveBoard.rbxm"><img src="screenshots/thumbs/models/12_LiveBoard.jpg" width="100%"></a><br><sub><b>LiveBoard</b><br><code>models/Workspace/LiveBoard.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Radios/Tree.rbxm"><img src="screenshots/thumbs/models/13_Tree.jpg" width="100%"></a><br><sub><b>Tree</b><br><code>models/ServerStorage/Database/Radios/Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Database/Maps/Mansion2/Decoration_Regular.rbxm"><img src="screenshots/thumbs/models/14_Decoration_Regular.jpg" width="100%"></a><br><sub><b>Decoration_Regular</b><br><code>models/ServerStorage/Database/Maps/Mansion2/Decoration_Regular.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`AdminBoardPurchaseClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminBoardPurchaseClient.client.lua) <sub>171 lines</sub><br>[`ItemPopupScript`](source/scripts/StarterGui/CrossPlatform/NewItem/ItemPopupScript.client.lua) <sub>113 lines</sub><br>[`LiveBoardClient`](source/scripts/StarterPlayer/StarterPlayerScripts/LiveBoardClient.client.lua) <sub>208 lines</sub><br>[`SpringUtils`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/blend/node_modules/%40quenty/spring/Shared/SpringUtils.lua) <sub>99 lines</sub><br>[`Button`](source/scripts/ReplicatedStorage/ClientServices/Button.lua) <sub>87 lines</sub> |
| UI controllers / window managers / menus | [`EventScript`](source/scripts/StarterGui/CrossPlatform/Summer2024/EventScript.client.lua) <sub>192 lines</sub><br>[`Menu_GUI`](source/scripts/ReplicatedStorage/GUI/MainPC/Menu_GUI.client.lua) <sub>255 lines</sub><br>[`InteractiveScript`](source/scripts/ServerStorage/Database/Maps/ResearchFacility/Interactive/GarageSystem/GarageOpenerInside/InteractiveBox/InteractiveScript.server.lua) <sub>49 lines</sub><br>[`WindowService01`](source/scripts/ReplicatedStorage/Modules/WindowService01.lua) <sub>104 lines</sub><br>[`SoftShutdownUI`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/Client/SoftShutdownUI.lua) <sub>247 lines</sub> |
| Notifications, toasts, popups, prompts | [`Script`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/Script.client.lua) <sub>187 lines</sub><br>[`ItemPopupScript`](source/scripts/StarterGui/CrossPlatform/NewItem/ItemPopupScript.client.lua) <sub>113 lines</sub><br>[`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`ShopDesktop`](source/scripts/StarterGui/CrossPlatform/Shop/ShopScript/ShopDesktop.client.lua) <sub>355 lines</sub><br>[`AdminSettings`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/OwnerPanel/AdminSettings.client.lua) <sub>341 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/ReplicatedFirst/UISelector/Loading.client.lua) <sub>467 lines</sub><br>[`LoadingScript`](source/scripts/ReplicatedFirst/UISelector/LoadingS2/Loading/LoadingScript.client.lua) <sub>51 lines</sub><br>[`ShopModule`](source/scripts/ReplicatedStorage/Modules/ShopModule.lua) <sub>869 lines</sub><br>[`RoleSelect`](source/scripts/ReplicatedStorage/GUI/MainMobile/Gameplay/RoleSelect.client.lua) <sub>284 lines</sub><br>[`Game_RoleSelector`](source/scripts/ReplicatedStorage/GUI/MainPC/Game_RoleSelector.client.lua) <sub>251 lines</sub> |
| VFX, particles, beams, hit effects | [`GunServer`](source/scripts/ServerStorage/Gameplay/GunScripts/GunServer.server.lua) <sub>163 lines</sub><br>[`Script`](source/scripts/ServerStorage/Database/Toys/MagicBook2024/Script.server.lua) <sub>45 lines</sub><br>[`MakeBalloon`](source/scripts/ServerStorage/Database/Toys/SnowballToy2020/MakeBalloon.lua) <sub>45 lines</sub><br>[`Teleporter`](source/scripts/ServerStorage/Database/Maps/ResearchFacility/Interactive/MainTeleporters/TP1/Teleporter.server.lua) <sub>146 lines</sub><br>[`Teleporter`](source/scripts/ServerStorage/Database/Maps/ResearchFacility/Interactive/MainTeleporters/TP2/Teleporter.server.lua) <sub>148 lines</sub> |
| DataStore / player data | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`DataModule`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/DataModule.lua) <sub>3010 lines</sub><br>[`DataStore`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/datastore/Server/DataStore.lua) <sub>223 lines</sub><br>[`DataStorePromises`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/datastore/Server/Utility/DataStorePromises.lua) <sub>154 lines</sub><br>[`PlayerDataStoreManager`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/datastore/Server/PlayerDataStoreManager.lua) <sub>172 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`DataModule`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/DataModule.lua) <sub>3010 lines</sub><br>[`AdminBoardPurchaseClient`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminBoardPurchaseClient.client.lua) <sub>171 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`DataModule`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/DataModule.lua) <sub>3010 lines</sub><br>[`CoinsController`](source/scripts/ServerScriptService/GameScript/Modules/CoinsController.lua) <sub>215 lines</sub><br>[`OpenCrate`](source/scripts/ReplicatedStorage/GUI/MainXbox/Menu/Shop_Data_Xbox/OpenCrate.lua) <sub>207 lines</sub><br>[`Classic`](source/scripts/ServerScriptService/GameScript/GameModes/Classic.lua) <sub>1092 lines</sub> |
| Trading systems | [`TradeModule`](source/scripts/ReplicatedStorage/Modules/TradeModule.lua) <sub>357 lines</sub><br>[`Trading`](source/scripts/ReplicatedStorage/GUI/MainPC/Inventory/Trading.client.lua) <sub>65 lines</sub><br>[`Trading_Phone`](source/scripts/ReplicatedStorage/GUI/MainMobile/Inventory/Trading_Phone.client.lua) <sub>34 lines</sub><br>[`Trade`](source/scripts/ReplicatedStorage/GUI/MainXbox/Menu/Trade.client.lua) <sub>505 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`KnifeServer`](source/scripts/ServerStorage/Gameplay/KnifeScripts/KnifeServer.server.lua) <sub>549 lines</sub><br>[`Assassin`](source/scripts/ServerScriptService/GameScript/GameModes/Assassin.lua) <sub>269 lines</sub><br>[`GunServer`](source/scripts/ServerStorage/Gameplay/GunScripts/GunServer.server.lua) <sub>163 lines</sub><br>[`Server`](source/scripts/ServerStorage/Database/Toys/Candle2025/Server.server.lua) <sub>72 lines</sub><br>[`Server`](source/scripts/ServerStorage/Database/Toys/TreeToy2024/Server.server.lua) <sub>72 lines</sub> |
| NPC / AI / monsters | [`NPCPhysics`](source/scripts/Workspace/Lobby/ToolNPCS/NPCPhysics.server.lua) <sub>91 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`SprintClient`](source/scripts/ServerScriptService/GameScript/Modules/PerksController/Sprint/SprintClient.client.lua) <sub>18 lines</sub><br>[`Sprint`](source/scripts/ServerStorage/Database/Perks/Sprint.lua) <sub>29 lines</sub><br>[`Classic`](source/scripts/ServerScriptService/GameScript/GameModes/Classic.lua) <sub>1092 lines</sub> |
| Tycoon / plots / bases / building | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`AdminSettings`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/OwnerPanel/AdminSettings.client.lua) <sub>341 lines</sub><br>[`AdminSettings`](source/scripts/StarterGui/CrossPlatform/OwnerPanel/AdminSettings.client.lua) <sub>342 lines</sub><br>[`EventScript`](source/scripts/StarterGui/CrossPlatform/Summer2024/EventScript.client.lua) <sub>192 lines</sub><br>[`DataModule`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/DataModule.lua) <sub>3010 lines</sub> |
| Admin panels & commands | [`AdminSettings`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/OwnerPanel/AdminSettings.client.lua) <sub>341 lines</sub><br>[`AdminSettings`](source/scripts/ServerStorage/DisabledOldAdminSystem/StarterGui/AdminSettings/AdminSettings.client.lua) <sub>151 lines</sub><br>[`AdminSettings`](source/scripts/StarterGui/CrossPlatform/OwnerPanel/AdminSettings.client.lua) <sub>342 lines</sub><br>[`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`AdminController`](source/scripts/ServerStorage/DisabledOldAdminSystem/ServerScriptService/AdminController.lua) <sub>303 lines</sub> |
| Sound & music | [`InteractSound`](source/scripts/ReplicatedStorage/ClientServices/FX/FX_Modules/InteractSound.lua) <sub>53 lines</sub><br>[`AudioSearcher`](source/scripts/ReplicatedStorage/Modules/AudioSearcher.lua) <sub>45 lines</sub><br>[`MusicScript`](source/scripts/ReplicatedStorage/GUI/MainPC/Game/Settings/MusicScript.client.lua) <sub>27 lines</sub><br>[`MusicScript`](source/scripts/StarterGui/GameTopbar/MusicScript.client.lua) <sub>56 lines</sub><br>[`GameplayAnimations`](source/scripts/StarterPlayer/StarterPlayerScripts/GameplayAnimations.client.lua) <sub>263 lines</sub> |
| Daily rewards, quests, codes, playtime | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>3595 lines</sub><br>[`DataModule`](source/scripts/ServerStorage/AdminPanelImportBackup/AdminPanelFromCoolGame/DataModule.lua) <sub>3010 lines</sub><br>[`QuestService`](source/scripts/StarterGui/CrossPlatform/Summer2026/EventScript/QuestService.lua) <sub>327 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`RxBrioUtils`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/blend/node_modules/%40quenty/brio/Shared/RxBrioUtils.lua) <sub>715 lines</sub><br>[`Table`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/attributeutils/node_modules/%40quenty/rx/node_modules/%40quenty/table/Shared/Table.lua) <sub>323 lines</sub><br>[`Promise`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/attributeutils/node_modules/%40quenty/rx/node_modules/%40quenty/canceltoken/node_modules/%40quenty/promise/Shared/Promise.lua) <sub>554 lines</sub><br>[`DataStoreStage`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/datastore/Server/Modules/DataStoreStage.lua) <sub>334 lines</sub><br>[`Signal`](source/scripts/ServerScriptService/GameScript/Classes/SoftShutdown/src/node_modules/%40quenty/attributeutils/node_modules/%40quenty/rx/node_modules/%40quenty/canceltoken/node_modules/%40quenty/signal/Shared/Signal.lua) <sub>155 lines</sub> |

### In the curated script library

- [Hitscan gun (server)](../../Scripts/11-Combat/HitscanGunServer__murderers-vs-sheriffs.lua) — Server hitscan with fire-rate lock and pass-through for invisible parts.
- [Gamepass buy button](../../Scripts/03-Notifications/GamepassBuyButton__murderers-vs-sheriffs.lua) — World SurfaceGui gamepass buy button: hover/press tweens, anti double-prompt, listens to PromptGamePassPurchaseFinished and flips to "Purchased".
- [Lightweight wander runtime](../../Scripts/12-NPC-AI/RandomWanderRuntime__murderers-vs-sheriffs.lua) — Tiny module that registers rigs and, every 5 seconds per rig, MoveTo's a random point 10-20 studs away; one Heartbeat connection per rig with Disconnect / DisconnectAll.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
