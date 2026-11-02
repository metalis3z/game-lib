-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local GetLuminance = require(script.Parent.Parent.GetLuminance)
local Schema = require(script.Parent.Parent.Util.Schema)
require(script.Parent.Parent.Util.Types)
local Vibrant = Assert.prepArrayOf("Vibrant")
local abs = math.abs
local sqrt = math.sqrt
local toHSV = Color3.toHSV
local v1 = {
    TargetLuminance = 0.49,
    TargetSaturation = 1,
    TargetValue = 0.8
}
return function(v2, v3) -- line 51 | captures: GetLuminance, Schema, Vibrant, abs, sqrt, toHSV, v1
    Vibrant("swatches", "Color3", v2)
    local v4 = Schema.Loose(v1, v3)
    local v5
    local v6 = (1/0)
    for v7, v8 in ipairs(v2) do
        local v9, v10, v11 = toHSV(v8)
        local v12 = GetLuminance(v8)
        local v13 = v10 - v4.TargetSaturation
        local v14 = abs(v13)
        local v15 = v11 - v4.TargetValue
        local v16 = abs(v15)
        local v17 = v12 - v4.TargetLuminance
        local v18 = abs(v17)
        local v19 = v14 ^ 2 + v16 ^ 2 + v18 ^ 2
        local v20 = sqrt(v19)
        if v20 < v6 then
            v5 = v8
            v6 = v20
        end
    end
    return v5
end
