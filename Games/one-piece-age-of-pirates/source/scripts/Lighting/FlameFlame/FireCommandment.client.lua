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
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end	
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Bright orange")
		x.Size = Vector3.new(35, 35, 35)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Shape = "Ball"
		x.CanCollide = false
		x.Anchored = true
		p = script.PointLight:clone()
		p.Parent = x
		x.Transparency = 1
		fd = script.Firedamage:clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(0, 0, 0)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 150
		y.Name = "grav"
		x.Parent = game.Workspace
		y.Parent = x
		f = Instance.new("Fire",x)
		f.Size = 0
		
		x2 = Instance.new("Part")
		x2.Name = "FireFire2"
		x2.BrickColor = BrickColor.new("Bright red")
		x2.Size = Vector3.new(35, 35, 35)
		x2.TopSurface = "Smooth"
		x2.BottomSurface = "Smooth"
		x2.Shape = "Ball"
		x2.CanCollide = false
		x2.Anchored = true
		x2.Transparency = 1
		z2 = Instance.new("SpecialMesh",x2)
		z2.MeshType = "Sphere"
		z2.Scale  = Vector3.new(0,0,0)
		y2 = Instance.new("BodyVelocity")
		y2.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y2.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 150
		x2.Parent = game.Workspace
		y2.Parent = x2
    
		game.Debris:AddItem(x, 5)
		game.Debris:AddItem(x2, 5)

		for i = 1,25 do
			z.Scale = z.Scale + Vector3.new(0.04, 0.04, 0.04)
			z2.Scale = z.Scale - Vector3.new(0.05, 0.05, 0.05)
			x.Transparency = x.Transparency - 0.025
			x2.Transparency = x2.Transparency - 0.025
			x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(2, 22, 0)
			x2.CFrame = x.CFrame
			p.Range = p.Range + 1.6
			f.Size = f.Size + 1.6
			wait(0.1)
		end
		fd.Disabled = false
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*120
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 4, -20)
		y2.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*120
		x2.CFrame = x.CFrame

		wait(.05)

		x.Anchored = false
		x2.Anchored = false
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end	
		
		wait(24)
		script.Disabled = false
	end
end)