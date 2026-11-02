local Tool = script.Parent
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local Cooldown = 6
local CanThrow = true
local ThrownBall = nil

local BallTemplate = Tool:WaitForChild("Ball")
local Handle = Tool:WaitForChild("Handle")
local ThrowSound = Handle:WaitForChild("BeachBallHit")

local function cleanupBall()
	if ThrownBall and ThrownBall.Parent then
		ThrownBall:Destroy()
		ThrownBall = nil
	end
end

Tool.Activated:Connect(function()
	if not CanThrow then return end
	CanThrow = false

	Handle.Transparency = 1

	local Character = Tool.Parent
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then 
		Handle.Transparency = 0
		CanThrow = true
		return 
	end

	if ThrowSound then
		ThrowSound:Play()
	end

	cleanupBall()

	local Ball = BallTemplate:Clone()
	Ball.Parent = workspace
	Ball.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, -2)

	local ForwardVelocity = HumanoidRootPart.CFrame.LookVector * 60 + Vector3.new(0, 15, 0)
	Ball.AssemblyLinearVelocity = ForwardVelocity

	ThrownBall = Ball

	Debris:AddItem(Ball, 6)

	task.delay(Cooldown, function()
		Handle.Transparency = 0
		CanThrow = true
	end)
end)