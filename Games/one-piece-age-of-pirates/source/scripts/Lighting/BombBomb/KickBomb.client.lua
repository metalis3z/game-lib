player = script.Parent.Parent
mouse = player:GetMouse()
RightHip = script.Parent.Parent.Character.Torso["Right Hip"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightHip.C0 = RightHip.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 24
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Light orange")
		x.Transparency = 0.4
		x.Size = Vector3.new(1, 2, 1)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		x.Parent = game.Workspace
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		fd.Disabled = false
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1.05, 1.05, 1.05)
		
		x.CFrame = script.Parent.Parent.Character["Right Leg"].CFrame
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = script.Parent.Parent.Character["Right Leg"]
		weld3.C0 = script.Parent.Parent.Character["Right Leg"].CFrame:inverse()
		weld3.Part1 = x
		weld3.C1 = x.CFrame:inverse()
		weld3.Parent = script.Parent.Parent.Character["Right Leg"]
		
  		game.Debris:AddItem(x, 5)

		wait(5.5)
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 16

		for i = 1, 10 do
			RightHip.C0 = RightHip.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(14)
		script.Disabled = false
	end
end)