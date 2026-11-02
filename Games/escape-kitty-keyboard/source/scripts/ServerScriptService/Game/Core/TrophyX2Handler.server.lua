local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage:WaitForChild("Config"))
local DataHandler = require(game.ServerScriptService.DataService.DataHandler)
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

local GAMEPASS_ID = Config.GAMEPASS_IDS.TROPHY_X2
local LEGACY_GAMEPASS_ID = Config.LEGACY_GAMEPASS_IDS and Config.LEGACY_GAMEPASS_IDS.TROPHY_X2 or 0

-- Find the ProximityPrompt on the Trophyx2 model
local function findProximityPrompt()
	local model = workspace:FindFirstChild("Structure")
	if not model then return nil end
	model = model:FindFirstChild("Stage0_HUB")
	if not model then return nil end
	model = model:FindFirstChild("Trophyx2")
	if not model then return nil end
	return model:FindFirstChildWhichIsA("ProximityPrompt", true)
end

-- Check if player owns the gamepass (new or legacy) and apply multiplier
local function checkTrophyGamepass(player)
	local data = DataHandler.Get(player)
	if not data then return end

	local success, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
	end)
	local trophyOwned = success and owns

	-- Also check legacy gamepass ID
	if not trophyOwned and LEGACY_GAMEPASS_ID and LEGACY_GAMEPASS_ID ~= 0 then
		local legacySuccess, legacyOwns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, LEGACY_GAMEPASS_ID)
		end)
		trophyOwned = legacySuccess and legacyOwns
	end

	if trophyOwned then
		data.WinsMultiplier = 2
	else
		data.WinsMultiplier = 1
	end
end

-- Handle ProximityPrompt trigger
local prompt = findProximityPrompt()
if prompt then
	prompt.Triggered:Connect(function(player)
		-- Check if player already owns the gamepass (new or legacy)
		local success, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
		end)
		local trophyOwned = success and owns

		if not trophyOwned and LEGACY_GAMEPASS_ID and LEGACY_GAMEPASS_ID ~= 0 then
			local legacySuccess, legacyOwns = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, LEGACY_GAMEPASS_ID)
			end)
			trophyOwned = legacySuccess and legacyOwns
		end

		if trophyOwned then
			-- Already owns it (new or legacy), ensure multiplier is applied
			checkTrophyGamepass(player)
			return
		end

		-- Prompt gamepass purchase (new gamepass)
		MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
	end)
else
	warn("[TrophyX2Handler] ProximityPrompt not found on Trophyx2 model")
end

-- Handle gamepass purchase completion
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, wasPurchased)
	if gamepassId ~= GAMEPASS_ID then return end
	if not wasPurchased then return end

	-- Apply the multiplier
	local data = DataHandler.Get(player)
	if not data then return end
	data.WinsMultiplier = 2

	-- Notify client
	UpdateUI:FireClient(player, {WinsMultiplier = 2})
end)

-- Check gamepass on player join
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.delay(2, function()
			checkTrophyGamepass(player)
		end)
	end)
end)

-- Handle players already in game
for _, player in Players:GetPlayers() do
	checkTrophyGamepass(player)
end

print("[TrophyX2Handler] Loaded with gamepass ID:", GAMEPASS_ID)