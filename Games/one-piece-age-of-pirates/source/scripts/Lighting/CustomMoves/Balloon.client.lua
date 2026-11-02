player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
rightarm = script.Parent.Parent.Character["Right Arm"]
leftarm = script.Parent.Parent.Character["Left Arm"]
torso = script.Parent.Parent.Character.Torso

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "b") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(0.1)
		
		health = script.Parent.Parent.Character.Humanoid.Health
		
		otherrightarm = Instance.new("Part")
		otherrightarm.Shape = "Ball"
		otherrightarm.Transparency = 1
		otherrightarm.FormFactor = "Custom"
		otherrightarm.Size = Vector3.new(2, 2, 2)
		otherrightarm.BrickColor = rightarm.BrickColor
		otherrightarm.TopSurface = "Smooth"
		otherrightarm.BottomSurface = "Smooth"
		otherrightarm.Name = "RightArm1"
		otherrightarm.Parent = rightarm.Parent
		otherrightarm.CFrame = torso.CFrame
		otherrightarm.CanCollide = true
		otherrightarm.Anchored = true
		
		for i = 1, 5 do
			otherrightarm.CFrame = torso.CFrame
			script.Parent.Parent.Character.Torso.Anchored = true
			script.Parent.Parent.Character.Torso.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 2, 0)
			wait()
		end
		
		otherrightarm.Transparency = 0
		
		for i = 1, 10 do
			script.Parent.Parent.Character.Humanoid.Health = health
			otherrightarm.Size = otherrightarm.Size + Vector3.new(1, 1, 1)
			otherrightarm.CFrame = torso.CFrame
			wait()
		end
		
		script.Parent.Parent.Character.Torso.Anchored = false
		
		otherrightarm.CFrame = torso.CFrame
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = script.Parent.Parent.Character.Torso
		weld3.C0 = script.Parent.Parent.Character.Torso.CFrame:inverse()
		weld3.Part1 = otherrightarm
		weld3.C1 = otherrightarm.CFrame:inverse()
		weld3.Parent = script.Parent.Parent.Character.Torso
		otherrightarm.Anchored = false
		
		otherrightarm.CFrame = torso.CFrame
		
		for i = 1, 100 do
			script.Parent.Parent.Character.Humanoid.Health = health
			wait(0.1)
		end
		
		weld3:remove()
		otherrightarm.Anchored = true
		script.Parent.Parent.Character.Torso.Anchored = true
		
		for i = 1, 10 do
			script.Parent.Parent.Character.Humanoid.Health = health
			otherrightarm.Size = otherrightarm.Size - Vector3.new(1, 1, 1)
			otherrightarm.CFrame = torso.CFrame
			wait(0.1)
		end
		
		script.Parent.Parent.Character.Torso.Anchored = false
		
		otherrightarm:remove()
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(15)
		script.Disabled = false
	end
end)