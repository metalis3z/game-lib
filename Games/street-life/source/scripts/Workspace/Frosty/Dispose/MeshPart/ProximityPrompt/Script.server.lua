script.Parent.Triggered:Connect(function(Player)
	if Player:FindFirstChild('CurrentFrost') then
		Player:FindFirstChild('CurrentFrost'):Destroy()
		game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'Threw away frost', 2)
		local Amount = math.random(10, 20)
		game.ReplicatedStorage.server:FireClient(Player, "money", Amount)
	else
		game:FindService('ReplicatedStorage'):FindFirstChild('Notify'):FireClient(Player, 'You have no frost to throw away', 2)
	end
end)