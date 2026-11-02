script.Parent.Parent.Parent.Parent.ContentAmount.Changed:Connect(function()
	script.Parent.Text = script.Parent.Parent.Parent.Parent.ContentAmount.Value
end)