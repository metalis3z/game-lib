local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataHandler = require(game.ServerScriptService.DataService.DataHandler)
local Config = require(ReplicatedStorage:WaitForChild("Config"))

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		local data = DataHandler.Get(player)
		
		if data then
			task.wait(0.1)
			if data.CustomWalkSpeed and data.CustomWalkSpeed > 0 then
				humanoid.WalkSpeed = data.CustomWalkSpeed
			else
				humanoid.WalkSpeed = Config.CalculateMaxSpeed(data.Level, data.Multiplier)
			end
		end
		
		humanoid.Died:Connect(function()
		end)
	end)
end)

print("MainServer initialized")
