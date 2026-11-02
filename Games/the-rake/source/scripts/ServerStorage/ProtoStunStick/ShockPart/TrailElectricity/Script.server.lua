local Debounce = false

	wait()
	if script.Parent.Enabled == true and Debounce == false then
		Debounce = true
		wait(0.3)
		script.Parent.Enabled = false
		wait(0.1)
		script.Parent:Destroy()
		script.Disabled = true
		wait(1)
		Debounce = false
	end