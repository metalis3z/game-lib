-- Reference copy for study. Game: steal-a-brainrot
-- Original: StarterPlayer/StarterPlayerScripts/RagdollClient.client.lua  (LocalScript, 166 lines)
-- What it does: Client half of the ragdoll: disables player controls, switches the Humanoid to Physics, moves the camera subject to the head, and restores everything (with a safety timeout) when the server un-ragdolls.

-- RagdollClient v8
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PlayerScripts = Player:WaitForChild("PlayerScripts")
local RagdollRemote = ReplicatedStorage.Packages.Ragdoll:WaitForChild("Ragdoll")

local Character, Humanoid, Head, HumanoidRootPart
local IsRagdolled = false
local unragdollTimeout = nil
local Controls = nil
local deathConnection = nil

local function GetControls()
	if not Controls then
		local ok, c = pcall(function()
			return require(PlayerScripts:WaitForChild("PlayerModule", 5)):GetControls()
		end)
		if ok and c then Controls = c end
	end
	return Controls
end

local function ForceUnlock()
	IsRagdolled = false
	if unragdollTimeout then task.cancel(unragdollTimeout) unragdollTimeout = nil end

	local ctrl = GetControls()
	if ctrl then pcall(function() ctrl:Enable() end) end

	if not Humanoid or not Humanoid.Parent then return end
	if Humanoid.Health <= 0 then return end

	Camera.CameraSubject = Humanoid

	-- Reset immédiat
	pcall(function()
		Humanoid.PlatformStand = false
		Humanoid.AutoRotate = true
		Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)

	task.spawn(function()
		-- Nettoyer les contraintes ragdoll résiduelles (BallSocket, Hinge, Attachments)
		if Character and Character.Parent then
			pcall(function()
				for _, obj in ipairs(Character:GetDescendants()) do
					if obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint")
					or obj:IsA("NoCollisionConstraint") then
						obj:Destroy()
					end
				end
				-- Réactiver tous les Motor6D
				for _, obj in ipairs(Character:GetDescendants()) do
					if obj:IsA("Motor6D") then
						obj.Enabled = true
					end
				end
			end)
		end
		-- Nettoyer les AngularVelocity résiduels
		if HumanoidRootPart and HumanoidRootPart.Parent then
			pcall(function()
				for _, obj in pairs(HumanoidRootPart:GetChildren()) do
					if obj:IsA("AngularVelocity") or obj:IsA("BodyAngularVelocity") then obj:Destroy() end
				end
				HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			end)
		end

		-- Répéter sur quelques frames pour forcer la sortie du ragdoll
		for i = 1, 8 do
			task.wait(0.08)
			if not Humanoid or not Humanoid.Parent or IsRagdolled then break end
			pcall(function()
				Humanoid.PlatformStand = false
				Humanoid.AutoRotate = true
				Humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end)
			-- Réactiver les contrôles à chaque frame aussi
			local c = GetControls()
			if c then pcall(function() c:Enable() end) end
		end
	end)
end

local function SetRagdoll(state)
	if not Character or not Character.Parent then return end
	if not Humanoid or not Humanoid.Parent then return end
	if state == IsRagdolled then return end

	IsRagdolled = state
	if unragdollTimeout then task.cancel(unragdollTimeout) unragdollTimeout = nil end

	if state then
		pcall(function()
			Humanoid.PlatformStand = true
			Humanoid.AutoRotate = false
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end)
		if Head then Camera.CameraSubject = Head end
		local ctrl = GetControls()
		if ctrl then pcall(function() ctrl:Disable() end) end
		unragdollTimeout = task.delay(3, function()
			unragdollTimeout = nil
			if IsRagdolled then
				warn("[RagdollClient] Timeout 3s - ForceUnlock")
				ForceUnlock()
			end
		end)
	else
		task.delay(0.1, ForceUnlock)
	end
end

RagdollRemote.OnClientEvent:Connect(function(ActionType, ManualType)
	local Action = ManualType or ActionType
	if Action == "Make" or Action == "manualM" then SetRagdoll(true)
	elseif Action == "Destroy" or Action == "manualD" then SetRagdoll(false)
	end
end)

local function initCharacter(char)
	IsRagdolled = false
	if unragdollTimeout then task.cancel(unragdollTimeout) unragdollTimeout = nil end
	if deathConnection then deathConnection:Disconnect() deathConnection = nil end

	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	Head = char:WaitForChild("Head")
	HumanoidRootPart = char:WaitForChild("HumanoidRootPart")

	pcall(function()
		Humanoid.PlatformStand = false
		Humanoid.AutoRotate = true
	end)

	Controls = nil
	task.wait(0.1)
	local ctrl = GetControls()
	if ctrl then pcall(function() ctrl:Enable() end) end
	Camera.CameraSubject = Humanoid

	deathConnection = Humanoid.Died:Connect(function()
		IsRagdolled = false
		if unragdollTimeout then task.cancel(unragdollTimeout) unragdollTimeout = nil end
		local c = GetControls()
		if c then pcall(function() c:Enable() end) end
	end)
end

Player.CharacterAdded:Connect(initCharacter)
if Player.Character then initCharacter(Player.Character) end

-- Watchdog : détecte et corrige le blocage ragdoll résiduel
game:GetService("RunService").Heartbeat:Connect(function()
    if not Humanoid or not Humanoid.Parent then return end
    if Humanoid.Health <= 0 then return end
    -- Si PlatformStand=true mais on pense ne pas être en ragdoll → bloqué
    if not IsRagdolled and Humanoid.PlatformStand then
        warn("[RagdollClient] Watchdog: PlatformStand bloqué → ForceUnlock")
        ForceUnlock()
    end
end)
