

local function joinAsString(t1: {[any]: any}, s1: string?)
	return table.concat(t1, s1 or ",")
end

return joinAsString
