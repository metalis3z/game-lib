

return function(t1: {[any]: any}, p1, p2)
	if t1[p1] == nil then
		return p2
	end

	return t1[p1]
end
