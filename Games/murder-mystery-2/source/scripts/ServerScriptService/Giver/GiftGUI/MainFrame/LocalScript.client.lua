local ItemNameToGive = script.Parent.ItemName
local PlayerNameToGive = script.Parent.PlayerName
local debounce = false

script.Parent.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.GiftWeapon.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftWeapon'):FireServer(ItemNameToGive.Text)
end)

script.Parent.GiftPet.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftPet'):FireServer(ItemNameToGive.Text)
end)

script.Parent.GiftPerks.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftPerks'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiftEmotes.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftEmotes'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiftEffect.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftEffect'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiftToys.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftToys'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiftAllEffects.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftAllEffects'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiftRadio.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('GiftRadio'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.ForceBonusRound.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('ForceBonusRound'):FireServer(ItemNameToGive.Text)
end)

script.Parent.SetMap.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('SetMap'):FireServer(ItemNameToGive.Text)
end)

script.Parent.ForceMurderer.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('ForceMurderer'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.ForceSheriff.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GiftGUI:WaitForChild('ForceSheriff'):FireServer(PlayerNameToGive.Text)
end)