player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
running = false

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z" and not running == true) then
		
		running = true
		
		script.Parent.Parent.Character.Humanoid.MaxHealth = script.Parent.Parent.Character.Humanoid.MaxHealth + 30
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 20
		
		charge = game.Lighting.GiraffeGiraffe.Charge:Clone()
		charge.Disabled = false
		charge.Parent = script.Parent
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
		d[i].Handle.Transparency = 1
		end
		end
		
		face = script.Parent.Parent.Character.Head.face.Texture
		
		script.Parent.Parent.Character.Head.face.Texture = ""
		
		head = script.Parent.Parent.Character.Head
		head.Transparency = 0.99
		
		otherhead = game.Lighting.Giraffe.Head.Part:Clone()
		otherhead.Name = "Head1"
		otherhead.Parent = head.Parent
		otherhead.CFrame = head.CFrame * CFrame.new(0, 1.9, -0.5) * CFrame.Angles(0, 3.15, 0)
		
		weld = Instance.new("Weld")
		weld.Part0 = head
		weld.C0 = head.CFrame:inverse()
		weld.Part1 = otherhead
		weld.C1 = otherhead.CFrame:inverse()
		weld.Parent = head
		otherhead.Anchored = false
		
		
		torso = script.Parent.Parent.Character.Torso
		torso.Transparency = 1
		
		othertorso = game.Lighting.Giraffe.Torso.Part:Clone()
		othertorso.Name = "Torso1"
		othertorso.Parent = torso.Parent
		othertorso.CFrame = torso.CFrame * CFrame.new(0, -0.1, 0.7) * CFrame.Angles(0, 3.15, 0)
		
		weld2 = Instance.new("Weld")
		weld2.Part0 = torso
		weld2.C0 = torso.CFrame:inverse()
		weld2.Part1 = othertorso
		weld2.C1 = othertorso.CFrame:inverse()
		weld2.Parent = torso
		othertorso.Anchored = false
		
		
		rightarm = script.Parent.Parent.Character["Right Arm"]
		rightarm.Transparency = 1
		
		otherrightarm = game.Lighting.Giraffe.RightArm.Part:Clone()
		otherrightarm.Name = "RightArm1"
		otherrightarm.Parent = rightarm.Parent
		otherrightarm.CFrame = rightarm.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.15, 0)
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = rightarm
		weld3.C0 = rightarm.CFrame:inverse()
		weld3.Part1 = otherrightarm
		weld3.C1 = otherrightarm.CFrame:inverse()
		weld3.Parent = rightarm
		otherrightarm.Anchored = false
		
		
		leftarm = script.Parent.Parent.Character["Left Arm"]
		leftarm.Transparency = 1
		
		otherleftarm = game.Lighting.Giraffe.LeftArm.Part:Clone()
		otherleftarm.Name = "LeftArm1"
		otherleftarm.Parent = leftarm.Parent
		otherleftarm.CFrame = leftarm.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.15, 0)
		
		weld4 = Instance.new("Weld")
		weld4.Part0 = leftarm
		weld4.C0 = leftarm.CFrame:inverse()
		weld4.Part1 = otherleftarm
		weld4.C1 = otherleftarm.CFrame:inverse()
		weld4.Parent = leftarm
		otherleftarm.Anchored = false
		
		
		leftleg = script.Parent.Parent.Character["Left Leg"]
		leftleg.Transparency = 1
		
		otherleftleg = game.Lighting.Giraffe.LeftLeg.Part:Clone()
		otherleftleg.Name = "LeftLeg1"
		otherleftleg.Parent = leftleg.Parent
		otherleftleg.CFrame = leftleg.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.15, 0)
		
		weld5 = Instance.new("Weld")
		weld5.Part0 = leftleg
		weld5.C0 = leftleg.CFrame:inverse()
		weld5.Part1 = otherleftleg
		weld5.C1 = otherleftleg.CFrame:inverse()
		weld5.Parent = leftleg
		otherleftleg.Anchored = false
		
		
		rightleg = script.Parent.Parent.Character["Right Leg"]
		rightleg.Transparency = 1
		
		otherrightleg = game.Lighting.Giraffe.RightLeg.Part:Clone()
		otherrightleg.Name = "RightLeg1"
		otherrightleg.Parent = rightleg.Parent
		otherrightleg.CFrame = rightleg.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.15, 0)
		
		weld6 = Instance.new("Weld")
		weld6.Part0 = rightleg
		weld6.C0 = rightleg.CFrame:inverse()
		weld6.Part1 = otherrightleg
		weld6.C1 = otherrightleg.CFrame:inverse()
		weld6.Parent = rightleg
		otherrightleg.Anchored = false
		
		
	else if (string.lower(key) == "z" and running) then
		
		head = script.Parent.Parent.Character.Head
		head.Transparency = 0
		
		torso = script.Parent.Parent.Character.Torso
		torso.Transparency = 0
		
		rightarm = script.Parent.Parent.Character["Right Arm"]
		rightarm.Transparency = 0
		
		leftarm = script.Parent.Parent.Character["Left Arm"]
		leftarm.Transparency = 0
		
		rightleg = script.Parent.Parent.Character["Right Leg"]
		rightleg.Transparency = 0
		
		leftleg = script.Parent.Parent.Character["Left Leg"]
		leftleg.Transparency = 0
		
		script.Parent.Parent.Character.Head1:remove()
		script.Parent.Parent.Character.Torso1:remove()
		script.Parent.Parent.Character.RightArm1:remove()
		script.Parent.Parent.Character.LeftArm1:remove()
		script.Parent.Parent.Character.RightLeg1:remove()
		script.Parent.Parent.Character.LeftLeg1:remove()
		
		script.Parent.Charge:remove()
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
		d[i].Handle.Transparency = 0
		end
		end
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 16
		
		script.Parent.Parent.Character.Head.face.Texture = face
		
		script.Parent.Parent.Character.Humanoid.MaxHealth = script.Parent.Parent.Character.Humanoid.MaxHealth - 30
		
		running = false
		
		script.Disabled = true
		
		wait(20)
		
		script.Disabled = false
		
	end end
end)