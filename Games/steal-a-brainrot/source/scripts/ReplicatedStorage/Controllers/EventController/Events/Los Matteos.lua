game:GetService("ServerScriptService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.AnimalController)
local v_u_8 = require(v_u_1.Controllers.SoundController)
local v_u_9 = require(v_u_1.Controllers.CycleController)
local v_u_10 = require(v_u_1.Controllers.EventController)
require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_11 = require(v_u_1.Shared.SharedEventUtils)
local v_u_12 = require(v_u_1.Packages.EvLightning)
local v_u_13 = require(v_u_1.Packages.CreateTween)
local v_u_14 = require(v_u_1.Shared.ShakePresets)
local v_u_15 = require(v_u_1.Shared.MapInformation)
local v_u_16 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Shared.Snapshot)
require(script.TreeRootAnimator)
local v17 = require(v_u_1.Packages.Shake)
local v18 = require(v_u_1.Packages.Trove)
local v19 = require(v_u_1.Packages.Net)
local v_u_20 = require(v_u_1.Shared.VFX)
local v_u_21 = script.Name
local v_u_22 = script.Clouds:GetChildren()
local v_u_23 = workspace.Events["Los Matteos"].CloudsStart
local v_u_24 = workspace.Events["Los Matteos"].CloudsEnd
local v_u_25 = v19:RemoteEvent("EventService/Los Matteos/CreateLightningBolt")
local v_u_26 = RaycastParams.new()
v_u_26.FilterDescendantsInstances = { workspace.Events["Los Matteos"].Areas }
v_u_26.FilterType = Enum.RaycastFilterType.Include
local v_u_27 = v18.new()
local v_u_28 = Instance.new("Part")
v_u_28.Anchored = true
v_u_28.CanCollide = false
v_u_28.TopSurface = Enum.SurfaceType.Smooth
v_u_28.BottomSurface = Enum.SurfaceType.Smooth
v_u_28.Material = Enum.Material.Neon
v_u_28.Color = Color3.fromRGB(96, 234, 255)
local v_u_29 = v17.new()
v_u_29.Amplitude = 3
v_u_29.Frequency = 0.1
v_u_29.FadeInTime = 0
v_u_29.FadeOutTime = 0.6
v_u_29.PositionInfluence = Vector3.new(0.5, 0.5, 0.5)
v_u_29.RotationInfluence = Vector3.new(2.5, 0.5, 0.5)
local function v_u_47()
	local v30 = v_u_27:Extend()
	local v_u_31 = table.create(4)
	v30:Add(function()
		table.clear(v_u_31)
	end)
	local v_u_32 = 0
	v30:Add(v_u_3.PreRender:Connect(function(p33)
		debug.profilebegin("Los Matteos Event")
		v_u_32 = v_u_32 + p33
		for v34, v35 in v_u_31 do
			if v35.target and v35.targetAttachment then
				v35.beam.First.Enabled = true
				v35.beam.Second.Enabled = true
				local v36 = v_u_32 - v34 + 1
				local v37 = math.clamp(v36, 0, 1)
				local v38 = v35.beam.WorldPosition
				v35.targetAttachment.Position = v38 + (v35.target:GetPivot().Position - v38) * v37
			end
		end
		debug.profileend()
	end))
	v30:Add(v_u_16.observeTag("LosMatteosPlayerVFX", function(p_u_39)
		local v_u_40 = script.PlayerVFX.Beam:Clone()
		v_u_40.Parent = p_u_39
		local v_u_41 = script.PlayerVFX.Torso:Clone()
		v_u_41.Parent = p_u_39
		local v_u_42 = p_u_39:GetAttribute("LosMatteosIndex")
		v_u_31[v_u_42] = {
			["beam"] = v_u_40,
			["target"] = nil
		}
		local v_u_46 = v_u_16.observeTag("LosMatteosPlayerVFX", function(p43)
			if p43 == p_u_39 then
				return nil
			end
			if p43:GetAttribute("LosMatteosIndex") ~= p_u_39:GetAttribute("LosMatteosIndex") % 3 + 1 then
				return nil
			end
			local v_u_44 = Instance.new("Attachment")
			v_u_44.Position = v_u_40.WorldPosition
			v_u_44.Parent = workspace.Terrain
			local v45 = v_u_31[p_u_39:GetAttribute("LosMatteosIndex")]
			v45.target = p43
			v45.beam.First.Attachment0 = v_u_44
			v45.beam.Second.Attachment0 = v_u_44
			v45.targetAttachment = v_u_44
			return function()
				v_u_44:Destroy()
			end
		end)
		return function()
			v_u_41:Destroy()
			v_u_40:Destroy()
			v_u_46()
			v_u_31[v_u_42] = nil
		end
	end))
