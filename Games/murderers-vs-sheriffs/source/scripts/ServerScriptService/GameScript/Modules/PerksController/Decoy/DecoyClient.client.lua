local Perk = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PerkService = require(game.ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("PerkService"));

local function onPerkActivated()
	Perk.Activate:FireServer()
end

PerkService.PerkActivated.Event:Connect(onPerkActivated)
