-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not game:IsLoaded() then
    game.Loaded:Wait()
end
task.spawn(function() -- line 10
    require(script.Parent:WaitForChild("PlayerModule"))
end)
require(ReplicatedStorage.Shared.Flags.GameFlags)
for v1, v2 in {
        ReplicatedStorage.Client.HiddenUIHandler,
        ReplicatedStorage.Client.UIScaling,
        ReplicatedStorage.Client.UIEffects,
        ReplicatedStorage.Client.MusicDirector,
        ReplicatedStorage.Client.Notifications,
        ReplicatedStorage.Client.PlotState,
        ReplicatedStorage.Client.FuseMachineMotion,
        ReplicatedStorage.Client.ChatMsg,
        ReplicatedStorage.Shared.Save
    } do
    local spawn = task.spawn
    local v3 = v2
    spawn(function() -- line 29 | captures: v3
        local v4, v5 = pcall(require, v3)
        if not v4 then
            local v6 = v3:GetFullName()
            warn((("Client startup module %* failed: %*"):format(v6, v5)))
        end
    end)
end
