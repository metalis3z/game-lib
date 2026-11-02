# Steal an Egg + P2W Admin Panel

> 🧠 **Brainrot** · steal / tycoon (eggs) + admin panel · source file `SU - SAE + P2W ADMIN PANEL.rbxl`

[⬅ Back to the catalog](../../README.md) · [Assets inventory](ASSETS.md) · [Style numbers](reference.md) · [Scripts](source/scripts/) · [Code analysis](source/README.md)

<img src="screenshots/crops/60_AdminPanelPassInfo__AdminPanelPassInfo.jpg" width="70%">

## At a glance

| | |
|---|---|
| Provenance | copy of a live game (saveinstance / decompiled client code) |
| Screens | 62 ScreenGuis, 3982 GUI objects → **79 screenshots** |
| Models (.rbxm) | 715 models, 25 model sets, 27 VFX sets |
| Lua builders (.lua) | 141 UI screens, 19 animation packs, 14 audio packs |
| Code | 1933 scripts, 248,518 lines |
| Asset ids | 78 animations, 263 sounds |
| Safety scan | 5 HIGH / 7 MED flags ([flags.txt](source/flags.txt)) |

**Fonts:** `GothamSSm ExtraBold`×645, `Rubik Bold`×233, `GothamSSm Heavy`×187, `SourceSansPro Regular`×96, `GothamSSm Bold`×79

## UI screenshots

Captured in Studio from the place's own ScreenGuis (scripts stripped). Each panel was opened on its own; click a thumbnail for the full 1519×886 frame. Runtime-filled lists (shop items, inventories) show their template state.

### Shop & Robux store

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/34_PopupPrompt__PurchaseSuccess.jpg"><img src="screenshots/thumbs/34_PopupPrompt__PurchaseSuccess.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › PurchaseSuccess</sub></td>
<td width="33%" valign="top"><a href="screenshots/41_RobuxShop.jpg"><img src="screenshots/thumbs/41_RobuxShop.jpg" width="100%"></a><br><sub><b>RobuxShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/51_SpeedShop.jpg"><img src="screenshots/thumbs/51_SpeedShop.jpg" width="100%"></a><br><sub><b>SpeedShop</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/52_TrailShop.jpg"><img src="screenshots/thumbs/52_TrailShop.jpg" width="100%"></a><br><sub><b>TrailShop</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/60_AdminPanelPassInfo__AdminPanelPassInfo.jpg"><img src="screenshots/thumbs/60_AdminPanelPassInfo__AdminPanelPassInfo.jpg" width="100%"></a><br><sub><b>AdminPanelPassInfo</b> › AdminPanelPassInfo</sub></td>
</tr>
</table>

### Inventory / backpack / pets

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/01_HotbarTemplate.jpg"><img src="screenshots/thumbs/01_HotbarTemplate.jpg" width="100%"></a><br><sub><b>HotbarTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/03_InventoryTemplate.jpg"><img src="screenshots/thumbs/03_InventoryTemplate.jpg" width="100%"></a><br><sub><b>InventoryTemplate</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/04_ActivePets.jpg"><img src="screenshots/thumbs/04_ActivePets.jpg" width="100%"></a><br><sub><b>ActivePets</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/08_BackpackGui__Backpack.jpg"><img src="screenshots/thumbs/08_BackpackGui__Backpack.jpg" width="100%"></a><br><sub><b>BackpackGui</b> › Backpack</sub></td>
<td width="33%" valign="top"><a href="screenshots/27_PetFuse.jpg"><img src="screenshots/thumbs/27_PetFuse.jpg" width="100%"></a><br><sub><b>PetFuse</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/28_PetFuse__FusePetInventory.jpg"><img src="screenshots/thumbs/28_PetFuse__FusePetInventory.jpg" width="100%"></a><br><sub><b>PetFuse</b> › FusePetInventory</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/35_PopupPrompt__SellAllPets.jpg"><img src="screenshots/thumbs/35_PopupPrompt__SellAllPets.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › SellAllPets</sub></td>
<td width="33%" valign="top"><a href="screenshots/36_PopupPrompt__PetFused.jpg"><img src="screenshots/thumbs/36_PopupPrompt__PetFused.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › PetFused</sub></td>
<td width="33%" valign="top"><a href="screenshots/61_AdminPanelPetIconPicker__AdminPanelPetIconPicker.jpg"><img src="screenshots/thumbs/61_AdminPanelPetIconPicker__AdminPanelPetIconPicker.jpg" width="100%"></a><br><sub><b>AdminPanelPetIconPicker</b> › AdminPanelPetIconPicker</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/62_AdminPanelPetPicker__AdminPanelPetPicker.jpg"><img src="screenshots/thumbs/62_AdminPanelPetPicker__AdminPanelPetPicker.jpg" width="100%"></a><br><sub><b>AdminPanelPetPicker</b> › AdminPanelPetPicker</sub></td>
</tr>
</table>

