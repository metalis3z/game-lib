player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "c") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Royal purple")
		x.Size = Vector3.new(130, 130, 130)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Shape = "Block"
		x.Name = "Gravity"
		x.CanCollide = false
		x.Anchored = false
		x.Transparency = 0.5
		x.Reflectance = 0
		fd = script.Firedamage:clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "FileMesh"
		z.MeshId = "http://www.roblox.com/asset/?id=1095708"
		z.Scale  = Vector3.new(0, 0, 0)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 0, 0)
		fd.Disabled = false
  		game.Debris:AddItem(x, 5)
		for i = 1, 100 do
			z.Scale = z.Scale + Vector3.new(1.2, 1.2, 1.6)
			x.Transparency = x.Transparency + 0.005
			wait(0.01)
		end
		
	end
		
		wait(20)
		script.Disabled = false
end)

