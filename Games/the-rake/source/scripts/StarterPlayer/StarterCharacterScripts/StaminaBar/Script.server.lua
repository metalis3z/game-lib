while wait() do
	if script.Parent.UseStamina.Value == true then
		repeat
			wait()
			script.Parent.Stamina.Value = script.Parent.Stamina.Value - 1.5
		until script.Parent.Stamina.Value < 1 or script.Parent.UseStamina.Value == false
	end
end