### Index / codex / glossary

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/22_Index.jpg"><img src="screenshots/thumbs/22_Index.jpg" width="100%"></a><br><sub><b>Index</b></sub></td>
</tr>
</table>

### Rewards, daily, spin, codes

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/14_FreeGift.jpg"><img src="screenshots/thumbs/14_FreeGift.jpg" width="100%"></a><br><sub><b>FreeGift</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/25_MonsterChestRewards.jpg"><img src="screenshots/thumbs/25_MonsterChestRewards.jpg" width="100%"></a><br><sub><b>MonsterChestRewards</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/42_RollbackRewardUI.jpg"><img src="screenshots/thumbs/42_RollbackRewardUI.jpg" width="100%"></a><br><sub><b>RollbackRewardUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/64_CodesGui__Frame.jpg"><img src="screenshots/thumbs/64_CodesGui__Frame.jpg" width="100%"></a><br><sub><b>CodesGui</b> › Frame</sub></td>
</tr>
</table>

### Quests & progression

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/46_SakuraEggCharge__ProgressBarHolder.jpg"><img src="screenshots/thumbs/46_SakuraEggCharge__ProgressBarHolder.jpg" width="100%"></a><br><sub><b>SakuraEggCharge</b> › Content.ProgressBarHolder</sub></td>
</tr>
</table>

### Settings & menus

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/33_PhoneVideoUI__Paused.jpg"><img src="screenshots/thumbs/33_PhoneVideoUI__Paused.jpg" width="100%"></a><br><sub><b>PhoneVideoUI</b> › Phone.Paused</sub></td>
<td width="33%" valign="top"><a href="screenshots/50_Settings.jpg"><img src="screenshots/thumbs/50_Settings.jpg" width="100%"></a><br><sub><b>Settings</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/57_AdminPanelSettings__AdminPanelSettings.jpg"><img src="screenshots/thumbs/57_AdminPanelSettings__AdminPanelSettings.jpg" width="100%"></a><br><sub><b>AdminPanelSettings</b> › AdminPanelSettings</sub></td>
</tr>
</table>

### Popups, notifications, prompts

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/23_Message.jpg"><img src="screenshots/thumbs/23_Message.jpg" width="100%"></a><br><sub><b>Message</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/37_PopupPrompt__Sellv2.jpg"><img src="screenshots/thumbs/37_PopupPrompt__Sellv2.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › Sellv2</sub></td>
<td width="33%" valign="top"><a href="screenshots/38_PopupPrompt__Sellv1.jpg"><img src="screenshots/thumbs/38_PopupPrompt__Sellv1.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › Sellv1</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/39_PopupPrompt__Emptyv2.jpg"><img src="screenshots/thumbs/39_PopupPrompt__Emptyv2.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › Emptyv2</sub></td>
<td width="33%" valign="top"><a href="screenshots/40_PopupPrompt__Emptyv1.jpg"><img src="screenshots/thumbs/40_PopupPrompt__Emptyv1.jpg" width="100%"></a><br><sub><b>PopupPrompt</b> › Emptyv1</sub></td>
</tr>
</table>

### End of round, death, results

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/17_GrowingEggs.jpg"><img src="screenshots/thumbs/17_GrowingEggs.jpg" width="100%"></a><br><sub><b>GrowingEggs</b></sub></td>
</tr>
</table>

### Crafting, fusing, machines

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/59_AdminPanelMutationPicker__AdminPanelMutationPicker.jpg"><img src="screenshots/thumbs/59_AdminPanelMutationPicker__AdminPanelMutationPicker.jpg" width="100%"></a><br><sub><b>AdminPanelMutationPicker</b> › AdminPanelMutationPicker</sub></td>
</tr>
</table>

