while true do
	wait()
	if script.Drinked.Value == true then
		script.Parent.StaminaBar.Stamina.Value = script.Parent.StaminaBar.MaxStamina.Value
		script.Drinked.Value = false
		
	end
end