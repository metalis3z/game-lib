debounce = false
local Price = script.Parent.Parent.Price.Value

local Notify = game:FindService('ReplicatedStorage'):FindFirstChild('Notify')

script.Parent.Buy.Triggered:connect(function(player)
	if game.Players:findFirstChild(player.Name) ~= nil and debounce == false then
		if player.stored.Money.Value >= Price then
			if game.Players:findFirstChild(player.Name):FindFirstChild("HomeOwner") == nil then
				player.stored.Money.Value = player.stored.Money.Value - Price
				debounce = true
				script.Parent.Parent.Owner.Value = player.Name
				script.Parent.Buy.Enabled = false
				script.Parent.SurfaceGui.Owner.Text = 'OWNER: ' .. player.Name
				script.Parent.SurfaceGui.TextLabel.Visible = false
				script.Parent.SurfaceGui.Owner.Visible = true
				script.Parent.SurfaceGui.For.Visible = false
				script.Parent.SurfaceGui.Sale.Visible = false
				script.Parent.SurfaceGui.BOUGHT.Visible = true
				local own = Instance.new("ObjectValue")
				own.Name = "HomeOwner"
				own.Value = script.Parent.Parent
				own.Parent = game.Players:findFirstChild(player.Name) Notify:FireClient(player, 'You bought a apartment.', 3)
			else
				Notify:FireClient(player, 'You already own a apartment.', 3)
			end
		else
			Notify:FireClient(player, 'You dont have enough to purchase this apartment.', 3)
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	if plr.Name == script.Parent.Parent.Owner.Value then script.Parent.Parent.Closed.Lock.C.Transparency = 1 script.Parent.Parent.Closed.Lock.O.Transparency = 0 script.Parent.Parent.Closed.Lock.C.Transparency = 1 script.Parent.Parent.Closed.Lock.O.Transparency = 0
		script.Parent.Parent.Owner.Value = "None"
		script.Parent.SurfaceGui.TextLabel.Visible = true
		script.Parent.SurfaceGui.TextLabel.Text = "$"..Price
		script.Parent.Buy.ObjectText = 'Buy for $' .. Price
		script.Parent.SurfaceGui.BOUGHT.Visible = false
		script.Parent.SurfaceGui.Owner.Visible = false
		script.Parent.SurfaceGui.Owner.Text = 'OWNER: fakeflipsy'
		script.Parent.Buy.Enabled = true
		script.Parent.SurfaceGui.For.Visible = true
		script.Parent.SurfaceGui.Sale.Visible = true
		debounce = false
	end
end)

script.Parent.Buy.ObjectText = 'Buy for $' .. Price
script.Parent.SurfaceGui.TextLabel.Text = "$"..Price
