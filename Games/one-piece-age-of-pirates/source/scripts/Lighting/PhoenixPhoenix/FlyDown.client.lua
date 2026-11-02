player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		y = script.Parent.Parent.Character.Torso.Flying
		
		if script.Parent.Parent.Character.Humanoid.WalkSpeed <= 16 then
			return
		end
		
		script.Disabled = true
		
		y.position = y.position - Vector3.new(0, 7, 0)
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = script.Parent.Parent.Character.Humanoid.WalkSpeed - 1
		
		wait(0.1)
		
		script.Disabled = false
	end
end)