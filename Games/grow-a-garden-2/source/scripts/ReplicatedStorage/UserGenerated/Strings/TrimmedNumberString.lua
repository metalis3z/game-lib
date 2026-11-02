--credit to quartz games studio
return function(p1) --[[ TrimmedNumberString | Line: 20 ]]
	assert(type(p1) == "number")

	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v3, v4 = string.match(string.format("%f", p1), "^([^%.]*)%.?(.*)$")

	assert(v3)

	if not v4 then
		return v3
	end

	local v5 = string.gsub(v4, "0+$", "")

	if #v5 == 0 then
		return v3
	end

	return ("%*.%*"):format(v3, v5)
end