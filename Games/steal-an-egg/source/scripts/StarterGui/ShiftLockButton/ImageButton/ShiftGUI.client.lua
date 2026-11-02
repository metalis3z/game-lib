-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Player = require(ReplicatedStorage.Library.Player)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = CFrame.new(-1.7, 0, 0)
local v2 = CFrame.new(1.7, 0, 0)
local v3 = Enum.RenderPriority.Camera.Value + 1
local t = {
	Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
	On = "rbxasset://textures/ui/mouseLock_on@2x.png"
}
local LocalPlayer = Players.LocalPlayer
local v4 = script.Parent

assert(v4:IsA("ImageButton"), "StarterGui.ShiftLockButton.ImageButton must be an ImageButton")

local v6 = v4.Parent

assert(v6:IsA("ScreenGui"), "StarterGui.ShiftLockButton must be a ScreenGui")

local Lock = v6.Lock

assert(Lock:IsA("ImageLabel"), "StarterGui.ShiftLockButton.Lock must be an ImageLabel")

local v9 = false
local v10 = Log.new()

local function updateImage(p1) --[[ updateImage | Line: 41 | Upvalues: v4 (copy), Lock (copy) ]]
	v4.Image = if p1 then "rbxasset://textures/ui/mouseLock_on@2x.png" else "rbxasset://textures/ui/mouseLock_off@2x.png"
	Lock.Visible = p1
end

local function getCurrentCamera() --[[ getCurrentCamera | Line: 46 | Upvalues: Workspace (copy) ]]
	local CurrentCamera = Workspace.CurrentCamera

	assert(CurrentCamera ~= nil, "Mobile shift lock requires Workspace.CurrentCamera")

	return CurrentCamera
end

local function updateShiftLock() --[[ updateShiftLock | Line: 52 | Upvalues: Variables (copy), Workspace (copy), Player (copy), LocalPlayer (copy), v4 (copy), t (copy), Lock (copy), v2 (copy) ]]
	if Variables.Locks.DisableShiftLock:IsLocked() then
		return
	end

	local CurrentCamera = Workspace.CurrentCamera

	assert(CurrentCamera ~= nil, "Mobile shift lock requires Workspace.CurrentCamera")

	if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
		local v22 = Player.HumanoidRootPart(LocalPlayer)

		Player.Humanoid(LocalPlayer).AutoRotate = false
		v4.Image = t.On
		Lock.Visible = true

		local LookVector = CurrentCamera.CFrame.LookVector

		v22.CFrame = CFrame.new(v22.Position, (Vector3.new(LookVector.X * 900000, v22.Position.Y, LookVector.Z * 900000)))
		CurrentCamera.CFrame = CurrentCamera.CFrame * v2
	end
end

local function disableShiftLock() --[[ disableShiftLock | Line: 75 | Upvalues: v9 (ref), RunService (copy), Player (copy), LocalPlayer (copy), v4 (copy), t (copy), Lock (copy), Workspace (copy), v1 (copy) ]]
	if not v9 then
		return
	end

	v9 = false
	RunService:UnbindFromRenderStep("MobileShiftLock")

	local v12 = Player.Optional.Humanoid(LocalPlayer)

	if v12 ~= nil then
		v12.AutoRotate = true
	end

	v4.Image = t.Off
	Lock.Visible = false

	local CurrentCamera = Workspace.CurrentCamera

	assert(CurrentCamera ~= nil, "Mobile shift lock requires Workspace.CurrentCamera")
	CurrentCamera.CFrame = CurrentCamera.CFrame * v1
end

local function enableShiftLock() --[[ enableShiftLock | Line: 90 | Upvalues: v9 (ref), Variables (copy), RunService (copy), v3 (copy), updateShiftLock (copy) ]]
	if not (v9 or Variables.Locks.DisableShiftLock:IsLocked()) then
		v9 = true
		RunService:BindToRenderStep("MobileShiftLock", v3, updateShiftLock)
	end
end

local function updateAvailability() --[[ updateAvailability | Line: 99 | Upvalues: Variables (copy), v9 (ref), RunService (copy), Player (copy), LocalPlayer (copy), v4 (copy), t (copy), Lock (copy), Workspace (copy), v1 (copy), v10 (copy), UserInputService (copy) ]]
	local v12 = Variables.Locks.DisableShiftLock:IsLocked()

	if v12 then
		if v9 then
			v9 = false
			RunService:UnbindFromRenderStep("MobileShiftLock")

			local v2 = Player.Optional.Humanoid(LocalPlayer)

			if v2 ~= nil then
				v2.AutoRotate = true
			end

			v4.Image = t.Off
			Lock.Visible = false

			local CurrentCamera = Workspace.CurrentCamera

			assert(if CurrentCamera == nil then false else true, "Mobile shift lock requires Workspace.CurrentCamera")
			CurrentCamera.CFrame = CurrentCamera.CFrame * v1
		end

		v10:AtDebug():Log("Mobile shift lock suppressed by a gameplay lock")
	end

	v4.Visible = UserInputService.TouchEnabled and not v12
end

local function toggleShiftLock() --[[ toggleShiftLock | Line: 108 | Upvalues: v9 (ref), RunService (copy), Player (copy), LocalPlayer (copy), v4 (copy), t (copy), Lock (copy), Workspace (copy), v1 (copy), Variables (copy), v3 (copy), updateShiftLock (copy) ]]
	if v9 then
		if not v9 then
			return
		end

		v9 = false
		RunService:UnbindFromRenderStep("MobileShiftLock")

		local v12 = Player.Optional.Humanoid(LocalPlayer)

		if v12 ~= nil then
			v12.AutoRotate = true
		end

		v4.Image = t.Off
		Lock.Visible = false

		local CurrentCamera = Workspace.CurrentCamera

		assert(CurrentCamera ~= nil, "Mobile shift lock requires Workspace.CurrentCamera")
		CurrentCamera.CFrame = CurrentCamera.CFrame * v1
	else
		if v9 then
			return
		end

		if Variables.Locks.DisableShiftLock:IsLocked() then
			return
		end

		v9 = true
		RunService:BindToRenderStep("MobileShiftLock", v3, updateShiftLock)
	end
end

v4.Image = t.Off
Lock.Visible = false

local v11 = Variables.Locks.DisableShiftLock:IsLocked()

if v11 then
	if v9 then
		v9 = false
		RunService:UnbindFromRenderStep("MobileShiftLock")

		local v12 = Player.Optional.Humanoid(LocalPlayer)

		if v12 ~= nil then
			v12.AutoRotate = true
		end

		v4.Image = t.Off
		Lock.Visible = false

		local CurrentCamera = Workspace.CurrentCamera

		assert(if CurrentCamera == nil then false else true, "Mobile shift lock requires Workspace.CurrentCamera")
		CurrentCamera.CFrame = CurrentCamera.CFrame * v1
	end

	v10:AtDebug():Log("Mobile shift lock suppressed by a gameplay lock")
end

v4.Visible = UserInputService.TouchEnabled and not v11
Variables.Locks.DisableShiftLock.Modified:Connect(updateAvailability)
v4.Activated:Connect(toggleShiftLock)