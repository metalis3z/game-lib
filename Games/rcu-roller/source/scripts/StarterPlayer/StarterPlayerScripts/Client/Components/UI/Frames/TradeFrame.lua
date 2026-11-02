-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:41
-- Luau version 6, Types version 3
-- Time taken: 0.017473 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TradeFrame";
})
any_new_result1._itemsInTrade = {}
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local Players_upvr = game:GetService("Players")
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local MainUI = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local TradeFrame_upvr = MainUI:WaitForChild("Menus"):WaitForChild("TradeFrame")
local Main_upvr = TradeFrame_upvr:WaitForChild("Main")
local TextBox_upvr_2 = TradeFrame_upvr:WaitForChild("SearchBar"):WaitForChild("TextBox")
local Displays_upvr = TradeFrame_upvr:WaitForChild("Displays")
local Player1_upvr = Main_upvr:WaitForChild("Player1")
local Player2_upvr = Main_upvr:WaitForChild("Player2")
local Inventory_2 = Player1_upvr:WaitForChild("Inventory")
local Holder_upvr = Inventory_2:WaitForChild("List"):WaitForChild("Holder")
local TradeTokens_upvr_2 = Inventory_2:WaitForChild("TradeTokens")
local TextBox_upvr = TradeTokens_upvr_2:WaitForChild("Input"):WaitForChild("TextBox")
local Inventory = Player2_upvr:WaitForChild("Inventory")
local Holder_upvr_2 = Inventory:WaitForChild("List"):WaitForChild("Holder")
local ProcessTrade_upvr = Inventory:WaitForChild("ProcessTrade")
function any_new_result1.getCategoryFromClass(arg1, arg2) -- Line 77
	--[[ Upvalues[1]:
		[1]: var13_upvw (read and write)
	]]
	for i, _ in var13_upvw do
		for _, v_2 in var13_upvw[i].classes do
			if v_2 == arg2 then
				return i
			end
		end
	end
end
function any_new_result1.addItemToTrade(arg1, arg2) -- Line 87
	--[[ Upvalues[5]:
		[1]: var8_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: Holder_upvr (readonly)
		[5]: var5_upvw (read and write)
	]]
	local any_addItemToTrade_result1, any_addItemToTrade_result2 = var8_upvw:addItemToTrade(arg2)
	if any_addItemToTrade_result1 == "success" then
		local any_createItemFromData_result1 = var11_upvw.itemUtils.createItemFromData(any_addItemToTrade_result2)
		arg1:createItemFrame(arg2, any_createItemFromData_result1, Holder_upvr.InTrade, true)
		arg1:updateItemFrame(arg2, any_createItemFromData_result1, Holder_upvr[var12_upvw.toPascal(arg1:getCategoryFromClass(any_createItemFromData_result1:getClass()))])
		arg1:updateSelfInTrade()
		arg1._itemsInTrade[arg2] = any_createItemFromData_result1
	elseif any_addItemToTrade_result1 == "tooManyItems" then
		var5_upvw:createMessagePopup({
			title = "Oops!";
			message = "You can only add 50 items in one trade!";
			reOpen = "TradeFrame";
		})
	end
end
function any_new_result1.removeItemFromTrade(arg1, arg2) -- Line 109
	--[[ Upvalues[4]:
		[1]: var8_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: Holder_upvr (readonly)
	]]
	local any_removeItemFromTrade_result1, any_removeItemFromTrade_result2 = var8_upvw:removeItemFromTrade(arg2)
	if any_removeItemFromTrade_result1 == "success" then
		local any_createItemFromData_result1_5 = var11_upvw.itemUtils.createItemFromData(any_removeItemFromTrade_result2)
		arg1:updateItemFrame(arg2, any_createItemFromData_result1_5, Holder_upvr.InTrade, true)
		arg1:updateItemFrame(arg2, any_createItemFromData_result1_5, Holder_upvr[var12_upvw.toPascal(arg1:getCategoryFromClass(any_createItemFromData_result1_5:getClass()))])
		if any_createItemFromData_result1_5:getAmount() <= 0 then
			arg1:removeItemFrame(arg2)
			arg1:updateSelfInTrade()
		end
		arg1._itemsInTrade[arg2] = any_createItemFromData_result1_5
	end
