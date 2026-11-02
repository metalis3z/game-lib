player = script.Parent.Parent
mouse = player:GetMouse()
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "u") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("White")
		x.Size = Vector3.new(4, 4, 4)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Shape = "Block"
		x.Name = "Gravity"
		x.CanCollide = false
		x.Anchored = false
		x.Transparency = 0.6
		fd = script.Firedamage:Clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Name = "Owner"
		o.Value = script.Parent.Parent.Name
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Sphere"
		z.Scale  = Vector3.new(1, 0.8, 1)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -4, 0)
		fd.Disabled = false
  		game.Debris:AddItem(x, 4)

		originalcf = script.Parent.Parent.Character.Torso.CFrame

		for i = 1, 80 do
			x.Size = x.Size + Vector3.new(3, 3, 3)
			x.CFrame = originalcf
			x.Transparency = x.Transparency + 0.0055
			wait()
		end
	end
		
		wait(30)
		script.Disabled = false
end)

