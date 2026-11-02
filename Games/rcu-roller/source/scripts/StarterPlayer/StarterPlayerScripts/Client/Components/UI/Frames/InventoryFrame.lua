-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:32
-- Luau version 6, Types version 3
-- Time taken: 0.022834 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "InventoryFrame";
	_currentCategory = nil;
	_archiveMode = false;
	_archiveType = 1;
	_archivePets = {};
	_massLockMode = false;
	_equipBestDebounce = 0;
	_shrinked = false;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local var17_upvw
local var18_upvw
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Menus = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus")
local InventoryFrame_upvr = Menus:WaitForChild("InventoryFrame")
local Displays_upvr = InventoryFrame_upvr:WaitForChild("Displays")
local Utility_upvr = InventoryFrame_upvr:WaitForChild("Utility")
local Bottom_upvr = InventoryFrame_upvr:WaitForChild("Bottom")
local List_upvr = Utility_upvr:WaitForChild("Displays"):WaitForChild("List")
local Holder = Displays_upvr:WaitForChild("Pets"):WaitForChild("List"):WaitForChild("Holder")
local Holder_3_upvr = Displays_upvr:WaitForChild("Items"):WaitForChild("List"):WaitForChild("Holder")
local Archive_upvr = Displays_upvr:WaitForChild("Archive")
local Holder_4_upvr = Archive_upvr:WaitForChild("List"):WaitForChild("Holder")
local InventoryGrid_upvr_2 = Holder_4_upvr:WaitForChild("InventoryGrid")
local InventoryGrid_upvr = Holder:WaitForChild("InventoryGrid")
local EquippedGrid_upvr = Holder:WaitForChild("EquippedGrid")
local Holder_2_upvr = Displays_upvr:WaitForChild("ExclusiveEggs"):WaitForChild("List"):WaitForChild("Holder")
local TextBox_upvr = InventoryFrame_upvr:WaitForChild("SearchBar"):WaitForChild("TextBox")
local TagIcon_upvr = InventoryFrame_upvr:WaitForChild("TagIcon")
function any_new_result1.createEquippedPetUI(arg1, arg2) -- Line 100
	--[[ Upvalues[7]:
		[1]: var4_upvw (read and write)
		[2]: EquippedGrid_upvr (readonly)
		[3]: var14_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var13_upvw (read and write)
		[6]: var10_upvw (read and write)
		[7]: var6_upvw (read and write)
	]]
	if EquippedGrid_upvr:FindFirstChild(arg2) then
	else
		local tbl_8 = {}
		tbl_8.name = arg2
		local any_pet_result1_upvr_3 = var5_upvw.uis.pet(var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2, {
			equipped = true;
		}), tbl_8)
		any_pet_result1_upvr_3.Main.Amount.Visible = false
		any_pet_result1_upvr_3.Parent = EquippedGrid_upvr
		local tbl_4 = {}
		tbl_4.itemId = arg2
		var5_upvw:createInfoHoverOnGuiStateChange(any_pet_result1_upvr_3.Main.Click, tbl_4)
		var13_upvw.new(any_pet_result1_upvr_3.Main):buttonUp(function() -- Line 120
			--[[ Upvalues[5]:
				[1]: arg1 (readonly)
				[2]: var10_upvw (copied, read and write)
				[3]: arg2 (readonly)
				[4]: any_pet_result1_upvr_3 (readonly)
				[5]: var6_upvw (copied, read and write)
			]]
			if arg1._massLockMode then
				local any_toggleLock_result1, any_toggleLock_result2 = var10_upvw:toggleLock(arg2)
				local var43
				if any_toggleLock_result1 == "success" then
					any_pet_result1_upvr_3.Main.Locked.Visible = any_toggleLock_result2
					local tbl_13 = {}
					if any_toggleLock_result2 then
						var43 = 1.05
					else
						var43 = 0.95
					end
					tbl_13.playbackSpeed = var43
					var43 = 0.3
					tbl_13.volume = var43
					var6_upvw:play("Lock Pet", tbl_13)
				end
			else
				local tbl_15 = {}
				tbl_15[1] = arg2
				if var10_upvw:unequipPet(tbl_15) == "success" then
					var6_upvw:play("Unequip Pet", {
						volume = 0.25;
					})
				end
			end
		end)
	end
end
function any_new_result1.petUIClicked(arg1, arg2, arg3, arg4) -- Line 141
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: var10_upvw (read and write)
		[4]: var6_upvw (read and write)
	]]
	local var47 = arg4
	if not var47 then
		var47 = {}
	end
	if not var47.item then
	end
	if arg1._archiveMode then
		if arg1._archivePets[arg3] then
			arg1._archivePets[arg3] = nil
		else
			arg1._archivePets[arg3] = true
		end
		arg2.Main.Confirm.Visible = arg1._archivePets[arg3]
	else
		if arg1._massLockMode then
			local any_toggleLock_result1_2, any_toggleLock_result2_2 = var10_upvw:toggleLock(arg3)
			local var50
			if any_toggleLock_result1_2 == "success" then
				arg2.Main.Locked.Visible = any_toggleLock_result2_2
				local tbl_5 = {}
				if any_toggleLock_result2_2 then
					var50 = 1.05
				else
					var50 = 0.95
				end
				tbl_5.playbackSpeed = var50
				var50 = 0.3
				tbl_5.volume = var50
				var6_upvw:play("Lock Pet", tbl_5)
			end
			return
		end
		local tbl_3 = {}
		tbl_3[1] = arg3
		if var10_upvw:equipPet(tbl_3) == "success" then
			var6_upvw:play("Equip Pet", {
				playbackSpeed = 1.1;
			})
		end
	end
