game.ReplicatedStorage.EntityInfo.StartTimerPlayAgain.OnServerEvent:Connect(function(player)
	wait("PROSHLO")
	local d = 20
	for i = 1, 20 do
		wait(1.1)
		game.ReplicatedStorage.GameData.PlayAgainText.Value = tostring(d)
		d = d - 1
	end
	
	game.ReplicatedStorage.EntityInfo.Loading:FireClient(player, true)
end)