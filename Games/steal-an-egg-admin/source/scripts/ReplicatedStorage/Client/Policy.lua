-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local v1 = Log.new()
local v2
local v3 = {
    Loaded = Signal.new(),
    Get = function() -- Get | line 15 | captures: v2
        return v2
    end,
    IsLoaded = function() -- IsLoaded | line 18 | captures: v2
        return v2 ~= nil
    end
}

function v3.GetAsync() -- line 23 | captures: v2, v3
    local v4 = v2
    if v4 == nil then
        return v3.Loaded:Wait()
    end
    return v4
end

function v3.IsEndlessContentLoadAllowed() -- line 30 | captures: v2
    local v5 = v2
    if v5 == nil then
        return false
    end
    return v5.IsEndlessContentLoadAllowed ~= false
end

task.spawn(function() -- line 38 | captures: v2, Players, PolicyService, v1, v3
    local v6 = 0
    local v7
    while true do
        if v2 == nil then
            local v8
            v8, v7 = pcall(function() -- line 42 | captures: Players, PolicyService
                return PolicyService:GetPolicyInfoForPlayerAsync(Players.LocalPlayer)
            end)
            if not (v8 and type(v7) == "table") then
                v6 += 1
                v1:AtWarning():Log((("Failed to fetch local player policy info (attempt %*): %*"):format(v6, v7)))
                local v9 = 2 ^ (v6 - 1) * 2
                task.wait((math.min(v9, 30)))
                continue
            end
            break
        end
        return
    end
    local v10 = table.freeze(v7)
    v2 = v10
    v3.Loaded:Fire(v10)
end)
return v3
