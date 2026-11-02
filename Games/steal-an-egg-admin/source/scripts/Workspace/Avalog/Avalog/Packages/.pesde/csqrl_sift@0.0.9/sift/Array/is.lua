-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function is(v1) -- line 21
    if typeof(v1) == "table" and #v1 > 0 then
        return next(v1, #v1) == nil
    end
    return false
end

return is
