local ItemNameToGive = script.Parent.ItemName
local debounce = false

script.Parent.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.ForceDodgeball.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceDodgeball'):FireServer(ItemNameToGive.Text)
end)

script.Parent.ForceInfection.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceInfection'):FireServer(ItemNameToGive.Text)
end)

script.Parent.ForceJuggernaut.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceJuggernaut'):FireServer(ItemNameToGive.Text)
end)

script.Parent.ForceMassacre.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceMassacre'):FireServer(ItemNameToGive.Text)
end)