### Admin panels

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/54_Cmdr__Autocomplete.jpg"><img src="screenshots/thumbs/54_Cmdr__Autocomplete.jpg" width="100%"></a><br><sub><b>Cmdr</b> › Autocomplete</sub></td>
<td width="33%" valign="top"><a href="screenshots/55_AdminModelBrowser__Shade.jpg"><img src="screenshots/thumbs/55_AdminModelBrowser__Shade.jpg" width="100%"></a><br><sub><b>AdminModelBrowser</b> › Shade</sub></td>
<td width="33%" valign="top"><a href="screenshots/56_AdminPanel_PREVIEW__AdminPanel.jpg"><img src="screenshots/thumbs/56_AdminPanel_PREVIEW__AdminPanel.jpg" width="100%"></a><br><sub><b>AdminPanel_PREVIEW</b> › AdminPanel</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/58_AdminPanelEggPicker__AdminPanelEggPicker.jpg"><img src="screenshots/thumbs/58_AdminPanelEggPicker__AdminPanelEggPicker.jpg" width="100%"></a><br><sub><b>AdminPanelEggPicker</b> › AdminPanelEggPicker</sub></td>
</tr>
</table>

### HUD & currency

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/18_HUD.jpg"><img src="screenshots/thumbs/18_HUD.jpg" width="100%"></a><br><sub><b>HUD</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/19_HUD__RightButtons.jpg"><img src="screenshots/thumbs/19_HUD__RightButtons.jpg" width="100%"></a><br><sub><b>HUD</b> › TradmilHud.RightButtons</sub></td>
<td width="33%" valign="top"><a href="screenshots/20_HUD__LeftControls.jpg"><img src="screenshots/thumbs/20_HUD__LeftControls.jpg" width="100%"></a><br><sub><b>HUD</b> › TradmilHud.LeftControls</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/21_HUD__BottomLeft.jpg"><img src="screenshots/thumbs/21_HUD__BottomLeft.jpg" width="100%"></a><br><sub><b>HUD</b> › TradmilHud.BottomLeft</sub></td>
<td width="33%" valign="top"><a href="screenshots/66_Money.jpg"><img src="screenshots/thumbs/66_Money.jpg" width="100%"></a><br><sub><b>Money</b></sub></td>
</tr>
</table>

### Map vote / teams / matchmaking

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/02_RoundChoices__EscapeAndKeep.jpg"><img src="screenshots/thumbs/02_RoundChoices__EscapeAndKeep.jpg" width="100%"></a><br><sub><b>RoundChoices</b> › EscapeAndKeep</sub></td>
</tr>
</table>

### Other

