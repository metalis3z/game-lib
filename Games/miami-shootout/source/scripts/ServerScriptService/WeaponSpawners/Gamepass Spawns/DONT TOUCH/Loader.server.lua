game.Players.PlayerAdded:connect(function(p)
	local stats = Instance.new("IntValue")
	stats.Name = "Spawns"
	stats.Parent = p
	stats.Value = 20
end)

