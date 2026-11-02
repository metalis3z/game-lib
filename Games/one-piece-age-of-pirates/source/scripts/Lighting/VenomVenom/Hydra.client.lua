player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Royal purple")
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Material = "Ice"
		x.Transparency = 0.2
		x.Size = Vector3.new(30, 30, 30)
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
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=24478215"
		z.Scale  = Vector3.new(20, 20, 20)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 5, -25)
		
		fd.Disabled = false
		
		for i = 1, 30 do
			g = Instance.new("Part")
			g.Material = "Ice"
			g.Transparency = 0.2
			g.BrickColor = BrickColor.new("Royal purple")
			g.Size = Vector3.new(25, 25, 25)
			g.Parent = game.Workspace
			g.CFrame = x.CFrame * CFrame.new(0, -7, 10) * CFrame.Angles(math.random(-6, 6), math.random(-6, 6), math.random(-6, 6))
			g.Anchored = true
			g.CanCollide = false
			g.TopSurface = "Smooth"
			g.BottomSurface = "Smooth"
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