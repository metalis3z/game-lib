while task.wait(1) do
	if script.Parent.Cooldown.Value > 0 then
		script.Parent.Cooldown.Value -= 1
	end
end