player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
RightHip = script.Parent.Parent.Character.Torso["Right Hip"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightHip.C0 = RightHip.C0 *CFrame.Angles(0, 0, 0.2)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Bright yellow")
		x.Transparency = 0.7
		x.Reflectance = 0
		x.Size = Vector3.new(8, 8, 12)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		light = script.PointLight:Clone()
		light.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 150
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(2, -1, -8)
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 3)

		wait(1)

		for i = 1, 10 do
			RightHip.C0 = RightHip.C0 *CFrame.Angles(0, 0, -0.2)
			Run.Stepped:wait(0.01)
		end
		
		wait(14)
		script.Disabled = false
	end
end)