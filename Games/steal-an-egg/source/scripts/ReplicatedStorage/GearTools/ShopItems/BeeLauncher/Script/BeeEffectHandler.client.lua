-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function createScreenEffect() --[[ createScreenEffect | Line: 8 ]]
	local Lighting = game:GetService("Lighting")
	local BeeEffect = Instance.new("ColorCorrectionEffect")

	BeeEffect.Name = "BeeEffect"
	BeeEffect.TintColor = Color3.fromRGB(255, 255, 0)
	BeeEffect.Saturation = 0.5
	BeeEffect.Parent = Lighting
	game:GetService("Debris"):AddItem(BeeEffect, 5)
end

local function createVFX() --[[ createVFX | Line: 20 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy) ]]
	local v1 = ReplicatedStorage.Assets.ToolEffects.BeeToolEffect:Clone()
	local Character = LocalPlayer.Character
	local v2 = if Character then Character:FindFirstChild("Head") else Character

	if v2 then
		v1.CFrame = v2.CFrame

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Parent = v1
		WeldConstraint.Part0 = v2
		WeldConstraint.Part1 = v1
		v1.Parent = v2
		game:GetService("Debris"):AddItem(v1, 5)
	end
end

local function invertMovement() --[[ invertMovement | Line: 39 | Upvalues: LocalPlayer (copy) ]]
	local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
	local v1 = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	local moveFunction = v1.moveFunction

	function v1.moveFunction(p1, p2, p3) --[[ Line: 47 | Upvalues: moveFunction (copy) ]]
		return moveFunction(p1, -p2, p3)
	end
	spawn(function() --[[ Line: 51 | Upvalues: v1 (copy), moveFunction (copy) ]]
		wait(5)
		v1.moveFunction = moveFunction
	end)
end

local function zoomCameraCloser() --[[ zoomCameraCloser | Line: 57 ]]
	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera then
		local FieldOfView = CurrentCamera.FieldOfView

		CurrentCamera.FieldOfView = FieldOfView / 2.4
		spawn(function() --[[ Line: 67 | Upvalues: CurrentCamera (copy), FieldOfView (copy) ]]
			wait(5)

			if not CurrentCamera then
				return
			end

			CurrentCamera.FieldOfView = FieldOfView
		end)
	end
end

createScreenEffect()
createVFX()
invertMovement()

local CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
	local FieldOfView = CurrentCamera.FieldOfView

	CurrentCamera.FieldOfView = FieldOfView / 2.4
	spawn(function() --[[ Line: 67 | Upvalues: CurrentCamera (copy), FieldOfView (copy) ]]
		wait(5)

		if not CurrentCamera then
			return
		end

		CurrentCamera.FieldOfView = FieldOfView
	end)
end