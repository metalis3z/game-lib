script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Parent.MoneyFrame.Visible == true then
		script.Parent.Parent.MoneyFrame.Visible = false
		script.Parent.Text = "PayCash"
	else
		script.Parent.Parent.MoneyFrame.Visible = true
		script.Parent.Text = "Close"
	end
end)