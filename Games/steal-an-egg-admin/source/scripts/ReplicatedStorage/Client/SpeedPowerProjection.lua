-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Save = require(ReplicatedStorage.Shared.Save)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.number)
local v2 = { Changed = Signal.new() }
local DEFAULT_BASE_SPEED_POWER = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local v3 = DEFAULT_BASE_SPEED_POWER
local v4
local v5 = DEFAULT_BASE_SPEED_POWER
local v6 = 0
local v7

local function readSavedPower() -- line 21 | captures: Save, TreadmillUtil
    local v8 = Save.Get()
    return TreadmillUtil.NormalizeSpeedPower(v8 and v8.SpeedPower or nil)
end

local function readPositiveAttribute(v9) -- line 26 | captures: Workspace
    local v10 = Workspace:GetAttribute(v9)
    if not (type(v10) == "number" and v10 > 0) then
        return nil
    end
    return v10
end

local function computeShown() -- line 34 | captures: v4, v5, v6, v7, Workspace, Save, TreadmillUtil
    local v11 = Save.Get()
    local v12 = TreadmillUtil.NormalizeSpeedPower(v11 and v11.SpeedPower or nil)
    if v4 == nil then
        if v7 ~= nil then
            local v13 = v7
            local v14 = math.max(v12, v13)
            if v7 <= v12 then
                v7 = nil
            end
            v12 = v14
        end
    else
        v12 = v5 + v6
    end
    local EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")
    if not (type(EqualisedSpeedPower) == "number" and EqualisedSpeedPower > 0) then
        EqualisedSpeedPower = nil
    end
    if EqualisedSpeedPower == nil then
        local MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
        if not (type(MinimumSpeedPower) == "number" and MinimumSpeedPower > 0) then
            MinimumSpeedPower = nil
        end
        if MinimumSpeedPower ~= nil then
            v12 = math.max(v12, MinimumSpeedPower)
        end
        return v12
    end
    return EqualisedSpeedPower
end

local function republish() -- line 59 | captures: v3, v4, v5, v6, v7, Workspace, Save, TreadmillUtil, v2
    local v15 = Save.Get()
    local v16 = TreadmillUtil.NormalizeSpeedPower(v15 and v15.SpeedPower or nil)
    if v4 == nil then
        if v7 ~= nil then
            local v17 = v7
            local v18 = math.max(v16, v17)
            if v7 <= v16 then
                v7 = nil
            end
            v16 = v18
        end
    else
        v16 = v5 + v6
    end
    local EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")
    if not (type(EqualisedSpeedPower) == "number" and EqualisedSpeedPower > 0) then
        EqualisedSpeedPower = nil
    end
    if EqualisedSpeedPower == nil then
        local MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
        if type(MinimumSpeedPower) == "number" then
            if not (MinimumSpeedPower > 0) then
                MinimumSpeedPower = nil
            end
        else
            MinimumSpeedPower = nil
        end
        if MinimumSpeedPower == nil then
            EqualisedSpeedPower = v16
        else
            EqualisedSpeedPower = math.max(v16, MinimumSpeedPower)
        end
    end
    if EqualisedSpeedPower ~= v3 then
        v3 = EqualisedSpeedPower
        v2.Changed:Fire(v3)
    end
end

function v2.ReadProjected() -- line 67 | captures: v3
    return v3
end

function v2.OpenSession(v19) -- line 71 | captures: v3, v4, v5, v6, v7, Workspace, Save, TreadmillUtil, v1, v2
    v1(v19)
    local v20 = Save.Get()
    local v21 = TreadmillUtil.NormalizeSpeedPower(v20 and v20.SpeedPower or nil)
    v4 = v19
    local v22 = v3
    v5 = math.max(v21, v22)
    v6 = 0
    v7 = nil
    local v23 = Save.Get()
    local v24 = TreadmillUtil.NormalizeSpeedPower(v23 and v23.SpeedPower or nil)
    if v4 == nil then
        if v7 ~= nil then
            local v25 = v7
            local v26 = math.max(v24, v25)
            if v7 <= v24 then
                v7 = nil
            end
            v24 = v26
        end
    else
        v24 = v5 + v6
    end
    local EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")
    if not (type(EqualisedSpeedPower) == "number" and EqualisedSpeedPower > 0) then
        EqualisedSpeedPower = nil
    end
    if EqualisedSpeedPower == nil then
        local MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
        if type(MinimumSpeedPower) == "number" then
            if not (MinimumSpeedPower > 0) then
                MinimumSpeedPower = nil
            end
        else
            MinimumSpeedPower = nil
        end
        if MinimumSpeedPower == nil then
            EqualisedSpeedPower = v24
        else
            EqualisedSpeedPower = math.max(v24, MinimumSpeedPower)
        end
    end
    if EqualisedSpeedPower ~= v3 then
        v3 = EqualisedSpeedPower
        v2.Changed:Fire(v3)
    end
