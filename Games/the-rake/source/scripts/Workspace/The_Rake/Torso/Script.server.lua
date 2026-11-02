script.Parent.BloodSplat.Changed:Connect(function()
	if script.Parent.BloodSplat.Enabled == true then
		wait(0.1)
		script.Parent.BloodSplat.Enabled = false
	end
end)