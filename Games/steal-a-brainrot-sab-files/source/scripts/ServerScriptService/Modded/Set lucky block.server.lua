local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Net = require(ReplicatedStorage.Packages.Net)
local SyncEvent = Net:RemoteEvent("SyncLuckyBlock")
local SetLuckyChance = Net:RemoteFunction("AdminService/SetLuckyBlockChance")
local gamedata = require(ReplicatedStorage.GameData)
local Animals = require(ReplicatedStorage.Datas.Animals)
local LuckyBlocks = require(ReplicatedStorage.Datas.LuckyBlocks)
local blacklist = gamedata.UnSpawnableBrainrots
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Players = game:GetService("Players")

local function wrapAnimalsTable(blockName: string, animalsTable: table)
	local mt = {
		__index = animalsTable,
		__newindex = function(_, k, v)
			animalsTable[k] = v
			for _, player in ipairs(Players:GetPlayers()) do
				local PlayerChannel = Synchronizer:Get(player)
				if not PlayerChannel then continue end
				local podiums = PlayerChannel:Get("AnimalPodiums")
				if not podiums then continue end
				local hasBlock = false
				for _, podiumData in pairs(podiums) do
					if type(podiumData) == "table" and podiumData.Index == blockName then
						hasBlock = true
						break
					end
				end
				if hasBlock then
					local copy = {}
					for pk, pv in pairs(podiums) do copy[pk] = pv end
					PlayerChannel:Set("AnimalPodiums", copy)
					PlayerChannel:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
				end
			end
		end,
		__len = function() return #animalsTable end,
	}
	local proxy = setmetatable({}, mt)
	proxy.__rawTable = animalsTable
	return proxy
end

for blockName, blockData in pairs(LuckyBlocks) do
	if blockData.Animals then
		blockData.Animals = wrapAnimalsTable(blockName, blockData.Animals)
	end
end

local function getRawAnimals(animalsTable)
	if animalsTable.__rawTable then
		return animalsTable.__rawTable
	end
	return animalsTable
end

local function setluck(player: Player, luckyBlockName: string, animalName: string, chanceValue: any, isRemoving: boolean)

	local block = LuckyBlocks[luckyBlockName]
	if not block then
		return false, "Lucky Block '" .. tostring(luckyBlockName) .. "' not found!"
	end

	if blacklist[animalName] or blacklist[luckyBlockName] then
		return false, "That item is blacklisted!"
	end

	local rawAnimals = getRawAnimals(block.Animals)

	local function propagatePlayers()
		for _, p in ipairs(Players:GetPlayers()) do
			local ch = Synchronizer:Get(p)
			if not ch then continue end
			local pods = ch:Get("AnimalPodiums")
			if not pods then continue end
			for _, pd in pairs(pods) do
				if type(pd) == "table" and pd.Index == luckyBlockName then
					local copy = {}
					for k, v in pairs(pods) do copy[k] = v end
					ch:Set("AnimalPodiums", copy)
					ch:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
					break
				end
			end
		end
	end

	if isRemoving then
		local foundIndex = nil
		for i, animal in ipairs(rawAnimals) do
			if animal.Name == animalName then
				foundIndex = i
				break
			end
		end
		if not foundIndex then
			return false, "Animal not found in this lucky block."
		end
		table.remove(rawAnimals, foundIndex)
		SyncEvent:FireAllClients({ LuckyBlock = luckyBlockName, Name = animalName, Removed = true })
		propagatePlayers()
		return true, "Successfully removed animal from block."
	end

	local chance = tonumber(chanceValue)
	if not chance or chance < 0 then
		return false, "Chance must be a valid number!"
	end

	if chance == 0 then
		local foundIndex = nil
		for i, animal in ipairs(rawAnimals) do
			if animal.Name == animalName then
				foundIndex = i
				break
			end
		end
		if foundIndex then
			table.remove(rawAnimals, foundIndex)
			SyncEvent:FireAllClients({ LuckyBlock = luckyBlockName, Name = animalName, Removed = true })
			propagatePlayers()
		end
		return true, "Chance set to 0 — animal removed from pool."
	end

	if chance > 1000000 then
		chance = 1000000
	end

	local found = false
	for _, animal in ipairs(rawAnimals) do
		if animal.Name == animalName then
			animal.Chance = chance
			found = true
			break
		end
	end

	if not found then
		table.insert(rawAnimals, { Name = animalName, Chance = chance })
	end

	SyncEvent:FireAllClients({ LuckyBlock = luckyBlockName, Name = animalName, Chance = chance, Removed = false })
	propagatePlayers()

	local spawnSuccess, spawnError = pcall(function()
		AnimalService.spawnAnimalInBase(player, luckyBlockName)
	end)

	if not spawnSuccess then
		warn("AnimalService Error: " .. tostring(spawnError))
		return true, "Chance updated, but spawning failed: " .. tostring(spawnError)
	end

	return true, "Chance updated and animal spawned successfully!"
end

SetLuckyChance.OnServerInvoke = setluck