end
local PolicyService_upvr = game:GetService("PolicyService")
function any_new_result1.canTradePaidItems(arg1) -- Line 128
	--[[ Upvalues[4]:
		[1]: PolicyService_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var12_upvw (read and write)
		[4]: var5_upvw (read and write)
	]]
	local pcall_result1, pcall_result2 = pcall(function() -- Line 129
		--[[ Upvalues[2]:
			[1]: PolicyService_upvr (copied, readonly)
			[2]: LocalPlayer_upvr (copied, readonly)
		]]
		return PolicyService_upvr:GetPolicyInfoForPlayerAsync(LocalPlayer_upvr)
	end)
	if not pcall_result1 then
		var12_upvw.print(`Kunde inte f\xE5 policy: {pcall_result2}`, warn)
	end
	if not pcall_result1 or not pcall_result2.IsPaidItemTradingAllowed then
		var5_upvw:createMessagePopup({
			message = "Sorry! Your country doesn't allow you to trade this.";
			reOpen = "TradeFrame";
		})
		return false
	end
	return true
end
function any_new_result1.canTradeItem(arg1, arg2) -- Line 147
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
		[3]: var5_upvw (read and write)
	]]
	local any_getItemFromId_result1_3 = var11_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2)
	if any_getItemFromId_result1_3:getClass() == "pet" and any_getItemFromId_result1_3:isPaid() and not arg1:canTradePaidItems() then return end
	if any_getItemFromId_result1_3:isUntradeable() or any_getItemFromId_result1_3:getClass() == "pet" and any_getItemFromId_result1_3:getLocked() then
		var5_upvw:createMessagePopup({
			title = "Oops!";
			message = "You cannot trade this item!";
			reOpen = "TradeFrame";
		})
		return
	end
	return true
end
local DisplaysShadow_upvr = TradeFrame_upvr:WaitForChild("DisplaysShadow")
function any_new_result1.toggleDisplays(arg1, arg2) -- Line 168
	--[[ Upvalues[2]:
		[1]: Displays_upvr (readonly)
		[2]: DisplaysShadow_upvr (readonly)
	]]
	Displays_upvr.Visible = arg2
	DisplaysShadow_upvr.Visible = arg2
end
local TradeTokens_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Top"):WaitForChild("TradeTokens")
function any_new_result1.toggleTradeTokensTop(arg1, arg2) -- Line 173
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: TradeTokens_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: var12_upvw (read and write)
	]]
	if _G.isTradingPlaza then
	else
		TradeTokens_upvr.Visible = arg2
		if not arg2 then return end
		local any_getTradeTokenItemId_result1 = arg1:getTradeTokenItemId()
		if not any_getTradeTokenItemId_result1 then
			TradeTokens_upvr.Amount.Text = 0
			return
		end
		TradeTokens_upvr.Amount.Text = var12_upvw.suffixes(var11_upvw.itemUtils.getItemFromId(var4_upvw.data, any_getTradeTokenItemId_result1):getAmount())
	end
end
function any_new_result1.toggleTradeTokensMenu(arg1, arg2) -- Line 197
	--[[ Upvalues[1]:
		[1]: TradeTokens_upvr_2 (readonly)
	]]
	TradeTokens_upvr_2.Visible = arg2
end
function any_new_result1.selectItem(arg1, arg2, arg3)
	-- CF ANALYSIS FAILED fix: arg3=true means item is in player inventory (add to trade), absent/false means already in trade (remove)
	if arg3 then
		arg1:addItemToTrade(arg2)
	else
		arg1:removeItemFromTrade(arg2)
	end
end
function any_new_result1.setFrameNotTradeable(arg1, arg2) -- Line 211
	local Main = arg2.Main
	local Color3_fromRGB_result1 = Color3.fromRGB(113, 113, 113)
	Main.BackgroundColor3 = Color3_fromRGB_result1
	Main.IconContainer.ImageLabel.ImageColor3 = Color3_fromRGB_result1
	arg2.LayoutOrder += 1000000
end
function any_new_result1.createItemFrame(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 223
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: var10_upvw (read and write)
	]]
	if arg4:FindFirstChild(arg2, true) then
		arg1:updateItemFrame(arg2, arg3, arg4, true)
		return
	end
	local var52 = arg1._itemsInTrade[arg2]
	local var53
	if var52 and not arg6 then
		arg3:setAmount(arg3:getAmount() - var52:getAmount())
	end
	if arg3:getClass() == "pet" then
		local tbl = {}
		tbl.name = arg2
		tbl.searchParams = true
		tbl.ignoreAnimateIconHover = true
		var53 = var5_upvw.uis.pet(arg3, tbl)
	else
		local tbl_2 = {}
		tbl_2.name = arg2
		tbl_2.searchParams = true
		tbl_2.ignoreAnimateIconHover = true
		var53 = var5_upvw.uis.item(arg3, tbl_2)
	end
	if arg3:getAmount() <= 0 then
		var53.Visible = false
		var53:SetAttribute("invisible", true)
	end
	if arg3:isUntradeable() or arg3:getClass() == "pet" and arg3:getLocked() then
		arg1:setFrameNotTradeable(var53)
	end
	var53.Parent = arg4
	if arg5 then
		var10_upvw.new(var53.Main):buttonUp(function() -- Line 261
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			arg1:selectItem(arg2)
		end)
	end
	local tbl_3 = {}
	tbl_3.itemId = arg2
	tbl_3.item = arg3
	tbl_3.unusable = true
	var5_upvw:createInfoHoverOnGuiStateChange(var53.Main.Click, tbl_3)
	return var53
