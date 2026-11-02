player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
rightarm = script.Parent.Parent.Character["Right Arm"]
leftarm = script.Parent.Parent.Character["Left Arm"]

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "t") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
			color1 = script.Parent.Parent.Character.Torso.BrickColor
			color2 = script.Parent.Parent.Character.Head.BrickColor
			color3 = script.Parent.Parent.Character["Left Arm"].BrickColor
			color4 = script.Parent.Parent.Character["Right Arm"].BrickColor
			color5 = script.Parent.Parent.Character["Left Leg"].BrickColor
			color6 = script.Parent.Parent.Character["Right Leg"].BrickColor
			
			script.Parent.Parent.Character.Torso.BrickColor = BrickColor.new("Really black")
			script.Parent.Parent.Character.Head.BrickColor = BrickColor.new("Really black")
			script.Parent.Parent.Character["Left Arm"].BrickColor = BrickColor.new("Really black")
			script.Parent.Parent.Character["Right Arm"].BrickColor = BrickColor.new("Really black")
			script.Parent.Parent.Character["Left Leg"].BrickColor = BrickColor.new("Really black")
			script.Parent.Parent.Character["Right Leg"].BrickColor = BrickColor.new("Really black")
			
			script.Parent.Parent.Character.Humanoid.WalkSpeed = script.Parent.Parent.Character.Humanoid.WalkSpeed + 5
			
			script.Parent.Parent.Character.Humanoid.MaxHealth = script.Parent.Parent.Character.Humanoid.MaxHealth + 50
			
			script.Parent.Parent.Character.Humanoid.Health = script.Parent.Parent.Character.Humanoid.Health + 40
			
			wait(15)
			
			script.Parent.Parent.Character.Torso.BrickColor = color1
			script.Parent.Parent.Character.Head.BrickColor = color2
			script.Parent.Parent.Character["Left Arm"].BrickColor = color3
			script.Parent.Parent.Character["Right Arm"].BrickColor = color4
			script.Parent.Parent.Character["Left Leg"].BrickColor = color5
			script.Parent.Parent.Character["Right Leg"].BrickColor = color6
			
			script.Parent.Parent.Character.Humanoid.WalkSpeed = script.Parent.Parent.Character.Humanoid.WalkSpeed - 5
			
			script.Parent.Parent.Character.Humanoid.MaxHealth = script.Parent.Parent.Character.Humanoid.MaxHealth - 50
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(40)
		script.Disabled = false
	end
end)