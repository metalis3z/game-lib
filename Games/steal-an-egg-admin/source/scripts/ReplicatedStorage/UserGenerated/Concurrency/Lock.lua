-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Finally = require(game.ReplicatedStorage.UserGenerated.Lang.Finally)
local v1 = {}

function v1.Call(v2, v3, ...) -- line 8 | captures: Finally
    local v4 = type(v3) == "function"
    assert(v4)
    while v2.Count > 0 do
        task.wait()
    end
    v2.Count += 1
    return Finally(v3, function() -- line 15 | captures: v2
        v2.Count -= 1
    end, ...)
end

function v1.Try(v5, v6, ...) -- line 20 | captures: Finally
    local v7 = type(v6) == "function"
    assert(v7)
    if v5.Count > 0 then
        return false
    end
    v5.Count += 1
    return true,
        Finally(v6, function() -- line 27 | captures: v5
            v5.Count -= 1
        end, ...)
end

function v1.IsLocked(v8) -- line 33
    return v8.Count > 0
end

local v9 = {}
local v10 = table.freeze({ __index = table.freeze(v1) })

function v9.new() -- line 39 | captures: v10
    local v11 = { Count = 0 }
    return (setmetatable(v11, v10))
end

return table.freeze(v9)
