


local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v4 = {}
require(v_u_1.Controllers.AnimalController)
local v_u_5 = require(v_u_1.Controllers.SoundController)
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Controllers.CycleController)
local v_u_8 = require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_9 = require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.Synchronizer)
local v_u_10 = require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.Observers)
local v_u_11 = require(v_u_1.Shared.TweenPivot)
local v_u_12 = require(v_u_1.Utils.MathUtils)
local v13 = require(v_u_1.Packages.Trove)
local v14 = require(v_u_1.Packages.Net)
local v_u_15 = require(v_u_1.Shared.VFX)
local v_u_16 = v14:RemoteEvent("EventService/10B Visits/CreateFirework")
local v_u_17 = v14:RemoteEvent("EventService/10B Visits/ExplodeTraitEffect")
local v_u_18 = script.Name
local v_u_19 = v13.new()
local v_u_20 = RaycastParams.new()
v_u_20.FilterType = Enum.RaycastFilterType.Include
v_u_20.FilterDescendantsInstances = { workspace.Map, workspace.Plots }
local v_u_21 = {}
function v4.OnStart(_)
	local v22 = v_u_6:GetActiveEventData(v_u_18)
	assert(v22)
	v_u_1:SetAttribute("10BVisitsEvent", true)
	v_u_19:Add(function()
		v_u_1:SetAttribute("10BVisitsEvent", nil)
	end)
	v_u_5:UpdateOST()
	v_u_7:Update()
	local v_u_23 = v_u_1.Models.Events["10B Visits"].Fireworks:Clone()
	v_u_23.Parent = workspace
	local v_u_24 = v_u_23:GetChildren()
	table.sort(v_u_24, function(p25, p26)
		local v27 = p25.Name
		local v28 = tonumber(v27)
		local v29 = p26.Name
		return v28 < tonumber(v29)
	end)
	local v_u_30 = {}
	for _, v31 in v_u_24 do
		v_u_30[v31] = v31.CFrame
	end
	local v_u_32 = v_u_10.BumpS:Clone()
	v_u_19:Add(v_u_32)
	v_u_32.Sustain = true
	v_u_19:Add(v_u_10.BindShakeToCamera(v_u_32, workspace.CurrentCamera))
	v_u_32:Start()
	v_u_19:Add(task.delay(v22.startedAt + 4 - workspace:GetServerTimeNow(), function()
		v_u_32:StopSustain()
	end))
	v_u_19:Add(function()
		for _, v33 in v_u_24 do
			local v34 = v_u_2
			local v35 = TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local v36 = {}
			local v37 = v_u_30[v33]
			local v38 = v33.Size.Y * 1.1
			v36.CFrame = v37 - Vector3.new(0, v38, 0)
			v34:Create(v33, v35, v36):Play()
		end
		task.wait(3)
		v_u_23:Destroy()
	end)
	local v_u_39 = v_u_19:Clone(script.DroneRig)
	v_u_39.Parent = workspace
	local v_u_40 = v_u_39.AnimationController.Animator:LoadAnimation(script.DronesAnimation)
	v_u_40:Play(0, 1, 0.2)
	v_u_40:GetMarkerReachedSignal("TungFinished"):Once(function()
		v_u_40:AdjustSpeed(1)
	end)
	v_u_40:GetMarkerReachedSignal("Lower"):Once(function()
		v_u_11(v_u_39, TweenInfo.new(1), script.DroneRig:GetPivot() - Vector3.new(0, 100, 0)):Play()
	end)
	v_u_40:GetMarkerReachedSignal("Freeze"):Once(function()
		v_u_40:AdjustSpeed(0)
	end)
	local v_u_41 = {}
	for _, v42 in v_u_39:GetChildren() do
		if v42:IsA("BasePart") then
			table.insert(v_u_41, v42)
		end
	end
	v_u_19:Add(v_u_16.OnClientEvent:Connect(function(p43)
		for v44, v_u_45 in p43 do
			local v46 = script.Effects
			local v47 = v_u_45.FireworkEffect
			local v_u_48 = v46[tostring(v47)]
			local v_u_49 = ColorSequence.new(Color3.new(1, 1, 1))
			local v50 = v_u_48.specs["Embers [20]"]
			if v50 then
				v_u_49 = v50.Color
			end
			v_u_21[v44] = v_u_49
			local v51 = v_u_24[v_u_45.Chosen]
			local v_u_52 = script.Firework:Clone()
			v_u_52.CFrame = v_u_30[v51]
			v_u_52.Parent = workspace
			local v_u_53 = script.FireworkStartup:Clone()
			local v54 = v_u_30[v51]
			local v55 = v51.Size.Y * 0.5 - v_u_53.Size.Y * 0.5
			v_u_53.CFrame = v54 + Vector3.new(0, v55, 0)
			v_u_53.Parent = workspace
			v_u_15.emit(v_u_53)
			local v56 = v_u_1.Sounds.Events["10B Visits"]["Trail Sound Ball"]:Clone()
			v56.Parent = v_u_52
			v_u_5:PlaySound(v56)
			local v57 = v_u_1.Sounds.Events["10B Visits"].Shot:Clone()
			v57.Parent = v_u_53
			v_u_5:PlaySound(v57)
			task.delay(2, function()
				v_u_53:Destroy()
			end)
			local v58 = v_u_30[v51]
			local v59 = v51.Size.Y
			local v_u_60 = v58 - Vector3.new(0, v59, 0)
			local v61 = v_u_30[v51]
			local v62 = v_u_45.Height
			local v_u_63 = v61 + Vector3.new(0, v62, 0)
			local v64 = v_u_45.Height / 20
			local v_u_65 = v_u_2:Create(v_u_52, TweenInfo.new(v64, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["CFrame"] = v_u_63
			})
			v_u_65:Play()
			task.delay(v64 * 0.8, function()
				v_u_65:Destroy()
				v_u_5:PlaySound(v_u_1.Sounds.Events["10B Visits"]["Firework Explosion"], v_u_63.Position)
				local v66 = v_u_49.Keypoints[1].Value
				for _, v67 in v_u_41 do
					v67.Color = v66
				end
				local v_u_68 = v_u_48:Clone()
				v_u_68.CFrame = v_u_63
				v_u_68.Parent = workspace
				v_u_15.emit(v_u_68)
				v_u_52:Destroy()
				task.delay(4, function()
					v_u_68:Destroy()
				end)
				for _, v_u_69 in v_u_45.Falloffs do
					local v_u_70
					if typeof(v_u_69) == "Vector3" then
						v_u_70 = v_u_60 + v_u_69
						local v71 = workspace:Raycast((v_u_63 + v_u_69).Position, Vector3.new(-0, -200, -0), v_u_20)
						if v71 then
							v_u_70 = CFrame.new(v71.Position)
						end
					else
						v_u_70 = nil
					end
					local v_u_72 = script.Falloff:Clone()
					v_u_72.CFrame = v_u_63
					for _, v73 in v_u_72:GetDescendants() do
						if v73:IsA("ParticleEmitter") then
							v73.Color = v_u_49
						end
					end
					v_u_72.Parent = workspace
					local v_u_74 = 0
					local v_u_75 = nil
					v_u_75 = v_u_3.PostSimulation:Connect(function(p76)
						debug.profilebegin("10B Visits:Falloff")
						v_u_74 = v_u_74 + p76
						local v77 = v_u_70
						if not v77 then
							local v78 = v_u_69
							if type(v78) == "string" then
								v77 = CFrame.new(v_u_8.getAnimalPosition(v_u_69))
							end
						end
						local v79 = v77 or CFrame.identity
						local v80 = v_u_74 / 2.3
						local v81 = v_u_9.pushPartCFrame
						local v82 = v_u_72
						local v83 = CFrame.new
						local v84 = v_u_12.quadBezier
						local v85 = v_u_63.Position
						local v86 = v_u_63.Position
						local v87 = v_u_45.Height
						v81(v82, v83(v84(v80, v85, v86 + Vector3.new(0, v87, 0) + (v79.Position - v_u_63.Position) * Vector3.new(1, 0, 1) * 0.7, v79.Position)))
						if v80 >= 1 then
							local v88 = v_u_69
							if type(v88) ~= "string" then
								local v_u_89 = script.GroundImpact:Clone()
								local v90 = v_u_89.Size.Y * 0.5
								v_u_89.CFrame = v79 + Vector3.new(0, v90, 0)
								for _, v91 in v_u_89:GetDescendants() do
									if v91:IsA("ParticleEmitter") then
										v91.Color = v_u_49
									end
								end
								v_u_89.Parent = workspace
								v_u_15.emit(v_u_89)
								v_u_15.disable(v_u_72)
								task.delay(3, function()
									v_u_72:Destroy()
									v_u_89:Destroy()
								end)
								v_u_75:Disconnect()
							end
						end
						debug.profileend()
					end)
				end
			end)
		end
	end))
	local v92 = Random.new()
	for _, v93 in v_u_24 do
		local v94 = v_u_30[v93]
		local v95 = v93.Size.Y * 1.1
		v93.CFrame = v94 - Vector3.new(0, v95, 0)
		local v_u_96 = v_u_2:Create(v93, TweenInfo.new(v92:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["CFrame"] = v_u_30[v93]
		})
		local v_u_97 = v_u_19:Add(function()
			v_u_96:Cancel()
			v_u_96:Destroy()
		end)
		v_u_96.Completed:Once(function()
			v_u_19:Remove(v_u_97)
		end)
		v_u_96:Play()
	end
end
function v4.OnStop(_)
	v_u_19:Destroy()
	table.clear(v_u_21)
end
function v4.OnLoad(_)
	v_u_17.OnClientEvent:Connect(function(p_u_98, p99)

		if not p99 then 
			return 
		end

		v_u_8.playBurst(script.FireworkBurst, p99, { v_u_1.Sounds.Events["10B Visits"]["Brainrot Hit"] }, {
			["modify"] = function(p100)
				local v101 = ColorSequence.new(Color3.new(1, 1, 1))
				local v102 = p_u_98
				local v103 = script.Effects[tostring(v102)].specs["Embers [20]"]
				if v103 then
					v101 = v103.Color
				end
				for _, v104 in p100:GetDescendants() do
					if v104:IsA("ParticleEmitter") then
						v104.Color = v101
					end
				end
				return p100
			end
		})
	end)
end
return v4