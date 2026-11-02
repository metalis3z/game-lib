

local v1 = game:GetService("RunService")
local u2 = script.Parent
local u3 = 0
v1.RenderStepped:Connect(function(p4)

	u3 = u3 + 20 * p4
	u2.Rotation = u3 % 360
end)