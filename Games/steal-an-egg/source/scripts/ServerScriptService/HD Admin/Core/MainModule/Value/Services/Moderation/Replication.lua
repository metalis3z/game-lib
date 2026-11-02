--!strict

--[[

	This handles he replication of bans

--]]



-- LOCAL
local Replication = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local State = require(modules.Objects.State)
local fingerprintValue = require(modules.TableUtil.fingerprintValue)
local Bans = require(script.Parent.Bans)


-- TYPES
type BanRoster = {
	UserInfo: {
		userId: number,
		userName: string?,
		userDisplayName: string?,
		userImage: string?,
	},
	Bans: {[string]: any},
}


-- LOCAL FUNCTIONS
local function activeAdminBansFor(user: any, nowSeconds: number): {[string]: any}?
	local entries = user.perm:get("PermanentBans")
	if typeof(entries) ~= "table" then return nil end
	local out: {[string]: any} = {}
	local any = false
	for banId, entry in entries do
		if typeof(banId) ~= "string" or typeof(entry) ~= "table" then continue end
		local entryType = entry.type or "perm"
		if entryType == "expire" then
			local expiresAt = entry.expiresAt
			if typeof(expiresAt) ~= "number" or expiresAt <= nowSeconds then
				continue
			end
		end
		any = true
		out[banId] = entry
	end
	if not any then return nil end
	return out
end

local function buildServerEntry(player: Player, user: any, nowSeconds: number): BanRoster?
	local entries = activeAdminBansFor(user, nowSeconds)
	if not entries then return nil end
	return {
		UserInfo = {
			userId = player.UserId,
			userName = player.Name,
			userDisplayName = player.DisplayName,
			userImage = `rbxthumb://type=AvatarBust&id={player.UserId}&w=150&h=150`,
		},
		Bans = entries,
	}
end

local function refreshServerBans()
	local roster: {[string]: BanRoster} = {}
	local now = os.time()
	for _, player in Players:GetPlayers() do
		local user = User.getUser(player)
		if not user then continue end
		local entry = buildServerEntry(player, user, now)
		if entry then
			roster[tostring(player.UserId)] = entry
		end
	end
	User.everyone:set("ServerBans", roster)
end

local function refreshOneServerBan(player: Player)
	local user = User.getUser(player)
	if not user then return end
	local entry = buildServerEntry(player, user, os.time())
	User.everyone:set("ServerBans", tostring(player.UserId), entry)
end


-- JOIN KICK
local function findActiveBanFor(userId: number, user: any?): any?
	if user then
		local has, ban, _ = Bans.findActiveAdminBan(user)
		if has then return ban end
	end
	local loaderHas, loaderBan, _ = Bans.findActiveLoaderBan(userId)
	if loaderHas then return loaderBan end
	return nil
end

local function kick(player: Player, ban: any)
	local applyToUniverse = typeof(ban) == "table" and ban.type ~= "server"
	local msg = Bans.formatKickMessage(ban, applyToUniverse)
	pcall(function() player:Kick(msg) end)
end

local function onPlayerAdded(player: Player)
	local success, targetUser = User.getUserAsync(player)
	if not success or not targetUser then
		-- User load failed because they left or the datastore is down
		local loaderHas, loaderBan, _ = Bans.findActiveLoaderBan(player.UserId)
		if loaderHas and player.Parent then
			kick(player, loaderBan)
		end
		return
	end

	refreshOneServerBan(player)
	local ban = findActiveBanFor(player.UserId, targetUser)
	if ban and player.Parent then
		kick(player, ban)
		return
	end

	local janitor = (targetUser :: any).janitor
	if janitor then
		janitor:add((targetUser :: any).perm:onChange("PermanentBans", function()
			if player.Parent == nil then return end
			refreshOneServerBan(player)
			local current = findActiveBanFor(player.UserId, targetUser)
			if current then
				kick(player, current)
			end
		end))
	end
end


-- PERMANENT FEED
local permanentBansLoaded = false

local function buildPermanentEntry(record: any, nowSeconds: number): BanRoster?
	if typeof(record) ~= "table" then return nil end
	local userInfo = (record :: any).UserInfo
	local recordBans = (record :: any).Bans
	if typeof(userInfo) ~= "table" or typeof(recordBans) ~= "table" then return nil end
	local activeBans: {[string]: any} = {}
	local any = false
	for banId, entry in recordBans do
		if typeof(banId) ~= "string" or typeof(entry) ~= "table" then continue end
		local entryType = entry.type or "perm"
		if entryType == "expire" then
			local expiresAt = entry.expiresAt
			if typeof(expiresAt) ~= "number" or expiresAt <= nowSeconds then
				continue
			end
		end
		activeBans[banId] = entry
		any = true
	end
	if not any then return nil end
	local userId = tonumber((userInfo :: any).userId) or 0
	return {
		UserInfo = {
			userId = userId,
			userName = (userInfo :: any).userName or tostring(userId),
			userDisplayName = (userInfo :: any).userDisplayName or tostring(userId),
			userImage = `rbxthumb://type=AvatarBust&id={userId}&w=150&h=150`,
		},
		Bans = activeBans,
	}
end

