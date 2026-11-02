-- Reference copy for study. Game: +1 Escape Kitty Keyboard (escape-kitty-keyboard)
-- Original: ServerScriptService/DataService/DataHandler.lua  (218 lines)
-- What it does: Writes Wins/XP/Rebirths to ordered stores on every save (math.floor to avoid ValueNotNumeric), a faster ordered-store-only update, and a one-time backfill of known players' saved data.

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage:WaitForChild("Config"))

local DataService = {}
local playerData = {}
local dataStore = DataStoreService:GetDataStore("PlayerProgress_v2")

-- OrderedDataStores for global leaderboards (includes offline players)
-- Wrapped in pcall so that if API access is not available (e.g. in Studio),
-- the rest of the DataHandler still works normally.
local orderedStores = {}
for _, pair_info in ipairs({
	{"Wins", "Wins_Leaderboard_v1"},
	{"TotalXP", "Speed_Leaderboard_v1"},
	{"Rebirths", "Rebirths_Leaderboard_v1"},
	}) do
	local key, name = pair_info[1], pair_info[2]
	local ok, store = pcall(function()
		return DataStoreService:GetOrderedDataStore(name)
	end)
	if ok then
		orderedStores[key] = store
	end
end

-- Les OrderedDataStores exigent des entiers (pas de décimales).
-- Cette fonction centralise l'arrondi pour éviter l'erreur "ValueNotNumeric".
local function toOrderedStoreValue(value)
	value = value or 0
	if type(value) ~= "number" then
		return 0
	end
	return math.floor(value)
end

-- Known players tracking for leaderboard backfill
local knownPlayersStore
do
	local ok, store = pcall(function()
		return DataStoreService:GetDataStore("KnownPlayers_v1")
	end)
	if ok then
		knownPlayersStore = store
	end
end

local knownPlayers = {}
local knownPlayersLoaded = false
local knownPlayersDirty = false

local function loadKnownPlayers()
	if knownPlayersLoaded or not knownPlayersStore then return end
	local success, data = pcall(function()
		return knownPlayersStore:GetAsync("All")
	end)
	if success and type(data) == "table" then
		knownPlayers = data
	end
	knownPlayersLoaded = true
end

function DataService.RegisterPlayer(userId)
	if not knownPlayersStore then return end
	loadKnownPlayers()
	for _, id in ipairs(knownPlayers) do
		if id == userId then return end
	end
	table.insert(knownPlayers, userId)
	knownPlayersDirty = true
	task.delay(10, function()
		if knownPlayersDirty and knownPlayersStore then
			knownPlayersDirty = false
			pcall(function()
				knownPlayersStore:SetAsync("All", knownPlayers)
			end)
		end
	end)
end

function DataService.Get(player)
	return playerData[player]
end

function DataService.Update(player, key, value)
	if playerData[player] then
		playerData[player][key] = value
		return true
	end
	return false
end

function DataService.LoadData(player)
	local success, data = pcall(function()
		return dataStore:GetAsync("User_" .. player.UserId)
	end)

	local finalData = {}
	if success and data then
		for k, v in pairs(Config.DEFAULT_DATA) do
			finalData[k] = data[k] ~= nil and data[k] or (type(v) == "table" and table.clone(v) or v)
		end
	else
		finalData = table.clone(Config.DEFAULT_DATA)
		-- Deep-clone nested tables to avoid shared references between players
		finalData.OwnedTrails = {}
		finalData.PurchaseHistory = {}
		finalData.TikfinityBinds = {}
		finalData.EventRsvpClaimed = {}
		finalData.CheatHistory = {}
		finalData.CheatHistory2 = {}
	end



	local currentXP = finalData.TotalXP
	local level = 1
	local xpReq = Config.GetXPRequired(level)
	while currentXP >= xpReq do
		currentXP = currentXP - xpReq
		level = level + 1
		xpReq = Config.GetXPRequired(level)
		if level > 1000 then break end
	end
	finalData.Level = level
	finalData.XP = currentXP

	-- Auto-equip best award based on wins
	finalData.StepBonus = Config.GetBestStepBonus(finalData.Wins)

	playerData[player] = finalData
	DataService.RegisterPlayer(player.UserId)
	return finalData
end

function DataService.SaveData(player)
	if playerData[player] then
		local success, err = pcall(function()
			dataStore:SetAsync("User_" .. player.UserId, playerData[player])
		end)
		-- Update OrderedDataStores for global leaderboards
		if next(orderedStores) then
			for key, store in pairs(orderedStores) do
				local value = toOrderedStoreValue(playerData[player][key])
				pcall(function()
					store:SetAsync(player.UserId, value)
				end)
			end
		end
		return success
	end
end

-- Update only the OrderedDataStore entries for a player (no full save)
-- Called more frequently than SaveData for live leaderboard accuracy
function DataService.UpdateOrderedStores(player)
	if not playerData[player] then return end
	if not next(orderedStores) then return end
	for key, store in pairs(orderedStores) do
		local value = toOrderedStoreValue(playerData[player][key])
		pcall(function()
			store:SetAsync(player.UserId, value)
		end)
	end
end

-- Fetch top entries from an OrderedDataStore (includes offline players)
function DataService.GetTopEntries(key, count)
	local store = orderedStores[key]
	if not store then return {} end
	local entries = {}
	local success, pages = pcall(function()
		return store:GetSortedAsync(false, count)
	end)
	if not success or not pages then return {} end
	local pageSuccess, page = pcall(function()
		return pages:GetPage(1)
	end)
	if pageSuccess and page then
		for _, entry in ipairs(page) do
			table.insert(entries, { userId = tonumber(entry.key), value = entry.value })
		end
	end
	return entries
end

-- Backfill all known players' data into OrderedDataStores
-- Ensures offline players appear in the leaderboard across all servers
function DataService.BackfillOrderedStores()
	if not next(orderedStores) then return end
	loadKnownPlayers()
	for _, userId in ipairs(knownPlayers) do
		local success, data = pcall(function()
			return dataStore:GetAsync("User_" .. userId)
		end)
		if success and data then
			for key, store in pairs(orderedStores) do
				local value = toOrderedStoreValue(data[key])
				pcall(function()
					store:SetAsync(userId, value)
				end)
			end
		end
		task.wait(0.1) -- Rate limiting to avoid DataStore throttling
	end
end

function DataService.Clear(player)
	playerData[player] = nil
end

-- Start backfill on server start (background task)
task.spawn(function()
	task.wait(15) -- Wait for server to fully initialize
	DataService.BackfillOrderedStores()
end)

return DataService
