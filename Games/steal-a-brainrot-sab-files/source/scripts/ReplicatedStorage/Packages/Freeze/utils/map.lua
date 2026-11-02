

return function(t1: {[any]: any}, p1: ((...any) -> ...any))
	local t2 = {}

	for v4, v5 in t1 do
		local v6, v7 = p1(v5, v4)
		local v8 = if v7 ~= nil then v7 else v4

		if v6 ~= nil then
			t2[v8] = v6
		end
	end

	return t2
end