end
function any_new_result1.removeItemFrame(arg1, arg2) -- Line 275
	--[[ Upvalues[1]:
		[1]: Main_upvr (readonly)
	]]
	local SOME_4 = Main_upvr:FindFirstChild(arg2, true)
	if not SOME_4 then
	else
		SOME_4:Destroy()
	end
end
function any_new_result1.updateItemFrame(arg1, arg2, arg3, arg4, arg5) -- Line 284
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: var11_upvw (read and write)
	]]
	local SOME = arg4:FindFirstChild(arg2, true)
	if not SOME then
	else
		-- arg5 = inTrade panel (show amount in trade); arg5 absent = inventory panel (show remaining)
		if not arg5 then
			-- inventory panel: show how many are NOT in trade
			local var61 = var11_upvw.itemUtils.getItemFromId(var4_upvw.data, arg2):getAmount() - arg3:getAmount()
			local invisible = var61 <= 0
			SOME:SetAttribute("invisible", invisible)
			SOME.Visible = true
			SOME.Main.Amount.Text = `x{var12_upvw.comma(var61)}`
		else
			-- inTrade panel: show the in-trade amount
			SOME.Main.Amount.Text = `x{var12_upvw.comma(arg3:getAmount())}`
		end
	end
end
function any_new_result1.createCategory(arg1, arg2) -- Line 311
	--[[ Upvalues[6]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: Holder_upvr (readonly)
		[5]: var11_upvw (read and write)
		[6]: var10_upvw (read and write)
	]]
	local data_2 = var4_upvw.data
	arg1:removeCategories()
	local var67 = var13_upvw[arg2]
	if not var67 then
		var12_upvw.print(`Kategori {arg2} finns inte!`, warn)
	else
		for _, var63 in var67.classes do
			local any_toPascal_result1_3 = var12_upvw.toPascal(arg2)
			local SOME_5 = Holder_upvr:FindFirstChild(any_toPascal_result1_3)
			SOME_5.Visible = true
			Holder_upvr:FindFirstChild(`Tag_{any_toPascal_result1_3}`).Visible = true
			if data_2.inventory[var63] then
				for var64_upvr, _ in data_2.inventory[var63] do
					local any_getItemFromId_result1 = var11_upvw.itemUtils.getItemFromId(data_2, var64_upvr)
					if not var67.only or table.find(var67.only, any_getItemFromId_result1:getName()) then
						var10_upvw.new(arg1:createItemFrame(var64_upvr, any_getItemFromId_result1, SOME_5).Main):buttonUp(function() -- Line 347
							--[[ Upvalues[2]:
								[1]: arg1 (readonly)
								[2]: var64_upvr (readonly)
							]]
							arg1:selectItem(var64_upvr, true)
						end)
					end
				end
			end
		end
	end
end
function any_new_result1.removeCategories(arg1, arg2) -- Line 354
	--[[ Upvalues[4]:
		[1]: var13_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: Holder_upvr_2 (readonly)
		[4]: Holder_upvr (readonly)
	]]
	for i_3, _ in var13_upvw do
		local any_toPascal_result1 = var12_upvw.toPascal(i_3)
		-- arg2=true means "other player's holder" (Holder_upvr_2), arg2=false/nil means self (Holder_upvr)
		local var85
		if arg2 then
			var85 = Holder_upvr_2
		else
			var85 = Holder_upvr
		end
		local SOME_3 = var85:FindFirstChild(any_toPascal_result1)
		if SOME_3 then
			SOME_3.Visible = false
			local tagEl = var85:FindFirstChild(`Tag_{any_toPascal_result1}`)
			if tagEl then tagEl.Visible = false end
			for _, v_5 in SOME_3:GetChildren() do
				if v_5:GetAttribute("isItemUI") then
					v_5:Destroy()
				end
			end
		end
	end
