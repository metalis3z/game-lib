while true do
	wait()
	if script.Parent.Parent.StunTime.Value < 1 then
		script.Parent.Parent.StunTime.Value = 0
	end
end