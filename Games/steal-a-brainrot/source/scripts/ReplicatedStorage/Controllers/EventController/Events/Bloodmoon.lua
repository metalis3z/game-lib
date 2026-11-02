---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
local v_u_2 = game:GetService("Lighting")
game:GetService("Players")
require(v1.Shared.EventTypes)
local v3 = {}
require(v1.Controllers.AnimalController)
local v_u_4 = require(v1.Controllers.SoundController)
require(v1.Controllers.EventController)
local v_u_5 = require(v1.Controllers.CycleController)
require(v1.Packages.Spring)
local v6 = require(v1.Packages.Trove)
require(v1.Packages.Shake)
require(v1.Packages.Net)
local _ = script.Name
local v_u_7 = v6.new()
function v3.OnStart(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_5, (copy) v_u_4
	local v_u_8 = v_u_2:FindFirstChild("Atmosphere")
	if v_u_8 then
		v_u_8.Parent = script
		v_u_7:Add(function()
			-- upvalues: (copy) v_u_8, (ref) v_u_2
			v_u_8.Parent = v_u_2
		end)
	end
	v_u_7:Clone(script.AtmosphereBloodmoon).Parent = v_u_2
	local v_u_9 = v_u_2:FindFirstChild("Cartoon")
	if v_u_9 then
		v_u_9.Parent = script
		v_u_7:Add(function()
			-- upvalues: (copy) v_u_9, (ref) v_u_2
			v_u_9.Parent = v_u_2
		end)
	end
	v_u_7:Clone(script.SkyBloodmoon).Parent = v_u_2
	v_u_5:Update()
	v_u_4:UpdateOST()
end
function v3.OnStop(_)
	-- upvalues: (copy) v_u_7
	v_u_7:Destroy()
end
function v3.OnLoad(_) end
return v3
