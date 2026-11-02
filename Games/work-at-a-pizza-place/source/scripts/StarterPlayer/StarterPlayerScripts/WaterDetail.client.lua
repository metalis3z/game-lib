local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	return false
end

local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local OceanWater = workspace.OceanWater
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")

local SavedSettings = Utility:SendData("GetSettings","PlayerChannel",10) or Utility:SendData("GetSettings","PlayerChannel",10) or {WaterEnabled = false}





function SetDetailedWater(enabled)
	if enabled then
		
		workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-500,-7,-500), Vector3int16.new(500,-2,500)),Enum.CellMaterial.Water,0,0)
		workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-9,-8,-197), Vector3int16.new(26,-2,58)),Enum.CellMaterial.Empty,0,0)
		workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-69,-8,-158), Vector3int16.new(69,-2,-63)),Enum.CellMaterial.Empty,0,0)
		
		OceanWater.Parent = game.ReplicatedStorage
		
		local sand = script.SeaFloorScript:clone()
		sand.Disabled = false
		sand.Parent = PlayerGui
		
		
	else
		
		PlayerGui.SeaFloorScript:Destroy()
		workspace.SeaFloor:Destroy()
		
		OceanWater.Parent = workspace
		
		workspace.Terrain:SetCells(Region3int16.new(Vector3int16.new(-500,-7,-500), Vector3int16.new(500,-2,500)),Enum.CellMaterial.Empty,0,0)
	end
end



UIEvents.ToggleButtonPressed.Event:connect(function(window,object,state)
	if window.Name == "Settings" and object.Parent.Name == "WaterEnabled" then
		SetDetailedWater(state)
	end
end)


if SavedSettings.WaterEnabled then
	SetDetailedWater(true)
end