-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local None = require(script.Parent.Parent.None)
local copyDeep = require(script.Parent.copyDeep)
local mergeDeep

local function mergeDeep_2(...) -- line 28 | captures: None, copyDeep, mergeDeep
    local v1 = {}
    local v2 = select("#", ...)
    for v3 = 1, v2 do
        local v4 = select(v3, ...)
        if type(v4) == "table" then
            for v5, v6 in pairs(v4) do
                if v6 == None then
                    v1[v5] = nil
                elseif type(v6) == "table" then
                    if v1[v5] == nil then
                        v1[v5] = copyDeep(v6)
                    else
                        local v7 = v1[v5]
                        if type(v7) == "table" then
                            v1[v5] = mergeDeep(v1[v5], v6)
                        else
                            v1[v5] = copyDeep(v6)
                        end
                    end
                else
                    v1[v5] = v6
                end
            end
        end
    end
    return v1
end

mergeDeep = mergeDeep_2
return mergeDeep_2
