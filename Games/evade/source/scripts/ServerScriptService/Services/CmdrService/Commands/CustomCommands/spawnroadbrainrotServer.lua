local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)

local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)

local function spawnLocalAnimal(animalName: string, mutation: string?, traitList: string?, speed: number?)
	local animalData = Animals[animalName]
	if not animalData then
		return false, "Animal '" .. animalName .. "' not found"
	end

	local cleanMutation = (mutation and mutation ~= "" and mutation ~= "Default") and mutation or nil
	if cleanMutation and not Mutations[cleanMutation] then
		return false, "Mutation '" .. cleanMutation .. "' not found"
	end

	if speed and tonumber(speed) then
		speed = tonumber(speed)
		if speed < 2 then
			return false, "Speed must be greater than 2"
		elseif speed > 100000 then
			return false, "Speed must be less than 100000"
		end
	end

	local traitTable = nil
	if traitList and traitList ~= "" and traitList ~= "None" then
		traitTable = {}

		for quoted in traitList:gmatch('"(.-)"') do
			table.insert(traitTable, quoted)
		end

		local withoutQuoted = traitList:gsub('"(.-)"', "")

		for _, trait in ipairs(string.split(withoutQuoted, ",")) do
			local cleaned = trait:match("^%s*(.-)%s*$")
			if cleaned ~= "" then
				table.insert(traitTable, cleaned)
			end
		end

		local seenTraits = {}
		local invalidTraits = {}

		for _, trait in ipairs(traitTable) do
			if seenTraits[trait] then
				return false, "Duplicate trait: " .. trait
			end
			if not Traits[trait] then
				table.insert(invalidTraits, trait)
			end
			seenTraits[trait] = true
		end

		if #invalidTraits > 0 then
			return false, "Invalid traits: " .. table.concat(invalidTraits, ", ")
		end
	end

	local success, err = pcall(function()
		AnimalService.spawnAnimalCustom(animalData, cleanMutation, traitTable, speed)
	end)

	if not success then
		return false, "Failed to spawn animal: " .. tostring(err)
	end

	return true, "'" .. animalName .. "' spawned successfully"
end

return function(context, animalName, mutation, traits, speed)
	local ok, result = spawnLocalAnimal(animalName, mutation, traits, speed)
	if not ok then
		return "❌ " .. result
	end

	local mutationText = mutation and mutation ~= "" and " (" .. mutation .. ")" or ""
	local traitsText = (traits and traits ~= "" and traits ~= "None") and (" with traits " .. traits) or ""

	return "Spawned '" .. animalName .. "'" .. mutationText .. traitsText .. " locally!"
end
