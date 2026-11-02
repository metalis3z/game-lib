-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Nil = require(script.Parent.Symbol).named("Nil")
local v1 = {}

local function getDefaultInstanceProperty(v2, v3) -- line 16 | captures: Nil, v1
    local v4 = v1[v2]
    local v5, v6, v7
    if v4 then
        v5 = v4[v3]
        if v5 == Nil then
            return true, nil
        end
        v6 = v5 == nil
    else
        v7 = {}
        v1[v2] = v7
    end
    if v4 and v6 or not v4 then
        local v8 = v4 or v7
        local v9 = Instance.new(v2)
        local v10, v11 = pcall(function() -- line 37 | captures: v3, v9
            return v9[v3]
        end)
        v9:Destroy()
        if v10 then
            if v11 == nil then
                v8[v3] = Nil
                return v10, v11
            end
            v8[v3] = v11
        end
        return v10, v11
    end
    return true, v5
end

return getDefaultInstanceProperty
