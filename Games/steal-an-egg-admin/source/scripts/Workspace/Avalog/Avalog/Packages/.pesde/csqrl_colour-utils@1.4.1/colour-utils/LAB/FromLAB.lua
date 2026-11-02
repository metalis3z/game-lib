-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local isNaN = require(script.Parent.Parent.Util.isNaN)
local Constants = require(script.Parent.Constants)

local function XYZ_RGB(v1) -- line 6
    local v2 = if v1 <= 0.00304 then v1 * 12.92 else v1 ^ 0.4166666666666667 * 1.055 - 0.055
    return v2 * 255
end

local function LAB_XYZ(v3) -- line 10 | captures: Constants
    if Constants.t1 < v3 then
        return v3 ^ 3
    end
    return Constants.t2 * (v3 - Constants.t0)
end

local function FromLAB(v4) -- line 21 | captures: Assert, isNaN, Constants
    Assert.typeOf("FromLAB", "lab", "table", v4)
    Assert.typeOf("FromLAB", "lab.L", "number", v4.L)
    Assert.typeOf("FromLAB", "lab.A", "number", v4.A)
    Assert.typeOf("FromLAB", "lab.B", "number", v4.B)
    local v5 = (v4.L + 16) / 116
    local v6 = if isNaN(v4.A) then v5 else v5 + v4.A / 500
    local v7 = if isNaN(v4.B) then v5 else v5 - v4.B / 200
    local Yn = Constants.Yn
    local v8 = if Constants.t1 < v5 then v5 ^ 3 else Constants.t2 * (v5 - Constants.t0)
    local v9 = Yn * v8
    local Xn = Constants.Xn
    local v10 = if Constants.t1 < v6 then v6 ^ 3 else Constants.t2 * (v6 - Constants.t0)
    local v11 = Xn * v10
    local Zn = Constants.Zn
    local v12 = if Constants.t1 < v7 then v7 ^ 3 else Constants.t2 * (v7 - Constants.t0)
    local v13 = Zn * v12
    local v14 = 3.2404542 * v11 - 1.5371385 * v9 - 0.4985314 * v13
    local v15 = if v14 <= 0.00304 then v14 * 12.92 else v14 ^ 0.4166666666666667 * 1.055 - 0.055
    local v16 = v15 * 255
    local v17 = -0.969266 * v11 + 1.8760108 * v9 + 0.041556 * v13
    local v18 = if v17 <= 0.00304 then v17 * 12.92 else v17 ^ 0.4166666666666667 * 1.055 - 0.055
    local v19 = v18 * 255
    local v20 = 0.0556434 * v11 - 0.2040259 * v9 + 1.0572252 * v13
    local v21 = if v20 <= 0.00304 then v20 * 12.92 else v20 ^ 0.4166666666666667 * 1.055 - 0.055
    local v22 = v21 * 255
    return Color3.fromRGB(v16, v19, v22)
end

return FromLAB
