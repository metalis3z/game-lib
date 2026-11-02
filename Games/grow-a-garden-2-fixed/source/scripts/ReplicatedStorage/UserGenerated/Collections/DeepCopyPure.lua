--credit to leon games studio
function DeepCopyPure(p1, p2) --[[ DeepCopyPure | Line: 31 ]]
	if type(p1) ~= "table" then
		return p1
	end

	assert(not getmetatable(p1))

	local v2 = if p2 then p2 else {}

	assert(not v2[p1])
	v2[p1] = true

	local t = {}

	for v4, v5 in next, p1 do
		t[DeepCopyPure(v4, v2)] = DeepCopyPure(v5, v2)
	end

	v2[p1] = nil

	return t
end

return DeepCopyPure