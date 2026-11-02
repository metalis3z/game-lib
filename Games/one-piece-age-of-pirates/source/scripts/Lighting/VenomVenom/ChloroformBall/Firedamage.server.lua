script.Parent.Touched:connect(function(Part)
	f = script.Parent.Owner
	player = game.Players:FindFirstChild(f.Value)
	humanoid = player.Character.Humanoid
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value then
		script.Disabled = true
		x = script.Parent
		local enemyPlayer = game.Players:GetPlayerFromCharacter(Part.Parent)
		x.Anchored = true
		if player.Data.Side.Value ~= enemyPlayer.Data.Side.Value or player.Data.Side.Value == "Pirate" then
			Part.Parent.Humanoid:TakeDamage(30)
			venomgui = game.Lighting.VenomVenom.VenomGui:Clone()
			player2 = game.Players:FindFirstParent(Part.Parent)
			venomgui.Parent = player2.PlayerGui
			for i = 1, 50 do
				Part.Parent.Humanoid.WalkSpeed = -16
				wait(0.1)
			end
			Part.Parent.Humanoid.WalkSpeed = 16
			venomgui:Destroy()
			if (Part.Parent.Humanoid.Health <= 0 and humanoid:FindFirstChild("Killer") == nil) then
				local killerVal = Instance.new("StringValue")
				killerVal.Name = "Killer"
				killerVal.Value = player.Name
				killerVal.Parent = Part.Parent.Humanoid
				if player.Data.Side.Value == "Marine" and enemyPlayer.Data.Side.Value == "Pirate" then
					enemyPlayer.Data.Imprisoned.Value = true
				end
			end
		end
	end
end)


wait(5)
script.Parent:remove()