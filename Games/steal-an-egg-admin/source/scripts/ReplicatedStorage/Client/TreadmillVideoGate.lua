-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Policy = require(ReplicatedStorage.Client.Policy)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local v1 = { Changed = Signal.new() }

function v1.IsVideoPlayerDisabled() -- line 12 | captures: Policy, TreadmillFlags
    if TreadmillFlags.VideoPlayerDisabled:Get() then
        return true
    end
    if TreadmillFlags.PolicyServiceVideoEnabled:Get() then
        return not Policy.IsEndlessContentLoadAllowed()
    end
    return false
end

local v2 = v1.IsVideoPlayerDisabled()

local function update() -- line 23 | captures: v2, v1
    local v3 = v1.IsVideoPlayerDisabled()
    if v3 ~= v2 then
        v2 = v3
        v1.Changed:Fire(v3)
    end
end

TreadmillFlags.VideoPlayerDisabled.Changed:Connect(update)
TreadmillFlags.PolicyServiceVideoEnabled.Changed:Connect(update)
Policy.Loaded:Connect(update)
return v1
