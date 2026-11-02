-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Shared.Util)
local v1 = {
    Validate = function(v2) -- Validate | line 8
        if v2:match("^https?://.+$") then
            return true
        end
        return false, "URLs must begin with http:// or https://"
    end,
    Parse = function(v3) -- Parse | line 14
        return v3
    end
}
return function(v4) -- line 18 | captures: Util, v1
    v4:RegisterType("url", v1)
    v4:RegisterType("urls", Util.MakeListableType(v1))
end
