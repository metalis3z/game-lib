-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Assert = require(script.Parent.Parent.Util.Assert)
local isNaN = require(script.Parent.Parent.Util.isNaN)
local Constants = require(script.Parent.Constants)
local LAB = require(script.Parent.Parent.LAB)
local sin = math.sin
local cos = math.cos

local function LCHtoLAB(v1) -- line 10 | captures: isNaN, Constants, sin, cos
    if isNaN(v1.H) then
        v1.H = 0
    end
    v1.H *= Constants.DEG_RAD
    local v2 = { L = v1.L }
    local H = v1.H
    v2.A = cos(H) * v1.C
    local H_2 = v1.H
    v2.B = sin(H_2) * v1.C
    return v2
end

local function FromLCH(v3) -- line 31 | captures: Assert, LAB, LCHtoLAB
    Assert.typeOf("FromLCH", "lch", "table", v3)
    Assert.typeOf("FromLCH", "lch.L", "number", v3.L)
    Assert.typeOf("FromLCH", "lch.C", "number", v3.C)
    Assert.typeOf("FromLCH", "lch.H", "number", v3.H)
    local v4 = LCHtoLAB(v3)
    return LAB.fromLAB(v4)
end

return FromLCH
