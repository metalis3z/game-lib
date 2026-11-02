-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Warmup = require(ReplicatedStorage.Shared.Utils.Warmup)
local v1 = {}
local v2 = {}
local v3 = {}
local v4 = false

local function schedulePreload(v5) -- line 12 | captures: v3, v4, Warmup
    local v6 = v3
    table.insert(v6, v5)
    if not v4 then
        v4 = true
        task.defer(function() -- line 18 | captures: v3, v4, Warmup
            while true do
                local v7 = v3
                v3 = {}
                if #v7 > 0 then
                    Warmup.WarmAssets(v7)
                end
                if #v3 == 0 then
                    break
                end
            end
            v4 = false
        end)
    end
end

function v1.Get(v8) -- line 33 | captures: v3, v4, Warmup, v2
    local v9 = Warmup.ResolveAssetId(v8)
    local v10 = v9 ~= nil
    local v11 = ("invalid animation asset id %*"):format(v8)
    assert(v10, v11)
    local v12 = v2[v9]
    if v12 then
        return v12
    end
    local Animation = Instance.new("Animation")
    Animation.Name = ("Animation_%*"):format(v9)
    Animation.AnimationId = ("rbxassetid://%*"):format(v9)
    v2[v9] = Animation
    local v13 = v3
    table.insert(v13, Animation)
    if not v4 then
        v4 = true
        task.defer(function() -- line 50 | captures: v3, v4, Warmup
            while true do
                local v14 = v3
                v3 = {}
                if #v14 > 0 then
                    Warmup.WarmAssets(v14)
                end
                if #v3 == 0 then
                    break
                end
            end
            v4 = false
        end)
    end
    return Animation
end

return table.freeze(v1)
