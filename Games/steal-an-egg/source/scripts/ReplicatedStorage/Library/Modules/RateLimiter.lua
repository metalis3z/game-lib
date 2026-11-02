-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Asserts = require(game.ReplicatedStorage.Library.Asserts)
local DebugGetCallerName = require(game.ReplicatedStorage.Library.Functions.DebugGetCallerName)
local v1 = require(game.ReplicatedStorage.Library.Modules.Packages.Log).new():AtWarning():Wrap()
local t = {
	DefaultBanLength = 60,
	DefaultWarn = true,
	Message = {
		STANDARD_ERROR = "You\'re doing that too fast!",
		TEMP_BANNED = "You\'re on cooldown. Please try again later.",
		GARBAGE_COLLECTED = "Endpoint not permitted."
	},
	LogTemplates = {
		BAN = "[RATE LIMIT][%*] (%*): %*, %*: (%*)"
	}
}
local t2 = {}

local function loadEndpoint(p1, p2) --[[ loadEndpoint | Line: 103 ]]
	assert(p2.MaximumTokens, "MaximumTokens must be provided")

	if p2.InitialTokens then
		assert(p2.InitialTokens <= p2.MaximumTokens, "InitialTokens must be less than or equal to MaximumTokens")
	end

	local t = {}

	if p2.Refresh then
		for i, v in ipairs(p2.Refresh) do
			assert(if v.Tokens > 0 then true else false, "Tokens must be greater than 0")
			assert(if v.Interval > 0 then true else false, "Interval must be greater than 0")
			table.insert(t, {
				tokens = v.Tokens,
				interval = v.Interval
			})
		end
	end

	table.freeze(t)

	local t2 = {
		timestamps = {},
		tokens = {},
		refresh = {},
		refreshConfig = t
	}

	t2.initialTokens = p2.InitialTokens or p2.MaximumTokens
	t2.maxTokens = p2.MaximumTokens
	t2.causesBan = if p2.Ban == true then true else false
	t2.name = p1

	return t2
end

local function tryEndpoint(p1, p2, p3) --[[ tryEndpoint | Line: 137 ]]
	local v1 = workspace:GetServerTimeNow()

	if not p3.timestamps[p2] then
		p3.timestamps[p2] = v1
	end

	if not p3.tokens[p2] then
		p3.tokens[p2] = p3.initialTokens
	end

	if not p3.refresh[p2] then
		local t = {}

		for i, v in ipairs(p3.refreshConfig) do
			table.insert(t, {
				credit = 0,
				tokens = v.tokens,
				interval = v.interval
			})
		end

		p3.refresh[p2] = t
	end

	local v2 = p3.refresh[p2]
	local v3 = p3.tokens[p2]
	local v5 = math.max(v1 - p3.timestamps[p2], 0)
	local sum = 0

	if p3.refresh then
		for i, v in ipairs(v2) do
			local v8 = math.min(v.credit + v5, p3.maxTokens / (v.tokens / v.interval))
			local v10 = math.floor(v8 / v.interval)

			if v10 <= 0 then
				v.credit = v8

				continue
			end

			sum = sum + v10 * v.tokens
			v.credit = math.fmod(v8, v10 * v.interval)
		end
	end

	local v12 = if v3 + sum >= 1 then true else false
	local v13 = math.min(v3 + sum, p3.maxTokens)

	p3.tokens[p2] = math.clamp(if v12 then v13 - 1 else v13, -1, p3.maxTokens)
	p3.timestamps[p2] = v1

	if v12 then
		return true
	end

	if v12 and p1._warn then
		warn(string.format(p1._logTemplate, "ENDPOINT_EXHAUSTED", p2.Name, p2.UserId, p3.name))
	end

	if not p3.causesBan then
		return false
	end

	p1:ApplyBan(p2)

	return false
end

