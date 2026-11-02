-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
local v_u_2 = game:GetService("Lighting")
game:GetService("Players")
require(v1.Shared.EventTypes)
local v3 = {}
local v_u_4 = require(v1.Controllers.EffectController)
local v_u_5 = require(v1.Controllers.SoundController)
local v_u_6 = require(v1.Controllers.EventController)
local v_u_7 = require(v1.Controllers.CycleController)
local v_u_8 = require(v1.Packages.Observers)
local v9 = require(v1.Packages.Trove)
require(v1.Packages.Spr)
require(v1.Shared.VFX)
local v_u_10 = script.Name
local v_u_11 = v9.new()
function v3.OnStart(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_10, (copy) v_u_2, (copy) v_u_11, (copy) v_u_4, (copy) v_u_8, (copy) v_u_7, (copy) v_u_5
	local v12 = v_u_6:GetActiveEventData(v_u_10)
	assert(v12)
	local v_u_13 = v_u_2:FindFirstChild("Atmosphere")
	if v_u_13 then
		v_u_13.Parent = script
		v_u_11:Add(function()
			-- upvalues: (copy) v_u_13, (ref) v_u_2
			v_u_13.Parent = v_u_2
		end)
	end
	v_u_11:Clone(script.AtmosphereCursed).Parent = v_u_2
	local v_u_14 = v_u_2:FindFirstChild("Cartoon")
	if v_u_14 then
		v_u_14.Parent = script
		v_u_11:Add(function()
			-- upvalues: (copy) v_u_14, (ref) v_u_2
			v_u_14.Parent = v_u_2
		end)
	end
	v_u_11:Clone(script.SkyCursed).Parent = v_u_2
	local v_u_15 = true
	v_u_11:Add(function()
		-- upvalues: (ref) v_u_15
		v_u_15 = false
	end)
	v_u_4:Activate("Blink")
	v_u_11:Add(function()
		-- upvalues: (ref) v_u_4
		v_u_4:Activate("Blink")
	end)
	v_u_4:Run("CursedEvent", "GrassRecolor")
	v_u_11:Add(function()
		-- upvalues: (ref) v_u_4
		v_u_4:Stop("CursedEvent", "GrassRecolor")
	end)
	v_u_4:Run("CursedEvent", "WallRecolor")
	v_u_11:Add(function()
		-- upvalues: (ref) v_u_4
		v_u_4:Stop("CursedEvent", "WallRecolor")
	end)
	v_u_4:Run("CursedEvent", "WallBottomRecolor")
	v_u_11:Add(function()
		-- upvalues: (ref) v_u_4
		v_u_4:Stop("CursedEvent", "WallBottomRecolor")
	end)
	v_u_11:Clone(script.CursedMap).Parent = workspace
	v_u_11:Add(v_u_8.observeTag("HideInCursed", function(p_u_16)
		local v_u_17 = p_u_16.Parent
		p_u_16.Parent = script
		return function()
			-- upvalues: (copy) p_u_16, (copy) v_u_17
			pcall(function()
				-- upvalues: (ref) p_u_16, (ref) v_u_17
				p_u_16.Parent = v_u_17
			end)
		end
	end, { workspace, script }))
	v_u_7:Update()
	v_u_5:UpdateOST()
end
function v3.OnStop(_)
	-- upvalues: (copy) v_u_11
	v_u_11:Destroy()
end
function v3.OnLoad(_) end
return v3