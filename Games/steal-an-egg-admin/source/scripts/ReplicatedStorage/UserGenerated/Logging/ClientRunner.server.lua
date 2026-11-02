-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local FastFlags = require(game.ReplicatedStorage.UserGenerated.FastFlags)
local Parent = require(script.Parent)
local Warn = FastFlags.Replicated("UserGenerated.Logging.ClientLevel", Parent.AssertLevel, "Warn")
Parent.SetLevel(Warn:Get())
Warn.Changed:Connect(function(v1) -- line 10 | captures: Parent
    Parent.SetLevel(v1)
end)
