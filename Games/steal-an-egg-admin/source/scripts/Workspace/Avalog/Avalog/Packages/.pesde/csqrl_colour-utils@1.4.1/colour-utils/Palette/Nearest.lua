-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function nearest(v1, v2) -- line 12
    local v3 = typeof(v1) == "Color3"
    local v4 = ("Nearest(...): Expected \"to\" to be a Color3, got \"%*\" (%*)"):format(v1, (typeof(v1)))
    assert(v3, v4)
    local v5 = (1/0)
    local v6
    local v7 = false
    for v8, v9 in v2 do
        if typeof(v9) == "Color3" then
            local v10 = (v9.R - v1.R) ^ 2 + (v9.G - v1.G) ^ 2 + (v9.B - v1.B) ^ 2
            local v11 = math.sqrt(v10)
            if v11 < v5 then
                v5 = v11
                v6 = v9
            end
        elseif v7 == false then
            warn((("Nearest(...): Expected \"colors\" to be an array of Color3, got \"%*\" (%*) at index #%*"):format(v9, typeof(v9), v8)))
            v7 = true
        end
    end
    return v6
end

return nearest
