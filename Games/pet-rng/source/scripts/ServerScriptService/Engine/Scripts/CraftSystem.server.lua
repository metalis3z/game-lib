local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Modules = RSEngine:WaitForChild("Modules")
local CraftSystem = require(Modules.CraftSystem)

game.Players.PlayerAdded:Connect(function(player)
	CraftSystem.Load(player)
end)