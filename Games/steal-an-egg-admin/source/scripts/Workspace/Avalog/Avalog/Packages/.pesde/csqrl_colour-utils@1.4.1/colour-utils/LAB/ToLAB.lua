-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local Constants = require(script.Parent.Constants)

local function RGB_XYZ(v1) -- line 4
    if v1 <= 0.04045 then
        return v1 / 12.92
    end
    return ((v1 + 0.055) / 1.055) ^ 2.4
end

local function XYZ_LAB(v2) -- line 12 | captures: Constants
    if Constants.t3 < v2 then
        return v2 ^ 0.3333333333333333
    end
    return v2 / Constants.t2 + Constants.t0
end

local function ToVector3(v3) -- line 20 | captures: Constants
    local R = v3.R
    local v4 = if R <= 0.04045 then R / 12.92 else ((R + 0.055) / 1.055) ^ 2.4
    local G = v3.G
    local v5 = if G <= 0.04045 then G / 12.92 else ((G + 0.055) / 1.055) ^ 2.4
    local B = v3.B
    local v6 = if B <= 0.04045 then B / 12.92 else ((B + 0.055) / 1.055) ^ 2.4
    local v7 = (v4 * 0.4124564 + v5 * 0.3575761 + v6 * 0.1804375) / Constants.Xn
    local v8 = if Constants.t3 < v7 then v7 ^ 0.3333333333333333 else v7 / Constants.t2 + Constants.t0
    local v9 = (v4 * 0.2126729 + v5 * 0.7151522 + v6 * 0.072175) / Constants.Yn
    local v10 = if Constants.t3 < v9 then v9 ^ 0.3333333333333333 else v9 / Constants.t2 + Constants.t0
    local v11 = (v4 * 0.0193339 + v5 * 0.119192 + v6 * 0.9503041) / Constants.Zn
    local v12 = if Constants.t3 < v11 then v11 ^ 0.3333333333333333 else v11 / Constants.t2 + Constants.t0
    return (Vector3.new(v8, v10, v12))
end

local function ToLAB(v13) -- line 39 | captures: Assert, ToVector3
    Assert.typeOf("ToLAB", "color", "Color3", v13)
    local v14 = ToVector3(v13)
    local v15 = v14.Y * 116 - 16
    local v16 = {}
    if v15 < 0 then
        v15 = 0
    end
    v16.L = v15
    v16.A = (v14.X - v14.Y) * 500
    v16.B = (v14.Y - v14.Z) * 200
    return v16
end

return ToLAB
