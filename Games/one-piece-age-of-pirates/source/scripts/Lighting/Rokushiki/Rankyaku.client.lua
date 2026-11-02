player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Hip"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Hip"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "j") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Pastel Blue")
		x.Transparency = 0.3
		x.Size = Vector3.new(15, 15, 15)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		z = Instance.new("SpecialMesh", x)
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=13425802"
		z.Scale = Vector3.new(4, 4, 4)
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 80
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0.5, 1, 0) * CFrame.Angles(0, -1.6, 1.5)
		
		fd.Disabled = false
		
		wait(1)
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		for i = 1, 6 do
			x.Transparency = x.Transparency + 0.12
			wait()
		end
		
		wait(0.5)
		
  		x:remove()
		
		wait(14)
		script.Disabled = false
	end
end)