end
function any_new_result1.itemInTradeUpdated(arg1, arg2, arg3) -- Line 376
	--[[ Upvalues[3]:
		[1]: var11_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: Holder_upvr_2 (readonly)
	]]
	local any_createItemFromData_result1_3 = var11_upvw.itemUtils.createItemFromData(arg3)
	if any_createItemFromData_result1_3:getAmount() <= 0 then
		arg1:removeItemFrame(arg2)
	else
		arg1:createItemFrame(arg2, any_createItemFromData_result1_3, Holder_upvr_2[var12_upvw.toPascal(arg1:getCategoryFromClass(any_createItemFromData_result1_3:getClass()))])
	end
	arg1:updateOtherCategories()
end
function any_new_result1.updateOtherCategories(arg1) -- Line 390
	--[[ Upvalues[3]:
		[1]: var13_upvw (read and write)
		[2]: var12_upvw (read and write)
		[3]: Holder_upvr_2 (readonly)
	]]
	-- CF ANALYSIS FAILED fix: show/hide category holders for the other player's side based on what items they have in trade
	for i_3, _ in var13_upvw do
		local any_toPascal_result1 = var12_upvw.toPascal(i_3)
		local SOME_6 = Holder_upvr_2:FindFirstChild(any_toPascal_result1)
		if SOME_6 then
			local hasItems = false
			for _, v_cat in SOME_6:GetChildren() do
				if v_cat:GetAttribute("isItemUI") and not v_cat:GetAttribute("invisible") then
					hasItems = true
					break
				end
			end
			SOME_6.Visible = hasItems
			local tagEl = Holder_upvr_2:FindFirstChild(`Tag_{any_toPascal_result1}`)
			if tagEl then tagEl.Visible = hasItems end
		end
	end
end
function any_new_result1.updateSelfInTrade(arg1, arg2) -- Line 417
	--[[ Upvalues[1]:
		[1]: Holder_upvr (readonly)
	]]
	-- CF ANALYSIS FAILED fix: count visible items in InTrade, show/hide the InTrade holder accordingly
	local children_3 = Holder_upvr.InTrade:GetChildren()
	local hasItems = false
	for _, v_it in children_3 do
		if v_it:GetAttribute("isItemUI") and not v_it:GetAttribute("invisible") then
			hasItems = true
			break
		end
	end
	Holder_upvr.InTrade.Visible = hasItems
	local tagEl = Holder_upvr:FindFirstChild("Tag_InTrade")
	if tagEl then tagEl.Visible = hasItems end
end
local Icon_upvr = Player1_upvr.Icon.Icon
local Icon_upvr_2 = Player2_upvr.Icon.Icon
function any_new_result1.tradeAccepted(arg1, arg2) -- Line 435
	--[[ Upvalues[11]:
		[1]: Players_upvr (readonly)
		[2]: Player1_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
		[4]: Player2_upvr (readonly)
		[5]: Icon_upvr (readonly)
		[6]: var12_upvw (read and write)
		[7]: Icon_upvr_2 (readonly)
		[8]: Holder_upvr (readonly)
		[9]: var5_upvw (read and write)
		[10]: TextBox_upvr (readonly)
		[11]: var6_upvw (read and write)
	]]
	local SOME_2_upvr = Players_upvr:FindFirstChild(arg2)
	Player1_upvr.PlayerName.Text = LocalPlayer_upvr.DisplayName
	Player2_upvr.PlayerName.Text = SOME_2_upvr.Name
	task.spawn(function() -- Line 441
		--[[ Upvalues[5]:
			[1]: Icon_upvr (copied, readonly)
			[2]: var12_upvw (copied, read and write)
			[3]: LocalPlayer_upvr (copied, readonly)
			[4]: Icon_upvr_2 (copied, readonly)
			[5]: SOME_2_upvr (readonly)
		]]
		Icon_upvr.Image = var12_upvw.getUserHeadshot(LocalPlayer_upvr.UserId)
		Icon_upvr_2.Image = var12_upvw.getUserHeadshot(SOME_2_upvr.UserId)
	end)
	for _, v_6 in Holder_upvr.InTrade:GetChildren() do
		if v_6:GetAttribute("isItemUI") then
			v_6:Destroy()
		end
	end
	table.clear(arg1._itemsInTrade)
	var5_upvw:openFrame("TradeFrame", true)
	arg1:setReady(Player1_upvr, false)
	arg1:setReady(Player2_upvr, false)
	arg1:removeCategories(false)
	arg1:removeCategories(true)
	arg1:updateOtherCategories()
	arg1:updateSelfInTrade()
	arg1:createCategory("pets")
	arg1:setPositiveButton("ready")
	arg1:setNegativeButton("decline")
	arg1:setCurrentSearch("")
	arg1:toggleDisplays(true)
	arg1:toggleTradeTokensTop(true)
	arg1:toggleTradeTokensMenu(false)
	TextBox_upvr.Text = ""
	_G.isTrading = true
	var6_upvw:preloadSounds({"Trade Ready", "Trade Completed"})
