script.Parent.Equipped:Connect(function()
	script.Parent.Sounds.Disabled = false
	script.Parent.Base.Idle:Stop()
	script.Parent.Base.Equip1:Stop()
	script.Parent.Base.Equip2:Stop()
end)
script.Parent.Unequipped:Connect(function()
	script.Parent.Sounds.Disabled = true
	script.Parent.Can.Value = false
	script.Parent.Base.Idle:Stop()
	script.Parent.Base.Equip1:Stop()
	script.Parent.Base.Equip2:Stop()
end)