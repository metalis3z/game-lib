-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function equalObjects(...) -- line 20
    local v1 = select(1, ...)
    local v2 = select("#", ...)
    for v3 = 2, v2 do
        if v1 ~= select(v3, ...) then
            return false
        end
    end
    return true
end

return equalObjects
