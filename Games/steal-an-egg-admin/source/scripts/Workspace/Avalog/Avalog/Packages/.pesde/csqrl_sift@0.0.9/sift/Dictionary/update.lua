-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = require(script.Parent.copy)

local function update(v1, v2, v3, v4) -- line 30 | captures: copy
    local v5 = copy(v1)
    if v5[v2] then
        if v3 then
            v5[v2] = v3(v5[v2], v2)
            return v5
        end
    elseif typeof(v4) == "function" then
        v5[v2] = v4(v2)
    end
    return v5
end

return update
