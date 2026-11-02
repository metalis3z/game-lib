-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = require(script.Parent.copy)

local function shuffle(v1) -- line 19 | captures: copy
    local v2 = Random.new(os.time() * #v1)
    local v3 = copy(v1)
    local v4 = #v3
    for v5 = v4, 1, -1 do
        local v6 = v2:NextInteger(1, v5)
        local v7 = v3[v5]
        v3[v5] = v3[v6]
        v3[v6] = v7
    end
    return v3
end

return shuffle
