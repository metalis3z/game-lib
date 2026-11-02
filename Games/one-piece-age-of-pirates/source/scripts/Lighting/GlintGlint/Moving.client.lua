player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.Parent = game.Workspace
		x.BrickColor = BrickColor.new("Bright yellow")
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Transparency = 0.5
		x.Size = Vector3.new(15, 15, 15)
		x.CanCollide = false
		x.Anchored = true
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame
		
		x2 = Instance.new("Part")
		x2.Parent = game.Workspace
		x2.BrickColor = BrickColor.new("Bright yellow")
		x2.TopSurface = "Smooth"
		x2.BottomSurface = "Smooth"
		x2.Transparency = 1
		x2.Size = Vector3.new(10, 10, 10)
		x2.CanCollide = false
		x2.Anchored = false
		x2.CFrame = script.Parent.Parent.Character.Torso.CFrame
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 293
		y.Parent = x2
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
		d[i].Handle.Transparency = 1
		end
		end
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 0
		
		face = script.Parent.Parent.Character.Head.face.Texture
		
		script.Parent.Parent.Character.Head.face.Texture = ""
		
		
		script.Parent.Parent.Character.Head.Transparency = 1
		script.Parent.Parent.Character.Torso.Transparency = 1
		script.Parent.Parent.Character["Left Arm"].Transparency = 1
		script.Parent.Parent.Character["Right Arm"].Transparency = 1
		script.Parent.Parent.Character["Left Leg"].Transparency = 1
		script.Parent.Parent.Character["Right Leg"].Transparency = 1
		
		for i = 1, 20 do
			x.Size = x.Size + Vector3.new(0, 0, 10)
			x.CFrame = x.CFrame * CFrame.new(0, 0, -5)
			script.Parent.Parent.Character.Torso.CFrame = x2.CFrame
			wait()
		end
		
		script.Parent.Parent.Character.Head.face.Texture = face
		
		
		script.Parent.Parent.Character.Head.Transparency = 0
		script.Parent.Parent.Character.Torso.Transparency = 0
		script.Parent.Parent.Character["Left Arm"].Transparency = 0
		script.Parent.Parent.Character["Right Arm"].Transparency = 0
		script.Parent.Parent.Character["Left Leg"].Transparency = 0
		script.Parent.Parent.Character["Right Leg"].Transparency = 0
		
		script.Parent.Parent.Character.Head.face.Transparency = 0
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
		d[i].Handle.Transparency = 0
		end
		end
		
		x.Anchored = true
		x2.Anchored = true
		
		script.Parent.Parent.Character.Humanoid.WalkSpeed = 16
		
		wait(1)
		
		x:remove()
		x2:remove()
		
		wait(7)
		
		script.Disabled = false
	end
end)