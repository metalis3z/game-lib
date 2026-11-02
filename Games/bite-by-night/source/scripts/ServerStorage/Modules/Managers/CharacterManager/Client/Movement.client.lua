
--// services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Requests = ReplicatedStorage:WaitForChild("Requests")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
for _, instance in Character:GetDescendants() do
	if instance:IsA("BasePart") then
		instance.Massless = HumanoidRootPart ~= instance
	end
end

--// set enabled states
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)

--// create velocity for movement
local MovementVelocity = Instance.new("BodyVelocity")
MovementVelocity.Name = "MovementBodyVelocity"
MovementVelocity.MaxForce = Vector3.new(2000, -5, 2000)
MovementVelocity.P = (1 / 0)
MovementVelocity.Velocity = Vector3.new(0, 0, 0)
MovementVelocity.Parent = HumanoidRootPart

Humanoid.WalkSpeed = 0.01
Humanoid.JumpPower = 0

local speed = 16
local v_u_13 = Vector3.new(0, 0, 0)
local v_u_14 = Vector3.new(0, 0, 0)
local v_u_15 = false
local v_u_16 = false
local rootPos = {}
RunService.Heartbeat:Connect(function()
	local currentTime = workspace:GetServerTimeNow()
	rootPos[currentTime] = HumanoidRootPart.Position
	for num in next, rootPos do
		if num < currentTime - 1 then
			rootPos[num] = nil
		end
	end
end)

local function MovementHandler()
	local WalkSpeed = Character:GetAttribute("WalkSpeed") or 16
	local RunSpeed = Character:GetAttribute("RunSpeed") or 0
	local Direction = Humanoid.MoveDirection
	if Character:HasTag("Confusion") then
		Direction = Direction * -1
	end
	local Crouching = Character:GetAttribute("Crouching")
	local Running = Character:GetAttribute("Running")
	local SlowStop = Character:HasTag("SlowStop")
	local Stamina = Character:GetAttribute("Stamina") or 0
	local notRunning = Character:HasTag("CantMove") or (Character:HasTag("CustomSpeed") and Character:GetAttribute("CustomSpeed") or Crouching and WalkSpeed / 2)
	if notRunning then
		WalkSpeed = notRunning
	elseif Running and Stamina > 0 then
		WalkSpeed = HumanoidRootPart.CFrame.LookVector:Dot(v_u_13.Magnitude > 0 and v_u_13.Unit or Vector3.new(0, 0, 0)) > 0.45 and RunSpeed and RunSpeed or WalkSpeed
	end
	
	speed = WalkSpeed
	
	local v28 = v_u_15
	if v28 then
		if Direction.Magnitude > 0 and (v_u_16 and HumanoidRootPart.CFrame.LookVector:Dot(Direction) < 0.45) or Direction.Magnitude == 0 then
			if HumanoidRootPart.CFrame.LookVector:Dot(v_u_13.Magnitude > 0 and v_u_13.Unit or Vector3.new(0, 0, 0)) > 0.45 then
				v28 = not Crouching
			else
				v28 = false
			end
		else
			v28 = false
		end
	end
	
	v_u_16 = v28
	
	if v_u_16 then
		Direction = HumanoidRootPart.CFrame.LookVector
	end
	
	if Direction.Magnitude > 0 then			
		if typeof(speed) == 'boolean' then
			return
		end
		
		v_u_13 = Direction * speed
		
		if not v_u_16 then
			v_u_14 = v_u_13
		end
		
		if not Running or (RunSpeed > speed or not SlowStop) then
			SlowStop = v_u_16
		end
		
		v_u_15 = SlowStop
	else
		v_u_13 = Vector3.new(0, 0, 0)
	end
	
	Requests.Movement:FireServer(HumanoidRootPart.CFrame, workspace:GetServerTimeNow(), Character)
end
RunService.Heartbeat:Connect(function(deltaTime)
	MovementHandler()
	if v_u_16 then
		v_u_14 = ((v_u_13.Magnitude > 0 and v_u_13.Unit or Vector3.new(0, 0, 0)) * v_u_14.Magnitude):Lerp(Vector3.new(0, 0, 0), 1.8 * deltaTime)
		if v_u_14.Magnitude <= 1 then
			v_u_16 = false
			v_u_15 = false
		end
	else
		v_u_14 = v_u_13
	end
	
	local velocity = HumanoidRootPart:FindFirstChild("Velocity") or HumanoidRootPart:FindFirstChild("BodyVelocity")
	if velocity and MovementVelocity.Parent ~= nil then
		velocity.Parent = nil
		task.delay(0.05, function()
			velocity.Parent = HumanoidRootPart
		end)
	end
	
	if Character:GetAttribute("Ragdoll") or (Character:HasTag("CantMove") or (Character:HasTag("Ragdoll") or velocity)) then
		MovementVelocity.MaxForce = Vector3.new(0, 0, 0)
		MovementVelocity.Parent = nil
	elseif MovementVelocity.MaxForce == Vector3.new(0, 0, 0) then
		MovementVelocity.MaxForce = Vector3.new(2000, -5, 2000)
		MovementVelocity.Parent = HumanoidRootPart
	end
	
	MovementVelocity.Velocity = v_u_14
	
	local bodyVelocity = HumanoidRootPart:FindFirstChildOfClass("BodyVelocity")
	if bodyVelocity and (bodyVelocity:GetAttribute("Update") and bodyVelocity:GetAttribute("Update") == "Root") then
		TweenService:Create(bodyVelocity, TweenInfo.new(bodyVelocity:GetAttribute("Tween") or 0), {Velocity = HumanoidRootPart.CFrame.LookVector * bodyVelocity:GetAttribute("Speed") or 0}):Play()
	end
	local bodyGyro = HumanoidRootPart:FindFirstChildOfClass("BodyGyro")
	if bodyGyro and (bodyGyro:GetAttribute("Update") and bodyGyro:GetAttribute("Update") == "Cam") then
		bodyGyro.CFrame = workspace.CurrentCamera.CFrame
	end
end)

Character:GetAttributeChangedSignal("Running"):Connect(MovementHandler)
Character:GetAttributeChangedSignal("Crouching"):Connect(MovementHandler)
Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(MovementHandler)