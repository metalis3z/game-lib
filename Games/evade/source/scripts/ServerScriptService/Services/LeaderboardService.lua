--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local UserService = game:GetService("UserService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local LeaderboardService = {}

local UPDATE_INTERVAL = 120
local LOG_BASE = 1.0000001

local LEADERBOARD_NAMES = {
	"Generation",
	"Steals"
}

local SCALED_LEADERBOARDS = {
	[LEADERBOARD_NAMES[1]] = true,
	[LEADERBOARD_NAMES[2]] = false
}

local leaderboards = {}
for _, name in ipairs(LEADERBOARD_NAMES) do
	leaderboards[name] = DataStoreService:GetOrderedDataStore(name .. "Leaderboard_2")
end

local displayNameCache = {}

local GetDisplayNames = Net:RemoteFunction("Leaderboard/GetDisplayNames")
local GetTopPlayers = Net:RemoteFunction("Leaderboard/GetTopPlayers")
local ReplicateDisplayNames = Net:RemoteEvent("Leaderboard/ReplicateDisplayNames")
local ReplicateUpdate = Net:RemoteEvent("Leaderboard/ReplicateUpdate")

local function getAndReplicateDisplayNames(userIds)
	local idsToFetch = {}
	for _, id in ipairs(userIds) do
		if not displayNameCache[id] then
			table.insert(idsToFetch, id)
		end
	end

	if #idsToFetch == 0 then return end

	local success, result = pcall(function()
		return UserService:GetUserInfosByUserIdsAsync(idsToFetch)
	end)

	if not success then
		warn("LeaderboardService: Could not fetch user infos:", result)
		return
	end

	local newNames = {}
	for _, info in ipairs(result) do
		displayNameCache[info.Id] = info.DisplayName
		newNames[info.Id] = info.DisplayName
	end

	if next(newNames) then
		ReplicateDisplayNames:FireAllClients(newNames)
	end
end

local function getTopPlayersData(boardName, count): any
	local store = leaderboards[boardName]
	if not store then
		warn("LeaderboardService: Attempted to get data for an invalid board:", boardName)
		return nil
	end

	local success, pages = pcall(function()
		return store:GetSortedAsync(false, count)
	end)

	if not success then
		warn("LeaderboardService: Failed to get data from DataStore for", boardName, ":", pages)
		return nil
	end

	local topPlayers = {}
	local data = pages:GetCurrentPage()

	for rank, entry in ipairs(data) do
		local finalValue = entry.value

		if SCALED_LEADERBOARDS[boardName] and finalValue > 0 then
			finalValue = math.floor(LOG_BASE ^ finalValue)
		end

		table.insert(topPlayers, {
			Rank = rank,
			UserId = tonumber(entry.key),
			Value = finalValue
		})
	end

	return topPlayers
end

function LeaderboardService:UpdatePlayerStat(player, boardName, value)
	local store = leaderboards[boardName]
	if not store then
		warn("LeaderboardService: Cannot update stat for invalid board:", boardName)
		return
	end

	local valueToStore

	if SCALED_LEADERBOARDS[boardName] then
		if value > 0 then
			valueToStore = math.floor(math.log(value) / math.log(LOG_BASE))
		else
			valueToStore = 0
		end
	else
		valueToStore = math.floor(value)
	end

	pcall(function()
		store:SetAsync(player.UserId, valueToStore)
	end)
end

function LeaderboardService:Start()
	GetTopPlayers.OnServerInvoke = function(player, boardName)
		local topPlayers = getTopPlayersData(boardName, 50)
		if topPlayers then
			local userIds = {}
			for _, data in ipairs(topPlayers) do
				table.insert(userIds, data.UserId)
			end
			getAndReplicateDisplayNames(userIds)
		end
		return topPlayers
	end

	GetDisplayNames.OnServerInvoke = function(player)
		return displayNameCache
	end

	task.spawn(function()
		while true do
			task.wait(UPDATE_INTERVAL)

			for _, player: Player in pairs(Players:GetPlayers()) do
				task.spawn(function()
					local playerChannel = Synchronizer:Get(player)
					if not playerChannel then
						return
					end

					local Generation = playerChannel and playerChannel:Get("Generation")
					if Generation then
						LeaderboardService:UpdatePlayerStat(player, "Generation", Generation)
					end

					local Steals = playerChannel and playerChannel:Get("Steals")
					if Steals then
						LeaderboardService:UpdatePlayerStat(player, "Steals", Steals)
					end
				end)
			end

			for boardName, _ in pairs(leaderboards) do
				local topPlayers = getTopPlayersData(boardName, 50)
				if topPlayers then
					local userIds = {}
					for _, data in ipairs(topPlayers) do
						table.insert(userIds, data.UserId)
					end
					getAndReplicateDisplayNames(userIds)

					ReplicateUpdate:FireAllClients(boardName, topPlayers)
				end
			end
		end
	end)
end

return LeaderboardService
