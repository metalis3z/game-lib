-- The hub's leaderboard screens (tag LeaderboardDisplay, built by the client's
-- LeaderboardDisplay: Win Streaks, Most Eliminations, Most Wins, Highest Level).
--
--   Misc.RequestLeaderboards({ name } | nil)   a client asks for those boards (nil = all)
--   Misc.UpdateLeaderboard({ Name, Players = { { key = tostring(userId), value } } })
--   Misc.LeaderboardRefreshed(name)            to everyone when a board has new data; each
--                                              client asks again once it is in the hub
--
-- Each board is an OrderedDataStore under the game's own DataStoreKey (LeaderboardLibrary.Info)
-- fed from one field of the player's data. The top is read every REFRESH_TIME; the players in
-- the server are merged in with their live values, so a win shows on the screen right away.

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local LeaderboardLibrary = require(Modules:WaitForChild("LeaderboardLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)

local Misc = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Misc")

-- Board name -> the data field it ranks.
local SOURCES = {
	["Current Highest Win Streak"] = "StatisticDuelsWinStreak",
	["Highest Win Streak Ever"] = "StatisticDuelsWinStreakHighest",
	["Most Eliminations"] = "StatisticEliminations",
	["Most Wins"] = "StatisticDuelsWon",
	["Highest Level"] = "Level",
}
local REFRESH_TIME = LeaderboardLibrary.REFRESH_TIME or 60
local SAVE_INTERVAL = 60
local MAX_PAGE = 100
local REQUEST_COOLDOWN = 1.5

local LeaderboardService = {}

local stores: { [string]: OrderedDataStore } = {}
-- [name] = { { key, value } } as last read from the store.
local stored: { [string]: { { key: string, value: number } } } = {}
-- [player][name] = the value last written for them.
local written: { [Player]: { [string]: number } } = {}
local lastRequest: { [Player]: number } = {}

local function boards(): { string }
	local list = {}
	for _, name in LeaderboardLibrary.Order do
		local info = LeaderboardLibrary.Info[name]
		if SOURCES[name] and info and info.DataStoreKey and not info.IsReadOnly then
			table.insert(list, name)
		end
	end
	return list
end

local function storeFor(name: string): OrderedDataStore?
	if stores[name] == nil then
		local ok, store = pcall(DataStoreService.GetOrderedDataStore, DataStoreService, LeaderboardLibrary.Info[name].DataStoreKey)
		stores[name] = ok and store or false :: any
	end
	return stores[name] or nil
end

local function valueOf(player: Player, name: string): number?
	if not PlayerDataService.IsLoaded(player) then
		return nil
	end
	local value = tonumber(PlayerDataService.Get(player, SOURCES[name]))
	return value and math.max(0, math.floor(value)) or 0
end

-- The stored top with everyone in the server at their current value.
local function serialize(name: string)
	local byKey: { [string]: number } = {}
	for _, entry in stored[name] or {} do
		byKey[entry.key] = entry.value
	end
	for _, player in Players:GetPlayers() do
		local value = valueOf(player, name)
		if value then
			byKey[tostring(player.UserId)] = value
		end
	end

	local list = {}
	for key, value in byKey do
		if value > 0 then
			table.insert(list, { key = key, value = value })
		end
	end
	local ascending = LeaderboardLibrary.Info[name].IsAscending
	table.sort(list, function(a, b)
		if a.value ~= b.value then
			if ascending then
				return a.value < b.value
			end
			return a.value > b.value
		end
		return a.key < b.key
	end)
	local limit = math.min(LeaderboardLibrary.Info[name].NumPlayers or MAX_PAGE, MAX_PAGE)
	while #list > limit do
		table.remove(list)
	end
	return { Name = name, Players = list }
end

local function send(player: Player, names: { string })
	for _, name in names do
		Misc.UpdateLeaderboard:FireClient(player, serialize(name))
	end
end

-- Tells every client a board changed; they ask for it again when they can show it.
function LeaderboardService.Refreshed(name: string)
	Misc.LeaderboardRefreshed:FireAllClients(name)
end

-- A player's values changed (a duel ended...): the screens update without waiting for a read.
function LeaderboardService.PlayerChanged(_player: Player)
	for _, name in boards() do
		LeaderboardService.Refreshed(name)
	end
end

local function save(player: Player)
	local last = written[player] or {}
	written[player] = last
	for _, name in boards() do
		local value = valueOf(player, name)
		local store = storeFor(name)
		if value and store and last[name] ~= value then
			local ok, err = pcall(store.SetAsync, store, tostring(player.UserId), value)
			if ok then
				last[name] = value
			else
				warn("[Leaderboards] " .. name .. " save failed: " .. tostring(err))
			end
		end
	end
end

local function read(name: string)
	local store = storeFor(name)
	if not store then
		return
	end
	local info = LeaderboardLibrary.Info[name]
	local ok, pages = pcall(store.GetSortedAsync, store, info.IsAscending == true, math.min(info.NumPlayers or MAX_PAGE, MAX_PAGE), 1)
	if not ok then
		warn("[Leaderboards] " .. name .. " read failed: " .. tostring(pages))
		return
	end
	local list = {}
	for _, entry in pages:GetCurrentPage() do
		table.insert(list, { key = tostring(entry.key), value = tonumber(entry.value) or 0 })
	end
	stored[name] = list
	LeaderboardService.Refreshed(name)
end

function LeaderboardService.Start()
	Misc.RequestLeaderboards.OnServerEvent:Connect(function(player: Player, names: any)
		local now = os.clock()
		if now - (lastRequest[player] or 0) < REQUEST_COOLDOWN and names == nil then
			return
		end
		lastRequest[player] = now
		local valid = {}
		for _, name in boards() do
			if not LeaderboardLibrary.Info[name].HiddenFromClient then
				table.insert(valid, name)
			end
		end
		if type(names) == "table" then
			local wanted = {}
			for _, name in names do
				if type(name) == "string" and table.find(valid, name) then
					table.insert(wanted, name)
				end
			end
			valid = wanted
		end
		send(player, valid)
	end)

	-- Joining players show up on the screens as soon as their data is in.
	PlayerDataService.Loaded:Connect(function(player: Player)
		LeaderboardService.PlayerChanged(player)
	end)
	Players.PlayerRemoving:Connect(function(player: Player)
		save(player)
		written[player] = nil
		lastRequest[player] = nil
	end)
	game:BindToClose(function()
		for _, player in Players:GetPlayers() do
			save(player)
		end
	end)

	task.spawn(function()
		while true do
			for _, name in boards() do
				read(name)
			end
			task.wait(REFRESH_TIME)
		end
	end)
	task.spawn(function()
		while true do
			task.wait(SAVE_INTERVAL)
			for _, player in Players:GetPlayers() do
				save(player)
			end
		end
	end)
end

LeaderboardService.Remotes = { Misc.RequestLeaderboards }

return LeaderboardService
