while true do
	wait()
	if script.Parent.Power.Value == 0 then
		repeat
			wait()
			script.Parent.PowerRecharge2.Disabled = true
		until script.Parent.Power.Value == 200
		script.Disabled = true
	end
end