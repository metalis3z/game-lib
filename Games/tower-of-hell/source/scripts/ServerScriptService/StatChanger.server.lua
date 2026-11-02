local perms = {"TommyExpressss"}
game.Players.PlayerAdded:Connect(function(player)
 for i, v in pairs(perms) do
  if game.Players:GetUserIdFromNameAsync(v) == player.UserId then
   script.StatChanger:Clone().Parent = player.PlayerGui
  end
 end
end)

game.ReplicatedStorage.Stat.OnServerEvent:Connect(function(player, stat, val)
 for i, v in pairs(perms) do
  if game.Players:GetUserIdFromNameAsync(player.Name) == player.UserId then
   player.leaderstats:FindFirstChild(stat).Value = val
  end
 end
end)