local Luck = require(game.ReplicatedStorage.Engine.Modules.Luck)

local debounce = false

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and debounce == false then
		debounce = true
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			Luck.GiveLuck(player, "Luck Potion II")
			hit.Parent:MoveTo(workspace["Main Map"].Spawn.Spawns.SpawnLocation.Position)
		end
		
		wait(1)
		debounce = false
	end
end)