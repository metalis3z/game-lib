script.Parent.Touched:connect(function(Part)
	if not script.Parent:FindFirstChild(Part.Parent.Name) then
	f = script.Parent.Owner
	player = game.Players:FindFirstChild(f.Value)
	humanoid = player.Character.Humanoid
	if Part.Parent:FindFirstChild("Humanoid") ~= nil and Part.Parent.Name ~= f.Value then
		x = script.Parent
		x.Anchored = true
			Part.Parent.Humanoid:TakeDamage(15)
			o = Instance.new("StringValue")
			o.Parent = script.Parent
			o.Name = Part.Parent.Name
			
			Part.Parent.Humanoid.PlatformStand = true
			
			wait(0.5)
			
			Part.Parent.Torso.Anchored = true
			wait(3)
			Part.Parent.Torso.Anchored = false
			
			Part.Parent.Humanoid.PlatformStand = false
		end
	end
end)


wait(5)
script.Parent:Destroy()