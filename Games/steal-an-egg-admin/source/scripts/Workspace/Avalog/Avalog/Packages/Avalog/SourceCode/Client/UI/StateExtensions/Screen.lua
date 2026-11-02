-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Workspace = game:GetService("Workspace")
local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.Parent.Fusion)
local States = require(script.Parent.Parent.States)
local Out = Fusion.Out
local v1 = {}
Fusion.scoped(Fusion):Hydrate(Workspace.CurrentCamera)({ [Out("ViewportSize")] = States.Screen.Resolution })
return v1
