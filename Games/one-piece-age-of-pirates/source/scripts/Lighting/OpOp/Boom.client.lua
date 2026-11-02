player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.Size = Vector3.new(70, 40, 70)
		x.BrickColor = BrickColor.new("Cyan")
		x.Parent = game.Workspace
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame
		x.CanCollide = false
		x.Anchored = true
		x.Transparency = 0.6
		spin = script.Spin:Clone()
		spin.Parent = x
		p = script.PointLight:Clone()
		p.Parent = x
		fd = script.Firedamage:Clone()
		fd.Parent = x
		z = Instance.new("SpecialMesh")
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=90782182"
		z.Scale = Vector3.new(0, 0, 0)
		z.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		y.Parent = x
		fd.Disabled = false
		
		for i = 1, 10 do
			z.Scale = z.Scale + Vector3.new(0.7, 0.7, 0.7)
			x.CFrame = x.CFrame * CFrame.new(0, 1, 0)
			wait(0.05)
		end
		
		game.Debris:AddItem(x, 6)
		
end
		
		wait(18)
		script.Disabled = false
end)

