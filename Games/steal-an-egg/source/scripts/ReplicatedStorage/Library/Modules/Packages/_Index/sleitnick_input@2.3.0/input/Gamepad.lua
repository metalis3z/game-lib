-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local HapticService = game:GetService("HapticService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function ApplyDeadzone(p1, p2) --[[ ApplyDeadzone | Line: 13 ]]
	if math.abs(p1) < p2 then
		return 0
	end

	return (math.abs(p1) - p2) / (1 - p2) * math.sign(p1)
end

local function GetActiveGamepad() --[[ GetActiveGamepad | Line: 20 | Upvalues: UserInputService (copy) ]]
	local v1 = nil
	local v2 = UserInputService:GetNavigationGamepads()

	if #v2 > 1 then
		for i, v in ipairs(v2) do
			if v1 == nil or v.Value < v1.Value then
				v1 = v
			end
		end
	else
		for i, v in ipairs((UserInputService:GetConnectedGamepads())) do
			if v1 == nil or v.Value < v1.Value then
				v1 = v
			end
		end
	end

	if v1 and not UserInputService:GetGamepadConnected(v1) then
		v1 = nil
	end

	return v1
end

local function HeartbeatDelay(p1, p2) --[[ HeartbeatDelay | Line: 43 | Upvalues: RunService (copy) ]]
	local v1 = time()
	local v2 = nil

	v2 = RunService.Heartbeat:Connect(function() --[[ Line: 46 | Upvalues: v1 (copy), p1 (copy), v2 (ref), p2 (copy) ]]
		if not (p1 <= time() - v1) then
			return
		end

		v2:Disconnect()
		p2()
	end)

	return v2
end

local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 232 | Upvalues: t (copy), Trove (copy), Signal (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2._gamepadTrove = v2._trove:Construct(Trove)
	v2.ButtonDown = v2._trove:Construct(Signal)
	v2.ButtonUp = v2._trove:Construct(Signal)
	v2.Connected = v2._trove:Construct(Signal)
	v2.Disconnected = v2._trove:Construct(Signal)
	v2.GamepadChanged = v2._trove:Construct(Signal)
	v2.DefaultDeadzone = 0.05
	v2.SupportsVibration = false
	v2.State = {}
	v2:_setupGamepad(p1)
	v2:_setupMotors()

	return v2
end
function t._setupActiveGamepad(p1, p2) --[[ _setupActiveGamepad | Line: 249 | Upvalues: HapticService (copy), UserInputService (copy) ]]
	local _gamepad = p1._gamepad

	if p2 == _gamepad then
		return
	end

	p1._gamepadTrove:Clean()
	table.clear(p1.State)
	p1.SupportsVibration = if p2 then HapticService:IsVibrationSupported(p2) else false
	p1._gamepad = p2

	if not p2 then
		p1.Disconnected:Fire()
		p1.GamepadChanged:Fire(nil)

		return
	end

	for i, v in ipairs(UserInputService:GetGamepadState(p2)) do
		p1.State[v.KeyCode] = v
	end

	p1._gamepadTrove:Add(p1, "StopMotors")
	p1._gamepadTrove:Connect(UserInputService.InputBegan, function(p12, p22) --[[ Line: 274 | Upvalues: p2 (copy), p1 (copy) ]]
		if p12.UserInputType ~= p2 then
			return
		end

		p1.ButtonDown:Fire(p12.KeyCode, p22)
	end)
	p1._gamepadTrove:Connect(UserInputService.InputEnded, function(p12, p22) --[[ Line: 280 | Upvalues: p2 (copy), p1 (copy) ]]
		if p12.UserInputType ~= p2 then
			return
		end

		p1.ButtonUp:Fire(p12.KeyCode, p22)
	end)

	if _gamepad == nil then
		p1.Connected:Fire()
	end

	p1.GamepadChanged:Fire(p2)
end
function t._setupGamepad(p1, p2) --[[ _setupGamepad | Line: 292 | Upvalues: UserInputService (copy), GetActiveGamepad (copy) ]]
	if p2 then
		p1._trove:Connect(UserInputService.GamepadConnected, function(p12) --[[ Line: 296 | Upvalues: p2 (copy), p1 (copy) ]]
			if p12 ~= p2 then
				return
			end

			p1:_setupActiveGamepad(p2)
		end)
		p1._trove:Connect(UserInputService.GamepadDisconnected, function(p12) --[[ Line: 302 | Upvalues: p2 (copy), p1 (copy) ]]
			if p12 ~= p2 then
				return
			end

			p1:_setupActiveGamepad(nil)
		end)

		if UserInputService:GetGamepadConnected(p2) then
			p1:_setupActiveGamepad(p2)
		end
	else
		local function CheckToSetupActive() --[[ CheckToSetupActive | Line: 314 | Upvalues: GetActiveGamepad (ref), p1 (copy) ]]
			local v1 = GetActiveGamepad()

			if v1 == p1._gamepad then
				return
			end

			p1:_setupActiveGamepad(v1)
		end

		p1._trove:Connect(UserInputService.GamepadConnected, CheckToSetupActive)
		p1._trove:Connect(UserInputService.GamepadDisconnected, CheckToSetupActive)
		p1:_setupActiveGamepad((GetActiveGamepad()))
	end
end
function t._setupMotors(p1) --[[ _setupMotors | Line: 327 ]]
	p1._setMotorIds = {}

	for i, v in ipairs(Enum.VibrationMotor:GetEnumItems()) do
		p1._setMotorIds[v] = 0
	end
end
function t.GetThumbstick(p1, p2, p3) --[[ GetThumbstick | Line: 349 ]]
	local Position = p1.State[p2].Position
	local v1 = if p3 then p3 else p1.DefaultDeadzone
	local v2 = Vector2.new
	local X = Position.X
	local v3 = if math.abs(X) < v1 then 0 else (math.abs(X) - v1) / (1 - v1) * math.sign(X)
	local Y = Position.Y

	return v2(v3, if math.abs(Y) < v1 then 0 else (math.abs(Y) - v1) / (1 - v1) * math.sign(Y))
end
function t.GetTrigger(p1, p2, p3) --[[ GetTrigger | Line: 371 ]]
	local Z = p1.State[p2].Position.Z
	local v1 = if p3 then p3 else p1.DefaultDeadzone

	if math.abs(Z) < v1 then
		return 0
	end

	return (math.abs(Z) - v1) / (1 - v1) * math.sign(Z)
end
function t.IsButtonDown(p1, p2) --[[ IsButtonDown | Line: 389 | Upvalues: UserInputService (copy) ]]
	return UserInputService:IsGamepadButtonDown(p1._gamepad, p2)
end
function t.IsMotorSupported(p1, p2) --[[ IsMotorSupported | Line: 408 | Upvalues: HapticService (copy) ]]
	return HapticService:IsMotorSupported(p1._gamepad, p2)
end
function t.SetMotor(p1, p2, p3) --[[ SetMotor | Line: 422 | Upvalues: HapticService (copy) ]]
	local _setMotorIds = p1._setMotorIds

	_setMotorIds[p2] = _setMotorIds[p2] + 1
	HapticService:SetMotor(p1._gamepad, p2, p3)

	return p1._setMotorIds[p2]
end
function t.PulseMotor(p1, p2, p3, p4) --[[ PulseMotor | Line: 454 | Upvalues: RunService (copy) ]]
	local v1 = p1:SetMotor(p2, p3)

	local function f2() --[[ Line: 456 | Upvalues: p1 (copy), p2 (copy), v1 (copy) ]]
		if p1._setMotorIds[p2] == v1 then
			p1:StopMotor(p2)
		end
	end

	local v3 = time()
	local v4 = nil

	v4 = RunService.Heartbeat:Connect(function() --[[ Line: 46 | Upvalues: v3 (copy), p4 (copy), v4 (ref), f2 (copy) ]]
		if not (p4 <= time() - v3) then
			return
		end

		v4:Disconnect()
		f2()
	end)

	local v5 = v4

	p1._gamepadTrove:Add(v5)
end
function t.StopMotor(p1, p2) --[[ StopMotor | Line: 476 ]]
	p1:SetMotor(p2, 0)
end
function t.StopMotors(p1) --[[ StopMotors | Line: 490 ]]
	for i, v in ipairs(Enum.VibrationMotor:GetEnumItems()) do
		if p1:IsMotorSupported(v) then
			p1:StopMotor(v)
		end
	end
end
function t.IsConnected(p1) --[[ IsConnected | Line: 502 | Upvalues: UserInputService (copy) ]]
	if p1._gamepad then
		return UserInputService:GetGamepadConnected(p1._gamepad)
	end

	return false
end
function t.GetUserInputType(p1) --[[ GetUserInputType | Line: 511 ]]
	return p1._gamepad
end
function t.SetAutoSelectGui(p1, p2) --[[ SetAutoSelectGui | Line: 533 | Upvalues: GuiService (copy) ]]
	GuiService.AutoSelectGuiEnabled = p2
end
function t.IsAutoSelectGuiEnabled(p1) --[[ IsAutoSelectGuiEnabled | Line: 542 | Upvalues: GuiService (copy) ]]
	return GuiService.AutoSelectGuiEnabled
end
function t.Destroy(p1) --[[ Destroy | Line: 549 ]]
	p1._trove:Destroy()
end

return t