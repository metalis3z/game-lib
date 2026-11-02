return function(sourceTable)
	local tCopy = table.create(#sourceTable)
	for key, value in (sourceTable) do tCopy[key] = value end
	return tCopy
end