

return function(p1, p2, p3)
	if p3 == p1[p2] then
		return p1
	end

	local v4 = table.clone(p1)

	v4[p2] = p3

	return v4
end
