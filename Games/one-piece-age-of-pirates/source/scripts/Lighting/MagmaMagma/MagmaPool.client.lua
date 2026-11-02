player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Really red")
		x.Material = "Granite"
		x.Transparency = 0.2
		x.FormFactor = "Custom"
		x.Size = Vector3.new(5, 1, 5)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = true
		
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
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 90
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -3, 0)
		
		fd.Disabled = false
		
		OriginalCF = x.CFrame
		
		for i = 1, 75 do
			x.CFrame = OriginalCF
			x.Size = x.Size + Vector3.new(2, 0, 2)
			x.CFrame = OriginalCF
			x.PointLight.Range = x.PointLight.Range + 1.4
			wait(0.01)
		end
  		game.Debris:AddItem(x, 4)
		
		wait(14)
		script.Disabled = false
	end
end)