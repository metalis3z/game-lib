-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:48
-- Luau version 6, Types version 3
-- Time taken: 0.009207 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "CraftMachineFrame";
})
any_new_result1._selectedItems = {}
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
function any_new_result1.updateSide(arg1, arg2) -- Line 36
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: var9_upvw (read and write)
	]]
	local data = var4_upvw.data
	local Canvas = arg1.Instance.Main.Canvas
	local Side = Canvas.Side
	local Select = Canvas.Select
	local var23
	if var10_upvw.getAmountInTable(arg1._selectedItems) > 0 then
		var23 = false
	else
		var23 = true
	end
	Select.Visible = var23
	Side.Visible = not var23
	if var23 then
	else
		local any_getItemFromId_result1_2 = var9_upvw.itemUtils.getItemFromId(data, arg2)
		Side.Title.Text = any_getItemFromId_result1_2:getName()
		Side.ImageContainer.PetIcon.Image = any_getItemFromId_result1_2:getIcon()
		Side.Multiplier.Before.Text = `x{var10_upvw.suffixes(any_getItemFromId_result1_2:getMultiplier())}`
		Side.Multiplier.After.Text = `x{var10_upvw.suffixes(var9_upvw.itemUtils.createItemFromData(any_getItemFromId_result1_2):setTier(any_getItemFromId_result1_2:getTier() + 1):getMultiplier())}`
		local var28 = 0
		for i_6, _ in data.inventory.pet do
			local any_getItemFromId_result1_3 = var9_upvw.itemUtils.getItemFromId(data, i_6)
			if var9_upvw.itemUtils.isSame(any_getItemFromId_result1_2, any_getItemFromId_result1_3, {
				checkExistence = {"sl"};
			}) then
				var28 = var28 + any_getItemFromId_result1_3:getAmount()
			end
		end
		-- Craft requires 5, CraftAll requires 10
		Side.Craft.Locked.Visible = var28 < 5
		Side.CraftAll.Locked.Visible = var28 < 10
		Side.ImageContainer.PetAmount.Text = `x{var10_upvw.suffixes(var28)}`
		if var28 < 5 then
			Side.ImageContainer.PetAmount.TextColor3 = Color3.fromRGB(255, 47, 47)
		else
			Side.ImageContainer.PetAmount.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		Side.Visible = true
		Select.Visible = false
	end
end
function any_new_result1.setFrameCheckmark(arg1, arg2, arg3) -- Line 82
	arg2.Main.Checkmark.Visible = arg3
end
function any_new_result1.setFrameNotSelectable(arg1, arg2) -- Line 89
	local Main = arg2.Main
	local Color3_fromRGB_result1 = Color3.fromRGB(113, 113, 113)
	Main.BackgroundColor3 = Color3_fromRGB_result1
	Main.IconContainer.ImageLabel.ImageColor3 = Color3_fromRGB_result1
	arg2.LayoutOrder += 1000000
end
function any_new_result1.petUIClicked(arg1, arg2, arg3) -- Line 101
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var10_upvw (read and write)
	]]
	if var9_upvw.itemUtils.getItemFromId(var4_upvw.data, arg3):getLocked() then
	else
		if arg1._selectedItems[arg3] then
			arg1._selectedItems[arg3] = nil
			arg1:setFrameCheckmark(arg2, false)
		else
			arg1._selectedItems[arg3] = true
			arg1:setFrameCheckmark(arg2, true)
		end
		if 0 < var10_upvw.getAmountInTable(arg1._selectedItems) then
			arg1:showItemsWithSameConditions(arg3)
		else
			arg1:showItemsWithSameConditions()
		end
		arg1:updateSide(arg3)
	end
