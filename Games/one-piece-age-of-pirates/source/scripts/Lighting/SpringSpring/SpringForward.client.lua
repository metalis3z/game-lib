player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
rightarm = script.Parent.Parent.Character["Right Arm"]
leftarm = script.Parent.Parent.Character["Left Arm"]
rightleg = script.Parent.Parent.Character["Right Leg"]
leftleg = script.Parent.Parent.Character["Left Leg"]
torso = script.Parent.Parent.Character.Torso

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		damagepart = Instance.new("Part")
		damagepart.Transparency = 1
		damagepart.Parent = game.Workspace
		damagepart.Size = Vector3.new(20, 20, 20)
		damagepart.CFrame = torso.CFrame
		damagepart.Anchored = false
		damagepart.CanCollide = false
		
		o = Instance.new("StringValue",damagepart)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		fd = script.Firedamage:Clone()
		fd.Parent = damagepart
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = torso
		weld3.C0 = torso.CFrame:inverse()
		weld3.Part1 = damagepart
		weld3.C1 = damagepart.CFrame:inverse()
		weld3.Parent = torso
		
		torso.Anchored = true
		
		otherrightarm = Instance.new("Part")
		otherrightarm.Transparency = 1
		otherrightarm.FormFactor = "Custom"
		otherrightarm.Size = Vector3.new(1, 2, 2)
		otherrightarm.BrickColor = BrickColor.new("Medium stone grey")
		otherrightarm.TopSurface = "Smooth"
		otherrightarm.BottomSurface = "Smooth"
		otherrightarm.Name = "MainPart"
		otherrightarm.Parent = torso.Parent
		otherrightarm.CFrame = torso.CFrame
		otherrightarm.CanCollide = false
		otherrightarm.Anchored = true
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = torso
		weld3.C0 = torso.CFrame:inverse()
		weld3.Part1 = otherrightarm
		weld3.C1 = otherrightarm.CFrame:inverse()
		weld3.Parent = torso
		otherrightarm.Anchored = false
		
		rightleg.Transparency = 1
		
		otherrightleg = Instance.new("Part")
		otherrightleg.FormFactor = "Custom"
		otherrightleg.Size = Vector3.new(1, 2, 2)
		otherrightleg.BrickColor = BrickColor.new("Medium stone grey")
		otherrightleg.TopSurface = "Smooth"
		otherrightleg.BottomSurface = "Smooth"
		otherrightleg.Name = "RightLeg1"
		otherrightleg.Parent = rightleg.Parent
		otherrightleg.CFrame = rightleg.CFrame * CFrame.Angles(1.5, 0, 0)
		otherrightleg.CanCollide = false
		otherrightleg.Anchored = true
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = rightleg
		weld3.C0 = rightleg.CFrame:inverse()
		weld3.Part1 = otherrightleg
		weld3.C1 = otherrightleg.CFrame:inverse()
		weld3.Parent = rightleg
		otherrightleg.Anchored = false
		
		z = Instance.new("SpecialMesh")
		z.Parent = otherrightleg
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=16606212"
		z.Scale = Vector3.new(0.6, 0.6, 0.6)
		
		leftleg.Transparency = 1
	
		otherleftleg = Instance.new("Part")
		otherleftleg.FormFactor = "Custom"
		otherleftleg.Size = Vector3.new(1, 2, 2)
		otherleftleg.BrickColor = BrickColor.new("Medium stone grey")
		otherleftleg.TopSurface = "Smooth"
		otherleftleg.BottomSurface = "Smooth"
		otherleftleg.Name = "LeftLeg1"
		otherleftleg.Parent = leftleg.Parent
		otherleftleg.CFrame = leftleg.CFrame * CFrame.Angles(1.5, 0, 0)
		otherleftleg.CanCollide = false
		otherleftleg.Anchored = true
		
		weld3 = Instance.new("Weld")
		weld3.Part0 = leftleg
		weld3.C0 = leftleg.CFrame:inverse()
		weld3.Part1 = otherleftleg
		weld3.C1 = otherleftleg.CFrame:inverse()
		weld3.Parent = leftleg
		otherleftleg.Anchored = false
		
		z2 = Instance.new("SpecialMesh")
		z2.Parent = otherleftleg
		z2.MeshType = "FileMesh"
		z2.MeshId = "http://www.roblox.com/asset/?id=16606212"
		z2.Scale = Vector3.new(0.6, 0.6, 0.6)
		
		for i = 1, 3 do
			game.Players.LocalPlayer.Character.Torso.CFrame = game.Players.LocalPlayer.Character.Torso.CFrame * CFrame.new(0, 1, 0)
			damagepart.CFrame = torso.CFrame
			wait()
		end
		
		fd.Disabled = false
		
		game.Players.LocalPlayer.Character:GetPrimaryPartCFrame("MainPart")
		
		game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(torso.CFrame * CFrame.Angles(-1.589, 0, 0))
		
		for i = 1, 50 do
			game.Players.LocalPlayer.Character.Torso.CFrame = game.Players.LocalPlayer.Character.Torso.CFrame * CFrame.new(0, 5, 0)
			damagepart.CFrame = torso.CFrame
			wait()
		end
		
		game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(torso.CFrame * CFrame.Angles(0, 0, 0))
		
		otherrightarm:remove()
		otherleftleg:remove()
		otherrightleg:remove()
		damagepart:remove()
		
		rightleg.Transparency = 0
		leftleg.Transparency = 0
		
		torso.Anchored = false
		
		wait(18)
		script.Disabled = false
	end
end)