-- Reference copy for study. Game: RCU (roll / mounts) (rcu-roller)
-- Original: ServerScriptService/Services/LeaderboardService.lua  (125 lines)
-- What it does: Knit service that, for each board in a shared config, uploads online players, reads the top 100, attaches cached user infos (display name, verified badge) and fires one signal to clients.

local RS = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local Knit = require(RS.Packages.Knit)

local UPDATE_INTERVAL = 60
local MAX_ENTRIES = 100

local LeaderboardService = Knit.CreateService({
	Name = "LeaderboardService",
	Client = {
		updateLeaderboard = Knit.CreateSignal(),
		weeklyReward = Knit.CreateSignal(),
	},
	_ds = nil,
	_leaderboards = {},
	_Leaderboards = nil,
})

local userInfoCache = {}

local function getUserInfos(userId)
	if userInfoCache[userId] then return userInfoCache[userId] end
	local ok, info = pcall(function()
		return Players:GetUserInfosByUserIdAsync(userId)
	end)
	if ok and info then
		local result = {
			Id = userId,
			DisplayName = info.DisplayName or "???",
			Username = info.Username or "???",
			HasVerifiedBadge = info.HasVerifiedBadge or false,
		}
		userInfoCache[userId] = result
		return result
	end
	return {
		Id = userId,
		DisplayName = "Player_"..userId,
		Username = "Player_"..userId,
		HasVerifiedBadge = false,
	}
end

function LeaderboardService:_updateBoards()
	local Leaderboards = self._Leaderboards
	for boardName, boardConfig in Leaderboards do
		if boardConfig.isClan then continue end
		
		local values = boardConfig.values
		if not values then continue end
		
		-- Build result: array of arrays, one per "value" in the board config
		local result = {}
		
		for vi, valueDef in values do
			local storeName = "Leaderboard_" .. (valueDef.name or boardName)
			
			local ok, store = pcall(function()
				return DataStoreService:GetOrderedDataStore(storeName)
			end)
			if not ok or not store then
				result[vi] = {}
				continue
			end
			
			-- Upload current player data
			for _, player in Players:GetPlayers() do
				local data = self._ds:GetData(player)
				if data and valueDef.getValue then
					local val = valueDef.getValue(data)
					if type(val) == "number" and val > 0 then
						pcall(function()
							store:SetAsync(tostring(player.UserId), math.floor(val))
						end)
					end
				end
			end
			
			-- Fetch sorted
			local ok2, pages = pcall(function()
				return store:GetSortedAsync(false, MAX_ENTRIES)
			end)
			
			local entries = {}
			if ok2 and pages then
				local pageData = pages:GetCurrentPage()
				for rank, entry in pageData do
					local userId = tonumber(entry.key)
					local userInfos = getUserInfos(userId)
					entries[#entries + 1] = {
						value = entry.value,
						userInfos = userInfos,
					}
				end
			end
			result[vi] = entries
		end
		
		self._leaderboards[boardName] = result
		for _, player in Players:GetPlayers() do
			self.Client.updateLeaderboard:Fire(player, boardName, result)
		end
	end
end

function LeaderboardService:KnitInit()
	self._ds = Knit.GetService("DataService")
	self._Leaderboards = require(RS.Shared.List.Leaderboards)
end

function LeaderboardService:KnitStart()
	task.spawn(function()
		task.wait(10)
		while true do
			pcall(function()
				self:_updateBoards()
			end)
			task.wait(UPDATE_INTERVAL)
		end
	end)
	print("[LeaderboardService] Started")
end

return LeaderboardService