end
function any_new_result1.createPetUI(arg1, arg2, arg3) -- Line 125
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: var8_upvw (read and write)
	]]
	local Holder = arg1.Instance.Main.List.Holder
	if Holder:FindFirstChild(arg2) then
	else
		local any_getItemFromId_result1 = var9_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2)
		if any_getItemFromId_result1:getTier() ~= arg1._tier - 1 then return end
		local tbl = {}
		tbl.name = arg2
		tbl.searchParams = true
		tbl.ignoreAnimateIconHover = true
		local any_pet_result1_upvr = var5_upvw.uis.pet(any_getItemFromId_result1, tbl)
		-- Color amount text red if fewer than 5
		if 5 > any_getItemFromId_result1:getAmount() then
			any_pet_result1_upvr.Main.Amount.TextColor3 = Color3.fromRGB(255, 47, 47)
		else
			any_pet_result1_upvr.Main.Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		-- LayoutOrder: always use existing LayoutOrder as base
		any_pet_result1_upvr.LayoutOrder = any_pet_result1_upvr.LayoutOrder + 1000000000
		any_pet_result1_upvr.Parent = Holder
		if any_getItemFromId_result1:getLocked() then
			arg1:setFrameNotSelectable(any_pet_result1_upvr)
		end
		-- Fix: use var8_upvw (Button module) with the Main frame
		var8_upvw.new(any_pet_result1_upvr.Main):buttonUp(function() -- Line 157
			--[[ Upvalues[3]:
				[1]: arg1 (readonly)
				[2]: any_pet_result1_upvr (readonly)
				[3]: arg2 (readonly)
			]]
			arg1:petUIClicked(any_pet_result1_upvr, arg2)
		end)
		local tbl_2 = {}
		tbl_2.itemId = arg2
		var5_upvw:createInfoHoverOnGuiStateChange(any_pet_result1_upvr.Main.Click, tbl_2)
	end
end
function any_new_result1.createPetUIs(arg1) -- Line 164
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local data_3 = var4_upvw.data
	if not data_3.inventory.pet then
	else
		for var38, _ in data_3.inventory.pet do
			arg1:createPetUI(var38)
		end
	end
end
function any_new_result1.removePetUIs(arg1) -- Line 176
	for _, v in arg1.Instance.Main.List.Holder:GetChildren() do
		if v:GetAttribute("isItemUI") then
			v:Destroy()
		end
	end
end
function any_new_result1.showItemsWithSameConditions(arg1, arg2) -- Line 186
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var9_upvw (read and write)
	]]
	local data_2 = var4_upvw.data
	for i_2, _ in data_2.inventory.pet do
		local SOME = arg1.Instance.Main.List.Holder:FindFirstChild(i_2)
		if SOME and not SOME:GetAttribute("invisible") then
			if not arg2 then
				SOME.Visible = true
			else
				SOME.Visible = var9_upvw.itemUtils.isSame(var9_upvw.itemUtils.getItemFromId(data_2, arg2), var9_upvw.itemUtils.getItemFromId(data_2, i_2), {
					checkExistence = {"sl"};
				})
			end
		end
	end
