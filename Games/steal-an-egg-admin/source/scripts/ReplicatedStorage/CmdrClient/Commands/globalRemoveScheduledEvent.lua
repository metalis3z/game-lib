-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local v1 = {
    Name = "globalRemoveScheduledEvent",
    Description = "Schedules an event in all servers",
    Group = "Moderator"
}
local v2 = {}

v2[1] = function(v3) -- line 11 | captures: RunService, ServerScriptService
    local v4
    if RunService:IsServer() then
        v4 = require(ServerScriptService.Controllers.AdminAbuseService).GetScheduledEvents()
    else
        v4 = require(game:GetService("ReplicatedStorage").Shared.Remotes).LiveEvents.FetchScheduled:InvokeServer()
    end
    local v5 = {}
    for v6 in v4 do
        table.insert(v5, v6)
    end
    return {
        Name = "ScheduledEventKey",
        Type = v3.Cmdr.Util.MakeEnumType("scheduleEventKey", v5)
    }
end

v1.Args = v2
return v1
