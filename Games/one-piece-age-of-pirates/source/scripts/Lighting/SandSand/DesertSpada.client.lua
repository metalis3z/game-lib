player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			Run.Stepped:wait(0.01)
		end
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Pastel brown")
		x.Material = "Sand"
		x.Transparency = 1
		x.Size = Vector3.new(12, 12, 12)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 40
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -15)
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 12)
		
		for i = 1, 15 do
			
		g = Instance.new("Part")
		g.BrickColor = BrickColor.new("Pastel brown")
		g.Material = "Sand"
		g.Transparency = 0.1
		g.Size = Vector3.new(20, 100, 20)
		g.TopSurface = "Smooth"
		g.BottomSurface = "Smooth"
		g.CanCollide = false
		g.Anchored = true
		
		smoke = script.Smoke:Clone()
		smoke.Parent = g
		
		p2 = script.PointLight:Clone()
		p2.Parent = g
		
		z2 = Instance.new("SpecialMesh",g)
		z2.MeshType = "FileMesh"
		z2.MeshId = "http://www.roblox.com/asset/?id=1033714"
		z2.Scale  = Vector3.new(20, 0, 20)
		
		g.Parent = game.Workspace
		g.CFrame = x.CFrame * CFrame.new(0, 0, 0)
		
		
		for i = 1, 10 do
			z2.Scale = z2.Scale + Vector3.new(0, 16, 0)
			wait(0.01)
		end
  		game.Debris:AddItem(g, 5)

		wait(0.01)

		end

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			Run.Stepped:wait(0.01)
		end
		
		wait(14)
		script.Disabled = false
	end
end)