

local function v1(p1, p2)
	return p2 < p1
end

return function(t1: {[any]: any}, p3: ((...any) -> ...any)?)
	local v6 = if p3 ~= nil then p3 else v1
	local v7 = nil
	local v8 = nil

	for v9, v10 in t1 do
		if v8 == nil or v6(v8, v10) == true then
			v7 = v9
			v8 = v10
		end
	end

	return v8, v7
end
