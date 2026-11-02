color = script.Parent.Parent.Parent.Parent.Name
for i,v in pairs(script.Parent:GetChildren())do 
	if v.ClassName == "Part" then
		if v.BrickColor == BrickColor.new("Earth green") then
			v.BrickColor= BrickColor.new(color)
		end
	end
end