end
function any_new_result1.createPetUI(arg1, arg2, arg3) -- Line 176
	--[[ Upvalues[5]:
		[1]: InventoryGrid_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var13_upvw (read and write)
	]]
	local var54 = arg3
	if not var54 then
		var54 = {}
	end
	local var55_upvw = var54
	var54 = var55_upvw.parent
	local var56 = var54
	if not var56 then
		var56 = InventoryGrid_upvr
	end
	if var56:FindFirstChild(arg2) then
	else
		local item_3 = var55_upvw.item
		if not item_3 then
			item_3 = var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2)
		end
		if not item_3 then
			return
		end
		local tbl_12 = {}
		tbl_12.name = arg2
		tbl_12.searchParams = true
		tbl_12.ignoreAnimateIconHover = true
		local any_pet_result1_upvr = var5_upvw.uis.pet(item_3, tbl_12)
		any_pet_result1_upvr.Parent = var56
		var13_upvw.new(any_pet_result1_upvr.Main):buttonUp(function() -- Line 197
			--[[ Upvalues[4]:
				[1]: arg1 (readonly)
				[2]: any_pet_result1_upvr (readonly)
				[3]: arg2 (readonly)
				[4]: var55_upvw (read and write)
			]]
			arg1:petUIClicked(any_pet_result1_upvr, arg2, var55_upvw)
		end)
		local tbl_7 = {}
		tbl_7.itemId = arg2
		var5_upvw:createInfoHoverOnGuiStateChange(any_pet_result1_upvr.Main.Click, tbl_7)
	end
end
function any_new_result1.createArchivePetUI(arg1, arg2) -- Line 204
	--[[ Upvalues[5]:
		[1]: InventoryGrid_upvr_2 (readonly)
		[2]: var4_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var13_upvw (read and write)
	]]
	local var62 = InventoryGrid_upvr_2
	if var62:FindFirstChild(arg2) then
	else
		local tbl = {}
		tbl.name = arg2
		tbl.searchParams = true
		tbl.ignoreAnimateIconHover = true
		local any_pet_result1_upvr_2 = var5_upvw.uis.pet(var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2, {
			archived = true;
			inventory = false;
		}), tbl)
		any_pet_result1_upvr_2.Parent = var62
		var13_upvw.new(any_pet_result1_upvr_2.Main):buttonUp(function() -- Line 220
			--[[ Upvalues[3]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
				[3]: any_pet_result1_upvr_2 (readonly)
			]]
			if arg1._archiveMode and arg1._archiveType == 2 then
				if arg1._archivePets[arg2] then
					arg1._archivePets[arg2] = nil
				else
					arg1._archivePets[arg2] = true
				end
				any_pet_result1_upvr_2.Main.Confirm.Visible = arg1._archivePets[arg2]
			end
		end)
		local tbl_6 = {}
		tbl_6.itemId = arg2
		var5_upvw:createInfoHoverOnGuiStateChange(any_pet_result1_upvr_2.Main.Click, tbl_6)
	end
end
local SoundService_upvr = game:GetService("SoundService")
function any_new_result1.playItemUseSound(arg1, arg2) -- Line 234
	--[[ Upvalues[3]:
		[1]: var15_upvw (read and write)
		[2]: SoundService_upvr (readonly)
		[3]: var6_upvw (read and write)
	]]
	local formatted = `Use Item {var15_upvw.toPascal(arg2:getClass())}`
	if not SoundService_upvr.SFX:FindFirstChild(formatted) then
	else
		var6_upvw:play(formatted, {
			volume = ({
				activeEvent = 0.3;
				fruit = 0.3;
			})[arg2:getClass()] or 0.5;
		})
	end
end
function any_new_result1.closeInventoryOnUse(arg1, arg2) -- Line 250
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	if arg2:getName():find("Axe") and not var4_upvw:getData().isAxeEquipped then
		var5_upvw:closeAllFrames()
	end
end
local ItemConfirmFrame_upvr = Menus:WaitForChild("ItemConfirmFrame")
function any_new_result1.itemUIClicked(arg1, arg2, arg3, arg4) -- Line 257
	--[[ Upvalues[6]:
		[1]: var8_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var4_upvw (read and write)
		[4]: var14_upvw (read and write)
		[5]: ItemConfirmFrame_upvr (readonly)
		[6]: var9_upvw (read and write)
	]]
	if var8_upvw:getFFlag("useItems") == false then
		var5_upvw:createMessagePopup({
			fFlagDisabled = true;
			reOpen = "InventoryFrame";
		})
	else
		if tick() - (arg1._debounceUseItem or 0) < 0.25 then return end
		arg1._debounceUseItem = tick()
		local var74 = arg4
		if not var74 then
			var74 = {}
		end
		local var75 = var74
		local item = var75.item
		if not item then
			item = var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg3)
		end
		if var75.isExclusiveEgg then
			var5_upvw:getFrameInstance("ExclusiveEggConfirmFrame"):SetAttribute("itemId", arg3)
			var5_upvw:openFrame("ExclusiveEggConfirmFrame")
			return
		end
		if item:hasConfirm() then
			ItemConfirmFrame_upvr:SetAttribute("itemId", arg3)
			var5_upvw:openFrame("ItemConfirmFrame")
			return
		end
		local any_useItem_result1, any_useItem_result2 = var9_upvw:useItem(arg3, item:getClass())
		if any_useItem_result1 == "success" then
			-- any_useItem_result2 is either a single {cl,nm,am} (potion/exclusive)
			-- or an array of {cl,nm,am} reward entries (box). Handle both.
			if type(any_useItem_result2) == "table" and any_useItem_result2[1] then
				-- Box reward: play sound on the box item itself, no further UI action
				-- (Replica will update inventory state automatically)
				arg1:playItemUseSound(item)
			else
				local any_createItemFromData_result1 = var14_upvw.itemUtils.createItemFromData(any_useItem_result2)
				if any_createItemFromData_result1 and any_createItemFromData_result1:getAmount() <= 0 then
					arg1:removeItemUIs(arg3)
				end
				if any_createItemFromData_result1 then
					arg1:playItemUseSound(any_createItemFromData_result1)
					arg1:closeInventoryOnUse(any_createItemFromData_result1)
				end
			end
		end
	end
