-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local FromLAB = require(script.Parent.FromLAB)
local ToLAB = require(script.Parent.ToLAB)

local function lerp(v1, v2, v3) -- line 16 | captures: FromLAB, ToLAB
    local v4 = typeof(v1) == "Color3"
    local v5 = ("Lerp(...): Expected \"from\" to be a Color3, got %*"):format((typeof(v1)))
    assert(v4, v5)
    local v6 = typeof(v2) == "Color3"
    local v7 = ("Lerp(...): Expected \"to\" to be a Color3, got %*"):format((typeof(v2)))
    assert(v6, v7)
    local v8 = typeof(v3) == "number"
    local v9 = ("Lerp(...): Expected \"alpha\" to be a number, got %*"):format((typeof(v3)))
    assert(v8, v9)
    local v10 = ToLAB(v1)
    local v11 = ToLAB(v2)
    local v12 = v10.L * (1 - v3) + v11.L * v3
    local v13 = v10.A * (1 - v3) + v11.A * v3
    local v14 = v10.B * (1 - v3) + v11.B * v3
    return FromLAB({
        L = v12,
        A = v13,
        B = v14
    })
end

return lerp
