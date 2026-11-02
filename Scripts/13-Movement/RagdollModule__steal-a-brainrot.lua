-- Reference copy for study. Game: steal-a-brainrot
-- Original: ReplicatedStorage/Packages/Ragdoll.lua  (ModuleScript, 165 lines)
-- What it does: Ragdoll(character): every Motor6D becomes a BallSocket (Hinge for root/neck) with limits and NoCollision constraints; Unragdoll restores motors and stands the character up; TimedRagdoll for knockdowns.

local RagdollModule = {}
local Players = game:GetService("Players")
local RagdollRemote = script:WaitForChild("Ragdoll")

local activeRagdolls = {}

local function cleanupCharacter(character)
	if activeRagdolls[character] then
		if activeRagdolls[character].diedConn then
			activeRagdolls[character].diedConn:Disconnect()
		end
		activeRagdolls[character] = nil
	end
end

local function reactivateMotors(character)
	for _, obj in pairs(character:GetDescendants()) do
		if obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") or obj:IsA("NoCollisionConstraint") then
			obj:Destroy()
		end
		if obj:IsA("Attachment") and obj.Name == "Attachment" then
			obj:Destroy()
		end
	end
	for _, motor in pairs(character:GetDescendants()) do
		if motor:IsA("Motor6D") then
			motor.Enabled = true
		end
	end
end

local function standUp(character)
	local root = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid then return end

	-- Stopper uniquement la rotation résiduelle
	pcall(function()
		for _, obj in pairs(root:GetChildren()) do
			if obj:IsA("AngularVelocity") or obj:IsA("BodyAngularVelocity") then
				obj:Destroy()
			end
		end
		root.AssemblyAngularVelocity = Vector3.zero
	end)

	-- Remettre le RootPart droit (rotation seulement, pas position)
	pcall(function()
		local pos = root.Position
		local upright = CFrame.new(pos)
		-- Interpoler doucement vers l'upright pour éviter le saut brusque
		root.CFrame = upright
	end)

	-- Utiliser Running au lieu de GettingUp pour éviter le conflit avec HealthChanged
	pcall(function()
		humanoid.PlatformStand = false
		humanoid.AutoRotate = true
		humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
		humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)
end

-- ===== RAGDOLL =====
RagdollModule.Ragdoll = function(character)
	if not character or not character.Parent then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if activeRagdolls[character] then
		RagdollModule.Unragdoll(character)
	end

	humanoid.BreakJointsOnDeath = false
	humanoid.PlatformStand = true

	for _, motor in pairs(character:GetDescendants()) do
		if motor:IsA("Motor6D") then
			local att0 = Instance.new("Attachment")
			local att1 = Instance.new("Attachment")
			att0.CFrame = motor.C0
			att1.CFrame = motor.C1
			att0.Parent = motor.Part0
			att1.Parent = motor.Part1

			local noCollide = Instance.new("NoCollisionConstraint")
			noCollide.Part0 = motor.Part0
			noCollide.Part1 = humanoid.RootPart
			noCollide.Parent = motor.Parent

			if motor.Name == "Root" or motor.Name == "Neck" then
				local hinge = Instance.new("HingeConstraint")
				hinge.Attachment0 = att0
				hinge.Attachment1 = att1
				hinge.LimitsEnabled = true
				hinge.Parent = motor.Parent
			else
				local ball = Instance.new("BallSocketConstraint")
				ball.Attachment0 = att0
				ball.Attachment1 = att1
				ball.LimitsEnabled = true
				ball.TwistLimitsEnabled = true
				ball.Parent = motor.Parent
			end

			motor.Enabled = false
		end
	end

	local diedConn
	diedConn = humanoid.Died:Connect(function()
		diedConn:Disconnect()
		activeRagdolls[character] = nil
		pcall(function() reactivateMotors(character) end)
		humanoid.BreakJointsOnDeath = true
		humanoid.PlatformStand = false
	end)

	activeRagdolls[character] = { diedConn = diedConn }

	local player = Players:GetPlayerFromCharacter(character)
	if player then
		RagdollRemote:FireClient(player, nil, "manualM")
	end
end

-- ===== UNRAGDOLL =====
RagdollModule.Unragdoll = function(character)
	if not character or not character.Parent then return end

	cleanupCharacter(character)
	reactivateMotors(character)

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.BreakJointsOnDeath = true
		if humanoid.Health > 0 then
			standUp(character)
		end
	end

	local player = Players:GetPlayerFromCharacter(character)
	if player then
		RagdollRemote:FireClient(player, nil, "manualD")
	end
end

-- ===== TIMED RAGDOLL =====
RagdollModule.TimedRagdoll = function(character, duration)
	if not character or not character.Parent then return end
	duration = duration or 3
	RagdollModule.Ragdoll(character)
	task.delay(duration, function()
		if character and character.Parent and activeRagdolls[character] then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				RagdollModule.Unragdoll(character)
			else
				cleanupCharacter(character)
			end
		end
	end)
end

return RagdollModule
