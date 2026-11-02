player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "l") then
		
		script.Disabled = true
		
		health = script.Parent.Parent.Character.Humanoid.Health
		
		originalcf = script.Parent.Parent.Character.Torso.CFrame
		
		for i = 1, 200 do
			script.Parent.Parent.Character.Humanoid.WalkSpeed = 0
			script.Parent.Parent.Character.Torso.CFrame = originalcf * CFrame.new(math.random(-3, 3), 0, math.random(-3, 3))
			script.Parent.Parent.Character.Humanoid.Health = health
			wait(0.05)
		end
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 16
		
		wait(25)
		script.Disabled = false
	end
end)