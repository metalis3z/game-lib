local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")

local STATS_DATASTORE = "Stats"
local LEADERBOARD_DATASTORE = "Stats"

-- Codes table: Each code can give multiple rewards (Money, Exp, Tools, etc.)
local Codes = {
	--	{ "TESTBUNDLE", Money = 500, Exp = 500, Tool = "Trophy"},
	{ "Meteor!",Tool = "Meteor"},
	{ "5KVisitsZS1", Money = 250, Exp = 250 },
	{ "Uncopylocked", Money = 100},
	{ "1KVisits", Exp = 1000},
}

local statList = {
	{ "Levels", 1 },
	{ "Exp", 0 },
	{ "Money", 0 },
	{ "Kills", 0 },
	{ "Wins", 0 },
}

-- Helper: Create leaderstats for player
local function createLeaderstats(player, loadedStats)
	local stats = Instance.new("Folder")
	stats.Name = "leaderstats"
	stats.Parent = player

	for i = 1, #statList do
		local statName, defaultValue = statList[i][1], statList[i][2]
		local statObj = Instance.new("IntValue")
		statObj.Name = statName
		statObj.Value = loadedStats and loadedStats[statName] or defaultValue
		statObj.Parent = stats
	end
end

-- Helper: Give tool to player
local function giveTool(player, toolName)
	local codeToolsFolder = ReplicatedStorage:FindFirstChild("Code_Tools")
	if not codeToolsFolder then return end
	
	local toolTemplate = codeToolsFolder:FindFirstChild(toolName)
	if not toolTemplate then return end
	
	-- Give to Backpack for immediate use
	local backpack = player:FindFirstChild("Backpack")
	if backpack and not backpack:FindFirstChild(toolName) then
		toolTemplate:Clone().Parent = backpack
	end
	
	-- Also add to StarterGear so it respawns on death
	local starterGear = player:FindFirstChild("StarterGear")
	if starterGear and not starterGear:FindFirstChild(toolName) then
		toolTemplate:Clone().Parent = starterGear
	end
end

-- Helper: Create CodesFolder for player
local function createCodesFolder(player, loadedCodes)
	local folder = Instance.new("Folder")
	folder.Name = "CodesFolder"
	folder.Parent = player
	for i = 1, #Codes do
		local codeName = Codes[i][1]
		local codeObj = Instance.new("BoolValue")
		codeObj.Name = codeName
		codeObj.Value = loadedCodes and loadedCodes[codeName] or false
		codeObj.Parent = folder
	end
end

-- Helper: Load player data from DataStore
local function loadPlayerData(player)
	local statsData = {}
	local codesData = {}
	local success, data = pcall(function()
		return DataStoreService:GetDataStore(STATS_DATASTORE):GetAsync(player.UserId)
	end)
	if success and data then
		statsData = data.stats or {}
		codesData = data.codes or {}
	end
	return statsData, codesData
end

-- Helper: Save player data to DataStore
local function savePlayerData(player)
	local stats = {}
	local codes = {}
	if player:FindFirstChild("leaderstats") then
		for _, statObj in player.leaderstats:GetChildren() do
			stats[statObj.Name] = statObj.Value
		end
	end
	if player:FindFirstChild("CodesFolder") then
		for _, codeObj in player.CodesFolder:GetChildren() do
			codes[codeObj.Name] = codeObj.Value
		end
	end
	local success, err = pcall(function()
		DataStoreService:GetDataStore(STATS_DATASTORE):SetAsync(player.UserId, {
			stats = stats,
			codes = codes,
		})
	end)
	if not success then
		warn("Failed to save stats for", player.Name, err)
	end
end

-- Helper: Level up logic
local function setupLevelUp(player)
	local exp = player.leaderstats:FindFirstChild("Exp")
	local levels = player.leaderstats:FindFirstChild("Levels")
	if not exp or not levels then return end

	exp.Changed:Connect(function()
		local requiredExp = 100 * (levels.Value + 1)
		if exp.Value >= requiredExp then
			levels.Value = levels.Value + 1
			exp.Value = 0
			local levelUpEvent = ReplicatedStorage.Remotes:FindFirstChild("LevelUpEvent")
			if levelUpEvent then
				levelUpEvent:FireClient(player)
			end
		end
	end)
