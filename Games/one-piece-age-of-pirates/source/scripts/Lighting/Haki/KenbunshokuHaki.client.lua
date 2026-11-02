player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "y") then
		
		script.Disabled = true
		
		hp = script.Parent.Parent.Character.Humanoid.Health
		
		for i = 1, 25 do
			script.Parent.Parent.Character.Humanoid.Health = hp
			script.Parent.Parent.Character.Torso.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(3, 0, 0)
			wait(0.2)
			script.Parent.Parent.Character.Humanoid.Health = hp
			script.Parent.Parent.Character.Torso.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(-3, 0, 0)
			wait(0.2)
		end
		

		
		wait(40)
		script.Disabled = false
	end
end)