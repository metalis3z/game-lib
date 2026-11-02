local RemoteEvent = game.ReplicatedStorage.ShopEvents:FindFirstChild("gun1") --the event name (needds to be the same name as the event in the purchase button script!!)
RemoteEvent.OnServerEvent:Connect(function(player,gun,price)
    local guntool = game.ReplicatedStorage.ToolStorage:FindFirstChild("CL-3")
    if guntool and player.leaderstats.Cash.Value > price then
        guntool:Clone().Parent = player.Backpack
        player.leaderstats.Cash.Value = player.leaderstats.Cash.Value - price
    end
end)

--do not touch anything else except the event name