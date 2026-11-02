local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local DataService = require(ReplicatedStorage.Packages.DataService).server
local LeaderboardTemplate = require(ReplicatedStorage.Source.Features.Leaderboards.LeaderboardTemplate)
local LongNum = require(ReplicatedStorage.Source.Core.Math.LongNum)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)

local networkerModule = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker

local Players_service = game:GetService("Players")
local function getProfileImage(userId: number): string
	local ok, url = pcall(function()
		return Players_service:GetUserThumbnailAsync(
			userId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size48x48
		)
	end)
	return ok and url or ""
end

local usernameCache = {}
local function getUsername(userId: number): string
	if usernameCache[userId] then return usernameCache[userId] end
	local ok, name = pcall(function()
		return Players_service:GetNameFromUserIdAsync(userId)
	end)
	local result = ok and name or ("User_" .. userId)
	usernameCache[userId] = result
	return result
end

local stores = {}
for leaderboardId in pairs(LeaderboardTemplate) do
	local ok, store = pcall(function()
		return DataStoreService:GetOrderedDataStore("Leaderboard_" .. leaderboardId)
	end)
	if ok then
		stores[leaderboardId] = store
	else
		warn("[LeaderboardServiceServer] Failed to get store for:", leaderboardId)
	end
end

local leaderboardData = {}

local function getNestedValue(data, path: {string})
	local value = data:get(path[1])
	if value == nil then return nil end
	if #path == 1 then return value end

	-- Walk deeper for nested paths like {"stats", "rolls"}
	for i = 2, #path do
		if type(value) ~= "table" then return nil end
		value = value[path[i]]
		if value == nil then return nil end
	end
	return value
end

local function fetchLeaderboard(leaderboardId: string): {any}
	local template = LeaderboardTemplate[leaderboardId]
	local store = stores[leaderboardId]
	if not store or not template then return {} end

	local ascending = template.smallestFirst == true
	local ok, pages = pcall(function()
		return store:GetSortedAsync(ascending, 100)
	end)
	if not ok then
		warn("[LeaderboardServiceServer] GetSortedAsync failed for", leaderboardId, ":", pages)
		return {}
	end

	local entries = {}
	local rank = 0

	local currentPage = pages:GetCurrentPage()
	local pagesDone = false

	while not pagesDone do
		for _, entry in ipairs(currentPage) do
			rank += 1
			if rank > 100 then break end

			local userId = tonumber(entry.key)
			local rawValue = entry.value

			if userId and rawValue then
				local displayValue
				if template.mutator then
					local decoded = rawValue
					if template.rounder then
						decoded = LongNum.decode(rawValue)
					end
					local ok2, result = pcall(template.mutator, rawValue)
					displayValue = ok2 and result or tostring(rawValue)
				else
					displayValue = Abbreviate(rawValue)
				end

				local username = getUsername(userId)
				local profileImage = getProfileImage(userId)

				table.insert(entries, {
					username = username,
					profileImage = profileImage,
					value = displayValue,
				})
			end
		end

		if rank >= 100 or pages.IsFinished then
			pagesDone = true
		else
			local advOk, advErr = pcall(function() pages:AdvanceToNextPageAsync() end)
			if not advOk then
				warn("[LeaderboardServiceServer] AdvanceToNextPageAsync failed:", advErr)
				pagesDone = true
			else
				currentPage = pages:GetCurrentPage()
			end
		end
	end

	return entries
end

local function refreshAllLeaderboards()
	for leaderboardId in pairs(LeaderboardTemplate) do
		local entries = fetchLeaderboard(leaderboardId)
		leaderboardData[leaderboardId] = entries
	end
	print("[LeaderboardServiceServer] All leaderboards refreshed")
end

local function writePlayerScores(player: Player)
	local data = DataService:waitForData(player)
	if not data then return end

	for leaderboardId, template in pairs(LeaderboardTemplate) do
		local store = stores[leaderboardId]
		if not store then continue end

		local rawValue = getNestedValue(data, template.dataPath)
		if type(rawValue) ~= "number" then continue end

		local min = template.min or 0
		if rawValue < min then continue end

		local storeValue = rawValue
		if template.rounder then
			local ok, encoded = pcall(template.rounder, rawValue)
			if ok and encoded then
				storeValue = encoded
			end
		end

		storeValue = math.floor(storeValue)
		if storeValue <= 0 then continue end

		local ok, err = pcall(function()
			store:SetAsync(tostring(player.UserId), storeValue)
		end)
		if not ok then
			warn("[LeaderboardServiceServer] SetAsync failed for", leaderboardId, player.Name, ":", err)
		else
			print(string.format(
				"[LeaderboardServiceServer] Wrote %s=%d for %s",
				leaderboardId, storeValue, player.Name
				))
		end
	end
end

local remoteEvent = nil
local function broadcastLeaderboards()
	if not remoteEvent then return end
	for leaderboardId, entries in pairs(leaderboardData) do
		remoteEvent:FireAllClients("leaderboardUpdated", leaderboardId, entries)
	end
end

local LeaderboardServiceServer = {}

function LeaderboardServiceServer:init()
	local remotes = networkerModule:WaitForChild("_remotes", 15)
	if not remotes then
		warn("[LeaderboardServiceServer] _remotes not found")
		return
	end

	local svcRemotes = remotes:WaitForChild("LeaderboardServiceServer", 10)
	if not svcRemotes then
		warn("[LeaderboardServiceServer] LeaderboardServiceServer remotes not found")
		return
	end

	remoteEvent = svcRemotes:FindFirstChild("RemoteEvent")

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			if method == "getAllLeaderboardData" then
				return leaderboardData
			end
			warn("[LeaderboardServiceServer] Unknown method:", method)
			return nil
		end
		print("[LeaderboardServiceServer] OnServerInvoke set")
	else
		warn("[LeaderboardServiceServer] RemoteFunction not found")
	end

	Players.PlayerRemoving:Connect(function(player)
		task.spawn(writePlayerScores, player)
	end)

	task.spawn(function()
		while true do
			task.wait(300)
			for _, player in ipairs(Players:GetPlayers()) do
				task.spawn(writePlayerScores, player)
			end
		end
	end)

	task.spawn(function()
		task.wait(3) -- let DataStores settle after server start
		refreshAllLeaderboards()
		broadcastLeaderboards()

		while true do
			task.wait(300)
			refreshAllLeaderboards()
			broadcastLeaderboards()
		end
	end)

	task.spawn(function()
		local lastResetDay = {}
		while true do
			task.wait(60)
			local now = os.time()
			for leaderboardId, template in pairs(LeaderboardTemplate) do
				if template.resetFrequency and template.resetFrequency > 0 then
					local currentPeriod = math.floor(now / template.resetFrequency)
					if lastResetDay[leaderboardId] ~= currentPeriod then
						lastResetDay[leaderboardId] = currentPeriod
						local entries = fetchLeaderboard(leaderboardId)
						leaderboardData[leaderboardId] = entries
						if remoteEvent then
							remoteEvent:FireAllClients("leaderboardUpdated", leaderboardId, entries)
						end
						print("[LeaderboardServiceServer] Reset period ticked for:", leaderboardId)
					end
				end
			end
		end
	end)

	print("[LeaderboardServiceServer] Initialized")
end

return LeaderboardServiceServer