-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = game:GetService("RunService"):IsStudio()
local v2 = game:GetService("RunService"):IsServer()
local HttpService = game:GetService("HttpService")
local AnalyticsService = game:GetService("AnalyticsService")
local AnalyticsLogLevel = Enum.AnalyticsLogLevel
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v3 = if v2 then nil else Players.LocalPlayer or nil
local Log = script:FindFirstAncestor("Packages").Configs:FindFirstChild("Log")
local v4 = script:FindFirstAncestor("Packages").Configs:FindFirstChild("Log") and require(Log) or "Debug"
local Asserts = require(ReplicatedStorage.Library.Asserts)
local JSON = require(ReplicatedStorage.Library.Functions.JSON)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local v5 = nil
local clock = os.clock
local t = {
	Trace = AnalyticsLogLevel.Trace.Value,
	Debug = AnalyticsLogLevel.Debug.Value,
	Info = AnalyticsLogLevel.Information.Value,
	Warning = AnalyticsLogLevel.Warning.Value,
	Error = AnalyticsLogLevel.Error.Value,
	Fatal = AnalyticsLogLevel.Fatal.Value
}

local function ToSeconds(p1, p2) --[[ ToSeconds | Line: 192 ]]
	if p2 == 0 then
		return p1 / 1000
	end

	if p2 == 1 then
		return p1
	end

	if p2 == 2 then
		return p1 * 60
	end

	if p2 == 3 then
		return p1 * 3600
	end

	if p2 == 4 then
		return p1 * 86400
	end

	if p2 == 5 then
		return p1 * 604800
	end

	if p2 == 6 then
		return p1 * 2592000
	end

	if p2 == 7 then
		return p1 * 31536000
	end

	error("Unknown time unit", 2)
end

local function GetPlayerFromCustomData(p1) --[[ GetPlayerFromCustomData | Line: 214 ]]
	if type(p1) ~= "table" then
		return nil
	end

	local v1 = p1.Player or p1.PlayerId

	if v1 then
		return game:GetService("Players"):GetPlayerByUserId(v1)
	end

	return nil
end

local v6 = if v1 then function(p1, p2, p3, p4) --[[ Line: 226 ]] end else function(p1, p2, p3, p4) --[[ Line: 228 | Upvalues: v3 (copy), AnalyticsService (copy) ]]
	local ok, result = pcall(function() --[[ Line: 229 | Upvalues: v3 (ref), p4 (copy), AnalyticsService (ref), p1 (copy), p2 (copy), p3 (copy) ]]
		local v1 = v3

		if not v1 then
			local v2 = p4

			if type(v2) == "table" then
				local v32 = v2.Player or v2.PlayerId

				v1 = if v32 then game:GetService("Players"):GetPlayerByUserId(v32) else nil
			else
				v1 = nil
			end
		end

		AnalyticsService:FireLogEvent(v1, p1, p2, {
			stackTrace = p3
		}, p4)
	end)

	if ok then
		return
	end

	warn(result)
end
local t3 = {}

t3.__index = t3
function t3.new(p1, p2, p3, p4, p5) --[[ new | Line: 256 | Upvalues: t3 (copy) ]]
	return setmetatable({
		_muted = p5,
		_log = p1,
		_traceback = p3,
		_levelName = p2,
		_modifiers = {
			Throw = false
		},
		_key = p4
	}, t3)
end
function t3._shouldLog(p1, p2) --[[ _shouldLog | Line: 270 | Upvalues: clock (copy) ]]
	if p1._modifiers.Every and not p2:_checkAndIncrementCount(p1._modifiers.Every) then
		return false
	end

	return (not p1._modifiers.AtMostEvery or p2:_checkLastTimestamp(clock(), p1._modifiers.AtMostEvery)) and true or false
end
function t3.Every(p1, p2) --[[ Every | Line: 280 ]]
	p1._modifiers.Every = p2

	return p1
