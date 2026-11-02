while true do
	wait()
	if script.Parent.Value == true then
		wait(1)
		script.Parent.Value = false
	end
end