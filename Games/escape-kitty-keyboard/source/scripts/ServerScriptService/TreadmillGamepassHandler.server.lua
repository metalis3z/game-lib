local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Config = require(ReplicatedStorage:FindFirstChild("Config"))
local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
local TreadmillAccessManager = require(ServerScriptService:FindFirstChild("TreadmillAccessManager"))

-- Treadmill gamepass mapping (new + legacy)
local TREADMILL_GAMEPASSES = {
	Gold = Config.GAMEPASS_IDS.GOLD_ACCESS,
	Diamond = Config.GAMEPASS_IDS.DIAMOND_ACCESS,
	Candy = Config.GAMEPASS_IDS.CANDY_ACCESS,
	Admin = Config.GAMEPASS_IDS.ADMIN_ACCESS,
}
local TREADMILL_LEGACY_GAMEPASSES = {
	Gold = Config.LEGACY_GAMEPASS_IDS.GOLD_ACCESS,
	Diamond = Config.LEGACY_GAMEPASS_IDS.DIAMOND_ACCESS,
	Candy = Config.LEGACY_GAMEPASS_IDS.CANDY_ACCESS,
	Admin = Config.LEGACY_GAMEPASS_IDS.ADMIN_ACCESS,
}

-- Display names for each treadmill
local TREADMILL_DISPLAY_NAMES = {
	Gold = "Gold Treadmill",
	Diamond = "Diamond Treadmill",
	Candy = "Candy Treadmill",
	Admin = "Admin Treadmill",
}

-- Debounce: track which players have been prompted for which treadmill
local promptedPlayers = {}

local function checkGamepassAccess(player)
	local accessFlags = {
		GoldTreadmillActive = false,
		DiamondTreadmillActive = false,
		CandyTreadmillActive = false,
		AdminTreadmillActive = false,
	}

	for treadmillType, gamepassId in pairs(TREADMILL_GAMEPASSES) do
		local success, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
		end)
		if success and owns then
			accessFlags[treadmillType .. "TreadmillActive"] = true
		end
		-- Also check legacy gamepass ID (old gamepass that some players already purchased)
		if not (success and owns) then
			local legacyId = TREADMILL_LEGACY_GAMEPASSES[treadmillType]
			if legacyId and legacyId > 0 then
				local legacySuccess, legacyOwns = pcall(function()
					return MarketplaceService:UserOwnsGamePassAsync(player.UserId, legacyId)
				end)
				if legacySuccess and legacyOwns then
					accessFlags[treadmillType .. "TreadmillActive"] = true
				end
			end
		end
		-- Also check admin-granted access from SetTreadmill command
		if TreadmillAccessManager.HasAccess(player.UserId, treadmillType) then
			accessFlags[treadmillType .. "TreadmillActive"] = true
		end
	end

	return accessFlags
end

local function sendAccessUpdate(player)
	local accessFlags = checkGamepassAccess(player)
	local remote = Remotes and Remotes:FindFirstChild("TreadmillAccessUpdate")
	if remote then
		remote:FireClient(player, accessFlags)
	end
end

local function onPlayerAdded(player)
	-- Initialize debounce table
	promptedPlayers[player.UserId] = {}

	-- Load permanent treadmill access from DataStore, then send access update
	task.spawn(function()
		TreadmillAccessManager.LoadPermanentAccess(player.UserId)
		task.wait(3)
		sendAccessUpdate(player)
	end)
end

local function onPlayerRemoving(player)
	promptedPlayers[player.UserId] = nil
end

-- Handle Prompt remotes from TreadmillSystem
local promptRemotes = {
	Gold = Remotes and Remotes:FindFirstChild("PromptGoldTreadmill"),
	Diamond = Remotes and Remotes:FindFirstChild("PromptDiamondTreadmill"),
	Candy = Remotes and Remotes:FindFirstChild("PromptCandyTreadmill"),
	Admin = Remotes and Remotes:FindFirstChild("PromptAdminTreadmill"),
}

for treadmillType, remote in pairs(promptRemotes) do
	if remote then
		remote.OnServerEvent:Connect(function(player)
			local userId = player.UserId
			if not promptedPlayers[userId] then
				promptedPlayers[userId] = {}
			end

			-- Debounce: only prompt once per treadmill entry
			if promptedPlayers[userId][treadmillType] then
				return
			end
			promptedPlayers[userId][treadmillType] = true

			-- Double-check if player actually owns the gamepass (new or legacy)
			local gamepassId = TREADMILL_GAMEPASSES[treadmillType]
			local legacyId = TREADMILL_LEGACY_GAMEPASSES[treadmillType]
			local success, owns = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
			end)
			local ownsLegacy = false
			if not (success and owns) and legacyId and legacyId > 0 then
				local legacySuccess, legacyResult = pcall(function()
					return MarketplaceService:UserOwnsGamePassAsync(player.UserId, legacyId)
				end)
				ownsLegacy = legacySuccess and legacyResult
			end

			if (success and owns) or ownsLegacy then
				-- Player owns it (new or legacy), send access update
				sendAccessUpdate(player)
				return
			end

			-- Also check admin-granted access (temporary or permanent)
			if TreadmillAccessManager.HasAccess(player.UserId, treadmillType) then
				sendAccessUpdate(player)
				return
			end

			-- Show buy panel to player
			local showRemote = Remotes and Remotes:FindFirstChild("ShowTreadmillBuyPanel")
			if showRemote then
				showRemote:FireClient(player, treadmillType, gamepassId, TREADMILL_DISPLAY_NAMES[treadmillType])
			end
		end)
	end
end

-- Handle TreadmillSignal to reset debounce when player leaves treadmill
local treadmillSignalRemote = Remotes and Remotes:FindFirstChild("TreadmillSignal")
if treadmillSignalRemote then
	treadmillSignalRemote.OnServerEvent:Connect(function(player, onTreadmill)
		if not onTreadmill and promptedPlayers[player.UserId] then
			promptedPlayers[player.UserId] = {}
		end
	end)
end

-- Handle recheck requests from client (after purchase)
local recheckRemote = Remotes and Remotes:FindFirstChild("RecheckTreadmillAccess")
if recheckRemote then
	recheckRemote.OnServerEvent:Connect(function(player)
		sendAccessUpdate(player)
		-- Reset prompt debounce so they can be prompted again if needed
		if promptedPlayers[player.UserId] then
			promptedPlayers[player.UserId] = {}
		end
	end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- Handle players already in game
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

print("[TreadmillGamepassHandler] Loaded with gamepass IDs:")
for k, v in pairs(TREADMILL_GAMEPASSES) do
	print("  " .. k .. ": " .. v)
end