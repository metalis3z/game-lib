_G.redpoints = 0
while true do
	wait(3)
	if script.Parent.Value == 20 then
		_G.redpoints = _G.redpoints+1
		for i,v in pairs(script.Parent.Parent:GetChildren()) do
			if v.Name == "ColorPart" then
				v.BrickColor = BrickColor.new(script.Parent.Name)
			end
		end
	end
end