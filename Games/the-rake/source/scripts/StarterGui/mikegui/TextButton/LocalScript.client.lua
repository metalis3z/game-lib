script.Parent.MouseButton1Down:Connect(function()
	if script.Parent.Parent.Frame.Visible == false then
		script.Parent.Parent.Frame.Visible = true
		script.Parent.Parent.TextLabel.Visible = true
	elseif script.Parent.Parent.Frame.Visible == true then
		script.Parent.Parent.Frame.Visible = false
		script.Parent.Parent.TextLabel.Visible = false
	end
end)