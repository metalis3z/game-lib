-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local External = require(script.Parent.Parent.External)

local function merge(v1, v2, ...) -- line 13 | captures: External
    local v3 = { ... }
    if not (#v3 < 1) then
        for v4, v5 in v3 do
            for v6, v7 in v5 do
                if v2[v6] == nil then
                    v2[v6] = v7
                elseif not v1 then
                    External.logError("mergeConflict", nil, (tostring(v6)))
                end
            end
        end
    end
    return v2
end

return merge
