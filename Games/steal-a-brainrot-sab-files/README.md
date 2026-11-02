# Steal a Brainrot (SAB files)

> 🧠 **Brainrot** · steal / tycoon (brainrots, plots) · source file `SLBR VIP _ SAB FILES.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/20_SantaMerchant__SantaMerchant.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 83 ScreenGuis, 5987 GUI objects → **93 screenshots** |
| Models (.rbxm) | 5224 models, 290 model sets, 7626 VFX sets |
| Lua builders (.lua) | 143 UI screens, 547 animation packs, 94 audio packs |
| Code | 1967 scripts, 284,519 lines |
| Asset ids | 1443 animations, 949 sounds |
| Safety scan | 30 HIGH / 31 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×987, `SourceSansPro Bold`×787, `GothamSSm Bold`×564, `GothamSSm Heavy`×114, `FredokaOne Regular`×103

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_GamepassUI.jpg"><img src="screenshots/thumbs/04_GamepassUI.jpg" width="100%"></a><br><sub><b>GamepassUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_GamepassUI__Frame.jpg"><img src="screenshots/thumbs/05_GamepassUI__Frame.jpg" width="100%"></a><br><sub><b>GamepassUI</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_SantaMerchant__SantaMerchant.jpg"><img src="screenshots/thumbs/20_SantaMerchant__SantaMerchant.jpg" width="100%"></a><br><sub><b>SantaMerchant</b> › SantaMerchant</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_RodsShop__RodsShop.jpg"><img src="screenshots/thumbs/21_RodsShop__RodsShop.jpg" width="100%"></a><br><sub><b>RodsShop</b> › RodsShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/27_FakePurchases__Shop.jpg"><img src="screenshots/thumbs/27_FakePurchases__Shop.jpg" width="100%"></a><br><sub><b>FakePurchases</b> › Shop</sub></td>
<td width="33%" valign="top"><a href="screenshots/38_CoinsShop__CoinsShop.jpg"><img src="screenshots/thumbs/38_CoinsShop__CoinsShop.jpg" width="100%"></a><br><sub><b>CoinsShop</b> › CoinsShop</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/49_ValentinesShop.jpg"><img src="screenshots/thumbs/49_ValentinesShop.jpg" width="100%"></a><br><sub><b>ValentinesShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/59_JumpShop__JumpShop.jpg"><img src="screenshots/thumbs/59_JumpShop__JumpShop.jpg" width="100%"></a><br><sub><b>JumpShop</b> › JumpShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/64_Merchant__Merchant.jpg"><img src="screenshots/thumbs/64_Merchant__Merchant.jpg" width="100%"></a><br><sub><b>Merchant</b> › Merchant</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/66_CandyShop__CandyShop.jpg"><img src="screenshots/thumbs/66_CandyShop__CandyShop.jpg" width="100%"></a><br><sub><b>CandyShop</b> › CandyShop</sub></td>
<td width="33%" valign="top"><a href="screenshots/79_Shop__Shop.jpg"><img src="screenshots/thumbs/79_Shop__Shop.jpg" width="100%"></a><br><sub><b>Shop</b> › Shop</sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_CyberWheel__Buttons.jpg"><img src="screenshots/thumbs/24_CyberWheel__Buttons.jpg" width="100%"></a><br><sub><b>CyberWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/25_CyberWheel__Wheel.jpg"><img src="screenshots/thumbs/25_CyberWheel__Wheel.jpg" width="100%"></a><br><sub><b>CyberWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/28_GiftPlayer__GiftPlayer.jpg"><img src="screenshots/thumbs/28_GiftPlayer__GiftPlayer.jpg" width="100%"></a><br><sub><b>GiftPlayer</b> › GiftPlayer</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_GalaxyWheel__Wheel.jpg"><img src="screenshots/thumbs/29_GalaxyWheel__Wheel.jpg" width="100%"></a><br><sub><b>GalaxyWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_GalaxyWheel__Buttons.jpg"><img src="screenshots/thumbs/30_GalaxyWheel__Buttons.jpg" width="100%"></a><br><sub><b>GalaxyWheel</b> › Buttons</sub></td>
<td width="33%" valign="top"><a href="screenshots/39_ChristmasWheel__Buttons.jpg"><img src="screenshots/thumbs/39_ChristmasWheel__Buttons.jpg" width="100%"></a><br><sub><b>ChristmasWheel</b> › Buttons</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_ChristmasWheel__Wheel.jpg"><img src="screenshots/thumbs/40_ChristmasWheel__Wheel.jpg" width="100%"></a><br><sub><b>ChristmasWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_AdventCalendar__Frame.jpg"><img src="screenshots/thumbs/42_AdventCalendar__Frame.jpg" width="100%"></a><br><sub><b>AdventCalendar</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/43_PhantomWheel__Buttons.jpg"><img src="screenshots/thumbs/43_PhantomWheel__Buttons.jpg" width="100%"></a><br><sub><b>PhantomWheel</b> › Buttons</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/44_PhantomWheel__Wheel.jpg"><img src="screenshots/thumbs/44_PhantomWheel__Wheel.jpg" width="100%"></a><br><sub><b>PhantomWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/62_ValentinesSendGift__ValentinesSendGift.jpg"><img src="screenshots/thumbs/62_ValentinesSendGift__ValentinesSendGift.jpg" width="100%"></a><br><sub><b>ValentinesSendGift</b> › ValentinesSendGift</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_DivineWheel__Buttons.jpg"><img src="screenshots/thumbs/67_DivineWheel__Buttons.jpg" width="100%"></a><br><sub><b>DivineWheel</b> › Buttons</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/68_DivineWheel__Wheel.jpg"><img src="screenshots/thumbs/68_DivineWheel__Wheel.jpg" width="100%"></a><br><sub><b>DivineWheel</b> › Wheel</sub></td>
<td width="33%" valign="top"><a href="screenshots/80_Codes.jpg"><img src="screenshots/thumbs/80_Codes.jpg" width="100%"></a><br><sub><b>Codes</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_TsunamiSpeedUpgrade__TsunamiSpeedUpgrade.jpg"><img src="screenshots/thumbs/14_TsunamiSpeedUpgrade__TsunamiSpeedUpgrade.jpg" width="100%"></a><br><sub><b>TsunamiSpeedUpgrade</b> › TsunamiSpeedUpgrade</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_Rebirth__Rebirth.jpg"><img src="screenshots/thumbs/22_Rebirth__Rebirth.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Rebirth</sub></td>
<td width="33%" valign="top"><a href="screenshots/52_Index__Progress.jpg"><img src="screenshots/thumbs/52_Index__Progress.jpg" width="100%"></a><br><sub><b>Index</b> › Progress</sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/13_TradePlayerList__TradePlayerList.jpg"><img src="screenshots/thumbs/13_TradePlayerList__TradePlayerList.jpg" width="100%"></a><br><sub><b>TradePlayerList</b> › TradePlayerList</sub></td>
<td width="33%" valign="top"><a href="screenshots/73_BrainrotTrader__Frame.jpg"><img src="screenshots/thumbs/73_BrainrotTrader__Frame.jpg" width="100%"></a><br><sub><b>BrainrotTrader</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/88_TradeLiveTrade__Header.jpg"><img src="screenshots/thumbs/88_TradeLiveTrade__Header.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b> › Header</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/89_TradeLiveTrade__Other.jpg"><img src="screenshots/thumbs/89_TradeLiveTrade__Other.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b> › Other</sub></td>
<td width="33%" valign="top"><a href="screenshots/90_TradeLiveTrade__YourSign.jpg"><img src="screenshots/thumbs/90_TradeLiveTrade__YourSign.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b> › YourSign</sub></td>
<td width="33%" valign="top"><a href="screenshots/91_TradeLiveTrade__OtherSign.jpg"><img src="screenshots/thumbs/91_TradeLiveTrade__OtherSign.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b> › OtherSign</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/92_TradeLiveTrade__Chat.jpg"><img src="screenshots/thumbs/92_TradeLiveTrade__Chat.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b> › Chat</sub></td>
<td width="33%" valign="top"><a href="screenshots/93_TradeLiveTrade__Your.jpg"><img src="screenshots/thumbs/93_TradeLiveTrade__Your.jpg" width="100%"></a><br><sub><b>TradeLiveTrade</b> › Your</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Settings__Settings.jpg"><img src="screenshots/thumbs/23_Settings__Settings.jpg" width="100%"></a><br><sub><b>Settings</b> › Settings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_MainFrame__Notification.jpg"><img src="screenshots/thumbs/02_MainFrame__Notification.jpg" width="100%"></a><br><sub><b>MainFrame</b> › Notification</sub></td>
<td width="33%" valign="top"><a href="screenshots/37_Confirmation__Template.jpg"><img src="screenshots/thumbs/37_Confirmation__Template.jpg" width="100%"></a><br><sub><b>Confirmation</b> › Template</sub></td>
<td width="33%" valign="top"><a href="screenshots/81_Confirmation__Template.jpg"><img src="screenshots/thumbs/81_Confirmation__Template.jpg" width="100%"></a><br><sub><b>Confirmation</b> › Template</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/82_Confirmation__ReconnectTemplate.jpg"><img src="screenshots/thumbs/82_Confirmation__ReconnectTemplate.jpg" width="100%"></a><br><sub><b>Confirmation</b> › ReconnectTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/83_Confirmation__WarningTemplate.jpg"><img src="screenshots/thumbs/83_Confirmation__WarningTemplate.jpg" width="100%"></a><br><sub><b>Confirmation</b> › WarningTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/85_Confirmation__JoinCancel.jpg"><img src="screenshots/thumbs/85_Confirmation__JoinCancel.jpg" width="100%"></a><br><sub><b>Confirmation</b> › JoinCancel</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_DuelsMachineTopFrame__DuelsMachineTopFrame.jpg"><img src="screenshots/thumbs/41_DuelsMachineTopFrame__DuelsMachineTopFrame.jpg" width="100%"></a><br><sub><b>DuelsMachineTopFrame</b> › DuelsMachineTopFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/56_TopUI__Poll.jpg"><img src="screenshots/thumbs/56_TopUI__Poll.jpg" width="100%"></a><br><sub><b>TopUI</b> › Frame.Poll</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/50_ValentinesShop__Send.jpg"><img src="screenshots/thumbs/50_ValentinesShop__Send.jpg" width="100%"></a><br><sub><b>ValentinesShop</b> › Sections.Send</sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_ColorDiceMachineGui__DiceFrame.jpg"><img src="screenshots/thumbs/08_ColorDiceMachineGui__DiceFrame.jpg" width="100%"></a><br><sub><b>ColorDiceMachineGui</b> › DiceFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/17_DuelsMachinePlayerList__DuelsMachinePlayerList.jpg"><img src="screenshots/thumbs/17_DuelsMachinePlayerList__DuelsMachinePlayerList.jpg" width="100%"></a><br><sub><b>DuelsMachinePlayerList</b> › DuelsMachinePlayerList</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_CupidsMachine__CupidsMachine.jpg"><img src="screenshots/thumbs/19_CupidsMachine__CupidsMachine.jpg" width="100%"></a><br><sub><b>CupidsMachine</b> › CupidsMachine</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_SantaFuse__SantaFuse.jpg"><img src="screenshots/thumbs/26_SantaFuse__SantaFuse.jpg" width="100%"></a><br><sub><b>SantaFuse</b> › SantaFuse</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_DuelsMachineSession__Header.jpg"><img src="screenshots/thumbs/32_DuelsMachineSession__Header.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Header</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_DuelsMachineSession__ScrollingFrame.jpg"><img src="screenshots/thumbs/33_DuelsMachineSession__ScrollingFrame.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › ScrollingFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_DuelsMachineSession__Your.jpg"><img src="screenshots/thumbs/34_DuelsMachineSession__Your.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Your</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_DuelsMachineSession__Other.jpg"><img src="screenshots/thumbs/35_DuelsMachineSession__Other.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Other</sub></td>
<td width="33%" valign="top"><a href="screenshots/45_CraftingMachine__CraftingMachine.jpg"><img src="screenshots/thumbs/45_CraftingMachine__CraftingMachine.jpg" width="100%"></a><br><sub><b>CraftingMachine</b> › CraftingMachine</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_NormalFuse__NormalFuse.jpg"><img src="screenshots/thumbs/46_NormalFuse__NormalFuse.jpg" width="100%"></a><br><sub><b>NormalFuse</b> › NormalFuse</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_OGCraftingMachine__CraftingMachine.jpg"><img src="screenshots/thumbs/55_OGCraftingMachine__CraftingMachine.jpg" width="100%"></a><br><sub><b>OGCraftingMachine</b> › CraftingMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_StockMachine__StockMachine.jpg"><img src="screenshots/thumbs/71_StockMachine__StockMachine.jpg" width="100%"></a><br><sub><b>StockMachine</b> › StockMachine</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/76_WitchFuse__WitchFuse.jpg"><img src="screenshots/thumbs/76_WitchFuse__WitchFuse.jpg" width="100%"></a><br><sub><b>WitchFuse</b> › WitchFuse</sub></td>
<td width="33%" valign="top"><a href="screenshots/78_FuseMachine__FuseMachine.jpg"><img src="screenshots/thumbs/78_FuseMachine__FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b> › FuseMachine</sub></td>
<td width="33%" valign="top"><a href="screenshots/87_SingleStockMachine__SingleStockMachine.jpg"><img src="screenshots/thumbs/87_SingleStockMachine__SingleStockMachine.jpg" width="100%"></a><br><sub><b>SingleStockMachine</b> › SingleStockMachine</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_CommandPanel.jpg"><img src="screenshots/thumbs/03_CommandPanel.jpg" width="100%"></a><br><sub><b>CommandPanel</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_BanPanelGui__MainPanel.jpg"><img src="screenshots/thumbs/09_BanPanelGui__MainPanel.jpg" width="100%"></a><br><sub><b>BanPanelGui</b> › MainPanel</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_AdminSelection__AdminSelection.jpg"><img src="screenshots/thumbs/48_AdminSelection__AdminSelection.jpg" width="100%"></a><br><sub><b>AdminSelection</b> › AdminSelection</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/69_Admin__Header.jpg"><img src="screenshots/thumbs/69_Admin__Header.jpg" width="100%"></a><br><sub><b>Admin</b> › Header</sub></td>
<td width="33%" valign="top"><a href="screenshots/70_Admin__Content.jpg"><img src="screenshots/thumbs/70_Admin__Content.jpg" width="100%"></a><br><sub><b>Admin</b> › Content</sub></td>
<td width="33%" valign="top"><a href="screenshots/86_AdminPanel__AdminPanel.jpg"><img src="screenshots/thumbs/86_AdminPanel__AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › AdminPanel</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_MainFrame.jpg"><img src="screenshots/thumbs/01_MainFrame.jpg" width="100%"></a><br><sub><b>MainFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_BrainrotShopGui__MainFrame.jpg"><img src="screenshots/thumbs/06_BrainrotShopGui__MainFrame.jpg" width="100%"></a><br><sub><b>BrainrotShopGui</b> › MainFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_ColorDiceMachineGui__Main.jpg"><img src="screenshots/thumbs/07_ColorDiceMachineGui__Main.jpg" width="100%"></a><br><sub><b>ColorDiceMachineGui</b> › Main</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_DuelsMachineSession__Main.jpg"><img src="screenshots/thumbs/36_DuelsMachineSession__Main.jpg" width="100%"></a><br><sub><b>DuelsMachineSession</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/53_Index__Main.jpg"><img src="screenshots/thumbs/53_Index__Main.jpg" width="100%"></a><br><sub><b>Index</b> › Main</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_LeftCenter.jpg"><img src="screenshots/thumbs/58_LeftCenter.jpg" width="100%"></a><br><sub><b>LeftCenter</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/65_LeftBottom.jpg"><img src="screenshots/thumbs/65_LeftBottom.jpg" width="100%"></a><br><sub><b>LeftBottom</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/96_BanGUI__Main.jpg"><img src="screenshots/thumbs/96_BanGUI__Main.jpg" width="100%"></a><br><sub><b>BanGUI</b> › Main</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_TopUI__Countdown.jpg"><img src="screenshots/thumbs/57_TopUI__Countdown.jpg" width="100%"></a><br><sub><b>TopUI</b> › Frame.Countdown</sub></td>
<td width="33%" valign="top"><a href="screenshots/84_Confirmation__DuelsTeleportBackTemplate.jpg"><img src="screenshots/thumbs/84_Confirmation__DuelsTeleportBackTemplate.jpg" width="100%"></a><br><sub><b>Confirmation</b> › DuelsTeleportBackTemplate</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_StartNew.jpg"><img src="screenshots/thumbs/10_StartNew.jpg" width="100%"></a><br><sub><b>StartNew</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/11_Start.jpg"><img src="screenshots/thumbs/11_Start.jpg" width="100%"></a><br><sub><b>Start</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/12_Finish.jpg"><img src="screenshots/thumbs/12_Finish.jpg" width="100%"></a><br><sub><b>Finish</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_VoiceChat__VoiceChat.jpg"><img src="screenshots/thumbs/15_VoiceChat__VoiceChat.jpg" width="100%"></a><br><sub><b>VoiceChat</b> › VoiceChat</sub></td>
<td width="33%" valign="top"><a href="screenshots/16_SummerBase__SummerBase.jpg"><img src="screenshots/thumbs/16_SummerBase__SummerBase.jpg" width="100%"></a><br><sub><b>SummerBase</b> › SummerBase</sub></td>
<td width="33%" valign="top"><a href="screenshots/18_EasterBase__EasterBase.jpg"><img src="screenshots/thumbs/18_EasterBase__EasterBase.jpg" width="100%"></a><br><sub><b>EasterBase</b> › EasterBase</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_FestiveLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/31_FestiveLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>FestiveLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_SelectBrainrots__SelectBrainrots.jpg"><img src="screenshots/thumbs/47_SelectBrainrots__SelectBrainrots.jpg" width="100%"></a><br><sub><b>SelectBrainrots</b> › SelectBrainrots</sub></td>
<td width="33%" valign="top"><a href="screenshots/51_LeprechaunLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/51_LeprechaunLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>LeprechaunLuckyBlock</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/54_EggLuckyBlock__Frame.jpg"><img src="screenshots/thumbs/54_EggLuckyBlock__Frame.jpg" width="100%"></a><br><sub><b>EggLuckyBlock</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_ValentinesBase__ValentinesBase.jpg"><img src="screenshots/thumbs/60_ValentinesBase__ValentinesBase.jpg" width="100%"></a><br><sub><b>ValentinesBase</b> › ValentinesBase</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_ValentinesCard__ValentinesCard.jpg"><img src="screenshots/thumbs/61_ValentinesCard__ValentinesCard.jpg" width="100%"></a><br><sub><b>ValentinesCard</b> › ValentinesCard</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/63_LuckyBase__LuckyBase.jpg"><img src="screenshots/thumbs/63_LuckyBase__LuckyBase.jpg" width="100%"></a><br><sub><b>LuckyBase</b> › LuckyBase</sub></td>
<td width="33%" valign="top"><a href="screenshots/77_SecurityCam.jpg"><img src="screenshots/thumbs/77_SecurityCam.jpg" width="100%"></a><br><sub><b>SecurityCam</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/94_BasePosition__Base_Position.jpg"><img src="screenshots/thumbs/94_BasePosition__Base_Position.jpg" width="100%"></a><br><sub><b>BasePosition</b> › Base Position</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/95_News__News.jpg"><img src="screenshots/thumbs/95_News__News.jpg" width="100%"></a><br><sub><b>News</b> › News</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Trucks/Model.rbxm"><img src="screenshots/thumbs/models/01_Model.jpg" width="100%"></a><br><sub><b>Model</b><br><code>models/ReplicatedStorage/Models/Trucks/Model.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/1%20Year/AnniversaryMap/Brainrots/La%20Supreme%20Combinasion.rbxm"><img src="screenshots/thumbs/models/02_La_Supreme_Combinasion.jpg" width="100%"></a><br><sub><b>La Supreme Combinasion</b><br><code>models/ReplicatedStorage/Models/Events/1 Year/AnniversaryMap/Brainrots/La Supreme Combinasion.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ServerStorage/Skins/Summer/ThirdFloor.rbxm"><img src="screenshots/thumbs/models/03_ThirdFloor.jpg" width="100%"></a><br><sub><b>ThirdFloor</b><br><code>models/ServerStorage/Skins/Summer/ThirdFloor.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/Rap%20Concert/VFX/VFXDisco.rbxm"><img src="screenshots/thumbs/models/04_VFXDisco.jpg" width="100%"></a><br><sub><b>VFXDisco</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/Rap Concert/VFX/VFXDisco.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ServerScriptService/Services/EventService/Events/Eggrot%20Hunt/Islands/DivineSection/Base.rbxm"><img src="screenshots/thumbs/models/05_Base.jpg" width="100%"></a><br><sub><b>Base</b><br><code>models/ServerScriptService/Services/EventService/Events/Eggrot Hunt/Islands/DivineSection/Base.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/Egg%20City/EggCityMap/EnterableBuildings/EggBuilding~3.rbxm"><img src="screenshots/thumbs/models/06_EggBuilding_3.jpg" width="100%"></a><br><sub><b>EggBuilding~3</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/Egg City/EggCityMap/EnterableBuildings/EggBuilding~3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Items/Rainbowrath%20Sword.rbxm"><img src="screenshots/thumbs/models/07_Rainbowrath_Sword.jpg" width="100%"></a><br><sub><b>Rainbowrath Sword</b><br><code>models/ReplicatedStorage/Items/Rainbowrath Sword.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/Laser%20City/LaserCityMap/Decor/Boats/Sailboat.rbxm"><img src="screenshots/thumbs/models/08_Sailboat.jpg" width="100%"></a><br><sub><b>Sailboat</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/Laser City/LaserCityMap/Decor/Boats/Sailboat.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/SammyRoomController/Cutscene/Assets/GroundDecor/Trees/JungleTree.rbxm"><img src="screenshots/thumbs/models/09_JungleTree.jpg" width="100%"></a><br><sub><b>JungleTree</b><br><code>models/ReplicatedStorage/Controllers/SammyRoomController/Cutscene/Assets/GroundDecor/Trees/JungleTree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Tools/Flash%20Teleport/Ghost.rbxm"><img src="screenshots/thumbs/models/10_Ghost.jpg" width="100%"></a><br><sub><b>Ghost</b><br><code>models/ReplicatedStorage/Assets/Tools/Flash Teleport/Ghost.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/Matteo/RainbowTrees/Tree3.rbxm"><img src="screenshots/thumbs/models/11_Tree3.jpg" width="100%"></a><br><sub><b>Tree3</b><br><code>models/ReplicatedStorage/Models/Events/Matteo/RainbowTrees/Tree3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/EventController/Events/North%20Pole/EntranceSign.rbxm"><img src="screenshots/thumbs/models/12_EntranceSign.jpg" width="100%"></a><br><sub><b>EntranceSign</b><br><code>models/ReplicatedStorage/Controllers/EventController/Events/North Pole/EntranceSign.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Controllers/SammyRoomController/Cutscene/Assets/Lab/Walls/Wall~2.rbxm"><img src="screenshots/thumbs/models/13_Wall_2.jpg" width="100%"></a><br><sub><b>Wall~2</b><br><code>models/ReplicatedStorage/Controllers/SammyRoomController/Cutscene/Assets/Lab/Walls/Wall~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Models/Events/1%20Year/AnniversaryMap/Decor/HalloweenSection/BrainrotGrave1.rbxm"><img src="screenshots/thumbs/models/14_BrainrotGrave1.jpg" width="100%"></a><br><sub><b>BrainrotGrave1</b><br><code>models/ReplicatedStorage/Models/Events/1 Year/AnniversaryMap/Decor/HalloweenSection/BrainrotGrave1.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`AnimatedButton`](source/scripts/ReplicatedStorage/Classes/AnimatedButton.lua) <sub>107 lines</sub><br>[`Manager`](source/scripts/StarterGui/GamepassUI/Manager.client.lua) <sub>116 lines</sub><br>[`AnimalService`](source/scripts/ServerScriptService/Services/AnimalService.lua) <sub>3796 lines</sub><br>[`a`](source/scripts/ServerScriptService/a.server.lua) <sub>2060 lines</sub><br>[`x`](source/scripts/StarterPlayer/StarterPlayerScripts/x.client.lua) <sub>1304 lines</sub> |
| UI controllers / window managers / menus | [`Window`](source/scripts/ServerScriptService/Cmdr/CmdrClient/CmdrInterface/Window.lua) <sub>320 lines</sub><br>[`SettingsController`](source/scripts/ReplicatedStorage/Controllers/SettingsController.lua) <sub>505 lines</sub><br>[`a`](source/scripts/ServerScriptService/a.server.lua) <sub>2060 lines</sub><br>[`ShopController`](source/scripts/ReplicatedStorage/Controllers/ShopController.lua) <sub>2569 lines</sub><br>[`TradeController`](source/scripts/ReplicatedStorage/Controllers/TradeController.lua) <sub>1601 lines</sub> |
| Notifications, toasts, popups, prompts | [`CornerNotificationController`](source/scripts/ReplicatedStorage/Controllers/CornerNotificationController.lua) <sub>115 lines</sub><br>[`NotificationController`](source/scripts/ReplicatedStorage/Controllers/NotificationController.lua) <sub>194 lines</sub><br>[`CustomProximityPromptController`](source/scripts/ReplicatedStorage/Controllers/CustomProximityPromptController.lua) <sub>580 lines</sub><br>[`AnnouncementSCRIPT`](source/scripts/ReplicatedStorage/ReplicatedGui/Admin/Admin/Content/CanvasGroup/List/AnnouncementSCRIPT.client.lua) <sub>80 lines</sub><br>[`CodesController`](source/scripts/ReplicatedStorage/Controllers/CodesController.lua) <sub>118 lines</sub> |
| Loading / intro screens | [`LocalScript`](source/scripts/StarterPlayer/StarterPlayerScripts/LocalScript.client.lua) <sub>274 lines</sub><br>[`Phase 2_ Galaxy Introduction`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Phase%202_%20Galaxy%20Introduction.lua) <sub>342 lines</sub><br>[`FakePurchase`](source/scripts/ReplicatedStorage/FakePurchase.lua) <sub>697 lines</sub><br>[`Brazil`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Brazil.lua) <sub>733 lines</sub><br>[`FuseMachineController`](source/scripts/ReplicatedStorage/Controllers/FuseMachineController.lua) <sub>1663 lines</sub> |
| Camera, cutscenes, screen shake | [`SammyRoomController`](source/scripts/ReplicatedStorage/Controllers/SammyRoomController.lua) <sub>1678 lines</sub><br>[`Phase 2_ Galaxy Introduction`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Phase%202_%20Galaxy%20Introduction.lua) <sub>342 lines</sub><br>[`ShakePresets`](source/scripts/ReplicatedStorage/Shared/ShakePresets.lua) <sub>111 lines</sub><br>[`CameraController`](source/scripts/ReplicatedStorage/Controllers/CameraController.lua) <sub>60 lines</sub><br>[`Laser City`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Laser%20City.lua) <sub>241 lines</sub> |
| VFX, particles, beams, hit effects | [`Controller`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/Controller.server.lua) <sub>471 lines</sub><br>[`VFX`](source/scripts/ReplicatedStorage/Shared/VFX.lua) <sub>145 lines</sub><br>[`Starfall`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Starfall.lua) <sub>197 lines</sub><br>[`SkullEmojiEffectController`](source/scripts/ReplicatedStorage/Controllers/SkullEmojiEffectController.lua) <sub>158 lines</sub><br>[`ServerController`](source/scripts/ReplicatedStorage/Items/Flash%20Teleport/ServerController.server.lua) <sub>300 lines</sub> |
| DataStore / player data | [`ProfileStore`](source/scripts/ServerScriptService/Controllers/ProfileStore.lua) <sub>1950 lines</sub><br>[`HoverInfoService`](source/scripts/ServerScriptService/Services/HoverInfoService.lua) <sub>508 lines</sub><br>[`CodesService`](source/scripts/ServerScriptService/Services/CodesService.lua) <sub>560 lines</sub><br>[`a`](source/scripts/ServerScriptService/a.server.lua) <sub>2060 lines</sub><br>[`CodeSystemServer`](source/scripts/ServerScriptService/CodeSystemServer.server.lua) <sub>350 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`RobuxShopData`](source/scripts/ReplicatedStorage/Datas/RobuxShopData.lua) <sub>131 lines</sub><br>[`BrainrotShopService`](source/scripts/ServerScriptService/BrainrotShopService.server.lua) <sub>50 lines</sub><br>[`promptPurchaseServer`](source/scripts/ServerScriptService/Services/CmdrService/Commands/CustomCommands/promptPurchaseServer.lua) <sub>60 lines</sub><br>[`ShopController`](source/scripts/ReplicatedStorage/Controllers/ShopController.lua) <sub>2569 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`PhantomSpinWheelService`](source/scripts/ServerScriptService/Services/PhantomSpinWheelService.lua) <sub>167 lines</sub><br>[`AnimalService`](source/scripts/ServerScriptService/Services/AnimalService.lua) <sub>3796 lines</sub><br>[`Egg City`](source/scripts/ServerScriptService/Services/EventService/Events/Egg%20City.lua) <sub>393 lines</sub><br>[`Eggrot Hunt`](source/scripts/ServerScriptService/Services/EventService/Events/Eggrot%20Hunt.lua) <sub>699 lines</sub><br>[`PhantomEventController`](source/scripts/ReplicatedStorage/Controllers/PhantomEventController.lua) <sub>398 lines</sub> |
| Trading systems | [`TradeController`](source/scripts/ReplicatedStorage/Controllers/TradeController.lua) <sub>1601 lines</sub><br>[`TradePlazaPortalController`](source/scripts/ReplicatedStorage/Controllers/TradePlazaPortalController.lua) <sub>105 lines</sub><br>[`addbrainrotrader`](source/scripts/ServerScriptService/Services/CommandsService/Commands/addbrainrotrader.lua) <sub>238 lines</sub><br>[`TradeService`](source/scripts/ServerScriptService/Services/TradeService.lua) <sub>1812 lines</sub><br>[`TradingFlags`](source/scripts/ReplicatedStorage/Shared/Flags/TradingFlags.lua) <sub>32 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`StealService`](source/scripts/ServerScriptService/Services/StealService.lua) <sub>2032 lines</sub><br>[`Rip My Granny`](source/scripts/ServerScriptService/Services/EventService/Events/Rip%20My%20Granny.lua) <sub>588 lines</sub><br>[`Solar Flare`](source/scripts/ServerScriptService/Services/EventService/Events/Solar%20Flare.lua) <sub>562 lines</sub><br>[`Controller`](source/scripts/ReplicatedStorage/Items/Rainbowrath%20Sword/Controller.server.lua) <sub>150 lines</sub><br>[`North Pole`](source/scripts/ServerScriptService/Services/EventService/Events/North%20Pole.lua) <sub>1454 lines</sub> |
| NPC / AI / monsters | [`NpcPathfinding`](source/scripts/ServerScriptService/Components/NpcPathfinding.lua) <sub>391 lines</sub><br>[`Dul Dul Dul`](source/scripts/ServerScriptService/Services/EventService/Events/Dul%20Dul%20Dul.lua) <sub>452 lines</sub><br>[`AnimalService`](source/scripts/ServerScriptService/Services/AnimalService.lua) <sub>3796 lines</sub><br>[`Crab Rave`](source/scripts/ServerScriptService/Services/EventService/Events/Crab%20Rave.lua) <sub>678 lines</sub><br>[`Npc`](source/scripts/ReplicatedStorage/Components/Npc.lua) <sub>63 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`MultiJumpController`](source/scripts/ReplicatedStorage/Controllers/MultiJumpController.lua) <sub>485 lines</sub><br>[`TemuSword`](source/scripts/ReplicatedStorage/Items/Rainbowrath%20Sword/TemuSword.client.lua) <sub>58 lines</sub><br>[`fly`](source/scripts/ServerScriptService/Services/CommandsService/Commands/fly.lua) <sub>204 lines</sub><br>[`JumpShopTutorial`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Eggrot%20Hunt/JumpShopTutorial.lua) <sub>158 lines</sub><br>[`Controller`](source/scripts/ReplicatedStorage/Items/Ban%20Hammer/Controller.server.lua) <sub>471 lines</sub> |
| Tycoon / plots / bases / building | [`PlotClient`](source/scripts/ReplicatedStorage/Classes/PlotClient.lua) <sub>1853 lines</sub><br>[`Fake Base`](source/scripts/ReplicatedStorage/ReplicatedGui/Admin/Admin/Content/CanvasGroup/List/Fake%20Base.client.lua) <sub>269 lines</sub><br>[`a`](source/scripts/ServerScriptService/a.server.lua) <sub>2060 lines</sub><br>[`BasePositionController`](source/scripts/ReplicatedStorage/BasePosition/Base%20Position/BasePositionController.client.lua) <sub>55 lines</sub><br>[`Caylus Base`](source/scripts/ServerScriptService/Services/EventService/Events/Caylus%20Base.lua) <sub>625 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/Services/LeaderboardService.lua) <sub>948 lines</sub> |
| Admin panels & commands | [`Allcommand`](source/scripts/ServerScriptService/Services/CommandsService/Commands/Allcommand.lua) <sub>618 lines</sub><br>[`Giftcommand`](source/scripts/ServerScriptService/Services/CommandsService/Commands/Giftcommand.lua) <sub>847 lines</sub><br>[`CommandsService`](source/scripts/ServerScriptService/Services/CommandsService.lua) <sub>173 lines</sub><br>[`Newyearsmachinecommands`](source/scripts/ServerScriptService/Services/CommandsService/Commands/Newyearsmachinecommands.lua) <sub>205 lines</sub><br>[`RitualCommands1`](source/scripts/ServerScriptService/Services/CommandsService/Commands/RitualCommands1.lua) <sub>357 lines</sub> |
| Sound & music | [`SoundController`](source/scripts/ReplicatedStorage/Controllers/SoundController.lua) <sub>513 lines</sub><br>[`DualAudio`](source/scripts/ReplicatedStorage/Components/DualAudio.lua) <sub>45 lines</sub><br>[`Karkerkar Kurkur`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Karkerkar%20Kurkur.lua) <sub>295 lines</sub><br>[`Phase 5_ Sammy Snap`](source/scripts/ReplicatedStorage/Controllers/EventController/Events/Phase%205_%20Sammy%20Snap.lua) <sub>412 lines</sub> |
| Daily rewards, quests, codes, playtime | [`CodesService`](source/scripts/ServerScriptService/Services/CodesService.lua) <sub>560 lines</sub><br>[`CodeSystemServer`](source/scripts/ServerScriptService/CodeSystemServer.server.lua) <sub>350 lines</sub><br>[`CodeSystemClient`](source/scripts/StarterPlayer/StarterPlayerScripts/CodeSystemClient.client.lua) <sub>266 lines</sub><br>[`CodesController`](source/scripts/ReplicatedStorage/Controllers/CodesController.lua) <sub>118 lines</sub><br>[`LeaderboardService`](source/scripts/ServerScriptService/Services/LeaderboardService.lua) <sub>948 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Caylus Base`](source/scripts/ServerScriptService/Services/EventService/Events/Caylus%20Base.lua) <sub>625 lines</sub><br>[`Rusty's Base`](source/scripts/ServerScriptService/Services/EventService/Events/Rusty%27s%20Base.lua) <sub>625 lines</sub><br>[`Sammy's Base`](source/scripts/ServerScriptService/Services/EventService/Events/Sammy%27s%20Base.lua) <sub>623 lines</sub><br>[`Steak's Base`](source/scripts/ServerScriptService/Services/EventService/Events/Steak%27s%20Base.lua) <sub>625 lines</sub><br>[`MerchantController`](source/scripts/ReplicatedStorage/Controllers/MerchantController.lua) <sub>492 lines</sub> |

