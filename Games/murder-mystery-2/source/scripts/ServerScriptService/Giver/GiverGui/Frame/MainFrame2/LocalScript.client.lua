local ItemNameToGive = script.Parent.ItemName
local PlayerNameToGive = script.Parent.PlayerName
local AmountToGive = script.Parent.Quanity
local debounce = false

script.Parent.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.GiveWeapon.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('SpawnWeapons'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text, AmountToGive.Text)
end)

script.Parent.GivePet.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('SpawnPets'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.RemoveWeapon.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('RemoveWeapons'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiveEffects.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveEffect'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiveLevel.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('SpawnLevels'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.RemoveData.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('RemoveData'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiveElite.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveElitePass'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiveElite.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveRadioPass'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiveGems.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveGems'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiveCoins.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveCoins'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
end)

script.Parent.GiveAll.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveAllWeapons'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiveKnife.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveKnife'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.GiveGun.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('GiveGun'):FireServer(PlayerNameToGive.Text)
end)

script.Parent.EndGame.MouseButton1Click:Connect(function()
	game.ReplicatedStorage:WaitForChild('EndGame'):FireServer(PlayerNameToGive.Text)
end)