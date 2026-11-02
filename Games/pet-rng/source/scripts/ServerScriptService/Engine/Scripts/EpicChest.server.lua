local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Modules = RSEngine:WaitForChild("Modules")
local ChestModule = require(Modules.ChestModule)

local groupId = 33985757

local Chest = workspace["Main Map"].Interactions["Epic Chest"]

Chest.Hitbox.Touched:Connect(function(hit)
	local player = Players:GetPlayerFromCharacter(hit.Parent)
	
	if player then
		if player:IsInGroup(groupId) then
			ChestModule.ClaimChest(player)
		end
	end
end)