# Steal an Egg (latest)

> 🧠 **Brainrot** · steal / tycoon (eggs, pets, plots) · source file `SLBR- VIP - SAE LATEST.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/44_Shop__LimitedStarterPack.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 79 ScreenGuis, 4477 GUI objects → **103 screenshots** |
| Models (.rbxm) | 526 models, 10 model sets, 90 VFX sets |
| Lua builders (.lua) | 375 UI screens, 25 animation packs, 9 audio packs |
| Code | 3167 scripts, 759,853 lines |
| Asset ids | 135 animations, 176 sounds |
| Safety scan | 58 HIGH / 15 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Rubik Bold`×522, `GothamSSm Bold`×124, `ComicNeueAngular Bold`×109, `GothamSSm ExtraBold`×82, `GothamSSm Heavy`×80

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/20_GearShop.jpg"><img src="screenshots/thumbs/20_GearShop.jpg" width="100%"></a><br><sub><b>GearShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_LimitedStarterPackOffer.jpg"><img src="screenshots/thumbs/25_LimitedStarterPackOffer.jpg" width="100%"></a><br><sub><b>LimitedStarterPackOffer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_Shop.jpg"><img src="screenshots/thumbs/41_Shop.jpg" width="100%"></a><br><sub><b>Shop</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/42_Shop__StarterPack.jpg"><img src="screenshots/thumbs/42_Shop__StarterPack.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame.Main.ScrollingFrame.StarterPack</sub></td>
<td width="33%" valign="top"><a href="screenshots/43_Shop__SecretStarterPack.jpg"><img src="screenshots/thumbs/43_Shop__SecretStarterPack.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame.Main.ScrollingFrame.SecretStarterPack</sub></td>
<td width="33%" valign="top"><a href="screenshots/44_Shop__LimitedStarterPack.jpg"><img src="screenshots/thumbs/44_Shop__LimitedStarterPack.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame.Main.ScrollingFrame.LimitedStarterPack</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/45_Shop__ServerLuck.jpg"><img src="screenshots/thumbs/45_Shop__ServerLuck.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame.Main.ScrollingFrame.ServerLuck</sub></td>
<td width="33%" valign="top"><a href="screenshots/46_Shop__TemporarySpeedBoosts.jpg"><img src="screenshots/thumbs/46_Shop__TemporarySpeedBoosts.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame.Main.ScrollingFrame.TemporarySpeedBoosts</sub></td>
<td width="33%" valign="top"><a href="screenshots/47_Shop__DoubleYourSpeed.jpg"><img src="screenshots/thumbs/47_Shop__DoubleYourSpeed.jpg" width="100%"></a><br><sub><b>Shop</b> › Frame.Main.ScrollingFrame.DoubleYourSpeed</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/55_TrailShop.jpg"><img src="screenshots/thumbs/55_TrailShop.jpg" width="100%"></a><br><sub><b>TrailShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/57_TreadmillShop.jpg"><img src="screenshots/thumbs/57_TreadmillShop.jpg" width="100%"></a><br><sub><b>TreadmillShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/58_TreadmillSpeedShop.jpg"><img src="screenshots/thumbs/58_TreadmillSpeedShop.jpg" width="100%"></a><br><sub><b>TreadmillSpeedShop</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_TreadmillSpeedShop__1.jpg"><img src="screenshots/thumbs/59_TreadmillSpeedShop__1.jpg" width="100%"></a><br><sub><b>TreadmillSpeedShop</b> › Frame.Main.ScrollingFrame.SpeedTop_oldtimer.1</sub></td>
<td width="33%" valign="top"><a href="screenshots/80_Put_me_in_StarterGui.jpg"><img src="screenshots/thumbs/80_Put_me_in_StarterGui.jpg" width="100%"></a><br><sub><b>Put me in StarterGui</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_InventoryTemplate.jpg"><img src="screenshots/thumbs/01_InventoryTemplate.jpg" width="100%"></a><br><sub><b>InventoryTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_HotbarTemplate.jpg"><img src="screenshots/thumbs/05_HotbarTemplate.jpg" width="100%"></a><br><sub><b>HotbarTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/09_BackpackGui__Backpack.jpg"><img src="screenshots/thumbs/09_BackpackGui__Backpack.jpg" width="100%"></a><br><sub><b>BackpackGui</b> › Backpack</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_FuseMachine__BackpackScrollingFrameContainer.jpg"><img src="screenshots/thumbs/18_FuseMachine__BackpackScrollingFrameContainer.jpg" width="100%"></a><br><sub><b>FuseMachine</b> › Main.FuseMachine.BackpackScrollingFrameContainer</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_PetList.jpg"><img src="screenshots/thumbs/34_PetList.jpg" width="100%"></a><br><sub><b>PetList</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_AdminPanel__GivePet.jpg"><img src="screenshots/thumbs/68_AdminPanel__GivePet.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › Main.Commands.GivePet</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/70_AdminPanel__PetSelector.jpg"><img src="screenshots/thumbs/70_AdminPanel__PetSelector.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › PetSelector</sub></td>
<td width="33%" valign="top"><a href="screenshots/81_ItemAlert.jpg"><img src="screenshots/thumbs/81_ItemAlert.jpg" width="100%"></a><br><sub><b>ItemAlert</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/87_Item.jpg"><img src="screenshots/thumbs/87_Item.jpg" width="100%"></a><br><sub><b>Item</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/96_PetLevel.jpg"><img src="screenshots/thumbs/96_PetLevel.jpg" width="100%"></a><br><sub><b>PetLevel</b></sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_Index.jpg"><img src="screenshots/thumbs/24_Index.jpg" width="100%"></a><br><sub><b>Index</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_Codes.jpg"><img src="screenshots/thumbs/11_Codes.jpg" width="100%"></a><br><sub><b>Codes</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_FreeGifts.jpg"><img src="screenshots/thumbs/16_FreeGifts.jpg" width="100%"></a><br><sub><b>FreeGifts</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/22_GroupReward.jpg"><img src="screenshots/thumbs/22_GroupReward.jpg" width="100%"></a><br><sub><b>GroupReward</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_OfflineCashAndAssetLevelGrew.jpg"><img src="screenshots/thumbs/31_OfflineCashAndAssetLevelGrew.jpg" width="100%"></a><br><sub><b>OfflineCashAndAssetLevelGrew</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/32_OfflineCashAndAssetLevelGrew__Template.jpg"><img src="screenshots/thumbs/32_OfflineCashAndAssetLevelGrew__Template.jpg" width="100%"></a><br><sub><b>OfflineCashAndAssetLevelGrew</b> › Frame.AssetsLevelGrowth.ScrollingFrame.Template</sub></td>
<td width="33%" valign="top"><a href="screenshots/33_OfflineCashOnly.jpg"><img src="screenshots/thumbs/33_OfflineCashOnly.jpg" width="100%"></a><br><sub><b>OfflineCashOnly</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/48_Shop__Gift.jpg"><img src="screenshots/thumbs/48_Shop__Gift.jpg" width="100%"></a><br><sub><b>Shop</b> › Gift</sub></td>
<td width="33%" valign="top"><a href="screenshots/62_TreadmillSpeedShop__Gift.jpg"><img src="screenshots/thumbs/62_TreadmillSpeedShop__Gift.jpg" width="100%"></a><br><sub><b>TreadmillSpeedShop</b> › Gift</sub></td>
<td width="33%" valign="top"><a href="screenshots/76_FollowRewardsUI__FollowUI.jpg"><img src="screenshots/thumbs/76_FollowRewardsUI__FollowUI.jpg" width="100%"></a><br><sub><b>FollowRewardsUI</b> › FollowUI</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/77_Rewards.jpg"><img src="screenshots/thumbs/77_Rewards.jpg" width="100%"></a><br><sub><b>Rewards</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/79_RewardsUI__Frame.jpg"><img src="screenshots/thumbs/79_RewardsUI__Frame.jpg" width="100%"></a><br><sub><b>RewardsUI</b> › Frame</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_DistanceProgression.jpg"><img src="screenshots/thumbs/12_DistanceProgression.jpg" width="100%"></a><br><sub><b>DistanceProgression</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/35_Rebirth.jpg"><img src="screenshots/thumbs/35_Rebirth.jpg" width="100%"></a><br><sub><b>Rebirth</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/85_Progress.jpg"><img src="screenshots/thumbs/85_Progress.jpg" width="100%"></a><br><sub><b>Progress</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/98_TutorialTask.jpg"><img src="screenshots/thumbs/98_TutorialTask.jpg" width="100%"></a><br><sub><b>TutorialTask</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/106_LevelDisplayUI.jpg"><img src="screenshots/thumbs/106_LevelDisplayUI.jpg" width="100%"></a><br><sub><b>LevelDisplayUI</b></sub></td>
</tr>
</table>

