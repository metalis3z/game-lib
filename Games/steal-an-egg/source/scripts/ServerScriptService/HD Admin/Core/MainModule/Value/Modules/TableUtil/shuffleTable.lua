return function(tableToShuffle)
	assert(type(tableToShuffle) == "table", "First argument must be a table")
	local swapIndex, temp
	for index = #tableToShuffle, 1, -1 do
		swapIndex = math.random(index)
		temp = tableToShuffle[index]
		tableToShuffle[index] = tableToShuffle[swapIndex]
		tableToShuffle[swapIndex] = temp
	end
	return tableToShuffle
end
