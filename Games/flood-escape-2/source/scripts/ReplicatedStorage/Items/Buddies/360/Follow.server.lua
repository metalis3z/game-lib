-- Written by edwured idek!!!

local Owner = script.Pointer.Value
local Players = game:GetService("Players")
local Player = Players:GetPlayerFromCharacter(Owner)
local RunService = game:GetService("RunService")
local FloatingBuddy = script.Parent
local Logo = FloatingBuddy.Logo
local Handle = Logo.Handle

script.Jump.OnServerEvent:Connect(function()
	return
end)

for _, Part in pairs(Logo:GetChildren()) do
	local WeldConstraint = Instance.new("WeldConstraint")
	WeldConstraint.Part0 = Part
	WeldConstraint.Part1 = Handle
	WeldConstraint.Parent = Handle
end

local HumanoidRootPart = Owner.HumanoidRootPart
local BodyGyro = Handle:FindFirstChild("BodyGyro")
local BodyPosition = Instance.new("BodyPosition", Handle)
BodyPosition.MaxForce = Vector3.new(10000, 10000, 10000)
BodyPosition.P = 10000
BodyPosition.D = 1000

RunService.PreSimulation:Connect(function()
	local RotatedOffset = HumanoidRootPart.CFrame:VectorToWorldSpace(Vector3.new(-3, 2, 1))
	BodyPosition.Position = HumanoidRootPart.Position + RotatedOffset
end)