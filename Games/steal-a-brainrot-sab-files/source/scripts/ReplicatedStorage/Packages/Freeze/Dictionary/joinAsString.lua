

local function joinAsString(t1: {[any]: any}, s1: string?)
	local t2 = {}

	for v5, v6 in t1 do
		table.insert(t2, string.format("%s=%s", tostring(v5), (tostring(v6))))
	end

	return table.concat(t2, s1 or ",")
end

return joinAsString
