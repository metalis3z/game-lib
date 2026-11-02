--[[
	AdminPermissions  (ModuleScript, server only)

	Works out a player's admin level from things YOU control, never from a list someone else
	shipped with a leaked game:
	  * the experience owner (game.CreatorId, or rank 255 in the owning group) -> Owner
	  * your group's ranks (MinRank per level)
	  * an explicit UserId list you fill in yourself
	  * optional: the private-server owner gets a limited level inside their own server
	  * Studio play-tests get Owner so you can test commands

	The level is cached per player and also written to a "AdminLevel" attribute (server-set
	attributes cannot be changed by the client, so UI can read it safely; the server still
	re-checks on every command).

	Credit: forsaken CommandManager / PlayerManager (group rank -> rank attribute, private server
	owner allowed for VIP-safe commands, creator-only extra tier), aura-ascension AdminService
	(UserIds + GroupId/MinimumGroupRank), evade ConsolePermissions (user ids OR group rank),
	catalogue-avatar-creator (IsAdministrator attribute set on join, creator check).

	Usage (server):
		local AdminPermissions = require(script.Parent.AdminPermissions)
		AdminPermissions.Configure({
			GroupId = 0,            -- your group id, or 0 / nil if the game is not group-owned
			GroupRanks = { Moderator = 100, Admin = 200 },   -- min group rank for each level
			UserIds = { [123456789] = "Admin" },              -- YOUR ids only
			PrivateServerOwnerLevel = "VIP",                  -- or nil to disable
		})
		if AdminPermissions.Has(player, "Moderator") then ... end
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local AdminPermissions = {}

-- Higher number = more power. Add your own levels here.
AdminPermissions.Levels = {
	Player = 0,
	VIP = 10, -- private server owner in their own server
	Moderator = 50,
	Admin = 100,
	Owner = 1000,
}

local config = {
	GroupId = nil,
	GroupRanks = {},
	UserIds = {},
	PrivateServerOwnerLevel = nil,
	StudioIsOwner = true,
}
local cache = {} -- [player] = levelName

local function levelValue(name)
	return AdminPermissions.Levels[name] or 0
end

local function best(a, b)
	return if levelValue(b) > levelValue(a) then b else a
end

function AdminPermissions.Configure(options)
	for key, value in pairs(options) do
		config[key] = value
	end
	table.clear(cache)
end

local function resolve(player)
	if config.StudioIsOwner and RunService:IsStudio() then
		return "Owner"
	end

	local level = "Player"

	if game.CreatorType == Enum.CreatorType.User and player.UserId == game.CreatorId then
		return "Owner"
	end

	local groupId = config.GroupId
	if (not groupId or groupId == 0) and game.CreatorType == Enum.CreatorType.Group then
		groupId = game.CreatorId
	end
	if groupId and groupId ~= 0 then
		local ok, rank = pcall(player.GetRankInGroup, player, groupId)
		if ok then
			if rank == 255 and groupId == game.CreatorId then
				return "Owner"
			end
			for name, minRank in pairs(config.GroupRanks) do
				if rank >= minRank then
					level = best(level, name)
				end
			end
		end
	end

	local listed = config.UserIds[player.UserId]
	if listed then
		level = best(level, listed)
	end

	if config.PrivateServerOwnerLevel and game.PrivateServerId ~= "" and game.PrivateServerOwnerId == player.UserId then
		level = best(level, config.PrivateServerOwnerLevel)
	end

	return level
end

function AdminPermissions.GetLevel(player)
	local level = cache[player]
	if not level then
		level = resolve(player)
		cache[player] = level
		player:SetAttribute("AdminLevel", level)
	end
	return level
end

-- True when the player is at least `required` (a level name).
function AdminPermissions.Has(player, required)
	return levelValue(AdminPermissions.GetLevel(player)) >= levelValue(required)
end

-- Call after changing a player's group rank in-game, or on a timer if you want.
function AdminPermissions.Refresh(player)
	cache[player] = nil
	return AdminPermissions.GetLevel(player)
end

Players.PlayerAdded:Connect(AdminPermissions.GetLevel)
Players.PlayerRemoving:Connect(function(player)
	cache[player] = nil
end)

return AdminPermissions
