-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local v1 = {}

v1[1927880506] = true
v1[2790707588] = true

if RunService:IsServer() then
    local AdminPanelService = require(ServerScriptService.Controllers.AdminPanelService)
    return function(v2) -- line 14 | captures: v1, AdminPanelService
        v2:RegisterHook("BeforeRun", function(v3) -- line 15 | captures: v1, AdminPanelService
            local Executor = v3.Executor
            if not v1[Executor.UserId] and AdminPanelService.IsAdmin(Executor) then
                return
            end
            return "You do not have permission to run this function."
        end)
    end
end
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Shared.Globals.Constants)
local v4 = false
Remotes.StaffConsole.StaffVerdict.OnClientEvent:Connect(function(v5) -- line 30 | captures: v4
    v4 = v5
end)
Remotes.StaffConsole.ProbeStaffStatus:FireServer()
return function(v6) -- line 34 | captures: v4, v1
    v6:RegisterHook("BeforeRun", function(v7) -- line 35 | captures: v4, v1
        if not v1[v7.Executor.UserId] and v4 then
            return
        end
        return "You do not have permission to run this function."
    end)
end
