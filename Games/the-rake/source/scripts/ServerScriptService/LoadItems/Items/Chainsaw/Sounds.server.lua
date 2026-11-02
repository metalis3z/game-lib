
script.Parent.Equipped:Connect(function()
	script.Parent.Can.Value = false
	wait(0.4)
	script.Parent.Base.Equip1:Play()
	wait(0.4)
	script.Parent.Base.Equip2:Play()
	wait(1)
	script.Parent.Base.Idle:Play()
	script.Parent.Can.Value = true

end)