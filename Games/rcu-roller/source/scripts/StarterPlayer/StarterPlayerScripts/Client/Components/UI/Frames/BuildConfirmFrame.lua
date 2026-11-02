-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:59
-- Luau version 6, Types version 3
-- Time taken: 0.006852 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "BuildConfirmFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local BuildConfirmFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("BuildConfirmFrame")
function any_new_result1.hasPreviousBuilding(arg1) -- Line 47
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
	]]
	local var17 = var13_upvw[arg1.Instance:GetAttribute("buildingId")]
	if not var17.previousBuilding then
		return true
	end
	if not var4_upvw:getData().buildings[var17.previousBuilding] then return end
	return true
end
function any_new_result1.hasAllItems(arg1) -- Line 64
	--[[ Upvalues[3]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: var12_upvw (read and write)
	]]
	for _, v in var13_upvw[arg1.Instance:GetAttribute("buildingId")].required do
		local any_getItemFromName_result1_2 = var12_upvw.itemUtils.getItemFromName(var4_upvw:getData(), v:getName())
		if not any_getItemFromName_result1_2 then return end
		if any_getItemFromName_result1_2:getAmount() < v:getAmount() then return end
	end
	return true
end
function any_new_result1.isClanBuilding(arg1, arg2) -- Line 85
	--[[ Upvalues[1]:
		[1]: var14_upvw (read and write)
	]]
	return var14_upvw[arg2]
