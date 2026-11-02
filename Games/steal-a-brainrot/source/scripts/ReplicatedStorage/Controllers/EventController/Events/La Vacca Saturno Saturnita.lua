--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_2 = game:GetService("RunService")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v3 = {}
local _ = v_u_1.Models.Events["La Vacca"]
local v_u_4 = require(v_u_1.Controllers.AnimalController)
local v_u_5 = require(v_u_1.Controllers.EffectController)
local v_u_6 = require(v_u_1.Controllers.SoundController)
local v_u_7 = require(v_u_1.Controllers.EventController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Shared.ShakePresets)
local v_u_10 = require(v_u_1.Shared.MapInformation)
local v_u_11 = require(v_u_1.Packages.Observers)
require(v_u_1.Shared.TweenPivot)
local v12 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v_u_13 = require(v_u_1.Packages.Net):RemoteEvent("EventService/LaVacca/Comet")
local v_u_14 = script.Name
local v_u_15 = v12.new()
local v_u_16 = workspace.CurrentCamera
function v3.OnStart(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_15, (copy) v_u_1, (copy) v_u_10, (copy) v_u_2, (copy) v_u_11, (copy) v_u_5, (copy) v_u_6, (copy) v_u_8, (copy) v_u_13, (copy) v_u_4, (copy) v_u_16, (copy) v_u_9
	local v_u_17 = v_u_7:GetActiveEventData(v_u_14)
	assert(v_u_17)
	workspace:GetServerTimeNow()
	local v18 = v_u_17.startedAt + 11 - workspace:GetServerTimeNow()
	if v18 > 0 then
		local v_u_19 = v_u_15:Extend()
		local v_u_20 = v_u_19:Add(Instance.new("Model"))
		local v21 = v_u_19:Add(Instance.new("Part"))
		v21.Name = "Center"
		v21.Transparency = 1
		v21.Anchored = true
		v21.CanCollide = false
		v21.CanQuery = false
		v21.CanTouch = false
		v21.Size = Vector3.new(1, 1, 1)
		v21.Position = v_u_1:GetAttribute("LaVaccaCenter") or v_u_10.MapCenter.Position
		v21.Parent = v_u_20
		v_u_20.PrimaryPart = v21
		v_u_20.Parent = workspace
		local v_u_22 = table.create(3)
		v_u_19:Add(function()
			-- upvalues: (copy) v_u_22
			table.clear(v_u_22)
		end)
		local v_u_23 = 0
		v_u_19:Add(v_u_2.PreRender:Connect(function(p24)
			-- upvalues: (ref) v_u_23, (copy) v_u_22
			debug.profilebegin("La Vacca Event")
			v_u_23 = v_u_23 + p24
			for v25, v26 in v_u_22 do
				if v26.target and v26.targetAttachment then
					v26.beam.First.Enabled = true
					v26.beam.Second.Enabled = true
					local v27 = v_u_23 - v25 + 1
					local v28 = math.clamp(v27, 0, 1)
					local v29 = v26.beam.WorldPosition
					v26.targetAttachment.Position = v29 + (v26.target:GetPivot().Position - v29) * v28
				end
			end
			debug.profileend()
		end))
		v_u_19:Add(v_u_11.observeTag("LaVaccaModel", function(p_u_30)
			-- upvalues: (copy) v_u_20, (copy) v_u_22, (ref) v_u_11
			p_u_30.Parent = v_u_20
			local v_u_31 = script.PlayerVFX.Beam:Clone()
			v_u_31.Parent = p_u_30.PrimaryPart
			v_u_22[p_u_30:GetAttribute("LaVaccaIndex")] = {
				["beam"] = v_u_31,
				["target"] = nil
			}
			local v_u_35 = v_u_11.observeTag("LaVaccaModel", function(p32)
				-- upvalues: (copy) p_u_30, (copy) v_u_31, (ref) v_u_22
				if p32 == p_u_30 then
					return nil
				end
				if p32:GetAttribute("LaVaccaIndex") ~= p_u_30:GetAttribute("LaVaccaIndex") % 3 + 1 then
					return nil
				end
				local v_u_33 = Instance.new("Attachment")
				v_u_33.Position = v_u_31.WorldPosition
				v_u_33.Parent = workspace.Terrain
				local v34 = v_u_22[p_u_30:GetAttribute("LaVaccaIndex")]
				v34.target = p32.PrimaryPart
				v34.beam.First.Attachment0 = v_u_33
				v34.beam.Second.Attachment0 = v_u_33
				v34.targetAttachment = v_u_33
				return function()
					-- upvalues: (copy) v_u_33
					v_u_33:Destroy()
				end
			end)
			return function()
				-- upvalues: (ref) v_u_22, (copy) p_u_30, (copy) v_u_31, (copy) v_u_35
				v_u_22[p_u_30:GetAttribute("LaVaccaIndex")] = nil
				v_u_31:Destroy()
				v_u_35()
			end
		end))
		local v_u_36 = v21.CFrame
		local v37 = v_u_19:Clone(script.SummonVFX)
		v37:PivotTo(v_u_36)
		v37.Parent = workspace
		local v_u_38 = v_u_19:Clone(script.SummonVFXBeam)
		v_u_38:PivotTo(v_u_36)
		v_u_38.Parent = workspace
		v_u_19:Add(v_u_2.PostSimulation:Connect(function(_)
			-- upvalues: (copy) v_u_17, (copy) v_u_20, (copy) v_u_36, (copy) v_u_38, (copy) v_u_19
			debug.profilebegin("La Vacca Event Animation")
			local v39 = workspace:GetServerTimeNow()
			if v39 >= v_u_17.startedAt + 3 then
				local v40 = 1 - (v_u_17.startedAt + 11 - v39) / 8
				local v41 = math.clamp(v40, 0, 1)
				local v42 = v41 * v41 * 3.141592653589793 * 2 * 8
				local v43 = v41 * v41 * 150
				v_u_20:PivotTo(v_u_36 * CFrame.Angles(0, v42, 0) * CFrame.new(0, v43, 0))
				v_u_38.Beams.Position = Vector3.new(0, v43, 0)
				if v41 >= 1 then
					v_u_19:Clean()
				end
				debug.profileend()
			end
		end))
		v_u_19:Add(v_u_11.observeTag("LaVaccaPlayerVFX", function(p44)
			local v_u_45 = script.PlayerVFX.Torso:Clone()
			v_u_45.Parent = p44
			return function()
				-- upvalues: (copy) v_u_45
				v_u_45:Destroy()
			end
		end, { workspace }))
	end
	v_u_15:Add(task.delay(v18, function()
		-- upvalues: (ref) v_u_5, (ref) v_u_14, (ref) v_u_15, (ref) v_u_1, (ref) v_u_6, (ref) v_u_8
		v_u_5:Run(v_u_14, "Space")
		v_u_5:Activate("Blink")
		v_u_15:Add(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Activate("Blink")
		end)
		v_u_1:SetAttribute("LaVaccaEvent", true)
		v_u_6:UpdateOST()
		v_u_8:Update()
		v_u_15:Add(function()
			-- upvalues: (ref) v_u_1, (ref) v_u_5, (ref) v_u_14
			v_u_1:SetAttribute("LaVaccaEvent", nil)
			v_u_5:Stop(v_u_14, "Space")
		end)
	end))
	v_u_15:Add(v_u_13.OnClientEvent:Connect(function(p46, p47)
		-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_1, (ref) v_u_2, (ref) v_u_16, (ref) v_u_9, (ref) v_u_15
		local v_u_48 = v_u_4:GetAnimals()[p47]
		if v_u_48 then
			local v_u_49 = CFrame.new(p46)
			task.spawn(function()
				-- upvalues: (ref) v_u_6, (ref) v_u_1, (copy) v_u_48
				local v50 = v_u_6
				local v51 = v_u_1.Sounds.Events["La Vacca Saturno Saturnita"].CommetActivation
				local v52 = v_u_48.AnimalModel
				local v53
				if v52.PrimaryPart then
					v53 = v52.PrimaryPart.CFrame
				else
					v53 = v52:GetPivot()
				end
				local v54 = v53.Position
				local v55 = v_u_48.AnimalModel:GetExtentsSize().Y * 0.5
				v50:PlaySound(v51, v54 + Vector3.new(0, v55, 0))
			end)
			local v_u_56 = script.Comet:Clone()
			v_u_56:PivotTo(v_u_49)
			v_u_56.Parent = workspace
			local v_u_57 = 0
			local v_u_58 = nil
			v_u_58 = v_u_2.PreRender:Connect(function(p59)
				-- upvalues: (ref) v_u_58, (ref) v_u_57, (copy) v_u_48, (copy) v_u_56, (copy) v_u_49, (ref) v_u_6, (ref) v_u_1, (ref) v_u_16, (ref) v_u_9, (ref) v_u_15
				if v_u_58 and v_u_58.Connected then
					debug.profilebegin("La Vacca Commet Hit")
					v_u_57 = v_u_57 + p59
					local v60 = CFrame.new
					local v61 = v_u_48.AnimalModel
					local v62
					if v61.PrimaryPart then
						v62 = v61.PrimaryPart.CFrame
					else
						v62 = v61:GetPivot()
					end
					local v63 = v62.Position
					local v64 = v_u_48.AnimalModel:GetExtentsSize().Y * 0.5
					local v65 = v60(v63 + Vector3.new(0, v64, 0))
					local v66 = v_u_57 / 1
					local v67 = math.clamp(v66, 0, 1)
					v_u_56:PivotTo(v_u_49:Lerp(v65, v67))
					if v67 >= 1 then
						v_u_58:Disconnect()
						task.spawn(function()
							-- upvalues: (ref) v_u_6, (ref) v_u_1, (ref) v_u_48
							local v68 = v_u_6
							local v69 = v_u_1.Sounds.Events["La Vacca Saturno Saturnita"].CommetHit
							local v70 = v_u_48.AnimalModel
							local v71
							if v70.PrimaryPart then
								v71 = v70.PrimaryPart.CFrame
							else
								v71 = v70:GetPivot()
							end
							local v72 = v71.Position
							local v73 = v_u_48.AnimalModel:GetExtentsSize().Y * 0.5
							v68:PlaySound(v69, v72 + Vector3.new(0, v73, 0))
						end)
						if (v_u_16.CFrame.Position - v65.Position).Magnitude <= 70 then
							local v_u_74 = v_u_9.Bump:Clone()
							v_u_15:Add(v_u_74)
							v_u_74.Sustain = true
							v_u_15:Add(v_u_9.BindShakeToCamera(v_u_74, v_u_16))
							v_u_74:Start()
							v_u_15:Add(task.delay(0.3, function()
								-- upvalues: (copy) v_u_74
								v_u_74:StopSustain()
							end))
						end
						local v_u_75 = script.CometBurst:Clone()
						v_u_75:PivotTo(v65)
						v_u_75.Anchored = false
						local v76 = Instance.new("WeldConstraint")
						v76.Part0 = v_u_75
						v76.Part1 = v_u_48.AnimalModel.PrimaryPart
						v76.Parent = v_u_75
						v_u_75.Parent = workspace
						for _, v77 in v_u_56:GetDescendants() do
							if v77:IsA("BasePart") then
								v77.Transparency = 1
							elseif v77:IsA("ParticleEmitter") then
								v77.Enabled = false
								v77:Clear()
							end
						end
						for _, v_u_78 in v_u_75:GetDescendants() do
							if v_u_78:IsA("ParticleEmitter") then
								task.delay(v_u_78:GetAttribute("EmitDelay") or 0, function()
									-- upvalues: (copy) v_u_78
									v_u_78:Emit(v_u_78:GetAttribute("EmitCount"))
								end)
							end
						end
						task.delay(2, function()
							-- upvalues: (ref) v_u_56, (copy) v_u_75
							v_u_56:Destroy()
							v_u_75:Destroy()
						end)
					end
					debug.profileend()
				end
			end)
		end
	end))
end
function v3.OnStop(_)
	-- upvalues: (copy) v_u_15
	v_u_15:Destroy()
end
function v3.OnLoad(_) end
return v3