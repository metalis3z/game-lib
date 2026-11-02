player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
			d[i].Handle.Transparency = 1
			end
		end
		
		face = script.Parent.Parent.Character.Head.face.Texture
		
		script.Parent.Parent.Character.Head.face.Texture = ""
		
		
		script.Parent.Parent.Character.Head.Transparency = 1
		script.Parent.Parent.Character.Torso.Transparency = 1
		script.Parent.Parent.Character["Left Arm"].Transparency = 1
		script.Parent.Parent.Character["Right Arm"].Transparency = 1
		script.Parent.Parent.Character["Left Leg"].Transparency = 1
		script.Parent.Parent.Character["Right Leg"].Transparency = 1
		
		script.Parent.Parent.Character.Head.face.Transparency = 1
		
		smoke = script.Smoke:Clone()
		smoke.Parent = script.Parent.Parent.Character.Torso
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = script.Parent.Parent.Character.Humanoid.WalkSpeed + 14
		
			wait(15)
			
			script.Parent.Parent.Character.Head.Transparency = 0
			script.Parent.Parent.Character.Torso.Transparency = 0
			script.Parent.Parent.Character["Left Arm"].Transparency = 0
			script.Parent.Parent.Character["Right Arm"].Transparency = 0
			script.Parent.Parent.Character["Left Leg"].Transparency = 0
			script.Parent.Parent.Character["Right Leg"].Transparency = 0
			
			script.Parent.Parent.Character.Humanoid.WalkSpeed = script.Parent.Parent.Character.Humanoid.WalkSpeed - 14
			
			smoke:remove()
			
			script.Parent.Parent.Character.Head.face.Texture = face
			
			local d = script.Parent.Parent.Character:GetChildren() 
			for i=1, #d do 
			if (d[i].className == "Hat") then 
			d[i].Handle.Transparency = 0
			end 
		end
	end
		
		wait(45)
		script.Disabled = false
end)

