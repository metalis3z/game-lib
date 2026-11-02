while true do
	wait()
	if script.Parent.Stamina.Value == 0 then
		repeat
			wait(0.6)
			script.Parent.Stamina.Value = script.Parent.Stamina.Value + 1
		until script.Parent.Stamina.Value == 10
	end
end