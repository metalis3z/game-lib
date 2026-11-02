--!strict
-- CONFIG
local MAX_ADMIN_BANS_PER_USER = 10


-- LOCAL
local Moderation = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Players = game:GetService("Players")
local User = require(modules.Objects.User)
local sharedTypes = require(modules.References.sharedTypes)
local Bans = require(script.Bans)


-- TYPES
export type BanRecord = Bans.BanRecord

export type BanOptions = {
	callerUser: User.Class?,
	callerUserId: number?,
	scope: sharedTypes.ActionScope?,
	duration: number?, -- seconds, required for "expire" unless expiresAt is set
	expiresAt: number?, -- absolute epoch
	reason: string,
	banAlts: boolean?, -- false = HD record only, no Roblox IP ban
}

export type UnbanOptions = {
	callerUser: User.Class?,
	callerUserId: number?,
	scope: ("perm" | "server")?,
}


-- LOCAL FUNCTIONS
local function resolveCaller(options: any): (User.Class?, (number | string)?)
	if typeof(options) ~= "table" then return nil, nil end
	local callerUser = options.callerUser
	local callerUserId = options.callerUserId
	if not callerUser and callerUserId then
		callerUser = User.getUser(callerUserId, true)
	end
	if not callerUserId and callerUser then
		callerUserId = (callerUser :: any).userId
	end
	return callerUser, callerUserId
end

local function inputFromOptions(options: BanOptions, callerUserId: (number | string)?): any
	return {
		scope = options.scope or "perm",
		duration = options.duration,
		expiresAt = options.expiresAt,
		reason = options.reason,
		bannedBy = callerUserId or 0,
		banAlts = options.banAlts,
	}
end

local function writeInMemory(targetUserId: number, banId: string, banEntry: any): boolean
	local targetUser = User.getUserByUserId(targetUserId, true)
	if not targetUser then return false end
	(targetUser :: any).perm:set({"PermanentBans", banId}, banEntry)
	return true
end

local function ensureBanStoreUserAsync(): any?
	if not User.getUser("Bans", true) then
		User.new("Bans", "BanStore")
	end
	local ok, banUser = User.getUserAsync("Bans")
	return if ok then banUser else nil
end

local function countAdminBansForTarget(targetUserId: number): number
	local count = 0
	local function tally(entries: any)
		if typeof(entries) ~= "table" then return end
		for id, _ in entries :: any do
			-- Loader entries live alongside admin ones, so exclude them from the cap
			if typeof(id) == "string" and string.sub(id, 1, 7) ~= "loader_" then
				count += 1
			end
		end
	end
	local existingUser = User.getUserByUserId(targetUserId, true)
	if existingUser then
		tally((existingUser :: any).perm:get("PermanentBans"))
		return count
	end
	local banUser = ensureBanStoreUserAsync()
	if banUser then
		tally((banUser :: any).perm:get({tostring(targetUserId), "Bans"}))
	end
	return count
end

local function kickIfHere(targetUserId: number, banEntry: any, applyToUniverse: boolean)
	local player = Players:GetPlayerByUserId(targetUserId)
	if not player then return end
	local msg = Bans.formatKickMessage(banEntry, applyToUniverse)
	pcall(function() player:Kick(msg) end)
end