<table>
<tr>
<td width="33%" valign="top"><a href="screenshots/05_AreaGui.jpg"><img src="screenshots/thumbs/05_AreaGui.jpg" width="100%"></a><br><sub><b>AreaGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/06_AssetHoverData.jpg"><img src="screenshots/thumbs/06_AssetHoverData.jpg" width="100%"></a><br><sub><b>AssetHoverData</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/07_AutoSell.jpg"><img src="screenshots/thumbs/07_AutoSell.jpg" width="100%"></a><br><sub><b>AutoSell</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/09_CaptureTheEggUI.jpg"><img src="screenshots/thumbs/09_CaptureTheEggUI.jpg" width="100%"></a><br><sub><b>CaptureTheEggUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/10_CrateOpeningPopUpFrame__CrateOpeningPopUp.jpg"><img src="screenshots/thumbs/10_CrateOpeningPopUpFrame__CrateOpeningPopUp.jpg" width="100%"></a><br><sub><b>CrateOpeningPopUpFrame</b> › CrateOpeningPopUp</sub></td>
<td width="33%" valign="top"><a href="screenshots/11_CutsceneUI__MonstersAreComing.jpg"><img src="screenshots/thumbs/11_CutsceneUI__MonstersAreComing.jpg" width="100%"></a><br><sub><b>CutsceneUI</b> › MonstersAreComing</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/12_DragonEggEventUI.jpg"><img src="screenshots/thumbs/12_DragonEggEventUI.jpg" width="100%"></a><br><sub><b>DragonEggEventUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/13_DropHeldEgg.jpg"><img src="screenshots/thumbs/13_DropHeldEgg.jpg" width="100%"></a><br><sub><b>DropHeldEgg</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/15_GetMoreSpeedOnHit.jpg"><img src="screenshots/thumbs/15_GetMoreSpeedOnHit.jpg" width="100%"></a><br><sub><b>GetMoreSpeedOnHit</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/16_GreatBloomBanner.jpg"><img src="screenshots/thumbs/16_GreatBloomBanner.jpg" width="100%"></a><br><sub><b>GreatBloomBanner</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/24_MonsterChargeUI.jpg"><img src="screenshots/thumbs/24_MonsterChargeUI.jpg" width="100%"></a><br><sub><b>MonsterChargeUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/26_MonsterEventUI.jpg"><img src="screenshots/thumbs/26_MonsterEventUI.jpg" width="100%"></a><br><sub><b>MonsterEventUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/29_PhoneVideoUI.jpg"><img src="screenshots/thumbs/29_PhoneVideoUI.jpg" width="100%"></a><br><sub><b>PhoneVideoUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/30_PhoneVideoUI__Comments.jpg"><img src="screenshots/thumbs/30_PhoneVideoUI__Comments.jpg" width="100%"></a><br><sub><b>PhoneVideoUI</b> › Phone.Comments</sub></td>
<td width="33%" valign="top"><a href="screenshots/32_PhoneVideoUI__GoToNext.jpg"><img src="screenshots/thumbs/32_PhoneVideoUI__GoToNext.jpg" width="100%"></a><br><sub><b>PhoneVideoUI</b> › Phone.GoToNext</sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/43_RunBackEffects.jpg"><img src="screenshots/thumbs/43_RunBackEffects.jpg" width="100%"></a><br><sub><b>RunBackEffects</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/44_SakuraCrystalCounter.jpg"><img src="screenshots/thumbs/44_SakuraCrystalCounter.jpg" width="100%"></a><br><sub><b>SakuraCrystalCounter</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/45_SakuraEggCharge.jpg"><img src="screenshots/thumbs/45_SakuraEggCharge.jpg" width="100%"></a><br><sub><b>SakuraEggCharge</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/47_SakuraEggCharge__EggPicker.jpg"><img src="screenshots/thumbs/47_SakuraEggCharge__EggPicker.jpg" width="100%"></a><br><sub><b>SakuraEggCharge</b> › EggPicker</sub></td>
<td width="33%" valign="top"><a href="screenshots/48_SakuraEventTutorialFrame.jpg"><img src="screenshots/thumbs/48_SakuraEventTutorialFrame.jpg" width="100%"></a><br><sub><b>SakuraEventTutorialFrame</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/49_MonsterEventTutorialFrame.jpg"><img src="screenshots/thumbs/49_MonsterEventTutorialFrame.jpg" width="100%"></a><br><sub><b>MonsterEventTutorialFrame</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/53_TutorialInstructions.jpg"><img src="screenshots/thumbs/53_TutorialInstructions.jpg" width="100%"></a><br><sub><b>TutorialInstructions</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/63_ScreenGui.jpg"><img src="screenshots/thumbs/63_ScreenGui.jpg" width="100%"></a><br><sub><b>ScreenGui</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/65_Speed.jpg"><img src="screenshots/thumbs/65_Speed.jpg" width="100%"></a><br><sub><b>Speed</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/67_Item2.jpg"><img src="screenshots/thumbs/67_Item2.jpg" width="100%"></a><br><sub><b>Item2</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/68_BTAnchorToolGUI.jpg"><img src="screenshots/thumbs/68_BTAnchorToolGUI.jpg" width="100%"></a><br><sub><b>BTAnchorToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/69_BTCollisionToolGUI.jpg"><img src="screenshots/thumbs/69_BTCollisionToolGUI.jpg" width="100%"></a><br><sub><b>BTCollisionToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/70_BTDecorateToolGUI.jpg"><img src="screenshots/thumbs/70_BTDecorateToolGUI.jpg" width="100%"></a><br><sub><b>BTDecorateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/71_BTLightingToolGUI.jpg"><img src="screenshots/thumbs/71_BTLightingToolGUI.jpg" width="100%"></a><br><sub><b>BTLightingToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/72_BTMaterialToolGUI.jpg"><img src="screenshots/thumbs/72_BTMaterialToolGUI.jpg" width="100%"></a><br><sub><b>BTMaterialToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/73_BTMeshToolGUI.jpg"><img src="screenshots/thumbs/73_BTMeshToolGUI.jpg" width="100%"></a><br><sub><b>BTMeshToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/74_BTMoveToolGUI.jpg"><img src="screenshots/thumbs/74_BTMoveToolGUI.jpg" width="100%"></a><br><sub><b>BTMoveToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/75_BTPaintToolGUI.jpg"><img src="screenshots/thumbs/75_BTPaintToolGUI.jpg" width="100%"></a><br><sub><b>BTPaintToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/76_BTResizeToolGUI.jpg"><img src="screenshots/thumbs/76_BTResizeToolGUI.jpg" width="100%"></a><br><sub><b>BTResizeToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/77_BTRotateToolGUI.jpg"><img src="screenshots/thumbs/77_BTRotateToolGUI.jpg" width="100%"></a><br><sub><b>BTRotateToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/78_BTSurfaceToolGUI.jpg"><img src="screenshots/thumbs/78_BTSurfaceToolGUI.jpg" width="100%"></a><br><sub><b>BTSurfaceToolGUI</b></sub></td>
</tr>
<tr>
<td width="33%" valign="top"><a href="screenshots/79_BTTextureToolGUI.jpg"><img src="screenshots/thumbs/79_BTTextureToolGUI.jpg" width="100%"></a><br><sub><b>BTTextureToolGUI</b></sub></td>
<td width="33%" valign="top"><a href="screenshots/80_BTWeldToolGUI.jpg"><img src="screenshots/thumbs/80_BTWeldToolGUI.jpg" width="100%"></a><br><sub><b>BTWeldToolGUI</b></sub></td>
</tr>
</table>

