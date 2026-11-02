local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local TraitsData = require(ReplicatedStorage.Datas.Traits)

return function(context, targetPlayer, brainrotName, mutation, traits)
	if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
		return "❌ Invalid player."
	end

	local animalData = AnimalsData[brainrotName]
	if not animalData then
		return "❌ Brainrot '" .. brainrotName .. "' not found."
	end

	local cleanMutation = mutation and mutation ~= "" and mutation ~= "Default" and mutation or nil
	if cleanMutation and not MutationsData[cleanMutation] then
		return "❌ Mutation '" .. cleanMutation .. "' not found."
	end

	local traitTable = nil
	if traits and traits ~= "" and traits ~= "None" then
		traitTable = string.split(traits, ",")
		local seen = {}
		local invalid = {}

		for i, trait in ipairs(traitTable) do
			local trimmed = trait:match("^%s*(.-)%s*$")
			traitTable[i] = trimmed

			if seen[trimmed] then
				return "❌ Duplicate trait: " .. trimmed
			end
			seen[trimmed] = true

			if not TraitsData[trimmed] then
				table.insert(invalid, trimmed)
			end
		end

		if #invalid > 0 then
			return "❌ Invalid traits: " .. table.concat(invalid, ", ")
		end
	end

	local success, err = pcall(function()
		AnimalService.spawnAnimalInBase(targetPlayer, brainrotName, cleanMutation, traitTable)
	end)

	if not success then
		return "❌ Failed to spawn brainrot: " .. tostring(err)
	end

	local summary = string.format("✅ Spawned brainrot '%s'", brainrotName)
	if cleanMutation then summary ..= " (" .. cleanMutation .. ")" end
	if traitTable then summary ..= " with traits [" .. table.concat(traitTable, ", ") .. "]" end
	summary ..= " in " .. targetPlayer.Name .. "'s base!"

	return summary
end
