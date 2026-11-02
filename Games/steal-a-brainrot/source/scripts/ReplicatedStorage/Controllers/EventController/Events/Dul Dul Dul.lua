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
local v_u_10 = require(v_u_1.Controllers.EventController.ClientEventUtils)
local v_u_11 = require(v_u_1.Packages.CreateTween)
local v_u_12 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
local v_u_13 = require(v_u_1.Packages.Trove)
local v14 = require(v_u_1.Packages.Net)
local v_u_15 = require(v_u_1.Shared.VFX)
require(v_u_1.Shared.Snapshot)
local v_u_16 = script.Name
local v_u_17 = v14:RemoteEvent("EventService/Dul Dul Dul/Burst")
local v_u_18 = v_u_13.new()
local function v_u_49(p19, p20, p_u_21)
	-- upvalues: (copy) v_u_18, (copy) v_u_11
	local function v37(p_u_22, p_u_23, p_u_24, p25)
		-- upvalues: (ref) v_u_18, (copy) p_u_21, (ref) v_u_11
		local v_u_26 = p_u_22.CFrame
		local v27 = p25 and 0 or p_u_23.X
		local v28 = p25 and 0 or p_u_23.Z
		local v29 = Vector3.new(v27, 0, v28)
		local v30 = v_u_26 * CFrame.new(0, -(p_u_23.Y - v29.Y) / 2, 0)
		p_u_22.Size = v29
		p_u_22.CFrame = v30
		local v_u_31 = p_u_22.Transparency
		p_u_22.Transparency = 1
		p_u_22.CanCollide = false
		v_u_18:Add(function()
			-- upvalues: (copy) p_u_22, (copy) v_u_31, (copy) p_u_23, (copy) v_u_26
			p_u_22.Transparency = v_u_31
			p_u_22.CanCollide = true
			p_u_22.Size = p_u_23
			p_u_22.CFrame = v_u_26
		end)
		local v32 = v_u_18
		local v33 = task.delay
		local v34
		if p_u_21 then
			v34 = p_u_21(p_u_24)
		else
			v34 = p_u_24
		end
		v32:Add(v33(v34, function()
			-- upvalues: (copy) p_u_22, (copy) v_u_31, (ref) p_u_21, (copy) p_u_24, (ref) v_u_11, (copy) p_u_23, (copy) v_u_26
			p_u_22.Transparency = v_u_31
			p_u_22.CanCollide = true
			local v35 = not p_u_21 and 1 or p_u_21(p_u_24 + 1)
			local v36 = TweenInfo.new(v35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			v_u_11(p_u_22, v36, {
				["Size"] = p_u_23
			})
			v_u_11(p_u_22, v36, {
				["CFrame"] = v_u_26
			})
		end))
	end
	local v38 = {}
	local v39 = (1 / 0)
	local v40 = (-1 / 0)
	for _, v41 in p19:GetDescendants() do
		if v41:IsA("BasePart") and v41.Transparency < 1 then
			table.insert(v38, v41)
			local v42 = v41.Position.Y
			v39 = math.min(v39, v42)
			local v43 = v41.Position.Y
			v40 = math.max(v40, v43)
		end
	end
	table.sort(v38, function(p44, p45)
		return p44.Position.Y < p45.Position.Y
	end)
	local v46 = v40 - v39
	for _, v47 in v38 do
		local v48 = (v47.Position.Y - v39) / v46 * p20 + 0.25
		v37(v47, v47.Size, v48)
	end
end
local function v_u_67()
	-- upvalues: (copy) v_u_18, (copy) v_u_3, (copy) v_u_12
	local v50 = v_u_18:Extend()
	local v_u_51 = table.create(4)
	v50:Add(function()
		-- upvalues: (copy) v_u_51
		table.clear(v_u_51)
	end)
	local v_u_52 = 0
	v50:Add(v_u_3.PreRender:Connect(function(p53)
		-- upvalues: (ref) v_u_52, (copy) v_u_51
		debug.profilebegin("Dul Dul Dul Event")
		v_u_52 = v_u_52 + p53
		for v54, v55 in v_u_51 do
			if v55.target and v55.targetAttachment then
				v55.beam.First.Enabled = true
				v55.beam.Second.Enabled = true
				local v56 = v_u_52 - v54 + 1
				local v57 = math.clamp(v56, 0, 1)
				local v58 = v55.beam.WorldPosition
				v55.targetAttachment.Position = v58 + (v55.target:GetPivot().Position - v58) * v57
			end
		end
		debug.profileend()
	end))
	v50:Add(v_u_12.observeTag("DulDulDulPlayerVFX", function(p_u_59)
		-- upvalues: (copy) v_u_51, (ref) v_u_12
		local v_u_60 = script.PlayerVFX.Beam:Clone()
		v_u_60.Parent = p_u_59
		local v_u_61 = script.PlayerVFX.Torso:Clone()
		v_u_61.Parent = p_u_59
		local v_u_62 = p_u_59:GetAttribute("DulDulDulIndex")
		v_u_51[v_u_62] = {
			["beam"] = v_u_60,
			["target"] = nil
		}
		local v_u_66 = v_u_12.observeTag("DulDulDulPlayerVFX", function(p63)
			-- upvalues: (copy) p_u_59, (copy) v_u_60, (ref) v_u_51
			if p63 == p_u_59 then
				return nil
			end
			if p63:GetAttribute("DulDulDulIndex") ~= p_u_59:GetAttribute("DulDulDulIndex") % 4 + 1 then
				return nil
			end
			local v_u_64 = Instance.new("Attachment")
			v_u_64.Position = v_u_60.WorldPosition
			v_u_64.Parent = workspace.Terrain
			local v65 = v_u_51[p_u_59:GetAttribute("DulDulDulIndex")]
			v65.target = p63
			v65.beam.First.Attachment0 = v_u_64
			v65.beam.Second.Attachment0 = v_u_64
			v65.targetAttachment = v_u_64
			return function()
				-- upvalues: (copy) v_u_64
				v_u_64:Destroy()
			end
		end)
		return function()
			-- upvalues: (copy) v_u_61, (copy) v_u_60, (copy) v_u_66, (ref) v_u_51, (copy) v_u_62
			v_u_61:Destroy()
			v_u_60:Destroy()
			v_u_66()
			v_u_51[v_u_62] = nil
		end
	end))
end
function v4.OnStart(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_16, (copy) v_u_18, (copy) v_u_5, (copy) v_u_8, (copy) v_u_7, (copy) v_u_67, (copy) v_u_12, (copy) v_u_13, (copy) v_u_1, (copy) v_u_49, (copy) v_u_15
	local v68 = v_u_9:GetActiveEventData(v_u_16)
	assert(v68)
	v_u_18:Add(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_8, (ref) v_u_7
		v_u_5:Activate("Blink")
		v_u_8:Update()
		v_u_7:UpdateOST()
		v_u_7:UpdateAmbience()
	end)
	v_u_8:Update()
	v_u_7:UpdateOST()
	v_u_7:UpdateAmbience()
	v_u_18:Add(task.spawn(function()
		-- upvalues: (ref) v_u_67
		v_u_67()
	end))
	v_u_18:Add(v_u_12.observeTag("DulDulDul", function(p_u_69)
		-- upvalues: (ref) v_u_13, (ref) v_u_18, (ref) v_u_12, (ref) v_u_1
		local v70 = v_u_13.new()
		local v71 = p_u_69:WaitForChild("HumanoidRootPart")
		local v_u_72 = v70:Clone(script["Dul Dul Dul"])
		local v73 = v70:Add(Instance.new("Weld"))
		v73.Part0 = v_u_72.PrimaryPart
		v73.Part1 = v71
		v73.C0 = CFrame.Angles(0, 0, 0)
		v73.Parent = v_u_72.PrimaryPart
		v_u_72.Parent = p_u_69
		local v74 = v_u_72.AnimationController.Animator
		local v75 = v74:LoadAnimation(script.Idle)
		v75.Priority = Enum.AnimationPriority.Idle
		v75.Looped = true
		v75:Play()
		local v_u_76 = v74:LoadAnimation(script.Walk)
		v_u_76.Priority = Enum.AnimationPriority.Movement
		local v77 = p_u_69:GetAttribute("Index")
		local v_u_78 = v74:LoadAnimation(script[(v77 == 1 or v77 == 4) and "Build2" or "Build1"])
		v_u_78.Priority = Enum.AnimationPriority.Action
		local v_u_79 = v74:LoadAnimation(script.Gesture)
		v_u_79.Priority = Enum.AnimationPriority.Action2
		local v_u_80 = v74:LoadAnimation(script.Attack)
		v_u_80.Priority = Enum.AnimationPriority.Action3
		local v_u_81 = nil
		v70:Add(v_u_80:GetMarkerReachedSignal("CreateTie"):Connect(function()
			-- upvalues: (ref) v_u_81, (ref) v_u_18, (copy) v_u_72
			if not v_u_81 then
				local v82 = v_u_18:Clone(script.Tie)
				v82.RigidConstraint.Attachment1 = v_u_72:FindFirstChild("HandAttachment", true)
				v82.Parent = v_u_72
				v_u_81 = v82
			end
		end))
		v70:Add(v_u_80:GetMarkerReachedSignal("DestroyTie"):Connect(function()
			-- upvalues: (ref) v_u_81, (ref) v_u_18
			if v_u_81 then
				v_u_18:Remove(v_u_81)
				v_u_81 = nil
			end
		end))
		v70:Add(v_u_80:GetMarkerReachedSignal("Freeze"):Connect(function()
			-- upvalues: (copy) p_u_69, (copy) v_u_80
			if not p_u_69:GetAttribute("FinishAttackAnimation") then
				v_u_80:AdjustSpeed(0)
			end
		end))
		v70:Add(task.defer(function()
			-- upvalues: (copy) p_u_69, (copy) v_u_76
			if p_u_69:GetAttribute("IsRunning") then
				v_u_76:Play()
			end
		end))
		v70:Add(v_u_12.observeAttribute(p_u_69, "IsBuilding", function(p83)
			-- upvalues: (copy) v_u_72, (copy) v_u_78
			if not p83 then
				return nil
			end
			local v_u_84 = script.Hammer:Clone()
			v_u_84["Cube.010"].RigidConstraint.Attachment1 = v_u_72:FindFirstChild("HandAttachment", true)
			v_u_84.Parent = v_u_72
			v_u_78:Play()
			return function()
				-- upvalues: (ref) v_u_78, (copy) v_u_84
				v_u_78:Stop()
				v_u_84:Destroy()
			end
		end))
		local v_u_85 = nil
		v70:Add(v_u_12.observeAttribute(p_u_69, "Gesture", function(p86)
			-- upvalues: (ref) v_u_1, (copy) v_u_72, (ref) v_u_85, (copy) v_u_79
			if not p86 then
				return nil
			end
			local v_u_87 = v_u_1.Sounds.Events["Dul Dul Dul"].Yap:Clone()
			v_u_87.Parent = v_u_72.PrimaryPart
			v_u_87:Play()
			v_u_85 = v_u_87
			v_u_79:Play()
			return function()
				-- upvalues: (copy) v_u_87, (ref) v_u_79, (ref) v_u_85
				v_u_87:Destroy()
				v_u_87:Stop()
				v_u_79:Stop()
				if v_u_85 == v_u_87 then
					v_u_85 = nil
				end
			end
		end))
		v70:Add(p_u_69:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			-- upvalues: (ref) v_u_81, (ref) v_u_18, (ref) v_u_85, (copy) v_u_80
			if v_u_81 then
				v_u_18:Remove(v_u_81)
				v_u_81 = nil
			end
			if v_u_85 then
				v_u_85:Pause()
			end
			v_u_80:Play()
		end))
		v70:Add(v_u_80.Ended:Connect(function()
			-- upvalues: (ref) v_u_85
			if v_u_85 then
				v_u_85:Resume()
			end
		end))
		v70:Add(p_u_69:GetAttributeChangedSignal("FinishAttackAnimation"):Connect(function()
			-- upvalues: (copy) p_u_69, (copy) v_u_80
			if p_u_69:GetAttribute("FinishAttackAnimation") then
				v_u_80:AdjustSpeed(1)
			end
		end))
		v70:Add(p_u_69:GetAttributeChangedSignal("IsRunning"):Connect(function()
			-- upvalues: (copy) p_u_69, (copy) v_u_76
			if p_u_69:GetAttribute("IsRunning") then
				v_u_76:Play()
			else
				v_u_76:Stop()
			end
		end))
		return v70:WrapClean()
	end))
	v_u_18:Add(task.delay(v68.startedAt + 4 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_5, (ref) v_u_18, (ref) v_u_12
		v_u_5:Activate("Blink")
		v_u_18:Clone(script.SchoolMap).Parent = workspace
		v_u_18:Add(v_u_12.observeTag("HideInDulDulDul", function(p_u_88)
			local v_u_89 = p_u_88.Parent
			p_u_88.Parent = script
			return function()
				-- upvalues: (copy) p_u_88, (copy) v_u_89
				pcall(function()
					-- upvalues: (ref) p_u_88, (ref) v_u_89
					p_u_88.Parent = v_u_89
				end)
			end
		end, { workspace, script }))
		v_u_5:Run("DulDulDulEvent", "GrassRecolor")
		v_u_18:Add(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Stop("DulDulDulEvent", "GrassRecolor")
		end)
		v_u_5:Run("DulDulDulEvent", "WallRecolor")
		v_u_18:Add(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Stop("DulDulDulEvent", "WallRecolor")
		end)
		v_u_5:Run("DulDulDulEvent", "WallBottomRecolor")
		v_u_18:Add(function()
			-- upvalues: (ref) v_u_5
			v_u_5:Stop("DulDulDulEvent", "WallBottomRecolor")
		end)
	end))
	v_u_18:Add(task.spawn(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_18, (ref) v_u_7, (ref) v_u_49, (ref) v_u_15
		while not v_u_1:GetAttribute("DulDulDulConstructionStart") do
			task.wait()
		end
		local v_u_90 = v_u_1:GetAttribute("DulDulDulConstructionStart")
		if v_u_90 then
			local v91 = v_u_18:Clone(script.Machine)
			v91.Parent = workspace
			v_u_7:PlaySound(v_u_1.Sounds.Events["Dul Dul Dul"].Building, v91.Root.Position, false)
			local v_u_92 = v_u_18:Clone(script.BuildingVFX)
			v_u_92.Parent = workspace
			v_u_49(v91.Animate.AnimateObjects, 6, function(p93)
				-- upvalues: (copy) v_u_90
				return v_u_90 + p93 + 3 - workspace:GetServerTimeNow()
			end)
			v_u_18:Add(task.delay(v_u_90 + 3 - workspace:GetServerTimeNow(), function()
				-- upvalues: (ref) v_u_15, (copy) v_u_92, (ref) v_u_18, (copy) v_u_90
				v_u_15.enable(v_u_92)
				v_u_18:Add(task.delay(v_u_90 + 6 + 3 - workspace:GetServerTimeNow(), function()
					-- upvalues: (ref) v_u_15, (ref) v_u_92
					v_u_15.disable(v_u_92)
				end))
			end))
		end
	end))
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_18
	v_u_18:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_17, (copy) v_u_6, (copy) v_u_10, (copy) v_u_15, (copy) v_u_7
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2, (ref) v_u_1
		v_u_2:PreloadAsync(v_u_1.Sounds.Events["Dul Dul Dul"]:GetChildren())
	end)
	v_u_17.OnClientEvent:Connect(function(p94)
		-- upvalues: (ref) v_u_6, (ref) v_u_10, (ref) v_u_15, (ref) v_u_7, (ref) v_u_1
		local v95 = v_u_6:GetAnimals()[p94]
		if v95 then
			local v_u_96 = script.Burst:Clone()
			v_u_96.CFrame = CFrame.new(v_u_10.getAnimalPosition(p94, {
				["top"] = true
			}))
			v_u_96.Anchored = false
			local v97 = Instance.new("WeldConstraint")
			v97.Part0 = v_u_96
			v97.Part1 = v95.AnimalModel.PrimaryPart
			v97.Parent = v_u_96
			v_u_96.Parent = workspace
			v_u_15.emit(v_u_96)
			v_u_7:PlaySound(v_u_1.Sounds.Events["Dul Dul Dul"].Burst, v_u_96.Position, false)
			task.delay(3, function()
				-- upvalues: (copy) v_u_96
				v_u_96:Destroy()
			end)
		end
	end)
end
return v4
