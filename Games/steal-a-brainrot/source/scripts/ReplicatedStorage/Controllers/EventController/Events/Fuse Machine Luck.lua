---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")
game:GetService("Players")
game:GetService("ServerScriptService")
require(v1.Shared.EventTypes)
local v2 = {}
local v3 = require(v1.Packages.Trove)
local _ = script.Name
local v_u_4 = v3.new()
function v2.OnStart(_) end
function v2.OnStop(_)
	-- upvalues: (copy) v_u_4
	v_u_4:Destroy()
end
function v2.OnLoad(_) end
return v2
