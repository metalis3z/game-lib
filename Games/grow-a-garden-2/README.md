# Grow a Garden 2 (GAG2)

> ⛏️ **Simulator** · farming / garden simulator · source file `Grow A Garden 2 -.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/04_RobuxShop__Gacha.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 76 ScreenGuis, 4009 GUI objects → **82 screenshots** |
| Models (.rbxm) | 469 models, 1 model sets, 30 VFX sets |
| Lua builders (.lua) | 110 UI screens, 56 animation packs, 1 audio packs |
| Code | 1122 scripts, 245,773 lines |
| Asset ids | 165 animations, 189 sounds |
| Safety scan | 0 HIGH / 4 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `ComicNeueAngular Bold`×938, `SourceSansPro Bold`×320, `SourceSansPro Regular`×259, `ComicNeueAngular Regular`×94, `ComicNeueAngular SemiBold`×21

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_RobuxShop.jpg"><img src="screenshots/thumbs/02_RobuxShop.jpg" width="100%"></a><br><sub><b>RobuxShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_RobuxShop__StarterPack.jpg"><img src="screenshots/thumbs/03_RobuxShop__StarterPack.jpg" width="100%"></a><br><sub><b>RobuxShop</b> › Frame.ScrollingFrame.StarterPack</sub></td>
<td width="33%" valign="top"><a href="screenshots/04_RobuxShop__Gacha.jpg"><img src="screenshots/thumbs/04_RobuxShop__Gacha.jpg" width="100%"></a><br><sub><b>RobuxShop</b> › Frame.ScrollingFrame.Gacha</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_GuildShop.jpg"><img src="screenshots/thumbs/08_GuildShop.jpg" width="100%"></a><br><sub><b>GuildShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_CrateShop.jpg"><img src="screenshots/thumbs/19_CrateShop.jpg" width="100%"></a><br><sub><b>CrateShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_CrateShop__Robux_Shelf.jpg"><img src="screenshots/thumbs/21_CrateShop__Robux_Shelf.jpg" width="100%"></a><br><sub><b>CrateShop</b> › Frame.ScrollingFrame.Robux_Shelf</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_CrateShop__Sheckles_Shelf.jpg"><img src="screenshots/thumbs/22_CrateShop__Sheckles_Shelf.jpg" width="100%"></a><br><sub><b>CrateShop</b> › Frame.ScrollingFrame.Sheckles_Shelf</sub></td>
<td width="33%" valign="top"><a href="screenshots/23_GearShop.jpg"><img src="screenshots/thumbs/23_GearShop.jpg" width="100%"></a><br><sub><b>GearShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_GearShop__Robux_Shelf.jpg"><img src="screenshots/thumbs/25_GearShop__Robux_Shelf.jpg" width="100%"></a><br><sub><b>GearShop</b> › Frame.ScrollingFrame.Robux_Shelf</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_GearShop__Sheckles_Shelf.jpg"><img src="screenshots/thumbs/26_GearShop__Sheckles_Shelf.jpg" width="100%"></a><br><sub><b>GearShop</b> › Frame.ScrollingFrame.Sheckles_Shelf</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_PreRobuxPrompt.jpg"><img src="screenshots/thumbs/32_PreRobuxPrompt.jpg" width="100%"></a><br><sub><b>PreRobuxPrompt</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_PremiumSeedShop.jpg"><img src="screenshots/thumbs/33_PremiumSeedShop.jpg" width="100%"></a><br><sub><b>PremiumSeedShop</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/35_PremiumSeedShop__Shelf.jpg"><img src="screenshots/thumbs/35_PremiumSeedShop__Shelf.jpg" width="100%"></a><br><sub><b>PremiumSeedShop</b> › Frame.ScrollingFrame.Shelf</sub></td>
<td width="33%" valign="top"><a href="screenshots/42_SeedShop.jpg"><img src="screenshots/thumbs/42_SeedShop.jpg" width="100%"></a><br><sub><b>SeedShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/44_SeedShop__Sheckles_Shelf.jpg"><img src="screenshots/thumbs/44_SeedShop__Sheckles_Shelf.jpg" width="100%"></a><br><sub><b>SeedShop</b> › Frame.NormalShop.Sheckles_Shelf</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/45_SeedShop__Robux_Shelf.jpg"><img src="screenshots/thumbs/45_SeedShop__Robux_Shelf.jpg" width="100%"></a><br><sub><b>SeedShop</b> › Frame.NormalShop.Robux_Shelf</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_RobuxShop__Pets.jpg"><img src="screenshots/thumbs/05_RobuxShop__Pets.jpg" width="100%"></a><br><sub><b>RobuxShop</b> › Frame.ScrollingFrame.Pets</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_CrateShop__ItemTemplate.jpg"><img src="screenshots/thumbs/20_CrateShop__ItemTemplate.jpg" width="100%"></a><br><sub><b>CrateShop</b> › Frame.ScrollingFrame.ItemTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/24_GearShop__ItemTemplate.jpg"><img src="screenshots/thumbs/24_GearShop__ItemTemplate.jpg" width="100%"></a><br><sub><b>GearShop</b> › Frame.ScrollingFrame.ItemTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_PremiumSeedShop__ItemTemplate.jpg"><img src="screenshots/thumbs/34_PremiumSeedShop__ItemTemplate.jpg" width="100%"></a><br><sub><b>PremiumSeedShop</b> › Frame.ScrollingFrame.ItemTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/43_SeedShop__ItemTemplate.jpg"><img src="screenshots/thumbs/43_SeedShop__ItemTemplate.jpg" width="100%"></a><br><sub><b>SeedShop</b> › Frame.NormalShop.ItemTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/46_SeedShop__ItemFrame_Secret.jpg"><img src="screenshots/thumbs/46_SeedShop__ItemFrame_Secret.jpg" width="100%"></a><br><sub><b>SeedShop</b> › Frame.ExclusiveShop.ItemFrame_Secret</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/47_SeedShop__ItemFrame_Super.jpg"><img src="screenshots/thumbs/47_SeedShop__ItemFrame_Super.jpg" width="100%"></a><br><sub><b>SeedShop</b> › Frame.ExclusiveShop.ItemFrame_Super</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_SeedShop__ItemFrame_Exotic.jpg"><img src="screenshots/thumbs/48_SeedShop__ItemFrame_Exotic.jpg" width="100%"></a><br><sub><b>SeedShop</b> › Frame.ExclusiveShop.ItemFrame_Exotic</sub></td>
<td width="33%" valign="top"><a href="screenshots/52_PlayerGardenMarket__Inventory.jpg"><img src="screenshots/thumbs/52_PlayerGardenMarket__Inventory.jpg" width="100%"></a><br><sub><b>PlayerGardenMarket</b> › Inventory</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_MailboxUI__ItemSendFrame.jpg"><img src="screenshots/thumbs/59_MailboxUI__ItemSendFrame.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.SendingFrame.ItemSendFrame</sub></td>
<td width="33%" valign="top"><a href="screenshots/71_PetList.jpg"><img src="screenshots/thumbs/71_PetList.jpg" width="100%"></a><br><sub><b>PetList</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/72_EquipPet.jpg"><img src="screenshots/thumbs/72_EquipPet.jpg" width="100%"></a><br><sub><b>EquipPet</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/75_PetInfo.jpg"><img src="screenshots/thumbs/75_PetInfo.jpg" width="100%"></a><br><sub><b>PetInfo</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/37_Gifting.jpg"><img src="screenshots/thumbs/37_Gifting.jpg" width="100%"></a><br><sub><b>Gifting</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/54_MailboxUI__GiftTemplate.jpg"><img src="screenshots/thumbs/54_MailboxUI__GiftTemplate.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.RecieveFrame.GiftTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/56_MailboxUI__GuildRewardTemplate.jpg"><img src="screenshots/thumbs/56_MailboxUI__GuildRewardTemplate.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.RecieveFrame.GuildRewardTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/57_MailboxUI__GuildRewardTemplate_Owner.jpg"><img src="screenshots/thumbs/57_MailboxUI__GuildRewardTemplate_Owner.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.RecieveFrame.GuildRewardTemplate_Owner</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_MailboxUI__GuildRewardTemplate_Elder.jpg"><img src="screenshots/thumbs/58_MailboxUI__GuildRewardTemplate_Elder.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.RecieveFrame.GuildRewardTemplate_Elder</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/15_GardenLevel.jpg"><img src="screenshots/thumbs/15_GardenLevel.jpg" width="100%"></a><br><sub><b>GardenLevel</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_ViewGuildProgress.jpg"><img src="screenshots/thumbs/69_ViewGuildProgress.jpg" width="100%"></a><br><sub><b>ViewGuildProgress</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/70_ViewGuildProgress__GuildProgressOLD.jpg"><img src="screenshots/thumbs/70_ViewGuildProgress__GuildProgressOLD.jpg" width="100%"></a><br><sub><b>ViewGuildProgress</b> › GuildProgressOLD</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_SignToolChangeTextMenu.jpg"><img src="screenshots/thumbs/09_SignToolChangeTextMenu.jpg" width="100%"></a><br><sub><b>SignToolChangeTextMenu</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_Settings.jpg"><img src="screenshots/thumbs/61_Settings.jpg" width="100%"></a><br><sub><b>Settings</b></sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_Message.jpg"><img src="screenshots/thumbs/06_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/83_Notification_UI__Notification_UI.jpg"><img src="screenshots/thumbs/83_Notification_UI__Notification_UI.jpg" width="100%"></a><br><sub><b>Notification_UI</b> › Notification_UI</sub></td>
<td width="33%" valign="top"><a href="screenshots/84_Notification_UI_Mobile__Notification_UI_Mobile.jpg"><img src="screenshots/thumbs/84_Notification_UI_Mobile__Notification_UI_Mobile.jpg" width="100%"></a><br><sub><b>Notification_UI_Mobile</b> › Notification_UI_Mobile</sub></td>
</tr>
</table>

### Loading & intro

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/49_LoadingGui__Variant1Frame.jpg"><img src="screenshots/thumbs/49_LoadingGui__Variant1Frame.jpg" width="100%"></a><br><sub><b>LoadingGui</b> › Variant1Frame</sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_CustomiseFenceTheme__GardenStatsHeader.jpg"><img src="screenshots/thumbs/29_CustomiseFenceTheme__GardenStatsHeader.jpg" width="100%"></a><br><sub><b>CustomiseFenceTheme</b> › Frame.GardenStatsHeader</sub></td>
<td width="33%" valign="top"><a href="screenshots/30_CustomiseFenceTheme__GardenStatsContent.jpg"><img src="screenshots/thumbs/30_CustomiseFenceTheme__GardenStatsContent.jpg" width="100%"></a><br><sub><b>CustomiseFenceTheme</b> › Frame.GardenStatsContent</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_CinematicBars__TopBar.jpg"><img src="screenshots/thumbs/40_CinematicBars__TopBar.jpg" width="100%"></a><br><sub><b>CinematicBars</b> › TopBar</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/65_ViewGuildLeaderboard.jpg"><img src="screenshots/thumbs/65_ViewGuildLeaderboard.jpg" width="100%"></a><br><sub><b>ViewGuildLeaderboard</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/66_ViewGuildLeaderboard__PlayerCard_Template_Rank1.jpg"><img src="screenshots/thumbs/66_ViewGuildLeaderboard__PlayerCard_Template_Rank1.jpg" width="100%"></a><br><sub><b>ViewGuildLeaderboard</b> › ContributionLeaderboard.Content.ScrollingFrame.PlayerCard_Template_Rank1</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_GrowingList.jpg"><img src="screenshots/thumbs/17_GrowingList.jpg" width="100%"></a><br><sub><b>GrowingList</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/18_GrowingList__Frame.jpg"><img src="screenshots/thumbs/18_GrowingList__Frame.jpg" width="100%"></a><br><sub><b>GrowingList</b> › Frame</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_MailboxUI__SelectPlayerFrame.jpg"><img src="screenshots/thumbs/60_MailboxUI__SelectPlayerFrame.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.SendingFrame.SelectPlayerFrame</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/77_Cmdr__Autocomplete.jpg"><img src="screenshots/thumbs/77_Cmdr__Autocomplete.jpg" width="100%"></a><br><sub><b>Cmdr</b> › Autocomplete</sub></td>
<td width="33%" valign="top"><a href="screenshots/81_AdminPanel.jpg"><img src="screenshots/thumbs/81_AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/82_AdminPanel__SetLuck.jpg"><img src="screenshots/thumbs/82_AdminPanel__SetLuck.jpg" width="100%"></a><br><sub><b>AdminPanel</b> › Main.Contents.SetLuck</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_SideBar.jpg"><img src="screenshots/thumbs/01_SideBar.jpg" width="100%"></a><br><sub><b>SideBar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_HUD.jpg"><img src="screenshots/thumbs/16_HUD.jpg" width="100%"></a><br><sub><b>HUD</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_CinematicBars__BottomBar.jpg"><img src="screenshots/thumbs/39_CinematicBars__BottomBar.jpg" width="100%"></a><br><sub><b>CinematicBars</b> › BottomBar</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/73_GearCinematicBars__BottomBar.jpg"><img src="screenshots/thumbs/73_GearCinematicBars__BottomBar.jpg" width="100%"></a><br><sub><b>GearCinematicBars</b> › BottomBar</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/28_CustomiseFenceTheme.jpg"><img src="screenshots/thumbs/28_CustomiseFenceTheme.jpg" width="100%"></a><br><sub><b>CustomiseFenceTheme</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/07_GuildWeekComplete.jpg"><img src="screenshots/thumbs/07_GuildWeekComplete.jpg" width="100%"></a><br><sub><b>GuildWeekComplete</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_Odds.jpg"><img src="screenshots/thumbs/10_Odds.jpg" width="100%"></a><br><sub><b>Odds</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/11_Odds__GrandTemplate.jpg"><img src="screenshots/thumbs/11_Odds__GrandTemplate.jpg" width="100%"></a><br><sub><b>Odds</b> › Frame.ScrollingFrame.GrandTemplate</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_TeleportButtons.jpg"><img src="screenshots/thumbs/12_TeleportButtons.jpg" width="100%"></a><br><sub><b>TeleportButtons</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/13_RollFrame.jpg"><img src="screenshots/thumbs/13_RollFrame.jpg" width="100%"></a><br><sub><b>RollFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_PropsFrame.jpg"><img src="screenshots/thumbs/14_PropsFrame.jpg" width="100%"></a><br><sub><b>PropsFrame</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/27_Watermark.jpg"><img src="screenshots/thumbs/27_Watermark.jpg" width="100%"></a><br><sub><b>Watermark</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/31_PlayerSelector.jpg"><img src="screenshots/thumbs/31_PlayerSelector.jpg" width="100%"></a><br><sub><b>PlayerSelector</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/36_RainbowShovel.jpg"><img src="screenshots/thumbs/36_RainbowShovel.jpg" width="100%"></a><br><sub><b>RainbowShovel</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_RollFrame_New.jpg"><img src="screenshots/thumbs/38_RollFrame_New.jpg" width="100%"></a><br><sub><b>RollFrame_New</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/41_ButtonMash.jpg"><img src="screenshots/thumbs/41_ButtonMash.jpg" width="100%"></a><br><sub><b>ButtonMash</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/51_PlayerGardenMarket.jpg"><img src="screenshots/thumbs/51_PlayerGardenMarket.jpg" width="100%"></a><br><sub><b>PlayerGardenMarket</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/53_MailboxUI.jpg"><img src="screenshots/thumbs/53_MailboxUI.jpg" width="100%"></a><br><sub><b>MailboxUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/55_MailboxUI__GuildInviteTemplate.jpg"><img src="screenshots/thumbs/55_MailboxUI__GuildInviteTemplate.jpg" width="100%"></a><br><sub><b>MailboxUI</b> › Frame.RecieveFrame.GuildInviteTemplate</sub></td>
<td width="33%" valign="top"><a href="screenshots/62_ColorPickerGuild.jpg"><img src="screenshots/thumbs/62_ColorPickerGuild.jpg" width="100%"></a><br><sub><b>ColorPickerGuild</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/63_ViewGuildPage.jpg"><img src="screenshots/thumbs/63_ViewGuildPage.jpg" width="100%"></a><br><sub><b>ViewGuildPage</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/64_CreateGuild.jpg"><img src="screenshots/thumbs/64_CreateGuild.jpg" width="100%"></a><br><sub><b>CreateGuild</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/67_LeaveGuild.jpg"><img src="screenshots/thumbs/67_LeaveGuild.jpg" width="100%"></a><br><sub><b>LeaveGuild</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/68_EditGuild.jpg"><img src="screenshots/thumbs/68_EditGuild.jpg" width="100%"></a><br><sub><b>EditGuild</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/76_GuildInvite.jpg"><img src="screenshots/thumbs/76_GuildInvite.jpg" width="100%"></a><br><sub><b>GuildInvite</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/78_BanHammer.jpg"><img src="screenshots/thumbs/78_BanHammer.jpg" width="100%"></a><br><sub><b>BanHammer</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_BanGui.jpg"><img src="screenshots/thumbs/79_BanGui.jpg" width="100%"></a><br><sub><b>BanGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/80_BanGui__BlackFrame.jpg"><img src="screenshots/thumbs/80_BanGui__BlackFrame.jpg" width="100%"></a><br><sub><b>BanGui</b> › BlackFrame</sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Pets/IceSerpent.rbxm"><img src="screenshots/thumbs/models/01_IceSerpent.jpg" width="100%"></a><br><sub><b>IceSerpent</b><br><code>models/ReplicatedStorage/Assets/Pets/IceSerpent.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/NPCS/Steven.rbxm"><img src="screenshots/thumbs/models/02_Steven.jpg" width="100%"></a><br><sub><b>Steven</b><br><code>models/Workspace/NPCS/Steven.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/BeanstalkSkins/Rainbow%20Beanstalk.rbxm"><img src="screenshots/thumbs/models/03_Rainbow_Beanstalk.jpg" width="100%"></a><br><sub><b>Rainbow Beanstalk</b><br><code>models/ReplicatedStorage/Assets/BeanstalkSkins/Rainbow Beanstalk.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/GuildCrates/Super%20Guild%20Crate.rbxm"><img src="screenshots/thumbs/models/05_Super_Guild_Crate.jpg" width="100%"></a><br><sub><b>Super Guild Crate</b><br><code>models/ReplicatedStorage/Assets/GuildCrates/Super Guild Crate.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/PlantGenerationModules/Plants/Venus%20Fly%20Trap/Head.rbxm"><img src="screenshots/thumbs/models/06_Head.jpg" width="100%"></a><br><sub><b>Head</b><br><code>models/ReplicatedStorage/PlantGenerationModules/Plants/Venus Fly Trap/Head.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Props/Rainbow%20Sign.rbxm"><img src="screenshots/thumbs/models/07_Rainbow_Sign.jpg" width="100%"></a><br><sub><b>Rainbow Sign</b><br><code>models/ReplicatedStorage/Assets/Props/Rainbow Sign.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Props/Flower%20Bench.rbxm"><img src="screenshots/thumbs/models/08_Flower_Bench.jpg" width="100%"></a><br><sub><b>Flower Bench</b><br><code>models/ReplicatedStorage/Assets/Props/Flower Bench.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/SeedInspectController/FakePlot.rbxm"><img src="screenshots/thumbs/models/09_FakePlot.jpg" width="100%"></a><br><sub><b>FakePlot</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/SeedInspectController/FakePlot.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Fruits/Moon%20Bloom.rbxm"><img src="screenshots/thumbs/models/10_Moon_Bloom.jpg" width="100%"></a><br><sub><b>Moon Bloom</b><br><code>models/ReplicatedStorage/Assets/Fruits/Moon Bloom.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Pets/Unicorn.rbxm"><img src="screenshots/thumbs/models/11_Unicorn.jpg" width="100%"></a><br><sub><b>Unicorn</b><br><code>models/ReplicatedStorage/Assets/Pets/Unicorn.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/PlantGenerationModules/Plants/Dragon%27s%20Breath/Dragon.rbxm"><img src="screenshots/thumbs/models/12_Dragon.jpg" width="100%"></a><br><sub><b>Dragon</b><br><code>models/ReplicatedStorage/PlantGenerationModules/Plants/Dragon's Breath/Dragon.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/BeanstalkSkins/Galaxy%20Beanstalk.rbxm"><img src="screenshots/thumbs/models/13_Galaxy_Beanstalk.jpg" width="100%"></a><br><sub><b>Galaxy Beanstalk</b><br><code>models/ReplicatedStorage/Assets/BeanstalkSkins/Galaxy Beanstalk.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/EggEffects/GrowEffects.rbxm"><img src="screenshots/thumbs/models/14_GrowEffects.jpg" width="100%"></a><br><sub><b>GrowEffects</b><br><code>models/ReplicatedStorage/Assets/EggEffects/GrowEffects.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`SeedPackEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/SeedPackOpenController/SeedPackEffect.lua) <sub>451 lines</sub><br>[`EggEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/EggOpenController/EggEffect.lua) <sub>1361 lines</sub><br>[`RakeVisualizerController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/RakeVisualizerController.lua) <sub>487 lines</sub><br>[`CurrenciesScript`](source/scripts/StarterGui/HUD/CurrenciesScript.client.lua) <sub>380 lines</sub><br>[`Mythic Spring`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/PropVisualizerController/Mythic%20Spring.lua) <sub>70 lines</sub> |
| UI controllers / window managers / menus | [`Menu`](source/scripts/ReplicatedStorage/ClientModules/Iris/widgets/Menu.lua) <sub>588 lines</sub><br>[`Tab`](source/scripts/ReplicatedStorage/ClientModules/Iris/widgets/Tab.lua) <sub>332 lines</sub><br>[`demoWindow`](source/scripts/ReplicatedStorage/ClientModules/Iris/demoWindow.lua) <sub>2358 lines</sub><br>[`Window`](source/scripts/ReplicatedStorage/ClientModules/Iris/widgets/Window.lua) <sub>1079 lines</sub><br>[`Window`](source/scripts/ReplicatedStorage/CmdrClient/CmdrInterface/Window.lua) <sub>318 lines</sub> |
| Notifications, toasts, popups, prompts | [`HarvestPromptController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/HarvestPromptController.lua) <sub>879 lines</sub><br>[`MessagePrompt`](source/scripts/ReplicatedStorage/ClientModules/MessagePrompt.lua) <sub>501 lines</sub><br>[`SocialPopupClient`](source/scripts/StarterPlayer/StarterPlayerScripts/SocialPopupClient.client.lua) <sub>258 lines</sub><br>[`HarvestPromptLabelController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/HarvestPromptLabelController.lua) <sub>375 lines</sub><br>[`ProximityPromptController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/ProximityPromptController.lua) <sub>572 lines</sub> |
| Loading / intro screens | [`LoadingScreenController`](source/scripts/ReplicatedFirst/LoadingScreenController.client.lua) <sub>1084 lines</sub><br>[`CutsceneController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CutsceneController.lua) <sub>277 lines</sub><br>[`topbarplus`](source/scripts/ReplicatedStorage/ClientModules/topbarplus.lua) <sub>2505 lines</sub><br>[`Scene`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Freeze%20Ray/Scene.lua) <sub>336 lines</sub><br>[`Scene`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/GearScenes/Power%20Hose/Scene.lua) <sub>319 lines</sub> |
| Camera, cutscenes, screen shake | [`CutsceneController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/CutsceneController.lua) <sub>277 lines</sub><br>[`SceneApi`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController/SceneApi.lua) <sub>337 lines</sub><br>[`DisplayPlantGrowthController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/DisplayPlantGrowthController.lua) <sub>675 lines</sub><br>[`CameraShaker`](source/scripts/ReplicatedStorage/ClientModules/CamShake/CameraShaker.lua) <sub>125 lines</sub><br>[`OfflineGrowthAnimationController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/OfflineGrowthAnimationController.lua) <sub>1579 lines</sub> |
| VFX, particles, beams, hit effects | [`SeedPackEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/SeedPackOpenController/SeedPackEffect.lua) <sub>451 lines</sub><br>[`EggEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/EggOpenController/EggEffect.lua) <sub>1361 lines</sub><br>[`Chained Moon`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/TimeCycleController/Phases/Chained%20Moon.lua) <sub>850 lines</sub><br>[`Markers`](source/scripts/ReplicatedStorage/Assets/Cutscenes/GAGTrailer/Markers.lua) <sub>577 lines</sub><br>[`Markers`](source/scripts/ReplicatedStorage/Assets/Cutscenes/GAGTrailerNoWalls/Markers.lua) <sub>566 lines</sub> |
| DataStore / player data | [`GameServer`](source/scripts/ServerScriptService/GameServer.server.lua) <sub>1131 lines</sub><br>[`MailboxService`](source/scripts/ServerScriptService/MailboxService.server.lua) <sub>342 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`DevProductService`](source/scripts/ServerScriptService/DevProductService.server.lua) <sub>889 lines</sub><br>[`DevProductController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/DevProductController.lua) <sub>739 lines</sub><br>[`RainbowShovelClient`](source/scripts/StarterPack/Shovel%20Rainbow/RainbowShovelClient.client.lua) <sub>204 lines</sub><br>[`RobuxShopClient`](source/scripts/StarterGui/RobuxShop/RobuxShopClient.client.lua) <sub>925 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`HugePetsService`](source/scripts/ServerScriptService/HugePetsService.server.lua) <sub>221 lines</sub><br>[`EggData`](source/scripts/ReplicatedStorage/SharedModules/EggData.lua) <sub>274 lines</sub><br>[`WildPetService`](source/scripts/ServerScriptService/WildPetService.server.lua) <sub>439 lines</sub><br>[`PlantSizeMultipliers`](source/scripts/ReplicatedStorage/SharedModules/PlantSizeMultipliers.lua) <sub>296 lines</sub><br>[`ExtraEggHatchController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/ExtraEggHatchController.lua) <sub>348 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`Zone`](source/scripts/ReplicatedStorage/SharedModules/Zone.lua) <sub>1906 lines</sub><br>[`BanHammerToolServer`](source/scripts/ReplicatedStorage/Assets/BanHammer/BanHammerTool/BanHammerToolServer.server.lua) <sub>116 lines</sub><br>[`RakeVisualizerController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/RakeVisualizerController.lua) <sub>487 lines</sub><br>[`WateringcanController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/WateringcanController.lua) <sub>776 lines</sub><br>[`FreezeRayController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/FreezeRayController.lua) <sub>169 lines</sub> |
| NPC / AI / monsters | [`NPCDialogueController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/NPCDialogueController.lua) <sub>389 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`SliderMusic`](source/scripts/StarterGui/Settings/Frame/Content/BGM/Slider/SliderMusic.client.lua) <sub>101 lines</sub><br>[`SliderSFX`](source/scripts/StarterGui/Settings/Frame/Content/SFX/Slider/SliderSFX.client.lua) <sub>101 lines</sub><br>[`SelectionScript`](source/scripts/StarterGui/ColorPickerGuild/Backdrop/ColorPicker/SelectionScript.client.lua) <sub>130 lines</sub><br>[`demoWindow`](source/scripts/ReplicatedStorage/ClientModules/Iris/demoWindow.lua) <sub>2358 lines</sub><br>[`Input`](source/scripts/ReplicatedStorage/ClientModules/Iris/widgets/Input.lua) <sub>1312 lines</sub> |
| Tycoon / plots / bases / building | [`PotPlacementController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/PotPlacementController.lua) <sub>900 lines</sub><br>[`PlotsController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/PlotsController.lua) <sub>457 lines</sub><br>[`GearInspectController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/GearInspectController.lua) <sub>709 lines</sub><br>[`ButtonHandler`](source/scripts/StarterGui/TeleportButtons/TeleportButtons/ButtonHandler.client.lua) <sub>213 lines</sub><br>[`RakeController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/RakeController.lua) <sub>825 lines</sub> |
| Admin panels & commands | [`CmdrPetCommands`](source/scripts/ServerScriptService/CmdrPetCommands.server.lua) <sub>82 lines</sub><br>[`OpSeedAdminCommand`](source/scripts/ServerScriptService/OpSeedAdminCommand.server.lua) <sub>134 lines</sub><br>[`AdminCommandBridge`](source/scripts/ServerScriptService/AdminCommandBridge.server.lua) <sub>779 lines</sub> |
| Sound & music | [`SliderMusic`](source/scripts/StarterGui/Settings/Frame/Content/BGM/Slider/SliderMusic.client.lua) <sub>101 lines</sub><br>[`SfxController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/SfxController.lua) <sub>123 lines</sub><br>[`SliderSFX`](source/scripts/StarterGui/Settings/Frame/Content/SFX/Slider/SliderSFX.client.lua) <sub>101 lines</sub><br>[`MusicController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/MusicController.lua) <sub>503 lines</sub><br>[`SeedPackEffect`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/SeedPackOpenController/SeedPackEffect.lua) <sub>451 lines</sub> |
| Daily rewards, quests, codes, playtime | [`Codes`](source/scripts/StarterGui/Settings/Frame/Content/CodesFrame/Codes.client.lua) <sub>57 lines</sub><br>[`MailboxController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/MailboxController.lua) <sub>2310 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`FruitProxyUtil`](source/scripts/ReplicatedStorage/SharedModules/FruitProxyUtil.lua) <sub>75 lines</sub><br>[`Utility`](source/scripts/ReplicatedStorage/ClientModules/topbarplus/Utility.lua) <sub>724 lines</sub><br>[`Utility`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/InventoryController/Main/Icon/Utility.lua) <sub>699 lines</sub><br>[`PetListController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/PetListController.lua) <sub>837 lines</sub><br>[`Maid`](source/scripts/ReplicatedStorage/ReplicaShared/Maid.lua) <sub>149 lines</sub> |

### In the curated script library

- [Favorite / join-group nudge](../../Scripts/03-Notifications/SocialPopup__grow-a-garden-2.lua) — Favorite / join-group nudge shown when using a shop prompt: native favorite dialog (AvatarEditorService) first, then a small group card; 5-minute cooldown if ignored.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
