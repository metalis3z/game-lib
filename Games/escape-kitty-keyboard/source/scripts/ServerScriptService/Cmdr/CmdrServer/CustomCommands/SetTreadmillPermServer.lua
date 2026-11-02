local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local TreadmillAccessManager = require(ServerScriptService:WaitForChild("TreadmillAccessManager"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local TreadmillAccessUpdate = Remotes:WaitForChild("TreadmillAccessUpdate")

local TREADMILL_GAMEPASSES = {
	Gold = Config.GAMEPASS_IDS.GOLD_ACCESS,
	Diamond = Config.GAMEPASS_IDS.DIAMOND_ACCESS,
	Candy = Config.GAMEPASS_IDS.CANDY_ACCESS,
	Admin = Config.GAMEPASS_IDS.ADMIN_ACCESS,
}

local VALID_TYPES = {
	gold = "Gold",
	diamond = "Diamond",
	candy = "Candy",
	admin = "Admin",
}

-- Get combined access flags (gamepass + admin-granted temporary + permanent)
local function getCombinedAccess(player)
	local flags = {
		GoldTreadmillActive = false,
		DiamondTreadmillActive = false,
		CandyTreadmillActive = false,
		KittyTreadmillActive = false,
		FranceTreadmillActive = false,
		AdminTreadmillActive = false,
	}

	for treadmillType, gamepassId in pairs(TREADMILL_GAMEPASSES) do
		-- Check gamepass ownership
		local success, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
		end)
		if success and owns then
			flags[treadmillType .. "TreadmillActive"] = true
		end
		-- Check admin-granted access (temporary AND permanent)
		if TreadmillAccessManager.HasAccess(player.UserId, treadmillType) then
			flags[treadmillType .. "TreadmillActive"] = true
		end
	end

	return flags
end

return function(context, target, treadmillType)
	local typeLower = string.lower(treadmillType)

	if typeLower == "remove" or typeLower == "reset" or typeLower == "none" then
		TreadmillAccessManager.RevokeAllPermanent(target.UserId)
		local flags = getCombinedAccess(target)
		TreadmillAccessUpdate:FireClient(target, flags)
		return string.format("Revoked all PERMANENT treadmill access from %s.", target.Name)
	end

	local mappedType = VALID_TYPES[typeLower]
	if not mappedType then
		return "Invalid treadmill type. Use: gold, diamond, candy, admin, or remove."
	end

	TreadmillAccessManager.GrantPermanent(target.UserId, mappedType)
	local flags = getCombinedAccess(target)
	TreadmillAccessUpdate:FireClient(target, flags)

	return string.format("Granted PERMANENT %s Treadmill access to %s.", mappedType, target.Name)
end