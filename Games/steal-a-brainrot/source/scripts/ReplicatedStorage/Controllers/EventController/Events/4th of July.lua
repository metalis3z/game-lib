---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.AnimalController)
local v_u_6 = require(v_u_1.Controllers.SoundController)
local v_u_7 = require(v_u_1.Controllers.EventController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_10 = require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.Synchronizer)
local v_u_11 = require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.Observers)
local v_u_12 = require(v_u_1.Utils.MathUtils)
local v13 = require(v_u_1.Packages.Trove)
local v14 = require(v_u_1.Packages.Net)
local v_u_15 = require(v_u_1.Shared.VFX)
local v_u_16 = v14:RemoteEvent("EventService/4th of July/CreateFirework")
local v_u_17 = v14:RemoteEvent("EventService/4th of July/ExplodeTraitEffect")
local v_u_18 = script.Name
local v_u_19 = v13.new()
local v_u_20 = RaycastParams.new()
v_u_20.FilterType = Enum.RaycastFilterType.Include
v_u_20.FilterDescendantsInstances = { workspace.Map, workspace.Plots }
function v4.OnStart(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_18, (copy) v_u_1, (copy) v_u_19, (copy) v_u_6, (copy) v_u_8, (copy) v_u_11, (copy) v_u_2, (copy) v_u_16, (copy) v_u_15, (copy) v_u_20, (copy) v_u_3, (copy) v_u_9, (copy) v_u_10, (copy) v_u_12
	local v21 = v_u_7:GetActiveEventData(v_u_18)
	assert(v21)
	v_u_1:SetAttribute("4thOfJulyEvent", true)
	v_u_19:Add(function()
		-- upvalues: (ref) v_u_1
		v_u_1:SetAttribute("4thOfJulyEvent", nil)
	end)
	v_u_6:UpdateOST()
	v_u_8:Update()
	local v_u_22 = v_u_1.Models.Events["4th of July"].Fireworks:Clone()
	v_u_22.Parent = workspace
	local v_u_23 = v_u_22:GetChildren()
	table.sort(v_u_23, function(p24, p25)
		local v26 = p24.Name
		local v27 = tonumber(v26)
		local v28 = p25.Name
		return v27 < tonumber(v28)
	end)
	local v_u_29 = {}
	for _, v30 in v_u_23 do
		v_u_29[v30] = v30.CFrame
	end
	local v_u_31 = v_u_11.BumpS:Clone()
	v_u_19:Add(v_u_31)
	v_u_31.Sustain = true
	v_u_19:Add(v_u_11.BindShakeToCamera(v_u_31, workspace.CurrentCamera))
	v_u_31:Start()
	v_u_19:Add(task.delay(v21.startedAt + 4 - workspace:GetServerTimeNow(), function()
		-- upvalues: (copy) v_u_31
		v_u_31:StopSustain()
	end))
	v_u_19:Add(function()
		-- upvalues: (copy) v_u_23, (ref) v_u_2, (copy) v_u_29, (copy) v_u_22
		for _, v32 in v_u_23 do
			local v33 = v_u_2
			local v34 = TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local v35 = {}
			local v36 = v_u_29[v32]
			local v37 = v32.Size.Y * 1.1
			v35.CFrame = v36 - Vector3.new(0, v37, 0)
			v33:Create(v32, v34, v35):Play()
		end
		task.wait(3)
		v_u_22:Destroy()
	end)
	v_u_19:Add(v_u_16.OnClientEvent:Connect(function(p38)
		-- upvalues: (copy) v_u_23, (copy) v_u_29, (ref) v_u_15, (ref) v_u_1, (ref) v_u_6, (ref) v_u_2, (ref) v_u_20, (ref) v_u_3, (ref) v_u_9, (ref) v_u_10, (ref) v_u_12
		for _, v_u_39 in p38 do
			local v40 = v_u_23[v_u_39.Chosen]
			local v_u_41 = script.Firework:Clone()
			v_u_41.CFrame = v_u_29[v40]
			v_u_41.Parent = workspace
			local v_u_42 = script.FireworkStartup:Clone()
			local v43 = v_u_29[v40]
			local v44 = v40.Size.Y * 0.5 - v_u_42.Size.Y * 0.5
			v_u_42.CFrame = v43 + Vector3.new(0, v44, 0)
			v_u_42.Parent = workspace
			v_u_15.emit(v_u_42)
			local v45 = v_u_1.Sounds.Events["4th of July"]["Trail Sound Ball"]:Clone()
			v45.Parent = v_u_41
			v_u_6:PlaySound(v45)
			local v46 = v_u_1.Sounds.Events["4th of July"].Shot:Clone()
			v46.Parent = v_u_42
			v_u_6:PlaySound(v46)
			task.delay(2, function()
				-- upvalues: (copy) v_u_42
				v_u_42:Destroy()
			end)
			local v47 = v_u_29[v40]
			local v48 = v40.Size.Y
			local v_u_49 = v47 - Vector3.new(0, v48, 0)
			local v50 = v_u_29[v40]
			local v51 = v_u_39.Height
			local v_u_52 = v50 + Vector3.new(0, v51, 0)
			local v53 = v_u_39.Height / 20
			local v_u_54 = v_u_2:Create(v_u_41, TweenInfo.new(v53, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["CFrame"] = v_u_52
			})
			v_u_54:Play()
			task.delay(v53 * 0.8, function()
				-- upvalues: (copy) v_u_54, (ref) v_u_6, (ref) v_u_1, (copy) v_u_52, (copy) v_u_39, (ref) v_u_15, (copy) v_u_41, (copy) v_u_49, (ref) v_u_20, (ref) v_u_3, (ref) v_u_9, (ref) v_u_10, (ref) v_u_12
				v_u_54:Destroy()
				v_u_6:PlaySound(v_u_1.Sounds.Events["4th of July"]["Firework Explosion"], v_u_52.Position)
				local v55 = script.Effects
				local v56 = v_u_39.FireworkEffect
				local v_u_57 = v55[tostring(v56)]:Clone()
				v_u_57.CFrame = v_u_52
				v_u_57.Parent = workspace
				v_u_15.emit(v_u_57)
				v_u_41:Destroy()
				task.delay(4, function()
					-- upvalues: (copy) v_u_57
					v_u_57:Destroy()
				end)
				for _, v_u_58 in v_u_39.Falloffs do
					local v_u_59
					if typeof(v_u_58) == "Vector3" then
						v_u_59 = v_u_49 + v_u_58
						local v60 = workspace:Raycast((v_u_52 + v_u_58).Position, Vector3.new(-0, -200, -0), v_u_20)
						if v60 then
							v_u_59 = CFrame.new(v60.Position)
						end
					else
						v_u_59 = nil
					end
					local v_u_61 = script.Falloff:Clone()
					v_u_61.CFrame = v_u_52
					v_u_61.Parent = workspace
					local v_u_62 = 0
					local v_u_63 = nil
					v_u_63 = v_u_3.PostSimulation:Connect(function(p64)
						-- upvalues: (ref) v_u_62, (ref) v_u_59, (copy) v_u_58, (ref) v_u_9, (ref) v_u_10, (copy) v_u_61, (ref) v_u_12, (ref) v_u_52, (ref) v_u_39, (ref) v_u_15, (ref) v_u_63
						debug.profilebegin("4th of July:Falloff")
						v_u_62 = v_u_62 + p64
						local v65 = v_u_59
						if not v65 then
							local v66 = v_u_58
							if type(v66) == "string" then
								v65 = CFrame.new(v_u_9.getAnimalPosition(v_u_58, {
									["top"] = true
								}))
							end
						end
						local v67 = v65 or CFrame.identity
						local v68 = v_u_62 / 2.3
						local v69 = v_u_10.pushPartCFrame
						local v70 = v_u_61
						local v71 = CFrame.new
						local v72 = v_u_12.quadBezier
						local v73 = v_u_52.Position
						local v74 = v_u_52.Position
						local v75 = v_u_39.Height
						v69(v70, v71(v72(v68, v73, v74 + Vector3.new(0, v75, 0) + (v67.Position - v_u_52.Position) * Vector3.new(1, 0, 1) * 0.7, v67.Position)))
						if v68 >= 1 then
							local v76 = v_u_58
							if type(v76) ~= "string" then
								local v_u_77 = script.GroundImpact:Clone()
								local v78 = v_u_77.Size.Y * 0.5
								v_u_77.CFrame = v67 + Vector3.new(0, v78, 0)
								v_u_77.Parent = workspace
								v_u_15.emit(v_u_77)
								v_u_15.disable(v_u_61)
								task.delay(3, function()
									-- upvalues: (ref) v_u_61, (copy) v_u_77
									v_u_61:Destroy()
									v_u_77:Destroy()
								end)
								v_u_63:Disconnect()
							end
						end
						debug.profileend()
					end)
				end
			end)
		end
	end))
	local v79 = Random.new()
	for _, v80 in v_u_23 do
		local v81 = v_u_29[v80]
		local v82 = v80.Size.Y * 1.1
		v80.CFrame = v81 - Vector3.new(0, v82, 0)
		local v_u_83 = v_u_2:Create(v80, TweenInfo.new(v79:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["CFrame"] = v_u_29[v80]
		})
		local v_u_84 = v_u_19:Add(function()
			-- upvalues: (copy) v_u_83
			v_u_83:Cancel()
			v_u_83:Destroy()
		end)
		v_u_83.Completed:Once(function()
			-- upvalues: (ref) v_u_19, (copy) v_u_84
			v_u_19:Remove(v_u_84)
		end)
		v_u_83:Play()
	end
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_19
	v_u_19:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_5, (copy) v_u_9, (copy) v_u_6, (copy) v_u_1, (copy) v_u_15
	v_u_17.OnClientEvent:Connect(function(p85)
		-- upvalues: (ref) v_u_5, (ref) v_u_9, (ref) v_u_6, (ref) v_u_1, (ref) v_u_15
		local v86 = v_u_5:GetAnimals()[p85]
		if v86 then
			local v_u_87 = script.FireworkBurst:Clone()
			v_u_87.CFrame = CFrame.new(v_u_9.getAnimalPosition(p85, {
				["top"] = true
			}))
			v_u_87.Anchored = false
			local v88 = Instance.new("WeldConstraint")
			v88.Part0 = v_u_87
			v88.Part1 = v86.AnimalModel.PrimaryPart
			v88.Parent = v_u_87
			v_u_87.Parent = workspace
			v_u_6:PlaySound(v_u_1.Sounds.Events["4th of July"]["Brainrot Hit"], v_u_87.Position)
			v_u_15.emit(v_u_87)
			task.delay(3, function()
				-- upvalues: (copy) v_u_87
				v_u_87:Destroy()
			end)
		end
	end)
end
return v4
