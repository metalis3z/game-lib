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
		x.BrickColor = BrickColor.new("Alder")
		x.Transparency = 1
		x.Size = Vector3.new(45, 11, 42)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=1095708"
		z.Scale  = Vector3.new(0, 0, 0)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 70
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, 12)
		
		smoke = script.Smoke:Clone()
		smoke.Parent = x
		
		fd.Disabled = false
  		game.Debris:AddItem(x, 2)
		
		for i = 1, 40 do
			z.Scale = z.Scale + Vector3.new(1, 1.375, 1.375)
			script.PointLight.Range = script.PointLight.Range + 0.5
			x.Transparency = x.Transparency - 0.015
			smoke.Opacity = smoke.Opacity + 0.02
			smoke.Size = smoke.Size + 0.7
			wait(0.025)
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