end

function v2.CreditRevealedGain(v27, v28) -- line 81 | captures: v3, v4, v5, v6, v7, Workspace, Save, TreadmillUtil, v1, v2
    v1(v27)
    v1(v28)
    local NormalizeSpeedPower, v29, v30
    if v4 == v27 then
        if v28 <= 0 then
            v30 = true
        else
            v6 += v28
            local v31 = Save.Get()
            NormalizeSpeedPower = TreadmillUtil.NormalizeSpeedPower
            v29 = v31 and v31.SpeedPower or nil
            v30 = false
        end
    else
        v30 = true
    end
    if v30 then
        return false
    end
    local v32 = NormalizeSpeedPower(v29)
    if v4 == nil then
        if v7 ~= nil then
            local v33 = v7
            local v34 = math.max(v32, v33)
            if v7 <= v32 then
                v7 = nil
            end
            v32 = v34
        end
    else
        v32 = v5 + v6
    end
    local EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")
    if not (type(EqualisedSpeedPower) == "number" and EqualisedSpeedPower > 0) then
        EqualisedSpeedPower = nil
    end
    if EqualisedSpeedPower == nil then
        local MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
        if type(MinimumSpeedPower) == "number" then
            if not (MinimumSpeedPower > 0) then
                MinimumSpeedPower = nil
            end
        else
            MinimumSpeedPower = nil
        end
        if MinimumSpeedPower == nil then
            EqualisedSpeedPower = v32
        else
            EqualisedSpeedPower = math.max(v32, MinimumSpeedPower)
        end
    end
    if EqualisedSpeedPower ~= v3 then
        v3 = EqualisedSpeedPower
        v2.Changed:Fire(v3)
    end
    return true
end

function v2.CloseSession(v35) -- line 92 | captures: v3, v4, v5, v6, v7, Workspace, Save, TreadmillUtil, v1, v2
    v1(v35)
    if v4 ~= v35 then
        return
    end
    v7 = v5 + v6
    v4 = nil
    v6 = 0
    local v36 = Save.Get()
    local v37 = TreadmillUtil.NormalizeSpeedPower(v36 and v36.SpeedPower or nil)
    if v4 == nil then
        if v7 ~= nil then
            local v38 = v7
            local v39 = math.max(v37, v38)
            if v7 <= v37 then
                v7 = nil
            end
            v37 = v39
        end
    else
        v37 = v5 + v6
    end
    local EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")
    if not (type(EqualisedSpeedPower) == "number" and EqualisedSpeedPower > 0) then
        EqualisedSpeedPower = nil
    end
    if EqualisedSpeedPower == nil then
        local MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
        if type(MinimumSpeedPower) == "number" then
            if not (MinimumSpeedPower > 0) then
                MinimumSpeedPower = nil
            end
        else
            MinimumSpeedPower = nil
        end
        if MinimumSpeedPower == nil then
            EqualisedSpeedPower = v37
        else
            EqualisedSpeedPower = math.max(v37, MinimumSpeedPower)
        end
    end
    if EqualisedSpeedPower ~= v3 then
        v3 = EqualisedSpeedPower
        v2.Changed:Fire(v3)
    end
end

local v40 = Save.Get()
local v41 = TreadmillUtil.NormalizeSpeedPower(v40 and v40.SpeedPower or nil)

if v4 == nil then
    if v7 ~= nil then
        local v42 = v7
        local v43 = math.max(v41, v42)
        if v7 <= v41 then
            v7 = nil
        end
        v41 = v43
    end
else
    v41 = v5 + v6
end
local EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")

if not (type(EqualisedSpeedPower) == "number" and EqualisedSpeedPower > 0) then
    EqualisedSpeedPower = nil
end

if EqualisedSpeedPower == nil then
    local MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
    if type(MinimumSpeedPower) == "number" then
        if not (MinimumSpeedPower > 0) then
            MinimumSpeedPower = nil
        end
    else
        MinimumSpeedPower = nil
    end
    if MinimumSpeedPower ~= nil then
        v41 = math.max(v41, MinimumSpeedPower)
    end
    v3 = v41
else
    v3 = EqualisedSpeedPower
end
Save.FieldSignal("SpeedPower"):Connect(republish)
Save.ProfileReady:Connect(republish)
Workspace:GetAttributeChangedSignal("EqualisedSpeedPower"):Connect(republish)
Workspace:GetAttributeChangedSignal("MinimumSpeedPower"):Connect(republish)
return v2
