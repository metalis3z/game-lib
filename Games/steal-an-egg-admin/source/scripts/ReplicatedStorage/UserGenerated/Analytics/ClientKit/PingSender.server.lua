-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local Ping = script.Parent:WaitForChild("Ping")
local v1 = 0
local v2 = 0
RunService.Heartbeat:Connect(function(v3) -- line 10 | captures: v1, v2, Ping
    v1 += v3
    if not (v1 >= 1) then
        return
    end
    v1 %= 1
    v2 += 1
    Ping:FireServer(v2, workspace:GetServerTimeNow())
end)
task.spawn(function() -- line 18 | captures: v2, Ping
    v2 += 1
    Ping:FireServer(v2, workspace:GetServerTimeNow())
end)
