script.Parent.Equipped:Connect(function()
	script.Parent.Available.Value = true
end)
script.Parent.Unequipped:Connect(function()
	script.Parent.Available.Value = true
end)