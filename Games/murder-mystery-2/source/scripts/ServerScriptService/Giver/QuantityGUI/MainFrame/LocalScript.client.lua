local ItemNameToGive = script.Parent.ItemName
local PlayerNameToGive = script.Parent.PlayerName
local debounce = false

script.Parent.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.Five.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('Five'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.Ten.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('Ten'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.Twenty.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('Twenty'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.Fifity.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('Fifity'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.Hundred.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('Hundred'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.TwoHundred.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('TwoHundred'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.OneThousand.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('OneThousand'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.TenThousand.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('TenThousand'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.HundredThousand.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('OneHundredThousand'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.FiveHundredThousand.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('FiveHundredThousand'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.OneMillion.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('OneMillion'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.TenMillion.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.QuantityGUI:WaitForChild('TenMillion'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)