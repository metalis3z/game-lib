player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		face = script.Parent.Parent.Character.Head.face.Texture
		
		script.Parent.Parent.Character.Head.face.Texture = ""
		
		othershell = script.Parent.Parent.Character.Shell
		othertorso = script.Parent.Parent.Character.Torso1
		otherhead = script.Parent.Parent.Character.Head1
		otherrightarm = script.Parent.Parent.Character.RightArm1
		otherleftarm = script.Parent.Parent.Character.LeftArm1
		otherrightleg = script.Parent.Parent.Character.RightLeg1
		otherleftleg = script.Parent.Parent.Character.LeftLeg1
		
		shell = game.Lighting.Turtle.Torso.Shell:Clone()
		shell.CanCollide = false
		shell.Parent = game.Workspace
		shell.Anchored = true
		shell.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, -1.5, 0)
		
		othershell.Transparency = 1
		othertorso.Transparency = 1
		otherhead.Transparency = 1
		otherrightarm.Transparency = 1
		otherleftarm.Transparency = 1
		otherrightleg.Transparency = 1
		otherleftleg.Transparency = 1
		
		script.Parent.Parent.Character.Head.Transparency = 1
		
			local d = script.Parent.Parent.Character:GetChildren() 
			for i=1, #d do 
			if (d[i].className == "Hat") then 
			d[i].Handle.Transparency = 1
			end
			end
			
			local d2 = script.Parent.Parent.Character:GetChildren() 
			for i2=1, #d2 do 
			if (d2[i2].className == "Model") then 
			d[i2].Handle.Transparency = 1
			end
			end
		
			health = script.Parent.Parent.Character.Humanoid.Health
		
		for i = 1, 667 do
			script.Parent.Parent.Character.Humanoid.Health = health
			shell.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, -1.5, 0)
			wait(0.03)
		end
		
		shell:remove()
		
		othershell.Transparency = 0
		othertorso.Transparency = 0
		otherhead.Transparency = 0
		otherrightarm.Transparency = 0
		otherleftarm.Transparency = 0
		otherrightleg.Transparency = 0
		otherleftleg.Transparency = 0
		
		script.Parent.Parent.Character.Head.Transparency = 0.99
		
		script.Parent.Parent.Character.Head.face.Texture = face
		
			local d = script.Parent.Parent.Character:GetChildren() 
			for i=1, #d do 
			if (d[i].className == "Hat") then 
			d[i].Handle.Transparency = 0
			end
			end
			
			local d2 = script.Parent.Parent.Character:GetChildren() 
			for i2=1, #d2 do 
			if (d2[i2].className == "Model") then 
			d[i2].Handle.Transparency = 0
			end
			end
	end
end)