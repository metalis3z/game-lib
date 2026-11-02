script.Parent.Equipped:Connect(function()
	script.Parent.AnimEnabler.Disabled = false
end)
script.Parent.Unequipped:Connect(function()
	script.Parent.AnimEnabler.Disabled = true
	script.Parent.EquipClient.Disabled = true
	script.Parent.Can.Value = false
end)