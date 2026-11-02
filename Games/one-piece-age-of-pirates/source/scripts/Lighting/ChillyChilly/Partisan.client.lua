player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
		
		
		for i = 1, 10 do
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Pastel Blue")
		x.Transparency = 0.2
		x.Material = "Ice"
		x.Size = Vector3.new(3, 3, 14)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=30694864"
		z.Scale  = Vector3.new(3, 3, 3)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(math.random(-8, 8), math.random(0, 5), 12) * CFrame.Angles(0, -3.25, 0)
		
		smoke = script.Smoke:Clone()
		smoke.Parent = x
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 3)

		wait(0.05)

		end

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(14)
		script.Disabled = false
	end
end)