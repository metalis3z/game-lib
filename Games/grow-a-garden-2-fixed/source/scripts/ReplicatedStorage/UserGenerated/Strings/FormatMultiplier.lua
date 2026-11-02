--credit to leon games studio
return function(p1, p2) --[[ FormatMultiplier | Line: 20 ]]
	assert(if type(p1) == "number" then true else false)
	assert(if p2 == nil then true elseif type(p2) == "number" and p2 >= 0 then if math.floor(p2) == p2 then true else false else false)

	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v3 = p2 or 2

	if v3 > 0 then
		return string.format(("%%0.%*f"):format(v3), p1):gsub("(%d)%.?0+$", "%1")
	end

	return tostring((math.round(p1)))
end