end
function v6.OnStart(_)
	local v_u_48 = v_u_10:GetActiveEventData(v_u_21)
	assert(v_u_48)
	local v_u_49 = v_u_1:GetAttribute("LosMatteosSpawn")
	if not v_u_49 then
		v_u_49 = v_u_15.MapCenter.Position
		local v50 = workspace:Raycast(v_u_49, Vector3.new(-0, -25, -0), v_u_26)
		if v50 then
			local v51 = v_u_49.X
			local v52 = v50.Position.Y
			local v53 = v_u_49.Z
			v_u_49 = Vector3.new(v51, v52, v53)
		end
	end
	v_u_1:SetAttribute("LosMatteosEvent", true)
	v_u_27:Add(function()
		v_u_1:SetAttribute("LosMatteosEvent", nil)
		v_u_7:Activate("Blink")
		v_u_9:Update()
		v_u_8:UpdateOST()
		v_u_8:UpdateAmbience()
	end)
	local function v_u_85(p54, p55, p_u_56)
		local function v72(p_u_57, p_u_58, p_u_59, p60)
			local v_u_61 = p_u_57.CFrame
			local v62 = p60 and 0 or p_u_58.X
			local v63 = p60 and 0 or p_u_58.Z
			local v64 = Vector3.new(v62, 0, v63)
			local v65 = v_u_61 * CFrame.new(0, -(p_u_58.Y - v64.Y) / 2, 0)
			p_u_57.Size = v64
			p_u_57.CFrame = v65
			local v_u_66 = p_u_57.Transparency
			p_u_57.Transparency = 1
			local v67 = v_u_27
			local v68 = task.delay
			local v69
			if p_u_56 then
				v69 = p_u_56(p_u_59)
			else
				v69 = p_u_59
			end
			v67:Add(v68(v69, function()
				p_u_57.Transparency = v_u_66
				local v70 = not p_u_56 and 1 or p_u_56(p_u_59 + 1)
				local v71 = TweenInfo.new(v70, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				v_u_13(p_u_57, v71, {
					["Size"] = p_u_58
				})
				v_u_13(p_u_57, v71, {
					["CFrame"] = v_u_61
				})
			end))
		end
		local v73 = {}
		local v74 = (1 / 0)
		local v75 = (-1 / 0)
		for _, v76 in p54:GetDescendants() do
			if v76:IsA("BasePart") and v76.Transparency < 1 then
				table.insert(v73, v76)
				local v77 = v76.Position.Y
				v74 = math.min(v74, v77)
				local v78 = v76.Position.Y
				v75 = math.max(v75, v78)
			end
		end
		table.sort(v73, function(p79, p80)
			return p79.Position.Y < p80.Position.Y
		end)
		local v81 = v75 - v74
		for _, v82 in v73 do
			local v83 = v82.Color.R * 255 < 90
			local v84 = (v82.Position.Y - v74) / v81 * p55
			if v83 then
				v84 = v84 + 0.2
			end
			v72(v82, v82.Size, v84, v83)
		end
	end
	v_u_27:Add(task.spawn(function()
		v_u_8:PlaySound(v_u_1.Sounds.Events["Los Matteos"].Grow, v_u_49, false)
	end))
	v_u_27:Add(task.delay(v_u_48.startedAt + 3 - workspace:GetServerTimeNow(), function()
		v_u_1:SetAttribute("LosMatteosEventNightTime", true)
		v_u_27:Add(function()
			v_u_1:SetAttribute("LosMatteosEventNightTime", nil)
		end)
		v_u_9:Update()
		v_u_8:UpdateOST()
		v_u_8:UpdateAmbience()
		local v86 = v_u_27:Clone(script.Tree)
		v86:PivotTo(CFrame.new(v_u_49))
		if v_u_1:GetAttribute("LosMatteosEventIsRainbow") then
			for _, v87 in v86.Leaves:GetDescendants() do
				v87:SetAttribute("RainbowIgnoreTransparency", true)
				v87:AddTag("RainbowModel")
			end
		end
		v86.Parent = workspace
		v_u_85(v86, 5, function(p88)
			local v89 = p88 + 3
			return v_u_48.startedAt + v89 - workspace:GetServerTimeNow()
		end)
	end))
	v_u_27:Add(task.delay(v_u_48.startedAt + 7 - workspace:GetServerTimeNow(), function()
		v_u_1.Sounds.Events["Los Matteos"].Roots:Play()
	end))
	v_u_27:Add(function()
		v_u_1.Sounds.Events["Los Matteos"].Roots:Stop()
	end)
	v_u_27:Add(v_u_1:GetAttributeChangedSignal("LosMatteosGrowing"):Connect(function()
		v_u_1.Sounds.Events["Los Matteos"].Roots.Looped = v_u_1:GetAttribute("LosMatteosGrowing") ~= false
	end))
	v_u_27:Add(v_u_16.observeTag("LosMatteos_Tree", function(p90)
		v_u_85(p90, 1)
		return nil
	end))
	v_u_27:Add(v_u_16.observeCharacter(v_u_4.LocalPlayer, function(_, p91)
		return v_u_27:Add(v_u_16.observeAttribute(p91, "Matteo_CollectedTree", function(p92)
			if p92 then
				return v_u_27:Add(v_u_16.observeTag("LosMatteos_TreePrompt", function(p_u_93)
					p_u_93.Enabled = false
					return function()
						p_u_93.Enabled = true
					end
				end, { workspace }))
			else
				return nil
			end
		end))
	end))
	local v_u_94 = {}
	local function v124()
		local function v_u_110(p95, p96)
			local v97 = v_u_23.Position
			local v98 = v_u_23.Size
			local v99 = v_u_24.Position
			local v100 = v_u_27:Clone(v_u_22[math.random(1, #v_u_22)])
			v100.Transparency = 1
			v100.CFrame = CFrame.new(v97.X + math.random(-v98.X * 0.5, v98.X * 0.5), v97.Y, v97.Z + (p95 or 0) * 30 + (p96 or 0))
			local v101 = v100.Position.X
			local v102 = v97.Y
			local v103 = v99.Z
			local v104 = Vector3.new(v101, v102, v103)
			local v105 = v99 - v97
			local v106 = v104 - v100.Position
			if vector.dot(v105, v106) >= 0 then
				v100.Parent = workspace.Camera
				local v107 = 50 / v100.Size.Magnitude
				local v108 = {
					["instance"] = v100,
					["speed"] = math.clamp(v107, 5, 15) * (math.random(80, 120) / 100),
					["startPos"] = v100.Position,
					["endPos"] = v104
				}
				v_u_27:Add(v_u_13(v100, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, (p96 or 0) * 0.1 + (math.abs(p95 or 0) + 1) * 0.5), {
					["Transparency"] = 0
				}))
				local v109 = v_u_94
				table.insert(v109, v108)
				return v108
			end
		end
		local v111 = 0
		for v112 = 1, 50 do
			v_u_110(v111, v112)
			if v112 % 3 == 1 then
				v111 = v111 + 1
			end
		end
		v_u_27:Add(v_u_3.PostSimulation:Connect(function(p113)
			debug.profilebegin("Los Matteos:Clouds")
			for v114 = #v_u_94, 1, -1 do
				local v115 = v_u_94[v114]
				local v_u_116 = v115.instance
				local v117 = v_u_116.Position
				local v118 = v115.endPos - v117
				local v119 = vector.normalize(v118)
				local v120 = v115.endPos - v117
				local v121 = vector.magnitude(v120)
				local v122 = v115.speed * p113
				local v123
				if v121 < v122 then
					v123 = v115.endPos
					table.remove(v_u_94, v114)
					v_u_27:Add(v_u_13(v_u_116, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
						["Transparency"] = 1
					})).Completed:Once(function()
						v_u_27:Remove(v_u_116)
					end)
					v_u_110()
				else
					v123 = v117 + v119 * v122
				end
				v_u_11.pushPartCFrame(v_u_116, CFrame.lookAt(v123, v123 + v119))
			end
			debug.profileend()
		end))
	end
	v_u_27:Add(task.delay(v_u_48.startedAt + 8 - workspace:GetServerTimeNow(), function()
		v_u_27:Clone(script.RainWeather).Parent = workspace
	end))
	v_u_27:Add(v_u_25.OnClientEvent:Connect(function(p125, p_u_126, p_u_127)
		local v128 = Random.new(p125)
		local v129 = (workspace.CurrentCamera.CFrame.Position - p_u_126).Magnitude
		if v129 <= 75 then
			local v130 = v_u_29:Clone()
			local v131 = (1 - v129 / 75 * 0.5) ^ 2
			v130.Amplitude = v130.Amplitude * v131
			v130.RotationInfluence = v130.RotationInfluence * v131
			v_u_27:Add(v_u_14.BindShakeToCamera(v130))
			v130:Start()
		end
		local v132 = {}
		for _, v133 in v_u_94 do
			if ((v133.instance.Position - p_u_126) * Vector3.new(1, 0, 1)).Magnitude < 100 then
				local v134 = v133.instance
				table.insert(v132, v134)
			end
		end
		local v135
		if #v132 > 0 then
			local v136 = v132[v128:NextInteger(1, #v132)]
			v135 = v136.Position
			v_u_8:PlaySound(v_u_1.Sounds.Events["Los Matteos"]["Lightning Strike"], v136.Position, false)
			local v137 = v136.Color
			v136.Color = Color3.fromRGB(90, 109, 161)
			v_u_13(v136, TweenInfo.new(1, Enum.EasingStyle.Sine), {
				["Color"] = v137
			})
			for _, v138 in script.CloudParticles:GetChildren() do
				local v139 = v138:Clone()
				v139.Parent = v136
				v_u_20.emit(v139)
				v_u_5:AddItem(v139, 2)
			end
		else
			v135 = p_u_126 + Vector3.new(0, 70, 0)
		end
		local v_u_140 = v_u_12.create(v135, p_u_126, {
			["bends"] = 4,
			["thickness"] = 1,
			["max_depth"] = 1,
			["fork_bends"] = 1,
			["fork_chance"] = 30,
			["decay"] = 3,
			["material"] = Enum.Material.Neon
		})
		local v_u_141 = Instance.new("Model")
		v_u_140.model = v_u_141
		v_u_141.Name = "LightningBolt"
		local v142 = v_u_140:GetLines()
		table.sort(v142, function(p143, p144)
			return p143.origin.Y > p144.origin.Y
		end)
		local v145 = v142[#v142].origin.Y
		local v146 = v142[1].origin.Y
		local v147 = v146 - v145
		local v148 = v_u_140.random:NextInteger(10, 20) / 100
		local v_u_149 = table.create(#v142)
		for v150, v151 in v142 do
			if v151.goal.Y >= p_u_126.Y then
				local v152 = (v146 - v151.origin.Y) / v147 * v148
				local v153 = math.max(v152, 0)
				local v154 = v_u_28:Clone()
				local v155 = v_u_140.thickness - v151.depth * 2 * 0.1
				local v156 = v_u_140.thickness - v151.depth * 2 * 0.1
				local v157 = (v151.origin - v151.goal).Magnitude + 0.5
				v154.Size = Vector3.new(v155, v156, v157)
				v154.CFrame = CFrame.new((v151.goal + v151.origin) / 2, v151.goal)
				v154.Transparency = 1
				v154.Parent = v_u_141
				v_u_149[v150] = v154
				v_u_13(v154, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, v153), {
					["Transparency"] = v151.transparency
				})
			end
		end
		task.delay(v148 + 0.05, function()
			local v_u_158
			if p_u_127 then
				v_u_158 = script.StrikeBrainrot:Clone()
			else
				v_u_158 = script.Strike:Clone()
			end
			v_u_158.Position = p_u_126
			v_u_158.Parent = workspace
			v_u_20.emit(v_u_158)
			if p_u_127 then
				v_u_8:PlaySound(v_u_1.Sounds.Events["Los Matteos"].Hit, p_u_126, false)
			else
				v_u_8:PlaySound(v_u_1.Sounds.Events["Los Matteos"].HitNothing, p_u_126, false)
			end
			for _, v_u_159 in v_u_149 do
				task.spawn(function()
					v_u_159.Transparency = 0
					task.wait(0.1)
					v_u_159.Transparency = 1
					task.wait(0.1)
					v_u_13(v_u_159, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
						["Transparency"] = 0.4
					})
				end)
			end
			task.delay(v_u_140.options.decay or 1, function()
				v_u_158:Destroy()
				v_u_141:Destroy()
				v_u_140.destroyed = true
			end)
		end)
		v_u_141.Parent = workspace.CurrentCamera
		v_u_140.drew = true
	end))
	v124()
	v_u_27:Add(task.spawn(function()
		v_u_47()
	end))
end
function v6.OnStop(_)
	v_u_27:Destroy()
end
function v6.OnLoad(_)
	task.spawn(pcall, function()
		v_u_2:PreloadAsync(script:GetChildren())
	end)
end
return v6