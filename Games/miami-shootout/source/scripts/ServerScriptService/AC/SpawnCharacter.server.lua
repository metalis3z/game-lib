local used = {}

game.ReplicatedStorage.SpawnCharacter.OnServerEvent:Connect(function(p)
	if used[p] then return end
	used[p] = true
	p:LoadCharacter()
end)

game.Players.PlayerRemoving:Connect(function(p)
	if used[p] then used[p] = nil end
end)