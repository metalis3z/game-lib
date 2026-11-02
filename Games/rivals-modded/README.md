# RIVALS (modded)

> 🔫 **Shooter** · arena FPS (duels) · source file `SLBR - RIVALS MODDED - BOOSTER.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/62_ShopSlot__Free.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 11 ScreenGuis, 1269 GUI objects → **107 screenshots** |
| Models (.rbxm) | 2429 models, 41 model sets, 6 VFX sets |
| Lua builders (.lua) | 282 UI screens, 1 animation packs, 51 audio packs |
| Code | 2154 scripts, 247,103 lines |
| Asset ids | 89 animations, 155 sounds |
| Safety scan | 0 HIGH / 8 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `Rubik Bold`×53, `Rubik Heavy`×41, `Rubik Medium`×35, `Rubik ExtraBold`×33, `Rubik SemiBold`×12

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_StoredStreakSlot.jpg"><img src="screenshots/thumbs/27_StoredStreakSlot.jpg" width="100%"></a><br><sub><b>StoredStreakSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/44_BattlePassRewardSlot.jpg"><img src="screenshots/thumbs/44_BattlePassRewardSlot.jpg" width="100%"></a><br><sub><b>BattlePassRewardSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/58_ShopSlot__Price.jpg"><img src="screenshots/thumbs/58_ShopSlot__Price.jpg" width="100%"></a><br><sub><b>ShopSlot</b> › Details.Buy.Price</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_ShopSlot__Locked.jpg"><img src="screenshots/thumbs/59_ShopSlot__Locked.jpg" width="100%"></a><br><sub><b>ShopSlot</b> › Details.Buy.Locked</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_ShopSlot__Robux.jpg"><img src="screenshots/thumbs/60_ShopSlot__Robux.jpg" width="100%"></a><br><sub><b>ShopSlot</b> › Details.Buy.Robux</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_ShopSlot__Limited.jpg"><img src="screenshots/thumbs/61_ShopSlot__Limited.jpg" width="100%"></a><br><sub><b>ShopSlot</b> › Details.Buy.Limited</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_ShopSlot__Free.jpg"><img src="screenshots/thumbs/62_ShopSlot__Free.jpg" width="100%"></a><br><sub><b>ShopSlot</b> › Details.Buy.Free</sub></td>
<td width="33%" valign="top"><a href="screenshots/63_ShopBigSlot.jpg"><img src="screenshots/thumbs/63_ShopBigSlot.jpg" width="100%"></a><br><sub><b>ShopBigSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/64_ShopBigSlot__Free.jpg"><img src="screenshots/thumbs/64_ShopBigSlot__Free.jpg" width="100%"></a><br><sub><b>ShopBigSlot</b> › Button.Buy.Free</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/65_ShopBigSlot__Limited.jpg"><img src="screenshots/thumbs/65_ShopBigSlot__Limited.jpg" width="100%"></a><br><sub><b>ShopBigSlot</b> › Button.Buy.Limited</sub></td>
<td width="33%" valign="top"><a href="screenshots/66_ShopBigSlot__Locked.jpg"><img src="screenshots/thumbs/66_ShopBigSlot__Locked.jpg" width="100%"></a><br><sub><b>ShopBigSlot</b> › Button.Buy.Locked</sub></td>
<td width="33%" valign="top"><a href="screenshots/67_ShopBigSlot__Price.jpg"><img src="screenshots/thumbs/67_ShopBigSlot__Price.jpg" width="100%"></a><br><sub><b>ShopBigSlot</b> › Button.Buy.Price</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/68_ShopBigSlot__Robux.jpg"><img src="screenshots/thumbs/68_ShopBigSlot__Robux.jpg" width="100%"></a><br><sub><b>ShopBigSlot</b> › Button.Buy.Robux</sub></td>
<td width="33%" valign="top"><a href="screenshots/74_CurrencySlot__Buy.jpg"><img src="screenshots/thumbs/74_CurrencySlot__Buy.jpg" width="100%"></a><br><sub><b>CurrencySlot</b> › Buy</sub></td>
<td width="33%" valign="top"><a href="screenshots/75_ShopEntryBuyButton.jpg"><img src="screenshots/thumbs/75_ShopEntryBuyButton.jpg" width="100%"></a><br><sub><b>ShopEntryBuyButton</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/76_ShopEntryBuyButton__Free.jpg"><img src="screenshots/thumbs/76_ShopEntryBuyButton__Free.jpg" width="100%"></a><br><sub><b>ShopEntryBuyButton</b> › Free</sub></td>
<td width="33%" valign="top"><a href="screenshots/85_InspectShopEntry.jpg"><img src="screenshots/thumbs/85_InspectShopEntry.jpg" width="100%"></a><br><sub><b>InspectShopEntry</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/94_InspectBundle.jpg"><img src="screenshots/thumbs/94_InspectBundle.jpg" width="100%"></a><br><sub><b>InspectBundle</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_ItemInterface.jpg"><img src="screenshots/thumbs/21_ItemInterface.jpg" width="100%"></a><br><sub><b>ItemInterface</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/84_InspectBackpackReward.jpg"><img src="screenshots/thumbs/84_InspectBackpackReward.jpg" width="100%"></a><br><sub><b>InspectBackpackReward</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/110_EquipmentClassSlot.jpg"><img src="screenshots/thumbs/110_EquipmentClassSlot.jpg" width="100%"></a><br><sub><b>EquipmentClassSlot</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_TeammateSlot__Streak.jpg"><img src="screenshots/thumbs/23_TeammateSlot__Streak.jpg" width="100%"></a><br><sub><b>TeammateSlot</b> › Container.Streak</sub></td>
<td width="33%" valign="top"><a href="screenshots/35_VideoAdRewards.jpg"><img src="screenshots/thumbs/35_VideoAdRewards.jpg" width="100%"></a><br><sub><b>VideoAdRewards</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_VideoAdRewards__Unavailable.jpg"><img src="screenshots/thumbs/36_VideoAdRewards__Unavailable.jpg" width="100%"></a><br><sub><b>VideoAdRewards</b> › Container.Unavailable</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/45_BattlePassRewardSlot__Claimed.jpg"><img src="screenshots/thumbs/45_BattlePassRewardSlot__Claimed.jpg" width="100%"></a><br><sub><b>BattlePassRewardSlot</b> › Container.Claimed</sub></td>
<td width="33%" valign="top"><a href="screenshots/51_RewardSlot__Reward.jpg"><img src="screenshots/thumbs/51_RewardSlot__Reward.jpg" width="100%"></a><br><sub><b>RewardSlot</b> › Reward</sub></td>
<td width="33%" valign="top"><a href="screenshots/92_SendOfflineGiftRewards.jpg"><img src="screenshots/thumbs/92_SendOfflineGiftRewards.jpg" width="100%"></a><br><sub><b>SendOfflineGiftRewards</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/95_SendBugRewards.jpg"><img src="screenshots/thumbs/95_SendBugRewards.jpg" width="100%"></a><br><sub><b>SendBugRewards</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/97_InternalViewRewardSlot.jpg"><img src="screenshots/thumbs/97_InternalViewRewardSlot.jpg" width="100%"></a><br><sub><b>InternalViewRewardSlot</b></sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/24_TeammateSlot__Level.jpg"><img src="screenshots/thumbs/24_TeammateSlot__Level.jpg" width="100%"></a><br><sub><b>TeammateSlot</b> › Container.Level</sub></td>
<td width="33%" valign="top"><a href="screenshots/38_DuelScoresTeamScoreNeededSlot__Progress.jpg"><img src="screenshots/thumbs/38_DuelScoresTeamScoreNeededSlot__Progress.jpg" width="100%"></a><br><sub><b>DuelScoresTeamScoreNeededSlot</b> › Container.Progress</sub></td>
<td width="33%" valign="top"><a href="screenshots/39_SideTaskSlot.jpg"><img src="screenshots/thumbs/39_SideTaskSlot.jpg" width="100%"></a><br><sub><b>SideTaskSlot</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/49_TaskSlot.jpg"><img src="screenshots/thumbs/49_TaskSlot.jpg" width="100%"></a><br><sub><b>TaskSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/50_TaskSlot__Unlocked.jpg"><img src="screenshots/thumbs/50_TaskSlot__Unlocked.jpg" width="100%"></a><br><sub><b>TaskSlot</b> › Unlocked</sub></td>
<td width="33%" valign="top"><a href="screenshots/78_TaskContainer.jpg"><img src="screenshots/thumbs/78_TaskContainer.jpg" width="100%"></a><br><sub><b>TaskContainer</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/96_ViewPermissionsRoles.jpg"><img src="screenshots/thumbs/96_ViewPermissionsRoles.jpg" width="100%"></a><br><sub><b>ViewPermissionsRoles</b></sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_SettingHotkeySlot.jpg"><img src="screenshots/thumbs/18_SettingHotkeySlot.jpg" width="100%"></a><br><sub><b>SettingHotkeySlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_SettingInputHotkeysSlot.jpg"><img src="screenshots/thumbs/41_SettingInputHotkeysSlot.jpg" width="100%"></a><br><sub><b>SettingInputHotkeysSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/43_LobbyButtonSlot.jpg"><img src="screenshots/thumbs/43_LobbyButtonSlot.jpg" width="100%"></a><br><sub><b>LobbyButtonSlot</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_SettingFrame.jpg"><img src="screenshots/thumbs/79_SettingFrame.jpg" width="100%"></a><br><sub><b>SettingFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/80_SettingFrame__Dropdown.jpg"><img src="screenshots/thumbs/80_SettingFrame__Dropdown.jpg" width="100%"></a><br><sub><b>SettingFrame</b> › Container.Controls.Container.Dropdown</sub></td>
<td width="33%" valign="top"><a href="screenshots/81_SettingFrame__Toggle.jpg"><img src="screenshots/thumbs/81_SettingFrame__Toggle.jpg" width="100%"></a><br><sub><b>SettingFrame</b> › Container.Controls.Container.Toggle</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/82_SettingFrame__Hotkey.jpg"><img src="screenshots/thumbs/82_SettingFrame__Hotkey.jpg" width="100%"></a><br><sub><b>SettingFrame</b> › Container.Controls.Container.Hotkey</sub></td>
<td width="33%" valign="top"><a href="screenshots/83_SettingFrame__Color.jpg"><img src="screenshots/thumbs/83_SettingFrame__Color.jpg" width="100%"></a><br><sub><b>SettingFrame</b> › Container.Controls.Container.Color</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_FighterInterface__Container.jpg"><img src="screenshots/thumbs/16_FighterInterface__Container.jpg" width="100%"></a><br><sub><b>FighterInterface</b> › WarningVignette.Container</sub></td>
<td width="33%" valign="top"><a href="screenshots/52_NotificationSlot.jpg"><img src="screenshots/thumbs/52_NotificationSlot.jpg" width="100%"></a><br><sub><b>NotificationSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_NotificationSlot__Container.jpg"><img src="screenshots/thumbs/53_NotificationSlot__Container.jpg" width="100%"></a><br><sub><b>NotificationSlot</b> › Visuals.Container</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/69_WarningCard.jpg"><img src="screenshots/thumbs/69_WarningCard.jpg" width="100%"></a><br><sub><b>WarningCard</b></sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_LoadingScreen__N.jpg"><img src="screenshots/thumbs/01_LoadingScreen__N.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › MainFrame.Logo.N</sub></td>
<td width="33%" valign="top"><a href="screenshots/03_LoadingScreen__Device.jpg"><img src="screenshots/thumbs/03_LoadingScreen__Device.jpg" width="100%"></a><br><sub><b>LoadingScreen</b> › MainFrame.Device</sub></td>
<td width="33%" valign="top"><a href="screenshots/103_MainGui__CameraFade.jpg"><img src="screenshots/thumbs/103_MainGui__CameraFade.jpg" width="100%"></a><br><sub><b>MainGui</b> › MainFrame.Equipment.CameraFade</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/10_DuelInterface__Scoreboard.jpg"><img src="screenshots/thumbs/10_DuelInterface__Scoreboard.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › Scoreboard</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_ScoreboardPlayerSlot.jpg"><img src="screenshots/thumbs/20_ScoreboardPlayerSlot.jpg" width="100%"></a><br><sub><b>ScoreboardPlayerSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/34_LeaderboardPlayerSlot.jpg"><img src="screenshots/thumbs/34_LeaderboardPlayerSlot.jpg" width="100%"></a><br><sub><b>LeaderboardPlayerSlot</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/105_MainGui__Top.jpg"><img src="screenshots/thumbs/105_MainGui__Top.jpg" width="100%"></a><br><sub><b>MainGui</b> › MainFrame.Equipment.Customize.Top</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_DuelInterface__Summary.jpg"><img src="screenshots/thumbs/08_DuelInterface__Summary.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › FinalResults.Summary</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_FinalResultsPlayerSlot.jpg"><img src="screenshots/thumbs/55_FinalResultsPlayerSlot.jpg" width="100%"></a><br><sub><b>FinalResultsPlayerSlot</b></sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_DuelInterface__LeftSpeaker.jpg"><img src="screenshots/thumbs/06_DuelInterface__LeftSpeaker.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › Top.StoryDialog.Container.LeftSpeaker</sub></td>
<td width="33%" valign="top"><a href="screenshots/07_DuelInterface__RightSpeaker.jpg"><img src="screenshots/thumbs/07_DuelInterface__RightSpeaker.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › Top.StoryDialog.Container.RightSpeaker</sub></td>
<td width="33%" valign="top"><a href="screenshots/54_ELOBar.jpg"><img src="screenshots/thumbs/54_ELOBar.jpg" width="100%"></a><br><sub><b>ELOBar</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/73_CurrencySlot.jpg"><img src="screenshots/thumbs/73_CurrencySlot.jpg" width="100%"></a><br><sub><b>CurrencySlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/102_MainGui.jpg"><img src="screenshots/thumbs/102_MainGui.jpg" width="100%"></a><br><sub><b>MainGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/104_MainGui__Bottom.jpg"><img src="screenshots/thumbs/104_MainGui__Bottom.jpg" width="100%"></a><br><sub><b>MainGui</b> › MainFrame.Equipment.Customize.Bottom</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/107_MainGui__Container.jpg"><img src="screenshots/thumbs/107_MainGui__Container.jpg" width="100%"></a><br><sub><b>MainGui</b> › Teleporting.Container</sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/04_DuelInterface.jpg"><img src="screenshots/thumbs/04_DuelInterface.jpg" width="100%"></a><br><sub><b>DuelInterface</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_DuelInterface__MatchPoint.jpg"><img src="screenshots/thumbs/05_DuelInterface__MatchPoint.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › Top.MatchPoint</sub></td>
<td width="33%" valign="top"><a href="screenshots/09_DuelInterface__ArcadeMode.jpg"><img src="screenshots/thumbs/09_DuelInterface__ArcadeMode.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › Voting.Maps.ArcadeMode</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/11_DuelInterface__UpNext.jpg"><img src="screenshots/thumbs/11_DuelInterface__UpNext.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › UpNext</sub></td>
<td width="33%" valign="top"><a href="screenshots/12_DuelInterface__HeadHoncho.jpg"><img src="screenshots/thumbs/12_DuelInterface__HeadHoncho.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › HeadHoncho</sub></td>
<td width="33%" valign="top"><a href="screenshots/13_DuelInterface__HardcoreParkour.jpg"><img src="screenshots/thumbs/13_DuelInterface__HardcoreParkour.jpg" width="100%"></a><br><sub><b>DuelInterface</b> › HardcoreParkour</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/19_SettingHotkeySlot__BackgroundFull.jpg"><img src="screenshots/thumbs/19_SettingHotkeySlot__BackgroundFull.jpg" width="100%"></a><br><sub><b>SettingHotkeySlot</b> › Edit.BackgroundFull</sub></td>
<td width="33%" valign="top"><a href="screenshots/22_TeammateSlot.jpg"><img src="screenshots/thumbs/22_TeammateSlot.jpg" width="100%"></a><br><sub><b>TeammateSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_MapSlot__Votes.jpg"><img src="screenshots/thumbs/26_MapSlot__Votes.jpg" width="100%"></a><br><sub><b>MapSlot</b> › Button.Votes</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/40_LocalQueuePlayerSlot.jpg"><img src="screenshots/thumbs/40_LocalQueuePlayerSlot.jpg" width="100%"></a><br><sub><b>LocalQueuePlayerSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/47_DuelHistorySlot.jpg"><img src="screenshots/thumbs/47_DuelHistorySlot.jpg" width="100%"></a><br><sub><b>DuelHistorySlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/48_DuelHistorySlot__Duelers.jpg"><img src="screenshots/thumbs/48_DuelHistorySlot__Duelers.jpg" width="100%"></a><br><sub><b>DuelHistorySlot</b> › Container.Duelers</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/71_MatchmakingQueueSlot.jpg"><img src="screenshots/thumbs/71_MatchmakingQueueSlot.jpg" width="100%"></a><br><sub><b>MatchmakingQueueSlot</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_MobileButton.jpg"><img src="screenshots/thumbs/14_MobileButton.jpg" width="100%"></a><br><sub><b>MobileButton</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_FighterInterface.jpg"><img src="screenshots/thumbs/15_FighterInterface.jpg" width="100%"></a><br><sub><b>FighterInterface</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/17_BowCharge.jpg"><img src="screenshots/thumbs/17_BowCharge.jpg" width="100%"></a><br><sub><b>BowCharge</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_MapSlot.jpg"><img src="screenshots/thumbs/25_MapSlot.jpg" width="100%"></a><br><sub><b>MapSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_PartyInviteSlot.jpg"><img src="screenshots/thumbs/28_PartyInviteSlot.jpg" width="100%"></a><br><sub><b>PartyInviteSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_PartyInviteSlot__Off.jpg"><img src="screenshots/thumbs/29_PartyInviteSlot__Off.jpg" width="100%"></a><br><sub><b>PartyInviteSlot</b> › Buttons.Challenge.Button.Off</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_PartyInviteSlot__Off.jpg"><img src="screenshots/thumbs/30_PartyInviteSlot__Off.jpg" width="100%"></a><br><sub><b>PartyInviteSlot</b> › Buttons.Invite.Button.Off</sub></td>
<td width="33%" valign="top"><a href="screenshots/31_PartyInviteSlot__Off.jpg"><img src="screenshots/thumbs/31_PartyInviteSlot__Off.jpg" width="100%"></a><br><sub><b>PartyInviteSlot</b> › Buttons.InviteExternal.Button.Off</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_EliminatedCard.jpg"><img src="screenshots/thumbs/32_EliminatedCard.jpg" width="100%"></a><br><sub><b>EliminatedCard</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_PartyMemberBigSlot.jpg"><img src="screenshots/thumbs/33_PartyMemberBigSlot.jpg" width="100%"></a><br><sub><b>PartyMemberBigSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/42_Crosshair.jpg"><img src="screenshots/thumbs/42_Crosshair.jpg" width="100%"></a><br><sub><b>Crosshair</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/46_CosmeticSlot.jpg"><img src="screenshots/thumbs/46_CosmeticSlot.jpg" width="100%"></a><br><sub><b>CosmeticSlot</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/56_WeaponSlot.jpg"><img src="screenshots/thumbs/56_WeaponSlot.jpg" width="100%"></a><br><sub><b>WeaponSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/57_WeaponSlot__Banned.jpg"><img src="screenshots/thumbs/57_WeaponSlot__Banned.jpg" width="100%"></a><br><sub><b>WeaponSlot</b> › Button.Banned</sub></td>
<td width="33%" valign="top"><a href="screenshots/70_PatchNotesSlot.jpg"><img src="screenshots/thumbs/70_PatchNotesSlot.jpg" width="100%"></a><br><sub><b>PatchNotesSlot</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/72_EliminationFeedSlot.jpg"><img src="screenshots/thumbs/72_EliminationFeedSlot.jpg" width="100%"></a><br><sub><b>EliminationFeedSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/77_PrivateServerPlayerSlot.jpg"><img src="screenshots/thumbs/77_PrivateServerPlayerSlot.jpg" width="100%"></a><br><sub><b>PrivateServerPlayerSlot</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/86_ViewRankedDetails.jpg"><img src="screenshots/thumbs/86_ViewRankedDetails.jpg" width="100%"></a><br><sub><b>ViewRankedDetails</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/87_ViewPlayerData.jpg"><img src="screenshots/thumbs/87_ViewPlayerData.jpg" width="100%"></a><br><sub><b>ViewPlayerData</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/88_Pardon.jpg"><img src="screenshots/thumbs/88_Pardon.jpg" width="100%"></a><br><sub><b>Pardon</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/89_Ban.jpg"><img src="screenshots/thumbs/89_Ban.jpg" width="100%"></a><br><sub><b>Ban</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/90_Unban.jpg"><img src="screenshots/thumbs/90_Unban.jpg" width="100%"></a><br><sub><b>Unban</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/91_Kick.jpg"><img src="screenshots/thumbs/91_Kick.jpg" width="100%"></a><br><sub><b>Kick</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/93_InspectConceptor.jpg"><img src="screenshots/thumbs/93_InspectConceptor.jpg" width="100%"></a><br><sub><b>InspectConceptor</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/98_Warn.jpg"><img src="screenshots/thumbs/98_Warn.jpg" width="100%"></a><br><sub><b>Warn</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/99_Restrict.jpg"><img src="screenshots/thumbs/99_Restrict.jpg" width="100%"></a><br><sub><b>Restrict</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/100_TeleportingGui.jpg"><img src="screenshots/thumbs/100_TeleportingGui.jpg" width="100%"></a><br><sub><b>TeleportingGui</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/101_InsetGui.jpg"><img src="screenshots/thumbs/101_InsetGui.jpg" width="100%"></a><br><sub><b>InsetGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/108_FlashbangGui.jpg"><img src="screenshots/thumbs/108_FlashbangGui.jpg" width="100%"></a><br><sub><b>FlashbangGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/109_FlashbangGui__Polaroid.jpg"><img src="screenshots/thumbs/109_FlashbangGui__Polaroid.jpg" width="100%"></a><br><sub><b>FlashbangGui</b> › Polaroid</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Hub/Important/Weapons/Nosniy.rbxm"><img src="screenshots/thumbs/models/01_Nosniy.jpg" width="100%"></a><br><sub><b>Nosniy</b><br><code>models/Workspace/Lobby/Hub/Important/Weapons/Nosniy.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Skin%20Case%203/Cerulean%20Axe.rbxm"><img src="screenshots/thumbs/models/02_Cerulean_Axe.jpg" width="100%"></a><br><sub><b>Cerulean Axe</b><br><code>models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Skin Case 3/Cerulean Axe.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/Police%20Car/CarProp/Base~2.rbxm"><img src="screenshots/thumbs/models/03_Base_2.jpg" width="100%"></a><br><sub><b>Base~2</b><br><code>models/ReplicatedStorage/Modules/Emotes/Police Car/CarProp/Base~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Festive%20Skin%20Case/Frost%20Warper.rbxm"><img src="screenshots/thumbs/models/04_Frost_Warper.jpg" width="100%"></a><br><sub><b>Frost Warper</b><br><code>models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Festive Skin Case/Frost Warper.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/Sleigh%20Ride/SleighProp/sleigh~2.rbxm"><img src="screenshots/thumbs/models/05_sleigh_2.jpg" width="100%"></a><br><sub><b>sleigh~2</b><br><code>models/ReplicatedStorage/Modules/Emotes/Sleigh Ride/SleighProp/sleigh~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Spooky%20Skin%20Case/Bucket%20of%20Candy/CandyLayer3.rbxm"><img src="screenshots/thumbs/models/06_CandyLayer3.jpg" width="100%"></a><br><sub><b>CandyLayer3</b><br><code>models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Spooky Skin Case/Bucket of Candy/CandyLayer3.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Lobby/Hub/Important/Duels/Queue%20Pad%20%233__x10.rbxm"><img src="screenshots/thumbs/models/07_Queue_Pad_3_x10.jpg" width="100%"></a><br><sub><b>Queue Pad #3__x10</b><br><code>models/Workspace/Lobby/Hub/Important/Duels/Queue Pad #3__x10.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/Surfing/SurfProp/board~2.rbxm"><img src="screenshots/thumbs/models/08_board_2.jpg" width="100%"></a><br><sub><b>board~2</b><br><code>models/ReplicatedStorage/Modules/Emotes/Surfing/SurfProp/board~2.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/X%20Marks%20The%20Spot/ShovelProp/shovel~2.rbxm"><img src="screenshots/thumbs/models/09_shovel_2.jpg" width="100%"></a><br><sub><b>shovel~2</b><br><code>models/ReplicatedStorage/Modules/Emotes/X Marks The Spot/ShovelProp/shovel~2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Assets/Misc/Portals/Glitter%20Warper/2.rbxm"><img src="screenshots/thumbs/models/10_2.jpg" width="100%"></a><br><sub><b>2</b><br><code>models/StarterPlayer/StarterPlayerScripts/Assets/Misc/Portals/Glitter Warper/2.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/X%20Marks%20The%20Spot/Objects/Key.rbxm"><img src="screenshots/thumbs/models/11_Key.jpg" width="100%"></a><br><sub><b>Key</b><br><code>models/ReplicatedStorage/Modules/Emotes/X Marks The Spot/Objects/Key.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Bundles/Street%20Sign.rbxm"><img src="screenshots/thumbs/models/12_Street_Sign.jpg" width="100%"></a><br><sub><b>Street Sign</b><br><code>models/StarterPlayer/StarterPlayerScripts/Assets/ViewModels/Bundles/Street Sign.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Assets/Misc/SmokeClouds/Beach%20Ball.rbxm"><img src="screenshots/thumbs/models/13_Beach_Ball.jpg" width="100%"></a><br><sub><b>Beach Ball</b><br><code>models/StarterPlayer/StarterPlayerScripts/Assets/Misc/SmokeClouds/Beach Ball.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Modules/Emotes/X%20Marks%20The%20Spot/Objects/Burger.rbxm"><img src="screenshots/thumbs/models/14_Burger.jpg" width="100%"></a><br><sub><b>Burger</b><br><code>models/ReplicatedStorage/Modules/Emotes/X Marks The Spot/Objects/Burger.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`NovaUI`](source/scripts/ReplicatedStorage/NovaUI.lua) <sub>712 lines</sub><br>[`AdminPanel_v2_Backup`](source/scripts/ServerStorage/AdminPanel_v2_Backup.client.lua) <sub>1555 lines</sub><br>[`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua) <sub>1850 lines</sub><br>[`AdminPanel_v1_Backup`](source/scripts/ServerStorage/AdminPanel_v1_Backup.client.lua) <sub>1127 lines</sub><br>[`Maps`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Pages/Maps.lua) <sub>482 lines</sub> |
| UI controllers / window managers / menus | [`UserInterfaceController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/UserInterfaceController.lua) <sub>310 lines</sub><br>[`Interface`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UserInterface/Equipment/Interface.lua) <sub>107 lines</sub><br>[`ItemInterface`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ClientReplicatedClasses/ClientFighter/ClientItem/ItemInterface.lua) <sub>271 lines</sub><br>[`RewardService`](source/scripts/ServerScriptService/Server/RewardService.lua) <sub>275 lines</sub><br>[`HUD`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UserInterface/HUD.lua) <sub>113 lines</sub> |
| Notifications, toasts, popups, prompts | [`NovaUI`](source/scripts/ReplicatedStorage/NovaUI.lua) <sub>712 lines</sub><br>[`QueuePadService`](source/scripts/ServerScriptService/Server/QueuePadService.lua) <sub>439 lines</sub><br>[`ProximityPromptController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/ProximityPromptController.lua) <sub>184 lines</sub><br>[`Notifications`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UserInterface/Notifications.lua) <sub>112 lines</sub><br>[`WarningMessages`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UserInterface/WarningMessages.lua) <sub>122 lines</sub> |
| Loading / intro screens | [`LoadingScreen`](source/scripts/ReplicatedFirst/Root/LoadingScreen.lua) <sub>295 lines</sub><br>[`Emote`](source/scripts/ReplicatedStorage/Modules/Emote.lua) <sub>386 lines</sub><br>[`ClientGiantChombie`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ClientReplicatedClasses/Enemies/ClientGiantChombie.lua) <sub>98 lines</sub><br>[`Zombie Tower`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Maps/Zombie%20Tower.lua) <sub>541 lines</sub><br>[`UILoadingDots`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/GameComponents/UILoadingDots.lua) <sub>36 lines</sub> |
| Camera, cutscenes, screen shake | [`CameraController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CameraController.lua) <sub>717 lines</sub><br>[`CameraShaker`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/CameraShaker.lua) <sub>156 lines</sub><br>[`ViewportCameras`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ViewportCameras.lua) <sub>43 lines</sub><br>[`Camera`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/UserInterface/Equipment/Camera.lua) <sub>301 lines</sub><br>[`CameraShakeInstance`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/CameraShaker/CameraShakeInstance.lua) <sub>159 lines</sub> |
| VFX, particles, beams, hit effects | [`FlashbangEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Functions/FlashbangEffect.lua) <sub>44 lines</sub><br>[`LootboxEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Functions/LootboxEffect.lua) <sub>155 lines</sub><br>[`ViewModelParticlesLogic`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ViewModelParticlesLogic.lua) <sub>82 lines</sub><br>[`Paintball Gun`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Items/Paintball%20Gun.lua) <sub>151 lines</sub><br>[`TracerEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/TracerEffect.lua) <sub>165 lines</sub> |
| DataStore / player data | [`PlayerDataService`](source/scripts/ServerScriptService/Server/PlayerDataService.lua) <sub>272 lines</sub><br>[`LeaderboardService`](source/scripts/ServerScriptService/Server/LeaderboardService.lua) <sub>224 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`MonetizationController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/MonetizationController.lua) <sub>226 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`Lucky`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/PatchNotes/Lucky.lua) <sub>171 lines</sub><br>[`ItemService`](source/scripts/ServerScriptService/Server/ItemService.lua) <sub>1715 lines</sub><br>[`CosmeticLibrary`](source/scripts/ReplicatedStorage/Modules/CosmeticLibrary.lua) <sub>9302 lines</sub><br>[`EmoteWheel`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/EmoteWheel.lua) <sub>323 lines</sub><br>[`LootboxEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Functions/LootboxEffect.lua) <sub>155 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`ItemService`](source/scripts/ServerScriptService/Server/ItemService.lua) <sub>1715 lines</sub><br>[`Projectiles`](source/scripts/ServerScriptService/Server/Projectiles.lua) <sub>220 lines</sub><br>[`DamageNumbers_ToppleStyle_Backup`](source/scripts/ServerStorage/DamageNumbers_ToppleStyle_Backup.lua) <sub>259 lines</sub><br>[`ClientItem`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ClientReplicatedClasses/ClientFighter/ClientItem.lua) <sub>415 lines</sub><br>[`EnemyService`](source/scripts/ServerScriptService/Server/EnemyService.lua) <sub>329 lines</sub> |
| NPC / AI / monsters | [`EnemyService`](source/scripts/ServerScriptService/Server/EnemyService.lua) <sub>329 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Gameplay`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ClientReplicatedClasses/ClientFighter/ClientFighterCharacter/Gameplay.lua) <sub>171 lines</sub><br>[`ItemService`](source/scripts/ServerScriptService/Server/ItemService.lua) <sub>1715 lines</sub><br>[`FighterService`](source/scripts/ServerScriptService/Server/FighterService.lua) <sub>414 lines</sub><br>[`Slider`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Settings/Slider.lua) <sub>281 lines</sub><br>[`MechanicsController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/MechanicsController.lua) <sub>1452 lines</sub> |
| Tycoon / plots / bases / building | [`NovaUI`](source/scripts/ReplicatedStorage/NovaUI.lua) <sub>712 lines</sub><br>[`UGCShop`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/Pages/UGCShop.lua) <sub>348 lines</sub><br>[`AdminPanel_v1_Backup`](source/scripts/ServerStorage/AdminPanel_v1_Backup.client.lua) <sub>1127 lines</sub><br>[`AdminPanel_v2_Backup`](source/scripts/ServerStorage/AdminPanel_v2_Backup.client.lua) <sub>1555 lines</sub><br>[`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua) <sub>1850 lines</sub> |
| Leaderboards & stats | [`LeaderboardService`](source/scripts/ServerScriptService/Server/LeaderboardService.lua) <sub>224 lines</sub> |
| Admin panels & commands | [`AdminPanelService`](source/scripts/ServerScriptService/Server/AdminPanelService.lua) <sub>719 lines</sub><br>[`AdminPanel_v1_Backup`](source/scripts/ServerStorage/AdminPanel_v1_Backup.client.lua) <sub>1127 lines</sub><br>[`AdminPanel_v2_Backup`](source/scripts/ServerStorage/AdminPanel_v2_Backup.client.lua) <sub>1555 lines</sub><br>[`AdminPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/AdminPanel.client.lua) <sub>1850 lines</sub><br>[`ModerationLibrary`](source/scripts/ReplicatedStorage/Modules/ModerationLibrary.lua) <sub>135 lines</sub> |
| Sound & music | [`MusicController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/MusicController.lua) <sub>337 lines</sub><br>[`Minigun`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ViewModels/Minigun.lua) <sub>237 lines</sub><br>[`AudioVisualizers`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ClientReplicatedClasses/ClientFighter/FighterInterface/AudioVisualizers.lua) <sub>198 lines</sub><br>[`SoundLibrary`](source/scripts/ReplicatedStorage/Modules/SoundLibrary.lua) <sub>77 lines</sub><br>[`Sounds`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/ClientReplicatedClasses/ClientFighter/ClientFighterCharacter/Sounds.lua) <sub>120 lines</sub> |
| Daily rewards, quests, codes, playtime | [`RewardService`](source/scripts/ServerScriptService/Server/RewardService.lua) <sub>275 lines</sub><br>[`DailyService`](source/scripts/ServerScriptService/Server/DailyService.lua) <sub>62 lines</sub><br>[`ShopService`](source/scripts/ServerScriptService/Server/ShopService.lua) <sub>278 lines</sub><br>[`DataTemplate`](source/scripts/ServerScriptService/Server/DataTemplate.lua) <sub>186 lines</sub><br>[`VideoAdRewards`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/VideoAdRewards.lua) <sub>256 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`DamageNumbers_ToppleStyle_Backup`](source/scripts/ServerStorage/DamageNumbers_ToppleStyle_Backup.lua) <sub>259 lines</sub><br>[`DamageNumbers`](source/scripts/StarterPlayer/StarterPlayerScripts/Modules/DamageNumbers.lua) <sub>200 lines</sub><br>[`AdminPanelService`](source/scripts/ServerScriptService/Server/AdminPanelService.lua) <sub>719 lines</sub><br>[`DebugService`](source/scripts/ServerScriptService/Server/DebugService.lua) <sub>236 lines</sub><br>[`ShopService`](source/scripts/ServerScriptService/Server/ShopService.lua) <sub>278 lines</sub> |

### In the curated script library

- [Server-simulated projectiles](../../Scripts/11-Combat/ServerProjectiles__rivals-modded.lua) — Server projectile simulation: spherecast sweeps, crits, pierce limit, explode on stop, afterburn.
- [Damage numbers (toss style)](../../Scripts/11-Combat/DamageNumbersToss__rivals-modded.lua) — Damage numbers that accumulate in place and get tossed away spinning (Rivals look).
- [Damage numbers (topple style)](../../Scripts/11-Combat/DamageNumbersTopple__rivals-modded.lua) — Per-hit numbers that topple over + combo total after a pause.
- [Daily reset at 00:00 UTC](../../Scripts/18-Daily-Rewards-Quests/DailyService-UTCReset__rivals-modded.lua) — Day number = os.time() // 86400; on join and every 15s it resets daily counters, refreshes the daily shop and rolls new daily tasks when the day changes (and tells TaskService if a day was missed).
- [Event-driven quests (beginner + daily)](../../Scripts/18-Daily-Rewards-Quests/TaskService-EventQuests__rivals-modded.lua) — Quests progress from events (TaskService.Record(player, 'DuelWon')), beginner sets of three until finished, then three daily Core tasks; completing a set grants rewards and keeps a daily streak.
- [Login reward, codes, group/like rewards](../../Scripts/18-Daily-Rewards-Quests/ClaimService-LoginCodesSocial__rivals-modded.lua) — Once-per-day login reward, one-off social rewards (group checked with IsInGroup; like/favourite trusted because Roblox cannot check them), battle-pass tier claims with validation, and a case-insensitive code table saved per player.
- [ProfileStore session + legacy import](../../Scripts/07-Data-Saving/PlayerDataService-ProfileStore__rivals-modded.lua) — ProfileStore usage: StartSessionAsync with Cancel, OnSessionEnd kick, OnSave hook that encodes data, one-time import from an older plain DataStore, server-validated settings remotes.
- [Template built by functions + reconcile](../../Scripts/07-Data-Saving/DataTemplate__rivals-modded.lua) — Data template as a New() function (fresh tables every call), per-season record ensured on load, and a shallow Reconcile for fields added later.
- [Live merge + write-on-change](../../Scripts/15-Leaderboards/LeaderboardService-LiveMerge__rivals-modded.lua) — Reads each board's top every minute, merges everyone in the server at their live value so a new win shows instantly, writes only values that changed, request cooldown and name validation on the client remote.
- [Staged client bootstrap with progress](../../Scripts/04-Loading-Screens/StagedBootstrap__rivals-modded.lua) — Client entry point that drives a loading screen through stages (game loaded 30%, constants 45%, player data 75%, controllers 100%), asks the device type when ambiguous, and always tells the server LoadingScreenDone so it spawns the character.
- [Fallback handlers + remote logger (dev tool)](../../Scripts/19-Utility/RemoteFallbacks-DevTool__rivals-modded.lua) — Gives every RemoteFunction that has no handler one that returns nil (so clients never hang forever) and logs the first calls to each remote with argument types.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
