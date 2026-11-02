player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "v") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Pastel brown")
		x.Size = Vector3.new(40, 40, 40)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Shape = "Block"
		x.Name = "Gravity"
		x.CanCollide = false
		x.Anchored = false
		p = script.PointLight:clone()
		p.Parent = x
		x.Transparency = 1
		x.Reflectance = 0
		fd = script.Firedamage:clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(1, 1, 1)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 0, 0)
		fd.Disabled = false
		
		for i = 1, 500 do
			x.CFrame = script.Parent.Parent.Character.Torso.CFrame
			wait(0.01)
		end
		game.Debris:AddItem(x, 2)
	end
		
		wait(16)
		script.Disabled = false
end)

