local textservice = game:GetService("TextService")

game.ReplicatedStorage.Send.OnServerEvent:Connect(function(player, msg)
	game.ReplicatedStorage.IfSend.Value = true
	game.ReplicatedStorage.Reci:FireAllClients(msg, player.Name)
	wait(5)
	game.ReplicatedStorage.IfSend.Value = false
end)