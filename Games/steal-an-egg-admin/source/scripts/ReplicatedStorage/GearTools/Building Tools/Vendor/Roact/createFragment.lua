-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ElementKind = require(script.Parent.ElementKind)
local Type = require(script.Parent.Type)

local function createFragment(v1) -- line 4 | captures: ElementKind, Type
    local v2 = {}
    v2[Type] = Type.Element
    v2[ElementKind] = ElementKind.Fragment
    v2.elements = v1
    return v2
end

return createFragment
