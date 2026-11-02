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

-- [ CONFIGURATION ]
local LEADERBOARDS_CONFIG = {
	Money = {
		StoreName = "GlobalMoney_v1",       
		ModelName = "MoneyLeaderboard",     
		DataKey = "Money",                  
		ScoreFormatter = function(score) return "$" .. NumberFormatter.Format(score) end
	},
	Rebirths = {
		StoreName = "GlobalRebirths_v1",       
		ModelName = "RebirthsLeaderboard",     
		DataKey = "Rebirths",                
		ScoreFormatter = function(score) return NumberFormatter.Format(score) .. " Rebirths" end
	}
}

local LeaderboardController = {}
local orderedDataStores: {[string]: OrderedDataStore} = {}

local function getODS(storeName: string): OrderedDataStore?
	if orderedDataStores[storeName] then return orderedDataStores[storeName] end
	local success, ods = pcall(function() return DataStoreService:GetOrderedDataStore(storeName) end)
	if success then 
		orderedDataStores[storeName] = ods
		return ods 
	else 
		warn(`[LeaderboardController] CRITICAL: Failed to get ODS: {storeName}`)
		return nil 
	end
end

local function clearDisplay(scrollingFrame: ScrollingFrame)
	local template = scrollingFrame:FindFirstChild("Template")
	for _, child in ipairs(scrollingFrame:GetChildren()) do
		if not child:IsA("UILayout") and child ~= template then child:Destroy() end
	end
end

function LeaderboardController:UpdateDisplay(config: table)
	local folder = Workspace:FindFirstChild(LEADERBOARDS_FOLDER_NAME)
	if not folder then return end

	local leaderboardModel = folder:FindFirstChild(config.ModelName)
	if not leaderboardModel then return end

	local surfaceGui = leaderboardModel:FindFirstChildWhichIsA("SurfaceGui", true)
	if not surfaceGui then return end

	local scrollingFrame = surfaceGui:FindFirstChildWhichIsA("ScrollingFrame", true)
	if not scrollingFrame then return end

	local entryTemplate = scrollingFrame:FindFirstChild("Template")
	if not entryTemplate then
		local templatesFolder = ReplicatedStorage:FindFirstChild("Templates")
		if templatesFolder then
			entryTemplate = templatesFolder:FindFirstChild(ENTRY_TEMPLATE_NAME)
		end
	end

	if not entryTemplate then return end

	clearDisplay(scrollingFrame)
	if entryTemplate.Parent == scrollingFrame then entryTemplate.Visible = false end

	local orderedDataStore = getODS(config.StoreName)
	if not orderedDataStore then return end

	local pages
	local getSuccess, getResult = pcall(function()
		return orderedDataStore:GetSortedAsync(false, TOP_N_PLAYERS)
	end)

	if not getSuccess then return end

	pages = getResult
	local dataPage = pages:GetCurrentPage()

	if not dataPage or #dataPage == 0 then return end

	for rank, entryData in ipairs(dataPage) do
		local userId = tonumber(entryData.key)
		local score = entryData.value
		if not userId then continue end

		local newEntry = entryTemplate:Clone()
		newEntry.Name = string.format("Entry_%03d", rank) 
		newEntry.LayoutOrder = rank 
		newEntry.Visible = true
		newEntry.Parent = scrollingFrame

		local rankLabel = newEntry:FindFirstChild("RankLabel")
		local scoreLabel = newEntry:FindFirstChild("ScoreLabel")
		local nameLabel = newEntry:FindFirstChild("NameLabel")
		local imageLabel = newEntry:FindFirstChild("ImageLabel")

		if rankLabel and rankLabel:IsA("TextLabel") then rankLabel.Text = "#" .. tostring(rank) end
		if scoreLabel and scoreLabel:IsA("TextLabel") then scoreLabel.Text = config.ScoreFormatter(score) end
		if imageLabel and imageLabel:IsA("ImageLabel") then
			imageLabel.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", userId)
		end

		task.spawn(function()
			local nameSuccess, playerName = pcall(function() return Players:GetNameFromUserIdAsync(userId) end)
			if not nameSuccess then playerName = "Unknown" end
			if nameLabel and nameLabel:IsA("TextLabel") and newEntry.Parent then 
				nameLabel.Text = playerName 
			end
		end)
	end
end

function LeaderboardController:SavePlayerToLeaderboards(player: Player)
	if not PlayerController then return end

	local profile = PlayerController:GetProfile(player)
	if not profile or not profile.Data then return end

	for _, config in pairs(LEADERBOARDS_CONFIG) do
		local score = profile.Data[config.DataKey]

		if score and score > 0 then
			local ods = getODS(config.StoreName)
			if ods then
				pcall(function() ods:SetAsync(tostring(player.UserId), score) end)
			end
		end
	end
end

function LeaderboardController:Init(controllers: {[string]: any})
	PlayerController = controllers.PlayerController
	print("[LeaderboardController] Initialized")
end

function LeaderboardController:Start()
	task.spawn(function()
		while true do
			task.wait(LEADERBOARD_REFRESH_INTERVAL)
			for _, config in pairs(LEADERBOARDS_CONFIG) do self:UpdateDisplay(config) end
		end
	end)

	task.delay(5, function()
		for _, config in pairs(LEADERBOARDS_CONFIG) do self:UpdateDisplay(config) end
	end)

	task.spawn(function()
		while true do
			task.wait(SAVE_INTERVAL)
			for _, player in ipairs(Players:GetPlayers()) do self:SavePlayerToLeaderboards(player) end
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:SavePlayerToLeaderboards(player)
	end)

	game:BindToClose(function()
		for _, player in ipairs(Players:GetPlayers()) do
			self:SavePlayerToLeaderboards(player)
		end
		task.wait(2)
	end)
end

return LeaderboardController