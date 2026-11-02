-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local v1 = script.Parent
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local Traps = Constants.NETWORK_MAP.Traps
local v2 = 0

local function onActivated() --[[ onActivated | Line: 16 | Upvalues: ToolGameplayGuard (copy), v1 (copy), v2 (ref), LocalPlayer (copy), Network (copy), Traps (copy) ]]
	if not ToolGameplayGuard.CanActivateLocal(v1) then
		return
	end

	local v12 = tick()

	if v12 - v2 < 1 then
		return
	end

	if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
		return
	end

	v2 = v12

	local Character = LocalPlayer.Character
	local PrimaryPart = Character.PrimaryPart
	local LookVector = PrimaryPart.CFrame.LookVector
	local v22 = PrimaryPart.Position + LookVector * 4
	local v3 = RaycastParams.new()

	v3.FilterType = Enum.RaycastFilterType.Exclude
	v3.FilterDescendantsInstances = { Character }

	if workspace:Raycast(PrimaryPart.Position, LookVector * 4, v3) then
		return
	end

	local v6 = workspace:Raycast(Vector3.new(v22.X, v22.Y + 5, v22.Z), Vector3.new(0, -100, 0), v3)
	local v7 = if v6 then v6.Position else v22
	local v8 = v1:GetAttribute("GearName")

	if typeof(v8) ~= "string" then
		v8 = v1.Name
	end

	Network.Fire(Traps.REQUEST_PLACE, v8, v7)
end

v1.Activated:Connect(onActivated)