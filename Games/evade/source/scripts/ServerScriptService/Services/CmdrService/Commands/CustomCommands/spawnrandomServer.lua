local RunService = game:GetService("RunService")
local MessagingService = game:GetService("MessagingService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)

-- Function to spawn a brainrot locally on this server
local function spawnBrainrot(animalName)
	local Animal = AnimalsData[animalName]
	if not Animal then
		return false, "Animal '" .. animalName .. "' not found"
	end

	AnimalService.spawnAnimalCustom(Animal)
	return true, "Animal spawned locally"
end

-- Listen for messages about spawns from other servers
MessagingService:SubscribeAsync("GlobalBrainrotSpawn", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	if data.AnimalName and data.Spawned then
		pcall(function()
			spawnBrainrot(data.AnimalName)
		end)
	end
end)

-- Command-style function (for Cmdr/BTools)
return function(context, animalName, percent)
	percent = tonumber(percent) or 1

	-- Random chance check (no guarantee)
	local spawnThisServer = math.random(1, 100) <= percent

	local success, result
	if spawnThisServer then
		success, result = spawnBrainrot(animalName)
		if not success then
			return "❌ Failed to spawn animal locally: " .. tostring(result)
		end
	end

	-- Always broadcast, so others can roll their own RNG independently
	local publishSuccess, publishError = pcall(function()
		MessagingService:PublishAsync("GlobalBrainrotSpawn", {
			AnimalName = animalName,
			FromServer = game.JobId,
			Executor = context.Executor and context.Executor.Name or "Unknown",
			Spawned = spawnThisServer
		})
	end)

	if not publishSuccess then
		warn("Failed to broadcast global spawn:", publishError)
		return "⚠️ Animal spawned locally but failed to broadcast globally: " .. tostring(publishError)
	end

	if spawnThisServer then
		return ("✅ '%s' spawned on this server! (%.0f%% chance)"):format(animalName, percent)
	else
		return ("ℹ️ '%s' did NOT spawn on this server (%.0f%% chance)"):format(animalName, percent)
	end
end
