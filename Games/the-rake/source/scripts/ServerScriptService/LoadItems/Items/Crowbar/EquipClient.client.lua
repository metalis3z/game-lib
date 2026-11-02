repeat wait() until script.parent.parent:FindFirstChild("Humanoid")

local char = script.Parent.Parent
local animations = script.Parent.Animations
local Equip = char:WaitForChild("Humanoid"):LoadAnimation(animations.Equip)
local Idle = char:WaitForChild("Humanoid"):LoadAnimation(animations.Idle)

script.Parent.Equipped:Connect(function()
	Idle:Play()
	Equip:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)