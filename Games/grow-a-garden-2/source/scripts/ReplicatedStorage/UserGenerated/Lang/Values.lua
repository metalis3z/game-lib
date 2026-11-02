--credit to leon games studio
return function(p1) --[[ Values | Line: 20 ]]
	local t = {}

	for k, v in pairs(p1) do
		table.insert(t, v)
	end

	return t
end