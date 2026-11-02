while true do
	wait()
	if script.Parent.Stamina.Value < 10 then
		script.Parent.Main.Disabled = true
	elseif script.Parent.Stamina.Value == 10 then
		script.Parent.Main.Disabled = false
	end
end