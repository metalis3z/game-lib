-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local Parent_2 = Parent.Parent
local ServerEndpoint = Parent:WaitForChild("ServerEndpoint")
local RunService = game:GetService("RunService")

function Parent.OnInvoke(...) -- line 7 | captures: Parent, ServerEndpoint, RunService
    if RunService:IsServer() then
        SyncModule = require(Parent:WaitForChild("SyncModule"))
        return SyncModule.PerformAction(game.Players.LocalPlayer, ...)
    end
    return ServerEndpoint:InvokeServer(...)
end
