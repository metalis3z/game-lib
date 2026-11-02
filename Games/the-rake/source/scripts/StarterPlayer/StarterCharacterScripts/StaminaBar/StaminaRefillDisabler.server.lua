while wait() do
	if script.Parent.UseStamina.Value == false then
		--script.Parent.StaminaRefill.Disabled = false
	elseif script.Parent.UseStamina.Value == true then
		script.Parent.StaminaRefill.Disabled = true
	elseif  script.Parent.Stamina.Value > 199 then
		script.Parent.StaminaRefill.Disabled = true
	end
end