local function deepCopyTable(original): {any}
	assert(type(original) == "table", "First argument must be a table")
	local tCopy = table.create(#original)
	for key, value in (original) do
		if (type(value) == "table") then
			tCopy[key] = deepCopyTable(value)
		else
			tCopy[key] = value
		end
	end
	return tCopy :: {any}
end
return deepCopyTable