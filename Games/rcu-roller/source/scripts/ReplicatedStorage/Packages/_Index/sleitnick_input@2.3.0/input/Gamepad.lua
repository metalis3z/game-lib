-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:56
-- Luau version 6, Types version 3
-- Time taken: 0.005732 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local HapticService_upvr = game:GetService("HapticService")
local GuiService_upvr = game:GetService("GuiService")
local RunService_upvr = game:GetService("RunService")
local function _(arg1, arg2) -- Line 13, Named "ApplyDeadzone"
	if math.abs(arg1) < arg2 then
		return 0
	end
	return (math.abs(arg1) - arg2) / (1 - arg2) * math.sign(arg1)
end
local function GetActiveGamepad_upvr() -- Line 20, Named "GetActiveGamepad"
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local any_GetNavigationGamepads_result1 = UserInputService_upvr:GetNavigationGamepads()
	local var10
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [9] 8. Error Block 30 start (CF ANALYSIS FAILED)
	for _, v in ipairs(any_GetNavigationGamepads_result1) do
		if var10 == nil or v.Value < var10.Value then
			var10 = v
		end
	end
	if var10 and not UserInputService_upvr:GetGamepadConnected(var10) then
		var10 = nil
	end
	do
		return var10
	end
	-- KONSTANTERROR: [9] 8. Error Block 30 end (CF ANALYSIS FAILED)
end
local function _(arg1, arg2) -- Line 43, Named "HeartbeatDelay"
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	local time_result1_upvr_2 = time()
	local var16_upvw
	var16_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 46
		--[[ Upvalues[4]:
			[1]: time_result1_upvr_2 (readonly)
			[2]: arg1 (readonly)
			[3]: var16_upvw (read and write)
			[4]: arg2 (readonly)
		]]
		if arg1 <= time() - time_result1_upvr_2 then
			var16_upvw:Disconnect()
			arg2()
		end
	end)
	return var16_upvw
end
local module_upvr = {}
module_upvr.__index = module_upvr
local Trove_upvr = require(script.Parent.Parent.Trove)
local Signal_upvr = require(script.Parent.Parent.Signal)
function module_upvr.new(arg1) -- Line 232
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: Trove_upvr (readonly)
		[3]: Signal_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._trove = Trove_upvr.new()
	setmetatable_result1._gamepadTrove = setmetatable_result1._trove:Construct(Trove_upvr)
	setmetatable_result1.ButtonDown = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1.ButtonUp = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1.Connected = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1.Disconnected = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1.GamepadChanged = setmetatable_result1._trove:Construct(Signal_upvr)
	setmetatable_result1.DefaultDeadzone = 0.05
	setmetatable_result1.SupportsVibration = false
	setmetatable_result1.State = {}
	setmetatable_result1:_setupGamepad(arg1)
	setmetatable_result1:_setupMotors()
	return setmetatable_result1
end
function module_upvr._setupActiveGamepad(arg1, arg2) -- Line 249
	--[[ Upvalues[2]:
		[1]: HapticService_upvr (readonly)
		[2]: UserInputService_upvr (readonly)
	]]
	local _gamepad = arg1._gamepad
	if arg2 == _gamepad then
	else
		arg1._gamepadTrove:Clean()
		local clear = table.clear
		clear(arg1.State)
		if arg2 then
			clear = HapticService_upvr:IsVibrationSupported(arg2)
		else
			clear = false
		end
		arg1.SupportsVibration = clear
		arg1._gamepad = arg2
		if not arg2 then
			arg1.Disconnected:Fire()
			arg1.GamepadChanged:Fire(nil)
			return
		end
		for _, v_4 in ipairs(UserInputService_upvr:GetGamepadState(arg2)) do
			arg1.State[v_4.KeyCode] = v_4
		end
		arg1._gamepadTrove:Add(arg1, "StopMotors")
		arg1._gamepadTrove:Connect(UserInputService_upvr.InputBegan, function(arg1_2, arg2_2) -- Line 274
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: arg1 (readonly)
			]]
			if arg1_2.UserInputType == arg2 then
				arg1.ButtonDown:Fire(arg1_2.KeyCode, arg2_2)
			end
		end)
		arg1._gamepadTrove:Connect(UserInputService_upvr.InputEnded, function(arg1_3, arg2_3) -- Line 280
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: arg1 (readonly)
			]]
			if arg1_3.UserInputType == arg2 then
				arg1.ButtonUp:Fire(arg1_3.KeyCode, arg2_3)
			end
		end)
		if _gamepad == nil then
			arg1.Connected:Fire()
		end
		arg1.GamepadChanged:Fire(arg2)
	end
