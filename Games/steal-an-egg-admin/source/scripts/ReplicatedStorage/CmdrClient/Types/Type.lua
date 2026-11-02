-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
return function(v1) -- line 7 | captures: Util
    local v2 = {}

    function v2.Transform(v3) -- line 9 | captures: v1, Util
        return Util.MakeFuzzyFinder(v1:GetTypeNames())(v3)
    end

    function v2.Validate(v4) -- line 13
        return #v4 > 0, "No type with that name could be found."
    end

    function v2.Autocomplete(v5) -- line 17
        return v5
    end

    function v2.Parse(v6) -- line 20
        return v6[1]
    end

    v1:RegisterType("type", v2)
    v1:RegisterType("types", Util.MakeListableType(v2))
end