end

-- PlayerAdded: Setup stats, codes, load data, setup level up
Players.PlayerAdded:Connect(function(player)
	local statsData, codesData = loadPlayerData(player)
	createLeaderstats(player, statsData)
	createCodesFolder(player, codesData)
	setupLevelUp(player)

	-- Fire codes table to client for redemption UI
	task.wait(1)
	local codeEvent = ReplicatedStorage.Remotes:FindFirstChild("codeEvent")
	if codeEvent then
		codeEvent:FireClient(player, Codes)
	end
end)

-- AddExp RemoteEvent: Add exp to player
local addExpEvent = ReplicatedStorage.Remotes:FindFirstChild("AddExp")
if addExpEvent then
	addExpEvent.OnServerEvent:Connect(function(player)
		if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Exp") then
			player.leaderstats.Exp.Value = player.leaderstats.Exp.Value + 50
		end
	end)
end

-- Helper: Check if code exists
local function isValidCode(codeName)
	for i = 1, #Codes do
		if Codes[i][1] == codeName then
			return true, Codes[i]
		end
	end
	return false, nil
end

-- Code Redemption RemoteEvent
local codeEvent = ReplicatedStorage.Remotes:FindFirstChild("codeEvent")
if codeEvent then
	codeEvent.OnServerEvent:Connect(function(player, enteredCode)
		-- Check if code is valid
		local valid, codeData = isValidCode(enteredCode)
		if not valid then
			-- Send invalid code notification
			local notificationEvent = ReplicatedStorage.Remotes:FindFirstChild("Notification")
			if notificationEvent then
				notificationEvent:FireClient(player, "Invalid Code", "This code does not exist!", 3)
			end
			return
		end
		
		local folder = player:FindFirstChild("CodesFolder")
		if folder and folder:FindFirstChild(enteredCode) then
			local codeObj = folder[enteredCode]
			if codeObj.Value == false then
				codeObj.Value = true
				
				-- Award rewards
				local awardedRewards = {}
				
				if player:FindFirstChild("leaderstats") then
					for rewardName, rewardValue in codeData do
						if rewardName ~= 1 and typeof(rewardValue) == "number" then
							local statObj = player.leaderstats:FindFirstChild(rewardName)
							if statObj then
								statObj.Value = statObj.Value + rewardValue
								table.insert(awardedRewards, rewardName .. ": +" .. rewardValue)
							end
						elseif rewardName == "Tool" and typeof(rewardValue) == "string" then
							giveTool(player, rewardValue)
							table.insert(awardedRewards, "Tool: " .. rewardValue)
						end
					end
				end
				
				-- Send success notification to player
				local notificationEvent = ReplicatedStorage.Remotes:FindFirstChild("Notification")
				if notificationEvent then
					local rewardText = #awardedRewards > 0 and table.concat(awardedRewards, ", ") or "No rewards"
					notificationEvent:FireClient(player, "Code Redeemed!", "Successfully redeemed code! Rewards: " .. rewardText, 5)
				end
				
				savePlayerData(player)
			else
				-- Code already redeemed
				local notificationEvent = ReplicatedStorage.Remotes:FindFirstChild("Notification")
				if notificationEvent then
					notificationEvent:FireClient(player, "Already Redeemed", "You have already used this code!", 3)
				end
			end
		end
	end)
end

-- Save stats on PlayerRemoving
Players.PlayerRemoving:Connect(function(player)
	savePlayerData(player)
end)

-- Save stats on game shutdown
game:BindToClose(function()
	if RunService:IsStudio() then
		task.wait(1)
	else
		for _, player in Players:GetPlayers() do
			savePlayerData(player)
		end
	end
end)

-- === LEADERBOARD LOGIC ===
local RequestLeaderboardData = ReplicatedStorage.Remotes:FindFirstChild("RequestLeaderboardData")
local SendLeaderboardData = ReplicatedStorage.Remotes:FindFirstChild("SendLeaderboardData")
local leaderboardStore = DataStoreService:GetDataStore(LEADERBOARD_DATASTORE)
local globalLeaderboard = {} -- { [statName] = { {UserId, Name, [stat]=value, ...}, ... } }
local cachedStatNames = nil