end
function any_new_result1.cancelTrade(arg1, arg2) -- Line 488
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	_G.isTrading = false
	var5_upvw:closeAllFrames()
	var5_upvw:createMessagePopup({
		message = `Your trade with {arg2} was canceled!`;
	})
	arg1:toggleTradeTokensTop(false)
end
function any_new_result1.completedTrade(arg1, arg2) -- Line 501
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	_G.isTrading = false
	var5_upvw:closeAllFrames()
	var5_upvw:createMessagePopup({
		message = `You successfully traded with {arg2}! 🤩`;
		sound = "Trade Completed";
	})
	arg1:toggleTradeTokensTop(false)
end
function any_new_result1.createFramesForConfirmTrade(arg1, arg2, arg3) -- Line 515
	--[[ Upvalues[4]:
		[1]: Holder_upvr_2 (readonly)
		[2]: Holder_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: var12_upvw (read and write)
	]]
	-- Scoping fix: var110 was declared inside if-block but used outside — move it before the if
	local var110
	if arg3 and Holder_upvr_2 then
		var110 = Holder_upvr_2
	else
		var110 = Holder_upvr
	end
	for i_7, v_7 in arg2 do
		local any_createItemFromData_result1_4 = var11_upvw.itemUtils.createItemFromData(v_7)
		local any_toPascal_result1_2 = var12_upvw.toPascal(arg1:getCategoryFromClass(any_createItemFromData_result1_4:getClass()))
		local catEl = var110:FindFirstChild(any_toPascal_result1_2)
		if catEl then catEl.Visible = true end
		local tagEl = var110:FindFirstChild(`Tag_{any_toPascal_result1_2}`)
		if tagEl then tagEl.Visible = true end
		arg1:createItemFrame(i_7, any_createItemFromData_result1_4, var110[any_toPascal_result1_2], nil, true)
	end
end
function any_new_result1.confirmCountdown(arg1) -- Line 534
	--[[ Upvalues[1]:
		[1]: Main_upvr (readonly)
	]]
	task.spawn(function() -- Line 535
		--[[ Upvalues[2]:
			[1]: Main_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local Countdown = Main_upvr.Positive.Countdown
		for i_8 = 30, 1, -1 do
			if not Countdown.Visible then break end
			Countdown.Label.Text = `({i_8 / 10}s)`
			task.wait(0.1)
		end
		if not Countdown.Visible then
		else
			arg1:setPositiveButton("confirm")
		end
	end)
end
function any_new_result1.confirmStage(arg1, arg2, arg3) -- Line 555
	--[[ Upvalues[3]:
		[1]: Holder_upvr (readonly)
		[2]: Player1_upvr (readonly)
		[3]: Player2_upvr (readonly)
	]]
	for _, v_8 in Holder_upvr.InTrade:GetChildren() do
		if v_8:GetAttribute("isItemUI") then
			v_8:Destroy()
		end
	end
	arg1:setPositiveButton("countdown")
	arg1:setNegativeButton("unready")
	arg1:confirmCountdown()
	arg1:removeCategories(false)
	arg1:removeCategories(true)
	arg1:createFramesForConfirmTrade(arg2, false)
	arg1:createFramesForConfirmTrade(arg3, true)
	arg1:setReady(Player1_upvr, false)
	arg1:setReady(Player2_upvr, false)
	arg1:updateSelfInTrade()
	arg1:toggleDisplays(false)
end
function any_new_result1.confirmTrade(arg1, arg2) -- Line 580
	--[[ Upvalues[3]:
		[1]: Player1_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Player2_upvr (readonly)
	]]
	local var121 = Player1_upvr
	if arg2 ~= LocalPlayer_upvr.Name then
		var121 = Player2_upvr
	end
	arg1:setReady(var121, true, 1.3)
	if arg2 == LocalPlayer_upvr.Name then
		arg1:setPositiveButton("confirmed")
	end
end
function any_new_result1.unconfirmTrade(arg1) -- Line 593
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: Holder_upvr (readonly)
	]]
	arg1:removeCategories()
	arg1:createCategory("pets")
	arg1:setPositiveButton("ready")
	arg1:setNegativeButton("decline")
	for i_10, v_9 in arg1._itemsInTrade do
		arg1:createItemFrame(i_10, var11_upvw.itemUtils.createItemFromData(v_9), Holder_upvr.InTrade, true, true)
	end
	arg1:updateSelfInTrade()
	arg1:toggleDisplays(true)
