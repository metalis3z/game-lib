player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
running = false

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z" and not running == true) then
		
		running = true
		
		script.Parent.Parent.Character.Humanoid.MaxHealth = script.Parent.Parent.Character.Humanoid.MaxHealth + 50
		
		flyup = game.Lighting.PhoenixPhoenix.FlyUp:Clone()
		flyup.Disabled = false
		flyup.Parent = script.Parent
		
		flydown = game.Lighting.PhoenixPhoenix.FlyDown:Clone()
		flydown.Disabled = false
		flydown.Parent = script.Parent
		
		regen = game.Lighting.PhoenixPhoenix.Regen:Clone()
		regen.Disabled = false
		regen.Parent = script.Parent
		
		y = Instance.new("BodyPosition")
		y.Name = "Flying"
		y.maxForce = Vector3.new(0, math.huge, 0)
		y.position = script.Parent.Parent.Character.Torso.Position + Vector3.new(0, 3, 0)
		y.Parent = script.Parent.Parent.Character.Torso
		
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
		
		torso = script.Parent.Parent.Character.Torso
		torso.Transparency = 1
		
		rightarm = script.Parent.Parent.Character["Right Arm"]
		rightarm.Transparency = 1
		
		leftarm = script.Parent.Parent.Character["Left Arm"]
		leftarm.Transparency = 1
		
		leftleg = script.Parent.Parent.Character["Left Leg"]
		leftleg.Transparency = 1
		
		rightleg = script.Parent.Parent.Character["Right Leg"]
		rightleg.Transparency = 1
		
		
		center = game.Lighting.Phoenix.Center:Clone()
		center.Name = "Center"
		center.Parent = torso.Parent
		center.CFrame = torso.CFrame * CFrame.new(0, 0, 1.5) * CFrame.Angles(-1.5, 0, 0)
		
		weld = Instance.new("Weld")
		weld.Part0 = torso
		weld.C0 = torso.CFrame:inverse()
		weld.Part1 = center
		weld.C1 = center.CFrame:inverse()
		weld.Parent = torso
		center.Anchored = false
		
		
		rightwing = game.Lighting.Phoenix.RightWing:Clone()
		rightwing.Name = "RightWing"
		rightwing.Parent = torso.Parent
		rightwing.CFrame = torso.CFrame * CFrame.new(3.5, 0, -1.5) * CFrame.Angles(-1.5, 0, 0)
		
		weld2 = Instance.new("Weld")
		weld2.Part0 = torso
		weld2.C0 = torso.CFrame:inverse()
		weld2.Part1 = rightwing
		weld2.C1 = rightwing.CFrame:inverse()
		weld2.Parent = torso
		rightwing.Anchored = false
		
		
		leftwing = game.Lighting.Phoenix.LeftWing:Clone()
		leftwing.Name = "LeftWing"
		leftwing.Parent = torso.Parent
		leftwing.CFrame = torso.CFrame * CFrame.new(-3.5, 0, -2) * CFrame.Angles(-1.5, 0, 0)
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = torso
		weld3.C0 = torso.CFrame:inverse()
		weld3.Part1 = leftwing
		weld3.C1 = leftwing.CFrame:inverse()
		weld3.Parent = torso
		leftwing.Anchored = false
		
	else if (string.lower(key) == "z" and running) then
		
		script.Parent.FlyUp:remove()
		
		script.Parent.FlyDown:remove()
		
		script.Parent.Regen:remove()
		
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
		
		script.Parent.Parent.Character.Center:remove()
		script.Parent.Parent.Character.RightWing:remove()
		script.Parent.Parent.Character.LeftWing:remove()
		
		script.Parent.Parent.Character.Torso.Flying:remove()
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
		d[i].Handle.Transparency = 0
		end
		end
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 16
		
		script.Parent.Parent.Character.Head.face.Texture = face
		
		script.Parent.Parent.Character.Humanoid.MaxHealth = script.Parent.Parent.Character.Humanoid.MaxHealth - 50
		
		running = false
		
		script.Disabled = true
		
		wait(25)
		
		script.Disabled = false
		
	end end
end)