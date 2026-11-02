-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local reduce = require(script.Parent.reduce)

local function zip(...) -- line 20 | captures: reduce
    local v1 = select("#", ...)
    local v2 = { ... }
    local v3 = {}
    if v1 ~= 0 then
        local v4 = reduce(v2, function(v5, v6) -- line 30
            local v7 = #v6
            return (math.min(v5, v7))
        end, #v2[1])
        for v8 = 1, v4 do
            local v9 = {}
            for v10, v11 in ipairs(v2) do
                local v12 = v11[v8]
                table.insert(v9, v12)
            end
            table.insert(v3, v9)
        end
    end
    return v3
end

return zip
