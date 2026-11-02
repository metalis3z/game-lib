--credit to quartz games studio
return table.freeze({
	QueryObject = function(p1, p2, p3) --[[ QueryObject | Line: 29 ]]
		for i, v in ipairs(string.split(p2, ".")) do
			if p1 == nil then
				return false
			end

			if p1 == p3 then
				return true
			end

			if type(p1) ~= "table" then
				return false
			end

			p1 = p1[v]
		end

		if p1 == nil then
			return false
		end

		if p1 == p3 then
			return true
		end

		return true, p1
	end,
	HasHierarchicalOverlap = function(p1, p2) --[[ HasHierarchicalOverlap | Line: 51 ]]
		if p1 == p2 then
			return true
		end

		local v1 = string.split(p1, ".")
		local v2 = string.split(p2, ".")

		for i = 1, math.min(#v1, #v2) do
			if v1[i] ~= v2[i] then
				return false
			end
		end

		return true
	end
})