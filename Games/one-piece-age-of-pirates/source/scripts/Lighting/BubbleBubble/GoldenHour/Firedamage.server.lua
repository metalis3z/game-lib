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
			if (Part.Parent.Humanoid.Health <= 0) and (humanoid:FindFirstChild("Killer") == nil) then
				local killerVal = Instance.new("StringValue")
				killerVal.Name = "Killer"
				killerVal.Value = player.Name
				killerVal.Parent = Part.Parent.Humanoid
				if player.Data.Side.Value == "Marine" and enemyPlayer.Data.Side.Value == "Pirate" then
					enemyPlayer.Data.Imprisoned.Value = true
				end
			end
			for i = 1, 15 do
				Part.Parent.Humanoid.WalkSpeed = 6
				bubble = game.Lighting.BubbleBubble.Part:Clone()
				bubble.Parent = game.Workspace
				bubble.CFrame = Part.Parent.Torso.CFrame * CFrame.new(math.random(-2, 2), math.random(-2, 3), math.random(-2, 2)) * CFrame.Angles(math.random(-6, 6), math.random(-6, 6), math.random(-6, 6))
				game.Debris:AddItem(bubble, 2)
				wait()
			end
			wait(2)
			Part.Parent.Humanoid.WalkSpeed = 16
		end
	end
end)


wait(5)
script.Parent:remove()