-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local LaserGunRemote = v1.LaserGunRemote
local v2 = LocalPlayer:GetMouse()

local function getRootPart(p1) --[[ getRootPart | Line: 20 ]]
	local PrimaryPart = p1.PrimaryPart

	if PrimaryPart then
		return PrimaryPart
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart
	end

	return nil
end

local function onActivated() --[[ onActivated | Line: 34 | Upvalues: ToolGameplayGuard (copy), v1 (copy), LocalPlayer (copy), v2 (copy), LaserGunRemote (copy) ]]
	if not ToolGameplayGuard.CanActivateLocal(v1) then
		return
	end

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	local PrimaryPart = Character.PrimaryPart
	local v12

	if PrimaryPart then
		v12 = PrimaryPart
	else
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		v12 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart else nil
	end

	if not v12 then
		return
	end

	local v22 = v2.Hit.Position - v12.Position
	local Magnitude = v22.Magnitude

	if Magnitude ~= 0 and Magnitude == Magnitude then
		LaserGunRemote:FireServer({
			direction = v22.Unit
		})
	end
end

v1.Activated:Connect(onActivated)