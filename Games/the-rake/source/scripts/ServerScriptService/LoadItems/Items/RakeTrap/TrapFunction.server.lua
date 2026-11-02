while wait() do
	if script.Parent.Bar.Value > 138 then
		script.Parent.Placed.Value = true
		wait()
		script.Parent.Placed.Value = false
	end
end