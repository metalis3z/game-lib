player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")
rightarm = script.Parent.Parent.Character["Right Arm"]

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		part = script.Scalpel:Clone()
		part.CFrame = script.Parent.Parent.Character["Right Arm"].CFrame
		part.Parent = game.Workspace
		wpart = Instance.new("Weld", part)
		wpart.Part0 = script.Parent.Parent.Character["Right Arm"]
		wpart.Part1 = part
		wpart.C1 = CFrame.fromEulerAnglesXYZ(1.5, 0, 1) *CFrame.new(0, 1, 0.64)
		
		game.Debris:AddItem(part, 5)
		
		x = Instance.new("Part")
		x.Size = Vector3.new(20, 20, 20)
		x.BrickColor = BrickColor.new("Cyan")
		x.Parent = game.Workspace
		x.CanCollide = false
		x.Anchored = true
		x.Transparency = 0.6
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -1.2)
		
		touch = script.Touch:Clone()
		touch.Parent = x

		fd = script.Firedamage:Clone()
		fd.Parent = x
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		
		touch.Disabled = false
		fd.Disabled = false
		
		for i = 1, 1000 do
			x.CFrame = script.Parent.Parent.Character.Torso.CFrame
			wait(0.01)
		end
				
		x:remove()
	end
		
		wait(25)
		script.Disabled = false
end)

