-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = t.strict(v2)
local v4 = t.strict(t.optional(t.instanceIsA("Humanoid")))
local v5 = t.strict(t.optional(t.string))
local v6 = t.strict(t.string)
local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
local v7 = {}

v7.__index = v7

local function foldModifiers(v8, v9) -- line 18 | captures: v3
    v3(v8)
    local v10 = {}
    local v11 = 0
    for v12, v13 in ipairs(v9) do
        if v13.type == "positive" then
            v11 += v13.value
        elseif v13.type == "malus" then
            local value = v13.value
            table.insert(v10, value)
        end
    end
    local v14 = v8 * (v11 + 1)
    for v15, v16 in ipairs(v10) do
        v14 *= v16 + 1
    end
    return (math.max(0, v14))
end

local function refold(v17) -- line 35 | captures: foldModifiers
    local v18 = foldModifiers(v17.baseSpeed, v17.modifiers)
    local v19 = v18 - v17.appliedSpeed
    if not (math.abs(v19) < 0.001) then
        v17.appliedSpeed = v18
        if v17.humanoid then
            v17.humanoid.WalkSpeed = v18
        end
    end
end

function v7.new(v20) -- line 46 | captures: v3, BASE_WALK_SPEED, v7
    local v21 = v20 or BASE_WALK_SPEED
    v3(v21)
    local v22 = v21 > 0
    assert(v22)
    local v23 = {}
    local v24 = setmetatable(v23, v7)
    v24.baseSpeed = v21
    v24.appliedSpeed = v21
    v24.modifiers = {}
    v24.humanoid = nil
    return v24
end

local function CurrentSpeed(v25) -- line 61
    return v25.appliedSpeed
end

v7.CurrentSpeed = CurrentSpeed

local function BaseSpeed(v26) -- line 64
    return v26.baseSpeed
end

v7.BaseSpeed = BaseSpeed

local function Modifiers(v27) -- line 67
    return v27.modifiers
end

v7.Modifiers = Modifiers

function v7.Bind(v28, v29) -- line 70 | captures: v4
    v4(v29)
    if v28.humanoid ~= v29 then
        v28.humanoid = v29
        if v29 then
            v29.WalkSpeed = v28.appliedSpeed
        end
    end
end

function v7.Rebase(v30, v31) -- line 80 | captures: v3, foldModifiers
    v3(v31)
    local v32 = v31 > 0
    assert(v32)
    if v30.baseSpeed == v31 then
        return
    end
    v30.baseSpeed = v31
    local v33 = foldModifiers(v30.baseSpeed, v30.modifiers)
    local v34 = v33 - v30.appliedSpeed
    if not (math.abs(v34) < 0.001) then
        v30.appliedSpeed = v33
        if v30.humanoid then
            v30.humanoid.WalkSpeed = v33
        end
    end
end

function v7.Attach(v35, v36, v37, v38, v39) -- line 98 | captures: v3, v5, v6, foldModifiers
    v6(v36)
    local v40 = if v37 == "positive" then true else v37 == "malus"
    assert(v40)
    v3(v38)
    v5(v39)
    for v41, v42 in ipairs(v35.modifiers) do
        if v42.id == v36 then
            error((("A modifier called %* is already attached to this stat"):format(v36)))
        end
    end
    local modifiers = v35.modifiers
    local v43 = {
        id = v36,
        type = v37,
        value = v38,
        source = v39
    }
    table.insert(modifiers, v43)
    local v44 = foldModifiers(v35.baseSpeed, v35.modifiers)
    local v45 = v44 - v35.appliedSpeed
    if not (math.abs(v45) < 0.001) then
        v35.appliedSpeed = v44
        if v35.humanoid then
            v35.humanoid.WalkSpeed = v44
        end
    end
end

function v7.HasModifier(v46, v47) -- line 120 | captures: v6
    v6(v47)
    for v48, v49 in ipairs(v46.modifiers) do
        if v49.id == v47 then
            return true
        end
    end
    return false
end

function v7.Detach(v50, v51) -- line 129 | captures: v6, foldModifiers
    v6(v51)
    for v52, v53 in ipairs(v50.modifiers) do
        if v53.id == v51 then
            table.remove(v50.modifiers, v52)
            local v54 = foldModifiers(v50.baseSpeed, v50.modifiers)
            local v55 = v54 - v50.appliedSpeed
            if not (math.abs(v55) < 0.001) then
                v50.appliedSpeed = v54
                if v50.humanoid then
                    v50.humanoid.WalkSpeed = v54
                end
            end
            return
        end
    end
end

function v7.DetachSource(v56, v57) -- line 148 | captures: v6, foldModifiers
    v6(v57)
    local v58 = #v56.modifiers
    local v59 = false
    for v60 = v58, 1, -1 do
        if v56.modifiers[v60].source == v57 then
            table.remove(v56.modifiers, v60)
            v59 = true
        end
    end
    if not v59 then
        return
    end
    local v61 = foldModifiers(v56.baseSpeed, v56.modifiers)
    local v62 = v61 - v56.appliedSpeed
    if not (math.abs(v62) < 0.001) then
        v56.appliedSpeed = v61
        if v56.humanoid then
            v56.humanoid.WalkSpeed = v61
        end
    end
end

local function Destroy(v63) -- line 174
    v63.humanoid = nil
end

v7.Destroy = Destroy
return v7
