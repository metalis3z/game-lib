script.Parent.Equipped:Connect(function()
	script.Parent.animfix.Disabled = false
end)

script.Parent.Unequipped:Connect(function()
	script.Parent.animfix.Disabled = true
end)