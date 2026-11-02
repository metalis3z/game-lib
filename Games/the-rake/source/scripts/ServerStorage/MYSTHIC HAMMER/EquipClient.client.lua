repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local Equip = char:WaitForChild("Humanoid"):LoadAnimation(script.Equip)
local Idle = char:WaitForChild("Humanoid"):LoadAnimation(script.Idle)

script.Parent.Equipped:Connect(function()
	Idle:Play()
	Equip:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)