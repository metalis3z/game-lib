script.Parent.ClickDetector.MouseClick:connect(function(person)
		
		script.Disabled = true
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Really black")
		x.Transparency = 0
		x.Size = Vector3.new(1, 1, 1)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		fd.Disabled = false
		
		sp = script.Spin:Clone()
		sp.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.CFrame.lookVector * 100
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.CFrame * CFrame.new(0, 0, -8)
		
		boom = Instance.new("Explosion")
		boom.Parent = game.Workspace
		boom.BlastRadius = 10
		boom.BlastPressure = 0
		boom.Position = x.Position
		
		sound = script.Sound:Clone()
		sound.Parent = script.Parent
		sound:Play()
		
		wait(3)
		
		x:remove()

		y:remove()
		
		wait(8)
		script.Disabled = false
end)