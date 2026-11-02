-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GameSettings = UserSettings().GameSettings
local t = {}

while not Players.LocalPlayer do
	wait()
end

local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()

LocalPlayer:WaitForChild("PlayerGui")

local v2 = nil
local v3 = true
local v4 = false
local v5 = false

t.OnShiftLockToggled = Instance.new("BindableEvent")

local function isShiftLockMode() --[[ isShiftLockMode | Line: 18 | Upvalues: LocalPlayer (copy), GameSettings (copy) ]]
	return LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable else false)
end

local v6 = if UserInputService.TouchEnabled then true else LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then false else true else false)

local function onShiftLockToggled() --[[ onShiftLockToggled | Line: 24 | Upvalues: v3 (ref), t (copy) ]]
	v3 = not v3
	t.OnShiftLockToggled:Fire()
end

function t.IsShiftLocked(p1) --[[ IsShiftLocked | Line: 31 | Upvalues: v6 (ref), v3 (ref) ]]
	return v6 and v3
end
function t.SetIsInFirstPerson(p1, p2) --[[ SetIsInFirstPerson | Line: 34 | Upvalues: v5 (ref) ]]
	v5 = p2
end

local function mouseLockSwitchFunc(p1, p2, p3) --[[ mouseLockSwitchFunc | Line: 37 | Upvalues: v6 (ref), v3 (ref), t (copy) ]]
	if not v6 then
		return
	end

	v3 = not v3
	t.OnShiftLockToggled:Fire()
end

local function disableShiftLock() --[[ disableShiftLock | Line: 42 | Upvalues: v6 (ref), v1 (copy), v2 (ref), v4 (ref), t (copy) ]]
	v6 = false
	v1.Icon = ""

	if not v2 then
		v4 = false
		t.OnShiftLockToggled:Fire()

		return
	end

	v2:disconnect()
	v2 = nil
	v4 = false
	t.OnShiftLockToggled:Fire()
end

local function f7(p1, p2) --[[ Line: 55 ]]
	if p2 then
		return
	end

	if p1.UserInputType ~= Enum.UserInputType.Keyboard or p1.KeyCode == Enum.KeyCode.LeftShift then
		return
	end

	local isRightShift = p1.KeyCode == Enum.KeyCode.RightShift
end

local function enableShiftLock() --[[ enableShiftLock | Line: 62 | Upvalues: v6 (ref), LocalPlayer (copy), GameSettings (copy), v3 (ref), t (copy), v4 (ref), v2 (ref), UserInputService (copy), f7 (copy) ]]
	v6 = LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable else false)

	if not v6 then
		return
	end

	if v3 then
		t.OnShiftLockToggled:Fire()
	end

	if v4 then
		return
	end

	v2 = UserInputService.InputBegan:connect(f7)
	v4 = true
end

GameSettings.Changed:connect(function(p1) --[[ Line: 77 | Upvalues: GameSettings (copy), v6 (ref), LocalPlayer (copy), v3 (ref), t (copy), v4 (ref), v2 (ref), UserInputService (copy), f7 (copy), v1 (copy) ]]
	if p1 == "ControlMode" then
		if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
			v6 = LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable else false)

			if not v6 then
				return
			end

			if v3 then
				t.OnShiftLockToggled:Fire()
			end

			if not v4 then
				v2 = UserInputService.InputBegan:connect(f7)
				v4 = true
			end
		else
			v6 = false
			v1.Icon = ""

			if not v2 then
				v4 = false
				t.OnShiftLockToggled:Fire()

				return
			end

			v2:disconnect()
			v2 = nil
			v4 = false
			t.OnShiftLockToggled:Fire()
		end
	else
		if p1 ~= "ComputerMovementMode" then
			return
		end

		if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
			v6 = false
			v1.Icon = ""

			if not v2 then
				v4 = false
				t.OnShiftLockToggled:Fire()

				return
			end

			v2:disconnect()
			v2 = nil
			v4 = false
			t.OnShiftLockToggled:Fire()

			return
		end

		v6 = LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable else false)

		if not v6 then
			return
		end

		if v3 then
			t.OnShiftLockToggled:Fire()
		end

		if v4 then
			return
		end

		v2 = UserInputService.InputBegan:connect(f7)
		v4 = true
	end
end)
LocalPlayer.Changed:connect(function(p1) --[[ Line: 92 | Upvalues: LocalPlayer (copy), v6 (ref), GameSettings (copy), v3 (ref), t (copy), v4 (ref), v2 (ref), UserInputService (copy), f7 (copy), v1 (copy) ]]
	if p1 == "DevEnableMouseLock" then
		if LocalPlayer.DevEnableMouseLock then
			v6 = LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable else false)

			if not v6 then
				return
			end

			if v3 then
				t.OnShiftLockToggled:Fire()
			end

			if not v4 then
				v2 = UserInputService.InputBegan:connect(f7)
				v4 = true
			end
		else
			v6 = false
			v1.Icon = ""

			if not v2 then
				v4 = false
				t.OnShiftLockToggled:Fire()

				return
			end

			v2:disconnect()
			v2 = nil
			v4 = false
			t.OnShiftLockToggled:Fire()
		end
	else
		if p1 ~= "DevComputerMovementMode" then
			return
		end

		if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
			v6 = false
			v1.Icon = ""

			if not v2 then
				v4 = false
				t.OnShiftLockToggled:Fire()

				return
			end

			v2:disconnect()
			v2 = nil
			v4 = false
			t.OnShiftLockToggled:Fire()

			return
		end

		v6 = LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable else false)

		if not v6 then
			return
		end

		if v3 then
			t.OnShiftLockToggled:Fire()
		end

		if v4 then
			return
		end

		v2 = UserInputService.InputBegan:connect(f7)
		v4 = true
	end
end)
LocalPlayer.CharacterAdded:connect(function(p1) --[[ Line: 107 | Upvalues: UserInputService (copy) ]]
	if UserInputService.TouchEnabled then
		return
	end

	print("enabled")
end)

if not UserInputService.TouchEnabled then
	print("enabled")

	if LocalPlayer.DevEnableMouseLock and (if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and (LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) then if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then false else true else false) then
		_ = UserInputService.InputBegan:connect(f7)
		v4 = true
	end
end

v6 = LocalPlayer.DevEnableMouseLock

if v6 then
	v6 = false

	if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
		v6 = false

		if LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove then
			v6 = false

			if GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove then
				v6 = if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then false else true
			end
		end
	end
end

if v6 then
	if v3 then
		t.OnShiftLockToggled:Fire()
	end

	if not v4 then
		_ = UserInputService.InputBegan:connect(f7)
		v4 = true
	end
end

return t