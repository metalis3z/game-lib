-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = {}
local v4 = {
    attribute = "CooldownActive",
    kind = "boolean",
    blank = false
}

v3[1] = {
    attribute = "CooldownEndTime",
    kind = "number",
    blank = 0
}
v3[2] = {
    attribute = "CooldownDuration",
    kind = "number",
    blank = 0
}
v3[3] = v4

local v5 = t.strict(v2)
local v6 = t.strict(t.instanceIsA("Tool"))
local v7 = {}

local function readyAtOf(v8) -- line 18
    local CooldownEndTime = v8:GetAttribute("CooldownEndTime")
    if type(CooldownEndTime) == "number" then
        return CooldownEndTime
    end
    return nil
end

local function markIdle(v9) -- line 25
    v9:SetAttribute("CooldownActive", false)
    v9:SetAttribute("CooldownDuration", 0)
    v9:SetAttribute("CooldownEndTime", 0)
end

function v7.PrimeTool(v10) -- line 30 | captures: v3, v6
    local function v11(...)
        return (typeof(...))
    end

    v6(v10)
    for v12, v13 in v3 do
        if v11(v10:GetAttribute(v13.attribute)) ~= v13.kind then
            v10:SetAttribute(v13.attribute, v13.blank)
        end
    end
end

function v7.IsRunning(v14) -- line 43 | captures: v6
    v6(v14)
    local CooldownEndTime
    if v14:GetAttribute("CooldownActive") then
        CooldownEndTime = v14:GetAttribute("CooldownEndTime")
        if type(CooldownEndTime) ~= "number" then
            CooldownEndTime = nil
        end
    end
    if CooldownEndTime == nil then
        return false
    end
    return workspace:GetServerTimeNow() < CooldownEndTime
end

function v7.SecondsRemaining(v15) -- line 59 | captures: v6, v7
    v6(v15)
    local CooldownEndTime
    if v7.IsRunning(v15) then
        CooldownEndTime = v15:GetAttribute("CooldownEndTime")
        if type(CooldownEndTime) ~= "number" then
            CooldownEndTime = nil
        end
    end
    if CooldownEndTime == nil then
        return 0
    end
    local v16 = CooldownEndTime - workspace:GetServerTimeNow()
    return (math.max(0, v16))
end

function v7.Begin(v17, v18) -- line 77 | captures: v5, v6
    v6(v17)
    v5(v18)
    local v19 = v18 >= 0
    assert(v19)
    local v20 = workspace:GetServerTimeNow() + v18
    v17:SetAttribute("CooldownDuration", v18)
    v17:SetAttribute("CooldownEndTime", v20)
    v17:SetAttribute("CooldownActive", true)
    task.delay(v18, function() -- line 86 | captures: v17, v20
        if not (v17 and v17.Parent and v17:GetAttribute("CooldownEndTime") == v20) then
            return
        end
        v17:SetAttribute("CooldownActive", false)
        v17:SetAttribute("CooldownDuration", 0)
        v17:SetAttribute("CooldownEndTime", 0)
    end)
end

function v7.Cancel(v21) -- line 98 | captures: v6
    v6(v21)
    v21:SetAttribute("CooldownActive", false)
    v21:SetAttribute("CooldownDuration", 0)
    v21:SetAttribute("CooldownEndTime", 0)
end

return v7
