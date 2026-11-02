local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = game:GetService("MessagingService")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local TraitsData = require(ReplicatedStorage.Datas.Traits)
local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
local IndexData = require(ReplicatedStorage.Datas.Mutations)

local GlobalSpawnBrainrot = Net:RemoteFunction("GlobalSpawnBrainrot")

local BROADCAST_CHANNEL = "GlobalSpawnBrainrotChannel"

MessagingService:SubscribeAsync(BROADCAST_CHANNEL, function(message)
    local data = message.Data
    if not data then return end
    if data.originPlayerUserId == game.Players.LocalPlayer.UserId then return end
    local animal = AnimalsData[data.name]
    if not animal then return end
    local mutation = data.mutation ~= "" and data.mutation or nil
    local speed = data.speed
    local traits = data.traits
    AnimalService.spawnAnimalCustom(animal, mutation, traits, speed)
end)

GlobalSpawnBrainrot.OnServerInvoke = function(player, name, mutation, traits, speed): (boolean, string?)
	local Animal = AnimalsData[name]
	if not Animal then
		return false, "Could not find brainrot."
	end

	if mutation ~= "" and not MutationsData[mutation] then
		return false, "Could not find this mutation."
	end

	if tonumber(speed) and tonumber(speed) < 2 then
		return false, "The speed has to be over 2."
	end

	if tonumber(speed) and tonumber(speed) > 100000 then
		return false, "The speed has to be under 100000."
	end

	local TraitTable = string.split(traits, ", ")
	if traits ~= "None" then
		if traits == "" then
			TraitTable = {}
		end

		local Removed = {}
		local SeenTraits = {}

		for Index, Trait in pairs(TraitTable) do
			if SeenTraits[Trait] then
				return false, string.format("You cannot have more than one of the same trait: %s", Trait)
			end
			SeenTraits[Trait] = true

			if not TraitsData[Trait] then
				table.insert(Removed, Trait)
				TraitTable[Index] = nil
			end
		end

		if #Removed > 0 then
			local RemovedString = table.concat(Removed, ", ")
			return false, string.format("These traits do not exist: %s", RemovedString)
		end
	end

	local MutationValue = mutation ~= "" and mutation or nil
	local SpeedValue = speed and speed or nil
	local TraitsValue = traits ~= "None" and TraitTable or nil

	AnimalService.spawnAnimalCustom(Animal, MutationValue, TraitsValue, SpeedValue)
	
	local broadcastData = {
		name = name,
		mutation = mutation,
		speed = speed,
		traits = TraitsValue,
		originPlayerUserId = player.UserId,
	}
	pcall(function()
		MessagingService:PublishAsync(BROADCAST_CHANNEL, broadcastData)
	end)
	
	return true
end