-- BAN FUNCTIONS
function Moderation.banAsync(targetUserId: number, options: BanOptions): (boolean, string?)
	if typeof(targetUserId) ~= "number" or targetUserId <= 0 then
		return false, "targetUserId must be a positive integer"
	end
	if typeof(options) ~= "table" then
		return false, "options must be a table"
	end
	local callerUser, callerUserId = resolveCaller(options)
	local scope = options.scope or "perm"
	if scope ~= "perm" and scope ~= "server" and scope ~= "expire" then
		return false, `Unknown scope '{tostring(scope)}'`
	end

	if callerUser or callerUserId then
		local Roles = require(modules.Parent.Services.Roles) :: any
		local callerRank: number
		if callerUser then
			callerRank = Roles.getRealTopRank(callerUser)
		else
			local rank, callerRankReliable = Roles.getEffectiveTopRankByUserIdAsync(callerUserId)
			if not callerRankReliable then
				return false, "Couldn't verify your rank right now (a group/gamepass lookup failed) - please try again"
			end
			callerRank = rank
		end
		local targetRank, rankReliable = Roles.getEffectiveTopRankByUserIdAsync(targetUserId)
		if not rankReliable then
			return false, "Couldn't verify the target's rank right now (a group/gamepass lookup failed) - please try again"
		end
		if callerRank <= targetRank then
			return false, `Cannot ban user {targetUserId} - their rank ({targetRank}) is at or above your own ({callerRank})`
		end
	end

	local record, recordErr = Bans.buildRecord(inputFromOptions(options, callerUserId), "admin")
	if not record then
		return false, recordErr
	end
	if scope == "server" then
		record.grantedOnJobId = if game.JobId == "" then "Studio" else game.JobId
	end

	if Bans.findActiveLoaderBan(targetUserId) then
		return false, "Target is already banned by a loader entry"
	end
	if countAdminBansForTarget(targetUserId) >= MAX_ADMIN_BANS_PER_USER then
		return false, `Target already has {MAX_ADMIN_BANS_PER_USER} bans on record. Please unban them first before adding another`
	end

	local banId = Bans.generateBanId()

	if scope == "server" then
		local wroteInMemory = writeInMemory(targetUserId, banId, record)
		if not wroteInMemory then
			return false, "Target is not loaded on this server"
		end
		kickIfHere(targetUserId, record, false)
		return true, banId
	end

	-- Perm and expire hit Roblox BanService FIRST when banAlts is on
	local applyToUniverse = true
	if record.banAlts then
		local duration = Bans.durationForBanAsync(record)
		-- Roblox has its own expiry row alongside DisplayReason
		local displayReason = Bans.formatKickMessage(record, applyToUniverse, true)
		local handlerOk, handlerErr = Bans.robloxBanAsync({
			targetUserId = targetUserId,
			duration = duration,
			displayReason = displayReason,
			privateReason = displayReason,
			excludeAlts = false,
			applyToUniverse = applyToUniverse,
		})
		if not handlerOk then
			return false, handlerErr
		end
	end

	-- Roblox accepted, so write via Permanent.applyAsync. If THIS fails
	-- after Roblox accepted, we attempt to roll back the Roblox ban so the two
	-- places where the user was banned don’t diverge
	local Permanent = require(modules.DataStores.Permanent)
	local getUserInfoAsync = require(modules.PlayerUtil.getUserInfoAsync)
	local extras: { { path: {string}, value: any } }? = nil
	local userInfoOk, userInfo = getUserInfoAsync(targetUserId)
	if userInfoOk and typeof(userInfo) == "table" then
		extras = {
			{ path = {tostring(targetUserId), "UserInfo"}, value = {
				userId = (userInfo :: any).userId,
				userName = (userInfo :: any).userName,
				userDisplayName = (userInfo :: any).userDisplayName,
			} },
		}
	end
	local permanentOk, permanentErr = Permanent.applyAsync({
		targetUserId = targetUserId,
		playerStorePath = {"PermanentBans", banId},
		globalStoreName = "BanStore",
		globalUserKey = "Bans",
		globalStorePath = {tostring(targetUserId), "Bans", banId},
		globalExtraWrites = extras,
		payload = record,
	})
	if not permanentOk then
		-- Roll back the Roblox ban if we made one so the two layers stay
		-- consistent
		if record.banAlts then
			local rollbackOk, rollbackErr = Bans.robloxUnbanAsync({
				targetUserId = targetUserId,
				applyToUniverse = applyToUniverse,
			})
			if not rollbackOk then
				warn(`[Moderation] PlayerStore write failed AND Roblox rollback failed for userId={targetUserId}. ` ..
					`Player is banned via Roblox but no HD record exists. Rollback error: {tostring(rollbackErr)}`)
			end
		end
		return false, `Ban could not be persisted: {tostring(permanentErr)}`
	end

	writeInMemory(targetUserId, banId, record)
	kickIfHere(targetUserId, record, applyToUniverse)

	return true, banId
