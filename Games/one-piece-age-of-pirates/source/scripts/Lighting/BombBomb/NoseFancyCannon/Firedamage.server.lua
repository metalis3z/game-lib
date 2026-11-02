script.Parent.Touched:connect(function(Part)
	f = script.Parent.Owner
	player = game.Players:FindFirstChild(f.Value)
	humanoid = player.Character.Humanoid
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value then
		x = script.Parent
		x.PointLight:Destroy()
		x.Transparency = 1
		boom = Instance.new("Explosion")
		boom.Parent = game.Workspace
		boom.BlastPressure = 0
		boom.Position = x.Position
		local enemyPlayer = game.Players:GetPlayerFromCharacter(Part.Parent)
		if player.Data.Side.Value ~= enemyPlayer.Data.Side.Value or player.Data.Side.Value == "Pirate" then
			Part.Parent.Humanoid:TakeDamage(25)
			if (Part.Parent.Humanoid.Health <= 0 and (humanoid:FindFirstChild("Killer") == nil)) then
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