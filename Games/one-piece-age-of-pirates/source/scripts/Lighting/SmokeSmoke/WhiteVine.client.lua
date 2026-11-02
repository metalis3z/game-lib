player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("White")
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Transparency = 1
		x.Size = Vector3.new(32, 20, 32)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		x2 = Instance.new("Part")
		x2.Parent = game.Workspace
		x2.Transparency = 1
		x2.Size = Vector3.new(55, 55, 55)
		x2.CanCollide = false
		x2.Anchored = true
		x2.CFrame = script.Parent.Parent.Character.Torso.CFrame
		
		o = Instance.new("StringValue",x2)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		fd = script.Firedamage:Clone()
		fd.Parent = x2
		fd.Disabled = false
		
		smoke = script.Smoke:Clone()
		smoke.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=1095708"
		z.Scale  = Vector3.new(60, 88, 88)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = Vector3.new(0, 100, 0)
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, 0)
		
		for i = 1, 25 do
			g = Instance.new("Part")
			g.Transparency = 0.2
			g.BrickColor = BrickColor.new("White")
			g.Size = Vector3.new(32, 20, 32)
			g.Parent = game.Workspace
			g.CFrame = x.CFrame * CFrame.new(0, -5, 0) * CFrame.Angles(math.random(-6, 6), math.random(-6, 6), 0)
			g.Anchored = true
			g.CanCollide = false
			g.TopSurface = "Smooth"
			g.BottomSurface = "Smooth"
			smoke2 = script.Smoke:Clone()
			smoke2.Parent = g
			z2 = Instance.new("SpecialMesh",g)
			z2.MeshType = "FileMesh"
			z2.MeshId = "http://www.roblox.com/asset/?id=1095708"
			z2.Scale  = Vector3.new(60, 88, 88)
			o2 = Instance.new("StringValue",g)
			o2.Value = script.Parent.Parent.Character.Name
			o2.Name = "Owner"
			fd2 = script.Firedamage2:Clone()
			fd2.Parent = g
			fd2.Disabled = false
			game.Debris:AddItem(g, 4)
			wait(0.1)
		end
		
  		x:remove()

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(16)
		script.Disabled = false
	end
end)