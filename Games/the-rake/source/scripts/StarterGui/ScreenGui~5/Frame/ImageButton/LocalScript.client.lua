local Opened = false

script.Parent.MouseButton1Down:Connect(function()
	if Opened == false then
		script.Parent.Parent.ScrollingFrame.Visible = true
		Opened = true
	else
		script.Parent.Parent.ScrollingFrame.Visible = false
		Opened = false
	end
end)