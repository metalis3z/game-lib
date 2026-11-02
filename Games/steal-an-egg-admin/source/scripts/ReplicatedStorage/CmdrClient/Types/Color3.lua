-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local v1 = Util.MakeSequenceType({
    Prefixes = "# hexColor3 ! brickColor3",
    Length = 3,
    ValidateEach = function(v2, v3) -- ValidateEach | line 10
        if v2 == nil then
            return false, ("Invalid or missing number at position %d in Color3 type."):format(v3)
        end
        if v2 < 0 or v2 > 255 then
            return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(v3)
        end
        if v2 % 1 == 0 then
            return true
        end
        return false, ("Number is not an integer at position %d in Color3 type."):format(v3)
    end,
    TransformEach = tonumber,
    Constructor = Color3.fromRGB
})

local function parseHexDigit(v4) -- line 25
    local v5 = if #v4 == 1 then v4 .. v4 else v4
    return (tonumber(v5, 16))
end

local v6 = {}

function v6.Transform(v7) -- line 35 | captures: Util, parseHexDigit
    local v8, v9, v10 = v7:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
    return Util.Each(parseHexDigit, v8, v9, v10)
end

local function Validate(v11, v12, v13) -- line 40
    local v14 = if v11 == nil or v12 == nil then false else v13 ~= nil
    return v14, "Invalid hex color"
end

v6.Validate = Validate

local function Parse(...) -- line 44
    return Color3.fromRGB(...)
end

v6.Parse = Parse
return function(v15) -- line 48 | captures: Util, v1, v6
    v15:RegisterType("color3", v1)
    v15:RegisterType("color3s", Util.MakeListableType(v1, { Prefixes = "# hexColor3s ! brickColor3s" }))
    v15:RegisterType("hexColor3", v6)
    v15:RegisterType("hexColor3s", Util.MakeListableType(v6))
end
