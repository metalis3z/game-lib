
script.Parent.Equipped:Connect(function()
	script.Parent.EquipClient.Disabled = true
	wait(0.03)
	script.Parent.EquipClient.Disabled = false
script.Parent.Can.Value = true
end)