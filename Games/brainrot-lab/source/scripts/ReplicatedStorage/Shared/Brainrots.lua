--!strict
-- LOCATION: ReplicatedStorage/Shared/Brainrots
-- Wraps BrainrotData into a dictionary format keyed by brainrot name
-- This format is expected by the AdminPanel client script

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BrainrotData = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("BrainrotData"))

local Brainrots = {}

-- Build dictionary from BrainrotData.Items
for _, item in ipairs(BrainrotData.Items) do
	Brainrots[item.Name] = {
		Name = item.Name,
		Rarity = item.Rarity,
		Income = item.Income,
		Price = item.Price,
	}
end

return Brainrots