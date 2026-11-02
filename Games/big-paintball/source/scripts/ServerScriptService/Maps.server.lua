local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while (not _L.Loaded) do
	game:GetService("RunService").Heartbeat:Wait();
end;
local CurrentMap = game.Workspace.__VARIABLES.MapName.Value
local map = game.ServerStorage.__MAPS:WaitForChild(CurrentMap).__MAP
local debrismap = game.Workspace:WaitForChild("__DEBRIS")
local LIGHTMAP = game.Lighting
local foldermap = game.ServerStorage.__MAPS:WaitForChild(CurrentMap)
	local workspace = game.Workspace
local lighting = game.Lighting
local MapModule = _L.Directory.Maps[CurrentMap]
	
game.Workspace.__VARIABLES.RoundType.Value = MapModule.Type
print(MapModule.Type)
print(MapModule.Display)
print(MapModule.Disabled)
	
	-- DELETING ALREADY EXISTING STUFF
-- THIS SCRIPT IS DUMB AS FUCK Y'ALL ARE RETARDED - Aimee

	--[[if workspace:FindFirstChild("__DEBRIS") then
		workspace.__DEBRIS:Destroy()
	else
		_L.Print("There's no debris in workspace! Continuing.")
	end]]
	
--[[	if lighting:FindFirstChild("Atmosphere") then
		lighting.Atmosphere:Destroy()
		lighting.Default:Destroy()
		lighting.ColorCorrection:Destroy()
		lighting.CreditsColorCorrection:Destroy()
		lighting.DepthOfField:Destroy()
	end]]

	-- pairing the stuff out to workspace
	
	--[[for i, v in pairs(foldermap:GetChildren()) do
		map.Parent = workspace
		debrismap.Parent = workspace
	end
	
	for i, v in pairs(LIGHTMAP:GetChildren()) do
		v.Parent = lighting
	end

	_L.Print("Successfully added map!")]]

