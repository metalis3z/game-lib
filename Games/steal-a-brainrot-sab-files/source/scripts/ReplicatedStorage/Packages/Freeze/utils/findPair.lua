

return function(t1: {[any]: any}, p1: ((...any) -> ...any))
	for v3, v4 in t1 do
		if p1(v4, v3) == true then
			return v3, v4
		end
	end

	return nil
end
