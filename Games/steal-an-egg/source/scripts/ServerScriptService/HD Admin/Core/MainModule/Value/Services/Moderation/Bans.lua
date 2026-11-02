--!strict

-- CONFIG
local BAN_ID_LENGTH = 16
local MAX_REASON_LENGTH = 400
local PERMANENT_DURATION = -1


-- LOCAL
local Bans = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local hdConfig = script:FindFirstAncestor("HD Admin").Config
local generateUID = require(modules.DataUtil.generateUID)
local isNumberSafe = require(modules.VerifyUtil.isNumberSafe)


-- TYPES
export type BanRecord = {
	type: "perm" | "expire" | "server",
	source: "admin" | "loader",
	bannedBy: number | string,
	bannedAt: number,
	expiresAt: number?,
	grantedOnJobId: string?,
	reason: string,
	banAlts: boolean,
}

export type LoaderEntry = {
	reason: string,
	type: ("perm" | "expire")?,
	bannedBy: (number | string)?,
	bannedAt: number?,
	expiresAt: number?,
}

export type BanInput = {
	reason: string,
	scope: ("perm" | "server" | "expire")?,
	bannedBy: (number | string)?,
	bannedAt: number?,
	duration: number?,
	expiresAt: number?,
	banAlts: boolean?,
}

export type RobloxBanRequest = {
	targetUserId: number,
	duration: number,
	displayReason: string,
	privateReason: string,
	excludeAlts: boolean,
	applyToUniverse: boolean,
}

export type RobloxUnbanRequest = {
	targetUserId: number,
	applyToUniverse: boolean,
}


-- CONSTANTS
Bans.PERMANENT_DURATION = PERMANENT_DURATION


-- LOCAL FUNCTIONS
local function sanitiseReason(raw: any): string
	if typeof(raw) ~= "string" then return "" end
	local cleaned = (raw :: string):gsub("[%c]", " ")
	if #cleaned > MAX_REASON_LENGTH then
		cleaned = string.sub(cleaned, 1, MAX_REASON_LENGTH)
	end
	return cleaned
end

local function trimReason(raw: string): string
	if #raw <= MAX_REASON_LENGTH then return raw end
	return string.sub(raw, 1, MAX_REASON_LENGTH)
end

local function normaliseRobloxError(rawError: any, targetUserId: number?): string
	local msg = tostring(rawError)
	-- Roblox rate-limits BanService to a handful of calls per user per
	-- universe each minute. IP bans hit this fast when stacking, so we name the
	-- user and point at the fix instead of recording the raw 429 error
	if msg:find("429") or msg:find("RESOURCE_EXHAUSTED") or msg:lower():find("too many requests") then
		local who = if typeof(targetUserId) == "number" then `UserId {targetUserId}` else "this user"
		return `Too many Roblox-ban requests for {who}. Please retry in a few seconds, or toggle off 'IP Ban'`
	end
	if msg:find("inappropriate") then
		return "Inappropriate ban reason. Please edit and retry"
	end
	if msg:find("403") or msg:find("forbidden") then
		return "Roblox rejected the ban (permissions or quota). Please retry shortly"
	end
	if msg:find("API Services") or msg:find("api services") then
		return "Publish the experience to use Roblox BanService"
	end
	return msg
end

local function isEntryActive(entry: any, nowSeconds: number): boolean
	if typeof(entry) ~= "table" then return false end
	local entryType = entry.type or "perm"
	if entryType == "server" then
		return true
	elseif entryType == "expire" then
		local expiresAt = entry.expiresAt
		if typeof(expiresAt) ~= "number" then return false end
		return expiresAt > nowSeconds
	end
	return true
end

-- We can't pick the player's timezone server-side without invoking locally, so easy just to use UTC
local MONTH_NAMES = {
	"January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December",
}
local function formatExpiry(expiresAt: number?): string
	if typeof(expiresAt) ~= "number" or expiresAt <= 0 then
		return "Never"
	end
	local date = os.date("!*t", expiresAt) :: any
	local monthName = MONTH_NAMES[date.month] or tostring(date.month)
	return string.format("%02d:%02d, %d %s %d (UTC)",
		date.hour, date.min, date.day, monthName, date.year)
end


