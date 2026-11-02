--!strict
-- LOCATION: ServerScriptService/Controllers/LeaderboardController

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

local PlayerController: any

local LEADERBOARD_REFRESH_INTERVAL = 5
local TOP_N_PLAYERS = 20
local LEADERBOARDS_FOLDER_NAME = "Leaderboards"

-- [ CONFIGURATION ]
local LEADERBOARDS_CONFIG = {
	Money = {
		ModelName = "Money",
		DataKey = "Money",
		ScoreFormatter = function(score) return "$" .. NumberFormatter.Format(score) end
	},
}

local LeaderboardController = {}

local function clearDisplay(scrollingFrame: ScrollingFrame)
	local template = scrollingFrame:FindFirstChild("Template")
	for _, child in ipairs(scrollingFrame:GetChildren()) do
		if not child:IsA("UILayout") and child ~= template then child:Destroy() end
	end
end

local function getSortedPlayers(dataKey: string)
	local playerData = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local profile = PlayerController:GetProfile(player)
		if profile and profile.Data then
			local score = profile.Data[dataKey]
			if score and score > 0 then
				table.insert(playerData, {
					Player = player,
					Score = score,
				})
			end
		end
	end
	table.sort(playerData, function(a, b) return a.Score > b.Score end)
	return playerData
end

function LeaderboardController:UpdateDisplay(config: table)
	local folder = Workspace:FindFirstChild(LEADERBOARDS_FOLDER_NAME)
	if not folder then return end

	local leaderboardModel = folder:FindFirstChild(config.ModelName)
	if not leaderboardModel then return end

	local leaderBoardSubModel = leaderboardModel:FindFirstChild("LeaderBoard")
	if not leaderBoardSubModel then return end

	local screenPart = leaderBoardSubModel:FindFirstChild("Screen")
	if not screenPart then return end

	local surfaceGui = screenPart:FindFirstChild("UI")
	if not surfaceGui or not surfaceGui:IsA("SurfaceGui") then return end

	local background = surfaceGui:FindFirstChild("Background")
	if not background then return end

	local scrollingFrame = background:FindFirstChild("List")
	if not scrollingFrame or not scrollingFrame:IsA("ScrollingFrame") then return end

	local entryTemplate = scrollingFrame:FindFirstChild("Template")
	if not entryTemplate then return end

	clearDisplay(scrollingFrame)
	entryTemplate.Visible = false

	local sortedPlayers = getSortedPlayers(config.DataKey)
	if #sortedPlayers == 0 then return end

	for rank, entryData in ipairs(sortedPlayers) do
		if rank > TOP_N_PLAYERS then break end

		local player = entryData.Player
		local score = entryData.Score

		local newEntry = entryTemplate:Clone()
		newEntry.Name = string.format("Entry_%03d", rank)
		newEntry.LayoutOrder = rank
		newEntry.Visible = true
		newEntry.Parent = scrollingFrame

		local rankLabel = newEntry:FindFirstChild("Rank")
		local earnLabel = newEntry:FindFirstChild("Earn")
		local iconLabel = newEntry:FindFirstChild("Icon")
		local usernameFrame = newEntry:FindFirstChild("Username")
		local nameLabel = usernameFrame and usernameFrame:FindFirstChild("Title")

		if rankLabel and rankLabel:IsA("TextLabel") then
			rankLabel.Text = tostring(rank) .. "."
		end
		if earnLabel and earnLabel:IsA("TextLabel") then
			earnLabel.Text = config.ScoreFormatter(score)
		end
		if iconLabel and iconLabel:IsA("ImageLabel") then
			iconLabel.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", player.UserId)
		end
		if nameLabel and nameLabel:IsA("TextLabel") then
			nameLabel.Text = player.Name
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

	task.delay(3, function()
		for _, config in pairs(LEADERBOARDS_CONFIG) do self:UpdateDisplay(config) end
	end)

	Players.PlayerAdded:Connect(function(player)
		task.wait(5)
		for _, config in pairs(LEADERBOARDS_CONFIG) do self:UpdateDisplay(config) end
	end)

	Players.PlayerRemoving:Connect(function()
		task.wait(1)
		for _, config in pairs(LEADERBOARDS_CONFIG) do self:UpdateDisplay(config) end
	end)
end

return LeaderboardController