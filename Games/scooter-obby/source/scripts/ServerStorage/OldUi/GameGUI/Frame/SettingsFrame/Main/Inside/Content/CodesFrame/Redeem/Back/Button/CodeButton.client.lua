script.Parent.Activated:Connect(function()
	if script.Parent.Parent.Parent.Parent.BoxBack.TextBox.Text ~= "" then
		script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.CashNotificationHandler.errorWrite:Fire("That code is invalid!")
		script.Parent.Parent.Parent.Parent.BoxBack.TextBox.Text = ""
	else
		script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.CashNotificationHandler.errorWrite:Fire("Please enter a code.")
	end
end)