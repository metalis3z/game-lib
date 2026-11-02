local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataModule = require(script.Parent:WaitForChild("DataModule"))
local remotes = ReplicatedStorage:WaitForChild("Remotes")
local extras = remotes:WaitForChild("Extras")
local getLiveBoardData = extras:WaitForChild("GetLiveBoardData")

local categories = {
	Murderer = {
		Store = DataStoreService:GetOrderedDataStore("MMV_LiveBoard_MurdererWins_v1"),
		Title = "MURDERER",
	},
	Sheriff = {
		Store = DataStoreService:GetOrderedDataStore("MMV_LiveBoard_SheriffWins_v1"),
		StatusKey = "Sheriffs",
		Title = "SHERIFF",
	},
	Innocent = {
		Store = DataStoreService:GetOrderedDataStore("MMV_LiveBoard_InnocentWins_v1"),
		StatusKey = "Innocents",
		Title = "INNOCENT",
	},
}

local cache = {}
local lastFetch = {}
local nameCache = {}
local publishCooldown = {}

local function numberWithCommas(value)
	value = tostring(math.floor(tonumber(value) or 0))
	while true do
		local nextValue, replacements = value:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		value = nextValue
		if replacements == 0 then break end
	end
	return value
end

local function safeUserName(userId)
	userId = tonumber(userId)
	if not userId then return "Player" end
	if nameCache[userId] then return nameCache[userId] end
	local name = "User " .. tostring(userId)
	pcall(function()
		name = Players:GetNameFromUserIdAsync(userId)
	end)
	nameCache[userId] = name
	return name
end

local function cleanValue(value)
	value = tonumber(value) or 0
	if value < 0 then value = 0 end
	return math.floor(value)
end

local function isValidLeaderboardPlayer(player)
	return typeof(player) == "Instance" and player:IsA("Player") and player.UserId and player.UserId > 0
end

local function getPlayerStatusValue(player, categoryName)
	local category = categories[categoryName]
	if not (player and category and category.StatusKey) then return nil end
	local dataTable = DataModule.GetDataTable and DataModule.GetDataTable()
	local data = dataTable and dataTable[player.Name]
	local status = data and data.Status
	return cleanValue(status and status[category.StatusKey])
end

local function setCategoryValue(player, categoryName, value)
	local category = categories[categoryName]
	if not (isValidLeaderboardPlayer(player) and category) then return end
	value = cleanValue(value)
	local key = tostring(player.UserId)
	pcall(function()
		category.Store:SetAsync(key, value)
	end)
	lastFetch[categoryName] = 0
end

local function publishProfileBackedValues(player, force)
	if not isValidLeaderboardPlayer(player) then return end
	-- LiveBoard uses its own round-win OrderedDataStores. Do not mirror murderer kills.
end

local function incrementCategoryWin(player, categoryName, amount)
	local category = categories[categoryName]
	if not (isValidLeaderboardPlayer(player) and category) then return end
	amount = math.max(1, cleanValue(amount or 1))
	local key = tostring(player.UserId)
	pcall(function()
		category.Store:UpdateAsync(key, function(oldValue)
			return cleanValue(oldValue) + amount
		end)
	end)
	lastFetch[categoryName] = 0
end

_G.LiveBoardPublishPlayer = publishProfileBackedValues
_G.LiveBoardRecordWin = function(player, categoryName, amount)
	if categories[categoryName] then
		incrementCategoryWin(player, categoryName, amount)
	end
end

local function fetchCategory(categoryName, force)
	local category = categories[categoryName] or categories.Murderer
	categoryName = categories[categoryName] and categoryName or "Murderer"
	local now = os.clock()
	if not force and cache[categoryName] and lastFetch[categoryName] and now - lastFetch[categoryName] < 45 then
		return cache[categoryName]
	end

	local rows = {}
	local ok, pages = pcall(function()
		return category.Store:GetSortedAsync(false, 50)
	end)
	if ok and pages then
		for _, entry in ipairs(pages:GetCurrentPage()) do
			local userId = tonumber(entry.key)
			local wins = cleanValue(entry.value)
			if userId and userId > 0 and wins > 0 then
				table.insert(rows, {
					Rank = #rows + 1,
					UserId = userId,
					Name = safeUserName(userId),
					Wins = wins,
					WinsText = numberWithCommas(wins),
				})
			end
		end
	end

	cache[categoryName] = {
		Category = categoryName,
		Title = category.Title,
		Rows = rows,
		FetchedAt = os.time(),
	}
	lastFetch[categoryName] = now
	return cache[categoryName]
end

getLiveBoardData.OnServerInvoke = function(player, categoryName)
	publishProfileBackedValues(player)
	return fetchCategory(categoryName)
end

Players.PlayerAdded:Connect(function(player)
	task.delay(8, function()
		publishProfileBackedValues(player, true)
		for categoryName in pairs(categories) do
			fetchCategory(categoryName, true)
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	publishProfileBackedValues(player, true)
	publishCooldown[player] = nil
end)

task.spawn(function()
	while true do
		for _, player in ipairs(Players:GetPlayers()) do
			publishProfileBackedValues(player)
		end
		for categoryName in pairs(categories) do
			fetchCategory(categoryName, true)
		end
		task.wait(60)
	end
end)
