-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local peek = require(script.Parent.Parent.Parent.Fusion).peek
return function(v1, v2) -- line 17 | captures: peek
    if peek(v1) == nil then
        if typeof(v1) == "table" and v1.kind == "Value" and v1.set ~= nil then
            v1:set(v2)
            return v1
        end
        return v2
    end
    return v1
end