## Model previews

<table>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/CutsceneAssets/DragonEggEventCutscene1/CosmicRig.rbxm"><img src="screenshots/thumbs/models/01_CosmicRig.jpg" width="100%"></a><br><sub><b>CosmicRig</b><br><code>models/ReplicatedStorage/CutsceneAssets/DragonEggEventCutscene1/CosmicRig.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/GearTools/ShopItems/Titan%20Axe.rbxm"><img src="screenshots/thumbs/models/02_Titan_Axe.jpg" width="100%"></a><br><sub><b>Titan Axe</b><br><code>models/ReplicatedStorage/GearTools/ShopItems/Titan Axe.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Eggs/Godzilla.rbxm"><img src="screenshots/thumbs/models/03_Godzilla.jpg" width="100%"></a><br><sub><b>Godzilla</b><br><code>models/ReplicatedStorage/Assets/Models/Eggs/Godzilla.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/GearTools/ShopItems/Demon%20Slap.rbxm"><img src="screenshots/thumbs/models/04_Demon_Slap.jpg" width="100%"></a><br><sub><b>Demon Slap</b><br><code>models/ReplicatedStorage/GearTools/ShopItems/Demon Slap.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Treadmills/HackerTreadmill.rbxm"><img src="screenshots/thumbs/models/05_HackerTreadmill.jpg" width="100%"></a><br><sub><b>HackerTreadmill</b><br><code>models/ReplicatedStorage/Assets/Models/Treadmills/HackerTreadmill.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__OBJECTS/Machines/FuseMachine.rbxm"><img src="screenshots/thumbs/models/07_FuseMachine.jpg" width="100%"></a><br><sub><b>FuseMachine</b><br><code>models/Workspace/__OBJECTS/Machines/FuseMachine.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/__OBJECTS/Build/Props/Zone6Props/volcano.rbxm"><img src="screenshots/thumbs/models/08_volcano.jpg" width="100%"></a><br><sub><b>volcano</b><br><code>models/Workspace/__OBJECTS/Build/Props/Zone6Props/volcano.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Chest.rbxm"><img src="screenshots/thumbs/models/09_Chest.jpg" width="100%"></a><br><sub><b>Chest</b><br><code>models/Workspace/Chest.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/Workspace/__OBJECTS/Leaderboards/Models/Leaderboard1.rbxm"><img src="screenshots/thumbs/models/10_Leaderboard1.jpg" width="100%"></a><br><sub><b>Leaderboard1</b><br><code>models/Workspace/__OBJECTS/Leaderboards/Models/Leaderboard1.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Abilities/SmokeBomb.rbxm"><img src="screenshots/thumbs/models/11_SmokeBomb.jpg" width="100%"></a><br><sub><b>SmokeBomb</b><br><code>models/ReplicatedStorage/Assets/Models/Abilities/SmokeBomb.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/ReplicatedStorage/Assets/Models/Sakura/BloomTrees/Gigantic.rbxm"><img src="screenshots/thumbs/models/12_Gigantic.jpg" width="100%"></a><br><sub><b>Gigantic</b><br><code>models/ReplicatedStorage/Assets/Models/Sakura/BloomTrees/Gigantic.rbxm</code></sub></td>
<td width="25%" valign="top"><a href="models/Workspace/Plots/1.rbxm"><img src="screenshots/thumbs/models/13_1.jpg" width="100%"></a><br><sub><b>1</b><br><code>models/Workspace/Plots/1.rbxm</code></sub></td>
</tr>
<tr>
<td width="25%" valign="top"><a href="models/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/MonsterEvent/Cutscene/CutsceneVFX/Eggs/Yeti.rbxm"><img src="screenshots/thumbs/models/14_Yeti.jpg" width="100%"></a><br><sub><b>Yeti</b><br><code>models/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/MonsterEvent/Cutscene/CutsceneVFX/Eggs/Yeti.rbxm</code></sub></td>
</tr>
</table>

