-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Gears = require(ReplicatedStorage.Directory.Gears)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local ToolInput = Constants.NETWORK_MAP.ToolInput
local t = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.Touch] = true
}
local LocalPlayer = Players.LocalPlayer

local function isBatTool(p1) --[[ isBatTool | Line: 29 | Upvalues: Asserts (copy), Gears (copy) ]]
	local v1 = p1:GetAttribute("GearName")

	Asserts.optional.string(v1)

	if v1 == nil then
		return false
	end

	local v2 = Gears.Types.GearNameExists(v1)

	return if v2 then Gears.Directory[v1].BatControllerData ~= nil else v2
end

local function trySendActivation() --[[ trySendActivation | Line: 40 | Upvalues: LocalPlayer (copy), ToolGameplayGuard (copy), Asserts (copy), Gears (copy), Network (copy), ToolInput (copy) ]]
	local v1 = LocalPlayer

	if not v1 then
		return
	end

	local Character = v1.Character

	if not Character then
		return
	end

	local v2 = Character:FindFirstChildWhichIsA("Tool")

	if not v2 then
		return
	end

	if not ToolGameplayGuard.CanActivateLocal(v2) then
		return
	end

	local v3 = v2:GetAttribute("GearName")

	Asserts.optional.string(v3)

	local v4

	if v3 == nil then
		v4 = false
	else
		local v5 = Gears.Types.GearNameExists(v3)

		v4 = if v5 then Gears.Directory[v3].BatControllerData ~= nil else v5
	end

	if not v4 then
		Network.Fire(ToolInput.ACTIVATE, v2)
	end
end

UserInputService.InputBegan:Connect(function(p1) --[[ Line: 69 | Upvalues: t (copy), trySendActivation (copy) ]]
	if t[p1.UserInputType] then
		trySendActivation()
	end
end)