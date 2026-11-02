local ItemNameToGive = script.Parent.ItemName
local PlayerNameToGive = script.Parent.PlayerName
local debounce = false

script.Parent.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.GiveWeapon.MouseButton1Click:Connect(function()
	spawn(function()
		game.ReplicatedStorage:WaitForChild('...'):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
	end)
end)

script.Parent.GivePet.MouseButton1Click:Connect(function()
	--if not debounce then
		game.ReplicatedStorage:WaitForChild("...."):FireServer(PlayerNameToGive.Text, ItemNameToGive.Text)
		--debounce = true
		--wait(2)
		--debounce = false
	--end
end)