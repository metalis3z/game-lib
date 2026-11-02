-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)

if Constants.IS_STUDIO then
end
local v1 = 300
local v2 = 300
local v3 = t.strict(t.boolean)
local v4 = t.strict(t.optional(t.number))
local v5 = t.strict(t.number)
local v6 = {
    EndingSoonSeconds = 20,
    FinalBlinkSeconds = 10,
    NightGrowthSkipSeconds = 300,
    MinNightDurationSeconds = 1,
    SchedulePollSeconds = 0.25,
    ResetPeriodSeconds = v2
}

local function scheduleNumber(v7, v8) -- line 28 | captures: Workspace
    local v9 = Workspace:GetAttribute(v7)
    if type(v9) == "number" then
        return v9
    end
    return v8
end

local function frozenAt(v10) -- line 35 | captures: Workspace
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v10
    end
    return (math.min(v10, AreaEggCycleDisabledAt))
end

local function requireServer() -- line 45 | captures: RunService
    local v11 = RunService:IsServer()
    assert(v11, "Only the server may rewrite the area egg schedule")
end

local function requireLegalNightLength(v12) -- line 49 | captures: v1
    local v13 = if v12 >= 1 then v12 <= v1 else false
    local v14 = ("A night of %*s falls outside %*..%*"):format(v12, 1, v1)
    assert(v13, v14)
end

function v6.NightLengthSeconds() -- line 53 | captures: v1, Workspace
    local AreaEggCycleNightSeconds = Workspace:GetAttribute("AreaEggCycleNightSeconds")
    if type(AreaEggCycleNightSeconds) ~= "number" then
        AreaEggCycleNightSeconds = 10
    end
    return (math.clamp(AreaEggCycleNightSeconds, 1, v1))
end

function v6.NightGrowthRate() -- line 63 | captures: v6
    return 300 / v6.NightLengthSeconds()
end

function v6.IsRunning() -- line 66 | captures: Workspace
    return Workspace:GetAttribute("AreaEggCycleDisabledAt") == nil
end

function v6.HasScheduleOverride() -- line 70 | captures: Workspace, v6
    if not (Workspace:GetAttribute("AreaEggCycleAnchorAt") == nil and Workspace:GetAttribute("AreaEggCycleNightSeconds") == nil) then
        return true
    end
    return not v6.IsRunning()
end

function v6.PeriodStartTime(v15) -- line 76 | captures: v1, Workspace, v5
    v5(v15)
    local AreaEggCycleAnchorIndex = Workspace:GetAttribute("AreaEggCycleAnchorIndex")
    if type(AreaEggCycleAnchorIndex) ~= "number" then
        AreaEggCycleAnchorIndex = 0
    end
    local AreaEggCycleAnchorAt = Workspace:GetAttribute("AreaEggCycleAnchorAt")
    if type(AreaEggCycleAnchorAt) ~= "number" then
        AreaEggCycleAnchorAt = 0
    end
    return AreaEggCycleAnchorAt + (v15 - AreaEggCycleAnchorIndex) * v1
end

function v6.PeriodIndexAt(v16) -- line 93 | captures: v1, Workspace, v5
    v5(v16)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v16
    end
    local v17 = math.min(v16, AreaEggCycleDisabledAt)
    local AreaEggCycleAnchorAt = Workspace:GetAttribute("AreaEggCycleAnchorAt")
    if type(AreaEggCycleAnchorAt) ~= "number" then
        AreaEggCycleAnchorAt = 0
    end
    local AreaEggCycleAnchorIndex = Workspace:GetAttribute("AreaEggCycleAnchorIndex")
    if type(AreaEggCycleAnchorIndex) ~= "number" then
        AreaEggCycleAnchorIndex = 0
    end
    local v18 = (v17 - AreaEggCycleAnchorAt) / v1
    local v19 = AreaEggCycleAnchorIndex + math.floor(v18)
    return (math.max(v19, 0))
end

function v6.NextResetTime(v20) -- line 120 | captures: v5, v6
    v5(v20)
    return v6.PeriodStartTime(v6.PeriodIndexAt(v20) + 1)
end

function v6.SecondsUntilReset(v21) -- line 124 | captures: Workspace, v5, v6
    v5(v21)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v21
    end
    local v22 = math.min(v21, AreaEggCycleDisabledAt)
    local v23 = v6.NextResetTime(v22) - v22
    return (math.max(0, v23))
end

function v6.NightStartTime(v24) -- line 136 | captures: Workspace, v5, v6
    v5(v24)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v24
    end
    local v25 = math.min(v24, AreaEggCycleDisabledAt)
    return v6.NextResetTime(v25) - v6.NightLengthSeconds()
end

function v6.IsNightPhase(v26) -- line 149 | captures: Workspace, v5, v6
    v5(v26)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v26
    end
    local v27 = math.min(v26, AreaEggCycleDisabledAt)
    return v6.SecondsUntilReset(v27) <= v6.NightLengthSeconds()
end

function v6.NightTransitionStartTime(v28, v29, v30) -- line 163 | captures: v5, v6
    v5(v28)
    v5(v29)
    v5(v30)
    return v6.NightStartTime(v28) - v29 + v30
end

function v6.IsWithinNightTransition(v31, v32, v33) -- line 169 | captures: Workspace, v5, v6
    v5(v31)
    v5(v32)
    v5(v33)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v31
    end
    local v34 = math.min(v31, AreaEggCycleDisabledAt)
    if v6.IsNightPhase(v34) then
        return false
    end
    return v6.NightTransitionStartTime(v34, v32, v33) <= v34
end

