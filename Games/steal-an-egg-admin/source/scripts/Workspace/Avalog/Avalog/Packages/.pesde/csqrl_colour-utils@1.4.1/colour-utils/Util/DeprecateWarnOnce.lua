-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function deprecateWarnOnce(v1) -- line 1
    return function(v2, v3, v4) -- line 2 | captures: v1
        local v5 = false
        return function(...) -- line 5 | captures: v5, v2, v3, v4, v1
            if not v5 then
                local v6 = v4 and (" and will be removed in %*"):format(v4) or ""
                v5 = true
                warn((("%* is deprecated%*. Please use %* instead."):format(v2, v6, v3)))
            end
            return v1(...)
        end
    end
end

return deprecateWarnOnce
