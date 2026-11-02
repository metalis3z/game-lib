
local webslinger = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FIRE_COOLDOWN = 12
local Net = require(ReplicatedStorage.Packages.Net)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")
local playerCooldowns = {}
local activeDrags = {}
local RunService = game:GetService("RunService")
function webslinger.CreateBeam(fromRoot, toPartOrPos, parent)

	local player = game.Players:GetPlayerFromCharacter(fromRoot.Parent)
	if player then
		local lastUse = playerCooldowns[player.UserId]
		if lastUse and (tick() - lastUse) < FIRE_COOLDOWN and not activeDrags[player] then
			return
		end
		playerCooldowns[player.UserId] = tick()

		local tool = fromRoot.Parent:FindFirstChild("Web Slinger")
		if tool then
			if lastUse and (tick() - lastUse) < FIRE_COOLDOWN and not activeDrags[player] then
				return
			end
			ToolsCooldown:FireClient(player, tool, FIRE_COOLDOWN)
		end
	end
	local root = fromRoot.Parent.PrimaryPart
	
	local fireSound = Instance.new("Sound")
	fireSound.SoundId = "rbxassetid://129425664"
	fireSound.Volume = 1
	fireSound.PlayOnRemove = true
	fireSound.Parent = root
	fireSound:Destroy()

	parent = parent or workspace

	local att0 = Instance.new("Attachment")
	att0.Name = "__ws_att0"
	att0.Parent = workspace
	att0.WorldPosition = fromRoot.Position

	local att1 = Instance.new("Attachment")
	att1.Name = "__ws_att1"
	att1.Parent = workspace
	if typeof(toPartOrPos) == "Vector3" then
		att1.WorldPosition = toPartOrPos
	else
		att1.WorldPosition = toPartOrPos.Position
	end

	local beam = Instance.new("Beam")
	beam.Name = "__ws_beam"
	beam.Attachment0 = att0
	beam.Attachment1 = att1
	beam.Color = ColorSequence.new(Color3.fromRGB(255,255,255))
	beam.Width0 = 0.15
	beam.Width1 = 0.15
	beam.Brightness = 1
	beam.TextureMode = Enum.TextureMode.Stretch
	beam.Transparency = NumberSequence.new(0)
	beam.FaceCamera = true
	beam.LightEmission = 1
	beam.Parent = parent

	local hb
	hb = RunService.Heartbeat:Connect(function()
		if not beam.Parent then
			hb:Disconnect()
			return
		end
		if fromRoot and fromRoot.Parent then
			att0.WorldPosition = fromRoot.Position
		end
		if typeof(toPartOrPos) == "Vector3" then
			att1.WorldPosition = toPartOrPos
		else
			if toPartOrPos and toPartOrPos.Parent then
				att1.WorldPosition = toPartOrPos.Position
			end
		end
	end)

	return beam, att0, att1, hb
end

local l_Ragdoll_0 = script.Ragdoll
webslinger.Ragdoll = function(v2)
	local l_Humanoid_0 = v2:WaitForChild("Humanoid")
	if l_Humanoid_0:GetState() == Enum.HumanoidStateType.Physics then
		return
	else
		l_Humanoid_0.BreakJointsOnDeath = false
		for _, v5 in pairs(v2:GetDescendants()) do
			if v5:IsA("Motor6D") then
				if not l_Ragdoll_0 then
					return
				else
					local l_BallSocketConstraint_0 = Instance.new("BallSocketConstraint")
					local l_Attachment_0 = Instance.new("Attachment")
					local l_Attachment_1 = Instance.new("Attachment")
					l_Attachment_0.Parent = v5.Part0
					l_Attachment_1.Parent = v5.Part1
					l_BallSocketConstraint_0.Parent = v5.Parent
					local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v2)
					l_Ragdoll_0:FireClient(l_PlayerFromCharacter_0, nil, "manualM")
					l_BallSocketConstraint_0.Attachment0 = l_Attachment_0
					l_BallSocketConstraint_0.Attachment1 = l_Attachment_1
					l_Attachment_0.CFrame = v5.C0
					l_Attachment_1.CFrame = v5.C1
					l_BallSocketConstraint_0.LimitsEnabled = true
					local l_NoCollisionConstraint_0 = Instance.new("NoCollisionConstraint")
					l_NoCollisionConstraint_0.Part0 = v5.Part0
					l_NoCollisionConstraint_0.Part1 = l_Humanoid_0.RootPart
					l_NoCollisionConstraint_0.Parent = v5.Parent
					if v5.Name == "Root" then
						l_BallSocketConstraint_0:Destroy()
						local l_HingeConstraint_0 = Instance.new("HingeConstraint")
						l_HingeConstraint_0.Attachment0 = l_Attachment_0
						l_HingeConstraint_0.Attachment1 = l_Attachment_1
						l_HingeConstraint_0.LimitsEnabled = true
						l_HingeConstraint_0.Parent = v5.Parent
					end
					if v5.Name == "Neck" then
						l_BallSocketConstraint_0:Destroy()
						local l_HingeConstraint_1 = Instance.new("HingeConstraint")
						l_HingeConstraint_1.Attachment0 = l_Attachment_0
						l_HingeConstraint_1.Attachment1 = l_Attachment_1
						l_HingeConstraint_1.LimitsEnabled = true
						l_HingeConstraint_1.Parent = v5.Parent
					end
					l_BallSocketConstraint_0.TwistLimitsEnabled = true
					v5.Enabled = false
				end
			end
		end
		return
	end