end
local Countdown_2_upvr = ProcessTrade_upvr:WaitForChild("Countdown")
function any_new_result1.processTrade(arg1) -- Line 611
	--[[ Upvalues[3]:
		[1]: ProcessTrade_upvr (readonly)
		[2]: Countdown_2_upvr (readonly)
		[3]: TradeFrame_upvr (readonly)
	]]
	ProcessTrade_upvr.Visible = true
	repeat
		Countdown_2_upvr.Text = "Processing Trade"
		task.wait(0.3333333333333333)
		Countdown_2_upvr.Text ..= '.'
		task.wait(0.3333333333333333)
		Countdown_2_upvr.Text ..= '.'
		task.wait(0.3333333333333333)
		Countdown_2_upvr.Text ..= '.'
		task.wait(0.3333333333333333)
	until not TradeFrame_upvr.Visible
	ProcessTrade_upvr.Visible = false
end
function any_new_result1.setReady(arg1, arg2, arg3, arg4) -- Line 626
	--[[ Upvalues[1]:
		[1]: var6_upvw (read and write)
	]]
	-- Fix: arg3=true means mark ready (green stroke), false/nil means unready (dark stroke)
	if arg3 then
		arg2.Inventory.UIStroke.Color = Color3.fromRGB(34, 216, 14)
		var6_upvw:play("Trade Ready", {
			playbackSpeed = arg4 or 1.2;
			volume = 0.25;
		})
	else
		arg2.Inventory.UIStroke.Color = Color3.fromRGB(0, 32, 54)
	end
end
function any_new_result1.readyTrade(arg1, arg2, arg3) -- Line 639
	--[[ Upvalues[3]:
		[1]: Player1_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Player2_upvr (readonly)
	]]
	local var126 = Player1_upvr
	if arg2 ~= LocalPlayer_upvr.Name then
		var126 = Player2_upvr
	end
	arg1:setReady(var126, arg3)
	if not arg3 then
		arg1:setPositiveButton("ready")
	end
end
function any_new_result1.hideButtons(arg1, arg2) -- Line 652
	for _, v_10 in arg2:GetChildren() do
		if v_10:IsA("Frame") then
			v_10.Visible = false
		end
	end
end
function any_new_result1.setNegativeButton(arg1, arg2) -- Line 660
	--[[ Upvalues[2]:
		[1]: Main_upvr (readonly)
		[2]: var12_upvw (read and write)
	]]
	arg1:hideButtons(Main_upvr.Negative)
	Main_upvr.Negative[var12_upvw.toPascal(arg2)].Visible = true
end
function any_new_result1.setPositiveButton(arg1, arg2) -- Line 667
	--[[ Upvalues[2]:
		[1]: Main_upvr (readonly)
		[2]: var12_upvw (read and write)
	]]
	arg1:hideButtons(Main_upvr.Positive)
	Main_upvr.Positive[var12_upvw.toPascal(arg2)].Visible = true
end
function any_new_result1.canTradeTokens(arg1) -- Line 674
	--[[ Upvalues[2]:
		[1]: var7_upvw (read and write)
		[2]: var5_upvw (read and write)
	]]
	if var7_upvw:getFFlag("tradingTradeTokens") == false then
		var5_upvw:createMessagePopup({
			fFlagDisabled = true;
			reOpen = "TradeFrame";
		})
		return
	end
	return true
