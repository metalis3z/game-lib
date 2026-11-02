repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Idle = char:WaitForChild("Humanoid"):LoadAnimation(script.Idle)

script.Parent.Equipped:Connect(function()
	Idle:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)