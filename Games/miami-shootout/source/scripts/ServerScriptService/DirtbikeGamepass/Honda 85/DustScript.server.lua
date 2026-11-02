WheelModel = script.Parent:WaitForChild("RearSection")
dustEffect = script:WaitForChild("DustEffect")
wheels = {}
touchingparts = {}

for i, v in pairs(WheelModel:GetChildren()) do
	if v:IsA("BasePart") then
		table.insert(wheels, v)
		dustEffect:Clone().Parent = v
		table.insert(touchingparts, nil)
	end
end
for i, v in pairs(wheels) do
	v.Touched:connect(function(part)
		touchingparts[i] = part
	end)
end
RunService = game:GetService("RunService")

RunService.Heartbeat:connect(function()
	for i, v in pairs(wheels) do
		local speed = v.Velocity.magnitude
		if speed > 20 then
			if touchingparts[i].Material == Enum.Material.Grass or touchingparts[i].Material == Enum.Material.Pebble or touchingparts[i].Material == Enum.Material.Sand or touchingparts[i].Material == Enum.Material.Slate or touchingparts[i].Material == Enum.Material.Ground or touchingparts[i].Material == Enum.Material.Mud or touchingparts[i].Material == Enum.Material.LeafyGrass or touchingparts[i].Material == Enum.Material.Basalt or touchingparts[i].Material == Enum.Material.Rock or touchingparts[i].Material == Enum.Material.CrackedLava then
				v.DustEffect.Rate = 5/100 * speed * 30
			else
				v.DustEffect.Rate = 0
			end
		else
			v.DustEffect.Rate = 0
		end
	end
end)