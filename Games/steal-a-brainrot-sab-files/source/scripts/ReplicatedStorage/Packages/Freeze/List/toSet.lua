

return function(t1: {[any]: any})
	local t2 = {}

	for _, v4 in t1 do
		t2[v4] = true
	end

	return t2
end
