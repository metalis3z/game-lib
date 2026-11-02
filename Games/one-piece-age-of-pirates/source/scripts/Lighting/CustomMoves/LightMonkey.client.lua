player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "n") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
			
		x = Instance.new("Part")
		x.Parent = game.Workspace
		x.BrickColor = BrickColor.new("Bright yellow")
		x.Transparency = 0.6
		x.Size = Vector3.new(30, 42, 1)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = true
		
		x2 = Instance.new("Part")
		x2.Parent = game.Workspace
		x2.BrickColor = BrickColor.new("Bright yellow")
		x2.Transparency = 0.4
		x2.Size = Vector3.new(18, 18, 18)
		x2.CanCollide = false
		x2.Anchored = true
		
		z2 = Instance.new("SpecialMesh",x2)
		z2.MeshType = "FileMesh"
		z2.MeshId = "http://www.roblox.com/asset/?id=15853477"
		z2.Scale  = Vector3.new(8, 8, 8)
		
		originalpos = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0.5, -2)
		originalpos2 = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0.5, -4)
		
		x.CFrame = originalpos
		
		fd = script.Firedamage:clone()
		fd.Parent = x2
		fd.Disabled = false
		
		o = Instance.new("StringValue",x2)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(0.12, 0.1, 1)
		
  		game.Debris:AddItem(x, 3)
		game.Debris:AddItem(x2, 3)

		for i = 1, 150 do
			x.Size = x.Size + Vector3.new(0, 0, 2.5)
			x.CFrame = originalpos * CFrame.new(0, 0, (-1 * i))
			x2.CFrame = originalpos2 * CFrame.new(0, 0, (-2 * i))
			wait()
		end

		wait(0.5)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(15)
		script.Disabled = false
	end
end)