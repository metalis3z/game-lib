while wait() do
	if script.Parent.Value > 138 then
		script.Parent.Value = 138
		script.Parent.Parent.Heal.Value = false
	elseif script.Parent.Value < 0 then
		script.Parent.Value = 0	
	end
end