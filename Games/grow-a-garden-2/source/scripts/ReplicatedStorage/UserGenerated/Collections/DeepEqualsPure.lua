--credit to quartz games studio
function DeepEqualsPure(p1, p2, p3) --[[ DeepEqualsPure | Line: 33 ]]
	if type(p1) == "table" and type(p2) == "table" then
		local v1 = if p3 then p3 else {}

		if v1[p1] or v1[p2] then
			return false
		end

		if rawequal(p1, p2) then
			return true
		end

		if rawlen(p1) ~= rawlen(p2) then
			return false
		end

		if getmetatable(p1) ~= getmetatable(p2) then
			return false
		end

		v1[p1] = true
		v1[p2] = true

		for v2, v3 in next, p1 do
			local v4 = rawget(p2, v2)

			if v4 == nil or not DeepEqualsPure(v3, v4, v1) then
				return false
			end
		end

		for v5, v6 in next, p2 do
			if rawget(p1, v5) == nil then
				return false
			end
		end

		v1[p1] = nil
		v1[p2] = nil

		return true
	end

	if rawequal(p1, p2) then
		return true
	end

	return p1 ~= p1 and p2 ~= p2
end

return DeepEqualsPure