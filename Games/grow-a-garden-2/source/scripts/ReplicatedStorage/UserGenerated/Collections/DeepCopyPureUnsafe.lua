--credit to quartz games studio
function DeepCopyPureUnsafe(p1) --[[ DeepCopyPureUnsafe | Line: 31 ]]
	if type(p1) ~= "table" then
		return p1
	end

	local t = {}

	for v1, v2 in next, p1 do
		t[DeepCopyPureUnsafe(v1)] = DeepCopyPureUnsafe(v2)
	end

	return t
end

return DeepCopyPureUnsafe