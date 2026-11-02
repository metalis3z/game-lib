while true do
	wait()
	if script.Parent.On.Value == 0 then
		wait(2)
		script.Parent.PowerRecharge2.Disabled = false
	end
end