player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "f") then
		
		script.Disabled = true
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(0, math.huge, 0)
		y.velocity = Vector3.new(0, 30, 0)
		y.Parent = script.Parent.Parent.Character.Torso
		
		cloud = script.Part:Clone()
		cloud.Parent = game.Workspace
		cloud.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -2, 0)
		
		for i = 1, 5 do
			cloud.Transparency = cloud.Transparency + 0.1
			wait(0.075)
		end
		
		y:remove()
		cloud:remove()

		wait(0.45)
		script.Disabled = false
	end
end)