local idle = script.Parent.Animations.idle
local equip = false

script.Parent.Equipped:Connect(function()
	local Char = script.Parent.Parent
	local animworkequip = Char.Humanoid:LoadAnimation(idle)
	animworkequip:Play()
	animworkequip.Looped = true
end)

script.Parent.Equipped:Connect(function()
	local Char = script.Parent.Parent
	local animworkequip = Char.Humanoid:LoadAnimation(idle)
	animworkequip:Stop()
	animworkequip.Looped = false
end)