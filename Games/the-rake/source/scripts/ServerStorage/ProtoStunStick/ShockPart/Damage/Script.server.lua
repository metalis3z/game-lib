while wait() do
	if script.Parent.Disabled == false then
		wait(0.4)
		script.Parent.Disabled = true
	end
end