end
local List_upvr = Displays_upvr:WaitForChild("List")
local Positive_upvr = Main_upvr:WaitForChild("Positive")
local Negative_upvr = Main_upvr:WaitForChild("Negative")
function any_new_result1.buttons(arg1) -- Line 683
	--[[ Upvalues[11]:
		[1]: List_upvr (readonly)
		[2]: var10_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: Positive_upvr (readonly)
		[5]: var8_upvw (read and write)
		[6]: Main_upvr (readonly)
		[7]: Negative_upvr (readonly)
		[8]: TradeTokens_upvr_2 (readonly)
		[9]: TextBox_upvr (readonly)
		[10]: var11_upvw (read and write)
		[11]: Holder_upvr (readonly)
	]]
	for _, v_11_upvr in List_upvr:GetChildren() do
		if v_11_upvr:IsA("Frame") then
			var10_upvw.new(v_11_upvr):buttonUp(function() -- Line 687
				--[[ Upvalues[3]:
					[1]: v_11_upvr (readonly)
					[2]: arg1 (readonly)
					[3]: var12_upvw (copied, read and write)
				]]
				-- CF ANALYSIS FAILED fix: TradeTokens tab opens the tokens input menu; other tabs load a category
				if v_11_upvr.Name == "TradeTokens" then
					arg1:removeCategories()
					arg1:updateSelfInTrade(false)
					arg1:toggleTradeTokensMenu(true)
				else
					arg1:createCategory(var12_upvw.toCamel(v_11_upvr.Name))
					arg1:setCurrentSearch("")
					arg1:updateSelfInTrade()
					arg1:toggleTradeTokensMenu(false)
				end
			end)
		end
	end
	var10_upvw.new(Positive_upvr):buttonUp(function() -- Line 704
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: Positive_upvr (copied, readonly)
			[3]: var8_upvw (copied, read and write)
		]]
		if tick() - (arg1._positiveDebounce or 0) < 0.25 then
		else
			arg1._positiveDebounce = tick()
			arg1:toggleTradeTokensMenu(false)
			if Positive_upvr.Countdown.Visible or Positive_upvr.Confirmed.Visible then return end
			if Positive_upvr.Confirm.Visible then
				var8_upvw.confirmTrade:Fire()
				return
			end
			if Positive_upvr.Ready.Visible then
				var8_upvw.readyTrade:Fire()
				arg1:setPositiveButton("unready")
				return
			end
			var8_upvw.unreadyTrade:Fire()
			arg1:setPositiveButton("ready")
		end
	end)
	var10_upvw.new(Main_upvr.Negative):buttonUp(function() -- Line 727
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: Negative_upvr (copied, readonly)
			[3]: var8_upvw (copied, read and write)
		]]
		if tick() - (arg1._negativeDebounce or 0) < 0.25 then
		else
			arg1:toggleTradeTokensMenu(false)
			arg1._negativeDebounce = tick()
			if Negative_upvr.Decline.Visible then
				var8_upvw.cancelTrade:Fire()
				return
			end
			var8_upvw.unconfirmTrade:Fire()
		end
	end)
	var10_upvw.new(TradeTokens_upvr_2.Confirm):buttonUp(function() -- Line 744
		--[[ Upvalues[6]:
			[1]: arg1 (readonly)
			[2]: TextBox_upvr (copied, readonly)
			[3]: var8_upvw (copied, read and write)
			[4]: var11_upvw (copied, read and write)
			[5]: var12_upvw (copied, read and write)
			[6]: Holder_upvr (copied, readonly)
		]]
		arg1:toggleTradeTokensMenu()
		arg1:createCategory("pets")
		local any_getTradeTokenItemId_result1_3 = arg1:getTradeTokenItemId()
		if not any_getTradeTokenItemId_result1_3 then
		else
			local any_setTokensInTrade_result1, any_setTokensInTrade_result2 = var8_upvw:setTokensInTrade(math.floor(tonumber(TextBox_upvr.Text)))
			if any_setTokensInTrade_result1 == "success" then
				local any_createItemFromData_result1_2 = var11_upvw.itemUtils.createItemFromData(any_setTokensInTrade_result2)
				arg1:createItemFrame(any_getTradeTokenItemId_result1_3, any_createItemFromData_result1_2, Holder_upvr.InTrade, true)
				arg1:updateItemFrame(any_getTradeTokenItemId_result1_3, any_createItemFromData_result1_2, Holder_upvr[var12_upvw.toPascal(arg1:getCategoryFromClass(any_createItemFromData_result1_2:getClass()))])
				if any_createItemFromData_result1_2:getAmount() <= 0 then
					arg1:removeItemFrame(any_getTradeTokenItemId_result1_3)
				end
				arg1:updateSelfInTrade()
				arg1._itemsInTrade[any_getTradeTokenItemId_result1_3] = any_createItemFromData_result1_2
			end
		end
	end)
end
function any_new_result1.getTradeTokenItemId(arg1) -- Line 775
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var11_upvw (read and write)
	]]
	local data = var4_upvw.data
	if not data.inventory.exclusive then
	else
		for var149, var150 in data.inventory.exclusive do
			if var11_upvw.itemUtils.createItemFromData(var150):getName() == "tradeTokens" then
				return var149
			end
		end
	end
