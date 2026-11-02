local Debounce = false
while true do
	wait()
	if script.Parent.Enabled == true and Debounce == false then
		Debounce = true
		wait(0.2)
		script.Parent.Enabled = false
		Debounce = false
	end
end	