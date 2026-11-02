local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("MoneyStats")
 
game.Players.PlayerAdded:Connect(function(Player)
    local Leaderstats = Instance.new("Folder", Player)
    Leaderstats.Name = "leaderstats"
    local Currency = Instance.new("IntValue", Leaderstats)
    Currency.Name = "Cash"  -- currenty name, do not change
    Currency.Value = 1000 --the amount of money you start with when you join the game (if you have API service enabled this wont effect anything)
 
    local Data = DataStore:GetAsync(Player.UserId)
    if Data then
        Currency.Value = Data 
    end
end)
 
game.Players.PlayerRemoving:Connect(function(Player)
    DataStore:SetAsync(Player.UserId, Player.leaderstats.Cash.Value)
end)
 