end
function t3.AtMostEvery(p1, p2, p3) --[[ AtMostEvery | Line: 285 | Upvalues: ToSeconds (copy) ]]
	p1._modifiers.AtMostEvery = ToSeconds(p2, p3)

	return p1
end
function t3.Throw(p1) --[[ Throw | Line: 290 ]]
	p1._modifiers.Throw = true

	return p1
end
function t3.Log(p1, p2, ...) --[[ Log | Line: 295 | Upvalues: wcall (copy), HttpService (copy), v1 (copy), JSON (copy), clock (copy), t (copy), v6 (ref) ]]
	if p1._muted then
		return
	end

	local v12 = select("#", ...)
	local v2 = nil

	if v12 == 1 then
		v2 = select(1, ...)
	elseif v12 > 1 then
		v2 = { ... }
	end

	local v4 = p1._log:_getLogStats(p1._key)
	local v5 = false

	if not p1:_shouldLog(v4) then
		return
	end

	if type(p2) == "function" then
		local v62, v7 = p2()

		if v7 == nil then
			p2 = v62
		else
			p2 = v62
			v2 = v7
		end
	elseif type(p2) == "table" then
		local v8, v9 = wcall(HttpService.JSONEncode, HttpService, p2)

		if v8 and v9 then
			p2 = v9
		end
	end

	if not v1 and (p1._log._settings.EnableStringRead and (type(p2) == "string" and type(v2) == "table")) then
		local v10, v11 = wcall(JSON.stringify, v2, nil, 2, true)

		if v10 and v11 then
			p2 = p2 .. " " .. v11
			v5 = true
		end
	end

	v4:_setTimestamp(clock())

	local v122 = ("%s: [%s] %s"):format(p1._log._name, p1._levelName, p2)
	local v13 = t[p1._levelName]

	v6(v13, ("%s: %s"):format(p1._log._name, p2), p1._traceback, v2)

	if p1._modifiers.Throw then
		local v14 = error
		local v15, v16

		if v2 and not v5 then
			v15 = " " .. HttpService:JSONEncode(v2)
			v16 = v122
		else
			v16 = v122
			v15 = ""
		end

		v14(v16 .. v15, 4)
	elseif v13 < t.Warning then
		print(v122, if v5 then "" else v2 or "")
	else
		warn(v122, if v5 then "" else v2 or "")
	end
end
function t3.SepLog(p1, p2, p3) --[[ SepLog | Line: 357 | Upvalues: Asserts (copy) ]]
	Asserts.optional.string(p3)
	Asserts.optional.number(p2)
	p1:Log(string.rep(p3 or "-", p2 or 100))
end
function t3.Wrap(p1) --[[ Wrap | Line: 364 ]]
	return function(...) --[[ Line: 365 | Upvalues: p1 (copy) ]]
		p1:Log(...)
	end
end
function t3.Assert(p1, p2, ...) --[[ Assert | Line: 370 ]]
	if not p2 then
		return
	end

	p1:Throw():Log(...)
end

local t4 = {}

t4.__index = t4
setmetatable(t4, t3)
function t4.new(...) --[[ new | Line: 380 | Upvalues: t3 (copy), t4 (copy) ]]
	return setmetatable(t3.new(...), t4)
end
function t4.Log(p1) --[[ Log | Line: 385 ]] end

local t5 = {}

t5.__index = t5
function t5.new() --[[ new | Line: 400 | Upvalues: t5 (copy) ]]
	local v2 = setmetatable({}, t5)

	v2._invocationCount = 0
	v2._lastTimestamp = 0

	return v2
end
function t5._checkAndIncrementCount(p1, p2) --[[ _checkAndIncrementCount | Line: 407 ]]
	local v1 = p1._invocationCount % p2 == 0

	p1._invocationCount = p1._invocationCount + 1

	return v1
end
function t5._checkLastTimestamp(p1, p2, p3) --[[ _checkLastTimestamp | Line: 413 ]]
	return p3 <= p2 - p1._lastTimestamp
end
function t5._setTimestamp(p1, p2) --[[ _setTimestamp | Line: 417 ]]
	p1._lastTimestamp = p2
