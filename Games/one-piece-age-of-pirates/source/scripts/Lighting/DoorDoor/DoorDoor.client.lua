player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.Size = Vector3.new(6, 8, 1)
		x.BrickColor = BrickColor.new("Cyan")
		x.Parent = game.Workspace
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 1, -5)
		x.CanCollide = false
		x.Anchored = true
		x.Transparency = 1
		d = Instance.new("Decal")
		d.Parent = x
		d.Transparency = 0.1
		d.Face = "Back"
		d.Texture = "http://www.roblox.com/asset/?id=156055649"
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
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		y.Parent = x
		fd.Disabled = false
		
		game.Debris:AddItem(x, 6)
		game.Debris:AddItem(fd, 6)
		
end
		
		wait(12)
		script.Disabled = false
end)

