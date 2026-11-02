-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(v2, ...)
    assert(v2, ...)
end

local function v3(v4, ...)
    assert(v4, ...)
end

local function v5(v6, ...)
    assert(v6, ...)
end

local v7 = game:GetService("RunService"):IsServer()
local v8 = game:GetService("RunService"):IsStudio()
local AnalyticsService = game:GetService("AnalyticsService")
local HttpService = game:GetService("HttpService")
local AnalyticsLogLevel = Enum.AnalyticsLogLevel
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer

if v7 then
else
    LocalPlayer = Players.LocalPlayer
end
local Log = script:FindFirstAncestor("Packages").Configs:FindFirstChild("Log")
local v9

if Log then
    v9 = require(Log)
else
    v9 = "Debug"
end
local Stringify = require(ReplicatedStorage.UserGenerated.Strings.Stringify)
local Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
local v10 = require(Packages:WaitForChild("t"))
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v11
local clock = os.clock
local v12 = {
    Trace = AnalyticsLogLevel.Trace.Value,
    Debug = AnalyticsLogLevel.Debug.Value,
    Info = AnalyticsLogLevel.Information.Value,
    Warning = AnalyticsLogLevel.Warning.Value,
    Error = AnalyticsLogLevel.Error.Value,
    Fatal = AnalyticsLogLevel.Fatal.Value
}

local function ToSeconds(v13, v14) -- line 40
    if v14 == 0 then
        return v13 / 1000
    end
    if v14 == 1 then
        return v13
    end
    if v14 == 2 then
        return v13 * 60
    end
    if v14 == 3 then
        return v13 * 3600
    end
    if v14 == 4 then
        return v13 * 86400
    end
    if v14 == 5 then
        return v13 * 604800
    end
    if v14 == 6 then
        return v13 * 2592000
    end
    if v14 == 7 then
        return v13 * 31536000
    end
    error("Unknown time unit", 2)
end

local function GetPlayerFromCustomData(v15) -- line 67
    if type(v15) == "table" then
        local v16 = v15.Player or v15.PlayerId
        if v16 then
            return game:GetService("Players"):GetPlayerByUserId(v16)
        end
    end
    return nil
end

local v17

if v8 then
    function v17(v18, v19, v20, v21) -- line 110
    end
else
    function v17(v22, v23, v24, v25) -- line 82 | captures: LocalPlayer, AnalyticsService
        local v26, v27 = pcall(function() -- line 84 | captures: v22, v23, v24, v25, LocalPlayer, AnalyticsService
            local v28 = LocalPlayer
            if not v28 then
                if type(v25) == "table" then
                    local v29 = v25.Player or v25.PlayerId
                    if v29 then
                        v28 = game:GetService("Players"):GetPlayerByUserId(v29)
                    else
                        v28 = nil
                    end
                else
                    v28 = nil
                end
            end
            AnalyticsService:FireLogEvent(v28, v22, v23, { stackTrace = v24 }, v25)
        end)
        if not v26 then
            warn(v27)
        end
    end
end
local v30 = {}

v30.__index = v30

function v30.new(v31, v32, v33, v34, v35) -- line 114 | captures: v30
    local v36 = {
        _muted = v35,
        _log = v31,
        _traceback = v33,
        _levelName = v32,
        _modifiers = { Throw = false },
        _key = v34
    }
    return (setmetatable(v36, v30))
end

function v30._shouldLog(v37, v38) -- line 125 | captures: clock
    if v37._modifiers.Every then
        if v38:_checkAndIncrementCount(v37._modifiers.Every) then
            if v37._modifiers.AtMostEvery then
                return not not v38:_checkLastTimestamp(clock(), v37._modifiers.AtMostEvery)
            end
            return true
        end
        return false
    end
    if v37._modifiers.AtMostEvery then
        return not not v38:_checkLastTimestamp(clock(), v37._modifiers.AtMostEvery)
    end
    return true
