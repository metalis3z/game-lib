workspace.PowerOutValue.Changed:Connect(function()
	if workspace.Values.DuringMode.Value == true and workspace.PowerOutValue.Value == 0 then
		workspace.PowerOutValue.Value = 1
	end 
end)