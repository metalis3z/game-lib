--credit to prince games studio
function DeepCopyWithMetatables(p1, p2) --[[ DeepCopyWithMetatables | Line: 33 ]]
	if type(p1) ~= "table" then
		return p1
	end

	local v1 = if p2 then p2 else {}
	local v2 = v1[p1]

	if v2 then
		return v2
	end

	local t = {}

	v1[p1] = t

	for v3, v4 in next, p1 do
		t[DeepCopyWithMetatables(v3, v1)] = DeepCopyWithMetatables(v4, v1)
	end

	local v5 = getmetatable(p1)

	if v5 then
		setmetatable(t, v5)
	end

	return t
end

return DeepCopyWithMetatables