end
function any_new_result1.getItemIdsToSend(arg1) -- Line 216
	local module = {}
	for i_3, _ in arg1._selectedItems do
		module[#module + 1] = i_3
	end
	return module
end
function any_new_result1.buttons(arg1) -- Line 226
	--[[ Upvalues[4]:
		[1]: var8_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	local Side_2_upvr = arg1.Instance.Main.Canvas.Side
	var8_upvw.new(Side_2_upvr.Craft):buttonUp(function() -- Line 233
		--[[ Upvalues[5]:
			[1]: Side_2_upvr (readonly)
			[2]: var7_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: var9_upvw (copied, read and write)
			[5]: var5_upvw (copied, read and write)
		]]
		if Side_2_upvr.Craft.Locked.Visible then
		else
			local any_craft_result1_2, _ = var7_upvw:craft(arg1:getItemIdsToSend())
			if any_craft_result1_2 == "success" then
				var5_upvw:createMessagePopup({
					message = `You crafted a {var9_upvw.petUtils.getTierData(arg1._tier).name} pet!`;
					reOpen = arg1.Instance.Name;
					sound = "Craft";
				})
				table.clear(arg1._selectedItems)
				arg1:updateSide()
			end
		end
	end)
	var8_upvw.new(Side_2_upvr.CraftAll):buttonUp(function() -- Line 253
		--[[ Upvalues[5]:
			[1]: Side_2_upvr (readonly)
			[2]: var7_upvw (copied, read and write)
			[3]: arg1 (readonly)
			[4]: var9_upvw (copied, read and write)
			[5]: var5_upvw (copied, read and write)
		]]
		if Side_2_upvr.CraftAll.Locked.Visible then
		else
			local any_craft_result1, any_craft_result2 = var7_upvw:craft(arg1:getItemIdsToSend(), true)
			if any_craft_result1 == "success" then
				var5_upvw:createMessagePopup({
					message = `You crafted {var9_upvw.petUtils.getTierData(arg1._tier).name} pets! (x{any_craft_result2})`;
					reOpen = arg1.Instance.Name;
					sound = "Craft";
				})
				table.clear(arg1._selectedItems)
				arg1:updateSide()
			end
		end
	end)
end
local HttpService_upvr = game:GetService("HttpService")
function any_new_result1.showFramesOnSearch(arg1) -- Line 273
	--[[ Upvalues[2]:
		[1]: var10_upvw (read and write)
		[2]: HttpService_upvr (readonly)
	]]
	local Text = arg1.Instance.SearchBar.TextBox.Text
	for _, v_4 in arg1.Instance.Main.List.Holder:GetDescendants() do
		if v_4:GetAttribute("isItemUI") then
			-- Fixed: var92 was uninitialized (nil) then checked with 0 >= var92 (crash)
			-- Fixed: outer if 0 >= var92 is a decompiler artifact — block always runs
			local matched = false
			-- Fixed: for i_5, v_5 in ..., nil — broken ipairs decomp; use ipairs directly
			for _, v_5 in ipairs(HttpService_upvr:JSONDecode(v_4:GetAttribute("searchParams"))) do
				if string.match(string.lower(v_5), string.lower(Text)) then
					matched = true
				end
			end
			if matched or Text == nil or Text == "" then
				v_4.Visible = true
			else
				v_4.Visible = false
			end
			-- Fixed: i_5 (for-loop var, out of scope) reused as boolean — use isInvisible
			local isInvisible = not matched and not (Text == nil or Text == "")
			v_4:SetAttribute("invisible", isInvisible or nil)
		end
	end
end
function any_new_result1.search(arg1) -- Line 303
	arg1.Instance.SearchBar.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line 304
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:showFramesOnSearch()
	end)
end
function any_new_result1.opened(arg1) -- Line 309
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	if var5_upvw:getCurrentFrameOpen() ~= arg1.Instance.Name then
	else
		table.clear(arg1._selectedItems)
		arg1:createPetUIs()
		arg1.Instance.SearchBar.TextBox.Text = ""
		arg1.Instance.Main.Canvas.Select.Visible = true
		arg1.Instance.Main.Canvas.Side.Visible = false
	end
end
function any_new_result1.closed(arg1) -- Line 322
	arg1:removePetUIs()
end
function any_new_result1.Start(arg1) -- Line 326
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:buttons()
	arg1:search()
	arg1:opened()
	var5_upvw:listenToOpen(arg1.Instance.Name):Connect(function() -- Line 331
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
	var5_upvw:listenToClose(arg1.Instance.Name):Connect(function() -- Line 334
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:closed()
	end)
	var6_upvw:preloadSounds({"Craft"})
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 343
	--[[ Upvalues[9]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var9_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var10_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("PetService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var10_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	arg1._tier = arg1.Instance:GetAttribute("tier")
end
return any_new_result1