--credit to quartz games studio
function DeepEqualsPureUnsafe(p1, p2) --[[ DeepEqualsPureUnsafe | Line: 33 ]]
	if rawequal(p1, p2) then
		return true
	end

	if type(p1) == "table" and type(p2) == "table" then
		if rawlen(p1) ~= rawlen(p2) then
			return false
		end

		if getmetatable(p1) ~= getmetatable(p2) then
			return false
		end

		for v1, v2 in next, p1 do
			local v3 = rawget(p2, v1)

			if v3 == nil or not DeepEqualsPureUnsafe(v2, v3) then
				return false
			end
		end

		for v4, v5 in next, p2 do
			if rawget(p1, v4) == nil then
				return false
			end
		end

		return true
	end

	return p1 ~= p1 and p2 ~= p2
end

return DeepEqualsPureUnsafe