local assistance = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage.Engine
local DataModules = ReplicatedStorage.DataModules

local pets = require(DataModules.Pets)

function assistance.findPetViaName(petName)
	for _, pet in pairs(pets) do
		if pet.name == petName then
			local actualPet = pet
			return pet
		end
	end
end

return assistance