### In the curated script library

- [Jumpscare controller](../../Scripts/05-Camera-Cutscene/JumpscareController__steal-a-brainrot-sab-files.lua) — Full jumpscare: model flies at the camera, shake, flash, color/DOF effects, auto cleanup.
- [FOV / blur helper](../../Scripts/05-Camera-Cutscene/FovBlurHelper__steal-a-brainrot-sab-files.lua) — Two-function helper to tween FOV and blur.
- [Limited-stock codes (UpdateAsync + MemoryStore)](../../Scripts/18-Daily-Rewards-Quests/CodesService-AtomicStock__steal-a-brainrot-sab-files.lua) — Codes with limited stock redeemed atomically in UpdateAsync (already-redeemed / out-of-stock reasons), global codes broadcast with MessagingService and stock kept in a MemoryStore sorted map, 5s cooldown.
- [Code-built animated loading screen](../../Scripts/04-Loading-Screens/AnimatedLoadingScreen__steal-a-brainrot-sab-files.lua) — Fully code-built animated loading screen (gradient background, floating particles, title, progress bar driven by asset preloading) that fades out when done.
- [Anchored-NPC pathfinding module](../../Scripts/12-NPC-AI/NpcPathfindingChase__steal-a-brainrot-sab-files.lua) — Reusable module that moves anchored (non-Humanoid) NPC models along PathfindingService waypoints with ground-snapping raycasts, smooth turning, and a chase() loop that re-paths on a timer or when the target moves.
- [Steal guard rails (locks, cooldown, join protection)](../../Scripts/14-Tycoon-Plots/StealGuards__steal-a-brainrot-sab-files.lua) — The guard rails a later Steal-a-Brainrot build added around StartSteal: a per-podium steal lock so two thieves can't grab the same item, a 1s steal cooldown, no stealing from players who are...
- [VFX library](../../Scripts/06-VFX/VFXLibrary__steal-a-brainrot-sab-files.lua) — Compact VFX library: copy-to-position, follow, rescale, emit by attributes, tag-driven emit loops.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Packages/Freeze/List.lua`
- `scripts/ReplicatedStorage/Packages/Freeze/List/compat/findWhereLast.lua`
- `scripts/ServerScriptService/67.server.lua`
- `scripts/ServerScriptService/CmdrSetup.server.lua`
- `scripts/ServerScriptService/Services/CommandsService/Commands/ban.lua`
- `scripts/ServerScriptService/Services/CommandsService/Commands/lockbase.lua`
- `scripts/ServerScriptService/Services/CommandsService/Commands/pushserverluck.lua`
- `scripts/ServerScriptService/Services/CommandsService/Commands/pushserverluck.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
