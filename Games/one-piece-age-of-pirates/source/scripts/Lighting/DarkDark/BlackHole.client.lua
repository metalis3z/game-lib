player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Really black")
		x.Size = Vector3.new(90, 1, 90)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Material = "Marble"
		x.Shape = "Block"
		x.Name = "Ice"
		x.CanCollide = false
		x.Anchored = true
		spin = script.Spin:Clone()
		spin.Parent = x
		p = script.PointLight:Clone()
		p.Parent = x
		x.Transparency = 0
		fd = script.Firedamage:Clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("CylinderMesh",x)
		z.Scale  = Vector3.new(0, 0, 0)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, -3, 0)
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, -3, 0)
		fd.Disabled = false

  		game.Debris:AddItem(x, 5)
		for i = 1,10 do
			z.Scale = z.Scale + Vector3.new(0.1, 0.1, 0.1)
			wait(0.05)
		end
		
	end
		
		wait(14)
		script.Disabled = false
end)

