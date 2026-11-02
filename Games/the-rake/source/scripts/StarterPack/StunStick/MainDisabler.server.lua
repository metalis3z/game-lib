while true do
	wait()
	if script.Parent.Parent.Stamina.Value == 10 then
		script.Parent.Main.Disabled = false
		script.Parent.Parent.StaminaRefill.Disabled = true
	elseif script.Parent.Parent.Stamina.Value == 0 then
		script.Parent.Main.Disabled = true
		script.Parent.ShockPart.Damage.Disabled = true
		script.Parent.Parent.StaminaRefill.Disabled = false
	--elseif script.Parent.Stamina.Value == -1 or -2 or -3 or -4 or -5 or -6 or -7 or -8 or -9 or -10 then
		--script.Parent.Stamina.Value = 0
	end
end