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
			Part.Parent.Humanoid:TakeDamage(20)
			if (Part.Parent.Humanoid.Health <= 0 and humanoid:FindFirstChild("Killer") == nil) then
				local killerVal = Instance.new("StringValue")
				killerVal.Name = "Killer"
				killerVal.Value = player.Name
				killerVal.Parent = Part.Parent.Humanoid
				if player.Data.Side.Value == "Marine" and enemyPlayer.Data.Side.Value == "Pirate" then
					enemyPlayer.Data.Imprisoned.Value = true
				end
			end
			for i = 1, 10 do
				script.Parent.Mesh.Scale = script.Parent.Mesh.Scale + Vector3.new(0.1, 0.1, 0.1)
				script.Parent.Transparency = script.Parent.Transparency + 0.03
				wait()
			end
		end
	end
end)


wait(5)
script.Parent:remove()