end
function any_new_result1.tradeTokensInput(arg1) -- Line 793
	--[[ Upvalues[3]:
		[1]: TextBox_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var11_upvw (read and write)
	]]
	TextBox_upvr.FocusLost:Connect(function() -- Line 794
		--[[ Upvalues[4]:
			[1]: var4_upvw (copied, read and write)
			[2]: TextBox_upvr (copied, readonly)
			[3]: arg1 (readonly)
			[4]: var11_upvw (copied, read and write)
		]]
		if not tonumber(TextBox_upvr.Text) then
			TextBox_upvr.Text = 0
		else
			local any_getTradeTokenItemId_result1_2 = arg1:getTradeTokenItemId()
			if not any_getTradeTokenItemId_result1_2 then
				TextBox_upvr.Text = 0
				return
			end
			local any_getItemFromId_result1_2 = var11_upvw.itemUtils.getItemFromId(var4_upvw.data, any_getTradeTokenItemId_result1_2)
			local floored = math.floor(tonumber(TextBox_upvr.Text))
			if any_getItemFromId_result1_2:getAmount() < floored then
				floored = any_getItemFromId_result1_2:getAmount()
			end
			TextBox_upvr.Text = floored
		end
	end)
end
function any_new_result1.setCurrentSearch(arg1, arg2) -- Line 820
	--[[ Upvalues[1]:
		[1]: TextBox_upvr_2 (readonly)
	]]
	TextBox_upvr_2.Text = arg2
end
local HttpService_upvr = game:GetService("HttpService")
function any_new_result1.showFramesOnSearch(arg1, arg2, arg3) -- Line 824
	--[[ Upvalues[1]:
		[1]: HttpService_upvr (readonly)
	]]
	for _, v_12 in arg3:GetDescendants() do
		if v_12:GetAttribute("isItemUI") then
			-- Fix: redundant `if not var180` wrapper removed; fix `for ... , nil` decompiler artifact
			local var180 = false
			local searchParams = v_12:GetAttribute("searchParams")
			if searchParams then
				for _, v_13 in HttpService_upvr:JSONDecode(searchParams) do
					if string.match(string.lower(v_13), string.lower(arg2)) then
						var180 = true
					end
				end
			end
			if var180 or arg2 == nil or arg2 == "" then
				v_12.Visible = true
			else
				v_12.Visible = false
			end
		end
	end
end
function any_new_result1.search(arg1) -- Line 850
	--[[ Upvalues[4]:
		[1]: TextBox_upvr_2 (readonly)
		[2]: var13_upvw (read and write)
		[3]: var12_upvw (read and write)
		[4]: Holder_upvr (readonly)
	]]
	TextBox_upvr_2:GetPropertyChangedSignal("Text"):Connect(function() -- Line 851
		--[[ Upvalues[5]:
			[1]: TextBox_upvr_2 (copied, readonly)
			[2]: var13_upvw (copied, read and write)
			[3]: var12_upvw (copied, read and write)
			[4]: Holder_upvr (copied, readonly)
			[5]: arg1 (readonly)
		]]
		local Text = TextBox_upvr_2.Text
		for i_15, _ in var13_upvw do
			arg1:showFramesOnSearch(Text, Holder_upvr:FindFirstChild(var12_upvw.toPascal(i_15)))
		end
	end)
end
function any_new_result1.Start(arg1) -- Line 863
	--[[ Upvalues[1]:
		[1]: var8_upvw (read and write)
	]]
	arg1:buttons()
	arg1:search()
	arg1:tradeTokensInput()
	var8_upvw.tradeAccepted:Connect(function(...) -- Line 868
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:tradeAccepted(...)
	end)
	var8_upvw.processTrade:Connect(function(...) -- Line 872
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:processTrade(...)
	end)
	var8_upvw.completedTrade:Connect(function(...) -- Line 875
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:completedTrade(...)
	end)
	var8_upvw.itemInTradeUpdated:Connect(function(...) -- Line 879
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:itemInTradeUpdated(...)
	end)
	var8_upvw.confirmStage:Connect(function(...) -- Line 883
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:confirmStage(...)
	end)
	var8_upvw.confirmTrade:Connect(function(...) -- Line 886
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:confirmTrade(...)
	end)
	var8_upvw.unconfirmTrade:Connect(function(...) -- Line 889
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:unconfirmTrade(...)
	end)
	var8_upvw.readyTrade:Connect(function(...) -- Line 893
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:readyTrade(...)
	end)
	var8_upvw.cancelTrade:Connect(function(...) -- Line 896
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:cancelTrade(...)
	end)
end
local var196_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 901
	--[[ Upvalues[12]:
		[1]: var8_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var196_upvw (read and write)
		[7]: var7_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: var11_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var12_upvw (read and write)
		[12]: var13_upvw (read and write)
	]]
	var8_upvw = Knit_upvr.GetService("TradeService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var196_upvw = Knit_upvr.GetController("ChatController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var13_upvw = require(script.Categories)
end
return any_new_result1