end

webslinger.UnRagdoll = function(v13)
	for _, v15 in pairs(v13:GetDescendants()) do
		if v15:IsA("Motor6D") then
			if not l_Ragdoll_0 then
				return
			elseif v15.Part0 and v15.Part1 then
				local _ = v13:WaitForChild("Humanoid")
				local v17 = v15.Parent:FindFirstChild("BallSocketConstraint") or v15.Parent:FindFirstChild("HingeConstraint")
				local l_NoCollisionConstraint_1 = v15.Parent:FindFirstChild("NoCollisionConstraint")
				local l_Attachment_2 = v15.Part0:FindFirstChild("Attachment")
				local l_Attachment_3 = v15.Part1:FindFirstChild("Attachment")
				if v17 then
					v17:Destroy()
				end
				if l_NoCollisionConstraint_1 then
					l_NoCollisionConstraint_1:Destroy()
				end
				if l_Attachment_2 then
					l_Attachment_2:Destroy()
				end
				if l_Attachment_3 then
					l_Attachment_3:Destroy()
				end
				local l_PlayerFromCharacter_1 = game.Players:GetPlayerFromCharacter(v13)
				l_Ragdoll_0:FireClient(l_PlayerFromCharacter_1, nil, "manualD")
				v15.Enabled = true
			end
		end
	end
end

function webslinger.AttachDrag(playerChar, targetChar)

	local playerRoot = playerChar:FindFirstChild("HumanoidRootPart")
	local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
	if not playerRoot or not targetRoot then return end

	local hitSound = Instance.new("Sound")
	hitSound.SoundId = "rbxassetid://16211030"
	hitSound.Volume = 1
	hitSound.PlayOnRemove = true
	hitSound.Parent = targetRoot
	hitSound:Destroy()

	local hum = targetChar:FindFirstChildOfClass("Humanoid")
	hum.PlatformStand = true
	hum.WalkSpeed = 0
	hum.JumpPower = 0

	local a0 = Instance.new("Attachment")
	a0.Parent = playerRoot
	local a1 = Instance.new("Attachment")
	a1.Parent = targetRoot

	local rope = Instance.new("RopeConstraint")
	rope.Attachment0 = a0
	rope.Attachment1 = a1
	rope.Length = 20
	rope.Thickness = 0.2
	rope.Visible = true
	rope.Color = BrickColor.new("Institutional white")
	rope.Parent = playerRoot

	local force = Instance.new("VectorForce")
	force.Attachment0 = a1
	force.ApplyAtCenterOfMass = true
	force.Force = Vector3.new(0,0,0)
	force.Parent = targetRoot

	local hb = RunService.Heartbeat:Connect(function()
		if not playerRoot or not targetRoot then return end
		local vec = (playerRoot.Position - targetRoot.Position)
		local dist = vec.Magnitude

		if dist > 5 then
		else
		end
	end)

	local dragData = {
		rope = rope,
		a0 = a0,
		a1 = a1,
		hb = hb,
		force = force,
		target = targetChar
	}

	local player = game.Players:GetPlayerFromCharacter(playerChar)
	if player then
		activeDrags[player] = dragData
	end

	return dragData
end

function webslinger.CleanupDragData(player, d)
	if not d then return end
	if d.hb then pcall(function() d.hb:Disconnect() end) end
	if d.rope then d.rope:Destroy() end
	if d.a0 then d.a0:Destroy() end
	if d.a1 then d.a1:Destroy() end
	if d.force then d.force:Destroy() end

	if d.target then
		local resetSound = Instance.new("Sound")
		resetSound.SoundId = "rbxassetid://153828145"
		resetSound.Volume = 1
		resetSound.PlayOnRemove = true
		resetSound.Parent = d.target.PrimaryPart or d.target
		resetSound:Destroy()
		if player then
			activeDrags[player] = nil
		end
	end
end

return webslinger