end
function any_new_result1.setItemState(arg1, arg2, arg3) -- Line 297
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local any_getData_result1_2 = var4_upvw:getData()
	if not arg3:getName():find("Axe") then
	else
		local Main = arg2.Main
		local State = Main.State
		Main.Amount.Visible = false
		State.Visible = true
		State.ON.Visible = any_getData_result1_2.isAxeEquipped
		State.OFF.Visible = not any_getData_result1_2.isAxeEquipped
	end
end
function any_new_result1.createItemUI(arg1, arg2, arg3) -- Line 314
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: Holder_3_upvr (readonly)
		[4]: var15_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var13_upvw (read and write)
	]]
	local var83 = arg3
	if not var83 then
		var83 = {}
	end
	local var84_upvw = var83
	local parent = var84_upvw.parent
	if not parent then
		parent = Holder_3_upvr[var15_upvw.toPascal(var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2):getClass())].Clips.Holder
	end
	if parent:FindFirstChild(arg2) then
	else
		local item_2 = var84_upvw.item
		if not item_2 then
			item_2 = var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2)
		end
		if not item_2 then
			return
		end
		local tbl_10 = {}
		tbl_10.name = arg2
		tbl_10.searchParams = true
		tbl_10.ignoreAnimateIconHover = true
		local any_item_result1_upvr = var5_upvw.uis.item(item_2, tbl_10)
		any_item_result1_upvr.Parent = parent
		arg1:setItemState(any_item_result1_upvr, item_2)
		var13_upvw.new(any_item_result1_upvr.Main.IconContainer, any_item_result1_upvr.Main.Click):buttonUp(function() -- Line 337
			--[[ Upvalues[4]:
				[1]: arg1 (readonly)
				[2]: any_item_result1_upvr (readonly)
				[3]: arg2 (readonly)
				[4]: var84_upvw (read and write)
			]]
			arg1:itemUIClicked(any_item_result1_upvr, arg2, var84_upvw)
		end)
		local tbl_11 = {}
		tbl_11.itemId = arg2
		var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1_upvr.Main.Click, tbl_11)
	end
end
function any_new_result1.updatePetUI(arg1, arg2) -- Line 344
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: InventoryGrid_upvr (readonly)
		[4]: var15_upvw (read and write)
	]]
	local data_5 = var4_upvw.data
	local any_getItemFromId_result1_3 = var14_upvw.itemUtils.getItemFromId(data_5, arg2)
	local SOME_2 = InventoryGrid_upvr:FindFirstChild(arg2, true)
	if not SOME_2 then
	else
		local var95 = any_getItemFromId_result1_3:getAmount() - var14_upvw.itemUtils.getSamePetEquipped(data_5, any_getItemFromId_result1_3)
		local var96
		if not any_getItemFromId_result1_3:getSerial() then
			if var95 >= 1000000 then
				var96 = var15_upvw.suffixes(var95)
			else
				var96 = var15_upvw.comma(var95)
			end
			SOME_2.Main.Amount.Text = `x{var96}`
		end
		local invisible = not (var95 > 0)
		SOME_2:SetAttribute("invisible", invisible)
		SOME_2.Visible = not invisible
	end
end
function any_new_result1.updateItemUI(arg1, arg2) -- Line 365
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: Displays_upvr (readonly)
		[4]: var15_upvw (read and write)
	]]
	local any_getItemFromId_result1_2 = var14_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2)
	local SOME = Displays_upvr:FindFirstChild(arg2, true)
	if not SOME then
	else
		SOME.Main.Amount.Text = `x{var15_upvw.comma(any_getItemFromId_result1_2:getAmount())}`
		arg1:setItemState(SOME, any_getItemFromId_result1_2)
	end
end
function any_new_result1.update(arg1, arg2) -- Line 380
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
		[3]: var14_upvw (read and write)
	]]
	local data_6 = var4_upvw.data
	for _, v in var17_upvw[arg2].classes do
		if data_6.inventory[v] then
			for i_2, _ in data_6.inventory[v] do
				local itemObj = var14_upvw.itemUtils.getItemFromId(data_6, i_2)
				if not itemObj then continue end
				if itemObj:getClass() == "pet" then
					arg1:updatePetUI(i_2)
				else
					arg1:updateItemUI(i_2)
				end
			end
		end
	end
	arg1:updateYouDontHaveAny()
