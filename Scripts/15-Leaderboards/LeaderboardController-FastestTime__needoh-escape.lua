-- Reference copy for study. Game: +1 NeeDoh Escape (needoh-escape)
-- Original: +1 Speed V1 Kit/ServerScriptService/Controllers/LeaderboardController.lua  (288 lines)
-- What it does: Several boards from one config, including a best-time board that stores MAX_MS - timeMs so a descending sort shows the fastest run first, plus mm:ss.mmm and 1h 2m 3s formatters.

--!strict
-- LOCATION: ServerScriptService/Controllers/LeaderboardController

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

local PlayerController: any

local LEADERBOARD_REFRESH_INTERVAL = 60
local SAVE_INTERVAL = 60
local TOP_N_PLAYERS = 50
local LEADERBOARDS_FOLDER_NAME = "Leaderboards"
local ENTRY_TEMPLATE_NAME = "LeaderboardEntry"

local MAX_MS = 999 * 60 * 1000 + 59 * 1000 + 999

local function timeStringToMs(formatted: string): number?
	local m, s, ms = formatted:match("(%d+):(%d+)%.(%d+)")
	if not m then return nil end
	return tonumber(m) * 60 * 1000 + tonumber(s) * 1000 + tonumber(ms)
end

local function msToTimeString(ms: number): string
	local minutes = math.floor(ms / 60000)
	local secs    = math.floor((ms % 60000) / 1000)
	local millis  = ms % 1000
	return string.format("%02d:%02d.%03d", minutes, secs, millis)
end

-- Formats total seconds into "1h 23m 45s", omitting leading zero units.
-- e.g. 65s -> "1m 5s", 3661s -> "1h 1m 1s", 45s -> "45s"
local function formatTimePlayed(totalSeconds: number): string
	totalSeconds = math.floor(totalSeconds)
	local hours   = math.floor(totalSeconds / 3600)
	local minutes = math.floor((totalSeconds % 3600) / 60)
	local secs    = totalSeconds % 60

	if hours > 0 then
		return string.format("%dh %dm %ds", hours, minutes, secs)
	elseif minutes > 0 then
		return string.format("%dm %ds", minutes, secs)
	else
		return string.format("%ds", secs)
	end
end

local LEADERBOARDS_CONFIG = {
	Speed = {
		StoreName      = "GlobalSpeed_v1",
		ModelName      = "SpeedLeaderboard",
		DataKey        = "Speed",
		IsTime         = false,
		IsTimePlayed   = false,
		ScoreFormatter = function(score) return NumberFormatter.Format(score) .. " Speed" end,
	},
	Wins = {
		StoreName      = "GlobalWins_v1",
		ModelName      = "WinsLeaderboard",
		DataKey        = "Wins",
		IsTime         = false,
		IsTimePlayed   = false,
		ScoreFormatter = function(score) return NumberFormatter.Format(score) .. " Wins" end,
	},
	Time = {
		StoreName      = "GlobalSpeedRunTime_v1",
		ModelName      = "TimeLeaderboard",
		DataKey        = "BestSpeedRunTime",
		IsTime         = true,
		IsTimePlayed   = false,
		ScoreFormatter = function(invertedMs) return msToTimeString(MAX_MS - invertedMs) end,
	},
	TimePlayed = {
		StoreName      = "GlobalTimePlayed_v1",
		ModelName      = "TimePlayedLeaderboard",
		DataKey        = "TimePlayed",   -- profile.Data.TimePlayed (total seconds, number)
		IsTime         = false,
		IsTimePlayed   = true,           -- special flag: store/display as seconds, format nicely
		ScoreFormatter = function(score) return formatTimePlayed(score) end,
	},
}

local LeaderboardController = {}
local orderedDataStores: {[string]: OrderedDataStore} = {}

-- [ HELPERS ] ----------------------------------------------------------------

local function getODS(storeName: string): OrderedDataStore?
	if orderedDataStores[storeName] then return orderedDataStores[storeName] end
	local success, ods = pcall(function()
		return DataStoreService:GetOrderedDataStore(storeName)
	end)
	if success then
		orderedDataStores[storeName] = ods
		return ods
	else
		warn("[LeaderboardController] CRITICAL: Failed to get ODS: " .. storeName)
		return nil
	end
end

local function clearDisplay(scrollingFrame: ScrollingFrame)
	local template = scrollingFrame:FindFirstChild("Template")
	for _, child in ipairs(scrollingFrame:GetChildren()) do
		if not child:IsA("UILayout") and child ~= template then
			child:Destroy()
		end
	end
end

local function findBoardGuiAndFrame(leaderboardModel: Instance): (SurfaceGui?, ScrollingFrame?)
	for _, descendant in ipairs(leaderboardModel:GetDescendants()) do
		if descendant:IsA("SurfaceGui") then
			local sf = descendant:FindFirstChildWhichIsA("ScrollingFrame", true)
			if sf then return descendant, sf end
		end
	end
	return nil, nil
end

-- [ CORE LOGIC ] -------------------------------------------------------------