end

local function Every(v39, v40) -- line 146
    v39._modifiers.Every = v40
    return v39
end

v30.Every = Every

function v30.AtMostEvery(v41, v42, v43) -- line 150 | captures: ToSeconds
    v41._modifiers.AtMostEvery = ToSeconds(v42, v43)
    return v41
end

local function Throw(v44) -- line 154
    v44._modifiers.Throw = true
    return v44
end

v30.Throw = Throw

function v30.Log(v45, v46, ...) -- line 158 | captures: v17, v8, HttpService, Stringify, TryCall, clock, v12
    if v45._muted then
        return
    end
    local v47 = select("#", ...)
    local v48
    if v47 == 1 then
        v48 = select(1, ...)
    elseif v47 > 1 then
        v48 = { ... }
    end
    local v49 = v45._log:_getLogStats(v45._key)
    if not v45:_shouldLog(v49) then
        return
    end
    local v50
    if type(v46) == "function" then
        local v51
        v50, v51 = v46()
        if v51 ~= nil then
            v48 = v51
        end
    elseif type(v46) == "table" then
        local v52, v53 = TryCall(HttpService.JSONEncode, HttpService, v46)
        v50 = v52 and v53 or v46
    else
        v50 = v46
    end
    local v54
    if v8 then
        v54 = false
    elseif v45._log._settings.EnableStringRead and type(v50) == "string" and type(v48) == "table" then
        local v55, v56 = TryCall(Stringify.Pretty, v48)
        if v55 and v56 then
            v50 ..= " " .. v56
            v54 = true
        else
            v54 = false
        end
    else
        v54 = false
    end
    v49:_setTimestamp(clock())
    local v57 = ("%s: [%s] %s"):format(v45._log._name, v45._levelName, v50)
    local v58 = v12[v45._levelName]
    local v59 = ("%s: %s"):format(v45._log._name, v50)
    v17(v58, v59, v45._traceback, v48)
    if v45._modifiers.Throw then
        error(v57 .. (v48 and not v54 and " " .. HttpService:JSONEncode(v48) or ""), 4)
    elseif v58 < v12.Warning then
        local v60 = not v54 and v48 or ""
        print(v57, v60)
    else
        local v61 = not v54 and v48 or ""
        warn(v57, v61)
    end
end

function v30.SepLog(v62, v63, v64) -- line 237 | captures: v10
    v10.strict(v10.optional(v10.string))(v64)
    v10.strict(v10.optional(v10.number))(v63)
    v62:Log(string.rep(v64 or "-", v63 or 100))
end

local function Wrap(v65) -- line 244
    return function(...) -- line 245 | captures: v65
        v65:Log(...)
    end
end

v30.Wrap = Wrap

local function Assert(v66, v67, ...) -- line 249
    if v67 then
        v66:Throw():Log(...)
    end
end

v30.Assert = Assert

local v68 = {}

v68.__index = v68
setmetatable(v68, v30)

function v68.new(...) -- line 257 | captures: v30, v68
    local v69 = v30.new(...)
    return (setmetatable(v69, v68))
end

local function Log_2(v70) -- line 261
end

v68.Log = Log_2

local v71 = {}

v71.__index = v71

function v71.new() -- line 264 | captures: v71
    local v72 = {}
    local v73 = setmetatable(v72, v71)
    v73._invocationCount = 0
    v73._lastTimestamp = 0
    return v73
end

local function _checkAndIncrementCount(v74, v75) -- line 270
    local v76 = v74._invocationCount % v75 == 0
    v74._invocationCount += 1
    return v76
end

v71._checkAndIncrementCount = _checkAndIncrementCount

local function _checkLastTimestamp(v77, v78, v79) -- line 275
    return v79 <= v78 - v77._lastTimestamp
end

v71._checkLastTimestamp = _checkLastTimestamp

local function _setTimestamp(v80, v81) -- line 279
    v80._lastTimestamp = v81