end
local Dark_upvr = BuildConfirmFrame_upvr:WaitForChild("Dark")
function any_new_result1.buildClanBuilding(arg1, arg2) -- Line 89
	--[[ Upvalues[6]:
		[1]: var15_upvw (read and write)
		[2]: BuildConfirmFrame_upvr (readonly)
		[3]: Dark_upvr (readonly)
		[4]: var10_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	local any_new_result1_2 = var15_upvw.new(BuildConfirmFrame_upvr)
	any_new_result1_2:run()
	Dark_upvr.Visible = true
	local any_build_result1 = var10_upvw:build(arg2)
	if any_build_result1 == "success" then
		var5_upvw:closeAllFrames()
		var6_upvw:animateBuild(arg2)
	elseif any_build_result1 == "notEnoughItems" then
		var5_upvw:createMessagePopup({
			message = "Your clan inventory does not have all required items!";
			reOpen = "BuildConfirmFrame";
		})
	elseif any_build_result1 == "debounce" then
		var5_upvw:createMessagePopup({
			message = "You're doing this too fast!";
			reOpen = "BuildConfirmFrame";
		})
	else
		var5_upvw:createMessagePopup({
			message = `Something went wrong, please try again! ({any_build_result1})`;
			reOpen = "BuildConfirmFrame";
		})
	end
	any_new_result1_2:remove()
	Dark_upvr.Visible = false
end
function any_new_result1.buildNormalBuilding(arg1, arg2) -- Line 119
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	if not arg1:hasPreviousBuilding() then
		var5_upvw:createMessagePopup({
			message = "You cannot build this yet!";
			reOpen = "BuildConfirmFrame";
		})
	else
		if not arg1:hasAllItems() then
			var5_upvw:createMessagePopup({
				message = "You do not have all required items!";
				reOpen = "BuildConfirmFrame";
			})
			return
		end
		if var9_upvw:build(arg2) == "success" then
			var5_upvw:closeAllFrames()
			var6_upvw:animateBuild(arg2)
		end
	end
end
function any_new_result1.buildButtonClicked(arg1) -- Line 143
	--[[ Upvalues[3]:
		[1]: var7_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var8_upvw (read and write)
	]]
	local buildingId_2 = arg1.Instance:GetAttribute("buildingId")
	if arg1:isClanBuilding(buildingId_2) then
		if var7_upvw:getFFlag("clansBuild") == false then
			var5_upvw:createMessagePopup({
				fFlagDisabled = true;
				reOpen = "ClansFrame";
			})
			return
		end
		if var8_upvw:getClanRank() == 3 then
			var5_upvw:createMessagePopup({
				message = "Only Officers+ are able to build!";
				reOpen = "BuildConfirmFrame";
			})
			return
		end
		return arg1:buildClanBuilding(buildingId_2)
	end
	if var7_upvw:getFFlag("buildings") == false then
		var5_upvw:createMessagePopup({
			fFlagDisabled = true;
		})
	else
		arg1:buildNormalBuilding(buildingId_2)
	end
end
function any_new_result1.buttons(arg1) -- Line 170
	--[[ Upvalues[2]:
		[1]: var11_upvw (read and write)
		[2]: BuildConfirmFrame_upvr (readonly)
	]]
	var11_upvw.new(BuildConfirmFrame_upvr.Button):buttonUp(function() -- Line 172
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:buildButtonClicked()
	end)
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_new_result1.input(arg1) -- Line 177
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: var5_upvw (read and write)
	]]
	UserInputService_upvr.InputEnded:Connect(function(arg1_2, arg2) -- Line 178
		--[[ Upvalues[3]:
			[1]: UserInputService_upvr (copied, readonly)
			[2]: var5_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		if UserInputService_upvr:GetFocusedTextBox() then
		else
			if arg1_2.KeyCode ~= Enum.KeyCode.ButtonA then return end
			if var5_upvw:getTimeSinceFrameOpened() < 0.5 then return end
			if var5_upvw:getCurrentFrameOpen() ~= "BuildConfirmFrame" then return end
			arg1:buildButtonClicked()
		end
	end)
end
local Holder_upvr = BuildConfirmFrame_upvr:WaitForChild("Holder")
function any_new_result1.update(arg1) -- Line 199
	--[[ Upvalues[10]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: BuildConfirmFrame_upvr (readonly)
		[5]: Holder_upvr (readonly)
		[6]: var6_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: var5_upvw (read and write)
		[10]: var12_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis fixed
	local any_getData_result1 = var4_upvw:getData()
	local buildingId = arg1.Instance:GetAttribute("buildingId")
	local var63 = var13_upvw[buildingId]
	if not var63 then
		var63 = var14_upvw[buildingId]
	end
	BuildConfirmFrame_upvr.Title.Text = var63.name
	for i_2, v_2 in Holder_upvr:GetChildren() do
		if v_2:IsA("Frame") then
			v_2:Destroy()
		end
	end
	-- Fix GOTO: if >4 required items use smaller cell size, else default 160
	if 4 < #var63.required then
		Holder_upvr.UIGridLayout.CellSize = UDim2.new(0, 130, 0, 130)
	else
		Holder_upvr.UIGridLayout.CellSize = UDim2.new(0, 160, 0, 160)
	end
	if 5 < #var63.required then
		BuildConfirmFrame_upvr.Message.Visible = false
		Holder_upvr.Position = UDim2.new(0.5, 0, 0.52, 0)
	else
		BuildConfirmFrame_upvr.Message.Visible = true
		Holder_upvr.Position = UDim2.new(0.5, 0, 0.576, 0)
	end
	BuildConfirmFrame_upvr.Button.Content.Label.Text = "Build"
	-- Fix scoping: fetch clan data before the items loop so it's accessible inside
	local any_getClanData_result1
	if var14_upvw[buildingId] then
		any_getClanData_result1 = var10_upvw:getClanData(any_getData_result1.clanId)
	end
	for _, v_3 in var63.required do
		local any_item_result1 = var5_upvw.uis.item(v_3)
		local Main = any_item_result1.Main
		local var71 = 0
		if var13_upvw[buildingId] then
			-- Normal building: get player's owned amount
			local any_getItemFromName_result1 = var12_upvw.itemUtils.getItemFromName(any_getData_result1, v_3:getName())
			if any_getItemFromName_result1 and any_getItemFromName_result1:getAmount() then
				var71 = any_getItemFromName_result1:getAmount()
			end
		elseif var14_upvw[buildingId] and any_getClanData_result1 and any_getClanData_result1.inventory then
			for _, v_4 in any_getClanData_result1.inventory do
				if v_4.nm == v_3:getName() then
					var71 = var12_upvw.itemUtils.createItemFromData(v_4):getAmount()
				end
			end
		end
		Main.Amount.Text = `{var71}/{v_3:getAmount()}`
		-- Fix color: green if has enough, red if not
		if v_3:getAmount() <= var71 then
			Main.Amount.TextColor3 = Color3.fromRGB(39, 255, 28)
		else
			Main.Amount.TextColor3 = Color3.fromRGB(255, 47, 47)
		end
		any_item_result1.Parent = Holder_upvr
		var5_upvw:createInfoHoverOnGuiStateChange(any_item_result1.Main.Click, {
			item = v_3;
			unusable = true;
		})
	end
end
function any_new_result1.opened(arg1) -- Line 270
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 274
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:input()
	arg1:opened()
	var5_upvw:listenToOpen("BuildConfirmFrame"):Connect(function() -- Line 279
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var75_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var77_upvw
function any_new_result1.Construct(arg1) -- Line 284
	--[[ Upvalues[16]:
		[1]: var9_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var75_upvw (read and write)
		[7]: var6_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var8_upvw (read and write)
		[10]: var11_upvw (read and write)
		[11]: var12_upvw (read and write)
		[12]: ReplicatedStorage_upvr (readonly)
		[13]: var77_upvw (read and write)
		[14]: var13_upvw (read and write)
		[15]: var14_upvw (read and write)
		[16]: var15_upvw (read and write)
	]]
	var9_upvw = Knit_upvr.GetService("BuildingService")
	var10_upvw = Knit_upvr.GetService("ClanService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var75_upvw = Knit_upvr.GetController("SoundController")
	var6_upvw = Knit_upvr.GetController("BuildingController")
	var7_upvw = Knit_upvr.GetController("FFlagController")
	var8_upvw = Knit_upvr.GetController("ClanController")
	var11_upvw = require(Knit_upvr.Modules.Button)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var77_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Buildings)
	var14_upvw = require(ReplicatedStorage_upvr.Shared.List.Clans.Buildings)
	var15_upvw = require(Knit_upvr.Modules.LoadingSpinner)
end
return any_new_result1