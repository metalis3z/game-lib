-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = { "number", "Vector3", "Color3" }
local v_u_2 = {
	"Head",
	"Torso",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg"
}
local v_u_3 = {
	["JumpPower"] = 0,
	["JumpHeight"] = 0,
	["AutoRotate"] = false
}
local v_u_4 = {
	["PlayerAura"] = {
		["OutlineTransparency"] = 1,
		["FillTransparency"] = 1
	},
	["goodbai"] = {
		["OutlineTransparency"] = 1,
		["FillTransparency"] = 1
	},
	["Sound"] = {
		["Volume"] = 0
	},
	["ParticleEmitter"] = {
		["Enabled"] = false
	},
	["BodyVelocity"] = true,
	["BodyGyro"] = true,
	["BodyPosition"] = true
}
local v_u_5 = {
	["ParticleEmitter"] = false,
	["BodyVelocity"] = false,
	["BodyGyro"] = false,
	["BodyPosition"] = false
}
local v_u_6 = game:GetService("RunService")
local v7 = game:GetService("ReplicatedStorage")
local v_u_8 = game:GetService("Players")
local v_u_9 = game:GetService("CollectionService")
local v_u_10 = game:GetService("TweenService")
local v_u_11 = game:GetService("Debris")
local v_u_12 = require(v7.Modules.Sounds)
local v_u_13 = require(v7.Modules.Util)
local v_u_14 = require(v7.Modules.Network)
local v_u_15 = require(script.KillEffects)
local v_u_16 = {
	["Ragdolls"] = {},
	["RagdollTag"] = "Ragdoll"
}
local function v_u_31(p17, p18)
	-- upvalues: (copy) v_u_10, (copy) v_u_5, (copy) v_u_4, (copy) v_u_11, (copy) v_u_1
	local v19 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	for _, v20 in ipairs(p17:GetDescendants()) do
		local v21
		if p18 then
			v21 = v_u_5[v20.Name] or nil
		else
			v21 = nil
		end
		local v22
		if p18 then
			v22 = v_u_5[v20.ClassName] or nil
		else
			v22 = nil
		end
		if v21 ~= false and v22 ~= false then
			local v23 = v_u_4[v20.Name] or nil
			local v24 = v_u_5[v20.ClassName] or nil
			if v23 ~= false and v24 ~= false then
				local v25 = v21 or (v22 or (v23 or v24))
				if v25 and not v20:GetAttribute("Bypassable") then
					v_u_11:AddItem(v20, 0.5)
					if v25 == true then
						v20:Destroy()
					elseif typeof(v25) == "table" then
						for v26, v27 in pairs(v25) do
							local v28 = table.find
							local v29 = v_u_1
							local v30 = v20[v26]
							if v28(v29, (typeof(v30))) then
								v_u_10:Create(v20, v19, {
									[v26] = v27
								}):Play()
							else
								v20[v26] = v27
							end
						end
					end
				end
			end
		end
	end
end
local function v_u_39(p32, p33)
	-- upvalues: (copy) v_u_6
	local v34 = v_u_6:IsServer()
	local v35 = ("%*: Attempted to set network ownership on client"):format("[RagdollHandler]")
	assert(v34, v35)
	local v36
	if p32 then
		v36 = p32:IsDescendantOf(workspace)
	else
		v36 = p32
	end
	local v37 = ("%*: Attempted to set network ownership of character that doesn\'t exist"):format("[RagdollHandler]")
	assert(v36, v37)
	for _, v38 in ipairs(p32:GetDescendants()) do
		if v38:IsA("BasePart") and v38:CanSetNetworkOwnership() then
			v38:SetNetworkOwner(p33)
		end
	end
end
local function v_u_42(p40)
	print(p40)
	if p40:GetAttribute("CustomRig") or p40:GetAttribute("ExecutionsDisabled") then
		return false
	end
	for _, v41 in ipairs({ "Torso", "Head" }) do
		if not p40:FindFirstChild(v41) then
			return false
		end
	end
	return true
