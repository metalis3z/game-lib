--credit to quartz games studio
return function(p1, p2) --[[ Line: 1 ]]
	local v1 = p2.CFrame:PointToObjectSpace(p1.Position)

	p2.CFrame:PointToObjectSpace(v1)

	if math.abs(v1.X) > p2.Size.X / 2 then
		return false
	end

	if math.abs(v1.Z) > p2.Size.Z / 2 then
		return false
	end

	return not (math.abs(v1.Y) > p2.Size.Y / 2)
end