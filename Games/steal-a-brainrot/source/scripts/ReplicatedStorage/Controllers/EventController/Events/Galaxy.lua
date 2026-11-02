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
local v_u_11 = script.Name
local v_u_12 = v1.Models.Events.UFO.UFO
local v_u_13 = v10.new()
function v4.OnStart(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_3, (copy) v_u_13, (copy) v_u_5, (copy) v_u_9, (copy) v_u_8, (copy) v_u_6, (copy) v_u_12, (copy) v_u_2
	local v14 = v_u_7:GetActiveEventData(v_u_11)
	assert(v14)
	local v_u_15 = v_u_3:FindFirstChild("Atmosphere")
	if v_u_15 then
		v_u_15.Parent = script
		v_u_13:Add(function()
			-- upvalues: (copy) v_u_15, (ref) v_u_3
			v_u_15.Parent = v_u_3
		end)
	end
	v_u_13:Clone(script.AtmosphereGalaxy).Parent = v_u_3
	local v_u_16 = v_u_3:FindFirstChild("Cartoon")
	if v_u_16 then
		v_u_16.Parent = script
		v_u_13:Add(function()
			-- upvalues: (copy) v_u_16, (ref) v_u_3
			v_u_16.Parent = v_u_3
		end)
	end
	v_u_13:Clone(script.SkyGalaxy).Parent = v_u_3
	v_u_5:Run("GalaxyEvent", "GrassRecolor")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Stop("GalaxyEvent", "GrassRecolor")
	end)
	v_u_5:Run("GalaxyEvent", "WallRecolor")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Stop("GalaxyEvent", "WallRecolor")
	end)
	v_u_13:Clone(script.GalaxyMap).Parent = workspace
	v_u_13:Add(v_u_9.observeTag("HideInGalaxy", function(p_u_17)
		local v_u_18 = p_u_17.Parent
		p_u_17.Parent = script
		return function()
			-- upvalues: (copy) p_u_17, (copy) v_u_18
			pcall(function()
				-- upvalues: (ref) p_u_17, (ref) v_u_18
				p_u_17.Parent = v_u_18
			end)
		end
	end, { workspace, script }))
	local v_u_19 = script.GalaxyWeather:Clone()
	v_u_19.Parent = workspace
	v_u_13:Add(function()
		-- upvalues: (copy) v_u_19
		for _, v20 in v_u_19:GetDescendants() do
			if v20:IsA("ParticleEmitter") then
				v20.Enabled = false
			end
		end
		task.wait(4)
		v_u_19:Destroy()
	end)
	v_u_8:Update()
	v_u_6:UpdateOST()
	local v_u_21 = v_u_13:Extend()
	v_u_21:Add(v_u_9.observeTag("GalaxyUFO", function(p_u_22)
		-- upvalues: (copy) v_u_21, (ref) v_u_12, (ref) v_u_2
		if not p_u_22:IsA("BasePart") then
			return nil
		end
		local v_u_23 = v_u_21:Extend()
		local v_u_24 = v_u_23:Clone(v_u_12)
		for _, v25 in v_u_24:GetDescendants() do
			if v25:IsA("BasePart") then
				v25.Anchored = true
			end
		end
		v_u_24.Parent = workspace
		v_u_23:Add(v_u_2.PostSimulation:Connect(function()
			-- upvalues: (copy) v_u_24, (copy) p_u_22, (copy) v_u_23
			debug.profilebegin("Galaxy:MoveUFO")
			if v_u_24.PrimaryPart and p_u_22.Parent then
				v_u_24:PivotTo(p_u_22.CFrame)
			else
				v_u_23:Destroy()
			end
			debug.profileend()
		end))
		return function()
			-- upvalues: (copy) v_u_23
			v_u_23:Destroy()
		end
	end))
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_13
	v_u_13:Destroy()
end
function v4.OnLoad(_) end
return v4
