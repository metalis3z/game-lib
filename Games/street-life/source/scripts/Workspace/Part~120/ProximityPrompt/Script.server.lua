script.Parent.Triggered:Connect(function(Player)
	game:FindService('ReplicatedStorage'):FindFirstChild('TattooStore'):Clone().Parent = Player.PlayerGui
end)