local function loadLeaderboardFromStore(statNames)
	for i = 1, #statNames do
		local statName = statNames[i]
		if not globalLeaderboard[statName] then
			globalLeaderboard[statName] = {}
		end
		local success, data = pcall(function()
			return leaderboardStore:GetAsync(statName)
		end)
		if success and type(data) == "table" then
			globalLeaderboard[statName] = data
		else
			globalLeaderboard[statName] = {}
		end
	end
end

local function saveLeaderboardToStore(statNames)
	for i = 1, #statNames do
		local statName = statNames[i]
		local data = globalLeaderboard[statName]
		if type(data) == "table" then
			pcall(function()
				leaderboardStore:SetAsync(statName, data)
			end)
		end
	end
end

local function updatePlayerEntry(player, statNames)
	local userId = player.UserId
	local name = player.Name
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	for i = 1, #statNames do
		local statName = statNames[i]
		local valueObj = leaderstats:FindFirstChild(statName)
		if valueObj and typeof(valueObj.Value) == "number" then
			local statValue = valueObj.Value
			if not globalLeaderboard[statName] then
				globalLeaderboard[statName] = {}
			end
			local entries = globalLeaderboard[statName]
			local found = false
			for j = 1, #entries do
				if entries[j].UserId == userId then
					entries[j].Name = name
					entries[j][statName] = statValue
					found = true
					break
				end
			end
			if not found then
				table.insert(entries, {
					UserId = userId,
					Name = name,
					[statName] = statValue
				})
			end
		end
	end
end

local function sortLeaderboard(statName)
	local entries = globalLeaderboard[statName]
	if entries then
		table.sort(entries, function(a, b)
			return (a[statName] or 0) > (b[statName] or 0)
		end)
	end
end

local function onStatChanged(player, statName, value, statNames)
	for i = 1, #statNames do
		if statNames[i] == statName then
			updatePlayerEntry(player, statNames)
			sortLeaderboard(statName)
			saveLeaderboardToStore(statNames)
			break
		end
	end
end

local function bindStatListeners(player, statNames)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end
	for i = 1, #statNames do
		local statName = statNames[i]
		local valueObj = leaderstats:FindFirstChild(statName)
		if valueObj then
			valueObj.Changed:Connect(function()
				onStatChanged(player, statName, valueObj.Value, statNames)
			end)
		end
	end
end

local function onPlayerAddedLeaderboard(player, statNames)
	updatePlayerEntry(player, statNames)
	bindStatListeners(player, statNames)
	saveLeaderboardToStore(statNames)
end

local function onPlayerRemovingLeaderboard(player, statNames)
	updatePlayerEntry(player, statNames)
	saveLeaderboardToStore(statNames)
end

if RequestLeaderboardData and SendLeaderboardData then
	RequestLeaderboardData.OnServerEvent:Connect(function(player, statNames)
		if typeof(statNames) ~= "table" or #statNames == 0 then
			return
		end
		cachedStatNames = statNames
		loadLeaderboardFromStore(statNames)
		local merged = {}
		local userMap = {}
		for i = 1, #statNames do
			local statName = statNames[i]
			if not globalLeaderboard[statName] then
				globalLeaderboard[statName] = {}
			end
			for j = 1, #globalLeaderboard[statName] do
				local entry = globalLeaderboard[statName][j]
				if entry.UserId then
					if not userMap[entry.UserId] then
						userMap[entry.UserId] = {
							UserId = entry.UserId,
							Name = entry.Name
						}
					end
					userMap[entry.UserId][statName] = entry[statName]
				end
			end
		end
		for _, entry in userMap do
			table.insert(merged, entry)
		end
		SendLeaderboardData:FireClient(player, merged)
	end)
end

task.spawn(function()
	while true do
		task.wait(30)
		if cachedStatNames then
			saveLeaderboardToStore(cachedStatNames)
		end
	end
end)

Players.PlayerAdded:Connect(function(player)
	while not cachedStatNames do
		task.wait(1)
	end
	onPlayerAddedLeaderboard(player, cachedStatNames)
end)

Players.PlayerRemoving:Connect(function(player)
	if cachedStatNames then
		onPlayerRemovingLeaderboard(player, cachedStatNames)
	end
end)
