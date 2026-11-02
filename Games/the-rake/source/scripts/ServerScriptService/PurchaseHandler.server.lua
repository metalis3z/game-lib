local items = game.ReplicatedStorage:WaitForChild("Items")


local datastore = game:GetService("DataStoreService")
local data1 = datastore:GetDataStore("myKilldata")

game.Players.PlayerAdded:connect(function(player)
	local leaderstats = Instance.new("Folder",player)
	leaderstats.Name = "leaderstats"
	local points = Instance.new("IntValue", leaderstats)
	points.Name = "Points"
	points.Value = 0
	local kills = Instance.new("IntValue", leaderstats)
	kills.Name = "Kills"
	kills.Value = data1:GetAsync(player.UserId) or 0
	data1:SetAsync(player.UserId, kills.Value)

	game.Players.PlayerRemoving:connect(function()
		data1:SetAsync(player.UserId, kills.Value)
	end)
end)


game.ReplicatedStorage:WaitForChild("OnItemBought").OnServerEvent:Connect(function(plr, itemBought)
	
	if itemBought and itemBought:IsA("Tool") and itemBought.Parent == items then
		
		
		local points = plr.leaderstats.Points
		
		if points.Value >= itemBought.ShopGuiInfo.Price.Value then
			
			points.Value -= itemBought.ShopGuiInfo.Price.Value
			
			itemBought:Clone().Parent = plr.Backpack
		end
	end
end)