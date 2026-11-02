local PowerOutValue = workspace.PowerOutValue

PowerOutValue.Changed:Connect(function()
	if PowerOutValue.Value == 1 then
		workspace.PowerOut:Play()
		workspace.NearMode.ModeStarted.Value = false
	elseif PowerOutValue.Value == 0 then
		workspace.Charged:Play()
	end
end)