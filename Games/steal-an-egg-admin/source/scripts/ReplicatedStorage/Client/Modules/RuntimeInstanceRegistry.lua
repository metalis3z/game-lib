-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.string)
local v2 = t.strict(t.optional(t.string))
local v3 = t.strict(t.Instance)
local v4 = {}
local v5 = { Changed = Signal.new() }

function v5.Peek(v6, v7) -- line 15 | captures: v1, v4
    v1(v6)
    v1(v7)
    local v8 = v4[v6]
    local v9 = if v8 then v8[v7] else nil
    if v9 and v9.Parent then
        return v9
    end
    return nil
end

function v5.Bind(v10, v11, v12) -- line 34 | captures: v1, v3, v4, v5
    v1(v10)
    v1(v11)
    v3(v12)
    local v13 = v4[v10] or {}
    v4[v10] = v13
    v13[v11] = v12
    v5.Changed:Fire(v10, v11, v12)
end

function v5.Demand(v14, v15) -- line 46 | captures: v5
    local v16 = v5.Peek(v14, v15)
    local v17 = ("nothing is bound at runtime slot %*/%*"):format(v14, v15)
    assert(v16, v17)
    return v16
end

function v5.Release(v18, v19) -- line 51 | captures: v1, v2, v4, v5
    v1(v18)
    v2(v19)
    local v20 = v4[v18]
    if v19 == nil then
        if v20 ~= nil then
            v4[v18] = nil
            v5.Changed:Fire(v18, nil, nil)
        end
    elseif v20 ~= nil and v20[v19] ~= nil then
        v20[v19] = nil
        v5.Changed:Fire(v18, v19, nil)
    end
end

return v5
