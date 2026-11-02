function onDamage(Part)
	f = script.Parent.Owner
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:findFirstChild("Snow") == nil then
		script.Disabled = true
		player = game.Players:FindFirstChild(f.Value)
		humanoid = player.Character.Humanoid
		x = script.Parent
		
		local enemyPlayer = game.Players:GetPlayerFromCharacter(Part.Parent)
		x.Anchored = true
		if player.Data.Side.Value ~= enemyPlayer.Data.Side.Value or player.Data.Side.Value == "Pirate" then
			Part.Parent.Humanoid:TakeDamage(20)
			
				Part.Parent.Humanoid.PlatformStand = true
				
				color1 = Part.Parent.Head.BrickColor
				color2 = Part.Parent.Torso.BrickColor
				color3 = Part.Parent["Right Arm"].BrickColor
				color4 = Part.Parent["Left Arm"].BrickColor
				color5 = Part.Parent["Right Leg"].BrickColor
				color6 = Part.Parent["Left Leg"].BrickColor
				
				Part.Parent.Head.BrickColor = BrickColor.new("Sand red")
				Part.Parent.Torso.BrickColor = BrickColor.new("Sand red")
				Part.Parent["Right Arm"].BrickColor = BrickColor.new("Sand red")
				Part.Parent["Left Arm"].BrickColor = BrickColor.new("Sand red")
				Part.Parent["Right Leg"].BrickColor = BrickColor.new("Sand red")
				Part.Parent["Left Leg"].BrickColor = BrickColor.new("Sand red")
				
				for i = 1, 10 do
					Part.Parent.Humanoid.WalkSpeed = Part.Parent.Humanoid.WalkSpeed - 1
					wait(0.1)
				end
				wait(5)
				Part.Parent.Head.BrickColor = color1
				Part.Parent.Torso.BrickColor = color2
				Part.Parent["Right Arm"].BrickColor = color3
				Part.Parent["Left Arm"].BrickColor = color4
				Part.Parent["Right Leg"].BrickColor = color5
				Part.Parent["Left Leg"].BrickColor = color6
				
				Part.Parent.Humanoid.WalkSpeed = Part.Parent.Humanoid.WalkSpeed + 10
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

	
	if Part.Parent:findFirstChild("Snow") ~= nil and Part.Parent.Name ~= f.Value and Part.Parent:FindFirstChild("Humanoid") ~= nil then
		
Part.Parent.Humanoid.Health = Part.Parent.Humanoid.Health + 0
x = math.random(1,5)
if x == 1 then
game:GetServSand("Chat"):Chat(Part.Parent.Head, "Now i got some ".. script.Parent.Name .." In My Belly" )
end
script.Disabled = true
	end

end



script.Parent.Touched:connect(onDamage)

door = script.Parent

wait(5)

script.Parent:remove()