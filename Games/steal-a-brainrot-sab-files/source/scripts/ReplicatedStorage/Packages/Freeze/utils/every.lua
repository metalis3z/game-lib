

return function(p1, p2)
	for v3, v4 in p1 do
		if p2(v4, v3) == false then
			return false
		end
	end

	return true
end