## Notable scripts

Top-scored scripts of this game per topic (full tree in [source/scripts](source/scripts/)).

| Topic | Scripts |
|---|---|
| UI animation (tweens, hover / click, pop-ins, springs) | [`AdminPanelUi`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/AdminPanelUi.client.lua) <sub>3752 lines</sub><br>[`CrateOpeningSpinner`](source/scripts/ReplicatedStorage/Client/UI/CrateOpeningSpinner.lua) <sub>552 lines</sub><br>[`GuardTutorialPresentation`](source/scripts/ReplicatedStorage/Client/GuardTutorialPresentation.lua) <sub>682 lines</sub><br>[`SpeedGainPopup`](source/scripts/ReplicatedStorage/Client/UI/VFX/SpeedGainPopup.lua) <sub>455 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6146 lines</sub> |
| UI controllers / window managers / menus | [`Window`](source/scripts/ReplicatedStorage/CmdrClient/CmdrInterface/Window.lua) <sub>314 lines</sub><br>[`LimitedEgg`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Shop/LimitedEgg.client.lua) <sub>592 lines</sub><br>[`Main`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main.lua) <sub>6146 lines</sub><br>[`AdminPanelUi`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/AdminPanelUi.client.lua) <sub>3752 lines</sub><br>[`Index`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Index.client.lua) <sub>902 lines</sub> |
| Notifications, toasts, popups, prompts | [`Message`](source/scripts/ReplicatedStorage/Client/Message.lua) <sub>234 lines</sub><br>[`Message`](source/scripts/ReplicatedStorage/Client/Notifications/Message.lua) <sub>392 lines</sub><br>[`ProximityPromptScript`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript.client.lua) <sub>812 lines</sub><br>[`ActiveAssetIncomePopup`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/ActiveAssetIncomePopup.lua) <sub>162 lines</sub><br>[`NotificationInstance`](source/scripts/ReplicatedStorage/Client/Notifications/NotificationInstance.lua) <sub>272 lines</sub> |
| Loading / intro screens | [`HotbarImagePreloadController`](source/scripts/ReplicatedStorage/Client/HotbarImagePreloadController.lua) <sub>366 lines</sub><br>[`AddCurrencyScreen`](source/scripts/ReplicatedStorage/Client/UI/VFX/AddCurrencyScreen.lua) <sub>304 lines</sub><br>[`CutscenePart2`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/DragonEggEvent/CutscenePart2.lua) <sub>421 lines</sub><br>[`SakuraIncubator`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/SakuraIncubator.client.lua) <sub>1059 lines</sub><br>[`CaptureTheEgg`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/CaptureTheEgg.lua) <sub>1858 lines</sub> |
| Camera, cutscenes, screen shake | [`CutscenePart2`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/DragonEggEvent/CutscenePart2.lua) <sub>421 lines</sub><br>[`CutscenePart1`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/DragonEggEvent/CutscenePart1.lua) <sub>1000 lines</sub><br>[`Cutscene`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/MonsterEvent/Cutscene.lua) <sub>1036 lines</sub><br>[`DragonEggEvent`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/DragonEggEvent.lua) <sub>923 lines</sub><br>[`DemonicEvent`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/DemonicEvent.lua) <sub>249 lines</sub> |
| VFX, particles, beams, hit effects | [`Cutscene`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/MonsterEvent/Cutscene.lua) <sub>1036 lines</sub><br>[`VFX`](source/scripts/ReplicatedStorage/Shared/Utils/VFX.lua) <sub>189 lines</sub><br>[`CutscenePart1`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/DragonEggEvent/CutscenePart1.lua) <sub>1000 lines</sub><br>[`SakuraFX`](source/scripts/ReplicatedStorage/Client/SakuraFX.lua) <sub>80 lines</sub><br>[`SakuraIncubator`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/SakuraIncubator.client.lua) <sub>1059 lines</sub> |
| DataStore / player data | [`DataService`](source/scripts/ServerScriptService/DataService.lua) <sub>550 lines</sub> |
| Monetization (dev products, game passes, receipts) | [`OfferServer`](source/scripts/Workspace/OfferPodiums/OfferServer.server.lua) <sub>269 lines</sub><br>[`AdminPanelService`](source/scripts/ServerScriptService/AdminPanelService.lua) <sub>1095 lines</sub><br>[`PromptPurchase`](source/scripts/ReplicatedStorage/Client/Functions/PromptPurchase.lua) <sub>262 lines</sub><br>[`GamepassButtons`](source/scripts/StarterGui/ScreenGui/Top/GamepassButtons.client.lua) <sub>21 lines</sub> |
| RNG, eggs, gacha, rarity rolls, pets | [`EggRecords`](source/scripts/ReplicatedStorage/Shared/Util/EggRecords.lua) <sub>639 lines</sub><br>[`AreaEggService`](source/scripts/ServerScriptService/AreaEggService.lua) <sub>871 lines</sub><br>[`DragonEgg`](source/scripts/ReplicatedStorage/Data/DragonEgg.lua) <sub>109 lines</sub><br>[`CrateOpeningSpinner`](source/scripts/ReplicatedStorage/Client/UI/CrateOpeningSpinner.lua) <sub>552 lines</sub><br>[`Sakura`](source/scripts/ReplicatedStorage/Data/Sakura.lua) <sub>207 lines</sub> |
| Combat, weapons, hitboxes, abilities | [`GunToolHandler`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/Tools/GunToolHandler.client.lua) <sub>107 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/Shared/Modules/BatController/Client.lua) <sub>493 lines</sub><br>[`Server`](source/scripts/ReplicatedStorage/Shared/Modules/BatController/Server.lua) <sub>500 lines</sub><br>[`_scriptThatsUnderTrap`](source/scripts/ReplicatedStorage/GearTools/ShopItems/Trap/_scriptThatsUnderTrap.lua) <sub>308 lines</sub><br>[`SubspaceMine`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/Tools/SubspaceMine.client.lua) <sub>73 lines</sub> |
| NPC / AI / monsters | [`MonsterEvent`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AdminAbuseClient/Events/MonsterEvent.lua) <sub>603 lines</sub><br>[`MonsterParasite`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/MonsterParasite.client.lua) <sub>3757 lines</sub> |
| Character movement (sprint, dash, double jump, slide) | [`Slider`](source/scripts/ReplicatedStorage/GearTools/Building%20Tools/UI/ColorPicker/Slider.lua) <sub>109 lines</sub><br>[`Client`](source/scripts/ReplicatedStorage/Shared/Modules/BatController/Client.lua) <sub>493 lines</sub><br>[`ObbyAntiTPClient`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/ObbyAntiTPClient.client.lua) <sub>533 lines</sub><br>[`Settings`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Settings.client.lua) <sub>681 lines</sub><br>[`AntiCollisionHighSeedPushBack`](source/scripts/StarterPlayer/StarterCharacterScripts/AntiCollisionHighSeedPushBack.client.lua) <sub>30 lines</sub> |
| Tycoon / plots / bases / building | [`EggPlacementController`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/Eggs/EggPlacementController.client.lua) <sub>184 lines</sub><br>[`AdminPanelService`](source/scripts/ServerScriptService/AdminPanelService.lua) <sub>1095 lines</sub><br>[`PlotService`](source/scripts/ServerScriptService/PlotService.lua) <sub>254 lines</sub><br>[`PlotUpgradeController`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/PlotUpgradeController.client.lua) <sub>315 lines</sub><br>[`AreaEggService`](source/scripts/ServerScriptService/AreaEggService.lua) <sub>871 lines</sub> |
| Admin panels & commands | [`AdminPanelService`](source/scripts/ServerScriptService/AdminPanelService.lua) <sub>1095 lines</sub><br>[`AdminPanelUi`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/AdminPanelUi.client.lua) <sub>3752 lines</sub> |
| Sound & music | [`Audio`](source/scripts/ReplicatedStorage/Shared/Audio.lua) <sub>442 lines</sub><br>[`MusicDirector`](source/scripts/ReplicatedStorage/Client/MusicDirector.lua) <sub>290 lines</sub><br>[`AssetSounds`](source/scripts/ReplicatedStorage/Shared/Util/AssetSounds.lua) <sub>153 lines</sub><br>[`AudioSettings`](source/scripts/StarterPlayer/StarterPlayerScripts/Game/AudioSettings.client.lua) <sub>113 lines</sub><br>[`Abyss Ocean`](source/scripts/ReplicatedStorage/Data/Guards/Configs/Abyss%20Ocean.lua) <sub>72 lines</sub> |
| Daily rewards, quests, codes, playtime | [`CodesService`](source/scripts/ServerScriptService/CodesService.lua) <sub>79 lines</sub><br>[`CodesController`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/CodesController.client.lua) <sub>91 lines</sub><br>[`GroupRewards`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/GroupRewards.client.lua) <sub>162 lines</sub><br>[`ClaimRewardPanel`](source/scripts/StarterPlayer/StarterPlayerScripts/GUI/Index/ClaimRewardPanel.lua) <sub>96 lines</sub> |
| Utility modules (number format, signals, tables, timers) | [`DataService`](source/scripts/ServerScriptService/DataService.lua) <sub>550 lines</sub><br>[`ServerFastFlags`](source/scripts/ServerScriptService/UserGenerated/Server/ServerFastFlags.lua) <sub>139 lines</sub><br>[`AreaEggService`](source/scripts/ServerScriptService/AreaEggService.lua) <sub>871 lines</sub><br>[`AdminPanelService`](source/scripts/ServerScriptService/AdminPanelService.lua) <sub>1095 lines</sub><br>[`Signal`](source/scripts/ReplicatedStorage/GearTools/Building%20Tools/Libraries/Signal.lua) <sub>149 lines</sub> |

