player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			Run.Stepped:wait(0.01)
		end
		
		script.Parent.Parent.Character.Torso.Anchored = true
		
		wait(2)
		
		script.Parent.Parent.Character.Humanoid.Health = script.Parent.Parent.Character.Humanoid.Health - 40
		
		script.Parent.Parent.Character["Left Leg"]:Destroy()
			
		x = Instance.new("Part")
		x.Parent = game.Workspace
		x.BrickColor = BrickColor.new("Really red")
		x.Transparency = 0.3
		x.Size = Vector3.new(4, 4, 4)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = true
		
		x2 = Instance.new("Part")
		x2.Parent = game.Workspace
		x2.BrickColor = BrickColor.new("Bright orange")
		x2.Transparency = 0.3
		x2.Size = Vector3.new(4, 4, 4)
		x2.TopSurface = "Smooth"
		x2.BottomSurface = "Smooth"
		x2.CanCollide = false
		x2.Anchored = true
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		fd.Disabled = false
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(0.99, 0.99, 0.99)
		
		z2 = Instance.new("SpecialMesh",x2)
		z2.MeshType = "Sphere"
		z2.Scale = Vector3.new(1, 1, 1)
		
		for i = 1, 30 do
			x.Size = x.Size + Vector3.new(6, 6, 6)
			x2.Size = x.Size
			x.CFrame = script.Parent.Parent.Character.Torso.CFrame
			x2.CFrame = x.CFrame
			p.Range = p.Range + 1.75
			wait()
		end
		
  		game.Debris:AddItem(x, 2)
		game.Debris:AddItem(x2, 2)

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			Run.Stepped:wait(0.01)
		end
		
		script.Parent.Parent.Character.Torso.Anchored = false
	end
end)