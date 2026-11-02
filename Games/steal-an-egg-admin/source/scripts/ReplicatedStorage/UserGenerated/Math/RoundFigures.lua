-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10)
return function(v1, v2, v3, v4) -- line 8 | captures: StableExp10
    local v5 = type(v1) == "number"
    assert(v5)
    local v6 = if v2 == nil then true else type(v2) == "number"
    assert(v6)
    local v7 = if v3 == nil then true else type(v3) == "number"
    assert(v7)
    local v8 = if v4 == nil then true else type(v4) == "function"
    assert(v8)
    local v9, v10, v11
    if v1 == v1 then
        if v1 == (1/0) or v1 == (-1/0) then
            v11 = true
        else
            v9 = v3 or 1
            v10 = v4 or math.round
            v11 = false
        end
    else
        v11 = true
    end
    if v11 then
        return v1
    end
    local v12 = math.sign(v1)
    if v12 == 0 then
        return 0
    end
    local v13 = v1 * v12
    local v14 = math.log10(v13)
    local v15 = math.floor(v14) - (v2 or 3) + 1
    if v9 ~= 1 then
        v13 /= v9
    end
    local v16 = v10((StableExp10(v13, -v15)))
    return StableExp10(v16 * v9, v15) * v12
end
