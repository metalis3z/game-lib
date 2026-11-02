return function(tbl)
	local count = 0
	for _, _ in tbl do
		count += 1
	end
	return count
end