function v6.ActivePeriodIndexAt(v35) -- line 187 | captures: Workspace, v5, v6
    v5(v35)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v35
    end
    local v36 = math.min(v35, AreaEggCycleDisabledAt)
    local v37 = v6.PeriodIndexAt(v36)
    if v6.IsNightPhase(v36) then
        return v37 + 1
    end
    return v37
end

function v6.SecondsUntilPhaseEnd(v38) -- line 203 | captures: Workspace, v5, v6
    v5(v38)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v38
    end
    local v39 = math.min(v38, AreaEggCycleDisabledAt)
    local v40 = v6.SecondsUntilReset(v39)
    if v6.IsNightPhase(v39) then
        return v40
    end
    local v41 = v40 - v6.NightLengthSeconds()
    return (math.max(0, v41))
end

function v6.NextNightTime(v42) -- line 219 | captures: v1, Workspace, v5, v6
    v5(v42)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v42
    end
    local v43 = math.min(v42, AreaEggCycleDisabledAt)
    local v44 = v6.NightStartTime(v43)
    if v43 < v44 then
        return v44
    end
    return v44 + v1
end

function v6.NightGrowthCreditAt(v45, v46) -- line 235 | captures: Workspace, v5, v6
    local function v47(v48, v49, ...)
        return (math.clamp(v48, v49, ...))
    end

    v5(v45)
    v5(v46)
    local AreaEggCycleDisabledAt = Workspace:GetAttribute("AreaEggCycleDisabledAt")
    if type(AreaEggCycleDisabledAt) ~= "number" then
        AreaEggCycleDisabledAt = v45
    end
    return v47(math.min(v45, AreaEggCycleDisabledAt) - v46, 0, v6.NightLengthSeconds()) * v6.NightGrowthRate()
end

function v6.IsCloseToReset(v50) -- line 248 | captures: v5
    v5(v50)
    return v50 <= 20
end

function v6.IsInFinalBlink(v51) -- line 253 | captures: v5
    v5(v51)
    return v51 <= 10
end

function v6.IsBlinkOnRedFrame(v52) -- line 258 | captures: v5
    v5(v52)
    return math.ceil(v52) % 2 == 0
end

function v6.IsNearResetBoundary(v53, v54) -- line 263 | captures: v1, v5, v6
    v5(v53)
    v5(v54)
    local v55 = v6.NextNightTime(v53)
    if v55 - v53 <= v54 then
        return true
    end
    return v53 - (v55 - v1) <= v54
end

function v6.SetRunning(v56) -- line 273 | captures: RunService, Workspace, v3, v6
    local v57 = RunService:IsServer()
    assert(v57, "Only the server may rewrite the area egg schedule")
    v3(v56)
    if v6.IsRunning() ~= v56 then
        local v58
        if v56 then
        else
            v58 = Workspace:GetServerTimeNow()
        end
        Workspace:SetAttribute("AreaEggCycleDisabledAt", v58)
    end
end

function v6.OverrideNightLength(v59) -- line 288 | captures: v1, RunService, Workspace, v4
    local v60 = RunService:IsServer()
    assert(v60, "Only the server may rewrite the area egg schedule")
    v4(v59)
    if v59 ~= nil then
        local v61 = if v59 >= 1 then v59 <= v1 else false
        local v62 = ("A night of %*s falls outside %*..%*"):format(v59, 1, v1)
        assert(v61, v62)
    end
    Workspace:SetAttribute("AreaEggCycleNightSeconds", v59)
end

function v6.BeginNight(v63, v64) -- line 298 | captures: v1, RunService, Workspace, v4, v5, v6
    local v65 = RunService:IsServer()
    assert(v65, "Only the server may rewrite the area egg schedule")
    v5(v63)
    v4(v64)
    if v6.IsNightPhase(v63) then
        return false, "Night is already running"
    end
    local v66 = v64 or v6.NightLengthSeconds()
    local v67 = if v66 >= 1 then v66 <= v1 else false
    local v68 = ("A night of %*s falls outside %*..%*"):format(v66, 1, v1)
    assert(v67, v68)
    local v69 = v6.PeriodIndexAt(v63)
    Workspace:SetAttribute("AreaEggCycleNightSeconds", v66)
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", v69 + 1)
    Workspace:SetAttribute("AreaEggCycleAnchorAt", v63 + v66)
    return true, nil
end

function v6.FinishNight(v70) -- line 318 | captures: RunService, Workspace, v5, v6
    local v71 = RunService:IsServer()
    assert(v71, "Only the server may rewrite the area egg schedule")
    v5(v70)
    if v6.IsNightPhase(v70) then
        Workspace:SetAttribute("AreaEggCycleAnchorIndex", v6.ActivePeriodIndexAt(v70))
        Workspace:SetAttribute("AreaEggCycleAnchorAt", v70)
        return true, nil
    end
    return false, "Night is not running"
end

function v6.PostponeReset(v72) -- line 329 | captures: RunService, Workspace, v5, v6
    local v73 = RunService:IsServer()
    assert(v73, "Only the server may rewrite the area egg schedule")
    v5(v72)
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", v6.PeriodIndexAt(v72))
    Workspace:SetAttribute("AreaEggCycleAnchorAt", v72)
end

function v6.ResetSchedule() -- line 336 | captures: RunService, Workspace
    local v74 = RunService:IsServer()
    assert(v74, "Only the server may rewrite the area egg schedule")
    Workspace:SetAttribute("AreaEggCycleAnchorAt", nil)
    Workspace:SetAttribute("AreaEggCycleAnchorIndex", nil)
    Workspace:SetAttribute("AreaEggCycleNightSeconds", nil)
    Workspace:SetAttribute("AreaEggCycleDisabledAt", nil)
end

return table.freeze(v6)
