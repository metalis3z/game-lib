local GunName = "HK416 Mod"

script.Parent.Text = GunName.. " | $".. game.ReplicatedStorage.GunShopWeaponData:FindFirstChild(GunName).Value

script.Parent.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Events.BuyWeapon:FireServer(GunName)
end)