function LeaderboardController:UpdateDisplay(config: table)
	local folder = Workspace:FindFirstChild(LEADERBOARDS_FOLDER_NAME)
	if not folder then
		warn("[LeaderboardController] MISSING: Folder '" .. LEADERBOARDS_FOLDER_NAME .. "' in Workspace.")
		return
	end

	local leaderboardModel = folder:FindFirstChild(config.ModelName)
	if not leaderboardModel then return end

	local _, scrollingFrame = findBoardGuiAndFrame(leaderboardModel)
	if not scrollingFrame then
		warn("[LeaderboardController] MISSING: SurfaceGui+ScrollingFrame in '" .. config.ModelName .. "'.")
		return
	end

	local entryTemplate = scrollingFrame:FindFirstChild("Template")
	if not entryTemplate then
		local templatesFolder = ReplicatedStorage:FindFirstChild("Templates")
		if templatesFolder then
			entryTemplate = templatesFolder:FindFirstChild(ENTRY_TEMPLATE_NAME)
		end
	end
	if not entryTemplate then
		warn("[LeaderboardController] MISSING: Template in '" .. config.ModelName .. "'.")
		return
	end

	clearDisplay(scrollingFrame)
	if entryTemplate.Parent == scrollingFrame then
		entryTemplate.Visible = false
	end

	local ods = getODS(config.StoreName)
	if not ods then return end

	local getSuccess, pages = pcall(function()
		return ods:GetSortedAsync(false, TOP_N_PLAYERS)
	end)
	if not getSuccess then
		warn("[LeaderboardController] API Error: " .. tostring(pages))
		return
	end

	local dataPage = pages:GetCurrentPage()
	if #dataPage == 0 then return end

	for rank, entryData in ipairs(dataPage) do
		local userId = tonumber(entryData.key)
		local score  = entryData.value
		if not userId then continue end

		task.spawn(function()
			local nameOk, playerName = pcall(function()
				return Players:GetNameFromUserIdAsync(userId)
			end)
			if not nameOk then playerName = "Unknown" end

			if not scrollingFrame or not scrollingFrame.Parent then return end

			local newEntry = entryTemplate:Clone()
			newEntry.Name = "Entry_" .. tostring(rank)
			newEntry:SetAttribute("UserId", userId)   -- ← ADD THIS LINE

			local rankLabel  = newEntry:FindFirstChild("RankLabel")
			local nameLabel  = newEntry:FindFirstChild("NameLabel")
			local scoreLabel = newEntry:FindFirstChild("ScoreLabel")
			local imageLabel = newEntry:FindFirstChild("ImageLabel")

			if rankLabel  and rankLabel:IsA("TextLabel")  then rankLabel.Text  = "#" .. tostring(rank) end
			if nameLabel  and nameLabel:IsA("TextLabel")  then nameLabel.Text  = playerName end
			if scoreLabel and scoreLabel:IsA("TextLabel") then scoreLabel.Text = config.ScoreFormatter(score) end
			if imageLabel and imageLabel:IsA("ImageLabel") then
				imageLabel.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", userId)
			end

			newEntry.Parent  = scrollingFrame
			newEntry.Visible = true
		end)
	end
end

function LeaderboardController:SavePlayerToLeaderboards(player: Player)
	if not PlayerController then return end
	local profile = PlayerController:GetProfile(player)
	if not profile or not profile.Data then return end

	-- Flush the current session's time into the profile before reading it,
	-- so the leaderboard always reflects up-to-the-minute playtime.
	if PlayerController.FlushTimePlayed then
		PlayerController:FlushTimePlayed(player)
	end

	for _, config in pairs(LEADERBOARDS_CONFIG) do
		if config.IsTime then
			local timeStr = profile.Data[config.DataKey]
			if type(timeStr) ~= "string" or timeStr == "" then continue end
			local ms = timeStringToMs(timeStr)
			if not ms or ms <= 0 then continue end
			local invertedMs = MAX_MS - ms
			local ods = getODS(config.StoreName)
			if ods then pcall(function() ods:SetAsync(tostring(player.UserId), invertedMs) end) end

		elseif config.IsTimePlayed then
			local seconds = profile.Data[config.DataKey]
			if type(seconds) ~= "number" or seconds <= 0 then continue end
			local ods = getODS(config.StoreName)
			if ods then pcall(function() ods:SetAsync(tostring(player.UserId), math.floor(seconds)) end) end

		else
			local score = profile.Data[config.DataKey]
			if score and score > 0 then
				local ods = getODS(config.StoreName)
				if ods then pcall(function() ods:SetAsync(tostring(player.UserId), score) end) end
			end
		end
	end
end

-- [ INIT & START ] -----------------------------------------------------------

function LeaderboardController:Init(controllers: {[string]: any})
	PlayerController = controllers.PlayerController
end

function LeaderboardController:Start()
	task.spawn(function()
		while true do
			task.wait(LEADERBOARD_REFRESH_INTERVAL)
			for _, config in pairs(LEADERBOARDS_CONFIG) do
				self:UpdateDisplay(config)
			end
		end
	end)

	task.delay(5, function()
		for _, config in pairs(LEADERBOARDS_CONFIG) do
			self:UpdateDisplay(config)
		end
	end)

	task.spawn(function()
		while true do
			task.wait(SAVE_INTERVAL)
			for _, p in ipairs(Players:GetPlayers()) do
				self:SavePlayerToLeaderboards(p)
			end
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:SavePlayerToLeaderboards(player)
	end)

	game:BindToClose(function()
		for _, p in ipairs(Players:GetPlayers()) do
			self:SavePlayerToLeaderboards(p)
		end
		task.wait(2)
	end)
end

return LeaderboardController
