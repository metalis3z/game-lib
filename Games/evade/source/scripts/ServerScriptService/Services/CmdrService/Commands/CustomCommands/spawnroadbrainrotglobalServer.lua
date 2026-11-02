local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)

local function spawnGlobalAnimal(animalName: string, mutation: string?, traitList: string?, speed: number?)
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

MessagingService:SubscribeAsync("GlobalAnimalSpawn", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local ok, result = spawnGlobalAnimal(data.AnimalName, data.Mutation, data.Traits, data.Speed)
	if not ok then
		warn("couldn't spawn", result)
	end
	
	
end)

return function(context, animalName, mutation, traitsJson, speed)
	local ok, result = spawnGlobalAnimal(animalName, mutation, traitsJson, speed)
	if not ok then
		return "❌ " .. result
	end

	local publishOk, publishErr = pcall(function()
		MessagingService:PublishAsync("GlobalAnimalSpawn", {
			AnimalName = animalName,
			Mutation = mutation,
			Traits = traitsJson,
			Speed = speed,
			FromServer = game.JobId,
			Executor = context.Executor.Name
		})
	end)

	if not publishOk then
		warn(publishErr)
		return "Spawned locally but failed to spawn globally: " .. tostring(publishErr)
	end

	local mutationText = mutation and mutation ~= "" and " (" .. mutation .. ")" or ""
	local traitsText = (traitsJson and traitsJson ~= "" and traitsJson ~= "None") and (" with traits " .. traitsJson) or ""

	return "Spawned '" .. animalName .. "'" .. mutationText .. traitsText .. " globally!"
end
