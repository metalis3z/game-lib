-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Util)
local copy = require(script.Parent.copy)

local function call(v1, v2) -- line 10
    if type(v1) == "function" then
        return v1(v2)
    end
end

local function update(v3, v4, v5, v6) -- line 44 | captures: Util, copy
    local v7 = #v3
    local v8 = copy(v3)
    local v9 = if v4 < 1 then v4 + v7 else v4
    local v10 = if type(v5) == "function" then v5 else Util.func.returned
    if v8[v9] == nil then
        if type(v6) == "function" then
            v8[v9] = v6(v9)
        else
            v8[v9] = nil
        end
    else
        v8[v9] = v10(v8[v9], v9)
    end
    return v8
end

return update
