player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "b") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Really red")
		x.Material = "Granite"
		x.Transparency = 0.2
		x.Size = Vector3.new(80, 80, 80)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fire = script.Fire:Clone()
		fire.Parent = x
		
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
		z.Scale  = Vector3.new(0, 0, 0)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 70
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(2, 0, -8)
		
		for i = 1, 20 do
			z.Scale = z.Scale + Vector3.new(0.05, 0.05, 0.05)
			p.Range = p.Range + 1.5
			wait()
		end

  		game.Debris:AddItem(x, 2)

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(14)
		script.Disabled = false
	end
end)