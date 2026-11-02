-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:28
-- Luau version 6, Types version 3
-- Time taken: 0.006279 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "BoothChooseFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local BoothChooseFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BoothChooseFrame")
local Main = BoothChooseFrame:WaitForChild("Main")
local Inventory_upvr = Main:WaitForChild("List"):WaitForChild("Holder"):WaitForChild("Inventory")
local SelectAmount_upvr = Main:WaitForChild("SelectAmount")
local TextBox_upvr_2 = SelectAmount_upvr:WaitForChild("Input"):WaitForChild("TextBox")
local TextBox_upvr = BoothChooseFrame:WaitForChild("SearchBar"):WaitForChild("TextBox")
function any_new_result1.createItemFrame(arg1, arg2, arg3) -- Line 48
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var5_upvw (read and write)
	]]
	local any_getItemFromId_result1 = var8_upvw.itemUtils.getItemFromId(var4_upvw:getData(), arg2)
	local var18
	if any_getItemFromId_result1:getClass() == "pet" then
		local tbl = {}
		tbl.name = arg2
		tbl.searchParams = true
		tbl.ignoreAnimateIconHover = true
		var18 = var5_upvw.uis.pet(any_getItemFromId_result1, tbl)
	else
		local tbl_3 = {}
		tbl_3.name = arg2
		tbl_3.searchParams = true
		tbl_3.ignoreAnimateIconHover = true
		var18 = var5_upvw.uis.item(any_getItemFromId_result1, tbl_3)
	end
	local tbl_2 = {}
	tbl_2.itemId = arg2
	tbl_2.item = any_getItemFromId_result1
	tbl_2.unusable = true
	var5_upvw:createInfoHoverOnGuiStateChange(var18.Main.Click, tbl_2)
	if 0 < arg3 then
		var18.Main.Amount.Text = `x{any_getItemFromId_result1:getAmount() - arg3}`
	end
	return var18
end
function any_new_result1.getAmountOfSame(arg1, arg2) -- Line 82
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	local var26
	if not var8_upvw.itemUtils.getItemFromId(var4_upvw:getData(), arg2) then
		var26 = 0
		return var26
	end
	var26 = 0
	for _, v in var6_upvw._offers do
		if v.itemId == arg2 then
			var26 += 1
		end
	end
	return var26
end
function any_new_result1.createCategory(arg1, arg2) -- Line 102
	--[[ Upvalues[9]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: Inventory_upvr (readonly)
		[4]: SelectAmount_upvr (readonly)
		[5]: var9_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var6_upvw (read and write)
		[9]: TextBox_upvr_2 (readonly)
	]]
	local data_2 = var4_upvw.data
	arg1:removeCategories()
	arg1:setCurrentSearch("")
	Inventory_upvr.Visible = true
	SelectAmount_upvr.Visible = false
	for _, v_2 in var10_upvw[arg2].classes do
		if data_2.inventory[v_2] then
			for i_3_upvr, _ in data_2.inventory[v_2] do
				local any_getItemFromId_result1_2 = var8_upvw.itemUtils.getItemFromId(data_2, i_3_upvr)
				if not any_getItemFromId_result1_2:isUntradeable() then
					local any_getAmountOfSame_result1_2 = arg1:getAmountOfSame(i_3_upvr)
					if any_getItemFromId_result1_2:getAmount() - any_getAmountOfSame_result1_2 > 0 then
						local any_createItemFrame_result1_2 = arg1:createItemFrame(i_3_upvr, any_getAmountOfSame_result1_2)
						any_createItemFrame_result1_2.Parent = Inventory_upvr
						var7_upvw.new(any_createItemFrame_result1_2.Main):buttonUp(function() -- Line 134
							--[[ Upvalues[5]:
								[1]: Inventory_upvr (copied, readonly)
								[2]: var6_upvw (copied, read and write)
								[3]: TextBox_upvr_2 (copied, readonly)
								[4]: SelectAmount_upvr (copied, readonly)
								[5]: i_3_upvr (readonly)
							]]
							Inventory_upvr.Visible = false
							var6_upvw._offer.price = 0
							TextBox_upvr_2.Text = ""
							SelectAmount_upvr.Visible = true
							var6_upvw._offer.itemId = i_3_upvr
						end)
					end
				end
			end
		end
	end
end
function any_new_result1.removeCategories(arg1, arg2) -- Line 148
	--[[ Upvalues[3]:
		[1]: var10_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: Inventory_upvr (readonly)
	]]
	for i_4, _ in var10_upvw do
		for _, _ in var10_upvw[i_4].classes do
			for _, v_6 in Inventory_upvr:GetChildren() do
				if v_6:GetAttribute("isItemUI") then
					v_6:Destroy()
				end
			end
		end
	end
