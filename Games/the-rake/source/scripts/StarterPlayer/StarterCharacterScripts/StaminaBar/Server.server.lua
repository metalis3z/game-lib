script.Parent.Running.OnServerEvent:Connect(function(plr, location)
	script.Parent.UseStamina.Value = true
end)

script.Parent.Walking.OnServerEvent:Connect(function(plr)
	script.Parent.UseStamina.Value = false
	script.Parent.StaminaRefill.Disabled = false
end)