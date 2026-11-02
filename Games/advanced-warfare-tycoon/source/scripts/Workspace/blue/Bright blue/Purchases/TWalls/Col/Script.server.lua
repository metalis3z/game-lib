wait(.1)
col = script.Parent.Parent.Parent.Parent

for i,v in pairs(script.Parent:GetChildren()) do 
	if v.ClassName == "Part" then
		v.BrickColor = BrickColor.new(col.Name)
	end
end