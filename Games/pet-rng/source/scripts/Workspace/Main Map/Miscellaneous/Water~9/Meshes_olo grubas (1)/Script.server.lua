local worlds = require(game:WaitForChild("ReplicatedStorage"):WaitForChild("DataModules"):WaitForChild("Worlds"))

local ServerScriptService = game:GetService("ServerScriptService")
local Engine = ServerScriptService:WaitForChild("Engine")
local Scripts = Engine:WaitForChild("Scripts")
local Data = Scripts:WaitForChild("Data")
local dataManager = require(Data:WaitForChild("DataManager"))

script.Parent.Touched:Connect(function(hit)
	local player = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
	if player then
		repeat wait() until dataManager.profiles[player]
		
		local spawnPoint = workspace["Main Map"].Spawn.Spawns.SpawnLocation
		
		local world = worlds[dataManager.profiles[player].Data["World"]]
		if world then
			spawnPoint = world.tp2[1].exit
		end
		
		hit.Parent:MoveTo(spawnPoint.Position)
	end
end)