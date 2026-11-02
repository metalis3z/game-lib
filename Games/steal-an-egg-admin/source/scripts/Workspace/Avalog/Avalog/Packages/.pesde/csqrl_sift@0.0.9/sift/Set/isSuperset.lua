-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local isSubset = require(script.Parent.isSubset)

local function isSuperset(v1, v2) -- line 21 | captures: isSubset
    return isSubset(v2, v1)
end

return isSuperset
