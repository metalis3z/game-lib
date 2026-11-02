-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:47
-- Luau version 6, Types version 3
-- Time taken: 0.003773 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
local tbl_upvr = {
	down = 0.95;
	up = 1.05;
	enter = 1.05;
	leave = 1;
}
function module_upvr.new(arg1, arg2, arg3) -- Line 14
	local setmetatable_result1 = setmetatable({}, module_upvr)
	local params = arg3 or {}
	local click = arg2
	if not click then
		if arg1:IsA("TextButton") or arg1:IsA("ImageButton") then
			click = arg1
		else
			click = arg1:FindFirstChild("Click")
		end
	end
	setmetatable_result1._button = arg1
	setmetatable_result1._click = click
	setmetatable_result1._parameters = params
	setmetatable_result1._signals = {}
	setmetatable_result1._originalSize = {
		x = arg1.Size.X.Scale;
		y = arg1.Size.Y.Scale;
	}
	setmetatable_result1._disableButton = false
	if click then
		if not params.disableEnter then
			setmetatable_result1:buttonEnter(function() end)
		end
		if not params.disableLeave then
			setmetatable_result1:buttonLeave(function() end)
		end
		if not params.disableDown then
			setmetatable_result1:buttonDown(function() end)
		end
	end
	return setmetatable_result1
end
function module_upvr.tween(arg1, arg2, arg3) -- Line 55
	arg2:TweenSize(UDim2.new(arg3.x * arg3.multiplier, 0, arg3.y * arg3.multiplier, 0), "Out", "Quad", 0.15, true)
end
function module_upvr.allowedToClick(arg1) -- Line 59
	if not arg1._disableButton and not _G.isPurchasing then
		return true
	end
	return false
end
function module_upvr.getOriginalSizes(arg1) -- Line 68
	return arg1._originalSize.x, arg1._originalSize.y
end
function module_upvr.getButtonMultiplier(arg1, arg2) -- Line 72
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local var10 = arg1._parameters[arg2]
	if not var10 then
		var10 = tbl_upvr[arg2]
	end
	return var10
end
local SoundController_upvr = require(script.Parent.Parent.Controllers.SoundController)
function module_upvr.playButtonSound(arg1, arg2) -- Line 76
	--[[ Upvalues[1]:
		[1]: SoundController_upvr (readonly)
	]]
	if arg2 == "down" then
		SoundController_upvr:play("Click Down", {
			volume = 0.1;
		})
	elseif arg2 == "up" then
		SoundController_upvr:play("Click Up", {
			volume = 0.1;
		})
	end
end
function module_upvr.setToOriginalSize(arg1) -- Line 84
	local any_getOriginalSizes_result1, any_getOriginalSizes_result2_2 = arg1:getOriginalSizes()
	arg1:tween(arg1._button, {
		x = any_getOriginalSizes_result1;
		y = any_getOriginalSizes_result2_2;
		multiplier = arg1:getButtonMultiplier("leave");
	})
end
function module_upvr.buttonEventFired(arg1, arg2) -- Line 91
	local any_getOriginalSizes_result1_2, any_getOriginalSizes_result2 = arg1:getOriginalSizes()
	arg1:playButtonSound(arg2)
	if arg1._parameters.disableTween == nil then
		arg1:tween(arg1._button, {
			x = any_getOriginalSizes_result1_2;
			y = any_getOriginalSizes_result2;
			multiplier = arg1:getButtonMultiplier(arg2);
		})
	end
end
function module_upvr.buttonDown(arg1, arg2) -- Line 102
	if not arg1._click then return end
	arg1._signals._down = arg1._click.MouseButton1Down:Connect(function()
		if not arg1:allowedToClick() then return end
		arg1:buttonEventFired("down")
		task.spawn(arg2)
	end)
end
function module_upvr.buttonUp(arg1, arg2) -- Line 110
	if not arg1._click then return end
	arg1._signals._up = arg1._click.MouseButton1Up:Connect(function()
		if not arg1:allowedToClick() then return end
		arg1:buttonEventFired("up")
		task.spawn(arg2)
	end)
end
function module_upvr.buttonEnter(arg1, arg2) -- Line 118
	if not arg1._click then return end
	arg1._signals._enter = arg1._click.MouseEnter:Connect(function()
		if not arg1:allowedToClick() then return end
		arg1:buttonEventFired("enter")
		task.spawn(arg2)
	end)
end
function module_upvr.buttonLeave(arg1, arg2) -- Line 126
	if not arg1._click then return end
	arg1._signals._leave = arg1._click.MouseLeave:Connect(function()
		if not arg1:allowedToClick() then return end
		arg1:buttonEventFired("leave")
		task.spawn(arg2)
	end)
end
function module_upvr.remove(arg1) -- Line 134
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	for i, v in arg1._signals do
		v:Disconnect()
		arg1._signals[i] = nil
	end
	setmetatable(module_upvr, nil)
end
return module_upvr