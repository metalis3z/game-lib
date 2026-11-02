--credit to prince games studio
local t = { 0, 2, 2, 2 }

return function(p1) --[[ FormatDuration | Line: 22 | Upvalues: t (copy) ]]
	assert(type(p1) == "number")

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 ~= p1 then
		return "NaN"
	end

	local v3 = math.ceil((math.max(0, p1)))
	local v4 = v3 % 60
	local v5 = v3 // 60
	local v7 = v5 // 60
	local list = {
		v7 // 24,
		v7 % 24,
		v5 % 60,
		v4
	}
	local v8 = #list

	for i, v in ipairs(list) do
		if v > 0 then
			v8 = i

			break
		end
	end

	if v8 == #list then
		return tostring(v4) .. "s"
	end

	local t2 = {}

	t2[1] = tostring(list[v8])

	for i = v8 + 1, #list do
		local v11 = tostring(list[i])

		while #v11 < t[i] do
			v11 = "0" .. v11
		end

		table.insert(t2, ":" .. v11)
	end

	return table.concat(t2)
end