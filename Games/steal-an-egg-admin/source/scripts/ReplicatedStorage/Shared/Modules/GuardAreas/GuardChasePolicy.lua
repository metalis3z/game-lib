-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    GetWakingDuration = function() -- GetWakingDuration | line 9
        return 0.63
    end
}

function v1.ResolveHitDistance(v2) -- line 12 | captures: t
    t.strict(t.optional(t.number))(v2)
    local v3 = v2 or 10
    local v4 = v3 > 0
    assert(v4)
    return v3
end

function v1.ResolveWalkSpeed(v5, v6, v7) -- line 20 | captures: t
    t.strict(t.number)(v5)
    t.strict(t.number)(v6)
    t.strict(t.number)(v7)
    local v8 = v5 > 0
    assert(v8)
    local v9 = v6 > 0
    assert(v9)
    local v10 = v7 >= 0
    assert(v10)
    local v11 = math.max(v6, 0.001)
    if v7 <= v11 then
        return v5
    end
    local v12 = v5 * ((v7 / v11 - 1) * 0.5 + 1)
    local v13 = v5 * 4
    return (math.min(v12, v13))
end

function v1.ResolveCatchDuration(v14, v15, v16, v17, v18) -- line 40 | captures: t, v1
    t.strict(t.number)(v14)
    t.strict(t.number)(v15)
    t.strict(t.number)(v16)
    t.strict(t.number)(v17)
    t.strict(t.number)(v18)
    local v19 = v14 > 0
    assert(v19)
    local v20 = v15 > 0
    assert(v20)
    local v21 = v16 > 0
    assert(v21)
    local v22 = v17 >= 0
    assert(v22)
    local v23 = v18 >= 0
    assert(v23)
    if v17 <= v16 then
        return 0
    end
    if v1.ResolveWalkSpeed(v14, v15, v16) <= v18 then
        return nil
    end
    local v24 = math.max(v15, 0.001)
    local v25 = v24 * 7
    local v26 = math.max(v16, v25)
    local v27 = if v26 < v17 then 0 + (v17 - v26) / (v14 * 4 - v18) else 0
    local v28 = math.max(v16, v24)
    local v29 = math.min(v17, v25)
    if v28 < v29 then
        local v30 = v14 * 0.5 / v24
        local v31 = v14 * 0.5
        local v32 = (v31 + v30 * v29 - v18) / (v31 + v30 * v28 - v18)
        v27 += math.log(v32) / v30
    end
    local v33 = math.min(v17, v24)
    if v16 < v33 then
        v27 += (v33 - v16) / (v14 - v18)
    end
    return v27
end

return v1
