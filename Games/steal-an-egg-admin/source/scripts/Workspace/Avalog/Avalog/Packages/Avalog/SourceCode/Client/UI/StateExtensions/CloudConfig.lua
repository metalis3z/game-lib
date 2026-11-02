-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Parent = script.Parent.Parent.Parent.Parent.Parent
local States = require(script.Parent.Parent.States)
local Sift = require(Parent.Parent.Sift)
local Types = require(Parent.SourceCode.Shared.Types)
local v1

if RunService:IsRunning() then
    v1 = require(Parent.SourceCode.Shared.Zap.client)
end
local v2 = {}

function v2.Start() -- line 15 | captures: v1, v2
    if v1 ~= nil then
        v1.CloudConfigReset.SetCallback(function() -- line 17 | captures: v2
            v2:FetchData()
        end)
        v2.FetchData()
    end
end

function v2.FetchData() -- line 25 | captures: v1, States, Sift, Types
    if v1 ~= nil then
        local v3 = v1.GetCloudConfig.Call()
        if v3 ~= nil then
            local v4 = Sift.Dictionary.mergeDeep(Types.AvalogConfig.Fallback, v3)
            States.CloudConfig:set(v4)
        end
    end
end

return v2
