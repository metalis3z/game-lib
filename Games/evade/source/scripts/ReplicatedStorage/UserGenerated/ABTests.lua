---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ServerScriptService")
require(v1.UserGenerated.ABTests.SharedABTests)
if v2:IsServer() then
    return require(v3.UserGenerated.Server.ServerABTests)
else
    return require(v1.UserGenerated.Client.ClientABTests)
end