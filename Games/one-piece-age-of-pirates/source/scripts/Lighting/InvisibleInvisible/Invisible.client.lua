player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		if script.Parent.Parent.Character.Head.Transparency >= 1 then
			script.Parent.Parent.Character.Head.Transparency = 1
			script.Parent.Parent.Character.Torso.Transparency = 1
			script.Parent.Parent.Character["Right Arm"].Transparency = 1
			script.Parent.Parent.Character["Left Arm"].Transparency = 1
			script.Parent.Parent.Character["Right Leg"].Transparency = 1
			script.Parent.Parent.Character["Left Leg"].Transparency = 1
			
			local d = script.Parent.Parent.Character:GetChildren() 
			for i=1, #d do 
			if (d[i].className == "Hat") then 
				d[i].Handle.Transparency = 1
				end
			end
			
			local d = script.Parent.Parent.Character:GetChildren() 
			for i=1, #d do 
			if (d[i].className == "Model") then 
				d[i].Handle.Transparency = 1
				end
			end
		end
		
		script.Parent.Parent.Character.Head.Transparency = script.Parent.Parent.Character.Head.Transparency + 0.2
		script.Parent.Parent.Character.Torso.Transparency = script.Parent.Parent.Character.Torso.Transparency + 0.2
		script.Parent.Parent.Character["Right Arm"].Transparency = script.Parent.Parent.Character["Right Arm"].Transparency + 0.2
		script.Parent.Parent.Character["Left Arm"].Transparency = script.Parent.Parent.Character["Left Arm"].Transparency + 0.2
		script.Parent.Parent.Character["Right Leg"].Transparency = script.Parent.Parent.Character["Right Leg"].Transparency + 0.2
		script.Parent.Parent.Character["Left Leg"].Transparency = script.Parent.Parent.Character["Left Leg"].Transparency + 0.2
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then
			d[i].Handle.Transparency = d[i].Handle.Transparency + 0.2
			end
		end
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Model") then
			d[i].Handle.Transparency = d[i].Handle.Transparency + 0.2
			end
		end
		
		script.Disabled = false
	end
end)