## ⚠️ Safety

HIGH flags (backdoors, `require(id)`, `loadstring`, webhooks). Review or delete before reusing:

- `scripts/ReplicatedStorage/Data/Products.lua`
- `scripts/ReplicatedStorage/GearTools/Building Tools/Libraries/Cryo/List.lua`
- `scripts/ReplicatedStorage/GearTools/Building Tools/Libraries/Cryo/List/reverse.spec.lua`
- `scripts/StarterPlayer/StarterPlayerScripts/GUI/ResetStartTimer.client.lua`
- `scripts/Workspace/Avalog/Avalog/Packages/.pesde/csqrl_sift@0.0.9/sift/Array.lua`

## Folders

| Folder | What |
|---|---|
| `screenshots/` | full frames; `crops/` = the panel only; `models/` = 3D previews; `thumbs/` = gallery thumbnails |
| `ui/` | every screen as a Lua builder (`require(module)()` returns the ScreenGui); `_StarterGui-all.lua` builds every StarterGui screen |
| `models/` | every model as .rbxm (the only .rbxm files), mirroring the place tree, scripts removed |
| `map/` | `workspace.rbxm` (the map as a model), `lighting.lua` (sky + post effects), `materials.lua`, `Environment.lua` |
| `animations/`, `audio/` | KeyframeSequence / Sound builders (.lua), `AnimationIds.lua`, `Sounds.lua` |
| `source/` | all scripts as .luau, `tree.txt`, `ui.txt`, `remotes.txt`, `assets.txt`, `flags.txt` |
