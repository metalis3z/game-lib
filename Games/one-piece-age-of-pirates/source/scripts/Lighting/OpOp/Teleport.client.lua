player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.Size = Vector3.new(150, 88, 150)
		x.BrickColor = BrickColor.new("Cyan")
		x.Parent = game.Workspace
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(0, 0, -70)
		x.CanCollide = false
		x.Anchored = true
		x.Transparency = 0.6
		spin = script.Spin:Clone()
		spin.Parent = x
		z = Instance.new("SpecialMesh")
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=90782182"
		z.Scale = Vector3.new(0, 0, 0)
		z.Parent = x
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		y.Parent = x
		
		for i = 1, 5 do
			z.Scale = z.Scale + Vector3.new(3, 3, 3)
			x.CFrame = x.CFrame * CFrame.new(0, 4.5, 0)
			wait(0.01)
		end
		wait(0.5)
		script.Parent.Parent.Character.HumanoidRootPart.CFrame = script.Parent.Parent.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -140)
		
		game.Debris:AddItem(x, 2)
		
end
		
		wait(20)
		script.Disabled = false
end)

