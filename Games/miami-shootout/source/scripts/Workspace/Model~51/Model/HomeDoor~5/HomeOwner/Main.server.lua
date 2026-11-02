debounce = false
local Price = script.Parent.Parent.Price.Value

local DataStores = game:GetService("DataStoreService")
local SafeItems = DataStores:GetDataStore("SafeItemsWipe1")

script.Parent.Buy.MouseClick:connect(function(player)
	if game.Players:findFirstChild(player.Name) ~= nil and debounce == false and game.Players:findFirstChild(player.Name):FindFirstChild("HomeOwner") == nil then
		if player.stored.Money.Value>= Price then
			player.stored.Money.Value = player.stored.Money.Value - Price
			debounce = true
			script.Parent.Buy.MaxActivationDistance = 0 
			script.Parent.Parent.Owner.Value = player.Name
			script.Parent.SurfaceGui.TextLabel.Text = player.Name
			local own = Instance.new("ObjectValue")
			own.Name = "HomeOwner"
			own.Value = script.Parent.Parent
			own.Parent = game.Players:findFirstChild(player.Name)
			--vvvvvvv Safe vvvvvvvv
			local Key = "Safe_" .. player.UserId
			local PlayerItems = SafeItems:GetAsync("Safe_"..player.UserId)
			if PlayerItems then
				for _, Items in ipairs(PlayerItems) do
					local ItemVal = Instance.new("StringValue")
					ItemVal.Name = Items
					ItemVal.Parent = script.Parent.Parent.Safe.Items
				end
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	if plr.Name == script.Parent.Parent.Owner.Value then
		script.Parent.Parent.Owner.Value = "None"
		script.Parent.SurfaceGui.TextLabel.Text = "$"..Price
		script.Parent.Buy.MaxActivationDistance = 12 
		debounce = false
	end
end)

script.Parent.SurfaceGui.TextLabel.Text = "$"..Price