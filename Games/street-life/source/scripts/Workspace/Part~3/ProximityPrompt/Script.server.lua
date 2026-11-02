script.Parent.Triggered:Connect(function(Player)
	game:FindService('ReplicatedStorage'):FindFirstChild('ClothingStore'):Clone().Parent = Player.PlayerGui
end)