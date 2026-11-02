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
		
		trem1 = Instance.new("Part")
		trem1.Anchored = true
		trem1.Transparency = 1
		trem1.CanCollide = false
		trem1.Parent = game.Workspace
		trem1.FormFactor = "Custom"
		trem1.Size = Vector3.new(10, 10, 0.2)
		trem1.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -4)
		game.Debris:AddItem(trem1, 4)
		d1 = Instance.new("Decal")
		d1.Parent = trem1
		d1.Face = "Front"
		d1.Texture = "http://www.roblox.com/asset/?id=29268434"
		d2 = Instance.new("Decal")
		d2.Parent = trem1
		d2.Face = "Back"
		d2.Texture = "http://www.roblox.com/asset/?id=29268434"
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Reddish brown")
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Material = "Slate"
		x.Transparency = 0
		x.Size = Vector3.new(30, 30, 30)
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
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -8, -25)
		
		fd.Disabled = false
		
		for i = 1, 30 do
			g = Instance.new("Part")
			g.Material = "Slate"
			g.BrickColor = BrickColor.new("Reddish brown")
			g.Size = Vector3.new(30, 30, 30)
			g.Parent = game.Workspace
			g.CFrame = x.CFrame * CFrame.Angles(math.random(-6, 6), math.random(-6, 6), math.random(-6, 6))
			g.Anchored = true
			g.CanCollide = false
			g.TopSurface = "Smooth"
			g.BottomSurface = "Smooth"
			o2 = Instance.new("StringValue",g)
			o2.Value = script.Parent.Parent.Character.Name
			o2.Name = "Owner"
			fd2 = script.Firedamage2:Clone()
			fd2.Parent = g
			fd2.Disabled = false
			game.Debris:AddItem(g, 6)
			wait(0.1)
		end
		
  		x:remove()

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(16)
		script.Disabled = false
	end
end)