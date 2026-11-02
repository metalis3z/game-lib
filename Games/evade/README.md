# "Evade" (brainrot game)

> 🧠 **Brainrot** · steal / tycoon (brainrots, lucky blocks; file named Evade) · source file `Evade_New-UPD.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/36_SantaMerchant__SantaMerchant.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 40 ScreenGuis, 2138 GUI objects → **76 screenshots** |
| Models (.rbxm) | 5340 models, 167 model sets, 13 VFX sets |
| Lua builders (.lua) | 103 UI screens, 355 animation packs, 45 audio packs |
| Code | 1551 scripts, 171,423 lines |
| Asset ids | 877 animations, 780 sounds |
| Safety scan | 272 HIGH / 45 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×391, `SourceSansPro Bold`×192, `GothamSSm Bold`×131, `FredokaOne Regular`×97, `GothamSSm Heavy`×73

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_Shop__Shop.jpg"><img src="screenshots/thumbs/04_Shop__Shop.jpg" width="100%"></a><br><sub><b>Shop</b> › Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_CoinsShop__CoinsShop.jpg"><img src="screenshots/thumbs/07_CoinsShop__CoinsShop.jpg" width="100%"></a><br><sub><b>CoinsShop</b> › CoinsShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_RodsShop__RodsShop.jpg"><img src="screenshots/thumbs/19_RodsShop__RodsShop.jpg" width="100%"></a><br><sub><b>RodsShop</b> › RodsShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_SantaMerchant__SantaMerchant.jpg"><img src="screenshots/thumbs/25_SantaMerchant__SantaMerchant.jpg" width="100%"></a><br><sub><b>SantaMerchant</b> › SantaMerchant</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_Merchant__Merchant.jpg"><img src="screenshots/thumbs/26_Merchant__Merchant.jpg" width="100%"></a><br><sub><b>Merchant</b> › Merchant</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_CoinsShop__CoinsShop.jpg"><img src="screenshots/thumbs/34_CoinsShop__CoinsShop.jpg" width="100%"></a><br><sub><b>CoinsShop</b> › CoinsShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_SantaMerchant__SantaMerchant.jpg"><img src="screenshots/thumbs/36_SantaMerchant__SantaMerchant.jpg" width="100%"></a><br><sub><b>SantaMerchant</b> › SantaMerchant</sub></td>
<td width="33%" valign="top"><a href="screenshots/52_RodsShop__RodsShop.jpg"><img src="screenshots/thumbs/52_RodsShop__RodsShop.jpg" width="100%"></a><br><sub><b>RodsShop</b> › RodsShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_Shop__Shop.jpg"><img src="screenshots/thumbs/58_Shop__Shop.jpg" width="100%"></a><br><sub><b>Shop</b> › Shop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_FakePurchases__Shop.jpg"><img src="screenshots/thumbs/62_FakePurchases__Shop.jpg" width="100%"></a><br><sub><b>FakePurchases</b> › Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/66_FakePurchases__RobuxButton.jpg"><img src="screenshots/thumbs/66_FakePurchases__RobuxButton.jpg" width="100%"></a><br><sub><b>FakePurchases</b> › Shop.RobuxButton</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_FakePurchases__Content.jpg"><img src="screenshots/thumbs/67_FakePurchases__Content.jpg" width="100%"></a><br><sub><b>FakePurchases</b> › Shop.Content</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_BackpackGui.jpg"><img src="screenshots/thumbs/13_BackpackGui.jpg" width="100%"></a><br><sub><b>BackpackGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_BackpackGui__Inventory.jpg"><img src="screenshots/thumbs/14_BackpackGui__Inventory.jpg" width="100%"></a><br><sub><b>BackpackGui</b> › Backpack.Inventory</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_GiftPlayer__GiftPlayer_.jpg"><img src="screenshots/thumbs/09_GiftPlayer__GiftPlayer_.jpg" width="100%"></a><br><sub><b>GiftPlayer</b> › GiftPlayer_</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_GiftPlayer__GiftPlayer.jpg"><img src="screenshots/thumbs/10_GiftPlayer__GiftPlayer.jpg" width="100%"></a><br><sub><b>GiftPlayer</b> › GiftPlayer</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_AdventCalendar__Frame.jpg"><img src="screenshots/thumbs/21_AdventCalendar__Frame.jpg" width="100%"></a><br><sub><b>AdventCalendar</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/32_AdventCalendar__Frame.jpg"><img src="screenshots/thumbs/32_AdventCalendar__Frame.jpg" width="100%"></a><br><sub><b>AdventCalendar</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_GiftPlayer__GiftPlayer.jpg"><img src="screenshots/thumbs/35_GiftPlayer__GiftPlayer.jpg" width="100%"></a><br><sub><b>GiftPlayer</b> › GiftPlayer</sub></td>
<td width="33%" valign="top"><a href="screenshots/38_GalaxyWheel__Wheel.jpg"><img src="screenshots/thumbs/38_GalaxyWheel__Wheel.jpg" width="100%"></a><br><sub><b>GalaxyWheel</b> › Wheel</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_GalaxyWheel__Buttons.jpg"><img src="screenshots/thumbs/39_GalaxyWheel__Buttons.jpg" width="100%"></a><br><sub><b>GalaxyWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_YinYangWheel__Wheel.jpg"><img src="screenshots/thumbs/47_YinYangWheel__Wheel.jpg" width="100%"></a><br><sub><b>YinYangWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_YinYangWheel__Buttons.jpg"><img src="screenshots/thumbs/48_YinYangWheel__Buttons.jpg" width="100%"></a><br><sub><b>YinYangWheel</b> › Buttons</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/50_RadioactiveWheel__Buttons.jpg"><img src="screenshots/thumbs/50_RadioactiveWheel__Buttons.jpg" width="100%"></a><br><sub><b>RadioactiveWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/51_RadioactiveWheel__Wheel.jpg"><img src="screenshots/thumbs/51_RadioactiveWheel__Wheel.jpg" width="100%"></a><br><sub><b>RadioactiveWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_ChristmasWheel__Buttons.jpg"><img src="screenshots/thumbs/55_ChristmasWheel__Buttons.jpg" width="100%"></a><br><sub><b>ChristmasWheel</b> › Buttons</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/56_ChristmasWheel__Wheel.jpg"><img src="screenshots/thumbs/56_ChristmasWheel__Wheel.jpg" width="100%"></a><br><sub><b>ChristmasWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/59_CursedWheel__Wheel.jpg"><img src="screenshots/thumbs/59_CursedWheel__Wheel.jpg" width="100%"></a><br><sub><b>CursedWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_CursedWheel__Buttons.jpg"><img src="screenshots/thumbs/60_CursedWheel__Buttons.jpg" width="100%"></a><br><sub><b>CursedWheel</b> › Buttons</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_Rebirth__Rebirth.jpg"><img src="screenshots/thumbs/02_Rebirth__Rebirth.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/29_Rebirth__Rebirth.jpg"><img src="screenshots/thumbs/29_Rebirth__Rebirth.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_Index__Progress.jpg"><img src="screenshots/thumbs/30_Index__Progress.jpg" width="100%"></a><br><sub><b>Index</b> › Progress</sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_BrainrotTrader.jpg"><img src="screenshots/thumbs/33_BrainrotTrader.jpg" width="100%"></a><br><sub><b>BrainrotTrader</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Settings__Settings.jpg"><img src="screenshots/thumbs/03_Settings__Settings.jpg" width="100%"></a><br><sub><b>Settings</b> › Settings</sub></td>
<td width="33%" valign="top"><a href="screenshots/49_Settings__Settings.jpg"><img src="screenshots/thumbs/49_Settings__Settings.jpg" width="100%"></a><br><sub><b>Settings</b> › Settings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_BackpackGui__GamepadHintsFrame.jpg"><img src="screenshots/thumbs/15_BackpackGui__GamepadHintsFrame.jpg" width="100%"></a><br><sub><b>BackpackGui</b> › Backpack.GamepadHintsFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_Confirmation__Template.jpg"><img src="screenshots/thumbs/16_Confirmation__Template.jpg" width="100%"></a><br><sub><b>Confirmation</b> › Template</sub></td>
<td width="33%" valign="top"><a href="screenshots/41_Confirmation__Template.jpg"><img src="screenshots/thumbs/41_Confirmation__Template.jpg" width="100%"></a><br><sub><b>Confirmation</b> › Template</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_TopbarStandard.jpg"><img src="screenshots/thumbs/23_TopbarStandard.jpg" width="100%"></a><br><sub><b>TopbarStandard</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_TopbarStandardClipped.jpg"><img src="screenshots/thumbs/24_TopbarStandardClipped.jpg" width="100%"></a><br><sub><b>TopbarStandardClipped</b></sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_StockMachine__StockMachine.jpg"><img src="screenshots/thumbs/05_StockMachine__StockMachine.jpg" width="100%"></a><br><sub><b>StockMachine</b> › StockMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_FuseMachine__FuseMachine.jpg"><img src="screenshots/thumbs/06_FuseMachine__FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b> › FuseMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_CraftingMachine__CraftingMachine.jpg"><img src="screenshots/thumbs/17_CraftingMachine__CraftingMachine.jpg" width="100%"></a><br><sub><b>CraftingMachine</b> › CraftingMachine</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_SingleStockMachine__SingleStockMachine.jpg"><img src="screenshots/thumbs/20_SingleStockMachine__SingleStockMachine.jpg" width="100%"></a><br><sub><b>SingleStockMachine</b> › SingleStockMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_CraftingMachine__CraftingMachine.jpg"><img src="screenshots/thumbs/42_CraftingMachine__CraftingMachine.jpg" width="100%"></a><br><sub><b>CraftingMachine</b> › CraftingMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/43_SingleStockMachine__SingleStockMachine.jpg"><img src="screenshots/thumbs/43_SingleStockMachine__SingleStockMachine.jpg" width="100%"></a><br><sub><b>SingleStockMachine</b> › SingleStockMachine</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/45_WitchingHourMachine__WitchingHourMachine.jpg"><img src="screenshots/thumbs/45_WitchingHourMachine__WitchingHourMachine.jpg" width="100%"></a><br><sub><b>WitchingHourMachine</b> › WitchingHourMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/53_FuseMachine__FuseMachine.jpg"><img src="screenshots/thumbs/53_FuseMachine__FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b> › FuseMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/54_StockMachine__StockMachine.jpg"><img src="screenshots/thumbs/54_StockMachine__StockMachine.jpg" width="100%"></a><br><sub><b>StockMachine</b> › StockMachine</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_AdminPanel__AdminPanel.jpg"><img src="screenshots/thumbs/46_AdminPanel__AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › AdminPanel</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_AdminSelection.jpg"><img src="screenshots/thumbs/61_AdminSelection.jpg" width="100%"></a><br><sub><b>AdminSelection</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/73_AdminSelection__Header.jpg"><img src="screenshots/thumbs/73_AdminSelection__Header.jpg" width="100%"></a><br><sub><b>AdminSelection</b> › Header</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/74_AdminSelection__Content.jpg"><img src="screenshots/thumbs/74_AdminSelection__Content.jpg" width="100%"></a><br><sub><b>AdminSelection</b> › Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/75_Admin__Header.jpg"><img src="screenshots/thumbs/75_Admin__Header.jpg" width="100%"></a><br><sub><b>Admin</b> › Header</sub></td>
<td width="33%" valign="top"><a href="screenshots/76_Admin__Content.jpg"><img src="screenshots/thumbs/76_Admin__Content.jpg" width="100%"></a><br><sub><b>Admin</b> › Content</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_LeftBottom.jpg"><img src="screenshots/thumbs/11_LeftBottom.jpg" width="100%"></a><br><sub><b>LeftBottom</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_LeftCenter.jpg"><img src="screenshots/thumbs/12_LeftCenter.jpg" width="100%"></a><br><sub><b>LeftCenter</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/27_LeftBottom.jpg"><img src="screenshots/thumbs/27_LeftBottom.jpg" width="100%"></a><br><sub><b>LeftBottom</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_Index__Main.jpg"><img src="screenshots/thumbs/31_Index__Main.jpg" width="100%"></a><br><sub><b>Index</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_LeftCenter.jpg"><img src="screenshots/thumbs/40_LeftCenter.jpg" width="100%"></a><br><sub><b>LeftCenter</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_VoiceChat__VoiceChat.jpg"><img src="screenshots/thumbs/01_VoiceChat__VoiceChat.jpg" width="100%"></a><br><sub><b>VoiceChat</b> › VoiceChat</sub></td>
<td width="33%" valign="top"><a href="screenshots/08_ActiveEvents.jpg"><img src="screenshots/thumbs/08_ActiveEvents.jpg" width="100%"></a><br><sub><b>ActiveEvents</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_SpookyLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/18_SpookyLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>SpookyLuckyBlock</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_FestiveLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/22_FestiveLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>FestiveLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_VoiceChat__VoiceChat.jpg"><img src="screenshots/thumbs/28_VoiceChat__VoiceChat.jpg" width="100%"></a><br><sub><b>VoiceChat</b> › VoiceChat</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_ActiveEvents.jpg"><img src="screenshots/thumbs/37_ActiveEvents.jpg" width="100%"></a><br><sub><b>ActiveEvents</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/44_Color__Template.jpg"><img src="screenshots/thumbs/44_Color__Template.jpg" width="100%"></a><br><sub><b>Color</b> › Template</sub></td>
<td width="33%" valign="top"><a href="screenshots/57_FestiveLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/57_FestiveLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>FestiveLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_StartNew.jpg"><img src="screenshots/thumbs/63_StartNew.jpg" width="100%"></a><br><sub><b>StartNew</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/64_Finish.jpg"><img src="screenshots/thumbs/64_Finish.jpg" width="100%"></a><br><sub><b>Finish</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/65_Start.jpg"><img src="screenshots/thumbs/65_Start.jpg" width="100%"></a><br><sub><b>Start</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_BaseManager__Header.jpg"><img src="screenshots/thumbs/68_BaseManager__Header.jpg" width="100%"></a><br><sub><b>BaseManager</b> › Header</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/69_BaseManager__Content.jpg"><img src="screenshots/thumbs/69_BaseManager__Content.jpg" width="100%"></a><br><sub><b>BaseManager</b> › Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/70_Saving__Saving.jpg"><img src="screenshots/thumbs/70_Saving__Saving.jpg" width="100%"></a><br><sub><b>Saving</b> › Saving</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_Teleport__Header.jpg"><img src="screenshots/thumbs/71_Teleport__Header.jpg" width="100%"></a><br><sub><b>Teleport</b> › Header</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/72_Teleport__Content.jpg"><img src="screenshots/thumbs/72_Teleport__Content.jpg" width="100%"></a><br><sub><b>Teleport</b> › Content</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/EventService/Events/Graveyard/BrainrotGravestones/BrainrotGrave9__x10.rbxm"><img src="screenshots/thumbs/models/01_BrainrotGrave9_x10.jpg" width="100%"></a><br><sub><b>BrainrotGrave9__x10</b><br><code>models/ServerScriptService/Services/EventService/Events/Graveyard/BrainrotGravestones/BrainrotGrave9__x10.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Events/Winter%20Hour/Model.rbxm"><img src="screenshots/thumbs/models/02_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/Workspace/Events/Winter Hour/Model.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Skins/Candy/ThirdFloor.rbxm"><img src="screenshots/thumbs/models/03_ThirdFloor.jpg" width="100%"></a><br><sub><b>ThirdFloor</b><br><code>models/ServerStorage/Skins/Candy/ThirdFloor.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/Rap%20Concert/VFX/VFXDisco.rbxm"><img src="screenshots/thumbs/models/04_VFXDisco.jpg" width="100%"></a><br><sub><b>VFXDisco</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/Rap Concert/VFX/VFXDisco.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/EventService/Events/Phase%203_%20Sammy%27s%20Base/SammyBase.rbxm"><img src="screenshots/thumbs/models/05_SammyBase.jpg" width="100%"></a><br><sub><b>SammyBase</b><br><code>models/ServerScriptService/Services/EventService/Events/Phase 3_ Sammy's Base/SammyBase.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Rainbowrath%20Sword.rbxm"><img src="screenshots/thumbs/models/06_Rainbowrath_Sword.jpg" width="100%"></a><br><sub><b>Rainbowrath Sword</b><br><code>models/ReplicatedStorage/Items/Rainbowrath Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/NewYearsMachine.rbxm"><img src="screenshots/thumbs/models/07_NewYearsMachine.jpg" width="100%"></a><br><sub><b>NewYearsMachine</b><br><code>models/Workspace/NewYearsMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/ItemController/RadioactiveAirstrikeController/F22%20Bombing%20Jet.rbxm"><img src="screenshots/thumbs/models/08_F22_Bombing_Jet.jpg" width="100%"></a><br><sub><b>F22 Bombing Jet</b><br><code>models/ReplicatedStorage/Controllers/ItemController/RadioactiveAirstrikeController/F22 Bombing Jet.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/Matteo/RainbowTrees/Tree3.rbxm"><img src="screenshots/thumbs/models/09_Tree3.jpg" width="100%"></a><br><sub><b>Tree3</b><br><code>models/ReplicatedStorage/Models/Events/Matteo/RainbowTrees/Tree3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/North%20Pole/EntranceSign.rbxm"><img src="screenshots/thumbs/models/10_EntranceSign.jpg" width="100%"></a><br><sub><b>EntranceSign</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/North Pole/EntranceSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Huge%20Tree.rbxm"><img src="screenshots/thumbs/models/11_Huge_Tree.jpg" width="100%"></a><br><sub><b>Huge Tree</b><br><code>models/ReplicatedStorage/Items/Huge Tree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/Brazil/Stage/FavelaDecoration/BackGroundFavela~4/Casinha3__x6.rbxm"><img src="screenshots/thumbs/models/12_Casinha3_x6.jpg" width="100%"></a><br><sub><b>Casinha3__x6</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/Brazil/Stage/FavelaDecoration/BackGroundFavela~4/Casinha3__x6.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerStorage/Developmental%20Assets/Modded/Resources/Models/Overhead.rbxm"><img src="screenshots/thumbs/models/13_Overhead.jpg" width="100%"></a><br><sub><b>Overhead</b><br><code>models/ServerStorage/Developmental Assets/Modded/Resources/Models/Overhead.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/TraitsPerAnimal/Reindeer%20Pet/Noo%20My%20Candy.rbxm"><img src="screenshots/thumbs/models/14_Noo_My_Candy.jpg" width="100%"></a><br><sub><b>Noo My Candy</b><br><code>models/ReplicatedStorage/Models/TraitsPerAnimal/Reindeer Pet/Noo My Candy.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`AnimatedButton`](source/scripts/ReplicatedStorage/Classes/AnimatedButton.lua) <sub>118 lines</sub><br>[`SkullEmojiEffectController`](source/scripts/ReplicatedStorage/Controllers/SkullEmojiEffectController.lua) <sub>164 lines</sub><br>[`FishingRodClient`](source/scripts/ReplicatedStorage/ClientToolScripts/FishingRodClient.server.lua) <sub>410 lines</sub><br>[`Controller`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/Controller.server.lua) <sub>471 lines</sub><br>[`FakePurchase (SOURCE)`](source/scripts/ServerScriptService/Fake%20Purchases/FakePurchase%20%28SOURCE%29.server.lua) <sub>625 lines</sub> |
| UI controllers / window managers / menus | [`Window`](source/scripts/ServerScriptService/Cmdr/CmdrClient/CmdrInterface/Window.lua) <sub>337 lines</sub><br>[`SpectateController`](source/scripts/ServerScriptService/Controllers/SpectateController.lua) <sub>239 lines</sub><br>[`ShopController`](source/scripts/ReplicatedStorage/Controllers/ShopController.lua) <sub>1027 lines</sub><br>[`FakePurchase (SOURCE)`](source/scripts/ServerScriptService/Fake%20Purchases/FakePurchase%20%28SOURCE%29.server.lua) <sub>625 lines</sub><br>[`FakePurchase`](source/scripts/ServerScriptService/Fake%20Purchases/FakePurchase.lua) <sub>625 lines</sub> |
| Notifications, toasts, popups, prompts | [`servermessage`](source/scripts/ServerScriptService/Services/CommandsService/Commands/servermessage.lua) <sub>37 lines</sub><br>[`Announcement`](source/scripts/ServerStorage/Developmental%20Assets/Modded/Resources/Guis/Admin/Admin/Content/CanvasGroup/List/Announcement.client.lua) <sub>25 lines</sub><br>[`AuraBoat`](source/scripts/ServerScriptService/Services/EventService/Events/AuraBoat.lua) <sub>388 lines</sub><br>[`Karkerkar Kurkur`](source/scripts/ServerScriptService/Services/EventService/Events/Karkerkar%20Kurkur.lua) <sub>470 lines</sub><br>[`e`](source/scripts/Workspace/e.lua) <sub>1275 lines</sub> |
| Loading / intro screens | [`FakePurchase (SOURCE)`](source/scripts/ServerScriptService/Fake%20Purchases/FakePurchase%20%28SOURCE%29.server.lua) <sub>625 lines</sub><br>[`FakePurchase`](source/scripts/ServerScriptService/Fake%20Purchases/FakePurchase.lua) <sub>625 lines</sub><br>[`Graveyard`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Graveyard.lua) <sub>305 lines</sub><br>[`PoleGameController`](source/scripts/ReplicatedStorage/Controllers/PoleGameController.lua) <sub>134 lines</sub><br>[`Dul Dul Dul`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Dul%20Dul%20Dul.lua) <sub>395 lines</sub> |
| Camera, cutscenes, screen shake | [`ShakePresets`](source/scripts/ReplicatedStorage/Shared/ShakePresets.lua) <sub>115 lines</sub><br>[`FishingRodClient`](source/scripts/ReplicatedStorage/ClientToolScripts/FishingRodClient.server.lua) <sub>410 lines</sub><br>[`Controller`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/Controller.server.lua) <sub>471 lines</sub><br>[`CameraShake`](source/scripts/ReplicatedStorage/Client/CameraShake.server.lua) <sub>22 lines</sub><br>[`CameraController`](source/scripts/ReplicatedStorage/Controllers/CameraController.lua) <sub>52 lines</sub> |
| VFX, particles, beams, hit effects | [`Controller`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/Controller.server.lua) <sub>471 lines</sub><br>[`Items`](source/scripts/ReplicatedStorage/Datas/Items.lua) <sub>881 lines</sub><br>[`PoleGameController`](source/scripts/ReplicatedStorage/Controllers/PoleGameController.lua) <sub>134 lines</sub><br>[`GraveyardTomb`](source/scripts/ServerScriptService/GraveyardTomb.server.lua) <sub>177 lines</sub><br>[`SkullEmojiEffectController`](source/scripts/ReplicatedStorage/Controllers/SkullEmojiEffectController.lua) <sub>164 lines</sub> |
| DataStore / player data | [`ProfileStore`](source/scripts/ServerScriptService/Controllers/ProfileStore.lua) <sub>2243 lines</sub><br>[`DataService`](source/scripts/ServerScriptService/Services/DataService.lua) <sub>160 lines</sub><br>[`AdminPanel`](source/scripts/ServerScriptService/Modded/AdminPanel.lua) <sub>1316 lines</sub><br>[`DataManagment`](source/scripts/ServerScriptService/Services/DataManagment.lua) <sub>1080 lines</sub><br>[`AdminPanel`](source/scripts/ServerStorage/Developmental%20Assets/Modded/AdminPanel.lua) <sub>974 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ShopService`](source/scripts/ServerScriptService/Services/ShopService.lua) <sub>414 lines</sub><br>[`MerchShopService`](source/scripts/ServerScriptService/Services/MerchShopService.lua) <sub>232 lines</sub><br>[`ShopController`](source/scripts/ReplicatedStorage/Controllers/ShopController.lua) <sub>1027 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`RadioactiveSpinwheelService`](source/scripts/ServerScriptService/Services/RadioactiveSpinwheelService.server.lua) <sub>241 lines</sub><br>[`RadioactiveSpinwheelService`](source/scripts/Workspace/RadioactiveSpinwheelService.server.lua) <sub>241 lines</sub><br>[`CursedSpinWheelService`](source/scripts/ServerScriptService/Services/CursedSpinWheelService.lua) <sub>163 lines</sub><br>[`ChristmasSpinwheelService`](source/scripts/ServerScriptService/Services/ChristmasSpinwheelService.server.lua) <sub>159 lines</sub><br>[`RadioactiveEventService`](source/scripts/ServerScriptService/Services/RadioactiveEventService.lua) <sub>124 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Controller`](source/scripts/ReplicatedStorage/Items/Rainbowrath%20Sword/Controller.server.lua) <sub>198 lines</sub><br>[`PlotService`](source/scripts/ServerScriptService/Services/PlotService.lua) <sub>1229 lines</sub><br>[`Solar Flare`](source/scripts/ServerScriptService/Services/EventService/Events/Solar%20Flare.lua) <sub>227 lines</sub><br>[`PlotClient`](source/scripts/ReplicatedStorage/Classes/PlotClient.lua) <sub>820 lines</sub><br>[`Controller~2`](source/scripts/ReplicatedStorage/Items/Rainbowrath%20Sword/Controller~2.server.lua) <sub>140 lines</sub> |
| NPC / AI / monsters | [`AnimalService`](source/scripts/ServerScriptService/Services/AnimalService.lua) <sub>1342 lines</sub><br>[`AnimalService olf`](source/scripts/Workspace/AnimalService%20olf.lua) <sub>1342 lines</sub><br>[`3 Roads`](source/scripts/ServerScriptService/Services/EventService/Events/3%20Roads.lua) <sub>805 lines</sub><br>[`e`](source/scripts/Workspace/e.lua) <sub>1275 lines</sub><br>[`Dul Dul Dul`](source/scripts/ServerScriptService/Services/EventService/Events/Dul%20Dul%20Dul.lua) <sub>368 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`TemuSword`](source/scripts/ReplicatedStorage/Items/Rainbowrath%20Sword/TemuSword.client.lua) <sub>58 lines</sub><br>[`Controller`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/Controller.server.lua) <sub>471 lines</sub> |
| Tycoon / plots / bases / building | [`PlotClient`](source/scripts/ReplicatedStorage/Classes/PlotClient.lua) <sub>820 lines</sub><br>[`Hide Base Manager Button`](source/scripts/ServerStorage/Developmental%20Assets/Modded/Resources/Guis/BaseManager/BaseManager/Content/CanvasGroup/List/Hide%20Base%20Manager%20Button.client.lua) <sub>39 lines</sub><br>[`PlotService`](source/scripts/ServerScriptService/Services/PlotService.lua) <sub>1229 lines</sub><br>[`Phase 3_ Sammy's Base`](source/scripts/ServerScriptService/Services/EventService/Events/Phase%203_%20Sammy%27s%20Base.lua) <sub>302 lines</sub><br>[`Unstealable Pets`](source/scripts/ServerStorage/Developmental%20Assets/Modded/Resources/Guis/BaseManager/BaseManager/Content/CanvasGroup/List/Unstealable%20Pets.client.lua) <sub>155 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/Services/LeaderboardService.lua) <sub>185 lines</sub> |
| Admin panels & commands | [`CommandsService`](source/scripts/ServerScriptService/Services/CommandsService.lua) <sub>156 lines</sub><br>[`AdminPanel`](source/scripts/ServerScriptService/Modded/AdminPanel.lua) <sub>1316 lines</sub><br>[`AdminPanel`](source/scripts/ServerStorage/Developmental%20Assets/Modded/AdminPanel.lua) <sub>974 lines</sub> |
| Sound & music | [`SoundController`](source/scripts/ReplicatedStorage/Controllers/SoundController.lua) <sub>317 lines</sub><br>[`DualAudio`](source/scripts/ReplicatedStorage/Components/DualAudio.lua) <sub>49 lines</sub><br>[`Karkerkar Kurkur`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Karkerkar%20Kurkur.lua) <sub>321 lines</sub> |
| Daily rewards, quests, codes, playtime | [`DataManagment`](source/scripts/ServerScriptService/Services/DataManagment.lua) <sub>1080 lines</sub><br>[`PlotService`](source/scripts/ServerScriptService/Services/PlotService.lua) <sub>1229 lines</sub><br>[`MerchShopService`](source/scripts/ServerScriptService/Services/MerchShopService.lua) <sub>232 lines</sub><br>[`YinYangEventController`](source/scripts/ReplicatedStorage/Controllers/YinYangEventController.lua) <sub>321 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Graveyard`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Graveyard.lua) <sub>305 lines</sub><br>[`AdminPanel`](source/scripts/ServerScriptService/Modded/AdminPanel.lua) <sub>1316 lines</sub><br>[`StealService`](source/scripts/ServerScriptService/Services/StealService.lua) <sub>724 lines</sub><br>[`StealService`](source/scripts/Workspace/StealService.lua) <sub>724 lines</sub><br>[`TimeUtils`](source/scripts/ReplicatedStorage/Utils/TimeUtils.lua) <sub>109 lines</sub> |

### In the curated script library

- [Conch console: one module per command](../../Scripts/16-Admin/CommandsService-ConchLoader__evade.lua) — Loads every ModuleScript in a Commands folder into the Conch console, gives the super-user role to permitted players and sends them the command list.
- [Permission check: user ids or group rank](../../Scripts/16-Admin/ConsolePermissions__evade.lua) — hasPermission(player): true if the UserId is in Config.AllowedUserIds or the player's rank in Config.GroupId is at least MinGroupRank.
- [Spectate next/previous](../../Scripts/05-Camera-Cutscene/SpectateCycle__evade.lua) — The simplest spectate: cycle Camera.CameraSubject through a player list.
- [Wandering swarm event](../../Scripts/12-NPC-AI/WanderSwarmEvent__evade.lua) — Timed event that spawns 20-30 small NPCs at wander points, moves each with SimplePath (path Costs avoid water/lava), picks a new random point after Reached, swaps idle/walk animations from Humanoid.Running, and scans a box around each NPC to apply a trait to nearby targets.
- [Event spin wheel (server)](../../Scripts/09-RNG-Gacha-Pets/SpinWheelService__evade.lua) — Server spin wheel: weighted reward with alternate reward if already owned, per-player cooldown, spin tokens given out by a UTC-scheduled event, reward applied after the client animation delay.
- [Steal start / cancel / complete service](../../Scripts/14-Tycoon-Plots/StealService__evade.lua) — Server side of a Steal-a-Brainrot style steal: StartSteal marks the victim's podium as being stolen, welds the animal model in front of the thief, slows them to 75% speed and plays a carry...
- [Steal-game plot service (assign, lock, steal remote, income)](../../Scripts/14-Tycoon-Plots/PlotService__evade.lua) — Full plot/base service for a steal game: hands out free plots, syncs the podium list to a per-plot replicated channel, 30s spawn grace lock, LockBase (timed laser lock that grows with rebirths and...

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`
- `scripts/ReplicatedStorage/Controllers/NewYearsMachineController.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