### Trading

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/51_TradeMessage.jpg"><img src="screenshots/thumbs/51_TradeMessage.jpg" width="100%"></a><br><sub><b>TradeMessage</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/52_TradePlayerList.jpg"><img src="screenshots/thumbs/52_TradePlayerList.jpg" width="100%"></a><br><sub><b>TradePlayerList</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_TradeWindow.jpg"><img src="screenshots/thumbs/53_TradeWindow.jpg" width="100%"></a><br><sub><b>TradeWindow</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/54_TradeWindow__ChatOverlay.jpg"><img src="screenshots/thumbs/54_TradeWindow__ChatOverlay.jpg" width="100%"></a><br><sub><b>TradeWindow</b> › Frame.ChatOverlay</sub></td>
<td width="33%" valign="top"><a href="screenshots/100_Trade.jpg"><img src="screenshots/thumbs/100_Trade.jpg" width="100%"></a><br><sub><b>Trade</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_Settings.jpg"><img src="screenshots/thumbs/40_Settings.jpg" width="100%"></a><br><sub><b>Settings</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_Message.jpg"><img src="screenshots/thumbs/26_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/49_StealDnaMessage.jpg"><img src="screenshots/thumbs/49_StealDnaMessage.jpg" width="100%"></a><br><sub><b>StealDnaMessage</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_TreadmillSpeedShop__Multiplier.jpg"><img src="screenshots/thumbs/61_TreadmillSpeedShop__Multiplier.jpg" width="100%"></a><br><sub><b>TreadmillSpeedShop</b> › Frame.Main.ScrollingFrame.UpgradeTreadmill.Pack.Multiplier</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/82_ItemAlert__Notification.jpg"><img src="screenshots/thumbs/82_ItemAlert__Notification.jpg" width="100%"></a><br><sub><b>ItemAlert</b> › Holder.ItemSlot.Notification</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_Notifications__Top.jpg"><img src="screenshots/thumbs/29_Notifications__Top.jpg" width="100%"></a><br><sub><b>Notifications</b> › Top</sub></td>
<td width="33%" valign="top"><a href="screenshots/50_StealDnaMessage__Top.jpg"><img src="screenshots/thumbs/50_StealDnaMessage__Top.jpg" width="100%"></a><br><sub><b>StealDnaMessage</b> › Frame.Top</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_GrowingEggList.jpg"><img src="screenshots/thumbs/23_GrowingEggList.jpg" width="100%"></a><br><sub><b>GrowingEggList</b></sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_FuseMachine.jpg"><img src="screenshots/thumbs/17_FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/65__MACHINES.jpg"><img src="screenshots/thumbs/65__MACHINES.jpg" width="100%"></a><br><sub><b>_MACHINES</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/67_AdminPanel.jpg"><img src="screenshots/thumbs/67_AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_AdminPanel__Info.jpg"><img src="screenshots/thumbs/69_AdminPanel__Info.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › Main.Info</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/03_Data__Composition.jpg"><img src="screenshots/thumbs/03_Data__Composition.jpg" width="100%"></a><br><sub><b>Data</b> › BottomRight.Composition</sub></td>
<td width="33%" valign="top"><a href="screenshots/10_BottomUI.jpg"><img src="screenshots/thumbs/10_BottomUI.jpg" width="100%"></a><br><sub><b>BottomUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_Elements2__RightFrame.jpg"><img src="screenshots/thumbs/15_Elements2__RightFrame.jpg" width="100%"></a><br><sub><b>Elements2</b> › RightFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Money.jpg"><img src="screenshots/thumbs/27_Money.jpg" width="100%"></a><br><sub><b>Money</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_Money__LuckHoverInfo.jpg"><img src="screenshots/thumbs/28_Money__LuckHoverInfo.jpg" width="100%"></a><br><sub><b>Money</b> › Bottom.Frame.BoostsList.Luck.LuckHoverInfo</sub></td>
<td width="33%" valign="top"><a href="screenshots/73_Elements__RightFrame.jpg"><img src="screenshots/thumbs/73_Elements__RightFrame.jpg" width="100%"></a><br><sub><b>Elements</b> › RightFrame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/89_Money.jpg"><img src="screenshots/thumbs/89_Money.jpg" width="100%"></a><br><sub><b>Money</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/95_Currency_.jpg"><img src="screenshots/thumbs/95_Currency_.jpg" width="100%"></a><br><sub><b>Currency___</b></sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_Rebirth__RequiredCharacters.jpg"><img src="screenshots/thumbs/36_Rebirth__RequiredCharacters.jpg" width="100%"></a><br><sub><b>Rebirth</b> › Content.Holder.HolderImage.RequiredCharacters</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_RoundChoices__EscapeAndKeep.jpg"><img src="screenshots/thumbs/04_RoundChoices__EscapeAndKeep.jpg" width="100%"></a><br><sub><b>RoundChoices</b> › EscapeAndKeep</sub></td>
<td width="33%" valign="top"><a href="screenshots/19_GameResetTimer.jpg"><img src="screenshots/thumbs/19_GameResetTimer.jpg" width="100%"></a><br><sub><b>GameResetTimer</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_Data.jpg"><img src="screenshots/thumbs/02_Data.jpg" width="100%"></a><br><sub><b>Data</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_AreaGui.jpg"><img src="screenshots/thumbs/06_AreaGui.jpg" width="100%"></a><br><sub><b>AreaGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_AssetHoverData.jpg"><img src="screenshots/thumbs/07_AssetHoverData.jpg" width="100%"></a><br><sub><b>AssetHoverData</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_AutoSell.jpg"><img src="screenshots/thumbs/08_AutoSell.jpg" width="100%"></a><br><sub><b>AutoSell</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/13_DropHeldEgg.jpg"><img src="screenshots/thumbs/13_DropHeldEgg.jpg" width="100%"></a><br><sub><b>DropHeldEgg</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_Elements2.jpg"><img src="screenshots/thumbs/14_Elements2.jpg" width="100%"></a><br><sub><b>Elements2</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_GetMoreSpeedOnHit.jpg"><img src="screenshots/thumbs/21_GetMoreSpeedOnHit.jpg" width="100%"></a><br><sub><b>GetMoreSpeedOnHit</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_Odds_UI.jpg"><img src="screenshots/thumbs/30_Odds_UI.jpg" width="100%"></a><br><sub><b>Odds_UI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/37_RunBackEffects.jpg"><img src="screenshots/thumbs/37_RunBackEffects.jpg" width="100%"></a><br><sub><b>RunBackEffects</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_RunButton.jpg"><img src="screenshots/thumbs/38_RunButton.jpg" width="100%"></a><br><sub><b>RunButton</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_RunCharge.jpg"><img src="screenshots/thumbs/39_RunCharge.jpg" width="100%"></a><br><sub><b>RunCharge</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/56_TreadmillClickX2__Frame.jpg"><img src="screenshots/thumbs/56_TreadmillClickX2__Frame.jpg" width="100%"></a><br><sub><b>TreadmillClickX2</b> › Frame</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/63_TutorialInstructions.jpg"><img src="screenshots/thumbs/63_TutorialInstructions.jpg" width="100%"></a><br><sub><b>TutorialInstructions</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/64_Vignette__Vignette.jpg"><img src="screenshots/thumbs/64_Vignette__Vignette.jpg" width="100%"></a><br><sub><b>Vignette</b> › Vignette</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_Elements.jpg"><img src="screenshots/thumbs/71_Elements.jpg" width="100%"></a><br><sub><b>Elements</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/74_Elements__Other.jpg"><img src="screenshots/thumbs/74_Elements__Other.jpg" width="100%"></a><br><sub><b>Elements</b> › Other</sub></td>
<td width="33%" valign="top"><a href="screenshots/75_Troll.jpg"><img src="screenshots/thumbs/75_Troll.jpg" width="100%"></a><br><sub><b>Troll</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/78_monetizationGUI.jpg"><img src="screenshots/thumbs/78_monetizationGUI.jpg" width="100%"></a><br><sub><b>monetizationGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/83_Award.jpg"><img src="screenshots/thumbs/83_Award.jpg" width="100%"></a><br><sub><b>Award</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/84_GlobalEvent.jpg"><img src="screenshots/thumbs/84_GlobalEvent.jpg" width="100%"></a><br><sub><b>GlobalEvent</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/86_Item2.jpg"><img src="screenshots/thumbs/86_Item2.jpg" width="100%"></a><br><sub><b>Item2</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/88_BiggestAssetWeight.jpg"><img src="screenshots/thumbs/88_BiggestAssetWeight.jpg" width="100%"></a><br><sub><b>BiggestAssetWeight</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/90_ExtraAsset.jpg"><img src="screenshots/thumbs/90_ExtraAsset.jpg" width="100%"></a><br><sub><b>ExtraAsset</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/91_Speed.jpg"><img src="screenshots/thumbs/91_Speed.jpg" width="100%"></a><br><sub><b>Speed</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/92_Frame.jpg"><img src="screenshots/thumbs/92_Frame.jpg" width="100%"></a><br><sub><b>Frame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/93_Frame__Hover_Effect.jpg"><img src="screenshots/thumbs/93_Frame__Hover_Effect.jpg" width="100%"></a><br><sub><b>Frame</b> › Holder.Frame.Accept.Hover_Effect</sub></td>
<td width="33%" valign="top"><a href="screenshots/99_Player.jpg"><img src="screenshots/thumbs/99_Player.jpg" width="100%"></a><br><sub><b>Player</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/101_Template.jpg"><img src="screenshots/thumbs/101_Template.jpg" width="100%"></a><br><sub><b>Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/102_Template.jpg"><img src="screenshots/thumbs/102_Template.jpg" width="100%"></a><br><sub><b>Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/103_GearTemplate.jpg"><img src="screenshots/thumbs/103_GearTemplate.jpg" width="100%"></a><br><sub><b>GearTemplate</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/104_Template.jpg"><img src="screenshots/thumbs/104_Template.jpg" width="100%"></a><br><sub><b>Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/105_Template.jpg"><img src="screenshots/thumbs/105_Template.jpg" width="100%"></a><br><sub><b>Template</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/107_Elements.jpg"><img src="screenshots/thumbs/107_Elements.jpg" width="100%"></a><br><sub><b>Elements</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/109_Value.jpg"><img src="screenshots/thumbs/109_Value.jpg" width="100%"></a><br><sub><b>Value</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Treadmills/DemonicTreadmill.rbxm"><img src="screenshots/thumbs/models/01_DemonicTreadmill.jpg" width="100%"></a><br><sub><b>DemonicTreadmill</b><br><code>models/ReplicatedStorage/Assets/Models/Treadmills/DemonicTreadmill.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/GearTools/ShopItems/Volcano%20Bat.rbxm"><img src="screenshots/thumbs/models/02_Volcano_Bat.jpg" width="100%"></a><br><sub><b>Volcano Bat</b><br><code>models/ReplicatedStorage/GearTools/ShopItems/Volcano Bat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Eggs/Alien%20Skeleton%20Boss.rbxm"><img src="screenshots/thumbs/models/03_Alien_Skeleton_Boss.jpg" width="100%"></a><br><sub><b>Alien Skeleton Boss</b><br><code>models/ReplicatedStorage/Assets/Models/Eggs/Alien Skeleton Boss.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/LuckyBlocks/Random%20Brainrot%20Block.rbxm"><img src="screenshots/thumbs/models/04_Random_Brainrot_Block.jpg" width="100%"></a><br><sub><b>Random Brainrot Block</b><br><code>models/ReplicatedStorage/Assets/Models/LuckyBlocks/Random Brainrot Block.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Eggs/Kitsune.rbxm"><img src="screenshots/thumbs/models/05_Kitsune.jpg" width="100%"></a><br><sub><b>Kitsune</b><br><code>models/ReplicatedStorage/Assets/Models/Eggs/Kitsune.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/GearTools/ShopItems/Demon%20Slap.rbxm"><img src="screenshots/thumbs/models/06_Demon_Slap.jpg" width="100%"></a><br><sub><b>Demon Slap</b><br><code>models/ReplicatedStorage/GearTools/ShopItems/Demon Slap.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/FuseMachine.rbxm"><img src="screenshots/thumbs/models/07_FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b><br><code>models/Workspace/FuseMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__OBJECTS/Leaderboards/Models/Leaderboard1.rbxm"><img src="screenshots/thumbs/models/08_Leaderboard1.jpg" width="100%"></a><br><sub><b>Leaderboard1</b><br><code>models/Workspace/__OBJECTS/Leaderboards/Models/Leaderboard1.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Abilities/SmokeBomb.rbxm"><img src="screenshots/thumbs/models/09_SmokeBomb.jpg" width="100%"></a><br><sub><b>SmokeBomb</b><br><code>models/ReplicatedStorage/Assets/Models/Abilities/SmokeBomb.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Plots/4.rbxm"><img src="screenshots/thumbs/models/10_4.jpg" width="100%"></a><br><sub><b>4</b><br><code>models/Workspace/Plots/4.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__OBJECTS/Build/SwampTree.rbxm"><img src="screenshots/thumbs/models/11_SwampTree.jpg" width="100%"></a><br><sub><b>SwampTree</b><br><code>models/Workspace/__OBJECTS/Build/SwampTree.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Treadmills/AngelicTreadmill.rbxm"><img src="screenshots/thumbs/models/12_AngelicTreadmill.jpg" width="100%"></a><br><sub><b>AngelicTreadmill</b><br><code>models/ReplicatedStorage/Assets/Models/Treadmills/AngelicTreadmill.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/GearTools/ShopItems/Jungle%20Bat.rbxm"><img src="screenshots/thumbs/models/13_Jungle_Bat.jpg" width="100%"></a><br><sub><b>Jungle Bat</b><br><code>models/ReplicatedStorage/GearTools/ShopItems/Jungle Bat.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__OBJECTS/Areas/GuardAreas/Desert.rbxm"><img src="screenshots/thumbs/models/14_Desert.jpg" width="100%"></a><br><sub><b>Desert</b><br><code>models/Workspace/__OBJECTS/Areas/GuardAreas/Desert.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6730 lines</sub><br>[`SpeedGainAnimation`](source/scripts/ReplicatedStorage/Library/Client/GUIFX/SpeedGainAnimation.lua) <sub>439 lines</sub><br>[`Index`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Index.client.lua) <sub>733 lines</sub><br>[`GuardTutorialPresentationComponent`](source/scripts/ReplicatedStorage/Library/Client/GuardTutorialPresentationComponent.lua) <sub>639 lines</sub><br>[`AssetHoverDataDisplay`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/AssetHoverDataDisplay.lua) <sub>487 lines</sub> |
| UI controllers / window managers / menus | [`TabController`](source/scripts/ReplicatedStorage/Library/Client/TabController.lua) <sub>441 lines</sub><br>[`Index`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Index.client.lua) <sub>733 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6730 lines</sub><br>[`TreadmillSpeedShop`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Shop/TreadmillSpeedShop.client.lua) <sub>134 lines</sub><br>[`MainShop`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Shop/MainShop.client.lua) <sub>180 lines</sub> |
| Notifications, toasts, popups, prompts | [`SpeedShopPrompt`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Shop/SpeedShopPrompt.client.lua) <sub>89 lines</sub><br>[`NotificationInstance`](source/scripts/ReplicatedStorage/Library/Client/NotificationCmds/NotificationInstance.lua) <sub>494 lines</sub><br>[`Notifications`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Trading/Notifications.lua) <sub>191 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6730 lines</sub><br>[`AssetDnaStealPrompt`](source/scripts/ReplicatedStorage/Library/Client/AssetDnaStealPrompt.lua) <sub>353 lines</sub> |
| Loading / intro screens | [`CircularSelection`](source/scripts/ReplicatedStorage/Library/Client/GUIFX/CircularSelection.lua) <sub>621 lines</sub><br>[`AddCurrencyScreen`](source/scripts/ReplicatedStorage/Library/Client/GUIFX/AddCurrencyScreen.lua) <sub>255 lines</sub><br>[`CustomFont`](source/scripts/ReplicatedStorage/Library/Client/UI/CustomFont.lua) <sub>831 lines</sub><br>[`DamageFeedback`](source/scripts/ReplicatedStorage/Library/Client/DamageFeedback.lua) <sub>39 lines</sub><br>[`AnimatedText`](source/scripts/ReplicatedStorage/Library/Client/UI/AnimatedText.lua) <sub>1074 lines</sub> |
| Camera, cutscenes, screen shake | [`Cutscene`](source/scripts/ReplicatedStorage/Library/Modules/Cutscene.lua) <sub>827 lines</sub><br>[`ShakePresets`](source/scripts/ReplicatedStorage/Library/Modules/ShakePresets.lua) <sub>118 lines</sub><br>[`ScaryEffectController`](source/scripts/ReplicatedStorage/Library/Client/ScaryEffectController.lua) <sub>589 lines</sub><br>[`TreadmillCharacterPresentationController`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/Plots/TreadmillCharacterPresentationController.lua) <sub>545 lines</sub><br>[`CameraShake`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/CameraShake.client.lua) <sub>14 lines</sub> |
| VFX, particles, beams, hit effects | [`AmazingImpactVFX`](source/scripts/ReplicatedStorage/Library/Client/GUIFX/AmazingImpactVFX.lua) <sub>123 lines</sub><br>[`Orb`](source/scripts/ReplicatedStorage/Library/Client/OrbCmds/Orb.lua) <sub>649 lines</sub><br>[`VFX`](source/scripts/ReplicatedStorage/Library/Modules/VFX.lua) <sub>142 lines</sub><br>[`Default`](source/scripts/ReplicatedStorage/Library/Modules/EffectController/Libraries/Default.lua) <sub>289 lines</sub><br>[`PeoUtils`](source/scripts/ReplicatedStorage/Library/Modules/PeoUtils.lua) <sub>357 lines</sub> |
| DataStore / player data | [`Core_PlayerData`](source/scripts/ServerScriptService/Core_PlayerData.lua) <sub>235 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`Core_Purchases`](source/scripts/ServerScriptService/Core_Purchases.lua) <sub>526 lines</sub><br>[`CashGrabPurchaseHandler`](source/scripts/ServerScriptService/CashGrabPurchaseHandler.server.lua) <sub>90 lines</sub><br>[`PromptPurchase`](source/scripts/ReplicatedStorage/Library/Shared/Functions/PromptPurchase.lua) <sub>430 lines</sub><br>[`PurchasePendingGUI`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/PurchasePendingGUI.client.lua) <sub>95 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`AssetRollUtil`](source/scripts/ReplicatedStorage/Library/Util/AssetRollUtil.lua) <sub>320 lines</sub><br>[`Core_Purchases`](source/scripts/ServerScriptService/Core_Purchases.lua) <sub>526 lines</sub><br>[`ItemDisplay`](source/scripts/ReplicatedStorage/Library/Modules/ItemDisplay.lua) <sub>859 lines</sub><br>[`EggItemUtil`](source/scripts/ReplicatedStorage/Library/Util/EggItemUtil.lua) <sub>460 lines</sub><br>[`Core_Eggs`](source/scripts/ServerScriptService/Core_Eggs.lua) <sub>1454 lines</sub> |
| Trading systems | [`TradingCmds`](source/scripts/ReplicatedStorage/Library/Client/TradingCmds.lua) <sub>395 lines</sub><br>[`TradeState`](source/scripts/ReplicatedStorage/Library/Client/TradingCmds/TradeState.lua) <sub>135 lines</sub><br>[`Trading`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Trading.client.lua) <sub>1235 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`MurderMysteryProjectileCast`](source/scripts/ReplicatedStorage/Library/Modules/MurderMysteryProjectileCast.lua) <sub>189 lines</sub><br>[`Hitbox`](source/scripts/ReplicatedStorage/Library/Modules/Hitbox.lua) <sub>738 lines</sub><br>[`HitboxClassLocal`](source/scripts/ReplicatedStorage/Library/Modules/Hitbox/HitboxClassLocal.client.lua) <sub>70 lines</sub><br>[`GunToolHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/Tools/GunToolHandler.client.lua) <sub>144 lines</sub><br>[`_scriptThatsUnderTrap`](source/scripts/ReplicatedStorage/GearTools/ShopItems/Trap/_scriptThatsUnderTrap.lua) <sub>388 lines</sub> |
| NPC / AI / monsters | [`SimplePath`](source/scripts/ReplicatedStorage/Library/Modules/SimplePath.lua) <sub>536 lines</sub><br>[`NPCMovement`](source/scripts/ReplicatedStorage/Library/Modules/NPCMovement.lua) <sub>605 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/AdminPanel.client.lua) <sub>1272 lines</sub><br>[`adhd`](source/scripts/ReplicatedStorage/Library/Modules/Animate/Sandbox/adhd.lua) <sub>897 lines</sub><br>[`original`](source/scripts/ReplicatedStorage/Library/Modules/Animate/Sandbox/original.lua) <sub>864 lines</sub><br>[`Core_Treadmills`](source/scripts/ServerScriptService/Core_Treadmills.lua) <sub>294 lines</sub><br>[`Physics`](source/scripts/ReplicatedStorage/Library/Modules/Physics.lua) <sub>135 lines</sub> |
| Tycoon / plots / bases / building | [`Index`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Index.client.lua) <sub>733 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6730 lines</sub><br>[`Core_Plots`](source/scripts/ServerScriptService/Core_Plots.lua) <sub>267 lines</sub><br>[`PlotUpgradeController`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/PlotUpgradeController.client.lua) <sub>255 lines</sub><br>[`TreadmillUpgrade`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/TreadmillUpgrade.client.lua) <sub>144 lines</sub> |
| Leaderboards & stats | [`LeaderboardManager`](source/scripts/ServerScriptService/LeaderboardManager.server.lua) <sub>109 lines</sub> |
| Admin panels & commands | [`AdminPanelHandler`](source/scripts/ServerScriptService/AdminPanelHandler.server.lua) <sub>218 lines</sub><br>[`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/AdminPanel.client.lua) <sub>1272 lines</sub><br>[`OrbCmds`](source/scripts/ReplicatedStorage/Library/Client/OrbCmds.lua) <sub>283 lines</sub> |
| Sound & music | [`Audio`](source/scripts/ReplicatedStorage/Library/Audio.lua) <sub>598 lines</sub><br>[`AssetSoundUtil`](source/scripts/ReplicatedStorage/Library/Util/AssetSoundUtil.lua) <sub>358 lines</sub><br>[`CreateMusicSound`](source/scripts/ReplicatedStorage/Library/Audio/CreateMusicSound.lua) <sub>32 lines</sub><br>[`Sounds`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/ObbyStages/BreakableBlocks/Sounds.lua) <sub>60 lines</sub><br>[`MusicController`](source/scripts/ReplicatedStorage/Library/Client/MusicController.lua) <sub>897 lines</sub> |
| Daily rewards, quests, codes, playtime | [`GroupRewards`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/GroupRewards.client.lua) <sub>175 lines</sub><br>[`Core_Compatibility`](source/scripts/ServerScriptService/Core_Compatibility.lua) <sub>447 lines</sub><br>[`ClaimRewardPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Index/ClaimRewardPanel.lua) <sub>37 lines</sub><br>[`Codes`](source/scripts/ReplicatedStorage/Library/Types/Codes.lua) <sub>108 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`Core_Purchases`](source/scripts/ServerScriptService/Core_Purchases.lua) <sub>526 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6730 lines</sub><br>[`ItemDisplay`](source/scripts/ReplicatedStorage/Library/Modules/ItemDisplay.lua) <sub>859 lines</sub><br>[`AssetRollUtil`](source/scripts/ReplicatedStorage/Library/Util/AssetRollUtil.lua) <sub>320 lines</sub><br>[`EggItemUtil`](source/scripts/ReplicatedStorage/Library/Util/EggItemUtil.lua) <sub>460 lines</sub> |

### In the curated script library

- [Dirty-only autosave + mirrors](../../Scripts/07-Data-Saving/PlayerData-DirtyAutosave__steal-an-egg.lua) — Small data core: deep reconcile, value sanitising on load, Update(changes, removals) that marks dirty and mirrors to attributes/leaderstats, autosave only for dirty players.
- [Idempotent receipts + server test](../../Scripts/08-Monetization/Core_Purchases__steal-an-egg.lua) — Product name routing by pattern (Money_500, Trail_X...), PurchaseId saved in the profile (ProcessedReceipts) plus an in-flight lock, a server pre-check before prompting, prompt cooldown, server-wide luck boost, gamepass sync on load.
- [Plot slots with revisioned owner snapshots](../../Scripts/14-Tycoon-Plots/Core_Plots__steal-an-egg.lua) — Plot slots with a revision number: assigns numbered plots, sets the sign (name + headshot), replicates owner-by-slot snapshots to clients, teleports to the plot on spawn, exposes plot capacity,...
- [Egg carry, claim and validated placement](../../Scripts/14-Tycoon-Plots/EggCarryAndPlacement__steal-an-egg.lua) — Carry-and-deliver plus validated placement: pick up an egg (distance <= 28 studs, one at a time, ownership check), drop/reset it, guards knock it out of your hands, crossing a separation line...
- [Remote binder with xpcall](../../Scripts/19-Utility/Core_Network-SafeBind__steal-an-egg.lua) — Creates remotes on demand in one folder (asserting the class), wraps every handler in xpcall with a traceback, and returns a friendly error from failed RemoteFunctions instead of throwing to the client.

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Directory/Products/_Index/Currency/Money_200000.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/Currency/Money_24000.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/Currency/Money_4000000.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/Currency/Money_800000.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/Currency/Money_8000000.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/LimitedEggs/Limited Egg x10.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/LimitedEggs/Limited Egg x3.lua`
- `scripts/ReplicatedStorage/Directory/Products/_Index/LimitedEggs/Limited Egg x50.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