end
function v_u_16.new(p_u_43)
	-- upvalues: (copy) v_u_42, (copy) v_u_16, (copy) v_u_2
	if v_u_42(p_u_43) then
		local v44 = v_u_16.Ragdolls[p_u_43]
		if v44 then
			return v44
		end
		local v45 = {
			["Connections"] = {},
			["Containers"] = {}
		}
		local v46 = {}
		local v47 = {}
		local v48 = {}
		local v49 = {}
		local v50 = p_u_43:FindFirstChild("Humanoid")
		local v51 = ("%*: Given character had no humanoid!"):format("[RagdollHandler]")
		assert(v50, v51)
		if not p_u_43:HasTag(v_u_16.RagdollTag) then
			p_u_43:AddTag(v_u_16.RagdollTag)
		end
		for _, v52 in ipairs(v_u_2) do
			local v53 = p_u_43:FindFirstChild(v52)
			if v53 then
				for _, v54 in ipairs(script.Attachments[v52]:GetChildren()) do
					local v55 = v53:FindFirstChild(v54.Name) or v54:Clone()
					v55.Parent = v53
					v46[v54.Name] = v55
				end
			end
		end
		local v56 = p_u_43:FindFirstChild("Colliders")
		if v56 then
			v56:Destroy()
		end
		local v57 = script.Colliders:Clone()
		v45.Containers.Colliders = v57
		for _, v58 in ipairs(v57:GetChildren()) do
			local v59 = p_u_43:FindFirstChild(v58.Name)
			if v59 and v59:IsA("BasePart") then
				v58.CollisionGroup = "Ragdolls"
				v58.CFrame = v59.CFrame * v58.Weld.C0
				v58.Weld.Enabled = false
				v58.Weld.Part0 = v59
				table.insert(v48, v58)
			else
				v58:Destroy()
			end
		end
		local v60 = p_u_43:FindFirstChild("Constraints")
		if v60 then
			v60:Destroy()
		end
		local v61 = script.Constraints:Clone()
		v45.Containers.Constraints = v61
		for _, v62 in ipairs(v61:GetChildren()) do
			local v63 = p_u_43:FindFirstChild(v62.Name)
			if v63 then
				if v63.Name:find("Leg") then
					local v64 = v63.Name:find("Left") and "Left" or "Right"
					local v65 = script.Misc[v64 .. "Knee"]:Clone()
					v65.Parent = v57
					v65.CollisionGroup = "None"
					v65.CFrame = v63.CFrame * v65.Weld.C0
					v65.Weld.Enabled = false
					v65.Weld.Part0 = v63
					table.insert(v48, v65)
					v49[("%* Knee"):format(v64)] = v65.Weld
					for _, v66 in ipairs(v65:GetChildren()) do
						if v66:IsA("Attachment") then
							v46[v66.Name] = v66
						end
					end
					local v67 = v65:FindFirstChildOfClass("HingeConstraint")
					v67.Enabled = false
					v67.Attachment0 = v46[v67:GetAttribute("Attachment0Name")]
					v67.Attachment1 = v46[v67:GetAttribute("Attachment1Name")]
					table.insert(v47, v67)
				end
				v62.Enabled = false
				v62.Attachment0 = v46[v62:GetAttribute("Attachment0Name")]
				v62.Attachment1 = v46[v62:GetAttribute("Attachment1Name")]
				table.insert(v47, v62)
			else
				v62:Destroy()
			end
		end
		for _, v68 in ipairs(p_u_43.Torso:GetChildren()) do
			if v68:IsA("Motor6D") then
				v49[v68.Part1.Name] = v68
			end
		end
		v50.BreakJointsOnDeath = false
		v50.RequiresNeck = false
		v50:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		v50:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		v50:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
		v45.Constraints = v47
		v45.Attachments = v46
		v45.Colliders = v48
		v45.Motors = v49
		v45.Humanoid = v50
		v45.Character = p_u_43
		v45.Active = false
		v_u_16.Ragdolls[p_u_43] = v45
		p_u_43.Destroying:Once(function()
			-- upvalues: (ref) v_u_16, (copy) p_u_43
			v_u_16.Ragdolls[p_u_43] = nil
		end)
		return v45
	end
	warn((("%*: Cannot create ragdoll for character %*!"):format("[RagdollHandler]", (tostring(p_u_43)))))
end
function v_u_16.GetProfile(p69)
	-- upvalues: (copy) v_u_16
	local v70 = v_u_16.Ragdolls[p69]
	local v71 = v70.Profile
	if not v71 or os.clock() - v71.Applied <= 1 then
		return v70 and v70.Profile or {}
	end
end
function v_u_16.SetProfile(p72, p73)
	-- upvalues: (copy) v_u_16
	local v74 = v_u_16.Ragdolls[p72] or v_u_16.new(p72)
	if v74 then
		local v75 = p73 or {}
		v75.Applied = v75.Applied or os.clock()
		v74.Profile = v75
	end
