local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local Net = require(ReplicatedStorage.Packages.Net)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")
local QuantumTeleport = Net:RemoteEvent("QuantumCloner/OnTeleport")

local QuantumCloner = {}

local COOLDOWN = 10
local WANDER_RADIUS = 25
local IDLE_TIME_MIN = 5 
local IDLE_TIME_MAX = 8
local WALK_SPEED = 30

local PlayerCooldowns = {}

local AnimateTemplate = script:WaitForChild("Animate")

local function ActivateCloneAI(cloneModel)
	local humanoid = cloneModel:FindFirstChild("Humanoid")
	local root = cloneModel:FindFirstChild("HumanoidRootPart")

	if not humanoid or not root then return end

	humanoid.WalkSpeed = WALK_SPEED

	task.spawn(function()

		task.wait(math.random(IDLE_TIME_MIN, IDLE_TIME_MAX))

		while cloneModel and cloneModel.Parent do
			local randomX = math.random(-WANDER_RADIUS, WANDER_RADIUS)
			local randomZ = math.random(-WANDER_RADIUS, WANDER_RADIUS)
			local targetPosition = root.Position + Vector3.new(randomX, 0, randomZ)

			humanoid:MoveTo(targetPosition)

			local reached = humanoid.MoveToFinished:Wait()

			task.wait(math.random(IDLE_TIME_MIN, IDLE_TIME_MAX))
		end
	end)
end

local function RemoveTool(clone, toolName)
	local tool = clone:FindFirstChild(toolName)
	if tool and tool:IsA("Tool") then
		tool:Destroy()
	end
end

local function SetupClone(player, originalChar, clone)
	clone.Name = player.Name
	clone.Parent = workspace

	local hum = clone:FindFirstChild("Humanoid")
	if hum then
		hum.DisplayName = "" 
		hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff

		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

		hum.WalkSpeed = WALK_SPEED
		hum.JumpPower = 0
	end

	RemoveTool(clone, "QuantumCloner")
	for _, child in pairs(clone:GetChildren()) do
		if child:IsA("Tool") then
			child:Destroy()
		end
		if child.Name == "Animate" then
			child:Destroy()
		end
	end

	local animScriptClone = AnimateTemplate:Clone()
	animScriptClone.Name = "Animate"
	animScriptClone.Parent = clone
	animScriptClone.Disabled = true

	clone.Parent = workspace

	task.wait()

	animScriptClone.Disabled = false

	for _, child in pairs(clone:GetDescendants()) do
		if child:IsA("LocalScript") then
			child:Destroy()
		end
	end
end

function QuantumCloner.OnExecution(Player: Player, Character: Model, Tool: Tool)
	local UserId = Player.UserId

	local lastUse = PlayerCooldowns[UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return
	end

	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Root then return end

	local cloneName = ("%s_Clone"):format(UserId)
	local ExistingClone = workspace:FindFirstChild(cloneName)
	if ExistingClone then
		ExistingClone:Destroy()
	end

	PlayerCooldowns[UserId] = tick()
	ToolsCooldown:FireClient(Player, Tool, COOLDOWN)

	Character.Archivable = true
	local Clone = Character:Clone()
	Character.Archivable = false

	Clone:SetPrimaryPartCFrame(Root.CFrame * CFrame.new(0, 0, -2))

	SetupClone(Player, Character, Clone)
	Clone.Name = cloneName

	ActivateCloneAI(Clone)
	
	local toolSound = Tool:FindFirstChild("Sound")
	if toolSound then
		local sound = toolSound:Clone()
		sound.Parent = Clone:FindFirstChild("HumanoidRootPart")
		sound:Play()
		Debris:AddItem(sound, sound.TimeLength + 0.1)
	end
end

function QuantumCloner.OnTeleport(Player: Player)
	local cloneName = ("%s_Clone"):format(Player.UserId)
	local Clone = workspace:FindFirstChild(cloneName)
	local Character = Player.Character

	if not Clone or not Character then return end

	local CloneRoot = Clone:FindFirstChild("HumanoidRootPart")
	local PlayerRoot = Character:FindFirstChild("HumanoidRootPart")
	local CloneHumanoid = Clone:FindFirstChild("Humanoid")

	if CloneRoot and PlayerRoot then
		
		local tool = Player.Character and Player.Character:FindFirstChild("Quantum Cloner")
		if tool then
			local handle = tool:FindFirstChild("Handle")
			local handleSound = handle and handle:FindFirstChild("Sound")

			if handleSound then
				local s1 = handleSound:Clone()
				s1.Parent = PlayerRoot
				s1:Play()
				Debris:AddItem(s1, s1.TimeLength + 0.1)

				local s2 = handleSound:Clone()
				s2.Parent = CloneRoot
				s2:Play()
				Debris:AddItem(s2, s2.TimeLength + 0.1)
			end
		end


		local playerPos = PlayerRoot.CFrame
		local clonePos = CloneRoot.CFrame

		PlayerRoot.CFrame = clonePos + Vector3.new(0, 5, 0)
		CloneRoot.CFrame = playerPos + Vector3.new(0, 5, 0)

		PlayerRoot.AssemblyLinearVelocity = Vector3.zero
		CloneRoot.AssemblyLinearVelocity = Vector3.zero

		if CloneHumanoid then
			CloneHumanoid:MoveTo(CloneRoot.Position)
		end
	end
end

QuantumTeleport.OnServerEvent:Connect(function(Player)
	QuantumCloner.OnTeleport(Player)
end)

Players.PlayerRemoving:Connect(function(Player)
	local cloneName = ("%s_Clone"):format(Player.UserId)
	local Clone = workspace:FindFirstChild(cloneName)
	if Clone then
		Debris:AddItem(Clone, 0)
	end
end)

return QuantumCloner