end

v71._setTimestamp = _setTimestamp

local v82 = {}

v82.__index = v82
v82.TimeUnit = {
    Milliseconds = 0,
    Seconds = 1,
    Minutes = 2,
    Hours = 3,
    Days = 4,
    Weeks = 5,
    Months = 6,
    Years = 7
}
v82.Level = v12
v82.LevelNames = {}
for v83, v84 in pairs(v82.Level) do
    v82.LevelNames[v84] = v83
end

function v82.new(v85) -- line 299 | captures: v10, v82
    v10.strict(v10.optional(v10.table))(v85)
    local v86 = {}
    local v87 = setmetatable(v86, v82)
    v87._name = debug.info(2, "s"):match("([^%.]-)$")
    v87._muted = false
    v87._stats = {}
    v87._settings = v85 or {}
    return v87
end

function v82.getLevelFromName(v88) -- line 314 | captures: v10, v82
    v10.strict(v10.string)(v88)
    local v89 = v82.Level[v88]
    local v90 = ("Invalid log level: \"%*\""):format(v88)
    return assert(v89, v90)
end

function v82.isWithinLevel(v91) -- line 319 | captures: v11, v82
    return v11 <= v82.getLevelFromName(v91), v11
end

function v82._getLogStats(v92, v93) -- line 323 | captures: v71
    local v94 = v92._stats[v93]
    if not v94 then
        v94 = v71.new()
        v92._stats[v93] = v94
    end
    return v94
end

function v82._at(v95, v96) -- line 331 | captures: v11, v30, v68, v82
    local lf, lf_2 = debug.info(3, "lf")
    local v97 = debug.traceback("Log", 3)
    local v98 = tostring(lf) .. tostring(lf_2)
    if (v95._limitUnder or v11) <= v96 then
        return v30.new(v95, v82.LevelNames[v96], v97, v98, v95._muted)
    end
    local v99 = v82.LevelNames[v96]
    return (v68.new(v95, v99, v97, v98))
end

local function Mute(v100) -- line 347
    v100._muted = true
    return v100
end

v82.Mute = Mute

local function UnMute(v101) -- line 351
    v101._muted = false
    return v101
end

v82.UnMute = UnMute

function v82.LimitUnderLevel(v102, v103) -- line 355 | captures: v82
    v102._limitUnder = v82.getLevelFromName(v103)
    return v102
end

local function At(v104, v105) -- line 359
    return v104:_at(v105)
end

v82.At = At

function v82.AtTrace(v106) -- line 362 | captures: v82
    return v106:_at(v82.Level.Trace)
end

function v82.AtDebug(v107) -- line 365 | captures: v82
    return v107:_at(v82.Level.Debug)
end

function v82.AtInfo(v108) -- line 368 | captures: v82
    return v108:_at(v82.Level.Info)
end

function v82.AtWarning(v109) -- line 371 | captures: v82
    return v109:_at(v82.Level.Warning)
end

function v82.AtError(v110) -- line 374 | captures: v82
    return v110:_at(v82.Level.Error)
end

function v82.AtFatal(v111) -- line 377 | captures: v82
    return v111:_at(v82.Level.Fatal)
end

function v82.Assert(v112, v113, ...) -- line 380 | captures: v82
    if not v113 then
        v112:_at(v82.Level.Error):Throw():Log(...)
    end
end

local function Destroy(v114) -- line 385
end

v82.Destroy = Destroy

local function __tostring(v115) -- line 386
    return ("Log<%s>"):format(v115._name)
end

v82.__tostring = __tostring

local function SetLogLevel(v116) -- line 389 | captures: v11, v7, v8, v82
    local v117 = v116:lower()
    for v118, v119 in pairs(v82.Level) do
        if v118:lower() == v117 then
            if v8 then
                local v120 = if v7 then "LogLevel" else "LogLevelClient"
                local v121 = v117:sub(1, 1):upper() .. v117:sub(2)
                local v122 = workspace:GetAttribute(v120) or ""
                if tostring(v122) ~= v121 then
                    workspace:SetAttribute(v120, v121)
                end
            end
            v11 = v119
            return
        end
    end
    error("Unknown log level: " .. tostring(v116))
