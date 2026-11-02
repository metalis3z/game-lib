-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    EggDisplayName = "Dragon Egg",
    RewardEggDisplayName = "Dragon's Egg",
    MaxCountedReturns = 10,
    BaseAssetScale = 0.3,
    AssetScalePerReturn = 0.42,
    NestBaseScale = 0.3,
    NestScalePerReturn = 0.42,
    DropTable = {
        { "Baby Aurora Dragon", 85, -8.5 },
        { "Shadow Dragon", 13.5, 1.25 },
        { "Ember Dragon", 1, 6.5 },
        { "Void Dragon", 0.5, 0.75 }
    }
}
local v2 = {}
local v3 = { "Shadow Dragon", 35 }
local v4 = { "Ember Dragon", 15 }
local v5 = { "Void Dragon", 5 }

v2[1] = { "Baby Aurora Dragon", 45 }
v2[2] = v3
v2[3] = v4
v2[4] = v5
v1.RestoreDropTable = v2
v1.RewardCategory = "ScorchedDragon"
v1.CarryCategory = "Baby Aurora Dragon"

function v1.GetCountedReturns(v6) -- line 33 | captures: v1
    local v7 = math.floor(v6)
    local MaxCountedReturns = v1.MaxCountedReturns
    return (math.clamp(v7, 0, MaxCountedReturns))
end

function v1.GetEntryWeight(v8, v9) -- line 37 | captures: v1
    local v10 = v8[2] + v8[3] * v1.GetCountedReturns(v9)
    return (math.max(v10, 0))
end

function v1.GetTotalWeight(v11) -- line 41 | captures: v1
    local v12 = 0
    for v13, v14 in v1.DropTable do
        v12 += v1.GetEntryWeight(v14, v11)
    end
    return v12
end

function v1.RollRestore() -- line 51 | captures: v1
    local v15 = Random.new()
    local v16 = 0
    for v17, v18 in v1.RestoreDropTable do
        v16 += v18[2]
    end
    local v19 = 0
    for v20, v21 in v1.DropTable do
        v19 += v21[2]
        if v15:NextNumber() * v16 <= v19 then
            return v21[1]
        end
    end
    error((("[%*] Roll out of bounds exception"):format(script.Name)))
end

function v1.Roll(v22, v23) -- line 72 | captures: v1
    local v24 = #v1.DropTable > 0
    assert(v24, "DragonEgg.DropTable is empty")
    local v25 = v23 or Random.new()
    local v26 = v1.GetTotalWeight(v22)
    if v26 <= 0 then
        return v1.DropTable[1][1]
    end
    local v27 = 0
    for v28, v29 in v1.DropTable do
        v27 += v1.GetEntryWeight(v29, v22)
        if v25:NextNumber() * v26 <= v27 then
            return v29[1]
        end
    end
    return v1.DropTable[#v1.DropTable][1]
end

function v1.GetAssetScale(v30) -- line 96 | captures: v1
    return v1.BaseAssetScale + v1.AssetScalePerReturn * v1.GetCountedReturns(v30)
end

function v1.GetNestVisualScale(v31) -- line 99 | captures: v1
    return v1.NestBaseScale + v1.NestScalePerReturn * v1.GetCountedReturns(v31)
end

function v1.IsEventCategory(v32) -- line 102 | captures: v1
    if v32 ~= nil then
        if v32 == v1.RewardCategory then
            return true
        end
        for v33, v34 in v1.DropTable do
            if v34[1] == v32 then
                return true
            end
        end
    end
    return false
end

return v1
