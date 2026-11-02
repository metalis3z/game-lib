player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
rightarm = script.Parent.Parent.Character["Right Arm"]
leftarm = script.Parent.Parent.Character["Left Arm"]
torso = script.Parent.Parent.Character.Torso

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(0.1)
		
		rightarm.Transparency = 1
		
		otherrightarm = Instance.new("Part")
		otherrightarm.FormFactor = "Custom"
		otherrightarm.Size = Vector3.new(1, 1, 2)
		otherrightarm.BrickColor = rightarm.BrickColor
		otherrightarm.TopSurface = "Smooth"
		otherrightarm.BottomSurface = "Smooth"
		otherrightarm.Name = "RightArm1"
		otherrightarm.Parent = rightarm.Parent
		otherrightarm.CFrame = torso.CFrame * CFrame.new(1.52, 0.5, -0.5)
		otherrightarm.CanCollide = false
		otherrightarm.Anchored = true
		
		fd = script.Firedamage:Clone()
		fd.Parent = otherrightarm
		fd.Disabled = false
		
		o = Instance.new("StringValue",otherrightarm)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		for i = 1, 50 do
			otherrightarm.Size = otherrightarm.Size + Vector3.new(0, 0, 2)
			otherrightarm.CFrame = torso.CFrame * CFrame.new(1.52, 0.5, (-0.5 - i * 1))
			wait()
		end
		
		for i = 1, 25 do
			otherrightarm.CFrame = torso.CFrame * CFrame.new(1.52, 0.5, -50.5)
			wait()
		end
		
		for i = 1, 50 do
			otherrightarm.Size = otherrightarm.Size - Vector3.new(0, 0, 2)
			otherrightarm.CFrame = torso.CFrame * CFrame.new(1.52, 0.5, (-50.5 + i * 1))
			wait()
		end
		
		otherrightarm:remove()
		rightarm.Transparency = 0
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(15)
		script.Disabled = false
	end
end)