end
function v_u_16.AddProfile(p76, p77)
	-- upvalues: (copy) v_u_16, (copy) v_u_13
	local v78 = v_u_16.Ragdolls[p76] or v_u_16.new(p76)
	if v78 then
		local v79 = v78.Profile or {}
		local v80 = v79.Applied and os.clock() - v79.Applied > 1 and {} or v79
		local v81 = p77 or {}
		local v82 = v81.Applied or 0
		local v83 = v80.Applied or 0
		local v84 = os.clock
		v81.Applied = math.max(v82, v83, v84())
		v78.Profile = v_u_13:MergeTables(v80, v81)
	end
end
function v_u_16.EnableRagdoll(p_u_85, p86)
	-- upvalues: (copy) v_u_16, (copy) v_u_3, (copy) v_u_39, (copy) v_u_12
	local v_u_87 = v_u_16.Ragdolls[p_u_85] or v_u_16.new(p_u_85)
	if v_u_87 then
		if v_u_87.GetupThread then
			pcall(task.cancel, v_u_87.GetupThread)
			v_u_87.GetupThread = nil
		end
		if p86 then
			v_u_87.GetupThread = task.delay(p86, function()
				-- upvalues: (ref) v_u_87, (ref) v_u_16, (copy) p_u_85
				if v_u_87 and (v_u_87.Character and (v_u_87.Character.Parent and not v_u_87.Dead)) then
					v_u_16.DisableRagdoll(p_u_85)
				end
			end)
		end
		if not v_u_87.Active then
			v_u_87.Active = true
			p_u_85:SetAttribute("Ragdolling", true)
			for _, v88 in ipairs(v_u_87.Colliders) do
				local v89 = v88:FindFirstChild("Weld")
				if v89 and v89.Part0 then
					v88.CFrame = v88.Weld.Part0.CFrame * v88.Weld.C0
				end
				v88.CanCollide = true
				v88.Anchored = false
				v88.Weld.Enabled = true
			end
			for _, v90 in ipairs(v_u_87.Constraints) do
				local v91 = v_u_87.Motors[v90.Name]
				if not v91 or v91.Enabled then
					v90.Enabled = true
				end
			end
			for _, v92 in pairs(v_u_87.Motors) do
				v92:SetAttribute("OriginalState", v92.Enabled)
				v92.Enabled = false
			end
			v_u_87.Containers.Constraints.Parent = p_u_85
			v_u_87.Containers.Colliders.Parent = p_u_85
			v_u_87.CollisionCache = {}
			for _, v93 in ipairs(p_u_85:GetChildren()) do
				if v93:IsA("BasePart") then
					v_u_87.CollisionCache[v93] = { v93.CanCollide, v93.CollisionGroup }
					v93.CanCollide = false
					if v93 ~= p_u_85.PrimaryPart and not v93:GetAttribute("Hitbox") then
						v93.CollisionGroup = "None"
					end
					v93.Anchored = false
				end
			end
			v_u_87.OriginalProperties = {}
			for v94, v95 in pairs(v_u_3) do
				v_u_87.OriginalProperties[v94] = v_u_87.Humanoid[v94]
				v_u_87.Humanoid[v94] = v95
			end
			local v_u_96 = v_u_87.Humanoid
			v_u_87.Connections.DeathFix = v_u_96.HealthChanged:Connect(function(p97)
				-- upvalues: (copy) v_u_96
				if p97 <= 0 and v_u_96.PlatformStand then
					v_u_96.PlatformStand = false
				end
			end)
			local v98 = v_u_87.RootJoint or p_u_85.PrimaryPart:FindFirstChild("RootJoint")
			local v99 = p_u_85.PrimaryPart.AssemblyLinearVelocity
			if v98 and p_u_85:FindFirstChild("Torso") then
				v_u_87.RootJoint = v98
				v98.Enabled = false
				p_u_85.PrimaryPart.CFrame = p_u_85.Torso.CFrame
				v_u_87.TempWeld = Instance.new("Weld", p_u_85.PrimaryPart)
				v_u_87.TempWeld.Part0 = p_u_85.Torso
				v_u_87.TempWeld.Part1 = p_u_85.PrimaryPart
				p_u_85.Torso.AssemblyLinearVelocity = v99
			end
			local v100 = game.Players:GetPlayerFromCharacter(p_u_85)
			if v100 then
				v_u_39(p_u_85, v100)
			end
			v_u_87.Humanoid.PlatformStand = true
			task.delay(0.35, function()
				-- upvalues: (ref) v_u_12, (copy) p_u_85
				v_u_12:Play("ragdolledLol", {
					["Parent"] = p_u_85.PrimaryPart
				})
			end)
		end
	else
		return
	end