-- BAN RECORD FUNCTIONS
function Bans.buildRecord(input: BanInput | LoaderEntry, source: "admin" | "loader"): (BanRecord?, string?)
	if typeof(input) ~= "table" then
		return nil, "input must be a table"
	end
	local banInput: any = input
	local reason = sanitiseReason(banInput.reason)
	if reason == "" then
		return nil, "reason must be a non-empty string"
	end

	local resolvedType: "perm" | "expire" | "server"
	local hint = banInput.type or banInput.scope
	if hint == "perm" or hint == "expire" or hint == "server" then
		resolvedType = hint
	elseif typeof(banInput.expiresAt) == "number" or (typeof(banInput.duration) == "number" and banInput.duration > 0) then
		resolvedType = "expire"
	else
		resolvedType = "perm"
	end
	if source == "loader" and resolvedType == "server" then
		return nil, "loader bans can't use scope=server"
	end

	-- isNumberSafe rejects NaN and +-inf, so a math.huge duration/expiresAt can't
	-- break our datastores with a non-finite expiresAt
	local expiresAt: number? = nil
	if resolvedType == "expire" then
		if typeof(banInput.expiresAt) == "number" and isNumberSafe(banInput.expiresAt) and banInput.expiresAt > 0 then
			expiresAt = banInput.expiresAt
		elseif typeof(banInput.duration) == "number" and isNumberSafe(banInput.duration) and banInput.duration > 0 then
			expiresAt = os.time() + banInput.duration
		else
			return nil, "expire scope requires a valid finite duration or expiresAt"
		end
	end

	local resolvedBanAlts: boolean
	if source == "loader" then
		resolvedBanAlts = false
	elseif banInput.banAlts == nil then
		resolvedBanAlts = true
	else
		resolvedBanAlts = banInput.banAlts == true
	end
	if resolvedType == "server" then
		resolvedBanAlts = false
	end

	local record: BanRecord = {
		type = resolvedType,
		source = source,
		bannedBy = if typeof(banInput.bannedBy) == "number" or typeof(banInput.bannedBy) == "string" then banInput.bannedBy else 0,
		bannedAt = if typeof(banInput.bannedAt) == "number" then banInput.bannedAt else os.time(),
		expiresAt = expiresAt,
		grantedOnJobId = nil,
		reason = reason,
		banAlts = resolvedBanAlts,
	}
	if source == "loader" then
		if typeof(banInput.bannedBy) ~= "number" and typeof(banInput.bannedBy) ~= "string" then
			record.bannedBy = 0
		end
		if typeof(banInput.bannedAt) ~= "number" then
			record.bannedAt = 0
		end
	end
	return record, nil
end

function Bans.generateBanId(): string
	return generateUID(BAN_ID_LENGTH, "LettersAndNumbers"):upper()
end

function Bans.loaderBanIdFor(userId: number | string): string
	return `loader_{tostring(userId)}`
end

function Bans.findActiveAdminBan(user: any, nowSeconds: number?): (boolean, any?, string?)
	if not user then return false, nil, nil end
	local now = nowSeconds or os.time()
	local entries = user.perm:get("PermanentBans")
	if typeof(entries) ~= "table" then return false, nil, nil end
	for banId, entry in entries do
		if isEntryActive(entry, now) then
			return true, entry, banId
		end
	end
	return false, nil, nil
end

function Bans.pickLatestActiveEntry(entries: any, nowSeconds: number?): (any?, string?)
	if typeof(entries) ~= "table" then return nil, nil end
	local now = nowSeconds or os.time()
	local bestEntry: any = nil
	local bestId: string? = nil
	local bestBannedAt: number = -math.huge
	for banId, entry in entries do
		if not isEntryActive(entry, now) then continue end
		local ts = if typeof(entry) == "table" and typeof(entry.bannedAt) == "number"
			then entry.bannedAt
			else 0
		if ts > bestBannedAt then
			bestEntry = entry
			bestId = banId
			bestBannedAt = ts
		end
	end
	return bestEntry, bestId
end

function Bans.findLatestActiveAdminBan(user: any, nowSeconds: number?): (boolean, any?, string?)
	if not user then return false, nil, nil end
	local entries = user.perm:get("PermanentBans")
	local entry, banId = Bans.pickLatestActiveEntry(entries, nowSeconds)
	if entry then return true, entry, banId end
	return false, nil, nil
end

function Bans.findActiveLoaderBan(userId: number, nowSeconds: number?): (boolean, BanRecord?, string?)
	local now = nowSeconds or os.time()
	local record = Bans.getLoaderBans()[tostring(userId)]
	if record and isEntryActive(record, now) then
		return true, record, Bans.loaderBanIdFor(userId)
	end
	return false, nil, nil
end


-- LOADER HYDRATION
local cachedLoaderBans: {[string]: BanRecord}? = nil

