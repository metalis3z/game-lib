player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			Run.Stepped:wait(0.01)
		end
		
		
		for i = 1, 80 do
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Really red")
		x.Material = "Granite"
		x.Transparency = 0.2
		x.Size = Vector3.new(16, 16, 16)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		fire = script.Fire:Clone()
		fire.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = Vector3.new(0, -70, 0)
		y.Parent = x
		x.Parent = game.Workspace
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(math.random(-80, 80), 100, math.random(-80, 80))
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 2)
		
		wait(0.02)

		end

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			Run.Stepped:wait(0.01)
		end
		
		wait(8)
		script.Disabled = false
	end
end)