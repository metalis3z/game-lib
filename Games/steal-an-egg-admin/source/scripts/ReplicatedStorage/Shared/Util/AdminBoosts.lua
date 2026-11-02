-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.string)
local v2 = t.numberMin(1)
local v3 = t.strict(t.optional(t.intersection(v2, t.numberMaxExclusive((1/0)))))
local v4 = {
    SPEED = "Speed",
    EARNINGS = "Earnings",
    EGG_SIZE = "EggSize",
    EGG_SPAWN_LUCK = "EggSpawnLuck",
    MUTATION_LUCK = "MutationLuck",
    TREADMILL = "Treadmill"
}
local v5 = {}
for v6, v7 in v4 do
    v5[v7] = true
end

local function attributeFor(v8) -- line 28 | captures: v1, v5
    v1(v8)
    local v9 = v5[v8]
    local v10 = ("there is no admin boost named \"%*\""):format(v8)
    assert(v9, v10)
    return "AdminBoost_" .. v8
end

function v4.ReadMultiplier(v11) -- line 33 | captures: Workspace, v1, v5
    v1(v11)
    local v12 = v5[v11]
    local v13 = ("there is no admin boost named \"%*\""):format(v11)
    assert(v12, v13)
    local v14 = Workspace:GetAttribute("AdminBoost_" .. v11)
    if not (type(v14) == "number" and v14 == v14) then
        return 1
    end
    return (math.max(v14, 1))
end

function v4.Observe(v15) -- line 42 | captures: Workspace, v1, v5
    v1(v15)
    local v16 = v5[v15]
    local v17 = ("there is no admin boost named \"%*\""):format(v15)
    assert(v16, v17)
    return Workspace:GetAttributeChangedSignal("AdminBoost_" .. v15)
end

function v4.Assign(v18, v19) -- line 47 | captures: RunService, Workspace, v1, v3, v5
    local v20 = RunService:IsServer()
    assert(v20, "admin boosts can only be assigned on the server")
    v3(v19)
    v1(v18)
    local v21 = v5[v18]
    local v22 = ("there is no admin boost named \"%*\""):format(v18)
    assert(v21, v22)
    local v23 = "AdminBoost_" .. v18
    if v19 == nil or v19 <= 1 then
        Workspace:SetAttribute(v23, nil)
    else
        Workspace:SetAttribute(v23, v19)
    end
end

return table.freeze(v4)
