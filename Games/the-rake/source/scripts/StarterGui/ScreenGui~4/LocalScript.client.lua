workspace.ShadowHourFunction.Changed:Connect(function()
	if workspace.ShadowHourFunction.Value==true then
		script.Parent.Darker.Visible = true
		script.Parent.Overlay.Visible = false
	else
		script.Parent.Darker.Visible = false
		script.Parent.Overlay.Visible = true
	end
end)

workspace.NightmareHourFunction.Changed:Connect(function()
	if workspace.NightmareHourFunction.Value==true then
		script.Parent.Darker.Visible = true
		script.Parent.Overlay.Visible = false
	else
		script.Parent.Darker.Visible = false
		script.Parent.Overlay.Visible = true
	end
end)