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
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Medium stone grey")
		x.Transparency = 0.9
		x.Reflectance = 0.5
		x.Size = Vector3.new(40, 30, 1)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = true
		x.Anchored = true
		
		hum = Instance.new("Humanoid")
		hum.Parent = x
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 5, -4)
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 12)

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(18)
		script.Disabled = false
	end
end)