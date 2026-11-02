player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
torso = script.Parent.Parent.Character.Torso
rightarm = script.Parent.Parent.Character["Right Arm"]

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 25
		
		otherhead = game.Lighting.TremorTremor.Part:Clone()
		otherhead.Name = "Head1"
		otherhead.Parent = rightarm.Parent
		otherhead.CFrame = rightarm.CFrame * CFrame.new(0, -3, 0)
		
		weld = Instance.new("Weld")
		weld.Part0 = rightarm
		weld.C0 = rightarm.CFrame:inverse()
		weld.Part1 = otherhead
		weld.C1 = otherhead.CFrame:inverse()
		weld.Parent = rightarm
		otherhead.Anchored = false
		
		fd = script.Firedamage:Clone()
		fd.Parent = otherhead
		fd.Disabled = false
		
		o = Instance.new("StringValue")
		o.Name = "Owner"
		o.Value = script.Parent.Parent.Name
		o.Parent = otherhead
		
		wait(10)
		
		otherhead:remove()
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 16
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
	end
		
		wait(15)
		script.Disabled = false
end)
