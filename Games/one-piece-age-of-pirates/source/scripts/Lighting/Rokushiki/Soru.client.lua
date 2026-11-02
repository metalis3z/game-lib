player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "k") then
		
		script.Disabled = true
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then
			trans = d[i].Handle.Transparency
			d[i].Handle.Transparency = 1
			end
		end
		
		for i = 1, 3 do
			script.Parent.Parent.Character.Head.Transparency = script.Parent.Parent.Character.Head.Transparency + 0.33
			script.Parent.Parent.Character.Torso.Transparency = script.Parent.Parent.Character.Torso.Transparency + 0.33
			script.Parent.Parent.Character["Right Arm"].Transparency = script.Parent.Parent.Character["Right Arm"].Transparency + 0.33
			script.Parent.Parent.Character["Left Arm"].Transparency = script.Parent.Parent.Character["Left Arm"].Transparency + 0.33
			script.Parent.Parent.Character["Right Leg"].Transparency = script.Parent.Parent.Character["Right Leg"].Transparency + 0.33
			script.Parent.Parent.Character["Left Leg"].Transparency = script.Parent.Parent.Character["Left Leg"].Transparency + 0.33
			wait(0.05)
		end
		
		script.Parent.Parent.Character:MoveTo(script.Parent.Parent.Character.Torso.Position + Vector3.new(math.random(-40, 40), 0, math.random(-40, 40)))

		local d2 = script.Parent.Parent.Character:GetChildren() 
		for i2=1, #d2 do 
		if (d2[i2].className == "Hat") then 
			d2[i2].Handle.Transparency = trans
			end
		end
		
		for i = 1, 3 do
			script.Parent.Parent.Character.Head.Transparency = script.Parent.Parent.Character.Head.Transparency - 0.33
			script.Parent.Parent.Character.Torso.Transparency = script.Parent.Parent.Character.Torso.Transparency - 0.33
			script.Parent.Parent.Character["Right Arm"].Transparency = script.Parent.Parent.Character["Right Arm"].Transparency - 0.33
			script.Parent.Parent.Character["Left Arm"].Transparency = script.Parent.Parent.Character["Left Arm"].Transparency - 0.33
			script.Parent.Parent.Character["Right Leg"].Transparency = script.Parent.Parent.Character["Right Leg"].Transparency - 0.33
			script.Parent.Parent.Character["Left Leg"].Transparency = script.Parent.Parent.Character["Left Leg"].Transparency - 0.33
			wait(0.05)
		end

		wait(5)
		
		script.Disabled = false
	end
end)