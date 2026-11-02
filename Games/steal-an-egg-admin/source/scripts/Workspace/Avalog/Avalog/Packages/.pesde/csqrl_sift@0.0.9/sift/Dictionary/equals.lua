-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Util = require(Parent.Util)
require(Parent.Types)

local function compare(v1, v2) -- line 7
    if not (type(v1) == "table" and type(v2) == "table") then
        return v1 == v2
    end
    for v3, v4 in pairs(v1) do
        if v2[v3] ~= v4 then
            return false
        end
    end
    for v5, v6 in pairs(v2) do
        if v1[v5] ~= v6 then
            return false
        end
    end
    return true
end

local function equals(...) -- line 45 | captures: Util, compare
    if not Util.equalObjects(...) then
        local v7 = select("#", ...)
        local v8 = select(1, ...)
        for v9 = 2, v7 do
            local v10 = select(v9, ...)
            if not compare(v8, v10) then
                return false
            end
        end
    end
    return true
end

return equals
