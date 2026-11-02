player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			Run.Stepped:wait(0.01)
		end
		
		x2 = script.Union:Clone()
		x2.Parent = game.Workspace
		x2.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -10.5, -35)
		
		o = Instance.new("StringValue",x2)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		for i = 1, 35 do
			x2.CFrame = x2.CFrame * CFrame.new(0, 0.33, 0)
			wait()
		end

		game.Debris:AddItem(x2, 15)
		
		x2.Firedamage.Disabled = false

		wait(3)
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.3)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.3)
			Run.Stepped:wait(0.01)
		end	
		
		wait(25)
		script.Disabled = false
	end
end)