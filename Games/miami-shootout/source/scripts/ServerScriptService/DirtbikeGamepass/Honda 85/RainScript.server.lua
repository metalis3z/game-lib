WheelModel = script.Parent:WaitForChild("RearSection")
RainEffect = script:WaitForChild("RainEffect")
wheels = {}
touchingparts = {}

for i, v in pairs(WheelModel:GetChildren()) do
	if v:IsA("BasePart") then
		table.insert(wheels, v)
		RainEffect:Clone().Parent = v
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
			if touchingparts[i].Material == Enum.Material.Glass or touchingparts[i].Material == Enum.Material.Ice then
				v.RainEffect.Rate = 26/100 * speed * 20.5
			else
				v.RainEffect.Rate = 0
			end
		else
			v.RainEffect.Rate = 0
		end
	end
end)