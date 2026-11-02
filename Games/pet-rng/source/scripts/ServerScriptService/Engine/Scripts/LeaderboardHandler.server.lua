local dataStoreService = game:GetService("DataStoreService")

local leaderboards = workspace["Main Map"].Leaderboards

local mostRolled = {}
local rarestRolls = {}

for _, leaderboard in pairs(leaderboards:GetChildren()) do
	if leaderboard.Name == "mostRolled" then
		table.insert(mostRolled, leaderboard)
	elseif leaderboard.Name == "rarestRolls" then
		table.insert(rarestRolls, leaderboard)
	end
end

print(mostRolled)
print(rarestRolls)

local rarestRollsStore = dataStoreService:GetOrderedDataStore("rarestRoll_1")
local mostRolledStore = dataStoreService:GetOrderedDataStore("mostRolled_1")

local replicatedStorage = game:GetService("ReplicatedStorage")
local dataModules = replicatedStorage.DataModules
local raritiesMod = require(dataModules.Rarities)
local petsMod = require(dataModules.Pets)
local assistance = require(replicatedStorage.Engine.Modules.Assistance)

local DataManager = require(game.ServerScriptService.Engine.Scripts.Data.DataManager)

local leaderboardHandler = require(script.Handler)

local function getChance(rarity, totalRarity)
	return math.round(1/rarity * totalRarity)
end

local function getAccumulated(weightsTable)
	local totalWeight = 0
	for _, weight in pairs(weightsTable) do
		totalWeight = totalWeight + weight.weight
	end
	return totalWeight
end

local function searchPets(petNames)
	local lowestChance = 0
	for _, petName in pairs(petNames) do
		local pet = assistance.findPetViaName(petName)
		local chance = pet.weight
		local accumulated = getAccumulated(petsMod)
		local finalChance = getChance(chance, accumulated)
		if lowestChance < finalChance then
			lowestChance = finalChance
		end
	end
	return lowestChance
end

game.Players.PlayerAdded:Connect(function(player)
	coroutine.wrap(function()
		while true do
			repeat wait() until DataManager.profiles[player]
			mostRolledStore:SetAsync(player.UserId, DataManager.profiles[player].Data["Rolls"])
			rarestRollsStore:SetAsync(player.UserId, searchPets(DataManager.profiles[player].Data["Pets"]))
			task.wait(60)
		end
	end)()
end)

while true do	
	for _, leaderboard in pairs(mostRolled) do
		coroutine.wrap(function()
			leaderboardHandler.setLeaderboard(leaderboard.Gui.scroll, leaderboard.Gui.scroll.template, mostRolledStore)
		end)()
	end
	for _, leaderboard in pairs(rarestRolls) do
		coroutine.wrap(function()
			leaderboardHandler.setLeaderboard(leaderboard.Gui.scroll, leaderboard.Gui.scroll.template, rarestRollsStore, "1/")
		end)()
	end
	task.wait(60)
end