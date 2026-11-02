repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local RootPart = script.Parent.Parent:FindFirstChild("HumanoidRootPart")
local hum = script.Parent.Parent:FindFirstChild("Humanoid")

script.Parent.Equipped:Connect(function()
	RootPart.Anchored = true
	hum.AutoRotate = false
end)

script.Parent.Unequipped:Connect(function()
	RootPart.Anchored = false
	hum.AutoRotate = true
end)
