while true do
	wait()
	if script.Parent.Value == true then
		wait(0.1)
		script.Parent.Value = false
	end
end