-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Util)

local function compare(v1, v2) -- line 6
    if not (type(v1) == "table" and type(v2) == "table") then
        return v1 == v2
    end
    local v3 = #v1
    if #v2 == v3 then
        for v4 = 1, v3 do
            if v1[v4] ~= v2[v4] then
                return false
            end
        end
        return true
    end
    return false
end

local function equals(...) -- line 44 | captures: Util, compare
    if not Util.equalObjects(...) then
        local v5 = select("#", ...)
        local v6 = select(1, ...)
        for v7 = 2, v5 do
            local v8 = select(v7, ...)
            if not compare(v6, v8) then
                return false
            end
        end
    end
    return true
end

return equals
