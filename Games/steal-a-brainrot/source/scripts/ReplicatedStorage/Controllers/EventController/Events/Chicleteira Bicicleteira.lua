---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("ServerScriptService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
game:GetService("Players")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.EffectController)
local v_u_6 = require(v_u_1.Controllers.AnimalController)
local v_u_7 = require(v_u_1.Controllers.SoundController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Controllers.EventController)
require(v_u_1.Controllers.EventController.ClientEventUtils)
require(v_u_1.Packages.CreateTween)
local v_u_10 = require(v_u_1.Packages.Observers)
require(v_u_1.Shared.TweenPivot)
require(v_u_1.Utils.MathUtils)
local v_u_11 = require(v_u_1.Packages.Timer)
local v_u_12 = require(v_u_1.Packages.Trove)
local v13 = require(v_u_1.Packages.Net)
local v_u_14 = require(v_u_1.Packages.Spr)
local v_u_15 = require(v_u_1.Shared.VFX)
require(v_u_1.Shared.Snapshot)
local v_u_16 = script.Name
local v_u_17 = v13:RemoteEvent("EventService/Chicleteira Bicicleteira/SpawnChicleteira")
local v_u_18 = v13:RemoteEvent("EventService/Chicleteira Bicicleteira/Burst")
local v_u_19 = v_u_12.new()
local function v_u_41()
	-- upvalues: (copy) v_u_19, (copy) v_u_3, (copy) v_u_10
	local v20 = v_u_19:Extend()
	local v_u_21 = table.create(2)
	v20:Add(function()
		-- upvalues: (copy) v_u_21
		table.clear(v_u_21)
	end)
	local v_u_22 = 0
	v20:Add(v_u_3.PreRender:Connect(function(p23)
		-- upvalues: (ref) v_u_22, (copy) v_u_21
		debug.profilebegin("Chicleteira Event")
		v_u_22 = v_u_22 + p23
		for v24, v25 in v_u_21 do
			if v25.target and v25.targetAttachment then
				v25.beam.First.Enabled = true
				v25.beam.Second.Enabled = true
				local v26 = v_u_22 - v24 + 1
				local v27 = math.clamp(v26, 0, 1)
				local v28 = v25.beam.WorldPosition
				v25.targetAttachment.Position = v28 + (v25.target:GetPivot().Position - v28) * v27
			end
		end
		debug.profileend()
	end))
	v20:Add(v_u_10.observeTag("ChicleteiraPlayerVFX", function(p_u_29)
		-- upvalues: (copy) v_u_21, (ref) v_u_10
		local v_u_30 = script.PlayerVFX.Beam:Clone()
		v_u_30.Parent = p_u_29
		local v_u_31 = script.PlayerVFX[("Torso%*"):format(p_u_29:GetAttribute("ChicleteiraIndex") % 2 + 1)]:Clone()
		v_u_31.Parent = p_u_29
		local v32 = script.PlayerVFX[("vfxTorso%*"):format(p_u_29:GetAttribute("ChicleteiraIndex") % 2 + 1)]:Clone()
		local v_u_33 = {}
		for _, v34 in v32:GetChildren() do
			v34.Parent = p_u_29
			table.insert(v_u_33, v34)
		end
		v32:Destroy()
		local v_u_35 = p_u_29:GetAttribute("ChicleteiraIndex")
		v_u_21[v_u_35] = {
			["beam"] = v_u_30,
			["target"] = nil
		}
		local v_u_39 = v_u_10.observeTag("ChicleteiraPlayerVFX", function(p36)
			-- upvalues: (copy) p_u_29, (copy) v_u_30, (ref) v_u_21
			if p36 == p_u_29 then
				return nil
			end
			if p36:GetAttribute("ChicleteiraIndex") ~= p_u_29:GetAttribute("ChicleteiraIndex") % 2 + 1 then
				return nil
			end
			local v_u_37 = Instance.new("Attachment")
			v_u_37.Position = v_u_30.WorldPosition
			v_u_37.Parent = workspace.Terrain
			local v38 = v_u_21[p_u_29:GetAttribute("ChicleteiraIndex")]
			v38.target = p36
			v38.beam.First.Attachment0 = v_u_37
			v38.beam.Second.Attachment0 = v_u_37
			v38.targetAttachment = v_u_37
			return function()
				-- upvalues: (copy) v_u_37
				v_u_37:Destroy()
			end
		end)
		return function()
			-- upvalues: (copy) v_u_31, (copy) v_u_30, (copy) v_u_33, (copy) v_u_39, (ref) v_u_21, (copy) v_u_35
			v_u_31:Destroy()
			v_u_30:Destroy()
			for _, v40 in v_u_33 do
				v40:Destroy()
			end
			v_u_39()
			v_u_21[v_u_35] = nil
		end
	end))
