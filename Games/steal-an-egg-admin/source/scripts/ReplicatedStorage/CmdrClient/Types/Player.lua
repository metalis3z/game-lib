-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local Players = game:GetService("Players")
local v1 = {}

function v1.Transform(v2) -- line 9 | captures: Util, Players
    return Util.MakeFuzzyFinder(Players:GetPlayers())(v2)
end

local function Validate(v3) -- line 12
    return #v3 > 0, "No player with that name could be found."
end

v1.Validate = Validate

function v1.Autocomplete(v4) -- line 16 | captures: Util
    return Util.GetNames(v4)
end

local function Parse(v5) -- line 19
    return v5[1]
end

v1.Parse = Parse

local function Default(v6) -- line 22
    return v6.Name
end

v1.Default = Default
v1.ArgumentOperatorAliases = {
    me = ".",
    all = "*",
    others = "**",
    random = "?"
}
return function(v7) -- line 27 | captures: Util, v1
    v7:RegisterType("player", v1)
    v7:RegisterType("players", Util.MakeListableType(v1, { Prefixes = "% teamPlayers" }))
end
