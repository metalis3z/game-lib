-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local v1 = { "^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$" }
return function(v2) -- line 8 | captures: Util, v1
    local v3 = {}

    function v3.Autocomplete(v4) -- line 10 | captures: v2
        local v5 = v2:GetStore("vars_used") or {}
        return v2.Cmdr.Util.MakeFuzzyFinder(v2.Cmdr.Util.DictionaryKeys(v5))(v4)
    end

    function v3.Validate(v6) -- line 17 | captures: v1
        for v7, v8 in ipairs(v1) do
            if v6:match(v8) then
                return true
            end
        end
        return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
    end

    function v3.Parse(v9) -- line 25
        return v9
    end

    v2:RegisterType("storedKey", v3)
    v2:RegisterType("storedKeys", Util.MakeListableType(v3))
end
