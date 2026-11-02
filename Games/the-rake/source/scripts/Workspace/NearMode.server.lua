script.ModeStarted.Changed:Connect(function()
	if script.ModeStarted.Value == true then
		script.Beep:Play()
	end
end)