while wait() do
	if script.Parent.Value > 138 then
		script.Parent.Value = 138
	elseif script.Parent.Value < 0 then
		script.Parent.Value = 0	
	end
end