end

function Moderation.unbanAsync(targetUserId: number, banId: string?, options: UnbanOptions?): (boolean, string?, number?)
	if typeof(targetUserId) ~= "number" or targetUserId <= 0 then
		return false, "targetUserId must be a positive integer"
	end
	options = options or {}
	local scope = (options :: any).scope or "perm"
	if scope ~= "perm" and scope ~= "server" then
		return false, `Unknown scope '{tostring(scope)}'`
	end

	local callerUser, callerUserId = resolveCaller(options)
	if callerUser or callerUserId then
		local Roles = require(modules.Parent.Services.Roles) :: any
		local callerRank: number
		if callerUser then
			callerRank = Roles.getRealTopRank(callerUser)
		else
			local rank, callerRankReliable = Roles.getEffectiveTopRankByUserIdAsync(callerUserId)
			if not callerRankReliable then
				return false, "Couldn't verify your rank right now (a group/gamepass lookup failed) - please try again"
			end
			callerRank = rank
		end
		local targetRank, rankReliable = Roles.getEffectiveTopRankByUserIdAsync(targetUserId)
		if not rankReliable then
			return false, "Couldn't verify the target's rank right now (a group/gamepass lookup failed) - please try again"
		end
		if callerRank <= targetRank then
			return false, `Cannot unban user {targetUserId}: their rank ({targetRank}) is at or above your own ({callerRank})`
		end
	end

	if banId and string.sub(banId, 1, 7) == "loader_" then
		return false, "Loader bans are immutable: edit Loader/Config/Bans.luau to remove"
	end

	if scope == "server" then
		local targetUser = User.getUserByUserId(targetUserId, true)
		if not targetUser then
			return true, nil, 0
		end
		local entries = (targetUser :: any).perm:get("PermanentBans")
		if typeof(entries) ~= "table" then
			return true, nil, 0
		end
		local cleared = 0
		for id, entry in entries :: any do
			if typeof(id) ~= "string" or typeof(entry) ~= "table" then continue end
			if banId and id ~= banId then continue end
			if (entry :: any).type ~= "server" then continue end
			(targetUser :: any).perm:set({"PermanentBans", id}, nil)
			cleared += 1
		end
		if banId and cleared == 0 then
			return false, "No server-scope ban with that banId on this server"
		end
		return true, nil, cleared
	end

	local Permanent = require(modules.DataStores.Permanent)
	local toRemove: { { id: string, entry: any } } = {}
	local function pushIfAdmin(id: any, entry: any)
		if typeof(id) ~= "string" or string.sub(id, 1, 7) == "loader_" then return end
		table.insert(toRemove, { id = id, entry = entry })
	end
	if banId then
		local entry: any = nil
		local existingUser = User.getUserByUserId(targetUserId, true)
		if existingUser then
			entry = (existingUser :: any).perm:get({"PermanentBans", banId})
		end
		if not entry then
			local banUser = ensureBanStoreUserAsync()
			if banUser then
				entry = (banUser :: any).perm:get({tostring(targetUserId), "Bans", banId})
			end
		end
		pushIfAdmin(banId, entry)
	else
		local existingUser = User.getUserByUserId(targetUserId, true)
		if existingUser then
			local entries = (existingUser :: any).perm:get("PermanentBans")
			if typeof(entries) == "table" then
				for id, entry in entries do
					pushIfAdmin(id, entry)
				end
			end
		end
		local targetLoadedOnline = existingUser ~= nil and (existingUser :: any).isLoaded == true
		if #toRemove == 0 and not targetLoadedOnline then
			local banUser = ensureBanStoreUserAsync()
			if banUser then
				local userEntry = (banUser :: any).perm:get({tostring(targetUserId), "Bans"})
				if typeof(userEntry) == "table" then
					for id, entry in userEntry do
						pushIfAdmin(id, entry)
					end
				end
			end
		end
	end

	local needsRobloxUnban = false
	for _, item in toRemove do
		if typeof(item.entry) == "table" and (item.entry :: any).banAlts == true then
			needsRobloxUnban = true
			break
		end
	end
	if needsRobloxUnban then
		local handlerOk, handlerErr = Bans.robloxUnbanAsync({
			targetUserId = targetUserId,
			applyToUniverse = true,
		})
		if not handlerOk then
			return false, handlerErr
		end
	end

	if #toRemove == 0 then
		return true, nil, 0
	end

	local banIdsToClear: {string} = {}
	for _, item in toRemove do
		table.insert(banIdsToClear, item.id)
	end

	for _, id in banIdsToClear do
		local removeOk, removeErr = Permanent.removeAsync({
			targetUserId = targetUserId,
			playerStorePath = {"PermanentBans", id},
			globalStoreName = "BanStore",
			globalUserKey = "Bans",
			globalStorePath = {tostring(targetUserId), "Bans", id},
			globalAfterWrite = function(banGlobalUser)
				local userIdStr = tostring(targetUserId)
				local entry = (banGlobalUser :: any).perm:get(userIdStr)
				if typeof(entry) ~= "table" then return end
				local remaining = (entry :: any).Bans
				if typeof(remaining) ~= "table" or next(remaining) == nil then
					(banGlobalUser :: any).perm:set({userIdStr, "UserInfo"}, nil)
				end
			end,
		})
		if not removeOk then
			return false, `Failed to remove ban {id}: {tostring(removeErr)}`
		end
	end

	return true, nil, #banIdsToClear
