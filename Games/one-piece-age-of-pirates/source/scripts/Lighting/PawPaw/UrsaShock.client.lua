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
		
		script.Parent.Parent.Character.Torso.Anchored = true
		
		x = script.Union:Clone()
		x.CanCollide = false
		x.Anchored = true
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 20, 0)
		p = script.PointLight:clone()
		p.Parent = x
		fd = script.Firedamage:clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 200
		y.Name = "grav"
		x.Parent = game.Workspace
		y.Parent = x
    
		game.Debris:AddItem(x, 10)

		for i = 1, 40 do
			x.Size = x.Size - Vector3.new(0.35, 0.35, 0.35)
			x.CFrame = x.CFrame * CFrame.new(0, -0.25, 0)
			x.PointLight.Range = x.PointLight.Range - 0.3
			x.PointLight.Brightness = x.PointLight.Brightness - 0.015
			wait(0.02)
		end
		fd.Disabled = false
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 100
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 4, -10)
		script.Parent.Parent.Character.Torso.Anchored = false

		wait(.05)

		x.Anchored = false
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			Run.Stepped:wait(0.01)
		end	
		
		wait(15)
		script.Disabled = false
	end
end)