while wait() do
	if script.Parent.Value < 0 then
		script.Parent.Value = 0
	elseif script.Parent.Value > script.Parent.Parent.MaxStamina.Value then
		script.Parent.Value = script.Parent.Parent.MaxStamina.Value	
		script.Parent.Parent.StaminaRefill.Disabled = true
	end
end