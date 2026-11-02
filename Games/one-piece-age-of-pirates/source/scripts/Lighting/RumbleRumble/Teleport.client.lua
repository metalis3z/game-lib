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
		x.BrickColor = BrickColor.new("Cyan")
		x.Transparency = 1
		x.Size = Vector3.new(6, 8, 6)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "FileMesh"
		z.MeshId = "Brick"
		z.Scale = Vector3.new(1, 1, 1)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 0
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame
		
		fire = script.Fire:clone()
		fire.Parent = script.Parent.Parent.Character.Torso
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
			d[i].Handle.Transparency = 1
			end
		end
		
		for i = 1, 20 do
			script.Parent.Parent.Character.Head.Transparency = script.Parent.Parent.Character.Head.Transparency + 0.05
			script.Parent.Parent.Character.Torso.Transparency = script.Parent.Parent.Character.Head.Transparency + 0.05
			script.Parent.Parent.Character["Left Arm"].Transparency = script.Parent.Parent.Character["Left Arm"].Transparency + 0.05
			script.Parent.Parent.Character["Right Arm"].Transparency = script.Parent.Parent.Character["Right Arm"].Transparency + 0.05
			script.Parent.Parent.Character["Left Leg"].Transparency = script.Parent.Parent.Character["Left Leg"].Transparency + 0.05
			script.Parent.Parent.Character["Right Leg"].Transparency = script.Parent.Parent.Character["Right Leg"].Transparency + 0.05
			wait()
		end
		
  		game.Debris:AddItem(x, 3)

		wait(1)
		
		script.Parent.Parent.Character.HumanoidRootPart.CFrame = script.Parent.Parent.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -150)
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame
		
		wait(1)
		
		for i = 1, 20 do
			script.Parent.Parent.Character.Head.Transparency = script.Parent.Parent.Character.Head.Transparency - 0.05
			script.Parent.Parent.Character.Torso.Transparency = script.Parent.Parent.Character.Head.Transparency - 0.05
			script.Parent.Parent.Character["Left Arm"].Transparency = script.Parent.Parent.Character["Left Arm"].Transparency - 0.05
			script.Parent.Parent.Character["Right Arm"].Transparency = script.Parent.Parent.Character["Right Arm"].Transparency - 0.05
			script.Parent.Parent.Character["Left Leg"].Transparency = script.Parent.Parent.Character["Left Leg"].Transparency - 0.05
			script.Parent.Parent.Character["Right Leg"].Transparency = script.Parent.Parent.Character["Right Leg"].Transparency - 0.05
			wait()
		end
		
		local d = script.Parent.Parent.Character:GetChildren() 
		for i=1, #d do 
		if (d[i].className == "Hat") then 
			d[i].Handle.Transparency = 0
			end
		end
		
		fire:remove()

		
		wait(20)
		script.Disabled = false
	end
end)