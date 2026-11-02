local LocalPlayer = game.Players.LocalPlayer
LocalPlayer.CharacterAdded:Wait()
wait()

local Framework = shared.Framework
local Require = Framework.Require
local Settings = Require("Settings")
local Event = Require("Event")
local Input = Require("Input")
local UI = {}
local Physics = Require("Physics")
local Audio = Require("Audio")
local Camera = {}
spawn(function() Camera = Require("Camera") end)
local Animation = Require("Animation")
local Effects = Require("Effects")
local Char = Require("Charactor")
local Ragdoll = {}
local Bullet = {}
local Combat = Require("Combat")
local Replication = {}
local Protection = {}
local Environment = {}
local Render = {}
local CharAnims = {}

wait(1)

local MouseLockController = game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule").CameraModule.MouseLockController

if MouseLockController:FindFirstChild("BoundKeys") then
	MouseLockController.BoundKeys.Value = ""
end

LocalPlayer.CameraMinZoomDistance = 2

do
	local rs = game:GetService("RunService")
		local rsfuncs = {
		Camera.Step,
		Char.Step,
		Input.Step,
		Combat.Step,
		--Replication.Step,
	}
	local hbfuncs = {
		Camera.HStep,
	}
	rs.RenderStepped:Connect(function(dt)
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		for i, v in pairs(rsfuncs) do
			if v then
				v(dt)
			end
		end
		for i, v in pairs(hbfuncs) do
			if v then
				v(dt)
			end
		end
	end)
	
	--rs:BindToRenderStep("CustomCamera", Enum.RenderPriority.Camera.Value, Camera.Step)


	local stfuncs = {
		--Char.Stepped
	}
end

return nil