end

function Moderation.isBanned(userId: number, nowSeconds: number?): boolean
	if typeof(userId) ~= "number" or userId <= 0 then return false end
	local now = nowSeconds or os.time()
	if Bans.findActiveLoaderBan(userId, now) then return true end
	local user = User.getUserByUserId(userId, true)
	if user then
		local has, _, _ = Bans.findActiveAdminBan(user, now)
		if has then return true end
	end
	return false
end

function Moderation.getActiveBan(userId: number, nowSeconds: number?): (any?, string?, string?)
	if typeof(userId) ~= "number" or userId <= 0 then return nil, nil, nil end
	local now = nowSeconds or os.time()
	local user = User.getUserByUserId(userId, true)
	if user then
		local has, entry, banId = Bans.findActiveAdminBan(user, now)
		if has then return entry, banId, "admin" end
	end
	local loaderHas, loaderEntry, loaderBanId = Bans.findActiveLoaderBan(userId, now)
	if loaderHas then return loaderEntry, loaderBanId, "loader" end
	return nil, nil, nil
end

function Moderation.getActiveBanAsync(userId: number, nowSeconds: number?): (any?, string?, string?)
	local entry, banId, source = Moderation.getActiveBan(userId, nowSeconds)
	if entry then
		return entry, banId, source
	end
	local loadedUser = User.getUserByUserId(userId, true)
	if loadedUser and (loadedUser :: any).isLoaded then
		return nil, nil, nil
	end
	local banUser = ensureBanStoreUserAsync()
	if not banUser then
		return nil, nil, nil
	end
	local entries = (banUser :: any).perm:get({tostring(userId), "Bans"})
	local mirrorEntry, mirrorBanId = Bans.pickLatestActiveEntry(entries, nowSeconds)
	if mirrorEntry then
		return mirrorEntry, mirrorBanId, "admin"
	end
	return nil, nil, nil
end

Moderation.Bans = Bans


-- SETUP
require(script.Replication)
require(script.Remotes).setup(Moderation)


return Moderation
