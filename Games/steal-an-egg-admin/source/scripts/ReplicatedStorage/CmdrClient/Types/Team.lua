-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Teams = game:GetService("Teams")
local Util = require(script.Parent.Parent.Shared.Util)
local v1 = {}

function v1.Transform(v2) -- line 9 | captures: Teams, Util
    return Util.MakeFuzzyFinder(Teams:GetTeams())(v2)
end

local function Validate(v3) -- line 12
    return #v3 > 0, "No team with that name could be found."
end

v1.Validate = Validate

function v1.Autocomplete(v4) -- line 16 | captures: Util
    return Util.GetNames(v4)
end

local function Parse(v5) -- line 19
    return v5[1]
end

v1.Parse = Parse

local v6 = {
    Listable = true,
    Transform = v1.Transform,
    Validate = v1.Validate,
    Autocomplete = v1.Autocomplete,
    Parse = function(v7) -- Parse | line 28
        return v7[1]:GetPlayers()
    end
}
local v8 = {
    Transform = v1.Transform,
    Validate = v1.Validate,
    Autocomplete = v1.Autocomplete,
    Parse = function(v9) -- Parse | line 36
        return v9[1].TeamColor
    end
}
return function(v10) -- line 40 | captures: Util, v1, v6, v8
    v10:RegisterType("team", v1)
    v10:RegisterType("teams", Util.MakeListableType(v1))
    v10:RegisterType("teamPlayers", v6)
    v10:RegisterType("teamColor", v8)
    v10:RegisterType("teamColors", Util.MakeListableType(v8))
end
