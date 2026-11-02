local l__RealGameId__3 = "13180494150"
local tp = game:GetService("TeleportService")

game.ReplicatedStorage.Bricks:FindFirstChild("ReturingToLobby").OnServerEvent:Connect(function(player)
	tp:Teleport(l__RealGameId__3,player);
end)