end

local v123 = type(v9)
local v124 = if v123 == "table" then true else v123 == "string"
local v125 = "LogConfig must return a table or a string; got " .. v123
assert(v124, v125)

if v123 == "string" then
    SetLogLevel(v9)
elseif v8 then
    if v9.Studio then
        local Studio = v9.Studio
        local v126 = type(Studio)
        local v127 = if v126 == "table" then true else v126 == "string"
        local v128 = "LogConfig.Studio must be a table or a string; got " .. v126
        assert(v127, v128)
        if v126 == "string" then
            SetLogLevel(v9.Studio)
        elseif v7 then
            local Server = v9.Studio.Server
            local v129 = type(Server) == "string"
            local v130 = "LogConfig.Studio.Server must be a string; got " .. type(Server)
            assert(v129, v130)
            SetLogLevel(Server)
        else
            local Client = v9.Studio.Client
            local v131 = type(Client) == "string"
            local v132 = "LogConfig.Studio.Client must be a string; got " .. type(Client)
            assert(v131, v132)
            SetLogLevel(Client)
        end
    end
else
    local v133 = 0
    local v134
    local v135 = false
    local v136
    for v137, v138 in pairs(v9) do
        if v137 ~= "Studio" then
            if type(v138) == "string" then
                v133 += 1
                v134 = v138
            elseif type(v138) == "table" then
                local PlaceId = v138.PlaceId
                local v139, v140
                if type(PlaceId) == "number" then
                    v140 = v138.PlaceId == game.PlaceId
                    v139 = false
                else
                    local PlaceIds = v138.PlaceIds
                    if type(PlaceIds) == "table" then
                        v140 = table.find(v138.PlaceIds, game.PlaceId) ~= nil
                        v139 = false
                    else
                        local GameId = v138.GameId
                        if type(GameId) == "number" then
                            v140 = v138.GameId == game.GameId
                            v139 = false
                        else
                            local GameIds = v138.GameIds
                            if type(GameIds) == "table" then
                                v140 = table.find(v138.GameIds, game.GameId) ~= nil
                                v139 = false
                            else
                                v140 = true
                                v139 = true
                            end
                        end
                    end
                end
                if not v139 then
                    v1(not v135, ("More than one LogConfig mapping matched (%s and %s)"):format(v136 or "", v137 or ""))
                end
                if v140 then
                    if v7 then
                        local Server = v138.Server
                        v5(type(Server) == "string", ("LogConfig.%s.Server must be a string; got %s"):format(v137, (type(Server))))
                        SetLogLevel(Server)
                    else
                        local Client = v138.Client
                        v3(type(Client) == "string", ("LogConfig.%s.Client must be a string; got %s"):format(v137, (type(Client))))
                        SetLogLevel(Client)
                    end
                    v135 = true
                    v136 = v137
                end
            else
                warn(("LogConfig.%s must be a table or a string; got %s"):format(v137, (typeof(v138))))
            end
        end
    end
    if v133 > 1 then
        warn("Ambiguous default logging level")
    end
    if v134 and not v135 then
        SetLogLevel(v134)
    end
end
local v141 = v11
local v142 = type(v141) == "number"
assert(v142, "LogLevel failed to be determined")

if v8 then
    local v143, v144
    if v7 then
        v143 = "LogLevel"
        v144 = "LogLevel"
    else
        v143 = "LogLevelClient"
        v144 = "LogLevelClient"
    end
    workspace:GetAttributeChangedSignal(v144):Connect(function() -- line 504 | captures: v143, SetLogLevel
        SetLogLevel(workspace:GetAttribute(v143))
    end)
end
return v82
