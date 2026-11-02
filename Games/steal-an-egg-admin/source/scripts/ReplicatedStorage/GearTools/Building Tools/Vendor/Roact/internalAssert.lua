-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function internalAssert(v1, v2) -- line 1
    if not v1 then
        error(v2 .. " (This is probably a bug in Roact!)", 3)
    end
end

return internalAssert
