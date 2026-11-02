script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Parent.Parent.BuyCashFrame.Visible == false then
		script.Parent.Parent.Parent.BuyCashFrame.Visible = true
	else
		script.Parent.Parent.Parent.BuyCashFrame.Visible = false
	end
end)