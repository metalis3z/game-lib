# Steal a Brainrot

> 🧠 **Brainrot** · steal / tycoon (brainrots, plots) · source file `Steal a badr (Kaizou scameur !!!).rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/07_Shop__Shop.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 77 ScreenGuis, 3653 GUI objects → **75 screenshots** |
| Models (.rbxm) | 9586 models, 283 model sets, 17 VFX sets |
| Lua builders (.lua) | 118 UI screens, 569 animation packs, 86 audio packs |
| Code | 1630 scripts, 232,663 lines |
| Asset ids | 1548 animations, 853 sounds |
| Safety scan | 9 HIGH / 15 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×695, `GothamSSm Bold`×265, `SourceSansPro Bold`×147, `GothamSSm Heavy`×129, `FredokaOne Regular`×102

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_Shop__Shop.jpg"><img src="screenshots/thumbs/07_Shop__Shop.jpg" width="100%"></a><br><sub><b>Shop</b> › Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/15_SantaMerchant__SantaMerchant.jpg"><img src="screenshots/thumbs/15_SantaMerchant__SantaMerchant.jpg" width="100%"></a><br><sub><b>SantaMerchant</b> › SantaMerchant</sub></td>
<td width="33%" valign="top"><a href="screenshots/21_Merchant__Merchant.jpg"><img src="screenshots/thumbs/21_Merchant__Merchant.jpg" width="100%"></a><br><sub><b>Merchant</b> › Merchant</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_FantaisieShop__FantaisieShop.jpg"><img src="screenshots/thumbs/27_FantaisieShop__FantaisieShop.jpg" width="100%"></a><br><sub><b>FantaisieShop</b> › FantaisieShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/53_ValentinesShop__ValentinesShop.jpg"><img src="screenshots/thumbs/53_ValentinesShop__ValentinesShop.jpg" width="100%"></a><br><sub><b>ValentinesShop</b> › ValentinesShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_CoinsShop__CoinsShop.jpg"><img src="screenshots/thumbs/55_CoinsShop__CoinsShop.jpg" width="100%"></a><br><sub><b>CoinsShop</b> › CoinsShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/73_ItemShopGui.jpg"><img src="screenshots/thumbs/73_ItemShopGui.jpg" width="100%"></a><br><sub><b>ItemShopGui</b></sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_Glossary__Traits.jpg"><img src="screenshots/thumbs/30_Glossary__Traits.jpg" width="100%"></a><br><sub><b>Glossary</b> › Right.Traits</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_DivineWheel__Buttons.jpg"><img src="screenshots/thumbs/09_DivineWheel__Buttons.jpg" width="100%"></a><br><sub><b>DivineWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_DivineWheel__Wheel.jpg"><img src="screenshots/thumbs/10_DivineWheel__Wheel.jpg" width="100%"></a><br><sub><b>DivineWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_RadioactiveWheel__Buttons.jpg"><img src="screenshots/thumbs/18_RadioactiveWheel__Buttons.jpg" width="100%"></a><br><sub><b>RadioactiveWheel</b> › Buttons</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_RadioactiveWheel__Wheel.jpg"><img src="screenshots/thumbs/19_RadioactiveWheel__Wheel.jpg" width="100%"></a><br><sub><b>RadioactiveWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/26_GiftPlayer__GiftPlayer.jpg"><img src="screenshots/thumbs/26_GiftPlayer__GiftPlayer.jpg" width="100%"></a><br><sub><b>GiftPlayer</b> › GiftPlayer</sub></td>
<td width="33%" valign="top"><a href="screenshots/38_AdventCalendar__Frame.jpg"><img src="screenshots/thumbs/38_AdventCalendar__Frame.jpg" width="100%"></a><br><sub><b>AdventCalendar</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_ChristmasWheel__Buttons.jpg"><img src="screenshots/thumbs/40_ChristmasWheel__Buttons.jpg" width="100%"></a><br><sub><b>ChristmasWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/41_ChristmasWheel__Wheel.jpg"><img src="screenshots/thumbs/41_ChristmasWheel__Wheel.jpg" width="100%"></a><br><sub><b>ChristmasWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_CursedWheel__Wheel.jpg"><img src="screenshots/thumbs/42_CursedWheel__Wheel.jpg" width="100%"></a><br><sub><b>CursedWheel</b> › Wheel</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/50_CyberWheel__Wheel.jpg"><img src="screenshots/thumbs/50_CyberWheel__Wheel.jpg" width="100%"></a><br><sub><b>CyberWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/51_CyberWheel__Buttons.jpg"><img src="screenshots/thumbs/51_CyberWheel__Buttons.jpg" width="100%"></a><br><sub><b>CyberWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/54_Codes__Codes.jpg"><img src="screenshots/thumbs/54_Codes__Codes.jpg" width="100%"></a><br><sub><b>Codes</b> › Codes</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/56_ValentinesSendGift__ValentinesSendGift.jpg"><img src="screenshots/thumbs/56_ValentinesSendGift__ValentinesSendGift.jpg" width="100%"></a><br><sub><b>ValentinesSendGift</b> › ValentinesSendGift</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_Rebirth__Content.jpg"><img src="screenshots/thumbs/17_Rebirth__Content.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_TsunamiSpeedUpgrade__TsunamiSpeedUpgrade.jpg"><img src="screenshots/thumbs/32_TsunamiSpeedUpgrade__TsunamiSpeedUpgrade.jpg" width="100%"></a><br><sub><b>TsunamiSpeedUpgrade</b> › TsunamiSpeedUpgrade</sub></td>
<td width="33%" valign="top"><a href="screenshots/59_BackroomsSpeedUpgrade__BackroomsSpeedUpgrade.jpg"><img src="screenshots/thumbs/59_BackroomsSpeedUpgrade__BackroomsSpeedUpgrade.jpg" width="100%"></a><br><sub><b>BackroomsSpeedUpgrade</b> › BackroomsSpeedUpgrade</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/75_Index__Progress.jpg"><img src="screenshots/thumbs/75_Index__Progress.jpg" width="100%"></a><br><sub><b>Index</b> › Progress</sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/35_BrainrotTrader__Frame.jpg"><img src="screenshots/thumbs/35_BrainrotTrader__Frame.jpg" width="100%"></a><br><sub><b>BrainrotTrader</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/36_BrainrotTrader__Odds.jpg"><img src="screenshots/thumbs/36_BrainrotTrader__Odds.jpg" width="100%"></a><br><sub><b>BrainrotTrader</b> › Odds</sub></td>
<td width="33%" valign="top"><a href="screenshots/70_TradePlayerList.jpg"><img src="screenshots/thumbs/70_TradePlayerList.jpg" width="100%"></a><br><sub><b>TradePlayerList</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/72_TradeLiveTrade.jpg"><img src="screenshots/thumbs/72_TradeLiveTrade.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_Settings__Settings.jpg"><img src="screenshots/thumbs/14_Settings__Settings.jpg" width="100%"></a><br><sub><b>Settings</b> › Settings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_Notification__Template.jpg"><img src="screenshots/thumbs/20_Notification__Template.jpg" width="100%"></a><br><sub><b>Notification</b> › Template</sub></td>
<td width="33%" valign="top"><a href="screenshots/44_Confirmation__Template.jpg"><img src="screenshots/thumbs/44_Confirmation__Template.jpg" width="100%"></a><br><sub><b>Confirmation</b> › Template</sub></td>
<td width="33%" valign="top"><a href="screenshots/45_Confirmation__ReconnectTemplate.jpg"><img src="screenshots/thumbs/45_Confirmation__ReconnectTemplate.jpg" width="100%"></a><br><sub><b>Confirmation</b> › ReconnectTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_Confirmation__WarningTemplate.jpg"><img src="screenshots/thumbs/46_Confirmation__WarningTemplate.jpg" width="100%"></a><br><sub><b>Confirmation</b> › WarningTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_Confirmation__JoinCancel.jpg"><img src="screenshots/thumbs/48_Confirmation__JoinCancel.jpg" width="100%"></a><br><sub><b>Confirmation</b> › JoinCancel</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_TopUI__Poll.jpg"><img src="screenshots/thumbs/24_TopUI__Poll.jpg" width="100%"></a><br><sub><b>TopUI</b> › Frame.Poll</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_DuelsMachineTopFrame__DuelsMachineTopFrame.jpg"><img src="screenshots/thumbs/63_DuelsMachineTopFrame__DuelsMachineTopFrame.jpg" width="100%"></a><br><sub><b>DuelsMachineTopFrame</b> › DuelsMachineTopFrame</sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_ColorDiceMachineGui__DiceFrame.jpg"><img src="screenshots/thumbs/03_ColorDiceMachineGui__DiceFrame.jpg" width="100%"></a><br><sub><b>ColorDiceMachineGui</b> › DiceFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_CupidsMachine__CupidsMachine.jpg"><img src="screenshots/thumbs/22_CupidsMachine__CupidsMachine.jpg" width="100%"></a><br><sub><b>CupidsMachine</b> › CupidsMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/23_StockMachine__StockMachine.jpg"><img src="screenshots/thumbs/23_StockMachine__StockMachine.jpg" width="100%"></a><br><sub><b>StockMachine</b> › StockMachine</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_Glossary__Mutations.jpg"><img src="screenshots/thumbs/29_Glossary__Mutations.jpg" width="100%"></a><br><sub><b>Glossary</b> › Right.Mutations</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_FuseMachine__FuseMachine.jpg"><img src="screenshots/thumbs/31_FuseMachine__FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b> › FuseMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_DuelsMachinePlayerList__DuelsMachinePlayerList.jpg"><img src="screenshots/thumbs/61_DuelsMachinePlayerList__DuelsMachinePlayerList.jpg" width="100%"></a><br><sub><b>DuelsMachinePlayerList</b> › DuelsMachinePlayerList</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_SingleStockMachine__SingleStockMachine.jpg"><img src="screenshots/thumbs/62_SingleStockMachine__SingleStockMachine.jpg" width="100%"></a><br><sub><b>SingleStockMachine</b> › SingleStockMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/65_DuelsMachineSession__Header.jpg"><img src="screenshots/thumbs/65_DuelsMachineSession__Header.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Header</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_DuelsMachineSession__Your.jpg"><img src="screenshots/thumbs/67_DuelsMachineSession__Your.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Your</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/68_DuelsMachineSession__Other.jpg"><img src="screenshots/thumbs/68_DuelsMachineSession__Other.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Other</sub></td>
<td width="33%" valign="top"><a href="screenshots/76_CraftingMachine__CraftingMachine.jpg"><img src="screenshots/thumbs/76_CraftingMachine__CraftingMachine.jpg" width="100%"></a><br><sub><b>CraftingMachine</b> › CraftingMachine</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_AdminPanel__AdminPanel.jpg"><img src="screenshots/thumbs/39_AdminPanel__AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › AdminPanel</sub></td>
<td width="33%" valign="top"><a href="screenshots/49_Sign__SignPanel.jpg"><img src="screenshots/thumbs/49_Sign__SignPanel.jpg" width="100%"></a><br><sub><b>Sign</b> › SignPanel</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_ColorDiceMachineGui__Main.jpg"><img src="screenshots/thumbs/02_ColorDiceMachineGui__Main.jpg" width="100%"></a><br><sub><b>ColorDiceMachineGui</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/06_LeftCenter.jpg"><img src="screenshots/thumbs/06_LeftCenter.jpg" width="100%"></a><br><sub><b>LeftCenter</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_Rebirth__Main.jpg"><img src="screenshots/thumbs/16_Rebirth__Main.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_Glossary__Left.jpg"><img src="screenshots/thumbs/28_Glossary__Left.jpg" width="100%"></a><br><sub><b>Glossary</b> › Left</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_LeftBottom.jpg"><img src="screenshots/thumbs/60_LeftBottom.jpg" width="100%"></a><br><sub><b>LeftBottom</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_DuelsMachineSession__Main.jpg"><img src="screenshots/thumbs/69_DuelsMachineSession__Main.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/74_Index__Main.jpg"><img src="screenshots/thumbs/74_Index__Main.jpg" width="100%"></a><br><sub><b>Index</b> › Main</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_CountdownGui.jpg"><img src="screenshots/thumbs/01_CountdownGui.jpg" width="100%"></a><br><sub><b>CountdownGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_TopUI__Countdown.jpg"><img src="screenshots/thumbs/25_TopUI__Countdown.jpg" width="100%"></a><br><sub><b>TopUI</b> › Frame.Countdown</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_Confirmation__DuelsTeleportBackTemplate.jpg"><img src="screenshots/thumbs/47_Confirmation__DuelsTeleportBackTemplate.jpg" width="100%"></a><br><sub><b>Confirmation</b> › DuelsTeleportBackTemplate</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_BaseManagerGui__Backdrop.jpg"><img src="screenshots/thumbs/04_BaseManagerGui__Backdrop.jpg" width="100%"></a><br><sub><b>BaseManagerGui</b> › Backdrop</sub></td>
<td width="33%" valign="top"><a href="screenshots/05_BrainrotInformationGUI.jpg"><img src="screenshots/thumbs/05_BrainrotInformationGUI.jpg" width="100%"></a><br><sub><b>BrainrotInformationGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_VoiceChat__VoiceChat.jpg"><img src="screenshots/thumbs/08_VoiceChat__VoiceChat.jpg" width="100%"></a><br><sub><b>VoiceChat</b> › VoiceChat</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_PollUI__Poll.jpg"><img src="screenshots/thumbs/11_PollUI__Poll.jpg" width="100%"></a><br><sub><b>PollUI</b> › Poll</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_FestiveLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/12_FestiveLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>FestiveLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_TacoBase__TacoBase.jpg"><img src="screenshots/thumbs/13_TacoBase__TacoBase.jpg" width="100%"></a><br><sub><b>TacoBase</b> › TacoBase</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_ValentinesBase__ValentinesBase.jpg"><img src="screenshots/thumbs/33_ValentinesBase__ValentinesBase.jpg" width="100%"></a><br><sub><b>ValentinesBase</b> › ValentinesBase</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_SpookyLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/34_SpookyLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>SpookyLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/52_ActiveEvents.jpg"><img src="screenshots/thumbs/52_ActiveEvents.jpg" width="100%"></a><br><sub><b>ActiveEvents</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_ValentinesCard__ValentinesCard.jpg"><img src="screenshots/thumbs/57_ValentinesCard__ValentinesCard.jpg" width="100%"></a><br><sub><b>ValentinesCard</b> › ValentinesCard</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_LeprechaunLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/58_LeprechaunLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>LeprechaunLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/64_LuckyBase__LuckyBase.jpg"><img src="screenshots/thumbs/64_LuckyBase__LuckyBase.jpg" width="100%"></a><br><sub><b>LuckyBase</b> › LuckyBase</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/77_News__News.jpg"><img src="screenshots/thumbs/77_News__News.jpg" width="100%"></a><br><sub><b>News</b> › News</sub></td>
<td width="33%" valign="top"><a href="screenshots/78_SkillTree__Frame.jpg"><img src="screenshots/thumbs/78_SkillTree__Frame.jpg" width="100%"></a><br><sub><b>SkillTree</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/79_Frame.jpg"><img src="screenshots/thumbs/79_Frame.jpg" width="100%"></a><br><sub><b>Frame</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/PlotService/Skins/Headless/FirstFloor.rbxm"><img src="screenshots/thumbs/models/01_FirstFloor.jpg" width="100%"></a><br><sub><b>FirstFloor</b><br><code>models/ServerScriptService/Services/PlotService/Skins/Headless/FirstFloor.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/1%20Year/AnniversaryMap/Brainrots/La%20Supreme%20Combinasion.rbxm"><img src="screenshots/thumbs/models/02_La_Supreme_Combinasion.jpg" width="100%"></a><br><sub><b>La Supreme Combinasion</b><br><code>models/ReplicatedStorage/Models/Events/1 Year/AnniversaryMap/Brainrots/La Supreme Combinasion.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/PlotService/Skins/Bunny%20Basket/ThirdFloor.rbxm"><img src="screenshots/thumbs/models/03_ThirdFloor.jpg" width="100%"></a><br><sub><b>ThirdFloor</b><br><code>models/ServerScriptService/Services/PlotService/Skins/Bunny Basket/ThirdFloor.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/Rap%20Concert/VFX/VFXDisco.rbxm"><img src="screenshots/thumbs/models/04_VFXDisco.jpg" width="100%"></a><br><sub><b>VFXDisco</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/Rap Concert/VFX/VFXDisco.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/EventService/Events/Sammy%27s%20Base/SammyBase.rbxm"><img src="screenshots/thumbs/models/05_SammyBase.jpg" width="100%"></a><br><sub><b>SammyBase</b><br><code>models/ServerScriptService/Services/EventService/Events/Sammy's Base/SammyBase.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/PinataController/GearVisuals/Candy%20Coils.rbxm"><img src="screenshots/thumbs/models/06_Candy_Coils.jpg" width="100%"></a><br><sub><b>Candy Coils</b><br><code>models/ReplicatedStorage/Controllers/PinataController/GearVisuals/Candy Coils.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Rainbowrath%20Sword.rbxm"><img src="screenshots/thumbs/models/07_Rainbowrath_Sword.jpg" width="100%"></a><br><sub><b>Rainbowrath Sword</b><br><code>models/ReplicatedStorage/Items/Rainbowrath Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/1%20Year/AnniversaryMap/Decor/EasterSection/EggShapedTree.rbxm"><img src="screenshots/thumbs/models/08_EggShapedTree.jpg" width="100%"></a><br><sub><b>EggShapedTree</b><br><code>models/ReplicatedStorage/Models/Events/1 Year/AnniversaryMap/Decor/EasterSection/EggShapedTree.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/CraftingMachine.rbxm"><img src="screenshots/thumbs/models/09_CraftingMachine.jpg" width="100%"></a><br><sub><b>CraftingMachine</b><br><code>models/Workspace/CraftingMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/1%20Year/AnniversaryMap/Decor/ChristmasSection/EntranceSign.rbxm"><img src="screenshots/thumbs/models/10_EntranceSign.jpg" width="100%"></a><br><sub><b>EntranceSign</b><br><code>models/ReplicatedStorage/Models/Events/1 Year/AnniversaryMap/Decor/ChristmasSection/EntranceSign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Tools/Flash%20Teleport/Ghost.rbxm"><img src="screenshots/thumbs/models/11_Ghost.jpg" width="100%"></a><br><sub><b>Ghost</b><br><code>models/ReplicatedStorage/Assets/Tools/Flash Teleport/Ghost.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/Matteo/RainbowTrees/Tree3.rbxm"><img src="screenshots/thumbs/models/12_Tree3.jpg" width="100%"></a><br><sub><b>Tree3</b><br><code>models/ReplicatedStorage/Models/Events/Matteo/RainbowTrees/Tree3.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/EventBoard.rbxm"><img src="screenshots/thumbs/models/13_EventBoard.jpg" width="100%"></a><br><sub><b>EventBoard</b><br><code>models/Workspace/EventBoard.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/EventService/Events/Backrooms/BackroomsMap/ModularizedRooms/EntranceRoom/Vent.rbxm"><img src="screenshots/thumbs/models/14_Vent.jpg" width="100%"></a><br><sub><b>Vent</b><br><code>models/ServerScriptService/Services/EventService/Events/Backrooms/BackroomsMap/ModularizedRooms/EntranceRoom/Vent.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`RNGMachineController`](source/scripts/ReplicatedStorage/Controllers/RNGMachineController.lua) <sub>3716 lines</sub><br>[`GlossaryController`](source/scripts/ReplicatedStorage/Controllers/GlossaryController.lua) <sub>1267 lines</sub><br>[`Patchnoteglobal`](source/scripts/ServerScriptService/Services/CommandsService/Commands/Patchnoteglobal.lua) <sub>325 lines</sub><br>[`1 Year`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/1%20Year.lua) <sub>3155 lines</sub><br>[`CustomProximityPromptController`](source/scripts/ReplicatedStorage/Controllers/CustomProximityPromptController.lua) <sub>475 lines</sub> |
| UI controllers / window managers / menus | [`BaseManagerController`](source/scripts/StarterGui/BaseManagerGui/BaseManagerController.client.lua) <sub>160 lines</sub><br>[`AdmC`](source/scripts/StarterGui/AdmC.client.lua) <sub>2205 lines</sub><br>[`CodesController`](source/scripts/ReplicatedStorage/Controllers/CodesController.lua) <sub>155 lines</sub><br>[`CraftBuilderMenu`](source/scripts/StarterGui/CraftBuilderMenu.client.lua) <sub>673 lines</sub><br>[`SettingsController`](source/scripts/ReplicatedStorage/Controllers/SettingsController.lua) <sub>362 lines</sub> |
| Notifications, toasts, popups, prompts | [`CustomProximityPromptController`](source/scripts/ReplicatedStorage/Controllers/CustomProximityPromptController.lua) <sub>475 lines</sub><br>[`NotificationController`](source/scripts/ReplicatedStorage/Controllers/NotificationController.lua) <sub>148 lines</sub><br>[`GlossaryPromptHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/GlossaryPromptHandler.client.lua) <sub>69 lines</sub><br>[`CornerNotificationController`](source/scripts/ReplicatedStorage/Controllers/CornerNotificationController.lua) <sub>107 lines</sub><br>[`BrainrotSpawner`](source/scripts/ServerScriptService/BrainrotSpawner.server.lua) <sub>414 lines</sub> |
| Loading / intro screens | [`Phase 2_ Galaxy Introduction`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Phase%202_%20Galaxy%20Introduction.lua) <sub>342 lines</sub><br>[`Loader`](source/scripts/ServerScriptService/Loader.server.lua) <sub>256 lines</sub><br>[`Badr Snap`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Badr%20Snap.lua) <sub>440 lines</sub><br>[`10B Visits`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/10B%20Visits.lua) <sub>269 lines</sub><br>[`France`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/France.lua) <sub>256 lines</sub> |
| Camera, cutscenes, screen shake | [`Phase 2_ Galaxy Introduction`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Phase%202_%20Galaxy%20Introduction.lua) <sub>342 lines</sub><br>[`DialogModule`](source/scripts/ReplicatedStorage/DialogModule.lua) <sub>444 lines</sub><br>[`Steak Snap`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Steak%20Snap.lua) <sub>160 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Items/Waverider/LocalScript.client.lua) <sub>848 lines</sub><br>[`10B Visits`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/10B%20Visits.lua) <sub>269 lines</sub> |
| VFX, particles, beams, hit effects | [`BanHammerScript`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/BanHammerScript.server.lua) <sub>541 lines</sub><br>[`Backrooms`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Backrooms.lua) <sub>404 lines</sub><br>[`BanController`](source/scripts/ReplicatedStorage/Items/Delete%20Hammer/BanController.server.lua) <sub>233 lines</sub><br>[`Water`](source/scripts/ServerScriptService/Services/EventService/Events/Water.lua) <sub>455 lines</sub><br>[`DeleteHammerController`](source/scripts/ServerScriptService/Services/ItemService/Delete%20Hammer/DeleteHammerController.server.lua) <sub>283 lines</sub> |
| DataStore / player data | [`DataService`](source/scripts/ServerScriptService/Services/DataService.lua) <sub>254 lines</sub><br>[`TimePlayedClass`](source/scripts/Workspace/TimePlayedLeaderboard/TimePlayedClass.server.lua) <sub>329 lines</sub><br>[`ModuleScript`](source/scripts/ServerScriptService/Services/ModuleScript.lua) <sub>551 lines</sub><br>[`LeaderboardService`](source/scripts/ServerScriptService/Services/LeaderboardService.lua) <sub>432 lines</sub><br>[`CodeService`](source/scripts/ServerScriptService/Services/CodeService.lua) <sub>469 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`ShopService`](source/scripts/ServerScriptService/Services/ShopService.lua) <sub>633 lines</sub><br>[`ValentinesShopService`](source/scripts/ServerScriptService/Services/ValentinesShopService.lua) <sub>367 lines</sub><br>[`GamepassBrainrotSpawner`](source/scripts/ServerScriptService/GamepassBrainrotSpawner.server.lua) <sub>124 lines</sub><br>[`BrainrotShopController`](source/scripts/ReplicatedStorage/Controllers/BrainrotShopController.lua) <sub>47 lines</sub><br>[`ShopController`](source/scripts/ReplicatedStorage/Controllers/ShopController.lua) <sub>1239 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`RNGMachineService`](source/scripts/ServerScriptService/Services/RNGMachineService.lua) <sub>921 lines</sub><br>[`spawnluckyblockrandommutations`](source/scripts/ServerScriptService/Services/CommandsService/Commands/spawnluckyblockrandommutations.lua) <sub>168 lines</sub><br>[`CyberSpinWheelService`](source/scripts/ServerScriptService/Services/CyberSpinWheelService.lua) <sub>64 lines</sub><br>[`CyberEventService`](source/scripts/ServerScriptService/Services/CyberEventService.lua) <sub>209 lines</sub><br>[`DivineEventService`](source/scripts/ServerScriptService/Services/DivineEventService.lua) <sub>214 lines</sub> |
| Trading systems | [`TradeController`](source/scripts/ReplicatedStorage/Controllers/TradeController.lua) <sub>687 lines</sub><br>[`TradeService`](source/scripts/ServerScriptService/Services/TradeService.lua) <sub>1103 lines</sub><br>[`TradingFlags`](source/scripts/ReplicatedStorage/Shared/Flags/TradingFlags.lua) <sub>23 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Backrooms`](source/scripts/ServerScriptService/Services/EventService/Events/Backrooms.lua) <sub>827 lines</sub><br>[`StealService`](source/scripts/ServerScriptService/Services/StealService.lua) <sub>1391 lines</sub><br>[`BrainrotSpawner`](source/scripts/ServerScriptService/BrainrotSpawner.server.lua) <sub>414 lines</sub><br>[`PlotClient`](source/scripts/ReplicatedStorage/Classes/PlotClient.lua) <sub>1107 lines</sub><br>[`Solar Flare`](source/scripts/ServerScriptService/Services/EventService/Events/Solar%20Flare.lua) <sub>201 lines</sub> |
| NPC / AI / monsters | [`3 Roads`](source/scripts/ServerScriptService/Services/EventService/Events/3%20Roads.lua) <sub>727 lines</sub><br>[`Crab Rave`](source/scripts/ServerScriptService/Services/EventService/Events/Crab%20Rave.lua) <sub>490 lines</sub><br>[`Dul Dul Dul`](source/scripts/ServerScriptService/Services/EventService/Events/Dul%20Dul%20Dul.lua) <sub>385 lines</sub><br>[`AnimalService`](source/scripts/ServerScriptService/Services/AnimalService.lua) <sub>1960 lines</sub><br>[`Npc`](source/scripts/ReplicatedStorage/Components/Npc.lua) <sub>56 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`RainbowrathController`](source/scripts/ReplicatedStorage/Items/Rainbowrath%20Sword/RainbowrathController.server.lua) <sub>111 lines</sub><br>[`LocalScript`](source/scripts/ReplicatedStorage/Items/Waverider/LocalScript.client.lua) <sub>848 lines</sub><br>[`BanHammerScript`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/BanHammerScript.server.lua) <sub>541 lines</sub> |
| Tycoon / plots / bases / building | [`PlotClient`](source/scripts/ReplicatedStorage/Classes/PlotClient.lua) <sub>1107 lines</sub><br>[`CraftBuilderMenu`](source/scripts/StarterGui/CraftBuilderMenu.client.lua) <sub>673 lines</sub><br>[`BaseManagerController`](source/scripts/StarterGui/BaseManagerGui/BaseManagerController.client.lua) <sub>160 lines</sub><br>[`Taco Base`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Taco%20Base.lua) <sub>193 lines</sub><br>[`BaseCheckService`](source/scripts/ServerScriptService/Services/BaseCheckService.lua) <sub>382 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/Services/LeaderboardService.lua) <sub>432 lines</sub><br>[`TimePlayedClass`](source/scripts/Workspace/TimePlayedLeaderboard/TimePlayedClass.server.lua) <sub>329 lines</sub> |
| Admin panels & commands | [`CommandsService`](source/scripts/ServerScriptService/Services/CommandsService.lua) <sub>189 lines</sub><br>[`CustomAdminPanel`](source/scripts/ServerScriptService/CustomAdminPanel.server.lua) <sub>398 lines</sub><br>[`UnbanCommand`](source/scripts/ServerScriptService/UnbanCommand.server.lua) <sub>122 lines</sub><br>[`AdminGodMode`](source/scripts/ServerScriptService/AdminGodMode.server.lua) <sub>138 lines</sub> |
| Sound & music | [`SoundController`](source/scripts/ReplicatedStorage/Controllers/SoundController.lua) <sub>413 lines</sub><br>[`RNGMachineController`](source/scripts/ReplicatedStorage/Controllers/RNGMachineController.lua) <sub>3716 lines</sub><br>[`Badr Snap`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Badr%20Snap.lua) <sub>440 lines</sub><br>[`Ibrx Snap`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Ibrx%20Snap.lua) <sub>412 lines</sub><br>[`Ay Mi Gatito`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Ay%20Mi%20Gatito.lua) <sub>620 lines</sub> |
| Daily rewards, quests, codes, playtime | [`CodeService`](source/scripts/ServerScriptService/Services/CodeService.lua) <sub>469 lines</sub><br>[`CyberEventService`](source/scripts/ServerScriptService/Services/CyberEventService.lua) <sub>209 lines</sub><br>[`createcode`](source/scripts/ServerScriptService/Services/CommandsService/Commands/createcode.lua) <sub>187 lines</sub><br>[`CraftingMachineService`](source/scripts/ServerScriptService/Services/CraftingMachineService.lua) <sub>1084 lines</sub><br>[`CodesController`](source/scripts/ReplicatedStorage/Controllers/CodesController.lua) <sub>155 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`StealService`](source/scripts/ServerScriptService/Services/StealService.lua) <sub>1391 lines</sub><br>[`CraftingMachineController`](source/scripts/ReplicatedStorage/Controllers/CraftingMachineController.lua) <sub>777 lines</sub><br>[`Winter Hour`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Winter%20Hour.lua) <sub>338 lines</sub><br>[`DataService`](source/scripts/ServerScriptService/Services/DataService.lua) <sub>254 lines</sub><br>[`DuelsMachineMatchController`](source/scripts/ReplicatedStorage/Controllers/DuelsMachineMatchController.lua) <sub>394 lines</sub> |

### In the curated script library

- [DataService with separate lock store](../../Scripts/07-Data-Saving/DataService-SessionLock__steal-a-brainrot.lua) — GetAsync/SetAsync with 2^n backoff, a separate SESSION-LOCK store claimed with UpdateAsync, reconcile against DefaultStats, 60s autosave and parallel BindToClose that waits for saves.
- [Log-scaled values, friends and country boards](../../Scripts/15-Leaderboards/LeaderboardService-LogScale-Friends-Country__steal-a-brainrot.lua) — Stores huge values as log(value)/log(1.0000001) so they fit an ordered store, a 12s read cache, a friends board (GetFriendsAsync + GetAsync per friend), a country board (LocalizationService) with an opt-out toggle.
- [Time-played board (RenanMSV toolbox model)](../../Scripts/15-Leaderboards/TimePlayedClass-RenanMSV__steal-a-brainrot.lua) — Self-contained 'most time played' board class from RenanMSV's public model: settings module, score update and board refresh timers, username/thumbnail caches, optional dancing #1 rig.
- [Preload critical assets only](../../Scripts/04-Loading-Screens/PreloadCriticalAssets__steal-a-brainrot.lua) — Preloads only the critical assets (first 100 UI items, then ~200 meshes of the most common models) in background tasks instead of preloading everything.
- [Ragdoll module (server)](../../Scripts/13-Movement/RagdollModule__steal-a-brainrot.lua) — Simple, readable ragdoll / unragdoll / timed ragdoll on the server.
- [Ragdoll client](../../Scripts/13-Movement/RagdollClient__steal-a-brainrot.lua) — Client side of a ragdoll: controls off, Physics state, camera on head, safe unlock.
- [Cross-server announce command](../../Scripts/03-Notifications/GlobalAnnounceCommand__steal-a-brainrot.lua) — Server admin command that announces to this server and to every other server via a messaging hub, skipping its own JobId to avoid double messages.
- [NPC dialogue module (typewriter + choices)](../../Scripts/12-NPC-AI/NPCDialogModule__steal-a-brainrot.lua) — Client OOP dialogue: list of {text, responses} where a response can jump to another entry (next) or close with an exit quip; typewriter text with tick sound, NPC turns to face the player, optional camera part lock, 1/2 keyboard shortcuts, hides other players, closes when you walk away.
- [Paid RNG slot machine with skill tree](../../Scripts/09-RNG-Gacha-Pets/RNGMachineService__steal-a-brainrot.lua) — Server RNG machine: price-based reward weights, server picks the result and decoy reel entries for the client to animate, chance of a luck-multiplier result, mutation skills, timed buy offer and delivery to a free podium.
- [Mutation data layout](../../Scripts/09-RNG-Gacha-Pets/MutationTable__steal-a-brainrot.lua) — Two entries of the mutation table: each mutation has a display name, rich text, sort order, roll Weight, income Modifier, icon and colour palettes used to recolour the model.
- [Replicated server luck timer](../../Scripts/09-RNG-Gacha-Pets/ServerLuckTimer__steal-a-brainrot.lua) — Tiny service that holds a server-wide luck index and end time in a replicated channel and counts it down once per second.
- [Podium trade service](../../Scripts/10-Trading/PodiumTradeService__steal-a-brainrot.lua) — Production trade service for base animals: invites, local and cross-server handshake, ready delay, steal checks.
- [NPC recipe trader](../../Scripts/10-Trading/NpcRecipeTrader__steal-a-brainrot.lua) — Rotating NPC offers that consume a recipe of brainrots; contains an insecure update remote to remove.
- [Steal remote validation + stale flag janitor](../../Scripts/14-Tycoon-Plots/StealRemoteValidation__steal-a-brainrot.lua) — The server's Steal remote handler (type-checks args, rejects if already stealing, confirms the thief's HumanoidRootPart is inside the victim plot's StealHitbox with GetPartBoundsInBox) plus a...
- [Switch to another free base](../../Scripts/14-Tycoon-Plots/BaseManagerService__steal-a-brainrot.lua) — Lets a player move to a different free base: a RemoteFunction lists free plots, a RemoteEvent requests the move, with a 3s per-player cooldown and a server-side re-check that the target plot is...
- [Base tier data (rebirth -> model, max podiums)](../../Scripts/14-Tycoon-Plots/BaseTiers__steal-a-brainrot.lua) — Data table mapping rebirth level to base model (first/second/third floor template) and MaxAnimals (podium count)

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Packages/Freeze/List.lua`
- `scripts/ReplicatedStorage/Packages/Freeze/List/compat/findWhereLast.lua`
- `scripts/ServerScriptService/AdminLogger.server.lua`
- `scripts/ServerScriptService/CmdrSetup.server.lua`
- `scripts/StarterPlayer/StarterPlayerScripts/BrainrotC_Client.client.lua`
- `scripts/Workspace/RobuxShop/_/AnimSaves/KeyframeSequence_3/Keyframe~43/HumanoidRootPart/LowerTorso/UpperTorso/LeftUpperArm/LeftLowerArm/Fix.server.lua`
- `scripts/Workspace/RobuxShop/_/AnimSaves/KeyframeSequence_3/Keyframe~60/HumanoidRootPart/LowerTorso/UpperTorso/RightUpperArm/RightLowerArm/AdminLoader.server.lua`
- `scripts/Workspace/Shop/_/AnimSaves/KeyframeSequence_3/Keyframe~31/HumanoidRootPart/LowerTorso/UpperTorso/LeftUpperArm/LeftLowerArm/Fix.server.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
