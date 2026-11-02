--credit to leon games studio
function DeepFreeze(p1, p2) --[[ DeepFreeze | Line: 32 ]]
	if type(p1) ~= "table" then
		return p1
	end

	if not table.isfrozen(p1) then
		table.freeze(p1)
	end

	local v1 = if p2 then p2 else {}

	if not v1[p1] then
		v1[p1] = true

		for v2, v3 in next, p1 do
			DeepFreeze(v2, v1)
			DeepFreeze(v3, v1)
		end

		v1[p1] = nil
	end

	return p1
end

return DeepFreeze