local function mergeLoaderBans(roster: {[string]: BanRoster}, nowSeconds: number)
	local loaderBans = Bans.getLoaderBans()
	for userIdStr, ban in loaderBans do
		if ban.type == "expire" then
			local expiresAt = ban.expiresAt
			if typeof(expiresAt) ~= "number" or expiresAt <= nowSeconds then
				continue
			end
		end
		local userId = tonumber(userIdStr) or 0
		local banId = Bans.loaderBanIdFor(userId)
		local existing = roster[userIdStr]
		if existing then
			existing.Bans[banId] = ban
		else
			roster[userIdStr] = {
				UserInfo = {
					userId = userId,
					userName = tostring(userId),
					userDisplayName = tostring(userId),
					userImage = `rbxthumb://type=AvatarBust&id={userId}&w=150&h=150`,
				},
				Bans = { [banId] = ban },
			}
		end
	end
end

local hasSwept = false
local function sweepExpiredBans(banUser: any)
	if hasSwept then return end
	hasSwept = true
	task.spawn(function()
		local all = (banUser :: any).perm:getAll()
		if typeof(all) ~= "table" then return end
		local now = os.time()
		for userIdStr, record in all do
			if typeof(userIdStr) ~= "string" or typeof(record) ~= "table" then continue end
			local recordBans = (record :: any).Bans
			if typeof(recordBans) ~= "table" then continue end
			local cleared = 0
			for banId, entry in recordBans do
				if typeof(banId) ~= "string" then continue end
				if typeof(entry) ~= "table" then
					cleared += 1
					(banUser :: any).perm:set({userIdStr, "Bans", banId}, nil)
					continue
				end
				local entryType = entry.type or "perm"
				if entryType == "expire" then
					local expiresAt = entry.expiresAt
					if typeof(expiresAt) ~= "number" or expiresAt <= now then
						(banUser :: any).perm:set({userIdStr, "Bans", banId}, nil)
						cleared += 1
					end
				end
			end
			if cleared == 0 then continue end
			-- If every ban cleared, drop UserInfo too so the roster doesn't
			-- show a ghost entry with zero bans
			local remaining = (banUser :: any).perm:get({userIdStr, "Bans"})
			if typeof(remaining) ~= "table" or next(remaining) == nil then
				(banUser :: any).perm:set({userIdStr}, nil)
			end
		end
	end)
end


-- PUBLIC
function Replication.update()
	refreshServerBans()
end

function Replication.updatePermanent()
	if permanentBansLoaded then return end
	permanentBansLoaded = true
	task.spawn(function()
		if not User.getUser("Bans", true) then
			User.new("Bans", "BanStore")
		end
		local ok, banUser = User.getUserAsync("Bans")
		if not ok or not banUser then
			-- Retry on the next first-fetch
			permanentBansLoaded = false
			return
		end

		-- Publish per entry rather than re-setting the whole roster
		local lastPublished: {[string]: string} = {}
		local function rebuild()
			local roster: {[string]: BanRoster} = {}
			local now = os.time()
			local all = (banUser :: any).perm:getAll()
			if typeof(all) == "table" then
				for userIdStr, record in all do
					if typeof(userIdStr) ~= "string" then continue end
					local entry = buildPermanentEntry(record, now)
					if entry then
						roster[userIdStr] = entry
					end
				end
			end
			-- Merge loader AFTER admin so admin's real names win over the
			-- loader's userId-as-name
			mergeLoaderBans(roster, now)
			local nextPublished: {[string]: string} = {}
			for userIdStr, entry in roster do
				local fingerprint = fingerprintValue(entry)
				nextPublished[userIdStr] = fingerprint
				if lastPublished[userIdStr] ~= fingerprint then
					User.everyone:set("PermanentBans", userIdStr, entry)
				end
			end
			for userIdStr in lastPublished do
				if nextPublished[userIdStr] == nil then
					User.everyone:set("PermanentBans", userIdStr, nil)
				end
			end
			lastPublished = nextPublished
		end

		local rebuildQueued = false
		local function queueRebuild()
			if rebuildQueued then return end
			rebuildQueued = true
			task.defer(function()
				rebuildQueued = false
				rebuild()
			end)
		end

		rebuild()
		local janitor = (banUser :: any).janitor
		if janitor then
			janitor:add((banUser :: any).perm:onAnyChange(queueRebuild))
		end

		sweepExpiredBans(banUser)
	end)
end

function Replication._resetForTesting()
	hasSwept = false
	permanentBansLoaded = false
end


-- SETUP
local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)

User.everyone:verify(getStateVerifier("ServerBans", "Exclude", {}, nil, "Bans"))
User.everyone:verify(getStateVerifier("PermanentBans", "Exclude", {}, nil, "Bans"))

User.everyone:set("ServerBans", {})
User.everyone:set("PermanentBans", {})

State.verifyFirstFetch("ServerBans", Replication.update)
State.verifyFirstFetch("PermanentBans", Replication.updatePermanent)

Players.PlayerAdded:Connect(function(player)
	task.spawn(onPlayerAdded, player)
end)
Players.PlayerRemoving:Connect(function(player)
	User.everyone:set("ServerBans", tostring(player.UserId), nil)
end)
for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end


return Replication
