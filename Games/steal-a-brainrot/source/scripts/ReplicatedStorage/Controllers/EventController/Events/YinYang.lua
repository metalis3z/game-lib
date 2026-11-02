---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Lighting")
game:GetService("Players")
require(v1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v1.Controllers.EffectController)
local v_u_6 = require(v1.Controllers.SoundController)
local v_u_7 = require(v1.Controllers.EventController)
local v_u_8 = require(v1.Controllers.CycleController)
local v_u_9 = require(v1.Packages.Observers)
local v10 = require(v1.Packages.Trove)
local v_u_11 = require(v1.Shared.VFX)
local v_u_12 = script.Name
local v_u_13 = v10.new()
function v4.OnStart(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_12, (copy) v_u_3, (copy) v_u_13, (copy) v_u_2, (copy) v_u_5, (copy) v_u_11, (copy) v_u_9, (copy) v_u_8, (copy) v_u_6
	local v14 = v_u_7:GetActiveEventData(v_u_12)
	assert(v14)
	local v_u_15 = v_u_3:FindFirstChild("Atmosphere")
	if v_u_15 then
		v_u_15.Parent = script
		v_u_13:Add(function()
			-- upvalues: (copy) v_u_15, (ref) v_u_3
			v_u_15.Parent = v_u_3
		end)
	end
	v_u_13:Clone(script.AtmosphereYinYang).Parent = v_u_3
	local v_u_16 = v_u_3:FindFirstChild("Cartoon")
	if v_u_16 then
		v_u_16.Parent = script
		v_u_13:Add(function()
			-- upvalues: (copy) v_u_16, (ref) v_u_3
			v_u_16.Parent = v_u_3
		end)
	end
	local v_u_17 = v_u_13:Clone(script.SkyYinYang)
	v_u_17.Parent = v_u_3
	v_u_13:Add(v_u_2.PostSimulation:Connect(function(p18)
		-- upvalues: (copy) v_u_17
		local v19 = v_u_17
		local v20 = v19.SkyboxOrientation
		local v21 = -p18 * 0.36
		v19.SkyboxOrientation = v20 + Vector3.new(0, v21, 0)
	end))
	v_u_5:Activate("Blink")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Activate("Blink")
	end)
	v_u_5:Run("YinYangEvent", "GrassRecolor")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Stop("YinYangEvent", "GrassRecolor")
	end)
	v_u_5:Run("YinYangEvent", "WallRecolor")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Stop("YinYangEvent", "WallRecolor")
	end)
	v_u_5:Run("YinYangEvent", "WallBottomRecolor")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Stop("YinYangEvent", "WallBottomRecolor")
	end)
	v_u_13:Clone(script.YinYangMap).Parent = workspace
	local v_u_22 = script.YinYangWeather:Clone()
	v_u_22.Parent = workspace
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_11, (copy) v_u_22
		v_u_11.disable(v_u_22)
		task.wait(4)
		v_u_22:Destroy()
	end)
	v_u_13:Add(v_u_9.observeTag("HideInYinYang", function(p_u_23)
		local v_u_24 = p_u_23.Parent
		p_u_23.Parent = script
		return function()
			-- upvalues: (copy) p_u_23, (copy) v_u_24
			pcall(function()
				-- upvalues: (ref) p_u_23, (ref) v_u_24
				p_u_23.Parent = v_u_24
			end)
		end
	end, { workspace, script }))
	v_u_8:Update()
	v_u_6:UpdateOST()
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_13
	v_u_13:Destroy()
end
function v4.OnLoad(_) end
return v4