local function track(p1, p2) --[[ track | Line: 206 ]]
	if p1._tracked[p2] then
		return
	end

	p1._tracked[p2] = true
	p2.Destroying:Connect(function() --[[ Line: 209 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:Reset(p2)
		p1._tracked[p2] = nil
	end)
end

local function ensureEndpoint(p1, p2) --[[ ensureEndpoint | Line: 216 | Upvalues: Asserts (copy) ]]
	Asserts.optional.string(p2)

	if not p2 then
		return
	end

	local v1 = p1._endpoints[p2] and (if p2 == "Global" then false else true)

	assert(v1, string.format("Endpoint \'%s\' was provided but does not exist", p2))
end

function t2.ApplyBan(p1, p2, p3) --[[ ApplyBan | Line: 229 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.Player(p2)
	Asserts.optional.number(p3)

	local v12 = if p3 then p3 else p1._banLength
	local v2 = if p1._bans[p2] == nil then false else true
	local v3 = workspace:GetServerTimeNow() + v12

	if v2 then
		v3 = math.max(v3, p1._bans[p2])
	end

	p1._bans[p2] = v3

	if p1._warn and not v2 then
		v1(string.format(p1._logTemplate, "BAN", p2.Name, p2.UserId, "Banned!"))
	end
end
function t2.RemoveBan(p1, p2) --[[ RemoveBan | Line: 249 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.Player(p2)

	if p1._bans[p2] then
		p1._bans[p2] = nil

		return true
	end

	return false, v1(string.format(p1._logTemplate, "BAN", p2.Name, p2.UserId, "Attempt to unban a never banned player!"))
end
function t2.IsBanned(p1, p2) --[[ IsBanned | Line: 269 | Upvalues: Asserts (copy) ]]
	Asserts.Player(p2)

	if not p1._bans[p2] then
		return false
	end

	if p1._bans[p2] < workspace:GetServerTimeNow() then
		p1._bans[p2] = nil

		return false
	end

	return true
end
function t2.Reset(p1, p2) --[[ Reset | Line: 284 ]]
	for i, v in ipairs(p2 and { p2 } or game.Players:GetPlayers()) do
		p1._bans[v] = nil

		for k, v2 in pairs(p1._endpoints) do
			v2.timestamps[v] = nil
			v2.tokens[v] = nil
			v2.refresh[v] = nil
		end
	end
end
function t2.Limit(p1, p2, p3) --[[ Limit | Line: 297 | Upvalues: Asserts (copy), t (copy), tryEndpoint (copy) ]]
	Asserts.Player(p2)
	Asserts.optional.string(p3)

	if p3 then
		local v1 = p1._endpoints[p3] and (if p3 == "Global" then false else true)

		assert(v1, string.format("Endpoint \'%s\' was provided but does not exist", p3))
	end

	if not (p1._tracked[p2] or p1._tracked[p2]) then
		p1._tracked[p2] = true
		p2.Destroying:Connect(function() --[[ Line: 209 | Upvalues: p1 (copy), p2 (copy) ]]
			p1:Reset(p2)
			p1._tracked[p2] = nil
		end)
	end

	if p1._destroyed then
		return false, t.Message.GARBAGE_COLLECTED
	end

	if p1:IsBanned(p2) then
		return false, t.Message.TEMP_BANNED
	end

	if p3 and not tryEndpoint(p1, p2, p1._endpoints[p3]) then
		return false, t.Message.STANDARD_ERROR
	end

	if p1._endpoints.Global and not tryEndpoint(p1, p2, p1._endpoints.Global) then
		return false, t.Message.STANDARD_ERROR
	end

	return true
end
function t.new(p1) --[[ new | Line: 325 | Upvalues: Asserts (copy), loadEndpoint (copy), t (copy), DebugGetCallerName (copy), t2 (copy) ]]
	Asserts.table(p1)
	Asserts.optional.number(p1.BanLength)
	assert(p1.Global or p1.Endpoints, "At least one endpoint must be provided")

	local t3 = {}

	if p1.Global then
		t3.Global = loadEndpoint("Global", p1.Global)
	end

	if p1.Endpoints then
		for k, v in pairs(p1.Endpoints) do
			assert(if k == "Global" then false else true, "Global endpoint cannot be overridden")
			t3[k] = loadEndpoint(k, v)
		end
	end

	assert(if next(t3) == nil then false else true, "No endpoints were provided")

	local DefaultWarn = t.DefaultWarn

	if p1.Warn ~= nil then
		DefaultWarn = p1.Warn
	end

	local v4 = p1.Id or DebugGetCallerName()
	local t4 = {
		_destroyed = false,
		_id = v4,
		_logTemplate = string.format(t.LogTemplates.BAN, "%*", v4, "%*", "%*", "%*"),
		_warn = DefaultWarn,
		_endpoints = t3,
		_bans = {}
	}

	t4._banLength = p1.BanLength or t.DefaultBanLength
	t4._tracked = {}

	return setmetatable(t4, {
		__index = t2
	})
end
function t.AllowOnce() --[[ AllowOnce | Line: 362 | Upvalues: t (copy) ]]
	return t.new({
		BanLength = (1 / 0),
		Global = {
			MaximumTokens = 1
		}
	})
end
function t.AllowPerSecond(p1, p2) --[[ AllowPerSecond | Line: 371 | Upvalues: Asserts (copy), t (copy) ]]
	assert(if p1 > 0 then true else false, "Rate must be positive")
	Asserts.optional.number(p2)

	return t.new({
		BanLength = t.DefaultBanLength,
		Global = {
			Ban = false,
			MaximumTokens = p2 or 1,
			Refresh = {
				{
					Tokens = 1,
					Interval = 1 / p1
				}
			}
		}
	})
end

return t