end
function any_new_result1.updateYouDontHaveAny(arg1) -- Line 399
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
		[3]: var15_upvw (read and write)
		[4]: InventoryFrame_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local var109 = false
	local var110 = false
	local var111 = ""
	local var112 = arg1._currentCategory
	if var112 == "items" then
		local count = 0
		for _, v_3 in var17_upvw.items.classes do
			if any_getData_result1.inventory[v_3] and var15_upvw.getAmountInTable(any_getData_result1.inventory[v_3]) ~= 0 then
				count += 1
			end
		end
		var111 = "Items"
		if count ~= 0 then
			var109 = false
		else
			var109 = true
		end
	else
		if var112 == "exclusiveEggs" then
			local hasNone = not any_getData_result1.inventory.exclusiveEgg
			if not hasNone then
				if var15_upvw.getAmountInTable(any_getData_result1.inventory.exclusiveEgg) ~= 0 then
					hasNone = false
				else
					hasNone = true
				end
			end
			var111 = "Eggs"
			var109 = hasNone
			var110 = hasNone
		end
	end
	InventoryFrame_upvr.YouDontHaveAny.GetMore.Visible = var110
	InventoryFrame_upvr.YouDontHaveAny.Label.Text = `You don't have any {var111} yet! 😅`
	InventoryFrame_upvr.YouDontHaveAny.Visible = var109
end
function any_new_result1.updateItemSections(arg1) -- Line 436
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
		[3]: Holder_3_upvr (readonly)
		[4]: var15_upvw (read and write)
		[5]: var14_upvw (read and write)
	]]
	local data = var4_upvw:getData()
	for _, class in var17_upvw.items.classes do
		local section = Holder_3_upvr:FindFirstChild(var15_upvw.toPascal(class))
		if section then
			local count = 0
			if data.inventory[class] then
				count = var15_upvw.getAmountInTable(data.inventory[class])
			end
			section.Visible = count > 0
			if section:FindFirstChild("Label") then
				section.Label.Text = var15_upvw.toPascal(class) .. " (" .. var15_upvw.suffixes(count) .. ")"
			end
		end
	end
end
function any_new_result1.loopRemoveItemUIs(arg1, arg2, arg3, arg4) -- Line 468
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: Holder_3_upvr (readonly)
		[3]: var15_upvw (read and write)
		[4]: Holder_2_upvr (readonly)
	]]
	local any_getData_result1_3 = var4_upvw:getData()
	for _, v_4 in arg3 do
		if any_getData_result1_3.inventory[v_4] then
			local var123
			if arg2 == "items" then
				var123 = Holder_3_upvr:FindFirstChild(var15_upvw.toPascal(v_4)).Clips.Holder
			elseif arg2 == "exclusiveEggs" then
				var123 = Holder_2_upvr
			end
			for _, v_5 in var123:GetChildren() do
				local function INLINED_2() -- Internal function, doesn't exist in bytecode
					return any_getData_result1_3.inventory[v_4][v_5.Name]
				end
				if v_5:GetAttribute("isItemUI") and (not INLINED_2() or arg4 == v_5.Name) then
					v_5:Destroy()
				end
			end
		end
	end
end
function any_new_result1.removeItemUIs(arg1, arg2) -- Line 500
	--[[ Upvalues[1]:
		[1]: var17_upvw (read and write)
	]]
	arg1:loopRemoveItemUIs("items", var17_upvw.items.classes, arg2)
	arg1:loopRemoveItemUIs("exclusiveEggs", var17_upvw.exclusiveEggs.classes, arg2)
end
local Equipped_upvr = Holder:WaitForChild("Equipped")
function any_new_result1.updateEquippedPetsLabel(arg1) -- Line 505
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var15_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: LocalPlayer_upvr (readonly)
		[5]: Equipped_upvr (readonly)
	]]
	local data_2 = var4_upvw.data
	Equipped_upvr.Label.Text = `Equipped ({var15_upvw.getAmountInTable(data_2.equippedPets)}/{var12_upvw.petsEquipped(LocalPlayer_upvr, data_2)})`
end
function any_new_result1.updateEquippedGrid(arg1) -- Line 514
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: EquippedGrid_upvr (readonly)
		[3]: var15_upvw (read and write)
	]]
	local var130
	if 0 >= var15_upvw.getAmountInTable(var4_upvw.data.equippedPets) then
		var130 = false
	else
		var130 = true
	end
	EquippedGrid_upvr.Visible = var130
end
function any_new_result1.updateEquippedPets(arg1) -- Line 519
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: EquippedGrid_upvr (readonly)
	]]
	local data_3 = var4_upvw.data
	for i_6, _ in data_3.equippedPets do
		arg1:createEquippedPetUI(i_6)
	end
	for _, v_7 in EquippedGrid_upvr:GetChildren() do
		if v_7:IsA("Frame") and not data_3.equippedPets[v_7.Name] then
			v_7:Destroy()
		end
	end
	arg1:updateEquippedPetsLabel()
	arg1:updateEquippedGrid()
end
function any_new_result1.hideDisplays(arg1, arg2) -- Line 538
	--[[ Upvalues[2]:
		[1]: Displays_upvr (readonly)
		[2]: var15_upvw (read and write)
	]]
	for _, v_8 in Displays_upvr:GetChildren() do
		if v_8:IsA("Frame") and var15_upvw.toCamel(v_8.Name) ~= arg2 then
			v_8.Visible = false
		end
	end
