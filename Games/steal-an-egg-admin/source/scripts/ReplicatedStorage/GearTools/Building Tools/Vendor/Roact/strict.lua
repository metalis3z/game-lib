-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function strict(v1, v2) -- line 1
    local v3 = v2 or tostring(v1)
    local v4 = {
        __index = function(v5, v6) -- __index | line 5 | captures: v3
            local v7 = ("%q (%s) is not a valid member of %s"):format(tostring(v6), typeof(v6), v3)
            error(v7, 2)
        end,
        __newindex = function(v8, v9, v10) -- __newindex | line 15 | captures: v3
            local v11 = ("%q (%s) is not a valid member of %s"):format(tostring(v9), typeof(v9), v3)
            error(v11, 2)
        end
    }
    return (setmetatable(v1, v4))
end

return strict
