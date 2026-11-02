local rs = game:GetService("RunService")

rs.RenderStepped:Connect(function(dt)
	local fpsEven = dt * 60
	script.Parent.OffsetStudsU += 0.01 * fpsEven
	script.Parent.OffsetStudsV += 0.01 * fpsEven
end)