function Bans.getLoaderBans(): {[string]: BanRecord}
	if cachedLoaderBans then return cachedLoaderBans end
	local result: {[string]: BanRecord} = {}
	local bansModule = hdConfig:FindFirstChild("Bans")
	if not bansModule or not bansModule:IsA("ModuleScript") then
		cachedLoaderBans = result
		return result
	end
	local ok, rawEntries = pcall(require, bansModule)
	if not ok or typeof(rawEntries) ~= "table" then
		warn(`[Moderation] Loader/Config/Bans.luau failed to load: {tostring(rawEntries)}`)
		cachedLoaderBans = result
		return result
	end
	for rawUserId, rawEntry in rawEntries :: any do
		local userId = tonumber(rawUserId)
		if not userId or userId <= 0 then
			warn(`[Moderation] Loader ban key {tostring(rawUserId)} is not a positive userId - skipped`)
			continue
		end
		local key = tostring(userId)
		if result[key] then
			warn(`[Moderation] Loader ban for userId {userId} appears twice - using the first entry`)
			continue
		end
		local record, err = Bans.buildRecord(rawEntry :: LoaderEntry, "loader")
		if not record then
			warn(`[Moderation] Loader ban for userId {userId} is invalid: {err} - skipped`)
			continue
		end
		result[key] = record
	end
	cachedLoaderBans = result
	return result
end

function Bans.resetLoaderCache()
	cachedLoaderBans = nil
end


-- ROBLOX BANSERVICE WRAPPER
function Bans.robloxBanAsync(req: RobloxBanRequest): (boolean, string?)
	if typeof(req) ~= "table" then return false, "request must be a table" end
	if typeof(req.targetUserId) ~= "number" or req.targetUserId <= 0 then
		return false, "targetUserId must be a positive integer"
	end
	if RunService:IsStudio() then
		return true, nil
	end
	local config = {
		UserIds = { req.targetUserId },
		Duration = if req.duration == PERMANENT_DURATION or req.duration <= 0
			then PERMANENT_DURATION
			else math.floor(req.duration),
		DisplayReason = trimReason(req.displayReason),
		PrivateReason = trimReason(req.privateReason),
		ExcludeAltAccounts = req.excludeAlts == true,
		ApplyToUniverse = req.applyToUniverse == true,
	}
	local ok, err = pcall(function()
		return (Players :: any):BanAsync(config)
	end)
	if not ok then
		return false, normaliseRobloxError(err, req.targetUserId)
	end
	return true, nil
end

function Bans.robloxUnbanAsync(req: RobloxUnbanRequest): (boolean, string?)
	if typeof(req) ~= "table" then return false, "request must be a table" end
	if typeof(req.targetUserId) ~= "number" or req.targetUserId <= 0 then
		return false, "targetUserId must be a positive integer"
	end
	if RunService:IsStudio() then
		return true, nil
	end
	local config = {
		UserIds = { req.targetUserId },
		ApplyToUniverse = req.applyToUniverse == true,
	}
	local ok, err = pcall(function()
		return (Players :: any):UnbanAsync(config)
	end)
	if not ok then
		return false, normaliseRobloxError(err, req.targetUserId)
	end
	return true, nil
end


-- KICK MESSAGE
function Bans.formatKickMessage(record: any, applyToUniverse: boolean?, omitExpiry: boolean?): string
	if typeof(record) ~= "table" then
		return "You have been banned"
	end
	local scopeLabel = if applyToUniverse == false then "this server" else "all servers"
	local reason = record.reason
	if typeof(reason) ~= "string" or reason == "" then
		reason = "No reason given"
	end
	local banRow = `🚫 You're banned from {scopeLabel}  🚫`
	local reasonRow = `💬 Reason: '{reason}'`
	if omitExpiry then
		return `\n{banRow}\n\n{reasonRow}\n`
	end
	local expireRow = `⌛ Expires: {formatExpiry(record.expiresAt)}`
	return `\n{banRow}\n\n{expireRow}\n\n{reasonRow}\n`
end

function Bans.durationForBanAsync(record: any): number
	if typeof(record) ~= "table" then return PERMANENT_DURATION end
	if record.type ~= "expire" then return PERMANENT_DURATION end
	local expiresAt = record.expiresAt
	if typeof(expiresAt) ~= "number" then return PERMANENT_DURATION end
	local remaining = expiresAt - os.time()
	if remaining <= 0 then return PERMANENT_DURATION end
	return math.floor(remaining)
end


return Bans
