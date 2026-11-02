--credit to prince games studio
return function(p1) --[[ Keys | Line: 20 ]]
	local t = {}

	for k, v in pairs(p1) do
		table.insert(t, k)
	end

	return t
end