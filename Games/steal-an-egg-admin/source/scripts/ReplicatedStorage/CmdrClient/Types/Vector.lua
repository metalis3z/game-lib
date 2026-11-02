-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)

local function validateVector(v1, v2) -- line 7
    if v1 == nil then
        return false, ("Invalid or missing number at position %d in Vector type."):format(v2)
    end
    return true
end

local v3 = Util.MakeSequenceType({
    Length = 3,
    ValidateEach = validateVector,
    TransformEach = tonumber,
    Constructor = Vector3.new
})
local v4 = Util.MakeSequenceType({
    Length = 2,
    ValidateEach = validateVector,
    TransformEach = tonumber,
    Constructor = Vector2.new
})
return function(v5) -- line 15 | captures: Util, v3, v4
    v5:RegisterType("vector3", v3)
    v5:RegisterType("vector3s", Util.MakeListableType(v3))
    v5:RegisterType("vector2", v4)
    v5:RegisterType("vector2s", Util.MakeListableType(v4))
end
