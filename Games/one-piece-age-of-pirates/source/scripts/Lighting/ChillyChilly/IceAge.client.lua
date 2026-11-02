player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Pastel Blue")
		x.Size = Vector3.new(1, 1, 1)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Material = "Ice"
		x.Shape = "Block"
		x.Name = "Gravity"
		x.CanCollide = false
		x.Anchored = false
		x.Transparency = 0.2
		fd = script.Firedamage:Clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1, 1, 1)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -3, 0)
		originalpos = x.CFrame
		fd.Disabled = false
  		game.Debris:AddItem(x, 8)
		for i = 1, 30 do
			x.Size = x.Size + Vector3.new(10, 0, 10)
			x.CFrame = originalpos
			wait(0.1)
		end
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			Run.Stepped:wait(0.01)
		end
	end
		
		wait(25)
		script.Disabled = false
end)
