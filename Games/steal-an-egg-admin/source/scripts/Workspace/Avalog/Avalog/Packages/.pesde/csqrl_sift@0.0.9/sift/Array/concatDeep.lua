-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local copyDeep = require(script.Parent.copyDeep)
local None = require(Parent.None)

local function concatDeep(...) -- line 28 | captures: copyDeep, None
    local function v1(v2, ...)
        table.insert(v2, ...)
    end

    local v3 = {}
    local v4 = select("#", ...)
    for v5 = 1, v4 do
        local v6 = select(v5, ...)
        if type(v6) == "table" then
            for v7, v8 in ipairs(v6) do
                if v8 ~= None then
                    if type(v8) == "table" then
                        v1(v3, copyDeep(v8))
                    else
                        table.insert(v3, v8)
                    end
                end
            end
        end
    end
    return v3
end

return concatDeep
