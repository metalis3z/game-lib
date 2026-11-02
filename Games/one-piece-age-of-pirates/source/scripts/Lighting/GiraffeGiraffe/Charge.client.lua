player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.Size = Vector3.new(50, 50, 50)
		x.BrickColor = BrickColor.new("Cyan")
		x.Parent = game.Workspace
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame
		x.CanCollide = false
		x.Anchored = true
		x.Transparency = 1
		game.Debris:AddItem(x, 3)
		p = script.PointLight:Clone()
		p.Parent = x
		fd = script.Firedamage:Clone()
		fd.Parent = x
		z = Instance.new("SpecialMesh")
		z.MeshType = "Brick"
		z.Scale = Vector3.new(1, 1, 1)
		z.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*50
		y.Parent = script.Parent.Parent.Character.Torso
		game.Debris:AddItem(y, 3)
		fd.Disabled = false
		
		for i = 1, 60 do
			x.CFrame = script.Parent.Parent.Character.Torso.CFrame
			wait(0.05)
		end
		
		x:remove()
		
		y:remove()
		
end
		
		wait(12)
		script.Disabled = false
end)

