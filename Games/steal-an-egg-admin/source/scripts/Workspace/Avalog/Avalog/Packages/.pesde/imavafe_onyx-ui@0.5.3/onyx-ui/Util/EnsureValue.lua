-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Fusion = require(script.Parent.Parent.Parent.Fusion)
local peek = Fusion.peek
return function(v1, v2) -- line 17 | captures: Fusion, peek
    if not (typeof(v2) == "table" and v2.kind == "Value") then
        return Fusion.Value(v1, peek(v2))
    end
    return v2
end
