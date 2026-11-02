col = script.Parent.Parent.Parent.Name

for i,v in pairs(script.Parent:GetChildren()) do
	if v.ClassName == "Part" then
		v.BrickColor = BrickColor.new(col)
	end
end