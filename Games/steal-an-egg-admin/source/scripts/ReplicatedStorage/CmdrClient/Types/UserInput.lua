-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local v1 = Enum.UserInputType:GetEnumItems()
for v2, v3 in pairs(Enum.KeyCode:GetEnumItems()) do
    v1[#v1 + 1] = v3
end
local v4 = {}

function v4.Transform(v5) -- line 12 | captures: Util, v1
    return Util.MakeFuzzyFinder(v1)(v5)
end

local function Validate(v6) -- line 15
    return #v6 > 0
end

v4.Validate = Validate

function v4.Autocomplete(v7) -- line 19 | captures: Util
    return Util.GetNames(v7)
end

local function Parse(v8) -- line 22
    return v8[1]
end

v4.Parse = Parse
return function(v9) -- line 26 | captures: Util, v4
    v9:RegisterType("userInput", v4)
    v9:RegisterType("userInputs", Util.MakeListableType(v4))
end
