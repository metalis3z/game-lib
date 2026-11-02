repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")

local Tool = script.Parent
local Idle = script.parent.parent.Humanoid:LoadAnimation(script.parent.IdleAnim)
local Clicked = false

script.Parent.Equipped:Connect(function()
	Idle:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)