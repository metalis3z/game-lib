

return function(p1, p2: ((...any) -> ...any))
	local n1 = 0

	for v4, v5 in p1 do
		n1 += 1

		if p2(v5, v4) == false then
			return n1
		end
	end

	return n1
end