end
function any_new_result1.removeCategoryItems(arg1, arg2) -- Line 547
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: Displays_upvr (readonly)
		[3]: var15_upvw (read and write)
	]]
	for _, v_9 in Displays_upvr:GetChildren() do
		if var15_upvw.toCamel(v_9.Name) ~= arg2 then
			local class_ScrollingFrame_2 = v_9:FindFirstChildWhichIsA("ScrollingFrame", true)
			if class_ScrollingFrame_2 then
				for _, v_10 in class_ScrollingFrame_2:GetDescendants() do
					if v_10:GetAttribute("isItemUI") then
						v_10:Destroy()
					end
				end
				v_9.Visible = false
			end
		end
	end
end
function any_new_result1.createCategoryItems(arg1, arg2) -- Line 574
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: Holder_2_upvr (readonly)
	]]
	local data = var4_upvw.data
	arg1:removeCategoryItems(arg2)
	for _, v_11 in var17_upvw[arg2].classes do
		if data.inventory[v_11] then
			for i_12, itemData in data.inventory[v_11] do
				if type(itemData) ~= "table" then continue end
				local any_getItemFromId_result1 = var14_upvw.itemUtils.getItemFromId(data, i_12)
				if not any_getItemFromId_result1 then continue end
				if any_getItemFromId_result1:getClass() == "pet" then
					arg1:createPetUI(i_12)
				elseif any_getItemFromId_result1:getClass() == "exclusiveEgg" then
					arg1:createItemUI(i_12, {
						parent = Holder_2_upvr;
						isExclusiveEgg = true;
					})
				else
					arg1:createItemUI(i_12)
				end
			end
		end
	end
	arg1:hideDisplays(arg2)
	arg1:update(arg2)
end
function any_new_result1.createArchivedPetsUIs(arg1) -- Line 610
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: InventoryGrid_upvr_2 (readonly)
	]]
	arg1:removeCategoryItems("archive")
	for i_13, _ in var4_upvw.data.archivedPets do
		arg1:createArchivePetUI(i_13)
	end
	for _, v_14 in InventoryGrid_upvr_2:GetChildren() do
		if v_14:IsA("Frame") and not var4_upvw.data.archivedPets[v_14.Name] then
			v_14:Destroy()
		end
	end
end
function any_new_result1.updateArchivedPetsLabel(arg1) -- Line 628
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var14_upvw (read and write)
		[3]: Holder_4_upvr (readonly)
		[4]: var15_upvw (read and write)
	]]
	local var184 = 0
	for _, v_15 in var4_upvw.data.archivedPets do
		var184 += var14_upvw.itemUtils.createItemFromData(v_15):getAmount()
	end
	Holder_4_upvr.Archived.Label.Text = `Archived Pets ({var15_upvw.suffixes(var184)})`
end
function any_new_result1.hideArchiveIcons(arg1) -- Line 641
	--[[ Upvalues[1]:
		[1]: InventoryGrid_upvr (readonly)
	]]
	for _, v_16 in InventoryGrid_upvr:GetChildren() do
		if v_16:IsA("Frame") then
			v_16.Main.Confirm.Visible = false
		end
	end
end
function any_new_result1.toggleArchiveMode(arg1, arg2) -- Line 649
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	arg1._archiveMode = arg2
	arg1._archivePets = {}
	arg1._archiveType = 1
	arg1:hideArchiveIcons()
	arg1:updateArchivedPetsLabel()
	var16_upvw.archiveChange(arg2)
end
local Shadow_upvr = TagIcon_upvr:WaitForChild("Shadow")
local TagLabel_upvr = InventoryFrame_upvr:WaitForChild("TagLabel")
function any_new_result1.setTitle(arg1, arg2) -- Line 660
	--[[ Upvalues[4]:
		[1]: var18_upvw (read and write)
		[2]: TagIcon_upvr (readonly)
		[3]: Shadow_upvr (readonly)
		[4]: TagLabel_upvr (readonly)
	]]
	local var192 = var18_upvw[arg2]
	TagIcon_upvr.Image = var192.icon
	Shadow_upvr.Image = var192.icon
	TagLabel_upvr.Text = var192.title
end
function any_new_result1.setSidebar(arg1, arg2, arg3) -- Line 668
	Utility_upvr.Displays.Visible = (arg2 == "displays")
	local toolsVisible = arg3
	if not toolsVisible then
		toolsVisible = (arg2 == "tools")
	end
	Utility_upvr.Tools.Visible = toolsVisible
end
function any_new_result1.showCategory(arg1, arg2) -- Line 673
	--[[ Upvalues[4]:
		[1]: var15_upvw (read and write)
		[2]: var16_upvw (read and write)
		[3]: Displays_upvr (readonly)
		[4]: var7_upvw (read and write)
	]]
	if arg1._archiveMode then
		arg1:toggleArchiveMode(false)
	end
	var16_upvw.archive(false)
	arg1._currentCategory = arg2
	arg1:setCurrentSearch("")
	arg1:setTitle(arg2)
	arg1:setSidebar("displays")
	arg1:createCategoryItems(arg2)
	Displays_upvr[var15_upvw.toPascal(arg2)].Visible = true
	arg1:updateYouDontHaveAny()
	if arg2 == "pets" then
		arg1:updateEquippedPets()
		arg1:setSidebar("displays", true)
	elseif arg2 == "items" then
		arg1:updateItemSections()
	end
	var7_upvw:resetNewItems(`inventory{var15_upvw.toPascal(arg2)}`)
	arg1:updateInfoIndicators()
