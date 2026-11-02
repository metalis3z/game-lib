-- Game: pet-rng
-- Original: ReplicatedStorage/Engine/Modules/Roll.lua
-- What it does: Smallest possible weighted pick: sum the weights, draw math.random()*total, walk the list until the running sum passes the draw.

local roll = {}

local replicatedStorage = game:GetService("ReplicatedStorage")
--local pets = require(replicatedStorage.DataModules.Pets)

function roll.rollPet(pets)
	local totalWeight = 0
	for _, weight in pairs(pets) do
		totalWeight = totalWeight + weight.weight
	end

	local randomNumber = math.random() * totalWeight

	local accumulatedWeight = 0
	for item, weight in pairs(pets) do
		accumulatedWeight = accumulatedWeight + weight.weight
		if randomNumber <= accumulatedWeight then
			return weight
		end
	end
end

return roll
