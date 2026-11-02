repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Hold = script.parent.parent.Humanoid:LoadAnimation(script.parent.Hold)

script.Parent.Equipped:Connect(function()
	Hold:Play()
end)

script.Parent.Unequipped:Connect(function()
	Hold:Stop()
end)