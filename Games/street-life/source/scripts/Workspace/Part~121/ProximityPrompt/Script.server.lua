script.Parent.Triggered:Connect(function(Player)
	game:FindService('ReplicatedStorage'):FindFirstChild('AccessoriesStore'):Clone().Parent = Player.PlayerGui
end)