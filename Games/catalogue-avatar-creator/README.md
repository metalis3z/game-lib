# Catalogue Avatar Creator

> 💬 **Social** · avatar editor / catalog browser · source file `VIP - SLBR - Catalogue Avatar Creator.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/17_wrapper__tags.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 35 ScreenGuis, 2489 GUI objects → **89 screenshots** |
| Models (.rbxm) | 41 models, 9 model sets, 1 VFX sets |
| Lua builders (.lua) | 147 UI screens, 0 animation packs, 2 audio packs |
| Code | 360 scripts, 104,372 lines |
| Asset ids | 36 animations, 4 sounds |
| Safety scan | 0 HIGH / 1 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `SourceSansPro Regular`×336, `Builder Sans SemiBold`×212, `Builder Sans Regular`×158, `Builder Sans Medium`×132, `Builder Sans Bold`×101

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_wrapper__tags.jpg"><img src="screenshots/thumbs/17_wrapper__tags.jpg" width="100%"></a><br><sub><b>wrapper</b> › layoutBypass.tags</sub></td>
<td width="33%" valign="top"><a href="screenshots/57_ShoppingCart.jpg"><img src="screenshots/thumbs/57_ShoppingCart.jpg" width="100%"></a><br><sub><b>ShoppingCart</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/100_ExclusiveShop.jpg"><img src="screenshots/thumbs/100_ExclusiveShop.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b></sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/47_itemOnlyName.jpg"><img src="screenshots/thumbs/47_itemOnlyName.jpg" width="100%"></a><br><sub><b>itemOnlyName</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/48_item.jpg"><img src="screenshots/thumbs/48_item.jpg" width="100%"></a><br><sub><b>item</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/88_ItemGridPreview.jpg"><img src="screenshots/thumbs/88_ItemGridPreview.jpg" width="100%"></a><br><sub><b>ItemGridPreview</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/89_RemoveItems.jpg"><img src="screenshots/thumbs/89_RemoveItems.jpg" width="100%"></a><br><sub><b>RemoveItems</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/101_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/101_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.heroRow.item</sub></td>
<td width="33%" valign="top"><a href="screenshots/103_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/103_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/104_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/104_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
<td width="33%" valign="top"><a href="screenshots/105_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/105_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
<td width="33%" valign="top"><a href="screenshots/106_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/106_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/107_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/107_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
<td width="33%" valign="top"><a href="screenshots/108_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/108_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
<td width="33%" valign="top"><a href="screenshots/109_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/109_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/110_ExclusiveShop__item.jpg"><img src="screenshots/thumbs/110_ExclusiveShop__item.jpg" width="100%"></a><br><sub><b>ExclusiveShop</b> › container.wrapper.shopView.itemsWrapper.gridContainer.item</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/81_Catalog.jpg"><img src="screenshots/thumbs/81_Catalog.jpg" width="100%"></a><br><sub><b>Catalog</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/82_Catalog__catalogSection.jpg"><img src="screenshots/thumbs/82_Catalog__catalogSection.jpg" width="100%"></a><br><sub><b>Catalog</b> › container.catalogSection</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/25_communityOutfitDisplay.jpg"><img src="screenshots/thumbs/25_communityOutfitDisplay.jpg" width="100%"></a><br><sub><b>communityOutfitDisplay</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/61_Settings.jpg"><img src="screenshots/thumbs/61_Settings.jpg" width="100%"></a><br><sub><b>Settings</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/70_PlayerContextMenu.jpg"><img src="screenshots/thumbs/70_PlayerContextMenu.jpg" width="100%"></a><br><sub><b>PlayerContextMenu</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/71_PlayerContextMenu__overflowMenu.jpg"><img src="screenshots/thumbs/71_PlayerContextMenu__overflowMenu.jpg" width="100%"></a><br><sub><b>PlayerContextMenu</b> › overflowMenu</sub></td>
<td width="33%" valign="top"><a href="screenshots/80_CommunityOutfits__dropdown.jpg"><img src="screenshots/thumbs/80_CommunityOutfits__dropdown.jpg" width="100%"></a><br><sub><b>CommunityOutfits</b> › container.wrapper.bottomBar.right.optionsContainer.dropdown</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/36_choiceDialog.jpg"><img src="screenshots/thumbs/36_choiceDialog.jpg" width="100%"></a><br><sub><b>choiceDialog</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/37_inputDialog.jpg"><img src="screenshots/thumbs/37_inputDialog.jpg" width="100%"></a><br><sub><b>inputDialog</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/39_basicDialog.jpg"><img src="screenshots/thumbs/39_basicDialog.jpg" width="100%"></a><br><sub><b>basicDialog</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/66_SavedOutfits__groupsPopup.jpg"><img src="screenshots/thumbs/66_SavedOutfits__groupsPopup.jpg" width="100%"></a><br><sub><b>SavedOutfits</b> › container.wrapper.groupsPopup</sub></td>
<td width="33%" valign="top"><a href="screenshots/74_Warning.jpg"><img src="screenshots/thumbs/74_Warning.jpg" width="100%"></a><br><sub><b>Warning</b></sub></td>
</tr>
</table>

### Leaderboards & stats

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/42_topHalf.jpg"><img src="screenshots/thumbs/42_topHalf.jpg" width="100%"></a><br><sub><b>topHalf</b></sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/77_Admin.jpg"><img src="screenshots/thumbs/77_Admin.jpg" width="100%"></a><br><sub><b>Admin</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/86_Commands.jpg"><img src="screenshots/thumbs/86_Commands.jpg" width="100%"></a><br><sub><b>Commands</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/91_Cmdr__Autocomplete.jpg"><img src="screenshots/thumbs/91_Cmdr__Autocomplete.jpg" width="100%"></a><br><sub><b>Cmdr</b> › Autocomplete</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/43_bottomHalf.jpg"><img src="screenshots/thumbs/43_bottomHalf.jpg" width="100%"></a><br><sub><b>bottomHalf</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/63_SavedOutfits__dropdown.jpg"><img src="screenshots/thumbs/63_SavedOutfits__dropdown.jpg" width="100%"></a><br><sub><b>SavedOutfits</b> › container.wrapper.bottomBar.right.configureTagContainer.dropdown</sub></td>
<td width="33%" valign="top"><a href="screenshots/64_SavedOutfits__leftCluster.jpg"><img src="screenshots/thumbs/64_SavedOutfits__leftCluster.jpg" width="100%"></a><br><sub><b>SavedOutfits</b> › container.wrapper.bottomBar.selectActionsBar.leftCluster</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/65_SavedOutfits__rightCluster.jpg"><img src="screenshots/thumbs/65_SavedOutfits__rightCluster.jpg" width="100%"></a><br><sub><b>SavedOutfits</b> › container.wrapper.bottomBar.selectActionsBar.rightCluster</sub></td>
</tr>
</table>

### Character / avatar / emotes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/31_avatarPreviewQuickActions.jpg"><img src="screenshots/thumbs/31_avatarPreviewQuickActions.jpg" width="100%"></a><br><sub><b>avatarPreviewQuickActions</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/32_avatarPreviewQuickActions__animationsDropdown.jpg"><img src="screenshots/thumbs/32_avatarPreviewQuickActions__animationsDropdown.jpg" width="100%"></a><br><sub><b>avatarPreviewQuickActions</b> › animationsDropdown</sub></td>
<td width="33%" valign="top"><a href="screenshots/34_outfit.jpg"><img src="screenshots/thumbs/34_outfit.jpg" width="100%"></a><br><sub><b>outfit</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/38_resetAvatar.jpg"><img src="screenshots/thumbs/38_resetAvatar.jpg" width="100%"></a><br><sub><b>resetAvatar</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/40_wearLatestOutfit.jpg"><img src="screenshots/thumbs/40_wearLatestOutfit.jpg" width="100%"></a><br><sub><b>wearLatestOutfit</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/49_contextButtonsRobloxOutfitEditable.jpg"><img src="screenshots/thumbs/49_contextButtonsRobloxOutfitEditable.jpg" width="100%"></a><br><sub><b>contextButtonsRobloxOutfitEditable</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/52_communityOutfit.jpg"><img src="screenshots/thumbs/52_communityOutfit.jpg" width="100%"></a><br><sub><b>communityOutfit</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/53_contextButtonsEmote.jpg"><img src="screenshots/thumbs/53_contextButtonsEmote.jpg" width="100%"></a><br><sub><b>contextButtonsEmote</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/62_SavedOutfits.jpg"><img src="screenshots/thumbs/62_SavedOutfits.jpg" width="100%"></a><br><sub><b>SavedOutfits</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/67_SaveOutfit.jpg"><img src="screenshots/thumbs/67_SaveOutfit.jpg" width="100%"></a><br><sub><b>SaveOutfit</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_SaveOutfit__chooseSaveType.jpg"><img src="screenshots/thumbs/68_SaveOutfit__chooseSaveType.jpg" width="100%"></a><br><sub><b>SaveOutfit</b> › container.wrapper.chooseSaveType</sub></td>
<td width="33%" valign="top"><a href="screenshots/69_PublishOutfit.jpg"><img src="screenshots/thumbs/69_PublishOutfit.jpg" width="100%"></a><br><sub><b>PublishOutfit</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/72_Outfits.jpg"><img src="screenshots/thumbs/72_Outfits.jpg" width="100%"></a><br><sub><b>Outfits</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/73_OutfitLoader.jpg"><img src="screenshots/thumbs/73_OutfitLoader.jpg" width="100%"></a><br><sub><b>OutfitLoader</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/79_CommunityOutfits.jpg"><img src="screenshots/thumbs/79_CommunityOutfits.jpg" width="100%"></a><br><sub><b>CommunityOutfits</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/84_Emotes.jpg"><img src="screenshots/thumbs/84_Emotes.jpg" width="100%"></a><br><sub><b>Emotes</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/87_OutfitsBackup.jpg"><img src="screenshots/thumbs/87_OutfitsBackup.jpg" width="100%"></a><br><sub><b>OutfitsBackup</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/92_CreateAvatar.jpg"><img src="screenshots/thumbs/92_CreateAvatar.jpg" width="100%"></a><br><sub><b>CreateAvatar</b></sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_wrapperBeforeAspectRatio.jpg"><img src="screenshots/thumbs/01_wrapperBeforeAspectRatio.jpg" width="100%"></a><br><sub><b>wrapperBeforeAspectRatio</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_wrapperOld.jpg"><img src="screenshots/thumbs/03_wrapperOld.jpg" width="100%"></a><br><sub><b>wrapperOld</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/05_wrapper.jpg"><img src="screenshots/thumbs/05_wrapper.jpg" width="100%"></a><br><sub><b>wrapper</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/06_wrapper.jpg"><img src="screenshots/thumbs/06_wrapper.jpg" width="100%"></a><br><sub><b>wrapper</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/08_wrapperOld.jpg"><img src="screenshots/thumbs/08_wrapperOld.jpg" width="100%"></a><br><sub><b>wrapperOld</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_wrapper.jpg"><img src="screenshots/thumbs/10_wrapper.jpg" width="100%"></a><br><sub><b>wrapper</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_wrapperOld.jpg"><img src="screenshots/thumbs/12_wrapperOld.jpg" width="100%"></a><br><sub><b>wrapperOld</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/14_wrapperBeforeAspectRatio.jpg"><img src="screenshots/thumbs/14_wrapperBeforeAspectRatio.jpg" width="100%"></a><br><sub><b>wrapperBeforeAspectRatio</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/16_wrapper.jpg"><img src="screenshots/thumbs/16_wrapper.jpg" width="100%"></a><br><sub><b>wrapper</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_wrapperOld.jpg"><img src="screenshots/thumbs/18_wrapperOld.jpg" width="100%"></a><br><sub><b>wrapperOld</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/20_wrapper.jpg"><img src="screenshots/thumbs/20_wrapper.jpg" width="100%"></a><br><sub><b>wrapper</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/21_wrapperLessOld.jpg"><img src="screenshots/thumbs/21_wrapperLessOld.jpg" width="100%"></a><br><sub><b>wrapperLessOld</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/26_wrapperBeforeAspectRatio.jpg"><img src="screenshots/thumbs/26_wrapperBeforeAspectRatio.jpg" width="100%"></a><br><sub><b>wrapperBeforeAspectRatio</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_gridContainer.jpg"><img src="screenshots/thumbs/28_gridContainer.jpg" width="100%"></a><br><sub><b>gridContainer</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/29_customChatTemplate.jpg"><img src="screenshots/thumbs/29_customChatTemplate.jpg" width="100%"></a><br><sub><b>customChatTemplate</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/30_Categories.jpg"><img src="screenshots/thumbs/30_Categories.jpg" width="100%"></a><br><sub><b>Categories</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/33_playerReport.jpg"><img src="screenshots/thumbs/33_playerReport.jpg" width="100%"></a><br><sub><b>playerReport</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/35_report.jpg"><img src="screenshots/thumbs/35_report.jpg" width="100%"></a><br><sub><b>report</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/41_getRobloxPlus.jpg"><img src="screenshots/thumbs/41_getRobloxPlus.jpg" width="100%"></a><br><sub><b>getRobloxPlus</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/44_colorSliders.jpg"><img src="screenshots/thumbs/44_colorSliders.jpg" width="100%"></a><br><sub><b>colorSliders</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/45_sliderTemplate.jpg"><img src="screenshots/thumbs/45_sliderTemplate.jpg" width="100%"></a><br><sub><b>sliderTemplate</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_dropdownTemplate.jpg"><img src="screenshots/thumbs/46_dropdownTemplate.jpg" width="100%"></a><br><sub><b>dropdownTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/50_contextButtons.jpg"><img src="screenshots/thumbs/50_contextButtons.jpg" width="100%"></a><br><sub><b>contextButtons</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/54_ColorPickerSample.jpg"><img src="screenshots/thumbs/54_ColorPickerSample.jpg" width="100%"></a><br><sub><b>ColorPickerSample</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/55_Pose.jpg"><img src="screenshots/thumbs/55_Pose.jpg" width="100%"></a><br><sub><b>Pose</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/56_Pose__r6.jpg"><img src="screenshots/thumbs/56_Pose__r6.jpg" width="100%"></a><br><sub><b>Pose</b> › bodySelector.r6</sub></td>
<td width="33%" valign="top"><a href="screenshots/58_AccessoryAdjustment.jpg"><img src="screenshots/thumbs/58_AccessoryAdjustment.jpg" width="100%"></a><br><sub><b>AccessoryAdjustment</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_AccessoryAdjustment__transformSection.jpg"><img src="screenshots/thumbs/59_AccessoryAdjustment__transformSection.jpg" width="100%"></a><br><sub><b>AccessoryAdjustment</b> › container.wrapper.transformSection</sub></td>
<td width="33%" valign="top"><a href="screenshots/60_AccessoryAdjustment__transform.jpg"><img src="screenshots/thumbs/60_AccessoryAdjustment__transform.jpg" width="100%"></a><br><sub><b>AccessoryAdjustment</b> › transform</sub></td>
<td width="33%" valign="top"><a href="screenshots/75_CurrentlyWearing.jpg"><img src="screenshots/thumbs/75_CurrentlyWearing.jpg" width="100%"></a><br><sub><b>CurrentlyWearing</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/76_RobloxPlusUpsell.jpg"><img src="screenshots/thumbs/76_RobloxPlusUpsell.jpg" width="100%"></a><br><sub><b>RobloxPlusUpsell</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/83_Buttons.jpg"><img src="screenshots/thumbs/83_Buttons.jpg" width="100%"></a><br><sub><b>Buttons</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/85_Photobooth.jpg"><img src="screenshots/thumbs/85_Photobooth.jpg" width="100%"></a><br><sub><b>Photobooth</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/90_Statistics.jpg"><img src="screenshots/thumbs/90_Statistics.jpg" width="100%"></a><br><sub><b>Statistics</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/93_Builds.jpg"><img src="screenshots/thumbs/93_Builds.jpg" width="100%"></a><br><sub><b>Builds</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/PoseModeController/R15.rbxm"><img src="screenshots/thumbs/models/01_R15.jpg" width="100%"></a><br><sub><b>R15</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/PoseModeController/R15.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/snowy_forest/Workspace/SPTK_PineTree_Var05.rbxm"><img src="screenshots/thumbs/models/03_SPTK_PineTree_Var05.jpg" width="100%"></a><br><sub><b>SPTK_PineTree_Var05</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/snowy_forest/Workspace/SPTK_PineTree_Var05.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/PhotoboothMap.rbxm"><img src="screenshots/thumbs/models/04_PhotoboothMap.jpg" width="100%"></a><br><sub><b>PhotoboothMap</b><br><code>models/ReplicatedStorage/Assets/PhotoboothMap.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/PurpleFlowers/PurpleBig.rbxm"><img src="screenshots/thumbs/models/05_PurpleBig.jpg" width="100%"></a><br><sub><b>PurpleBig</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/PurpleFlowers/PurpleBig.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Spawn.rbxm"><img src="screenshots/thumbs/models/06_Spawn.jpg" width="100%"></a><br><sub><b>Spawn</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Spawn.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/OrangeFlowers/Orange.rbxm"><img src="screenshots/thumbs/models/07_Orange.jpg" width="100%"></a><br><sub><b>Orange</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/OrangeFlowers/Orange.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/PurpleFlower.rbxm"><img src="screenshots/thumbs/models/08_PurpleFlower.jpg" width="100%"></a><br><sub><b>PurpleFlower</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/PurpleFlower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/WhiteFlower.rbxm"><img src="screenshots/thumbs/models/09_WhiteFlower.jpg" width="100%"></a><br><sub><b>WhiteFlower</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/WhiteFlower.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Pebbles/Pebble.rbxm"><img src="screenshots/thumbs/models/10_Pebble.jpg" width="100%"></a><br><sub><b>Pebble</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Pebbles/Pebble.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/PinkFlower.rbxm"><img src="screenshots/thumbs/models/11_PinkFlower.jpg" width="100%"></a><br><sub><b>PinkFlower</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Flowers/PinkFlower.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Patches/GrassPatch.rbxm"><img src="screenshots/thumbs/models/13_GrassPatch.jpg" width="100%"></a><br><sub><b>GrassPatch</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Patches/GrassPatch.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Rocks/Rock.rbxm"><img src="screenshots/thumbs/models/14_Rock.jpg" width="100%"></a><br><sub><b>Rock</b><br><code>models/StarterPlayer/StarterPlayerScripts/Controllers/MapController/Maps/retro/Workspace/Rocks/Rock.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`Buttons`](source/scripts/StarterPlayer/StarterPlayerScripts/Buttons.client.lua) <sub>769 lines</sub><br>[`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>594 lines</sub> |
| UI controllers / window managers / menus | [`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>594 lines</sub><br>[`Buttons`](source/scripts/StarterPlayer/StarterPlayerScripts/Buttons.client.lua) <sub>769 lines</sub> |
| Notifications, toasts, popups, prompts | [`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>594 lines</sub><br>[`CmdrServer`](source/scripts/ServerScriptService/CmdrServer.server.lua) <sub>362 lines</sub><br>[`AvatarMakerServer`](source/scripts/ServerScriptService/AvatarMakerServer.server.lua) <sub>1916 lines</sub> |
| DataStore / player data | [`AvatarMakerServer`](source/scripts/ServerScriptService/AvatarMakerServer.server.lua) <sub>1916 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>594 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`AvatarMakerServer`](source/scripts/ServerScriptService/AvatarMakerServer.server.lua) <sub>1916 lines</sub> |
| Tycoon / plots / bases / building | [`AvatarMakerServer`](source/scripts/ServerScriptService/AvatarMakerServer.server.lua) <sub>1916 lines</sub> |
| Admin panels & commands | [`CmdrServer`](source/scripts/ServerScriptService/CmdrServer.server.lua) <sub>362 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`AdminController`](source/scripts/StarterPlayer/StarterPlayerScripts/Controllers/AdminController.lua) <sub>594 lines</sub> |

### In the curated script library

- [Command string parser (me/all selectors)](../../Scripts/16-Admin/CmdrServer-CommandParser__catalogue-avatar-creator.lua) — Server handler for a command bar: one RemoteFunction, admin check through a server-set IsAdministrator attribute, me/all/partial-name selectors, kick/ban/teleport/bring/god and more, pcall'd handlers.

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
