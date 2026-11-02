local TweenService = game:GetService("TweenService")
local info = TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
for _, inst in ipairs(script.Parent:GetDescendants()) do
	if inst:IsA("PointLight") then
		TweenService:Create(inst, info, {Brightness = 3.2}):Play()
	elseif inst:IsA("BasePart") and inst.Name == "Lava" then
		local c = inst.Color
		TweenService:Create(inst, info, {Color = Color3.new(c.R, math.min(c.G + 0.15, 1), c.B)}):Play()
	end
end