end
function any_new_result1.utilityDisplays(arg1) -- Line 703
	--[[ Upvalues[5]:
		[1]: List_upvr (readonly)
		[2]: var15_upvw (read and write)
		[3]: var13_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var17_upvw (read and write)
	]]
	for _, v_17 in List_upvr:GetChildren() do
		if v_17:IsA("Frame") then
			local any_toCamel_result1_upvr = var15_upvw.toCamel(v_17.Name)
			var13_upvw.new(v_17):buttonUp(function() -- Line 709
				--[[ Upvalues[2]:
					[1]: arg1 (readonly)
					[2]: any_toCamel_result1_upvr (readonly)
				]]
				arg1:showCategory(any_toCamel_result1_upvr)
			end)
			var5_upvw:createTooltipOnHover(v_17, var17_upvw[any_toCamel_result1_upvr].name)
		end
	end
end
local List_upvr_2 = Utility_upvr:WaitForChild("Tools"):WaitForChild("List")
function any_new_result1.utilityTools(arg1) -- Line 717
	--[[ Upvalues[16]:
		[1]: var13_upvw (read and write)
		[2]: List_upvr_2 (readonly)
		[3]: var5_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: Archive_upvr (readonly)
		[6]: var16_upvw (read and write)
		[7]: Bottom_upvr (readonly)
		[8]: var4_upvw (read and write)
		[9]: var15_upvw (read and write)
		[10]: var14_upvw (read and write)
		[11]: var12_upvw (read and write)
		[12]: LocalPlayer_upvr (readonly)
		[13]: var10_upvw (read and write)
		[14]: var6_upvw (read and write)
		[15]: EquippedGrid_upvr (readonly)
		[16]: InventoryGrid_upvr (readonly)
	]]
	var13_upvw.new(List_upvr_2.Close):buttonUp(function() -- Line 719
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:showCategory("pets")
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.Close, "Go Back")
	var13_upvw.new(List_upvr_2.Archive):buttonUp(function() -- Line 725
		--[[ Upvalues[5]:
			[1]: var8_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: Archive_upvr (copied, readonly)
			[5]: var16_upvw (copied, read and write)
		]]
		if var8_upvw:getFFlag("archivePets") == false then
			var5_upvw:createMessagePopup({
				title = "Sorry!";
				message = "This is disabled right now, try again later!";
				reOpen = "InventoryFrame";
			})
		else
			arg1._currentCategory = "archive"
			Archive_upvr.Visible = true
			arg1:createArchivedPetsUIs()
			arg1:updateArchivedPetsLabel()
			arg1:setTitle("archive")
			arg1:setSidebar("tools")
			var16_upvw.archive(true)
		end
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.Archive, "Archive")
	var13_upvw.new(List_upvr_2.Deposit):buttonUp(function() -- Line 749
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:toggleArchiveMode(true)
		arg1:createCategoryItems("pets")
		arg1._currentCategory = "pets"
		arg1:setTitle("archiveDeposit")
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.Deposit, "Deposit")
	var13_upvw.new(List_upvr_2.Withdraw):buttonUp(function() -- Line 759
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: Bottom_upvr (copied, readonly)
			[3]: var16_upvw (copied, read and write)
		]]
		arg1._archivePets = {}
		arg1._archiveMode = true
		arg1._archiveType = 2
		Bottom_upvr.Visible = true
		arg1:createArchivedPetsUIs()
		arg1:updateArchivedPetsLabel()
		arg1:setTitle("archiveWithdraw")
		var16_upvw.archive(true)
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.Withdraw, "Withdraw")
	var13_upvw.new(List_upvr_2.EquipBest):buttonUp(function() -- Line 775
		--[[ Upvalues[8]:
			[1]: arg1 (readonly)
			[2]: var4_upvw (copied, read and write)
			[3]: var15_upvw (copied, read and write)
			[4]: var14_upvw (copied, read and write)
			[5]: var12_upvw (copied, read and write)
			[6]: LocalPlayer_upvr (copied, readonly)
			[7]: var10_upvw (copied, read and write)
			[8]: var6_upvw (copied, read and write)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		if arg1._currentCategory ~= "pets" then
		else
			if tick() - (arg1._equipBestDebounce or 0) < 0.5 then return end
			arg1._equipBestDebounce = tick()
			local data_4 = var4_upvw.data
			if not data_4.inventory.pet then return end
			local tbl_14 = {}
			local var239_upvr = data_4
			for i_23, _ in var15_upvw.deepCopy(data_4.inventory.pet) do
				tbl_14[#tbl_14 + 1] = {
					itemId = i_23;
					item = var14_upvw.itemUtils.getItemFromId(data_4, i_23);
				}
			end
			table.sort(tbl_14, function(arg1_2, arg2) -- Line 799
				--[[ Upvalues[1]:
					[1]: var239_upvr (readonly)
				]]
				local var243
				if arg2.item:getMultiplier(var239_upvr, {
					ignoreServer = true;
				}) >= arg1_2.item:getMultiplier(var239_upvr, {
					ignoreServer = true;
				}) then
					var243 = false
				else
					var243 = true
				end
				return var243
			end)
			-- Collect currently equipped pet IDs before unequipping (fix: was scoped inside loop)
			local equippedPetIds = {}
			if var239_upvr.equippedPets then
				for i_26, _ in var239_upvr.equippedPets do
					equippedPetIds[#equippedPetIds + 1] = i_26
				end
			end
			for _, unequipId in equippedPetIds do
				var10_upvw:unequipPet({unequipId})
			end
			local tbl_9 = {}
			for _, v_24 in tbl_14 do
				if var12_upvw.petsEquipped(LocalPlayer_upvr, var239_upvr) <= #tbl_9 then break end
				for _ = 1, v_24.item:getAmount() do
					if var12_upvw.petsEquipped(LocalPlayer_upvr, var239_upvr) <= #tbl_9 then break end
					tbl_9[#tbl_9 + 1] = v_24.itemId
				end
			end
			var10_upvw:equipPet(tbl_9)
			var6_upvw:play("Equip Pet", {
				playbackSpeed = 1.1;
			})
		end
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.EquipBest, "Equip Best")
	var13_upvw.new(List_upvr_2.MassLock):buttonUp(function() -- Line 832
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: List_upvr_2 (copied, readonly)
		]]
		if arg1._currentCategory ~= "pets" then
		else
			arg1._massLockMode = not arg1._massLockMode
			List_upvr_2.MassLock.Icon.State.Visible = arg1._massLockMode
			if arg1._massLockMode then
				arg1:setTitle("lock")
				return
			end
			arg1:setTitle("pets")
		end
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.MassLock, "Mass Lock")
	var13_upvw.new(List_upvr_2.Shrink):buttonUp(function() -- Line 851
		--[[ Upvalues[4]:
			[1]: arg1 (readonly)
			[2]: EquippedGrid_upvr (copied, readonly)
			[3]: InventoryGrid_upvr (copied, readonly)
			[4]: List_upvr_2 (copied, readonly)
		]]
		if arg1._currentCategory ~= "pets" then
		else
			arg1._shrinked = not arg1._shrinked
			local cellSize
			if arg1._shrinked then
				cellSize = 82
			else
				cellSize = 112
			end
			EquippedGrid_upvr.UIGridLayout.CellSize = UDim2.fromOffset(cellSize, cellSize)
			InventoryGrid_upvr.UIGridLayout.CellSize = UDim2.fromOffset(cellSize, cellSize)
			List_upvr_2.Shrink.Icon.State.Visible = arg1._shrinked
		end
	end)
	var5_upvw:createTooltipOnHover(List_upvr_2.Shrink, "Shrink")
end
function any_new_result1.utilityButtons(arg1) -- Line 869
	arg1:utilityDisplays()
	arg1:utilityTools()
end
function any_new_result1.bottomButtons(arg1) -- Line 874
	--[[ Upvalues[6]:
		[1]: var13_upvw (read and write)
		[2]: Bottom_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: InventoryFrame_upvr (readonly)
		[6]: var5_upvw (read and write)
	]]
	var13_upvw.new(Bottom_upvr.Confirm):buttonUp(function() -- Line 876
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: var10_upvw (copied, read and write)
			[3]: var6_upvw (copied, read and write)
		]]
		if arg1._archiveMode then
			arg1:toggleArchiveMode(false)
			arg1._currentCategory = "archive"
			var6_upvw:play("Archive Pet")
			arg1:setTitle("archive")
			task.wait(0.1)
			arg1:createArchivedPetsUIs()
		end
	end)
	var13_upvw.new(Bottom_upvr.Cancel):buttonUp(function() -- Line 893
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1._archiveMode then
			arg1:toggleArchiveMode(false)
			arg1:createArchivedPetsUIs()
			arg1._currentCategory = "archive"
			arg1:setTitle("archive")
		end
	end)
	var13_upvw.new(InventoryFrame_upvr.YouDontHaveAny.GetMore):buttonUp(function() -- Line 904
		--[[ Upvalues[1]:
			[1]: var5_upvw (copied, read and write)
		]]
		var5_upvw:openFrame("ShopFrame")
	end)
