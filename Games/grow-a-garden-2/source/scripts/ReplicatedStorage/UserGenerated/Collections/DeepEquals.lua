--credit to prince games studio
local function v1(p1, p2, p3) --[[ DeepEquals | Line: 31 | Upvalues: v1 (copy) ]]
	if rawequal(p1, p2) then
		return true
	end

	if type(p1) == "table" and type(p2) == "table" then
		if rawlen(p1) ~= rawlen(p2) then
			return false
		end

		local v12 = getmetatable(p1)

		if v12 ~= getmetatable(p2) then
			return false
		end

		if v12 == nil or not v12.__eq then
			local v2 = if p3 then p3 else {}

			v2[p1] = v2[p1] or {}
			v2[p2] = v2[p2] or {}

			if v2[p1][p2] then
				return true
			end

			v2[p1][p2] = true
			v2[p2][p1] = true

			for v5, v6 in next, p1 do
				local v7 = rawget(p2, v5)

				if v7 == nil or not v1(v6, v7, v2) then
					return false
				end
			end

			for v8, v9 in next, p2 do
				if rawget(p1, v8) == nil then
					return false
				end
			end

			return true
		end

		return p1 == p2
	end

	return p1 ~= p1 and p2 ~= p2
end

return v1