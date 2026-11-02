player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Bright orange")
		x.Transparency = 0.3
		x.Size = Vector3.new(15, 15, 15)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fire = script.Fire:Clone()
		fire.Parent = x
		
		x2 = x:Clone()
		x2.Name = "Fire2"
		x2.Transparency = 0.5
		x2.BrickColor = BrickColor.new("Bright red")
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		fd2 = script.Firedamage2:clone()
		fd2.Parent = x2
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1, 1, 1)
		
		z2 = Instance.new("SpecialMesh",x2)
		z2.MeshType = "Brick"
		z2.Scale  = Vector3.new(1, 1, 1)
		
		spin = script.Spin:Clone()
		spin.Parent = x
		
		spin2 = script.Spin2:Clone()
		spin2.Parent = x2
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -8)
		
		y2 = Instance.new("BodyVelocity")
		y2.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y2.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x2.Parent = game.Workspace
		y2.Parent = x2
		x2.CFrame = x.CFrame
		
		fd.Disabled = false
		fd2.Disabled = false
  		game.Debris:AddItem(x, 2)
  		game.Debris:AddItem(x2, 2)

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