end

local t6 = {}

t6.__index = t6
t6.TimeUnit = {
	Milliseconds = 0,
	Seconds = 1,
	Minutes = 2,
	Hours = 3,
	Days = 4,
	Weeks = 5,
	Months = 6,
	Years = 7
}
t6.Level = t
t6.LevelNames = {}

for k, v in pairs(t6.Level) do
	t6.LevelNames[v] = k
end

function t6.new(p1) --[[ new | Line: 621 | Upvalues: Asserts (copy), t6 (copy) ]]
	Asserts.optional.table(p1)

	local v2 = setmetatable({}, t6)

	v2._name = debug.info(2, "s"):match("([^%.]-)$")
	v2._muted = false
	v2._stats = {}
	v2._settings = if p1 then p1 else {}

	return v2
end
function t6.getLevelFromName(p1) --[[ getLevelFromName | Line: 633 | Upvalues: Asserts (copy), t6 (copy) ]]
	Asserts.string(p1)

	return assert(t6.Level[p1], (("Invalid log level: \"%*\""):format(p1)))
end
function t6.isWithinLevel(p1) --[[ isWithinLevel | Line: 638 | Upvalues: t6 (copy), v5 (ref) ]]
	return v5 <= t6.getLevelFromName(p1), v5
end
function t6._getLogStats(p1, p2) --[[ _getLogStats | Line: 643 | Upvalues: t5 (copy) ]]
	local v1 = p1._stats[p2]

	if not v1 then
		local v2 = t5.new()

		p1._stats[p2] = v2
		v1 = v2
	end

	return v1
end
function t6._at(p1, p2) --[[ _at | Line: 652 | Upvalues: v5 (ref), t4 (copy), t6 (copy), t3 (copy) ]]
	local v1, v2 = debug.info(3, "lf")
	local v3 = debug.traceback("Log", 3)
	local v4 = tostring(v1) .. tostring(v2)

	if p2 < (p1._limitUnder or v5) then
		return t4.new(p1, t6.LevelNames[p2], v3, v4)
	end

	return t3.new(p1, t6.LevelNames[p2], v3, v4, p1._muted)
end
function t6.Mute(p1) --[[ Mute | Line: 664 ]]
	p1._muted = true

	return p1
end
function t6.UnMute(p1) --[[ UnMute | Line: 669 ]]
	p1._muted = false

	return p1
end
function t6.LimitUnderLevel(p1, p2) --[[ LimitUnderLevel | Line: 674 | Upvalues: t6 (copy) ]]
	p1._limitUnder = t6.getLevelFromName(p2)

	return p1
end
function t6.At(p1, p2) --[[ At | Line: 683 ]]
	return p1:_at(p2)
end
function t6.AtTrace(p1) --[[ AtTrace | Line: 691 | Upvalues: t6 (copy) ]]
	return p1:_at(t6.Level.Trace)
end
function t6.AtDebug(p1) --[[ AtDebug | Line: 699 | Upvalues: t6 (copy) ]]
	return p1:_at(t6.Level.Debug)
end
function t6.AtInfo(p1) --[[ AtInfo | Line: 707 | Upvalues: t6 (copy) ]]
	return p1:_at(t6.Level.Info)
end
function t6.AtWarning(p1) --[[ AtWarning | Line: 715 | Upvalues: t6 (copy) ]]
	return p1:_at(t6.Level.Warning)
end
function t6.AtError(p1) --[[ AtError | Line: 723 | Upvalues: t6 (copy) ]]
	return p1:_at(t6.Level.Error)
end
function t6.AtFatal(p1) --[[ AtFatal | Line: 731 | Upvalues: t6 (copy) ]]
	return p1:_at(t6.Level.Fatal)
end
function t6.Assert(p1, p2, ...) --[[ Assert | Line: 742 | Upvalues: t6 (copy) ]]
	if p2 then
		return
	end

	p1:_at(t6.Level.Error):Throw():Log(...)
