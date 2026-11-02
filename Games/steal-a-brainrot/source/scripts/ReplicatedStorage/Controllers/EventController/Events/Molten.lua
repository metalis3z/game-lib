---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
game:GetService("RunService")
local v_u_3 = game:GetService("Lighting")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.EffectController)
local v_u_6 = require(v_u_1.Controllers.SoundController)
local v_u_7 = require(v_u_1.Controllers.EventController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.Observers)
local v10 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Net)
local v_u_11 = require(v_u_1.Shared.VFX)
local v_u_12 = script.Name
local v_u_13 = v10.new()
function v4.OnStart(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_12, (copy) v_u_6, (copy) v_u_1, (copy) v_u_13, (copy) v_u_2, (copy) v_u_9, (copy) v_u_11, (copy) v_u_5, (copy) v_u_3, (copy) v_u_8
	local v14 = v_u_7:GetActiveEventData(v_u_12)
	assert(v14)
	task.spawn(function()
		-- upvalues: (ref) v_u_6
		v_u_6:PlaySound("Sounds.Events.Molten.LavaActivate")
	end)
	local v_u_15 = v_u_1.Models.Events.Molten.Craters:Clone()
	v_u_15.Parent = workspace
	local v_u_16 = v_u_15:GetChildren()
	table.sort(v_u_16, function(p17, p18)
		local v19 = p17.Name
		local v20 = tonumber(v19)
		local v21 = p18.Name
		return v20 < tonumber(v21)
	end)
	local v_u_22 = {}
	for _, v23 in v_u_16 do
		v_u_22[v23] = v23.PrimaryPart:GetPivot()
	end
	v_u_13:Add(function()
		-- upvalues: (copy) v_u_16, (ref) v_u_2, (copy) v_u_22, (copy) v_u_15
		for _, v24 in v_u_16 do
			local v25 = v24:GetExtentsSize()
			local v26 = v_u_2
			local v27 = v24.PrimaryPart
			local v28 = TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local v29 = {}
			local v30 = v_u_22[v24]
			local v31 = v25.Y * 1.1
			v29.CFrame = v30 - Vector3.new(0, v31, 0)
			v26:Create(v27, v28, v29):Play()
		end
		task.wait(3)
		v_u_15:Destroy()
	end)
	local v_u_32 = v_u_9.BumpS:Clone()
	v_u_13:Add(v_u_32)
	v_u_32.Sustain = true
	v_u_13:Add(v_u_9.BindShakeToCamera(v_u_32, workspace.CurrentCamera))
	v_u_32:Start()
	local v33 = v14.startedAt + 4 - workspace:GetServerTimeNow()
	v_u_13:Add(task.delay(v33, function()
		-- upvalues: (copy) v_u_32
		v_u_32:StopSustain()
	end))
	local v_u_34 = v_u_13:Clone(script.MoltenWeather)
	v_u_11.disable(v_u_34)
	v_u_34.Parent = workspace
	v_u_13:Add(task.delay(v33, function()
		-- upvalues: (ref) v_u_5, (ref) v_u_3, (ref) v_u_13, (ref) v_u_11, (copy) v_u_34
		v_u_5:Activate("Blink")
		local v_u_35 = v_u_3:FindFirstChild("Atmosphere")
		if v_u_35 then
			v_u_35.Parent = script
			v_u_13:Add(function()
				-- upvalues: (copy) v_u_35, (ref) v_u_3
				v_u_35.Parent = v_u_3
			end)
		end
		v_u_13:Clone(script.AtmosphereMolten).Parent = v_u_3
		local v_u_36 = v_u_3:FindFirstChild("Cartoon")
		if v_u_36 then
			v_u_36.Parent = script
			v_u_13:Add(function()
				-- upvalues: (copy) v_u_36, (ref) v_u_3
				v_u_36.Parent = v_u_3
			end)
		end
		v_u_13:Clone(script.SkyMolten).Parent = v_u_3
		v_u_11.enable(v_u_34)
	end))
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Activate("Blink")
	end)
	v_u_5:Run("MoltenEvent", "GrassRecolor")
	v_u_13:Add(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Stop("MoltenEvent", "GrassRecolor")
	end)
	local v37 = Random.new()
	for _, v38 in ipairs(v_u_16) do
		local v39 = v38:GetExtentsSize()
		local v40 = v38:GetPrimaryPartCFrame()
		v38:PivotTo(v40 * CFrame.new(0, -v39.Y * 1.1, 0))
		v_u_2:Create(v38.PrimaryPart, TweenInfo.new(v37:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["CFrame"] = v40
		}):Play()
	end
	v_u_8:Update()
	v_u_6:UpdateOST()
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_13
	v_u_13:Destroy()
end
function v4.OnLoad(_) end
return v4
