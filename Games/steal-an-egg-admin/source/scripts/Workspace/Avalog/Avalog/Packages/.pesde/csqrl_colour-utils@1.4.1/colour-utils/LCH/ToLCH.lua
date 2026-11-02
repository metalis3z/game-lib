-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local LAB = require(script.Parent.Parent.LAB)
local Constants = require(script.Parent.Constants)
local round = math.round
local atan2 = math.atan2
local sqrt = math.sqrt

local function LABtoLCH(v1) -- line 10 | captures: Constants, round, atan2, sqrt
    local v2 = v1.A ^ 2 + v1.B ^ 2
    local v3 = sqrt(v2)
    local B = v1.B
    local A = v1.A
    local v4 = (atan2(B, A) * Constants.RAD_DEG + 360) % 360
    local v5 = v3 * 10000
    if round(v5) == 0 then
        v4 = Constants.NaN
    end
    return {
        L = v1.L,
        C = v3,
        H = v4
    }
end

local function ToLCH(v6) -- line 32 | captures: Assert, LAB, LABtoLCH
    Assert.typeOf("ToLCH", "color", "Color3", v6)
    local v7 = LAB.toLAB(v6)
    return (LABtoLCH(v7))
end

return ToLCH
