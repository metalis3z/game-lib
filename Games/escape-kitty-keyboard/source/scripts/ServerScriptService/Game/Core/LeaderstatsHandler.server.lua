local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local DataHandler = require(game.ServerScriptService.DataService.DataHandler)
local Config = require(ReplicatedStorage:WaitForChild("Config"))

local function setupLeaderstats(player, data)
	local leaderstatsTemplate = ServerStorage:FindFirstChild("leaderstats")
	if not leaderstatsTemplate then
		return
	end
	
	local leaderstats = leaderstatsTemplate:Clone()
	leaderstats.Parent = player
	
	local speedVal = leaderstats:FindFirstChild("Speed")
	local winsVal = leaderstats:FindFirstChild("Wins")
	local rebirthsVal = leaderstats:FindFirstChild("Rebirths")
	
	if speedVal then speedVal.Value = tostring(data.TotalXP or 0) end
	if winsVal then winsVal.Value = data.Wins or 0 end
	if rebirthsVal then rebirthsVal.Value = data.Rebirths or 0 end
end

Players.PlayerAdded:Connect(function(player)
	local data = DataHandler.LoadData(player)
	
	-- Check if player owns the x2 Speed gamepass (new or legacy)
	local speedGamepassId = Config.GAMEPASS_IDS.SPEED_X2
	local speedLegacyId = Config.LEGACY_GAMEPASS_IDS and Config.LEGACY_GAMEPASS_IDS.SPEED_X2 or 0
	local speedOwned = false
	if speedGamepassId and speedGamepassId ~= 0 then
		local success, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, speedGamepassId)
		end)
		if success and owns then
			speedOwned = true
		end
	end
	if not speedOwned and speedLegacyId and speedLegacyId ~= 0 then
		local legacySuccess, legacyOwns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, speedLegacyId)
		end)
		if legacySuccess and legacyOwns then
			speedOwned = true
		end
	end
	if speedOwned then
		data.SpeedBoostMultiplier = 2
	end
	
	setupLeaderstats(player, data)
end)

Players.PlayerRemoving:Connect(function(player)
	DataHandler.SaveData(player)
	DataHandler.Clear(player)
end)

task.spawn(function()
	while true do
		task.wait(Config.AUTO_SAVE_INTERVAL or 60)
		for _, player in ipairs(Players:GetPlayers()) do
			DataHandler.SaveData(player)
		end
	end
end)

-- Update OrderedDataStore entries more frequently for live leaderboard accuracy
-- This ensures online players' current stats are reflected in the global leaderboard
task.spawn(function()
	while true do
		task.wait(20)
		for _, player in ipairs(Players:GetPlayers()) do
			DataHandler.UpdateOrderedStores(player)
		end
	end
end)
