-- https://lua.expert/
local v1 = script.Parent
local Off = v1:WaitForChild("Off")
local On = v1:WaitForChild("On")

v1.MouseButton1Click:Connect(function() --[[ Line: 6 | Upvalues: Off (copy), On (copy) ]]
	if Off.Visible then
		Off.Visible = false
		On.Visible = true
	else
		Off.Visible = true
		On.Visible = false
	end
end)