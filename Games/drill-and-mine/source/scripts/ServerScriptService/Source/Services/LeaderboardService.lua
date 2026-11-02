local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GetNameFromCache = require(ReplicatedStorage.Source.Utils.NameCache)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

local LeaderboardService = {}

local UPDATE_INTERVAL = 30
local PLAYTIME_TICK = 60
local MAX_ENTRIES = 50

local TotalCashODS = DataStoreService:GetOrderedDataStore("Leaderboard_TotalCash_V2")
local RebirthsODS = DataStoreService:GetOrderedDataStore("Leaderboard_Rebirths_V1")
local TotalPlaytimeODS = DataStoreService:GetOrderedDataStore("Leaderboard_TotalPlaytime_V2")

local BoardsFolder = Workspace:FindFirstChild("Lbs")

local rankCache = {}
local playtimeTimer = 0

-- "Top #1" podium displays under Workspace.Lbs: the R15 dummy wears the current
-- #1 player's avatar and a nameplate shows their name + value. Keyed by the
-- board's internal Name -> the display folder name in Lbs.
local TopDisplays = {
	TotalCash = "TopCash",
	Rebirths = "TopRebirth",
}
-- [displayFolderName] = last userId whose avatar we applied, so we only re-run
-- the (expensive, yielding) ApplyDescription when the #1 player actually changes.
local lastTopUserId = {}
-- [displayFolderName] = the rig's authored body scale, captured once. We reapply
-- it onto every fetched description so the dummy keeps the Humanoids rig's size
-- instead of adopting the player's avatar height/width/proportion scaling.
local originalScale = {}

local function formatPlaytime(value)
	local totalSeconds = math.max(0, math.floor(value))
	local totalMinutes = math.floor(totalSeconds / 60)
	local totalHours = math.floor(totalMinutes / 60)
	local days = math.floor(totalHours / 24)
	local hours = totalHours % 24
	local minutes = totalMinutes % 60
	if days > 0 then
		if hours > 0 then return days .. "d " .. hours .. "h" end
		return days .. "d"
	end
	if totalHours > 0 then
		if minutes > 0 then return totalHours .. "h " .. minutes .. "m" end
		return totalHours .. "h"
	end
	if totalMinutes > 0 then return totalMinutes .. "m" end
	return totalSeconds .. "s"
end

local BOARDS = {
	{
		Name = "TotalCash",
		BoardName = "MostCashLb",
		Store = TotalCashODS,
		GetValue = function(data) return math.floor(data.TotalCash or 0) end,
		Format = function(value) return "$" .. FormatUtils.Abbreviate(value) end,
	},
	{
		Name = "Rebirths",
		BoardName = "MostRebirthsLb",
		Store = RebirthsODS,
		GetValue = function(data) return math.floor(data.Rebirths or 0) end,
		Format = function(value) return FormatUtils.Abbreviate(value) end,
	},
	{
		Name = "TotalPlaytime",
		BoardName = "MostTimeLb",
		Store = TotalPlaytimeODS,
		GetValue = function(data) return math.floor(data.TotalPlaytime or 0) end,
		Format = formatPlaytime,
	},
}

local function getCategoryDisplayName(name)
	if name == "TotalCash" then return "Cash" end
	if name == "Rebirths" then return "Rebirths" end
	if name == "TotalPlaytime" then return "Playtime" end
	return name
end

