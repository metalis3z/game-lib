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
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end


		part = script.Union:Clone()
		part.CFrame = script.Parent.Parent.Character["Right Arm"].CFrame
		part.Parent = script.Parent.Parent.Character
		wpart = Instance.new("Weld", script.Parent.Parent.Character)
		wpart.Part0 = script.Parent.Parent.Character["Right Arm"]
		wpart.Part1 = part
		wpart.C1 = CFrame.fromEulerAnglesXYZ(1.5, 0, 0) *CFrame.new(0, 1.47, 0.34)
		wait(1)
		
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Alder")
		x.Transparency = 1
		x.Size = Vector3.new(60, 60, 60)
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
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -45)
		
		for i = 1, 50 do
			boom = Instance.new("Explosion")
			boom.Parent = x
			boom.BlastPressure = 0
			boom.BlastRadius = 100
			boom.Position = x.Position + Vector3.new(math.random(-25, 25), math.random(-5, 15), math.random(-25, 25))
			fd.Disabled = false
		end
		
		wait(1)
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		part:remove()
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 1)

		wait(12)
		script.Disabled = false
	end
end)