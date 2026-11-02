# Murder Mystery 2

> 🎉 **Party** · social deduction (murderer vs sheriff) · source file `New MM2 Leak.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/98_TradeGUI_Phone__NewItem1.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 35 ScreenGuis, 18024 GUI objects → **91 screenshots** |
| Models (.rbxm) | 793 models, 41 model sets, 77 VFX sets |
| Lua builders (.lua) | 131 UI screens, 3 animation packs, 5 audio packs |
| Code | 1256 scripts, 151,206 lines |
| Asset ids | 143 animations, 293 sounds |
| Safety scan | 5 HIGH / 23 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Bold`×4912, `SourceSansPro Regular`×1778, `SourceSansPro SemiBold`×80, `Kalam Regular`×36, `RomanAntique Regular`×12

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_ScreenGui__BattlePass.jpg"><img src="screenshots/thumbs/03_ScreenGui__BattlePass.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.BattlePass</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_ScreenGui__Workshop.jpg"><img src="screenshots/thumbs/07_ScreenGui__Workshop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Workshop</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_ScreenGui___returnToShop.jpg"><img src="screenshots/thumbs/08_ScreenGui___returnToShop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._returnToShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_ScreenGui__BattlePass.jpg"><img src="screenshots/thumbs/28_ScreenGui__BattlePass.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.BattlePass</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_ScreenGui__Workshop.jpg"><img src="screenshots/thumbs/32_ScreenGui__Workshop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Workshop</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_ScreenGui___returnToShop.jpg"><img src="screenshots/thumbs/33_ScreenGui___returnToShop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._returnToShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/53_ScreenGui__BattlePass.jpg"><img src="screenshots/thumbs/53_ScreenGui__BattlePass.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.BattlePass</sub></td>
<td width="33%" valign="top"><a href="screenshots/57_ScreenGui__Workshop.jpg"><img src="screenshots/thumbs/57_ScreenGui__Workshop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Workshop</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_ScreenGui___returnToShop.jpg"><img src="screenshots/thumbs/58_ScreenGui___returnToShop.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._returnToShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/98_TradeGUI_Phone__NewItem1.jpg"><img src="screenshots/thumbs/98_TradeGUI_Phone__NewItem1.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Trade.Offer1.Container.NewItem1</sub></td>
<td width="33%" valign="top"><a href="screenshots/102_TradeGUI_Phone__NewItem1.jpg"><img src="screenshots/thumbs/102_TradeGUI_Phone__NewItem1.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Trade.Offer2.Container.NewItem1</sub></td>
<td width="33%" valign="top"><a href="screenshots/109_Shop.jpg"><img src="screenshots/thumbs/109_Shop.jpg" width="100%"></a><br><sub><b>Shop</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_ScreenGui___ItemPack.jpg"><img src="screenshots/thumbs/02_ScreenGui___ItemPack.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._ItemPack</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_ScreenGui__Box.jpg"><img src="screenshots/thumbs/04_ScreenGui__Box.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Box</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_ScreenGui__ItemPack.jpg"><img src="screenshots/thumbs/05_ScreenGui__ItemPack.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.ItemPack</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_ScreenGui__ItemPack2.jpg"><img src="screenshots/thumbs/09_ScreenGui__ItemPack2.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack2</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/10_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_ScreenGui__Pet.jpg"><img src="screenshots/thumbs/11_ScreenGui__Pet.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Pet</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/12_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Knife</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_ScreenGui__ItemPack4.jpg"><img src="screenshots/thumbs/13_ScreenGui__ItemPack4.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack4</sub></td>
<td width="33%" valign="top"><a href="screenshots/14_ScreenGui__ItemPack5.jpg"><img src="screenshots/thumbs/14_ScreenGui__ItemPack5.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/15_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Knife</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/16_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_ScreenGui__Gun.jpg"><img src="screenshots/thumbs/17_ScreenGui__Gun.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Gun</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/18_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_ScreenGui__Pet.jpg"><img src="screenshots/thumbs/19_ScreenGui__Pet.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Pet</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/20_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Knife</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_ScreenGui__ItemPack1.jpg"><img src="screenshots/thumbs/22_ScreenGui__ItemPack1.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack1</sub></td>
<td width="33%" valign="top"><a href="screenshots/23_ScreenGui__ItemPack6.jpg"><img src="screenshots/thumbs/23_ScreenGui__ItemPack6.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack6</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_ScreenGui__ItemPack5.jpg"><img src="screenshots/thumbs/24_ScreenGui__ItemPack5.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_ScreenGui___ItemPack.jpg"><img src="screenshots/thumbs/27_ScreenGui___ItemPack.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._ItemPack</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_ScreenGui__ItemPack2.jpg"><img src="screenshots/thumbs/34_ScreenGui__ItemPack2.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack2</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/35_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Effect</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_ScreenGui__Pet.jpg"><img src="screenshots/thumbs/36_ScreenGui__Pet.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Pet</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/37_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Knife</sub></td>
<td width="33%" valign="top"><a href="screenshots/39_ScreenGui__ItemPack5.jpg"><img src="screenshots/thumbs/39_ScreenGui__ItemPack5.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/41_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/43_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/43_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_ScreenGui__ItemPack1.jpg"><img src="screenshots/thumbs/47_ScreenGui__ItemPack1.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack1</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/52_ScreenGui___ItemPack.jpg"><img src="screenshots/thumbs/52_ScreenGui___ItemPack.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._ItemPack</sub></td>
<td width="33%" valign="top"><a href="screenshots/54_ScreenGui__Box.jpg"><img src="screenshots/thumbs/54_ScreenGui__Box.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Box</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_ScreenGui__ItemPack.jpg"><img src="screenshots/thumbs/55_ScreenGui__ItemPack.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.ItemPack</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_ScreenGui__ItemPack2.jpg"><img src="screenshots/thumbs/59_ScreenGui__ItemPack2.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack2</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/60_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_ScreenGui__Pet.jpg"><img src="screenshots/thumbs/61_ScreenGui__Pet.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Pet</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/62_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack3.Knife</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_ScreenGui__ItemPack4.jpg"><img src="screenshots/thumbs/63_ScreenGui__ItemPack4.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack4</sub></td>
<td width="33%" valign="top"><a href="screenshots/64_ScreenGui__ItemPack5.jpg"><img src="screenshots/thumbs/64_ScreenGui__ItemPack5.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/65_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/65_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Knife</sub></td>
<td width="33%" valign="top"><a href="screenshots/66_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/66_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_ScreenGui__Gun.jpg"><img src="screenshots/thumbs/67_ScreenGui__Gun.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack6.Gun</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/68_ScreenGui__Effect.jpg"><img src="screenshots/thumbs/68_ScreenGui__Effect.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/69_ScreenGui__Pet.jpg"><img src="screenshots/thumbs/69_ScreenGui__Pet.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Pet</sub></td>
<td width="33%" valign="top"><a href="screenshots/70_ScreenGui__Knife.jpg"><img src="screenshots/thumbs/70_ScreenGui__Knife.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main.ItemPack1.Knife</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/72_ScreenGui__ItemPack1.jpg"><img src="screenshots/thumbs/72_ScreenGui__ItemPack1.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack1</sub></td>
<td width="33%" valign="top"><a href="screenshots/73_ScreenGui__ItemPack6.jpg"><img src="screenshots/thumbs/73_ScreenGui__ItemPack6.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack6</sub></td>
<td width="33%" valign="top"><a href="screenshots/74_ScreenGui__ItemPack5.jpg"><img src="screenshots/thumbs/74_ScreenGui__ItemPack5.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.ItemPack5</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/93_Trade__Weapons.jpg"><img src="screenshots/thumbs/93_Trade__Weapons.jpg" width="100%"></a><br><sub><b>Trade</b> › Container.Items._mO.Weapons</sub></td>
<td width="33%" valign="top"><a href="screenshots/106_TradeGUI_Phone__Items.jpg"><img src="screenshots/thumbs/106_TradeGUI_Phone__Items.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b> › Container.Items</sub></td>
<td width="33%" valign="top"><a href="screenshots/110_Shop___ItemPack.jpg"><img src="screenshots/thumbs/110_Shop___ItemPack.jpg" width="100%"></a><br><sub><b>Shop</b> › Old.MenuItems._ItemPack</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/91_SpawnFade__CodeFrame.jpg"><img src="screenshots/thumbs/91_SpawnFade__CodeFrame.jpg" width="100%"></a><br><sub><b>SpawnFade</b> › CodeFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/107_Gifter.jpg"><img src="screenshots/thumbs/107_Gifter.jpg" width="100%"></a><br><sub><b>Gifter</b></sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/92_Trade.jpg"><img src="screenshots/thumbs/92_Trade.jpg" width="100%"></a><br><sub><b>Trade</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/97_TradeGUI_Phone.jpg"><img src="screenshots/thumbs/97_TradeGUI_Phone.jpg" width="100%"></a><br><sub><b>TradeGUI_Phone</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_ScreenGui__Menu.jpg"><img src="screenshots/thumbs/21_ScreenGui__Menu.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.Menu</sub></td>
<td width="33%" valign="top"><a href="screenshots/46_ScreenGui__Menu.jpg"><img src="screenshots/thumbs/46_ScreenGui__Menu.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.Menu</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_ScreenGui__Menu.jpg"><img src="screenshots/thumbs/71_ScreenGui__Menu.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Main4.Menu</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/78_Loading.jpg"><img src="screenshots/thumbs/78_Loading.jpg" width="100%"></a><br><sub><b>Loading</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_ScreenGui__Leaderboard.jpg"><img src="screenshots/thumbs/06_ScreenGui__Leaderboard.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Leaderboard</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_ScreenGui__Leaderboard.jpg"><img src="screenshots/thumbs/31_ScreenGui__Leaderboard.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Leaderboard</sub></td>
<td width="33%" valign="top"><a href="screenshots/56_ScreenGui__Leaderboard.jpg"><img src="screenshots/thumbs/56_ScreenGui__Leaderboard.jpg" width="100%"></a><br><sub><b>ScreenGui</b> › Seasonal.Old.MenuItems._oldmenu.Leaderboard</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/86_Scoreboard_Phone__ScaryMode.jpg"><img src="screenshots/thumbs/86_Scoreboard_Phone__ScaryMode.jpg" width="100%"></a><br><sub><b>Scoreboard_Phone</b> › ScaryMode</sub></td>
<td width="33%" valign="top"><a href="screenshots/87_Scoreboard_Phone__Classic.jpg"><img src="screenshots/thumbs/87_Scoreboard_Phone__Classic.jpg" width="100%"></a><br><sub><b>Scoreboard_Phone</b> › Classic</sub></td>
<td width="33%" valign="top"><a href="screenshots/88_Scoreboard__ScaryMode.jpg"><img src="screenshots/thumbs/88_Scoreboard__ScaryMode.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › ScaryMode</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/89_Scoreboard__Assassin.jpg"><img src="screenshots/thumbs/89_Scoreboard__Assassin.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › Assassin</sub></td>
<td width="33%" valign="top"><a href="screenshots/90_Scoreboard__Classic.jpg"><img src="screenshots/thumbs/90_Scoreboard__Classic.jpg" width="100%"></a><br><sub><b>Scoreboard</b> › Classic</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/85_Victory.jpg"><img src="screenshots/thumbs/85_Victory.jpg" width="100%"></a><br><sub><b>Victory</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_ScreenGui.jpg"><img src="screenshots/thumbs/01_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_ScreenGui.jpg"><img src="screenshots/thumbs/25_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_ScreenGui.jpg"><img src="screenshots/thumbs/26_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/51_ScreenGui.jpg"><img src="screenshots/thumbs/51_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/76_Join.jpg"><img src="screenshots/thumbs/76_Join.jpg" width="100%"></a><br><sub><b>Join</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/77_Join__Retry.jpg"><img src="screenshots/thumbs/77_Join__Retry.jpg" width="100%"></a><br><sub><b>Join</b> › Retry</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_DeviceSelect.jpg"><img src="screenshots/thumbs/79_DeviceSelect.jpg" width="100%"></a><br><sub><b>DeviceSelect</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/81_JoinPhone__Retry.jpg"><img src="screenshots/thumbs/81_JoinPhone__Retry.jpg" width="100%"></a><br><sub><b>JoinPhone</b> › Retry</sub></td>
<td width="33%" valign="top"><a href="screenshots/82_GamemodeBonus.jpg"><img src="screenshots/thumbs/82_GamemodeBonus.jpg" width="100%"></a><br><sub><b>GamemodeBonus</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/83_GamemodePhone.jpg"><img src="screenshots/thumbs/83_GamemodePhone.jpg" width="100%"></a><br><sub><b>GamemodePhone</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/84_Gamemode.jpg"><img src="screenshots/thumbs/84_Gamemode.jpg" width="100%"></a><br><sub><b>Gamemode</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/95_LowGraphics.jpg"><img src="screenshots/thumbs/95_LowGraphics.jpg" width="100%"></a><br><sub><b>LowGraphics</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/96_HighGraphics.jpg"><img src="screenshots/thumbs/96_HighGraphics.jpg" width="100%"></a><br><sub><b>HighGraphics</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/108_Inviter.jpg"><img src="screenshots/thumbs/108_Inviter.jpg" width="100%"></a><br><sub><b>Inviter</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/Workshop.rbxm"><img src="screenshots/thumbs/models/01_Workshop.jpg" width="100%"></a><br><sub><b>Workshop</b><br><code>models/ServerStorage/Maps/Workshop.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Weapon%20Models/Handle__x14.rbxm"><img src="screenshots/thumbs/models/02_Handle_x14.jpg" width="100%"></a><br><sub><b>Handle__x14</b><br><code>models/Workspace/Weapon Models/Handle__x14.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Autumn%20Tree.rbxm"><img src="screenshots/thumbs/models/03_Autumn_Tree.jpg" width="100%"></a><br><sub><b>Autumn Tree</b><br><code>models/Workspace/Autumn Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Robux/Model~2.rbxm"><img src="screenshots/thumbs/models/04_Model_2.jpg" width="100%"></a><br><sub><b>Model~2</b><br><code>models/Workspace/Robux/Model~2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Items/Pets/HeartBalloon.rbxm"><img src="screenshots/thumbs/models/06_HeartBalloon.jpg" width="100%"></a><br><sub><b>HeartBalloon</b><br><code>models/ServerStorage/Items/Pets/HeartBalloon.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Lobby/MainLobby/Model__x112.rbxm"><img src="screenshots/thumbs/models/07_Model_x112.jpg" width="100%"></a><br><sub><b>Model__x112</b><br><code>models/ServerStorage/Lobby/MainLobby/Model__x112.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/Karachi/Map/Car.rbxm"><img src="screenshots/thumbs/models/08_Car.jpg" width="100%"></a><br><sub><b>Car</b><br><code>models/ServerStorage/Maps/Karachi/Map/Car.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/Hospital3/Map/Parts/Floor1/XrayRoom/Keyboard.rbxm"><img src="screenshots/thumbs/models/09_Keyboard.jpg" width="100%"></a><br><sub><b>Keyboard</b><br><code>models/ServerStorage/Maps/Hospital3/Map/Parts/Floor1/XrayRoom/Keyboard.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Meshes_Eugene%20Wings%20of%20Devour%20Final_Meshpart2.rbxm"><img src="screenshots/thumbs/models/10_Meshes_Eugene_Wings_of_Devour_Final_Meshpart2.jpg" width="100%"></a><br><sub><b>Meshes_Eugene Wings of Devour Final_Meshpart2</b><br><code>models/Workspace/Meshes_Eugene Wings of Devour Final_Meshpart2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/Hospital3/Map/Parts/Floor1/XrayRoom/StaffOnlySign.rbxm"><img src="screenshots/thumbs/models/11_StaffOnlySign.jpg" width="100%"></a><br><sub><b>StaffOnlySign</b><br><code>models/ServerStorage/Maps/Hospital3/Map/Parts/Floor1/XrayRoom/StaffOnlySign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Handle~2.rbxm"><img src="screenshots/thumbs/models/12_Handle_2.jpg" width="100%"></a><br><sub><b>Handle~2</b><br><code>models/Workspace/Handle~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/Karachi/Map/Bl0x/Buildings.rbxm"><img src="screenshots/thumbs/models/13_Buildings.jpg" width="100%"></a><br><sub><b>Buildings</b><br><code>models/ServerStorage/Maps/Karachi/Map/Bl0x/Buildings.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Maps/ResearchFacility/Parts.rbxm"><img src="screenshots/thumbs/models/14_Parts.jpg" width="100%"></a><br><sub><b>Parts</b><br><code>models/ServerStorage/Maps/ResearchFacility/Parts.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>4524 lines</sub><br>[`KnifeLocal`](source/scripts/ServerStorage/GunScripts/KnifeLocal.client.lua) <sub>534 lines</sub><br>[`InteractiveScript`](source/scripts/ServerStorage/Maps/ResearchFacility/Interactive/GarageSystem/InteractiveBox/InteractiveScript.server.lua) <sub>39 lines</sub><br>[`InteractiveScript`](source/scripts/ServerStorage/Maps/ResearchFacility/Interactive/GarageSystem/InteractiveBox~2/InteractiveScript.server.lua) <sub>42 lines</sub><br>[`FloatAnimation`](source/scripts/Workspace/Handle~3/Eye/FloatAnimation.server.lua) <sub>85 lines</sub> |
| UI controllers / window managers / menus | [`RbxGui`](source/scripts/ReplicatedStorage/LoadLibrary/RbxGui.lua) <sub>4207 lines</sub><br>[`EventScript_Christmas2022`](source/scripts/ReplicatedStorage/GUI/MainPC/Misc/EventScript_Christmas2022.client.lua) <sub>383 lines</sub><br>[`EventScript_Halloween2021`](source/scripts/ServerStorage/EventScript_Halloween2021.client.lua) <sub>389 lines</sub><br>[`EventScript_Halloween2021`](source/scripts/ReplicatedStorage/GUI/MainMobile/Menu/EventScript_Halloween2021.client.lua) <sub>424 lines</sub><br>[`EventScript_Halloween2021`](source/scripts/ReplicatedStorage/GUI/MainPC/Misc/EventScript_Halloween2021.client.lua) <sub>429 lines</sub> |
| Notifications, toasts, popups, prompts | [`Chat`](source/scripts/ReplicatedStorage/GUI/MainMobile/Menu/Chat.client.lua) <sub>79 lines</sub><br>[`Game_Chat`](source/scripts/ReplicatedStorage/GUI/MainPC/Game_Chat.client.lua) <sub>247 lines</sub><br>[`InventoryOld`](source/scripts/ReplicatedStorage/GUI/MainPC/InventoryOld.client.lua) <sub>896 lines</sub><br>[`AdminCommands`](source/scripts/ServerScriptService/AdminCommands.server.lua) <sub>178 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/GUI/MainMobile/Lobby/Screens/Shop/Main/Packs/Client.client.lua) <sub>61 lines</sub> |
| Loading / intro screens | [`Loading`](source/scripts/ReplicatedFirst/Loading.client.lua) <sub>515 lines</sub><br>[`RbxGui`](source/scripts/ReplicatedStorage/LoadLibrary/RbxGui.lua) <sub>4207 lines</sub><br>[`RoleSelect`](source/scripts/ReplicatedStorage/GUI/MainMobile/GameFolder/RoleSelect.client.lua) <sub>237 lines</sub><br>[`Game_RoleSelector`](source/scripts/ReplicatedStorage/GUI/MainPC/Game_RoleSelector.client.lua) <sub>252 lines</sub><br>[`RoleSelector`](source/scripts/ReplicatedStorage/GUI/MainXbox/Game/RoleSelector.client.lua) <sub>189 lines</sub> |
| Camera, cutscenes, screen shake | [`Camera Blocker`](source/scripts/VoiceChatService/WhiteListService/Manager/Camera%20Blocker.client.lua) <sub>16 lines</sub><br>[`Module3D`](source/scripts/ReplicatedStorage/Module3D.lua) <sub>448 lines</sub> |
| VFX, particles, beams, hit effects | [`KnifeServer`](source/scripts/ServerStorage/GunScripts/KnifeServer.server.lua) <sub>534 lines</sub> |
| DataStore / player data | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>4524 lines</sub><br>[`GameScript`](source/scripts/ServerScriptService/GameScript.server.lua) <sub>623 lines</sub><br>[`WheelScript`](source/scripts/ServerScriptService/WheelScript.server.lua) <sub>179 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>4524 lines</sub><br>[`GameScript`](source/scripts/ServerScriptService/GameScript.server.lua) <sub>623 lines</sub><br>[`GamepassController`](source/scripts/ServerScriptService/GamepassController.server.lua) <sub>43 lines</sub><br>[`Shop_Data`](source/scripts/ReplicatedStorage/GUI/MainPC/Shop/Shop_Data.client.lua) <sub>1111 lines</sub><br>[`WheelScript`](source/scripts/ServerScriptService/WheelScript.server.lua) <sub>179 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`OpenCrate`](source/scripts/ReplicatedStorage/GUI/MainMobile/Menu/EventScript_Christmas2021/OpenCrate.lua) <sub>212 lines</sub><br>[`OpenCrate`](source/scripts/ReplicatedStorage/GUI/MainMobile/Menu/EventScript_Halloween2021/OpenCrate.lua) <sub>222 lines</sub><br>[`OpenCrate`](source/scripts/ReplicatedStorage/GUI/MainMobile/Shop/Shop_Data/OpenCrate.lua) <sub>212 lines</sub><br>[`OpenCrate`](source/scripts/ReplicatedStorage/GUI/MainPC/Misc/EventScript_Halloween2021/OpenCrate.lua) <sub>212 lines</sub><br>[`OpenCrate`](source/scripts/ReplicatedStorage/GUI/MainPC/Shop/Shop_Data/OpenCrate.lua) <sub>212 lines</sub> |
| Trading systems | [`TradePhone`](source/scripts/ReplicatedStorage/GUI/MainMobile/Menu/TradePhone.client.lua) <sub>599 lines</sub><br>[`Trade`](source/scripts/ReplicatedStorage/GUI/MainXbox/Menu/Trade.client.lua) <sub>558 lines</sub><br>[`Menu_Trade`](source/scripts/ReplicatedStorage/GUI/MainPC/Menu_Trade.client.lua) <sub>604 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`NPC Targeting Attack Script`](source/scripts/ServerStorage/Jadens%20map/Jadens%20Map/Model/Map/Background%20Stuff/Pond%20Turtle/E/RunAwayScript/NPC%20Targeting%20Attack%20Script.server.lua) <sub>52 lines</sub><br>[`FallDamage`](source/scripts/ServerStorage/Jadens%20map/Jadens%20Map/Model/Map/Background%20Stuff/Pond%20Turtle/E/FallDamage.server.lua) <sub>17 lines</sub> |
| NPC / AI / monsters | [`NPC Targeting Attack Script`](source/scripts/ServerStorage/Jadens%20map/Jadens%20Map/Model/Map/Background%20Stuff/Pond%20Turtle/E/RunAwayScript/NPC%20Targeting%20Attack%20Script.server.lua) <sub>52 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Animation`](source/scripts/ServerStorage/Jadens%20map/Jadens%20Map/Model/Map/Background%20Stuff/Pond%20Turtle/E/Animation.server.lua) <sub>561 lines</sub><br>[`LocalSound`](source/scripts/StarterPlayer/StarterCharacterScripts/Sound/LocalSound.client.lua) <sub>143 lines</sub><br>[`LocalSound`](source/scripts/Workspace/Premium/_/Sound/LocalSound.client.lua) <sub>399 lines</sub><br>[`SpeedTrail`](source/scripts/StarterPlayer/StarterCharacterScripts/SpeedTrail.server.lua) <sub>14 lines</sub><br>[`Sprint`](source/scripts/ReplicatedStorage/GUI/MainMobile/Inventory/PerkSystem/Sprint.lua) <sub>37 lines</sub> |
| Tycoon / plots / bases / building | [`Crafting_Data`](source/scripts/ReplicatedStorage/GUI/MainMobile/Inventory/Crafting_Data.client.lua) <sub>823 lines</sub><br>[`Christmas2022`](source/scripts/ReplicatedStorage/Modules/Christmas2022.lua) <sub>357 lines</sub><br>[`Crafting_Data`](source/scripts/ServerStorage/OldInventory/Crafting_Data.client.lua) <sub>841 lines</sub><br>[`EventScript_Summer2023`](source/scripts/ReplicatedStorage/GUI/MainMobile/Menu/EventScript_Summer2023.client.lua) <sub>486 lines</sub><br>[`Inventory_Data`](source/scripts/ReplicatedStorage/GUI/MainPC/Inventory/Inventory_Data.client.lua) <sub>807 lines</sub> |
| Leaderboards & stats | [`ChristmasLeaderboard`](source/scripts/ServerScriptService/Leaderboards/ChristmasLeaderboard.server.lua) <sub>19 lines</sub><br>[`GiftsLeaderboard`](source/scripts/ServerScriptService/Leaderboards/Christmas2021/GiftsLeaderboard.server.lua) <sub>12 lines</sub><br>[`TokensLeaderboard`](source/scripts/ServerScriptService/Leaderboards/Christmas2021/TokensLeaderboard.server.lua) <sub>12 lines</sub><br>[`TokensLeaderboard`](source/scripts/ServerScriptService/Summer2023Leaderboard/TokensLeaderboard.server.lua) <sub>12 lines</sub><br>[`GiftsLeaderboard`](source/scripts/ServerScriptService/Xmas2021Leaderboard/GiftsLeaderboard.server.lua) <sub>13 lines</sub> |
| Admin panels & commands | [`AdminCommands`](source/scripts/ServerScriptService/AdminCommands.server.lua) <sub>178 lines</sub> |
| Sound & music | [`LocalSound`](source/scripts/StarterPlayer/StarterCharacterScripts/Sound/LocalSound.client.lua) <sub>143 lines</sub><br>[`LocalSound`](source/scripts/Workspace/Premium/_/Sound/LocalSound.client.lua) <sub>399 lines</sub><br>[`MusicController`](source/scripts/ReplicatedStorage/GUI/MainMobile/GameFolder/MusicController.client.lua) <sub>71 lines</sub><br>[`Game_Music`](source/scripts/ReplicatedStorage/GUI/MainPC/Game_Music.client.lua) <sub>21 lines</sub> |
| Daily rewards, quests, codes, playtime | [`DataModule`](source/scripts/ServerScriptService/GameScript/DataModule.lua) <sub>4524 lines</sub><br>[`Inventory_Data`](source/scripts/ReplicatedStorage/GUI/MainPC/Inventory/Inventory_Data.client.lua) <sub>807 lines</sub><br>[`Inventory_Data`](source/scripts/ReplicatedStorage/GUI/MainMobile/Inventory/Inventory_Data.client.lua) <sub>1054 lines</sub><br>[`CodeGenerator`](source/scripts/ServerScriptService/CodeGenerator.server.lua) <sub>113 lines</sub><br>[`Inventory_Data`](source/scripts/ServerStorage/OldInventory/Inventory_Data.client.lua) <sub>562 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`RbxUtility`](source/scripts/ReplicatedStorage/LoadLibrary/RbxUtility.lua) <sub>1109 lines</sub><br>[`Janitor`](source/scripts/Workspace/Handle~3/Eye/FloatAnimation/Janitor.lua) <sub>637 lines</sub><br>[`Christmas2022`](source/scripts/ReplicatedStorage/Modules/Christmas2022.lua) <sub>357 lines</sub><br>[`GridCreator`](source/scripts/ReplicatedStorage/Modules/GridCreator.lua) <sub>192 lines</sub><br>[`Christmas2021`](source/scripts/ReplicatedStorage/Modules/Christmas2021.lua) <sub>511 lines</sub> |

### In the curated script library

- [RequestQueueSize loading + join menu](../../Scripts/04-Loading-Screens/QueueLoadingAndJoinMenu__murder-mystery-2.lua) — Classic MM2 loading flow: waits on ContentProvider.RequestQueueSize ('N objects left'), shows Skip after 7 s, waits for character and server data, picks PC/Mobile/Xbox main GUI, fades out, then shows a join-a-friend menu.
- [Death effect module](../../Scripts/06-VFX/LightningDeathEffect__murder-mystery-2.lua) — Cosmetic death effect as a function(char) module (how MM2 stores death effects).

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ServerScriptService/Adonis_Loader/Config/Plugins/Server_ Adonis Discord Logging.lua`
- `scripts/ServerScriptService/Giver.server.lua`
- `scripts/ServerScriptService/GiverServer.server.lua`
- `scripts/ServerScriptService/Leaderboards/ReaverLeaderboard.server.lua`
- `scripts/ServerScriptService/ReaverLeaderboard.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
