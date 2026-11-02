workspace.Values.DuringMode.Changed:Connect(function()
	if workspace.Values.DuringMode.Value == false then
		script.Parent.MaxActivationDistance = 5
	end
end)