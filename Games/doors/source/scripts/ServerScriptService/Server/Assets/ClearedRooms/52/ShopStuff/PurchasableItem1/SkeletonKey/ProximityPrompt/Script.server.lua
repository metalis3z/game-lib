local db = true

script.Parent.Triggered:Connect(function(player)
	local itemName = game.ReplicatedStorage.SkeletonKey:Clone()


	if player.leaderstats.Cash.Value >= 250 then
		db = false
		player.leaderstats.Cash.Value = player.leaderstats.Cash.Value - 250
		itemName.Parent = player.Backpack
		wait()
		db = true
	end
end)
