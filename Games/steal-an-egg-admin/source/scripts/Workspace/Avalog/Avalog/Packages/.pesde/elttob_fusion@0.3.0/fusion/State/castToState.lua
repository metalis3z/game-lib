-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function castToState(v1) -- line 13
    if not (typeof(v1) == "table" and v1.type == "State") then
        return nil
    end
    return v1
end

return castToState
