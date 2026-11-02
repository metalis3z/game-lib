local Demon = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
assert(RunService:IsServer(), "Demon must run on server")

function Demon.Freeze(targetCharacter: Model, duration: number)
	if not targetCharacter then return end

	local humanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	local root = targetCharacter:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	duration = duration or 4

	local oldWalkSpeed = humanoid.WalkSpeed
	local oldJumpPower = humanoid.JumpPower
	local oldAutoRotate = humanoid.AutoRotate

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true

	local highlight = Instance.new("Highlight")
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	highlight.FillColor = Color3.fromRGB(150, 0, 0)
	highlight.FillTransparency = 0.6
	highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineTransparency = 0
	highlight.Adornee = targetCharacter
	highlight.Parent = targetCharacter

	task.delay(duration, function()
		if humanoid and humanoid.Parent then
			humanoid.WalkSpeed = oldWalkSpeed or 16
			humanoid.JumpPower = oldJumpPower or 50
			humanoid.AutoRotate = oldAutoRotate
			humanoid.PlatformStand = false
		end
		if highlight then
			highlight:Destroy()
		end
	end)
end

function Demon.Launch(targetCharacter: Model, power: number)
	local root = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
	if root then
		root:ApplyImpulse(Vector3.new(0, power or 900, 0))
	end
end

return Demon