end
function module_upvr._setupGamepad(arg1, arg2) -- Line 292
	--[[ Upvalues[2]:
		[1]: UserInputService_upvr (readonly)
		[2]: GetActiveGamepad_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [29] 23. Error Block 3 start (CF ANALYSIS FAILED)
	arg1:_setupActiveGamepad(arg2)
	do
		return
	end
	-- KONSTANTERROR: [29] 23. Error Block 3 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [34] 27. Error Block 4 start (CF ANALYSIS FAILED)
	local function CheckToSetupActive() -- Line 314
		--[[ Upvalues[2]:
			[1]: GetActiveGamepad_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		local GetActiveGamepad_upvr_result1 = GetActiveGamepad_upvr()
		if GetActiveGamepad_upvr_result1 ~= arg1._gamepad then
			arg1:_setupActiveGamepad(GetActiveGamepad_upvr_result1)
		end
	end
	arg1._trove:Connect(UserInputService_upvr.GamepadConnected, CheckToSetupActive)
	arg1._trove:Connect(UserInputService_upvr.GamepadDisconnected, CheckToSetupActive)
	arg1:_setupActiveGamepad(GetActiveGamepad_upvr())
	-- KONSTANTERROR: [34] 27. Error Block 4 end (CF ANALYSIS FAILED)
end
function module_upvr._setupMotors(arg1) -- Line 327
	arg1._setMotorIds = {}
	for _, v_2 in ipairs(Enum.VibrationMotor:GetEnumItems()) do
		arg1._setMotorIds[v_2] = 0
	end
end
function module_upvr.GetThumbstick(arg1, arg2, arg3) -- Line 349
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Position = arg1.State[arg2].Position
	local var39 = arg3
	if not var39 then
		var39 = arg1.DefaultDeadzone
	end
	local X = Position.X
	if math.abs(X) < var39 then
	else
	end
	local Y = Position.Y
	if math.abs(Y) < var39 then
	else
	end
	return Vector2.new((math.abs(X) - var39) / (1 - var39) * math.sign(X), (math.abs(Y) - var39) / (1 - var39) * math.sign(Y))
end
function module_upvr.GetTrigger(arg1, arg2, arg3) -- Line 371
	local Z = arg1.State[arg2].Position.Z
	local var43 = arg3
	if not var43 then
		var43 = arg1.DefaultDeadzone
	end
	if math.abs(Z) < var43 then
		return 0
	end
	return (math.abs(Z) - var43) / (1 - var43) * math.sign(Z)
end
function module_upvr.IsButtonDown(arg1, arg2) -- Line 389
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	return UserInputService_upvr:IsGamepadButtonDown(arg1._gamepad, arg2)
end
function module_upvr.IsMotorSupported(arg1, arg2) -- Line 408
	--[[ Upvalues[1]:
		[1]: HapticService_upvr (readonly)
	]]
	return HapticService_upvr:IsMotorSupported(arg1._gamepad, arg2)
end
function module_upvr.SetMotor(arg1, arg2, arg3) -- Line 422
	--[[ Upvalues[1]:
		[1]: HapticService_upvr (readonly)
	]]
	local _setMotorIds = arg1._setMotorIds
	_setMotorIds[arg2] += 1
	HapticService_upvr:SetMotor(arg1._gamepad, arg2, arg3)
	return arg1._setMotorIds[arg2]
end
function module_upvr.PulseMotor(arg1, arg2, arg3, arg4) -- Line 454
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	local any_SetMotor_result1_upvr = arg1:SetMotor(arg2, arg3)
	local function var45_upvr() -- Line 456
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
			[3]: any_SetMotor_result1_upvr (readonly)
		]]
		if arg1._setMotorIds[arg2] ~= any_SetMotor_result1_upvr then
		else
			arg1:StopMotor(arg2)
		end
	end
	local time_result1_upvr = time()
	local var49_upvw
	var49_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 46
		--[[ Upvalues[4]:
			[1]: time_result1_upvr (readonly)
			[2]: arg4 (readonly)
			[3]: var49_upvw (read and write)
			[4]: var45_upvr (readonly)
		]]
		if arg4 <= time() - time_result1_upvr then
			var49_upvw:Disconnect()
			var45_upvr()
		end
	end)
	var45_upvr = arg1._gamepadTrove.Add
	var45_upvr(arg1._gamepadTrove, var49_upvw)
end
function module_upvr.StopMotor(arg1, arg2) -- Line 476
	arg1:SetMotor(arg2, 0)
end
function module_upvr.StopMotors(arg1) -- Line 490
	for _, v_3 in ipairs(Enum.VibrationMotor:GetEnumItems()) do
		if arg1:IsMotorSupported(v_3) then
			arg1:StopMotor(v_3)
		end
	end
end
function module_upvr.IsConnected(arg1) -- Line 502
	--[[ Upvalues[1]:
		[1]: UserInputService_upvr (readonly)
	]]
	if arg1._gamepad then
		return UserInputService_upvr:GetGamepadConnected(arg1._gamepad)
	end
	return false
end
function module_upvr.GetUserInputType(arg1) -- Line 511
	return arg1._gamepad
end
function module_upvr.SetAutoSelectGui(arg1, arg2) -- Line 533
	--[[ Upvalues[1]:
		[1]: GuiService_upvr (readonly)
	]]
	GuiService_upvr.AutoSelectGuiEnabled = arg2
end
function module_upvr.IsAutoSelectGuiEnabled(arg1) -- Line 542
	--[[ Upvalues[1]:
		[1]: GuiService_upvr (readonly)
	]]
	return GuiService_upvr.AutoSelectGuiEnabled
end
function module_upvr.Destroy(arg1) -- Line 549
	arg1._trove:Destroy()
end
return module_upvr