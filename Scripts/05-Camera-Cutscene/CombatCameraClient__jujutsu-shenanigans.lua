-- Reference copy for study. Game: jujutsu-shenanigans
-- Original: StarterPlayer/StarterCharacterScripts/Client.client.lua  (LocalScript, 206 lines)
-- What it does: Character client script: decaying random shake added through Humanoid.CameraOffset (shared.addshake), head-follow camera offset, double-tap-to-run, and keeps the offset applied after death.

--// Services \\--

local TS = game:GetService('TweenService')
local RS = game:GetService('ReplicatedStorage')
local RNS = game:GetService('RunService')
local Players = game:GetService('Players')



--// Player \\--

local Player = Players.LocalPlayer
local ConfigFolder: Configuration = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local Head: BasePart = Character:FindFirstChild('Head') or Character:WaitForChild('Head', 10)
local Torso: BasePart = Character:FindFirstChild('Torso') or Character:WaitForChild('Torso', 10)
local userGameSettings = UserSettings():GetService("UserGameSettings")



--// Remotes \\--

local Remotes = RS.Remotes


local Comunicator: RemoteEvent = Remotes.Comunicator.Set



--// Raycast Params \\--

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = { workspace.Map }
params.IgnoreWater = true



--// Variables \\--

local Camera = workspace.CurrentCamera
local DashSpeed = 85
local cameraShakeLoop = nil
local xShake, yShake, zShake = 0, 0, 0
local TN_Info = TweenInfo.new(.1)
local RunningPhase = 0
local deadCamOffset = false



--// Functions \\--

local function raycast(origin, direction)
	return workspace:Raycast(origin, direction, params)
end

shared.addshake = function(Shake)
	if ConfigFolder:FindFirstChild('Reduce Camera Shake') and ConfigFolder['Reduce Camera Shake'].Value == true then
		Shake = Shake / 2
	end
	
	if not cameraShakeLoop then
		cameraShakeLoop = shared.loop(function()
			xShake = xShake * (math.random(1, 2) == 1 and -1 or 1)
			yShake = yShake * (math.random(1, 2) == 1 and -1 or 1)
			zShake = zShake * (math.random(1, 2) == 1 and -1 or 1)
			
			shared.shakes = {
				xShake, 
				yShake, 
				zShake
			}
			
			xShake = xShake * 0.85
			yShake = yShake * 0.85
			zShake = zShake * 0.85
			
			if math.abs(xShake) <= 0.05 and math.abs(yShake) <= 0.05 and math.abs(zShake) <= 0.05 then
				cameraShakeLoop()
				cameraShakeLoop = nil
			end
		end)
	end;
	xShake = xShake + Shake * (math.random(1, 2) == 1 and -1 or 1)
	yShake = yShake + Shake * (math.random(1, 2) == 1 and -1 or 1)
	zShake = zShake + Shake * (math.random(1, 2) == 1 and -1 or 1)
end

local function isRunning()
	Humanoid.WalkSpeed = Character:GetAttribute('DefaultRunSpeed')
	if Humanoid.WalkSpeed > 0 and Character:HasTag('Awakened') then
		Humanoid.WalkSpeed += 7
	end
	
	Humanoid.JumpPower = Character:GetAttribute('DefaultJumpPower')
end

local running = false

local function CheckWalkDirection()
	local LookVector = Humanoid.MoveDirection:Dot(Camera.CFrame.LookVector)
	local RightVector = Humanoid.MoveDirection:Dot(Camera.CFrame.RightVector)



	if Humanoid.MoveDirection ~= Vector3.zero and math.abs(RightVector) < 0.85 and LookVector >= -0.1 then
		if ConfigFolder['Auto Run'].Value == false then
			RunningPhase += 1

			task.delay(.25, function()
				RunningPhase = 0
			end)

			if RunningPhase == 2 then
				isRunning()
				running = true
			end
		else
			isRunning()
			running = true
		end
	else
		Humanoid.WalkSpeed = Character:GetAttribute('DefaultWalkSpeed')
		Humanoid.JumpPower = Character:GetAttribute('DefaultJumpPower')
		running = false
	end
end

--// Params \\--

local Oparams = OverlapParams.new()
Oparams.FilterType = Enum.RaycastFilterType.Include
Oparams.FilterDescendantsInstances = { workspace.Map }



--// Connections \\--


local Heartbeat: RBXScriptConnection
Heartbeat = RNS.Heartbeat:Connect(function(deltaTime)
	if not Character or not Character.Parent then Heartbeat:Disconnect() return end
	
	if HumRP and Head and Humanoid and Torso then
		local defaultOffset = Vector3.new(0 + xShake, -1.25 + yShake, 0 + zShake)
		local camOffset = defaultOffset
		
		if not Character:HasTag('NoHeadFollow') then
			camOffset += HumRP.CFrame:ToObjectSpace(Head.CFrame).Position
		end
		
		local offsetLerp = Humanoid.CameraOffset:Lerp(camOffset, 1 - 2.5E-5 ^ deltaTime)
		local offsetMagnitude = (HumRP.Position - (HumRP.Position + offsetLerp)).Magnitude
		local offsetCFrame = HumRP.CFrame * CFrame.new(Vector3.new(0, 1.5, 0) + offsetLerp)
		if (offsetMagnitude > 1000) or (offsetCFrame.Position - HumRP.Position).Magnitude > 1000 then
			offsetLerp = defaultOffset
		end
		
		Humanoid.CameraOffset = offsetLerp
		
		if Humanoid.Health <= 0 and deadCamOffset == false then
			deadCamOffset = true
			
			RNS.RenderStepped:Connect(function()
				if Camera.CameraType ~= Enum.CameraType.Scriptable then
					Camera.CFrame = Camera.CFrame + Humanoid.CameraOffset
				end
			end)
		end
	end
end)

Character:GetAttributeChangedSignal('DefaultRunSpeed'):Connect(CheckWalkDirection)
Character:GetAttributeChangedSignal('DefaultWalkSpeed'):Connect(CheckWalkDirection)
Character:GetAttributeChangedSignal('DefaultJumpPower'):Connect(CheckWalkDirection)
Humanoid:GetPropertyChangedSignal('MoveDirection'):Connect(CheckWalkDirection)


workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)



--// Runtime \\--

Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
--Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
TS:Create(Camera, TweenInfo.new(.5), { FieldOfView = 70; }):Play()
Camera.CameraSubject = Humanoid
Camera.CameraType = Enum.CameraType.Custom
Player.PlayerGui.Hotbar.Hotbar:TweenPosition(UDim2.new(0.5, -327, 1, -70), nil, nil, .4)
Player.PlayerGui.AwakeningBar.UltimateBar:TweenPosition(UDim2.new(0.5, 0, 1, -100), nil, nil, .5, true)

require(RS.Modules.CameraTableAnims):StopAnimations()
require(RS.Modules.CameraHandler):StopAnims()

Humanoid.StateChanged:Connect(function(oldState, newState)
	if newState == Enum.HumanoidStateType.Ragdoll or newState == Enum.HumanoidStateType.FallingDown or newState == Enum.HumanoidStateType.Swimming  then --or newState == Enum.HumanoidStateType.Climbing
		Humanoid:ChangeState(oldState)
	end
end)
