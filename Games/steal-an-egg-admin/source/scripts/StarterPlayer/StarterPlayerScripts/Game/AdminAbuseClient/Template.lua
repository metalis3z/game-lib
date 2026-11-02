-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

game:GetService("Debris")
game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
game:GetService("ServerStorage")
game:GetService("Workspace")
local v1 = require(ReplicatedStorage.Packages.Trove).new()
local v2 = false
local v3 = {}

function v3.StartEvent(v4, v5) -- line 11 | captures: v2, v1
    v1:Clean()
    v2 = true
end

function v3.StopEvent(v6) -- line 15 | captures: v2, v1
    v1:Clean()
    v2 = false
end

return v3
