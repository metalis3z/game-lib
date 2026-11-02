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
		
		local x2 = game.Lighting.CageCage.Row:Clone()
		x2.Parent = game.Workspace
		x2.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -7, -38)
		
		o = Instance.new("StringValue",x2)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		for i = 1, 35 do
			x2.CFrame = x2.CFrame * CFrame.new(0, 0.2, 0)
			wait()
		end

		game.Debris:AddItem(x2, 7)

		wait(3)
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end	
		
		wait(14)
		script.Disabled = false
	end
end)