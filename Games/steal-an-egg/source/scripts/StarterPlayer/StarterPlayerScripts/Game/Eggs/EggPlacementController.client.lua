-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local EggPlacementRaycast = require(ReplicatedStorage.Library.Client.Eggs.EggPlacementRaycast)
local EggToolDisplay = require(ReplicatedStorage.Library.Client.Eggs.EggToolDisplay)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PlacedEggRenderer = require(ReplicatedStorage.Library.Client.Eggs.PlacedEggRenderer)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()

local function showInvalidPlacement() --[[ showInvalidPlacement | Line: 29 | Upvalues: Message (copy) ]]
	Message.Bottom({
		Message = "Cannot place egg here!",
		Time = 2,
		Color = Color3.fromRGB(255, 80, 80)
	})
end

local function tryPlace(p1) --[[ tryPlace | Line: 37 | Upvalues: EggToolDisplay (copy), Message (copy), PlotCmds (copy), EggPlacementRaycast (copy), LocalPlayer (copy), EggCmds (copy), PlacedEggRenderer (copy) ]]
	local v1 = EggToolDisplay.GetToolUid(p1)

	if v1 == nil then
		Message.Bottom({
			Message = "Cannot place egg here!",
			Time = 2,
			Color = Color3.fromRGB(255, 80, 80)
		})

		return
	end

	local v2 = PlotCmds.GetPlotData()

	if v2 == nil then
		Message.Bottom({
			Message = "Cannot place egg here!",
			Time = 2,
			Color = Color3.fromRGB(255, 80, 80)
		})

		return
	end

	local PetArea = v2.PetArea
	local v3 = EggPlacementRaycast.Raycast(PetArea, LocalPlayer.UserId)

	if v3 == nil or v3.Instance ~= PetArea then
		Message.Bottom({
			Message = "Cannot place egg here!",
			Time = 2,
			Color = Color3.fromRGB(255, 80, 80)
		})

		return
	end

	local v5, v6 = EggCmds.RequestPlaceEgg(v1, (v2.CenterPoint.CFrame:ToObjectSpace(CFrame.new(v3.Position))))

	if v5 then
		PlacedEggRenderer.Refresh()
	else
		Message.Bottom({
			Time = 2,
			Message = v6 or "Cannot place egg here!",
			Color = Color3.fromRGB(255, 80, 80)
		})
	end
end

local function bindTool(p1) --[[ bindTool | Line: 71 | Upvalues: v1 (copy), tryPlace (copy) ]]
	v1:Clean()
	v1:Connect(p1.Activated, function() --[[ Line: 73 | Upvalues: tryPlace (ref), p1 (copy) ]]
		tryPlace(p1)
	end)
end

local function refreshCharacter(p1) --[[ refreshCharacter | Line: 78 | Upvalues: v1 (copy), EggToolDisplay (copy), tryPlace (copy) ]]
	v1:Clean()

	for i, v in ipairs(p1:GetChildren()) do
		if v.ClassName == "Tool" and EggToolDisplay.IsEggTool(v) then
			v1:Clean()
			v1:Connect(v.Activated, function() --[[ Line: 73 | Upvalues: tryPlace (ref), v (copy) ]]
				tryPlace(v)
			end)

			return
		end
	end
end

local function bindCharacter(p1) --[[ bindCharacter | Line: 88 | Upvalues: refreshCharacter (copy), EggToolDisplay (copy), v1 (copy), tryPlace (copy) ]]
	refreshCharacter(p1)
	p1.ChildAdded:Connect(function(p1) --[[ Line: 90 | Upvalues: EggToolDisplay (ref), v1 (ref), tryPlace (ref) ]]
		if p1.ClassName ~= "Tool" or not EggToolDisplay.IsEggTool(p1) then
			return
		end

		v1:Clean()
		v1:Connect(p1.Activated, function() --[[ Line: 73 | Upvalues: tryPlace (ref), p1 (copy) ]]
			tryPlace(p1)
		end)
	end)
	p1.ChildRemoved:Connect(function(p1) --[[ Line: 95 | Upvalues: EggToolDisplay (ref), v1 (ref) ]]
		if p1.ClassName ~= "Tool" or not EggToolDisplay.IsEggTool(p1) then
			return
		end

		v1:Clean()
	end)
end

LocalPlayer.CharacterAdded:Connect(bindCharacter)
Network.Fired(Network.NET_MAP.Treadmills.ACTIVE_TREADMILL_EVENT):Connect(function(p1) --[[ Line: 107 | Upvalues: PlacedEggRenderer (copy) ]]
	PlacedEggRenderer.SetPromptsSuppressed(p1 ~= nil)
end)

if LocalPlayer.Character ~= nil then
	bindCharacter(LocalPlayer.Character)
end

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 114 | Upvalues: LocalPlayer (copy), refreshCharacter (copy) ]]
	local Character = LocalPlayer.Character

	if Character == nil then
		return
	end

	refreshCharacter(Character)
end)