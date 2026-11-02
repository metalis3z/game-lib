-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.string)
local v2 = t.strict(t.table)
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = Log.new()
local v7 = {}

local function v8(v9) -- line 23 | captures: ContentProvider, v3, v4, v5, v6
    local v10 = {}
    local v11 = "Unknown failure"
    for v12 = 1, 3 do
        v10[1] = nil
        local v13, v14 = pcall(((function(v15)
            return function() -- line 31 | captures: v15, v9, ContentProvider
                ContentProvider:PreloadAsync({ v9 }, ((function(v16)
                    return function(v17, v18) -- line 32 | captures: v16
                        v16[1] = v18
                    end
                end)(v15)))
            end
        end)(v10)))
        if v13 then
            v10[1] = v10[1] or ContentProvider:GetAssetFetchStatus(v9)
            local Success = Enum.AssetFetchStatus.Success
            if v10[1] == Success then
                v3[v9] = true
                v4[v9] = nil
                return
            end
            local v19 = v10[1]
            v11 = tostring(v19)
            local TimedOut = Enum.AssetFetchStatus.TimedOut
            if v10[1] ~= TimedOut then
                local v20 = v10[1]
                break
            end
        else
            v11 = tostring(v14)
            if v12 < 3 then
                task.wait(v12 * 0.5)
            end
        end
        local v21 = v10[1]
        local v22 = {}
        v22[1] = v21
        v10 = v22
    end
    v4[v9] = nil
    local v23 = (v5[v9] or 0) + 1
    v5[v9] = v23
    if v23 == 3 then
        v6:AtWarning():Log((("Failed to preload image %* (intento %* de %*): %*"):format(v9, v23, 3, v11)))
    end
end

function v7.Request(v24) -- line 69 | captures: v8, ContentProvider, v1, v3, v4, v5
    v1(v24)
    if v24 ~= "" and not v3[v24] and not v4[v24] then
        if (v5[v24] or 0) >= 3 then
            return false
        end
        if ContentProvider:GetAssetFetchStatus(v24) == Enum.AssetFetchStatus.Success then
            v3[v24] = true
            return false
        end
        v4[v24] = true
        task.spawn(v8, v24)
        return true
    end
    return false
end

function v7.RequestAll(v25) -- line 86 | captures: v2, v7
    v2(v25)
    local v26 = 0
    for v27, v28 in v25 do
        if v7.Request(v28) then
            v26 += 1
        end
    end
    return v26
end

return table.freeze(v7)
