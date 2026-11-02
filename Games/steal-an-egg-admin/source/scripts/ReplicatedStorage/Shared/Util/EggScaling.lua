-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventEggCategories = require(ReplicatedStorage.Shared.Util.EventEggCategories)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.Spatial).ModelBounds
local v1 = t.numberMinExclusive((-1/0))
local v2 = t.intersection(v1, t.numberMaxExclusive((1/0)))
local v3 = t.strict(v2)
local v4 = t.strict(function(v5) -- line 13 | captures: v2
    if typeof(v5) == "Vector3" then
        return v2(v5.X) and v2(v5.Y) and v2(v5.Z)
    end
    return false
end)
local v6 = t.strict(t.optional(t.string))
local v7 = t.strict(t.instanceIsA("Model"))
local v8 = {}

function v8.ClampSaved(v9) -- line 29 | captures: v3
    v3(v9)
    return (math.clamp(v9, 0.002, 200))
end

function v8.FloorForCategory(v10, v11) -- line 33 | captures: EventEggCategories, v3, v6
    v3(v10)
    v6(v11)
    if EventEggCategories.IsEventEgg(v11) then
        return v10 * 1
    end
    return v10 * 0.6
end

function v8.RawVisual(v12, v13) -- line 41 | captures: v3
    v3(v12)
    v3(v13)
    return v12 * math.max(v13, 0.002)
end

function v8.LiftToFloor(v14, v15, v16) -- line 47 | captures: v3, v8
    v3(v14)
    v3(v15)
    local v17 = v8.FloorForCategory(v14, v16)
    return (math.max(v17, v15))
end

function v8.PreGrowthVisual(v18, v19, v20) -- line 53 | captures: v8
    local v21 = v8.RawVisual(v18, v19)
    local v22 = v8.FloorForCategory(v18, v20)
    return (math.max(v21, v22))
end

function v8.PlacedStart(v23, v24, v25) -- line 61 | captures: v8
    return v8.PreGrowthVisual(v23, v24, v25)
end

function v8.PlacedTarget(v26, v27, v28) -- line 64 | captures: v8
    local v29 = v8.RawVisual(v26, v27)
    local v30 = v8.FloorForCategory(v26, v28)
    if v29 < v30 then
        return v30
    end
    return v29 * 3
end

function v8.FitInside(v31, v32) -- line 72 | captures: ModelBounds, v4, v7, v8
    v7(v31)
    v4(v32)
    local v33, v34 = ModelBounds(v31)
    _ = v33
    local X = v32.X
    local X_2 = v34.X
    local v35 = X / math.max(X_2, 0.002)
    local Y = v32.Y
    local Y_2 = v34.Y
    local v36 = Y / math.max(Y_2, 0.002)
    local Z = v32.Z
    local Z_2 = v34.Z
    local v37 = Z / math.max(Z_2, 0.002)
    local v38 = math.min(v35, v36, v37) * 0.92
    return v8.ClampSaved(v31:GetScale() * v38)
end

v8.MIN_EGG_SCALE = 0.8
v8.MAX_EGG_SCALE = 3
v8.MIN_ICON_SCALE = 0.5
v8.MAX_ICON_SCALE = 1.1

local function IconScaleFor(v39) -- line 86
    if typeof(v39) == "number" and v39 == v39 and not (v39 <= 0) then
        return (math.clamp(v39, 0.8, 3) - 0.8) / 2.2 * 0.6000000000000001 + 0.5
    end
    return 1.1
end

v8.IconScaleFor = IconScaleFor

function v8.FitIconToEgg(v40, v41) -- line 92 | captures: v8
    local v42 = v8.IconScaleFor(v41)
    v40.Size = UDim2.fromScale(v42, v42)
end

return v8