end
function t6.Destroy(p1) --[[ Destroy | Line: 748 ]] end
function t6.__tostring(p1) --[[ __tostring | Line: 750 ]]
	return ("Log<%s>"):format(p1._name)
end

local function SetLogLevel(p1) --[[ SetLogLevel | Line: 756 | Upvalues: t6 (copy), v1 (copy), v2 (copy), v5 (ref) ]]
	local v12 = p1:lower()

	for k, v in pairs(t6.Level) do
		if k:lower() == v12 then
			if v1 then
				local v22 = if v2 then "LogLevel" else "LogLevelClient"
				local v3 = v12:sub(1, 1):upper() .. v12:sub(2)

				if tostring(workspace:GetAttribute(v22) or "") ~= v3 then
					workspace:SetAttribute(v22, v3)
				end
			end

			v5 = v

			return
		end
	end

	error("Unknown log level: " .. tostring(p1))
end

local v7 = type(v4)

assert(if v7 == "table" then true elseif v7 == "string" then true else false, "LogConfig must return a table or a string; got " .. v7)

if v7 == "string" then
	SetLogLevel(v4)
elseif v1 and v4.Studio then
	local v9 = type(v4.Studio)

	assert(if v9 == "table" then true elseif v9 == "string" then true else false, "LogConfig.Studio must be a table or a string; got " .. v9)

	if v9 == "string" then
		SetLogLevel(v4.Studio)
	elseif v2 then
		local Server = v4.Studio.Server
		local v11 = if type(Server) == "string" then true else false

		assert(v11, "LogConfig.Studio.Server must be a string; got " .. type(Server))
		SetLogLevel(Server)
	else
		local Client = v4.Studio.Client
		local v13 = type(Client) == "string"

		assert(v13, "LogConfig.Studio.Client must be a string; got " .. type(Client))
		SetLogLevel(Client)
	end
else
	local v15 = false
	local v16 = nil
	local count = 0
	local v17 = nil

	for k, v in pairs(v4) do
		local v18

		if k ~= "Studio" then
			if type(v) == "string" then
				count, v17 = count + 1, v

				continue
			end

			if type(v) == "table" then
				local v19 = false

				if type(v.PlaceId) == "number" then
					v18 = v.PlaceId == game.PlaceId
				elseif type(v.PlaceIds) == "table" then
					v18 = if table.find(v.PlaceIds, game.PlaceId) == nil then false else true
				elseif type(v.GameId) == "number" then
					v18 = v.GameId == game.GameId
				elseif type(v.GameIds) == "table" then
					v18 = table.find(v.GameIds, game.GameId) ~= nil
				else
					v19 = true
					v18 = true
				end

				if not v19 then
					assert(not v15, ("More than one LogConfig mapping matched (%s and %s)"):format(v16 or "", k or ""))
				end

				if v18 then
					if v2 then
						local Server = v.Server
						local v20 = if type(Server) == "string" then true else false

						assert(v20, ("LogConfig.%s.Server must be a string; got %s"):format(k, (type(Server))))
						SetLogLevel(Server)
						v15 = true
						v16 = k

						continue
					end

					local Client = v.Client
					local v22 = type(Client) == "string"

					assert(v22, ("LogConfig.%s.Client must be a string; got %s"):format(k, (type(Client))))
					SetLogLevel(Client)
					v15 = true
					v16 = k
				end

				continue
			end

			warn(("LogConfig.%s must be a table or a string; got %s"):format(k, (typeof(v))))
		end
	end

	if count > 1 then
		warn("Ambiguous default logging level")
	end

	if v17 and not v15 then
		SetLogLevel(v17)
	end
end

local v24 = v5

assert(if type(v24) == "number" then true else false, "LogLevel failed to be determined")

if v1 then
	local v26 = if v2 then "LogLevel" else "LogLevelClient"

	workspace:GetAttributeChangedSignal(v26):Connect(function() --[[ Line: 880 | Upvalues: SetLogLevel (copy), v26 (copy) ]]
		SetLogLevel(workspace:GetAttribute(v26))
	end)
end

return t6