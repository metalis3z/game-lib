local Tycoon = script.Parent.Parent.Parent

while wait(0.1) do 
	if game.Players:FindFirstChild(Tycoon.Data.Owner.Value) then
		if script.Parent.Data.Enabled.Value == true then
			local Drop = script.Drop:Clone()
			Drop.Transparency = 0
			Drop.CanCollide = true
			Drop.Anchored = false
			Drop.Parent = Tycoon.Drops
			Drop.Position = script.Parent.DropSpot.Position
			wait(script.Parent.Data.Cooldown.Value)
		end
	end
end