end
function any_new_result1.input(arg1) -- Line 162
	--[[ Upvalues[5]:
		[1]: TextBox_upvr_2 (readonly)
		[2]: var4_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: var9_upvw (read and write)
		[5]: var6_upvw (read and write)
	]]
	TextBox_upvr_2.FocusLost:Connect(function() -- Line 163
		--[[ Upvalues[5]:
			[1]: var4_upvw (copied, read and write)
			[2]: TextBox_upvr_2 (copied, readonly)
			[3]: var5_upvw (copied, read and write)
			[4]: var9_upvw (copied, read and write)
			[5]: var6_upvw (copied, read and write)
		]]
		local tonumber_result1 = tonumber(TextBox_upvr_2.Text)
		if not tonumber_result1 or tonumber_result1 < 1 then
			TextBox_upvr_2.Text = ""
			var5_upvw:createMessagePopup({
				message = "Please enter an amount of 1 or higher!";
				reOpen = "BoothChooseFrame";
			})
		else
			if 25000 < tonumber_result1 then
				TextBox_upvr_2.Text = ""
				var5_upvw:createMessagePopup({
					message = "Please enter an amount of 25,000 or lower!";
					reOpen = "BoothChooseFrame";
				})
				return
			end
			TextBox_upvr_2.Text = var9_upvw.comma(math.floor(tonumber_result1))
			var6_upvw._offer.price = math.floor(tonumber_result1)
		end
	end)
end
local HttpService_upvr = game:GetService("HttpService")
function any_new_result1.showFramesOnSearch(arg1, arg2) -- Line 191
	--[[ Upvalues[2]:
		[1]: Inventory_upvr (readonly)
		[2]: HttpService_upvr (readonly)
	]]
	for _, v_7 in Inventory_upvr:GetChildren() do
		if v_7:GetAttribute("isItemUI") then
			local var82 = false
			local searchParams = v_7:GetAttribute("searchParams")
			if searchParams then
				for _, v_8 in HttpService_upvr:JSONDecode(searchParams) do
					if string.match(string.lower(v_8), string.lower(arg2)) then
						var82 = true
					end
				end
			end
			if var82 or arg2 == nil or arg2 == "" then
				v_7.Visible = true
			else
				v_7.Visible = false
			end
		end
	end
end
function any_new_result1.search(arg1) -- Line 217
	--[[ Upvalues[1]:
		[1]: TextBox_upvr (readonly)
	]]
	TextBox_upvr:GetPropertyChangedSignal("Text"):Connect(function() -- Line 218
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: TextBox_upvr (copied, readonly)
		]]
		arg1:showFramesOnSearch(TextBox_upvr.Text)
	end)
end
function any_new_result1.setCurrentSearch(arg1, arg2) -- Line 223
	--[[ Upvalues[1]:
		[1]: TextBox_upvr (readonly)
	]]
	TextBox_upvr.Text = arg2
end
local List_upvr = BoothChooseFrame:WaitForChild("Tools"):WaitForChild("List")
function any_new_result1.buttons(arg1) -- Line 227
	--[[ Upvalues[7]:
		[1]: List_upvr (readonly)
		[2]: var7_upvw (read and write)
		[3]: var9_upvw (read and write)
		[4]: SelectAmount_upvr (readonly)
		[5]: var6_upvw (read and write)
		[6]: var5_upvw (read and write)
		[7]: Inventory_upvr (readonly)
	]]
	for _, v_9_upvr in List_upvr:GetChildren() do
		if v_9_upvr:IsA("Frame") then
			var7_upvw.new(v_9_upvr):buttonUp(function() -- Line 231
				--[[ Upvalues[3]:
					[1]: arg1 (readonly)
					[2]: var9_upvw (copied, read and write)
					[3]: v_9_upvr (readonly)
				]]
				arg1:createCategory(var9_upvw.toCamel(v_9_upvr.Name))
			end)
		end
	end
	var7_upvw.new(SelectAmount_upvr.Confirm):buttonUp(function() -- Line 237
		--[[ Upvalues[2]:
			[1]: var6_upvw (copied, read and write)
			[2]: var5_upvw (copied, read and write)
		]]
		if var6_upvw._offer.price <= 0 then
		else
			var5_upvw:openFrame("BoothConfirmSellFrame")
		end
	end)
	var7_upvw.new(SelectAmount_upvr.Cancel):buttonUp(function() -- Line 246
		--[[ Upvalues[2]:
			[1]: SelectAmount_upvr (copied, readonly)
			[2]: Inventory_upvr (copied, readonly)
		]]
		SelectAmount_upvr.Visible = false
		Inventory_upvr.Visible = true
	end)
end
function any_new_result1.opened(arg1) -- Line 252
	arg1:createCategory("pets")
end
function any_new_result1.Start(arg1) -- Line 256
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:input()
	arg1:search()
	arg1:opened()
	var5_upvw:listenToOpen("BoothChooseFrame"):Connect(function() -- Line 262
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var94_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 267
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var94_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var9_upvw (read and write)
		[10]: var10_upvw (read and write)
	]]
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var94_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("TradingPlazaController")
	var7_upvw = require(Knit_upvr.Modules.Button)
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var10_upvw = require(script.Categories)
end
return any_new_result1