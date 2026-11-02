--credit to quartz games studio
return function(p1, p2) --[[ CompareBuffer | Line: 20 ]]
	local v1 = buffer.len(p1)
	local v2 = buffer.len(p2)

	for i = 0, math.min(v1, v2) - 1 do
		local v3 = buffer.readu8(p1, i)
		local v4 = buffer.readu8(p2, i)

		if v3 ~= v4 then
			return v3 - v4
		end
	end

	return v1 - v2
end