local function resolveBoardParts(boardName)
	if not BoardsFolder then return nil end
	local boardModel = BoardsFolder:FindFirstChild(boardName)
	if not boardModel then return nil end
	-- The board model can contain multiple parts named "Ground" -- find the
	-- one that actually carries the LeaderboardGui (it's the visible surface).
	local gui
	for _, desc in ipairs(boardModel:GetDescendants()) do
		if desc.Name == "LeaderboardGui" and desc:IsA("SurfaceGui") then
			gui = desc
			break
		end
	end
	if not gui then return nil end
	local holder = gui:FindFirstChild("EntryHolder")
	if not holder then return nil end
	local template = holder:FindFirstChild("EntryTemplate")
	if not template then return nil end
	return holder, template
end

local function updateBoardVisuals(board, dataPage)
	local holder, template = resolveBoardParts(board.BoardName)
	if not holder or not template then return end

	template.Visible = false

	for _, child in ipairs(holder:GetChildren()) do
		if child ~= template and string.sub(child.Name, 1, 5) == "Rank_" then
			child:Destroy()
		end
	end

	for rank, data in ipairs(dataPage) do
		local userId = tonumber(data.key)
		local value = data.value
		if not userId then continue end

		local entry = template:Clone()
		entry.Name = "Rank_" .. rank
		entry.Visible = true
		entry.LayoutOrder = rank
		entry.Parent = holder

		local rankLabel = entry:FindFirstChild("Rank")
		if rankLabel and rankLabel:IsA("TextLabel") then
			rankLabel.Text = "#" .. rank
		end

		local dataLabel = entry:FindFirstChild("Data")
		if dataLabel and dataLabel:IsA("TextLabel") then
			dataLabel.Text = board.Format(value)
		end

		local playerLabel = entry:FindFirstChild("Player")
		if playerLabel and playerLabel:IsA("TextLabel") then
			playerLabel.Text = "..."
		end

		task.spawn(function()
			local name = GetNameFromCache(userId)
			if not name then
				task.wait(0.5)
				name = GetNameFromCache(userId)
			end
			if entry.Parent ~= holder then return end
			local label = entry:FindFirstChild("Player")
			if label and label:IsA("TextLabel") then
				label.Text = name or ("User_" .. userId)
			end
		end)

		task.spawn(function()
			local ok, content = pcall(function()
				return Players:GetUserThumbnailAsync(
					userId,
					Enum.ThumbnailType.HeadShot,
					Enum.ThumbnailSize.Size420x420
				)
			end)
			if not ok or not content then return end
			if entry.Parent ~= holder then return end
			local icon = entry:FindFirstChild("Icon")
			if icon and icon:IsA("ImageLabel") then
				icon.Image = content
			end
		end)
	end
end

-- Updates a "Top #1" podium (the dummy wears the #1 player's avatar) from the
-- board's sorted page.
local function updateTopDisplay(board, dataPage)
	local folderName = TopDisplays[board.Name]
	if not folderName or not BoardsFolder then return end

	local displayFolder = BoardsFolder:FindFirstChild(folderName)
	if not displayFolder then return end

	local humanoidsFolder = displayFolder:FindFirstChild("Humanoids")
	local model = humanoidsFolder and humanoidsFolder:FindFirstChild("1")
	if not model then return end

	local top = dataPage[1]
	local userId = top and tonumber(top.key)
	if not userId then return end

	-- Who is currently shown on this podium (handy for debugging / other systems).
	model:SetAttribute("TopUserId", userId)

	-- Avatar: only re-apply when the #1 player actually changes (ApplyDescription
	-- yields and can throttle, so we don't run it every 30s refresh).
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if humanoid and lastTopUserId[folderName] ~= userId then
		lastTopUserId[folderName] = userId
		task.spawn(function()
			-- Capture the rig's authored body scale once, before we ever apply an
			-- avatar to it, so the dummy always keeps the Humanoids rig's size.
			if not originalScale[folderName] then
				local ok, current = pcall(function()
					return humanoid:GetAppliedDescription()
				end)
				if ok and current then
					originalScale[folderName] = {
						HeightScale = current.HeightScale,
						WidthScale = current.WidthScale,
						DepthScale = current.DepthScale,
						HeadScale = current.HeadScale,
						BodyTypeScale = current.BodyTypeScale,
						ProportionScale = current.ProportionScale,
					}
				end
			end

			local ok, desc = pcall(function()
				return Players:GetHumanoidDescriptionFromUserId(userId)
			end)
			if ok and desc and humanoid.Parent then
				-- Keep the rig's size: overwrite the player's scale with the rig's.
				local scale = originalScale[folderName]
				if scale then
					desc.HeightScale = scale.HeightScale
					desc.WidthScale = scale.WidthScale
					desc.DepthScale = scale.DepthScale
					desc.HeadScale = scale.HeadScale
					desc.BodyTypeScale = scale.BodyTypeScale
					desc.ProportionScale = scale.ProportionScale
				end
				local applied = pcall(function()
					humanoid:ApplyDescription(desc)
				end)
				if not applied and lastTopUserId[folderName] == userId then
					lastTopUserId[folderName] = nil -- allow a retry next refresh
				end
			elseif lastTopUserId[folderName] == userId then
				lastTopUserId[folderName] = nil -- fetch failed; retry next refresh
			end
		end)
	end
end

-- per-board ranks: rankCache[userId][boardName] = rank. Every board the
-- player is top-50 on gets its own stacked overhead tag, so no best-rank
-- collapsing here; the chat tag still shows only the best rank.
local function processRankCache(dataPage, boardName)
	for rank, data in ipairs(dataPage) do
		local userId = tonumber(data.key)
		local current = rankCache[userId]
		if not current then
			current = {}
			rankCache[userId] = current
		end
		current[boardName] = rank
	end
end

local function getBestRank(ranks)
	local bestRank, bestBoard
	for _, board in ipairs(BOARDS) do
		local r = ranks[board.Name]
		if r and (not bestRank or r < bestRank) then
			bestRank, bestBoard = r, board.Name
		end
	end
	return bestRank, bestBoard
end

local function saveAllPlayers()
	for _, player in ipairs(Players:GetPlayers()) do
		local data = PlayerDataService.GetPlayerData(player)
		if not data then continue end
		local key = tostring(player.UserId)
		for _, board in ipairs(BOARDS) do
			local value = board.GetValue(data)
			if value > 0 then
				pcall(function() board.Store:SetAsync(key, value) end)
			end
		end
	end
end

local function updateChatTags()
	for _, player in ipairs(Players:GetPlayers()) do
		local ranks = rankCache[player.UserId]
		local best, bestBoard
		if ranks then best, bestBoard = getBestRank(ranks) end
		if best then
			player:SetAttribute("LeaderboardTag",
				string.format("[#%d %s]", best, getCategoryDisplayName(bestBoard)))
		else
			player:SetAttribute("LeaderboardTag", nil)
		end
		-- one structured rank attribute per board -- OverheadStatServer
		-- stacks one "#N" head tag per board the player is top-50 on
		for _, board in ipairs(BOARDS) do
			player:SetAttribute("LeaderboardRank_" .. board.Name,
				ranks and ranks[board.Name] or nil)
		end
	end
end

local function refreshLeaderboards()
	saveAllPlayers()
	table.clear(rankCache)

	for _, board in ipairs(BOARDS) do
		task.spawn(function()
			local success, pages = pcall(function()
				return board.Store:GetSortedAsync(false, MAX_ENTRIES)
			end)
			if success and pages then
				local dataPage = pages:GetCurrentPage()
				updateBoardVisuals(board, dataPage)
				processRankCache(dataPage, board.Name)
				updateTopDisplay(board, dataPage)
			end
		end)
	end

	task.wait(3)
	updateChatTags()
end

local function tickPlaytime(dt)
	playtimeTimer = playtimeTimer + dt
	if playtimeTimer < PLAYTIME_TICK then return end
	playtimeTimer = playtimeTimer - PLAYTIME_TICK

	for _, player in ipairs(Players:GetPlayers()) do
		local data = PlayerDataService.GetPlayerData(player)
		if data then
			data.TotalPlaytime = (data.TotalPlaytime or 0) + PLAYTIME_TICK
		end
	end
end

function LeaderboardService.AddTotalCash(player, amount)
	if amount <= 0 then return end
	local data = PlayerDataService.GetPlayerData(player)
	if data then
		data.TotalCash = (data.TotalCash or 0) + amount
	end
end

function LeaderboardService.Init()
	RunService.Heartbeat:Connect(tickPlaytime)

	task.delay(3, refreshLeaderboards)

	task.spawn(function()
		while true do
			task.wait(UPDATE_INTERVAL)
			refreshLeaderboards()
		end
	end)

	PlayerDataService.ProfileLoaded.Event:Connect(function(player, data)
		if not data.TotalCash then data.TotalCash = 0 end
		if not data.TotalPlaytime then data.TotalPlaytime = 0 end
		if not data.Rebirths then data.Rebirths = 0 end

		task.wait(2)
		local ranks = rankCache[player.UserId]
		if ranks then
			local best, bestBoard = getBestRank(ranks)
			if best then
				player:SetAttribute("LeaderboardTag",
					string.format("[#%d %s]", best, getCategoryDisplayName(bestBoard)))
			end
			for _, board in ipairs(BOARDS) do
				player:SetAttribute("LeaderboardRank_" .. board.Name, ranks[board.Name])
			end
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		local data = PlayerDataService.GetPlayerData(player)
		if not data then return end
		local key = tostring(player.UserId)
		for _, board in ipairs(BOARDS) do
			local value = board.GetValue(data)
			if value > 0 then
				pcall(function() board.Store:SetAsync(key, value) end)
			end
		end
	end)
end

return LeaderboardService