end
function v_u_16.DisableRagdoll(p_u_101)
	-- upvalues: (copy) v_u_16
	if p_u_101:GetAttribute("CustomRig") then
		return
	else
		local v102 = v_u_16.Ragdolls[p_u_101]
		if v102 then
			if v102.Active then
				if not v102.Dead then
					v102.Active = false
					p_u_101:SetAttribute("Ragdolling", nil)
					for _, v103 in ipairs(v102.Constraints) do
						v103.Enabled = false
					end
					for _, v104 in ipairs(v102.Colliders) do
						v104.CanCollide = false
						v104.Weld.Enabled = false
						v104.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						v104.Anchored = true
					end
					for v105, v106 in pairs(v102.OriginalProperties) do
						v102.Humanoid[v105] = v106
					end
					for v107, v108 in pairs(v102.CollisionCache) do
						v107.CanCollide = v108[1]
						v107.CollisionGroup = v108[2]
					end
					table.clear(v102.CollisionCache)
					if v102.Connections.DeathFix then
						v102.Connections.DeathFix:Disconnect()
						v102.Connections.DeathFix = nil
					end
					v102.Containers.Constraints.Parent = nil
					v102.Containers.Colliders.Parent = nil
					for _, v109 in pairs(v102.Motors) do
						v109.Enabled = v109:GetAttribute("OriginalState")
					end
					v102.Humanoid.PlatformStand = false
					p_u_101.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					if v102.RootJoint then
						v102.TempWeld:Destroy()
						p_u_101.PrimaryPart.Anchored = true
						p_u_101.Torso.Anchored = true
						p_u_101.PrimaryPart.CFrame = CFrame.new(p_u_101.Torso.Position + Vector3.new(0, 2, 0)) * CFrame.Angles(0, 0, 0)
						v102.RootJoint.Enabled = true
						task.defer(function()
							-- upvalues: (copy) p_u_101
							p_u_101.PrimaryPart.Anchored = false
							p_u_101.Torso.Anchored = false
							p_u_101.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							p_u_101.Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						end)
					end
				end
			else
				return
			end
		else
			return
		end
	end
