player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
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
		trem1.Size = Vector3.new(0.2, 6, 6)
		trem1.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(4, 0, -2)
		game.Debris:AddItem(trem1, 6)
		d1 = Instance.new("Decal")
		d1.Parent = trem1
		d1.Face = "Right"
		d1.Texture = "http://www.roblox.com/asset/?id=29268434"
		d2 = Instance.new("Decal")
		d2.Parent = trem1
		d2.Face = "Left"
		d2.Texture = "http://www.roblox.com/asset/?id=29268434"
		
		trem2 = Instance.new("Part")
		trem2.Anchored = true
		trem2.Transparency = 1
		trem2.CanCollide = false
		trem2.Parent = game.Workspace
		trem2.FormFactor = "Custom"
		trem2.Size = Vector3.new(0.2, 6, 6)
		trem2.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(-4, 0, -2)
		game.Debris:AddItem(trem1, 6)
		d3 = Instance.new("Decal")
		d3.Parent = trem2
		d3.Face = "Right"
		d3.Texture = "http://www.roblox.com/asset/?id=29268434"
		d4 = Instance.new("Decal")
		d4.Parent = trem2
		d4.Face = "Left"
		d4.Texture = "http://www.roblox.com/asset/?id=29268434"
		game.Debris:AddItem(trem2, 6)
		
		x = script.Wave:Clone()
		x.Parent = game.Workspace
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, 600)
		x.CFrame = x.CFrame * CFrame.Angles(0, 3.1, 0)
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 150
		y.Parent = x
		
		fd.Disabled = false
		
  		game.Debris:AddItem(x, 12)

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(22)
		script.Disabled = false
	end
end)