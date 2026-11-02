repeat wait() until script.parent.parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Equip = script.parent.parent.Humanoid:LoadAnimation(script.parent.EquipAnim)
local Idle = script.parent.parent.Humanoid:LoadAnimation(script.parent.IdleAnim)
local Clicked = false

script.Parent.Equipped:Connect(function()
	script.Parent.MainDisabler.Disabled = false
Equip:Play()
Idle:Play()
end)

script.Parent.Unequipped:Connect(function()
	script.Parent.MainDisabler.Disabled = true
Idle:Stop()
end)