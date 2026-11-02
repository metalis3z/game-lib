local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local EquippedSound = Handle:WaitForChild("Equipped")
local SlashSound = Handle:WaitForChild("Slash")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local character
local humanoid
local root
local Remote = Tool:WaitForChild("RemoteEvent")

local SlashAnimations = {
	"rbxassetid://93269283552133",
	"rbxassetid://93269283552133"
}
local currentSlashIndex = 1
local isCoolingDown = false

Tool.Equipped:Connect(function()
	character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")
	root = character:WaitForChild("HumanoidRootPart")
	EquippedSound:Play()
	Remote:FireServer("Equipped", root.CFrame)
end)

local function Dash()
	if not root then return end
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5, 0, 1e5)
	bv.Velocity = root.CFrame.LookVector * 60
	bv.P = 10000
	bv.Parent = root
	task.delay(0.3, function() bv:Destroy() end)
end

local function Slash()
	if not humanoid or not root or isCoolingDown then return end
	isCoolingDown = true

	local anim = Instance.new("Animation")
	anim.AnimationId = SlashAnimations[currentSlashIndex]
	currentSlashIndex = (currentSlashIndex % #SlashAnimations) + 1
	local track = humanoid:LoadAnimation(anim)
	track:Play()
	humanoid.WalkSpeed = 50
	Dash()

	Remote:FireServer("Slash", root.CFrame)

	task.delay(0.3, function() humanoid.WalkSpeed = 34 end)
	task.wait(2.5)
	isCoolingDown = false
end

Tool.Activated:Connect(Slash)
