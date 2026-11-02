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
		x.BrickColor = BrickColor.new("Pastel brown")
		x.Material = "Sand"
		x.Transparency = 0.3
		x.Size = Vector3.new(40, 60, 40)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		smoke = script.Smoke:Clone()
		smoke.Parent = x
		
		sp = script.Spin:Clone()
		sp.Parent = x
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=102638417"
		z.Scale  = Vector3.new(0, 0, 0)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 40
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -8)
		
		fd.Disabled = false
		
		for i = 1, 15 do
			z.Scale = z.Scale + Vector3.new(2, 2, 2)
			wait(0.02)
		end
		
  		game.Debris:AddItem(x, 5)

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