end
local HttpService_upvr = game:GetService("HttpService")
function any_new_result1.showFramesOnSearch(arg1, arg2, arg3) -- Line 909
	--[[ Upvalues[1]:
		[1]: HttpService_upvr (readonly)
	]]
	for _, v_18 in arg3:GetChildren() do
		if v_18:GetAttribute("isItemUI") then
			local var278
			if not var278 then
				var278 = false
				for _, v_19 in HttpService_upvr:JSONDecode(v_18:GetAttribute("searchParams")) do
					if string.match(string.lower(v_19), string.lower(arg2)) then
						var278 = true
					end
				end
				if var278 or arg2 == nil or arg2 == "" then
					v_18.Visible = true
				else
					v_18.Visible = false
				end
			end
		end
	end
end
function any_new_result1.search(arg1) -- Line 935
	--[[ Upvalues[6]:
		[1]: TextBox_upvr (readonly)
		[2]: InventoryGrid_upvr (readonly)
		[3]: InventoryGrid_upvr_2 (readonly)
		[4]: var17_upvw (read and write)
		[5]: Holder_3_upvr (readonly)
		[6]: var15_upvw (read and write)
	]]
	TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 936
		--[[ Upvalues[7]:
			[1]: TextBox_upvr (copied, readonly)
			[2]: arg1 (readonly)
			[3]: InventoryGrid_upvr (copied, readonly)
			[4]: InventoryGrid_upvr_2 (copied, readonly)
			[5]: var17_upvw (copied, read and write)
			[6]: Holder_3_upvr (copied, readonly)
			[7]: var15_upvw (copied, read and write)
		]]
		local Text = TextBox_upvr.Text
		arg1:showFramesOnSearch(Text, InventoryGrid_upvr)
		arg1:showFramesOnSearch(Text, InventoryGrid_upvr_2)
		for _, v_20 in var17_upvw.items.classes do
			arg1:showFramesOnSearch(Text, Holder_3_upvr:FindFirstChild(var15_upvw.toPascal(v_20)).Clips.Holder)
		end
	end)
