-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:59
-- Luau version 6, Types version 3
-- Time taken: 0.004323 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "ClickController";
	_debounce = 0;
	_isAutoClicking = false;
	_lastClickType = 1;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local UserInputService_upvr = game:GetService("UserInputService")
local var9_upvw
local Auto_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Bottom"):WaitForChild("Auto")
local tbl_upvr = {Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch, Enum.KeyCode.ButtonX}
function any_CreateController_result1.setDebounce(arg1) -- Line 54
	arg1._debounce = tick()
end
function any_CreateController_result1.canClick(arg1) -- Line 57
	--[[ Upvalues[1]:
		[1]: var9_upvw (read and write)
	]]
	local var12
	if var9_upvw.clickCooldown > tick() - arg1._debounce then
		var12 = false
	else
		var12 = true
	end
	return var12
end
function any_CreateController_result1.setLastClickType(arg1, arg2) -- Line 61
	arg1._lastClickType = arg2
end
function any_CreateController_result1.canAutoClick(arg1) -- Line 65
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	local data = var4_upvw.data
	if data.upgrades.freeAutoClicker then
		return true
	end
	if data.passes.autoClicker then
		return true
	end
end
function any_CreateController_result1.autoClick(arg1) -- Line 76
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	task.spawn(function() -- Line 77
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var7_upvw (copied, read and write)
		]]
		repeat
			local var15
			var15 = 0.1
			if var4_upvw:getData().passes.autoClicker then
				var15 = 0.05
			end
			arg1:setLastClickType(1)
			arg1:setDebounce()
			var7_upvw.click:Fire()
			task.wait(var15)
		until not arg1._isAutoClicking
	end)
end
function any_CreateController_result1.setAutoClicker(arg1, arg2, arg3) -- Line 96
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: Auto_upvr (readonly)
		[5]: var5_upvw (read and write)
	]]
	if not arg1:canAutoClick() then
		var6_upvw:createMessagePopup({
			message = "You haven't unlocked Auto Clicker yet!";
		})
	else
		arg1._isAutoClicking = arg2
		arg1:update()
		var7_upvw.setIsAutoClicking:Fire(arg2)
		if Auto_upvr and Auto_upvr:FindFirstChild("Icon") then
			var6_upvw.fx.wiggle(Auto_upvr.Icon, {
				timeIn = 0.1;
				timeOut = 0.5;
			})
		end
		if arg2 then
			arg1:autoClick()
			if not arg3 then
				var5_upvw:play("Auto Clicker On", {
					volume = 0.2;
				})
			end
			var5_upvw:preloadSounds({"Auto Clicker Off"})
			return
		end
		var5_upvw:play("Auto Clicker Off", {
			volume = 0.1;
			playbackSpeed = 0.9;
		})
	end
end
function any_CreateController_result1.getAutoClicker(arg1) -- Line 134
	return arg1._isAutoClicking
end
local State_upvr = Auto_upvr:WaitForChild("State")
function any_CreateController_result1.update(arg1) -- Line 138
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: State_upvr (readonly)
	]]
	if not arg1:canAutoClick() then
	else
		State_upvr.Locked.Visible = false
		State_upvr.ON.Visible = arg1._isAutoClicking
		State_upvr.OFF.Visible = not arg1._isAutoClicking
	end
end
function any_CreateController_result1.click(arg1) -- Line 150
	--[[ Upvalues[3]:
		[1]: UserInputService_upvr (readonly)
		[2]: tbl_upvr (readonly)
		[3]: var7_upvw (read and write)
	]]
	UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 151
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: tbl_upvr (copied, readonly)
			[3]: var7_upvw (copied, read and write)
		]]
		if not arg1:canClick() then
		else
			if arg2 then return end
			local table_find_result1 = table.find(tbl_upvr, arg1_2.KeyCode)
			if not table_find_result1 then
				table_find_result1 = table.find(tbl_upvr, arg1_2.UserInputType)
			end
			if not table_find_result1 then return end
			arg1:setLastClickType(2)
			arg1:setDebounce()
			var7_upvw.click:Fire()
		end
	end)
end
local CurrentCamera_upvr = workspace.CurrentCamera
function any_CreateController_result1.clickPopup(arg1, arg2, arg3) -- Line 176
	--[[ Upvalues[3]:
		[1]: UserInputService_upvr (readonly)
		[2]: CurrentCamera_upvr (readonly)
		[3]: var6_upvw (read and write)
	]]
	local any_GetMouseLocation_result1 = UserInputService_upvr:GetMouseLocation()
	local udim2 = UDim2.fromScale(any_GetMouseLocation_result1.X / CurrentCamera_upvr.ViewportSize.X, any_GetMouseLocation_result1.Y / CurrentCamera_upvr.ViewportSize.Y)
	if arg1._lastClickType == 1 then
		udim2 = nil
	end
	var6_upvw:createPopup(arg2, arg3, udim2)
end
function any_CreateController_result1.isAutoClickingOnJoin(arg1) -- Line 187
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	if not var4_upvw.data.isAutoClicking then
	else
		arg1:setAutoClicker(true, true)
	end
end
function any_CreateController_result1.valuesChanged(arg1) -- Line 197
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"upgrades"}, function(arg1_3) -- Line 198
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"ancientShop"}, function(arg1_4) -- Line 201
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
	var4_upvw.replica:OnSet({"passes"}, function(arg1_5) -- Line 204
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 209
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	arg1:click()
	task.spawn(function() -- Line 212
		--[[ Upvalues[2]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
		]]
		repeat
			wait()
		until var4_upvw.data
		arg1:isAutoClickingOnJoin()
		arg1:update()
		arg1:valuesChanged()
	end)
	var7_upvw.click:Connect(function(...) -- Line 219
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:clickPopup(...)
	end)
end
local var35_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var37_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 224
	--[[ Upvalues[9]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var35_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var37_upvw (read and write)
		[9]: var9_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("ClickService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var6_upvw = Knit_upvr.GetController("UIController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var35_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var37_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Variables)
end
return any_CreateController_result1