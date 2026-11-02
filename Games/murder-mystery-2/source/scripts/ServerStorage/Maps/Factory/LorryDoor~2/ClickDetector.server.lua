local Door = script.Parent.Door
local ClickDetector = script.Parent.Button.ClickDetector

ClickDetector.MouseClick:Connect(function()
	for i,v in pairs(Door:GetDescendants()) do
		if v:IsA('BasePart') then
			if v.Transparency == 0 then
				v.Transparency = 1
				v.CanCollide = false
			else
				if v.Transparency == 1 then
					v.Transparency = 0
					v.CanCollide = true
				end
			end
		end
	end
end)