end
function any_new_result1.setCurrentSearch(arg1, arg2) -- Line 950
	--[[ Upvalues[1]:
		[1]: TextBox_upvr (readonly)
	]]
	TextBox_upvr.Text = arg2
end
function any_new_result1.updateInfoIndicators(arg1) -- Line 954
	--[[ Upvalues[2]:
		[1]: var7_upvw (read and write)
		[2]: List_upvr (readonly)
	]]
	-- Pets indicator
	local any_getNewItems_result1 = var7_upvw:getNewItems("inventoryPets")
	local petsVisible = any_getNewItems_result1 > 0
	List_upvr.Pets.InfoIndicator.Visible = petsVisible
	List_upvr.Pets.InfoIndicator.Amount.Text = any_getNewItems_result1

	-- Items indicator
	local any_getNewItems_result1_3 = var7_upvw:getNewItems("inventoryItems")
	local itemsVisible = any_getNewItems_result1_3 > 0
	List_upvr.Items.InfoIndicator.Visible = itemsVisible
	List_upvr.Items.InfoIndicator.Amount.Text = any_getNewItems_result1_3

	-- ExclusiveEggs indicator
	local any_getNewItems_result1_2 = var7_upvw:getNewItems("inventoryExclusiveEggs")
	local eggsVisible = any_getNewItems_result1_2 > 0
	List_upvr.ExclusiveEggs.InfoIndicator.Visible = eggsVisible
	List_upvr.ExclusiveEggs.InfoIndicator.Amount.Text = any_getNewItems_result1_2
end
function any_new_result1.opened(arg1) -- Line 968
	--[[ Upvalues[2]:
		[1]: var16_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	arg1:setCurrentSearch("")
	arg1:toggleArchiveMode(false)
	var16_upvw.archive(false)
	if arg1._currentCategory == "archive" then
		arg1._currentCategory = "pets"
	end
	arg1:showCategory(arg1._currentCategory or "pets")
	arg1:update(arg1._currentCategory or "pets")
	arg1:updateInfoIndicators()
	var7_upvw:resetNewItems("inventory")
end
function any_new_result1.closed(arg1) -- Line 994
	arg1:removeCategoryItems()
end
function any_new_result1.valuesChanged(arg1) -- Line 998
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var17_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"equippedPets"}, function(arg1_3) -- Line 999
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateEquippedPets()
		arg1:update("pets")
		arg1:setCurrentSearch("")
	end)
	for i_21_upvr, v_21 in var17_upvw do
		for _, v_22 in v_21.classes do
			var4_upvw.replica:OnSet({"inventory", v_22}, function(arg1_4) -- Line 1007
				--[[ Upvalues[2]:
					[1]: arg1 (readonly)
					[2]: i_21_upvr (readonly)
				]]
				if arg1._currentCategory ~= i_21_upvr then
				else
					arg1:createCategoryItems(i_21_upvr)
					arg1:update(i_21_upvr)
					if i_21_upvr == "items" then
						arg1:updateItemSections()
					end
				end
			end)
		end
	end
	var4_upvw.replica:OnSet({"archivedPets"}, function(arg1_5) -- Line 1021
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1._currentCategory ~= "archive" then
		else
			arg1:createArchivedPetsUIs()
			arg1:updateArchivedPetsLabel()
		end
	end)
	var4_upvw.replica:OnSet({"isAxeEquipped"}, function(arg1_6) -- Line 1027
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update("items")
	end)
end
function any_new_result1.Start(arg1) -- Line 1032
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	arg1:valuesChanged()
	arg1:utilityButtons()
	arg1:bottomButtons()
	arg1:search()
	arg1:opened()
	var5_upvw:listenToOpen("InventoryFrame"):Connect(function() -- Line 1041
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose("InventoryFrame"):Connect(function() -- Line 1044
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
	var7_upvw.newItems:Connect(function() -- Line 1048
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateInfoIndicators()
	end)
	var6_upvw:preloadSounds({"Equip Pet", "Unequip Pet", "Lock Pet", "Archive Pet", "Use Item ActiveEvent", "Use Item Box", "Use Item Fruit", "Use Item Potion"})
end
local var306_upvw
local var307_upvw
local var308_upvw
function any_new_result1.Construct(arg1) -- Line 1064
	--[[ Upvalues[19]:
		[1]: var9_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var8_upvw (read and write)
		[9]: var306_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var12_upvw (read and write)
		[12]: var13_upvw (read and write)
		[13]: var14_upvw (read and write)
		[14]: var15_upvw (read and write)
		[15]: var16_upvw (read and write)
		[16]: var17_upvw (read and write)
		[17]: var307_upvw (read and write)
		[18]: var308_upvw (read and write)
		[19]: var18_upvw (read and write)
	]]
	var9_upvw = Knit_upvr.GetService("InventoryService")
	var10_upvw = Knit_upvr.GetService("PetService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("ItemController")
	var8_upvw = Knit_upvr.GetController("FFlagController")
	var306_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var13_upvw = require(Knit_upvr.Modules.Button)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var15_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var16_upvw = require(script.Modes)
	var17_upvw = require(script.Categories)
	var307_upvw = require(Knit_upvr.Modules.InfoHover)
	var308_upvw = require(ReplicatedStorage_upvr.Packages.Input).PreferredInput
	var18_upvw = require(script.Titles)
end
return any_new_result1