for i,v in pairs(script.Parent:GetChildren()) do
	if v.Name == "Part" then
		v.BrickColor = BrickColor.new(script.Parent.Parent.Parent.Parent.Parent.Parent.Name)
	end
end