end
function v_u_16.Start(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_16, (copy) v_u_14, (copy) v_u_13, (copy) v_u_9, (copy) v_u_8, (copy) v_u_31, (copy) v_u_15
	if v_u_6:IsServer() then
		local v110 = Instance.new("Folder")
		v110.Name = "Ragdolls"
		v110.Parent = workspace
		local function v117(p_u_111)
			-- upvalues: (ref) v_u_16, (ref) v_u_14
			if not v_u_16.Ragdolls[p_u_111] then
				local v112 = p_u_111:WaitForChild("Humanoid", 0.5)
				if v112 then
					local v_u_113 = v_u_16.new(p_u_111)
					if not v_u_113 then
						return
					end
					v112.Died:Once(function()
						-- upvalues: (copy) v_u_113, (copy) p_u_111, (ref) v_u_16, (ref) v_u_14
						task.defer(function()
							-- upvalues: (ref) v_u_113, (ref) p_u_111, (ref) v_u_16, (ref) v_u_14
							if v_u_113 then
								while p_u_111.Parent and (p_u_111.PrimaryPart and (p_u_111.PrimaryPart.Anchored and (v_u_113 and (v_u_113.Profile and (v_u_113.Profile.AnchorDelay and os.clock() - v_u_113.Profile.Applied < 1))))) do
									task.wait()
								end
								if p_u_111 and (p_u_111.Parent and v_u_113) then
									v_u_113.Dead = true
									v_u_16.EnableRagdoll(p_u_111)
									v_u_14:FireAllClientConnection("CreateRagdoll", "REMOTE_EVENT", p_u_111, v_u_113.Profile)
									for _, v114 in ipairs(p_u_111:GetDescendants()) do
										if v114:IsA("BasePart") then
											v114.CollisionGroup = "DeadPlayers"
											v114.CanCollide = false
											v114.Anchored = true
											v114.CanQuery = false
											v114.CanTouch = false
										end
									end
								end
							end
						end)
					end)
					p_u_111.Destroying:Connect(function()
						-- upvalues: (copy) v_u_113
						if v_u_113 then
							for _, v115 in pairs(v_u_113.Containers) do
								v115:Destroy()
							end
							for _, v116 in pairs(v_u_113.Connections) do
								v116:Disconnect()
							end
							table.clear(v_u_113)
						end
					end)
				end
			end
		end
		v_u_13.OnCharacterAdded(function(p118, _)
			-- upvalues: (ref) v_u_16
			p118:AddTag(v_u_16.RagdollTag)
		end)
		v_u_9:GetInstanceAddedSignal(v_u_16.RagdollTag):Connect(v117)
		for _, v119 in ipairs(v_u_9:GetTagged(v_u_16.RagdollTag)) do
			v117(v119)
		end
	else
		local v_u_120 = v_u_8.LocalPlayer
		v_u_120.CharacterAdded:Connect(function(p121)
			local v122 = p121:WaitForChild("Humanoid", 10)
			if v122 then
				v122:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
				v122:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
				v122:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
			end
		end)
		v_u_14:SetConnection("CreateRagdoll", "REMOTE_EVENT", function(p_u_123, p_u_124)
			-- upvalues: (ref) v_u_8, (ref) v_u_13, (copy) v_u_120, (ref) v_u_31, (ref) v_u_15
			task.defer(function()
				-- upvalues: (copy) p_u_123, (ref) v_u_8, (ref) v_u_13, (ref) v_u_120, (copy) p_u_124, (ref) v_u_31, (ref) v_u_15
				p_u_123.Archivable = true
				v_u_8:GetPlayerFromCharacter(p_u_123)
				local v125 = v_u_13:GetSettingValue("RagdollSillies", v_u_120) == true
				local v126 = p_u_123 == v_u_120.Character
				local v127 = p_u_123:FindFirstChild("Humanoid")
				local v_u_128 = p_u_123:Clone()
				local v129 = v_u_128:FindFirstChild("Humanoid")
				assert(v129, "CL Ragdoll had no humanoid!")
				if p_u_124 and p_u_124.Velocity then
					local v130
					if v125 then
						local v131 = math.random(-5, 5)
						local v132 = math.random(-5, 5)
						local v133 = math.random
						v130 = vector.create(v131, v132, v133(-5, 5)) or Vector3.new(0, 0, 0)
					else
						v130 = Vector3.new(0, 0, 0)
					end
					local v134 = v125 and math.random(5, 25) or 1
					if p_u_124 then
						v130 = p_u_124.Velocity or v130
					end
					local v135 = v130 * v134
					local v136 = v_u_128:FindFirstChild("Torso")
					v_u_128.PrimaryPart.AssemblyLinearVelocity = v135
					if v136 then
						v136.AssemblyLinearVelocity = v135
						if v125 and math.random(1, 30) == 1 then
							local v137 = Instance.new("BodyVelocity", v136)
							v137.P = (1 / 0)
							v137.MaxForce = Vector3.new(1, 1, 1) * (1 / 0)
							v137.Velocity = v135 / math.random(1, 7)
						end
					end
				end
				local v138
				if v125 then
					v138 = math.random(1, 44) == 1
				else
					v138 = v125
				end
				v129.PlatformStand = not v138
				v_u_128.Parent = workspace.Ragdolls
				if workspace.CurrentCamera.CameraSubject == v127 or v126 then
					workspace.CurrentCamera.CameraSubject = v129
				end
				for _, v139 in ipairs(v_u_128:GetDescendants()) do
					if v139:IsA("BasePart") then
						local v140
						if v139.Parent.Name == "Colliders" then
							v140 = not v139.Name:lower():find("knee")
						else
							v140 = false
						end
						v139.CollisionGroup = v140 and "Ragdolls" or "None"
						v139.CanCollide = v140
						v139.Anchored = false
						v139.CanQuery = false
						v139.CanTouch = false
					end
				end
				game.Debris:AddItem(v_u_128, 30)
				v_u_31(v_u_128, v125)
				task.spawn(function()
					-- upvalues: (ref) p_u_124, (ref) v_u_15, (copy) v_u_128
					local v141 = p_u_124
					if v141 then
						v141 = p_u_124.KillEffects
					end
					local v142 = {}
					for v143, v144 in pairs(v141 or {}) do
						local v145 = v_u_15[v143]
						if v145 then
							local v146 = true
							if v145.Exclusivity then
								for _, _ in ipairs(v145.Exclusivity) do
									if table.find(v142, v145.Exclusivity) then
										v146 = false
										break
									end
								end
							end
							if v146 then
								v145.Callback(v_u_128, v144)
								table.insert(v142, v143)
							end
						else
							warn((("%*: Could not find data for kill effect %*"):format("[RagdollHandler]", v143)))
						end
					end
				end)
				p_u_123.Archivable = false
				for _, v147 in ipairs(p_u_123:GetDescendants()) do
					if v147 ~= p_u_123.PrimaryPart and not v147:IsA("Humanoid") then
						v147:Destroy()
					end
				end
			end)
		end)
	end
end
table.freeze(v_u_1)
table.freeze(v_u_2)
table.freeze(v_u_3)
table.freeze(v_u_4)
table.freeze(v_u_5)
return v_u_16