end
function v4.OnStart(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_16, (copy) v_u_1, (copy) v_u_19, (copy) v_u_5, (copy) v_u_8, (copy) v_u_7, (copy) v_u_10, (copy) v_u_12, (copy) v_u_15, (copy) v_u_11, (copy) v_u_6, (copy) v_u_14, (copy) v_u_41
	local v42 = v_u_9:GetActiveEventData(v_u_16)
	assert(v42)
	v_u_1:SetAttribute("ChicleteiraBicicleteiraEvent", true)
	v_u_19:Add(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_8, (ref) v_u_7
		v_u_1:SetAttribute("ChicleteiraBicicleteiraEvent", nil)
		v_u_5:Activate("Blink")
		v_u_8:Update()
		v_u_7:UpdateOST()
		v_u_7:UpdateAmbience()
	end)
	v_u_19:Add(task.delay(v42.startedAt + 2 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_19, (ref) v_u_10, (ref) v_u_5, (ref) v_u_8, (ref) v_u_7
		v_u_19:Clone(script.Map).Parent = workspace
		v_u_19:Add(v_u_10.observeTag("HideInChicleteiraBicicleteira", function(p_u_43)
			local v_u_44 = p_u_43.Parent
			p_u_43.Parent = script
			return function()
				-- upvalues: (copy) p_u_43, (copy) v_u_44
				pcall(function()
					-- upvalues: (ref) p_u_43, (ref) v_u_44
					p_u_43.Parent = v_u_44
				end)
			end
		end, { workspace, script }))
		v_u_5:Run("ChicleteiraBicicleteiraEvent", "GrassRecolor")
		v_u_19:Add(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Stop("ChicleteiraBicicleteiraEvent", "GrassRecolor")
		end)
		v_u_5:Run("ChicleteiraBicicleteiraEvent", "WallRecolor")
		v_u_19:Add(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Stop("ChicleteiraBicicleteiraEvent", "WallRecolor")
		end)
		v_u_8:Update()
		v_u_7:UpdateOST()
		v_u_7:UpdateAmbience()
		v_u_5:Activate("Blink")
	end))
	v_u_19:Add(v_u_10.observeTag("Event_ChicleteiraBicicleteira", function(p_u_45)
		-- upvalues: (ref) v_u_12, (ref) v_u_7, (ref) v_u_1, (ref) v_u_15, (ref) v_u_11, (ref) v_u_6, (ref) v_u_14
		local v_u_46 = p_u_45:GetPivot() * CFrame.fromOrientation(0, 3.141592653589793, 0)
		local v47 = v_u_12.new()
		local v_u_48 = v47:Clone(script["Standing Chicleteira Bicicleteira"])
		local v49 = v_u_48:GetExtentsSize().Y
		v_u_48:PivotTo(v_u_46 - Vector3.new(0, v49, 0))
		v_u_48.Parent = p_u_45
		local v50 = v_u_48.AnimationController.Animator:LoadAnimation(script.Idle)
		v47:Add(v50, "Stop")
		v47:Add(v50)
		v50.Looped = true
		v50.Priority = Enum.AnimationPriority.Idle
		v50:Play()
		local v_u_51 = v_u_48.AnimationController.Animator:LoadAnimation(script.Painting)
		v47:Add(v_u_51, "Stop")
		v47:Add(v_u_51)
		v_u_51.Looped = false
		v_u_51.Priority = Enum.AnimationPriority.Action4
		v47:Add(v50:GetMarkerReachedSignal("Shake"):Connect(function(...)
			-- upvalues: (copy) v_u_51, (ref) v_u_7, (ref) v_u_1, (copy) v_u_46
			if not v_u_51.IsPlaying then
				task.spawn(function()
					-- upvalues: (ref) v_u_7, (ref) v_u_1, (ref) v_u_46
					v_u_7:PlaySound(v_u_1.Sounds.Events["Chicleteira Bicicleteira"].Shake, v_u_46.Position)
				end)
			end
		end))
		v47:Add(p_u_45:GetAttributeChangedSignal("ForceSpray"):Connect(function()
			-- upvalues: (copy) p_u_45, (ref) v_u_7, (ref) v_u_1, (copy) v_u_46, (copy) v_u_51, (ref) v_u_15, (copy) v_u_48
			if p_u_45:GetAttribute("ForceSpray") then
				task.spawn(function()
					-- upvalues: (ref) v_u_7, (ref) v_u_1, (ref) v_u_46
					v_u_7:PlaySound(v_u_1.Sounds.Events["Chicleteira Bicicleteira"].Spray, v_u_46.Position)
				end)
				v_u_51:Stop(0)
				v_u_51:Play()
				task.wait(0.3)
				v_u_15.enable(v_u_48.Handle.vfx)
				task.wait(1)
				v_u_15.disable(v_u_48.Handle.vfx)
			end
		end))
		v47:Add(task.spawn(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_1, (copy) v_u_46
			v_u_7:PlaySound(v_u_1.Sounds.Events["Chicleteira Bicicleteira"].Ground, v_u_46.Position)
		end))
		v47:Add(v_u_11.Simple(0.1, function()
			-- upvalues: (copy) p_u_45, (ref) v_u_6, (copy) v_u_46, (ref) v_u_14, (copy) v_u_48
			local v52 = nil
			local v53 = p_u_45:GetAttribute("ForceSpray")
			if v53 then
				local v54 = v_u_6:GetAnimals()[v53]
				if v54 then
					v52 = v54.Instance
				end
			end
			if v52 then
				local v55 = v52:GetPivot().Position
				local v56 = v55.X
				local v57 = v_u_46.Y
				local v58 = v55.Z
				local v59 = Vector3.new(v56, v57, v58)
				v_u_14.target(v_u_48, 1, 2, {
					["Pivot"] = CFrame.lookAt(v_u_46.Position, v59) * CFrame.fromOrientation(0, 3.141592653589793, 0)
				})
			else
				local v60 = {
					["Pivot"] = v_u_46
				}
				v_u_14.target(v_u_48, 1, 2, v60)
			end
		end, true))
		return v47:WrapClean()
	end, { workspace }))
	v_u_19:Add(task.spawn(function()
		-- upvalues: (ref) v_u_41
		v_u_41()
	end))
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_19
	v_u_19:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_18, (copy) v_u_6, (copy) v_u_7, (copy) v_u_1, (copy) v_u_15, (copy) v_u_17, (copy) v_u_19, (copy) v_u_3
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	v_u_18.OnClientEvent:Connect(function(p61)
		-- upvalues: (ref) v_u_6, (ref) v_u_7, (ref) v_u_1, (ref) v_u_15
		local v62 = v_u_6:GetAnimals()[p61]
		if v62 then
			local v63 = v62.AnimalModel
			local v64
			if v63.PrimaryPart then
				v64 = v63.PrimaryPart.CFrame
			else
				v64 = v63:GetPivot()
			end
			local v_u_65 = v64.Position
			task.spawn(function()
				-- upvalues: (ref) v_u_7, (ref) v_u_1, (copy) v_u_65
				v_u_7:PlaySound(v_u_1.Sounds.Events["Chicleteira Bicicleteira"].Hit, v_u_65)
			end)
			local v_u_66 = script.Burst:Clone()
			v_u_66:PivotTo(CFrame.new(v_u_65))
			v_u_66.Anchored = false
			local v67 = Instance.new("WeldConstraint")
			v67.Part0 = v_u_66
			v67.Part1 = v62.AnimalModel.PrimaryPart
			v67.Parent = v_u_66
			v_u_66.Parent = workspace
			v_u_15.emit(v_u_66)
			task.delay(5, function()
				-- upvalues: (copy) v_u_66
				v_u_66:Destroy()
			end)
		end
	end)
	v_u_17.OnClientEvent:Connect(function(p_u_68, p_u_69, p70, p_u_71)
		-- upvalues: (ref) v_u_19, (ref) v_u_1, (ref) v_u_3
		local v_u_72 = script["Chicleteira Bicicleteira"]:Clone()
		v_u_72:PivotTo(p_u_71 or p_u_68)
		v_u_72.Parent = workspace
		local v73 = v_u_72.AnimationController.Animator:LoadAnimation(script.Walk)
		v73.Looped = true
		v73:Play()
		v73:AdjustSpeed(2)
		local v74 = v_u_19:Clone(v_u_1.Sounds.Events["Chicleteira Bicicleteira"].Bike)
		v74.Parent = v_u_72.PrimaryPart
		v74:Play()
		local v75 = p_u_69.Z - p_u_68.Z
		local v_u_76 = math.abs(v75) / p70
		local v_u_77 = 0
		local v_u_78 = nil
		v_u_78 = v_u_3.PostSimulation:Connect(function(p79)
			-- upvalues: (ref) v_u_77, (copy) v_u_76, (ref) v_u_78, (copy) v_u_72, (copy) p_u_71, (copy) p_u_68, (copy) p_u_69
			v_u_77 = v_u_77 + p79
			local v80 = v_u_77 / v_u_76
			local v81 = math.clamp(v80, 0, 1)
			if v81 >= 1 and v_u_78 then
				v_u_78:Disconnect()
				v_u_78 = nil
				v_u_72:Destroy()
			end
			if p_u_71 == nil then
				v_u_72:PivotTo(p_u_68:Lerp(p_u_69, v81), v81)
			else
				local v82 = p_u_68:Lerp(p_u_69, v81)
				local v83 = p_u_71:Lerp(p_u_69, v81)
				local v84 = v81 / 0.05
				local v85 = math.clamp(v84, 0, 1)
				local v86 = 5 + (v83.Y - v82.Y)
				local v87 = v83.Y
				local v88 = v82.Y
				local v89 = math.lerp(v87, v88, v85)
				local v90 = 3.141592653589793 * v85
				local v91 = v89 + math.sin(v90) * v86
				v_u_72:PivotTo(CFrame.new(v82.X, v91, v83.Z) * v82.Rotation)
			end
		end)
	end)
end
return v4
