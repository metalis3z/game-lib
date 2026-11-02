-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local None = require(script.Parent.Parent.None)

local function concat(...) -- line 26 | captures: None
    local v1 = {}
    local v2 = select("#", ...)
    for v3 = 1, v2 do
        local v4 = select(v3, ...)
        if type(v4) == "table" then
            for v5, v6 in ipairs(v4) do
                if v6 ~= None then
                    table.insert(v1, v6)
                end
            end
        end
    end
    return v1
end

return concat
